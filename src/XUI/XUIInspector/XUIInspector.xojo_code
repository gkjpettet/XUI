#tag Class
Protected Class XUIInspector
Inherits NSScrollViewCanvas
	#tag Event
		Function DoCommand(command As String) As Boolean
		  /// A key command has occurred.
		  
		  If command = CmdInsertTab Then
		    MoveFocusToNextItem
		    
		  ElseIf command = CmdInsertBacktab Then
		    MoveFocusToPreviousItem
		    
		  Else
		    // Delegate to the item currently in focus.
		    If ItemWithFocus <> Nil And ItemWithFocus IsA XUIInspectorItemKeyHandler Then
		      XUIInspectorItemKeyHandler(ItemWithFocus).DoCommand(command)
		    End If
		  End If
		  
		  // Tell the Xojo framework that we've handled the key.
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub FocusLost()
		  /// Dismiss any popups.
		  If mPopup <> Nil Then
		    mPopup.Owner.PopupDismissed
		    mPopup = Nil
		  End If
		  
		  RedrawImmediately
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub InsertText(text As String, range As TextRange)
		  /// The user is attempting to enter a single character.
		  
		  // Delegate to the item currently in focus.
		  If ItemWithFocus <> Nil And ItemWithFocus IsA XUIInspectorItemKeyHandler Then
		    XUIInspectorItemKeyHandler(ItemWithFocus).InsertCharacter(text, range)
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function IsEditable() As Boolean
		  /// Returns False if the canvas is read-only or True if it's editable.
		  
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  // Give the canvas the focus.
		  Me.SetFocus
		  
		  // Cache the x, y coords that this mouse down event occurs at.
		  mLastMouseDownX = x
		  mLastMouseDownY = y
		  
		  // Right click?
		  mLastClickWasContextual = IsContextualClick
		  
		  // Adjust for vertical scrolling.
		  y = y + mScrollOffsetY
		  
		  // If there is a popup menu open, did the user click it?
		  If mPopup <> Nil Then
		    If mPopup.Bounds.Contains(x, y) Then
		      HandlePopupMenuClick(x, y)
		      
		      Return True
		    Else
		      // Since the user clicked somewhere other than the popup, close it.
		      mPopup.Owner.PopupDismissed
		      mPopup = Nil
		      RedrawImmediately
		      Return True
		    End If
		  End If
		  
		  // Get the section clicked in.
		  Var data As XUIInspectorMouseDownData
		  For Each section As XUIInspectorSection In mSections
		    If section.Bounds <> Nil And section.Bounds.Contains(x, y) Then
		      data = section.MouseDown(x, y, mLastClickType)
		      If data = Nil Then
		        // The click did not occur in this section.
		        Continue
		      End If
		      
		      If data.PopupMenu <> Nil Then
		        HandleNewPopupMenu(data.PopupMenu)
		        Return True
		      End If
		      
		      Exit
		    End If
		  Next section
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  RedrawImmediately
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(x As Integer, y As Integer)
		  /// Find the item the mouse is over and tell it the mouse has moved.
		  
		  // Adjust for vertical scrolling.
		  y = y + mScrollOffsetY
		  
		  Var shouldRedraw As Boolean = False
		  
		  // Tell the item last moved over that the mouse has exited.
		  If mLastMovedItem <> Nil Then
		    shouldRedraw = mLastMovedItem.MouseExit
		  End If
		  
		  For Each section As XUIInspectorSection In mSections
		    If section.Bounds.Contains(x, y) Then
		      Var data As XUIInspectorMouseMoveData = section.MouseMoved(x, y)
		      If data <> Nil Then
		        // Store the item moved over.
		        mLastMovedItem = data.Owner
		        If data.VisualChange Then
		          shouldRedraw = True
		        End If
		        Exit
		      End If
		    End If
		  Next section
		  
		  If shouldRedraw Then RedrawImmediately
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  // Adjust for vertical scrolling.
		  y = y + mScrollOffsetY
		  
		  // Determine click type.
		  If mLastClickWasContextual Then
		    mLastClickType = XUI.ClickTypes.ContextualClick
		  ElseIf IsTripleClick(x,y) Then
		    mLastClickType = XUI.ClickTypes.TripleClick
		  ElseIf IsDoubleClick(x,y) Then
		    mLastClickType = XUI.ClickTypes.DoubleClick
		  Else
		    mLastClickType = XUI.ClickTypes.SingleClick
		  End If
		  
		  // Get the section clicked in.
		  Var data As XUIInspectorMouseUpData
		  For Each section As XUIInspectorSection In mSections
		    If section.Bounds <> Nil And section.Bounds.Contains(x, y) Then
		      data = section.MouseUp(x, y, mLastClickType)
		      If data = Nil Then
		        // The click did not occur in this section.
		        Continue
		      End If
		      
		      If data.VisualChange Then RedrawImmediately
		      
		      Exit
		    End If
		  Next section
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  /// The mouse has wheeled on Windows or Linux.
		  ///
		  /// `x` is the X coord relative to the control that has received the event.
		  /// `y` is the Y coord relative to the control that has received the event.
		  /// `deltaX` is the number of horizontal scroll lines moved.
		  /// `deltaY` is the number of vertical scroll lines moved.
		  ///
		  /// Returns True to prevent propagating the event further.
		  ///
		  /// `deltaX` is positive when the user scrolls right and negative when scrolling left. 
		  /// `deltaY` is positive when the user scrolls down and negative when scrolling up.
		  ///
		  /// Never called on macOS (handled instead within `NSScrollViewBoundsChanged`).
		  
		  #Pragma Unused deltaX
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  #If TargetMacOS Then
		    Return True
		  #EndIf
		  
		  // Prevent the event propagating further.
		  If deltaY = 0 Then Return True
		  
		  // =================================
		  // VERTICAL SCROLLING
		  // =================================
		  Const SLOW_THRESHOLD = 10
		  Const MIN_SCROLL = 5
		  If deltaY < 0 Then
		    // Scroll up.
		    If AllowInertialScrolling Then
		      If Abs(deltaY) < SLOW_THRESHOLD Then
		        ScrollOffsetY = ScrollOffsetY - MIN_SCROLL
		      Else
		        ScrollOffsetY = ScrollOffsetY - ((Abs(deltaY) / MIN_SCROLL) * VSCROLL_SENSITIVITY)
		      End If
		    Else
		      // Just scroll up by the minimum scroll
		      ScrollOffsetY = ScrollOffsetY - MIN_SCROLL
		    End If
		  ElseIf deltaY > 0 Then
		    // Scroll down
		    If AllowInertialScrolling Then
		      If Abs(deltaY) < SLOW_THRESHOLD Then
		        ScrollOffsetY = ScrollOffsetY + MIN_SCROLL
		      Else
		        ScrollOffsetY = ScrollOffsetY + ((Abs(deltaY) / MIN_SCROLL) * VSCROLL_SENSITIVITY)
		      End If
		    Else
		      // Just scroll down by the minimum scroll
		      ScrollOffsetY = ScrollOffsetY + MIN_SCROLL
		    End If
		  End If
		  
		  Refresh
		End Function
	#tag EndEvent

	#tag Event , Description = 546865207363726F6C6C207669657720626F756E647320686173206368616E6765642E
		Sub NSScrollViewBoundsChanged(bounds As CGRect)
		  /// The user has scrolled with the mouse / trackpad on macOS.
		  ///
		  /// bounds.Origin.X is the horizontal scroll offset (same as NSScrollViewCanvas.ScrollX_)
		  /// bounds.Origin.Y is the vertical scroll offset (same as NSScrollViewCanvas.ScrollY_)
		  /// bounds.RectSize contains the width and height of the document window.
		  ///
		  /// Note: This replaces the `MouseWheel` event on macOS.
		  
		  #Pragma Unused bounds
		  
		  // This looks daft but ScrollOffsetY clamps ScrollY_ for us.
		  ScrollOffsetY = ScrollY_
		  
		  Refresh
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Xojo.Rect)
		  #Pragma Unused areas
		  
		  If Self.Style = Nil Then Return
		  
		  If mBackBuffer = Nil Or mNeedsFullRedraw Then
		    RebuildBackBuffer
		  End If
		  
		  // Draw the background.
		  g.DrawingColor = Style.BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // Draw the back buffer, vertically offsetting it for scrolling.
		  g.DrawPicture(mBackBuffer, 0, -ScrollOffsetY)
		  
		  // Borders.
		  g.DrawingColor = Style.BorderColor
		  g.PenSize = 1
		  If HasTopBorder Then
		    g.DrawLine(0, 0, g.Width, 0)
		  End If
		  If HasBottomBorder Then
		    g.DrawLine(0, g.Height - 1, g.Width, g.Height - 1)
		  End If
		  If HasLeftBorder Then
		    g.DrawLine(0, 0, 0, g.Height - 1)
		  End If
		  If HasRightBorder Then
		    g.DrawLine(g.Width - 1, 0, g.Width - 1, g.Height - 1)
		  End If
		  
		  // Is there a popup to draw?
		  If mPopup <> Nil Then
		    mPopup.Render(g, Style, ScrollOffsetY)
		  End If
		  
		  // On macOS we need to update the document size to get fancy scrollbars.
		  #If TargetMacOS
		    SetDocumentSize(mBackBuffer.Graphics.Width, mBackBuffer.Graphics.Height)
		  #EndIf
		End Sub
	#tag EndEvent

	#tag Event
		Function RectForRange(ByRef range As TextRange) As Xojo.Rect
		  // Delegate to the item currently in focus.
		  If ItemWithFocus <> Nil And ItemWithFocus IsA XUIInspectorItemKeyHandler Then
		    Return XUIInspectorItemKeyHandler(ItemWithFocus).RectForRange(range)
		  End If
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub ScaleFactorChanged(newScaleFactor as Double)
		  /// The canvas has moved onto a monitor with a different scale factor.
		  
		  #Pragma Unused newScaleFactor
		  
		  RebuildBackBuffer
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 417070656E6473206073656374696F6E6020746F2074686520696E73706563746F722E
		Sub AddSection(section As XUIInspectorSection)
		  /// Appends `section` to the inspector.
		  
		  section.Owner = Self
		  mSections.Add(section)
		  
		  RedrawImmediately
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41646473206073656374696F6E6020746F207468697320696E73706563746F722061742060696E646578602E2052616973657320616E20604F75744F66426F756E6473457863657074696F6E602069662060696E6465786020697320696E76616C69642E
		Sub AddSectionAt(index As Integer, section As XUIInspectorSection)
		  /// Adds `section` to this inspector at `index`. 
		  /// Raises an `OutOfBoundsException` if `index` is invalid.
		  
		  mSections.AddAt(index, section)
		  
		  RedrawImmediately
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C6564207768656E6576657220606D4361726574426C696E6B657254696D65722E416374696F6E602066697265732E
		Private Sub CaretBlinkerTimerAction(sender As Timer)
		  /// Called whenever `mCaretBlinkerTimer.Action` fires.
		  
		  #Pragma Unused sender
		  
		  If mItemWithFocus = Nil Then
		    CaretVisible = False
		  Else
		    CaretVisible = Not CaretVisible
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E657720696E73706563746F7220636F6E74726F6C2E
		Sub Constructor()
		  /// Constructs a new inspector control.
		  
		  Super.Constructor
		  
		  // Start with the default style.
		  Self.Style = XUIInspectorStyle.Default
		  
		  // Setup the timer that handles refreshing.
		  mRefreshTimer = New Timer
		  mRefreshTimer.Period = 50
		  mRefreshTimer.RunMode = Timer.RunModes.Multiple
		  AddHandler mRefreshTimer.Action, AddressOf RefreshTimerAction
		  mRefreshTimer.Enabled = True
		  
		  // Setup the caret blinker timer.
		  mCaretBlinkerTimer = New Timer
		  mCaretBlinkerTimer.Period = 500
		  mCaretBlinkerTimer.RunMode = Timer.RunModes.Multiple
		  AddHandler mCaretBlinkerTimer.Action, AddressOf CaretBlinkerTimerAction
		  mCaretBlinkerTimer.Enabled = True
		  
		  // We don't support horizontal scrolling.
		  HasHorizontalScrollbar = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 457870616E647320616C6C2073656374696F6E7320696E2074686520696E73706563746F722E
		Sub ExpandAllSections()
		  /// Expands all sections in the inspector.
		  
		  For Each section As XUIInspectorSection In mSections
		    section.Expanded = True
		  Next section
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 536574732060706F7075704D656E756020746F206265207468652063757272656E746C792061637469766520706F707570206D656E7520696E2074686520696E73706563746F722E2048616E646C657320636C6F73696E6720616E206578697374696E6720706F707570206D656E752028696620616E79292E20526564726177732074686520696E73706563746F722E
		Private Sub HandleNewPopupMenu(popupMenu As XUIInspectorItemPopupMenu)
		  /// Sets `popupMenu` to be the currently active popup menu in the inspector.
		  /// Handles closing an existing popup menu (if any).
		  /// Redraws the inspector.
		  
		  // If there is already a popup open it should be dismissed and its owner informed.
		  If mPopup <> Nil Then
		    mPopup.Owner.PopupDismissed
		  End If
		  
		  // Edge case: No items in the popup.
		  If popupMenu.Items.Count = 0 Then
		    popupMenu.Owner.PopupDismissed
		    mPopup = Nil
		    RedrawImmediately
		    Return
		  End If
		  
		  // Assign the popup menu.
		  mPopup = popupMenu
		  
		  // Cache the backbuffer's graphics for brevity.
		  Var g As Graphics = mBackBuffer.Graphics
		  
		  g.SaveState
		  
		  // Cache the width and height of the the popup.
		  Var popupW As Double = mPopup.RequiredWidth(g, Style)
		  Var popupH As Double = mPopup.RequiredHeight(g, Style)
		  
		  // ========================
		  // COMPUTE POPUP X POSITION
		  // ========================
		  Var x As Double
		  If mPopup.Anchor = XUIInspectorItemPopupMenu.Anchors.Left Then
		    // AnchorX is the desired left edge X position.
		    x = mPopup.AnchorX
		    // Clamp `x` to make sure it fits in the inspector's current bounds.
		    x = XUIMaths.Clamp(x, 0, g.Width - popupW)
		  Else
		    // AnchorX is the desired right edge X position.
		    x = mPopup.AnchorX - popupW
		    // Clamp `x` to make sure it fits in the inspector's current bounds.
		    x = XUIMaths.Clamp(x, 0, g.Width)
		  End If
		  
		  // ========================
		  // COMPUTE POPUP Y POSITION
		  // ========================
		  Var y As Double
		  // First try to honour the preferred top Y position.
		  If mPopup.PreferredTopY + popupH <= g.Height Then
		    y = mPopup.PreferredTopY
		  ElseIf mPopup.PreferredBottomY - popupH >= 0 Then
		    // Not possible. Try to honour the preferred bottom Y position.
		    y = mPopup.PreferredBottomY
		  Else
		    // Not possible, automatically position the popup menu vertically in the centre of the item.
		    y = mPopup.Owner.Bounds.Center.Y - (popupH / 2)
		  End If
		  // Clamp y to a valid position.
		  y = XUIMaths.Clamp(y, 0, g.Height)
		  
		  // Asisgn the bounds.
		  mPopup.Bounds = New Rect(x, y, popupW, popupH)
		  
		  // ========================
		  // COMPUTE THE ITEM BOUNDS
		  // ========================
		  Var itemTop As Double = mPopup.Bounds.Top + mPopup.ITEM_VPADDING
		  Var itemLeft As Double = mPopup.Bounds.Left + mPopup.HPADDING
		  Var itemWidth As Double = popupW - (mPopup.HPADDING * 2)
		  
		  g.FontName = Style.FontName
		  g.FontSize = Style.FontSize
		  Var itemHeight As Double = If(g.TextHeight > mPopup.INDICATOR_SIZE, g.TextHeight, mPopup.INDICATOR_SIZE)
		  
		  For Each item As String In mPopup.Items
		    mPopup.ItemBounds.Add(New Rect(itemLeft, itemTop, itemWidth, itemHeight))
		    itemTop = itemTop + itemHeight + mPopup.ITEM_VPADDING
		  Next item
		  
		  g.RestoreState
		  
		  RedrawImmediately
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C65732061206D6F7573652075702077697468696E20606D506F707570602E
		Private Sub HandlePopupMenuClick(x As Double, y As Double)
		  /// Handles a mouse up within `mPopup`.
		  
		  For i As Integer = 0 To mPopup.ItemBounds.LastIndex
		    If mPopup.ItemBounds(i).Contains(x, y) Then
		      // Tell the popup's owner that this item was clicked.
		      mPopup.Owner.PopupItemSelected(i)
		      Exit
		    End If
		  Next i
		  
		  // Dismiss the popup.
		  mPopup.Owner.PopupDismissed
		  mPopup = Nil
		  
		  // Redraw.
		  RedrawImmediately
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732054727565206966206120646F75626C6520636C69636B206A757374206F636375727265642E20417373756D65732060786020616E6420607960206172652061646A757374656420666F72207363726F6C6C696E672E
		Private Function IsDoubleClick(x As Integer, y As Integer) As Boolean
		  /// Returns True if a double click just occurred.
		  /// Assumes `x` and `y` are adjusted for scrolling.
		  
		  Const SPACE_DELTA = 4
		  
		  Var currentClickTicks As Integer
		  Var result As Boolean = False
		  
		  currentClickTicks = System.Ticks
		  
		  // Did the two clicks happen close enough together in time?
		  If (currentClickTicks - mLastClickTicks) <= XUI.GetDoubleClickTimeTicks Then
		    // Did they happen close enough together in space?
		    If Abs(x - mLastMouseUpX) <= SPACE_DELTA And Abs(y - mLastMouseUpY) <= SPACE_DELTA Then
		      // A double click has occurred.
		      result = True
		    End If
		  End If
		  
		  mLastClickTicks = currentClickTicks
		  mLastMouseUpX = x
		  mLastMouseUpY = y
		  
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732054727565206966206120747269706C6520636C69636B206A7573742068617070656E65642E20417373756D65732060786020616E6420607960206172652061646A757374656420666F72207363726F6C6C696E672E
		Private Function IsTripleClick(x As Integer, y As Integer) As Boolean
		  /// Returns True if a triple click just happened.
		  /// Assumes `x` and `y` are adjusted for scrolling.
		  
		  Const SPACE_DELTA = 4
		  
		  If mLastClickType = XUI.ClickTypes.DoubleClick Then
		    // At least a double click has occurred.
		    Var doubleClickTime, currentClickTicks As Integer
		    Var result As Boolean = False
		    
		    doubleClickTime = XUI.GetDoubleClickTimeTicks
		    currentClickTicks = System.Ticks
		    
		    // Did the three clicks happen close enough together in time?
		    If (currentClickTicks - mLastTripleClickTicks) <= doubleClickTime Then
		      // Did the three clicks happen close enough together in space?
		      If Abs(x - mLastMouseUpX) <= SPACE_DELTA And Abs(y - mLastMouseUpY) <= SPACE_DELTA Then
		        // A triple click occurred.
		        result = True
		      End If
		    End If
		    
		    // Cache required values.
		    mLastTripleClickTicks = currentClickTicks
		    mLastMouseUpX = x
		    mLastMouseUpY = y
		    Return result
		  Else
		    // Even a double click hasn't occurred.
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520666F63757320746F207468652066697273742076697369626C65206974656D20696E2074686520696E73706563746F7220746861742063616E206163636570742074616220666F6375732E
		Private Sub MoveFocusToFirstItem()
		  /// Moves the focus to the first visible item in the inspector that can accept tab focus.
		  
		  For Each section As XUIInspectorSection In mSections
		    Var item As XUIInspectorItem = section.FirstItemThatCanAcceptTabFocus
		    If item <> Nil Then
		      // Found the first item in this section that can accept tab focus.
		      ItemWithFocus = item
		      ItemWithFocus.DidReceiveTabFocus
		      Return
		    End If
		  Next section
		  
		  // If we get here then there are no visible items that can receive the tab focus.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520666F63757320746F20746865206E657874206974656D20746861742063616E20616363657074207468652074616220666F6375732E
		Private Sub MoveFocusToNextItem()
		  /// Moves the focus to the next item that can accept the tab focus.
		  
		  If ItemWithFocus = Nil Then
		    // Give the focus to the first item that can accept tab focus.
		    MoveFocusToFirstItem
		    Return
		  End If
		  
		  If SectionWithFocus = Nil Then Return
		  
		  // Start at the current section and loop through all visible sections until we get 
		  // back to the current section.
		  Var currentSectionIndex As Integer = mSections.IndexOf(SectionWithFocus)
		  If currentSectionIndex < 0 Or currentSectionIndex > mSections.LastIndex Then Return
		  For i As Integer = currentSectionIndex To mSections.LastIndex
		    Var result As XUIInspectorItem = mSections(i).MoveFocusToNextItem(ItemWithFocus)
		    If result <> Nil Then
		      ItemWithFocus = result
		      ItemWithFocus.DidReceiveTabFocus
		      Return
		    End If
		  Next i
		  
		  // Haven't found an item moving down the inspector that can receive the tab focus.
		  // Start at the top of the inspector down to the current section.
		  For i As Integer = 0 To currentSectionIndex
		    Var result As XUIInspectorItem = mSections(i).MoveFocusToNextItem(ItemWithFocus)
		    If result <> Nil Then
		      ItemWithFocus = result
		      ItemWithFocus.DidReceiveTabFocus
		      Return
		    End If
		  Next i
		  
		  // If we've reached here then there is no item to move the focus to.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520666F63757320746F207468652070726576696F7573206974656D20746861742063616E20616363657074207468652074616220666F6375732E
		Private Sub MoveFocusToPreviousItem()
		  /// Moves the focus to the previous item that can accept the tab focus.
		  
		  If ItemWithFocus = Nil Then
		    // Give the focus to the first item that can accept tab focus.
		    MoveFocusToFirstItem
		    Return
		  End If
		  
		  If SectionWithFocus = Nil Then Return
		  
		  // Start at the current section and loop backwards through all visible sections
		  // until we get back to the current section.
		  
		  Var currentSectionIndex As Integer = mSections.IndexOf(SectionWithFocus)
		  If currentSectionIndex < 0 Or currentSectionIndex > mSections.LastIndex Then Return
		  For i As Integer = currentSectionIndex DownTo 0
		    Var result As XUIInspectorItem = mSections(i).MoveFocusToPreviousItem(ItemWithFocus)
		    If result <> Nil Then
		      ItemWithFocus = result
		      ItemWithFocus.DidReceiveBackTab
		      Return
		    End If
		  Next i
		  
		  // Haven't found an item moving up the inspector that can receive the tab focus.
		  // Start at the bottom of the inspector, moving up to the current section.
		  For i As Integer = mSections.LastIndex DownTo currentSectionIndex
		    Var result As XUIInspectorItem = mSections(i).MoveFocusToPreviousItem(ItemWithFocus)
		    If result <> Nil Then
		      ItemWithFocus = result
		      ItemWithFocus.DidReceiveBackTab
		      Return
		    End If
		  Next i
		  
		  // If we've reached here then there is no item to move the focus to.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656275696C64732074686520696E7465726E616C207069637475726520746861742069732072656E646572656420746F2074686520696E73706563746F72277320677261706869637320636F6E746578742E
		Private Sub RebuildBackBuffer()
		  /// Rebuilds the internal picture that is rendered to the inspector's graphics context.
		  
		  If Self.Window = Nil Then
		    Return
		  Else
		    Var bufferW As Double = Me.Width
		    #If TargetMacOS Then
		      // Adjust the width if legacy vertical scrollbars are visible on macOS.
		      If Self.HasVerticalScrollbar And Self.NSScrollerStyle = NSScrollViewCanvas.NSScrollerStyles.Legacy Then
		        bufferW = Me.Width - NSScrollViewCanvas.SCROLLBAR_DEPTH
		      End If
		    #EndIf
		    mBackBuffer = Self.Window.BitmapForCaching(bufferW, RequiredHeight)
		  End If
		  
		  // Grab a reference to the back buffer's graphics for brevity.
		  Var g As Graphics = mBackBuffer.Graphics
		  
		  // Draw the sections.
		  Var y As Double = 0
		  For Each section As XUIInspectorSection In mSections
		    y = section.Render(g, 0, y, Style)
		  Next section
		  
		  mNeedsFullRedraw = False
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526564726177732074686520696E73706563746F7220696D6D6564696174656C792E
		Sub RedrawImmediately()
		  /// Redraws the inspector immediately.
		  
		  mNeedsFullRedraw = True
		  Refresh(True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C6564207768656E6576657220606D5265667265736854696D65722E416374696F6E602066697265732E
		Private Sub RefreshTimerAction(sender As Timer)
		  /// Called whenever `mRefreshTimer.Action` fires.
		  
		  #Pragma Unused sender
		  
		  RedrawImmediately
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616C6C2073656374696F6E732066726F6D2074686520696E73706563746F722E
		Sub RemoveAllSections()
		  /// Removes all sections from the inspector.
		  
		  mSections.RemoveAll
		  
		  RedrawImmediately
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F766573206073656374696F6E602028696620666F756E64292066726F6D207468697320696E73706563746F722E
		Sub RemoveSection(section As XUIInspectorSection)
		  /// Removes `section` (if found) from this inspector.
		  
		  For i As Integer = 0 To mSections.LastIndex
		    If mSections(i) = section Then
		      mSections.RemoveAt(i)
		      RedrawImmediately
		      Return
		    End If
		  Next i
		  
		  RedrawImmediately
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616E642072657475726E73207468652066697273742073656374696F6E206E616D656420606E616D65602E20436173652D696E73656E736974697665207365617263682E204966207468652073656374696F6E206973206E6F7420666F756E64207468656E204E696C2069732072657475726E65642E
		Function RemoveSectionNamed(name As String) As XUIInspectorSection
		  /// Removes and returns the first section named `name`. Case-insensitive search.
		  /// If the section is not found then Nil is returned.
		  
		  For i As Integer = 0 To mSections.LastIndex
		    If mSections(i).Name = name Then
		      Var section As XUIInspectorSection = mSections(i)
		      mSections.RemoveAt(i)
		      RedrawImmediately
		      Return section
		    End If
		  Next i
		  
		  // Not found.
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E64657273206120646973636C6F737572652077696467657420746F2060676020616E642072657475726E73206974732068697420626F756E64732E2050726573657276657320746865207374617465206F66206067602E
		Shared Function RenderDisclosureWidget(g As Graphics, x As Double, y As Double, colour As Color, expanded As Boolean, bold As Boolean) As Rect
		  /// Renders a disclosure widget to `g` and returns its hit bounds.
		  /// Preserves the state of `g`.
		  ///
		  /// x: The left edge of the widget.
		  /// y: The top edge of the widget.
		  /// expanded: True = downwards facing, False = right-facing.
		  /// bold: If True then the widget is thicker.
		  
		  g.SaveState
		  
		  Var rightX, rightY, bottomX, bottomY As Double
		  
		  g.DrawingColor = colour
		  g.PenSize = If(Bold, 2, 1)
		  
		  // Compute the vertices.
		  If expanded Then
		    // Draw a downwards triangle.
		    rightX = x + WIDGET_WIDTH_EXPANDED
		    bottomX = x + WIDGET_HEIGHT_EXPANDED
		    bottomY = y + WIDGET_HEIGHT_EXPANDED
		    // Draw the widget.
		    g.DrawLine(x, y, bottomX, bottomY)
		    g.DrawLine(bottomX, bottomY, rightX, y)
		  Else
		    // Draw a right-facing triangle.
		    rightX = x + WIDGET_WIDTH_COLLAPSED
		    rightY = y + (WIDGET_HEIGHT_COLLAPSED / 2)
		    bottomY = y + WIDGET_HEIGHT_COLLAPSED
		    // Draw the widget.
		    g.DrawLine(x, y, rightX, rightY)
		    g.DrawLine(rightX, rightY, x, bottomY)
		  End If
		  
		  g.RestoreState
		  
		  // Return the rect bounds for this widget.
		  Return New Rect(x, y, rightX - x, bottomY - y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652068656967687420726571756972656420746F20647261772074686520696E73706563746F7220696E2066756C6C20676976656E2074686520636F6C6C617073656420737461747573206F6620616C6C2073656374696F6E732E
		Private Function RequiredHeight() As Double
		  /// Returns the max height required to draw the inspector in full given the collapsed status of all sections.
		  /// Will always be as tall as the height of the inspector.
		  
		  Var h As Double
		  
		  For Each section As XUIInspectorSection In mSections
		    h = h + section.Height(Style)
		  Next section
		  
		  // Cache the value
		  mCachedRequiredHeight = Max(h, Me.Height)
		  
		  Return mCachedRequiredHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652066697273742073656374696F6E206E616D656420606E616D65602E20436173652D696E73656E736974697665207365617263682E204D61792072657475726E204E696C2E
		Function SectionNamed(name As String) As XUIInspectorSection
		  /// Returns the first section named `name`. Case-insensitive search. May return Nil.
		  
		  For Each section As XUIInspectorSection In mSections
		    If section.Name = name Then Return section
		  Next section
		  
		  // Not found.
		  Return Nil
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		An inspector control that is capable of displaying multiple items, separated into sections. Items are very customisable, ranging from text fields to checkboxes.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520696E73706563746F722077696C6C20766572746963616C6C79207363726F6C6C2066617374657220696620746865206D6F75736520776865656C206973206D6F766564206661737465722E
		AllowInertialScrolling As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4966205472756520616E6420612074657874206669656C6420697320696E20666F637573207468656E20746865206373617265742069732076697369626C652C206F7468657277697365207468652063617265742069732068696464656E2E
		CaretVisible As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4172626974726172792064617461206173736F6369617465642077697468207468697320696E73706563746F722E
		Data As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E2074686520696E73706563746F7220686173206120626F74746F6D20626F726465722E
		#tag Getter
			Get
			  Return mHasBottomBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasBottomBorder = value
			End Set
		#tag EndSetter
		HasBottomBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E2074686520696E73706563746F72206861732061206C65667420626F726465722E
		#tag Getter
			Get
			  Return mHasLeftBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasLeftBorder = value
			End Set
		#tag EndSetter
		HasLeftBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E2074686520696E73706563746F72206861732061206C65667420626F726465722E
		#tag Getter
			Get
			  Return mHasRightBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasRightBorder = value
			End Set
		#tag EndSetter
		HasRightBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E2074686520696E73706563746F7220686173206120746F7020626F726465722E
		#tag Getter
			Get
			  Return mHasTopBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasTopBorder = value
			End Set
		#tag EndSetter
		HasTopBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206974656D20746861742063757272656E746C79206861732074686520666F6375732E204D6179206265204E696C2E
		#tag Getter
			Get
			  Return mItemWithFocus
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mItemWithFocus <> Nil And mItemWithFocus <> value Then
			    mItemWithFocus.LostFocus
			  End If
			  
			  mItemWithFocus = value
			  
			End Set
		#tag EndSetter
		ItemWithFocus As XUIInspectorItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620746865206D6F75736520636C69636B2074686174206A757374206F6363757272656420696E2074686520604D6F757365446F776E60206576656E7420776173206120636F6E7465787475616C20636C69636B2E
		#tag Getter
			Get
			  Return mLastClickWasContextual
			End Get
		#tag EndGetter
		LastClickWasContextual As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865205820636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742E
		#tag Getter
			Get
			  Return mLastMouseDownX
			  
			End Get
		#tag EndGetter
		LastMouseDownX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865205920636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742028616C72656164792061646A757374656420666F72207363726F6C6C696E67292E
		#tag Getter
			Get
			  Return mLastMouseDownY
			  
			End Get
		#tag EndGetter
		LastMouseDownY As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 54686520696E7465726E616C207069637475726520746861742069732072656E646572656420746F2074686520696E73706563746F7227732063616E7661732E
		Private mBackBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41206361636865206F66207468652068656967687420726571756972656420746F20647261772074686520696E73706563746F7220696E2066756C6C20676976656E2074686520636F6C6C617073656420737461747573206F6620616C6C2073656374696F6E7320636F6D707574656420696E20746865206C61737420605061696E74282960206576656E742E
		Private mCachedRequiredHeight As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 48616E646C657320626C696E6B696E6720746865206361726574206F6620616E79206163746976652074657874206669656C6420696E2074686520696E73706563746F722E
		Private mCaretBlinkerTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520696E73706563746F722073686F756C642064726177206120626F74746F6D20626F726465722E
		Private mHasBottomBorder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520696E73706563746F722073686F756C6420647261772061206C65667420626F726465722E
		Private mHasLeftBorder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520696E73706563746F722073686F756C642064726177206120726967687420626F726465722E
		Private mHasRightBorder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520696E73706563746F722073686F756C642064726177206120746F7020626F726465722E
		Private mHasTopBorder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E74206974656D20776974682074686520666F6375732E204D6179206265204E696C2E
		Private mItemWithFocus As XUIInspectorItem
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207469636B73207468617420746865206C617374206D6F75736520636C69636B206F636375727265642061742E
		Private mLastClickTicks As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652074797065206F6620636C69636B2074686174206F6363757272656420696E20746865206C61737420604D6F757365557060206576656E742E
		Private mLastClickType As XUI.ClickTypes = XUI.ClickTypes.SingleClick
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206D6F75736520636C69636B2074686174206A757374206F6363757272656420696E2074686520604D6F757365446F776E60206576656E7420776173206120636F6E7465787475616C20636C69636B2E
		Private mLastClickWasContextual As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205820636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742E204E6F742061646A757374656420666F7220616E79207363726F6C6C696E672E
		Private mLastMouseDownX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205920636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742E204E6F742061646A757374656420666F7220616E79207363726F6C6C696E672E
		Private mLastMouseDownY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652058206D6F75736520636F6F7264696E6174652066726F6D207468652070726576696F757320604D6F757365557060206576656E742C2061646A757374656420666F72207363726F6C6C696E672E
		Private mLastMouseUpX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652059206D6F75736520636F6F7264696E6174652066726F6D207468652070726576696F757320604D6F757365557060206576656E742C2061646A757374656420666F72207363726F6C6C696E672E
		Private mLastMouseUpY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C617374206974656D206D6F766564206F76657220627920746865206D6F7573652E204D6179206265204E696C2E
		Private mLastMovedItem As XUIInspectorItem
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207469636B73207468617420746865206C61737420747269706C6520636C69636B206F636375727265642061742E
		Private mLastTripleClickTicks As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E20746865206261636B206275666665722077696C6C2062652072656372656174656420617420746865206E657874205061696E74206576656E742E
		Private mNeedsFullRedraw As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E746C7920646973706C6179656420706F707570206D656E752E2057696C6C206265204E696C2069662074686572652069736E2774206F6E652E
		Private mPopup As XUIInspectorItemPopupMenu
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 526573706F6E7369626C6520666F7220726567756C61726C792072657061696E74696E672074686520696E73706563746F722E
		Private mRefreshTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C73207765277665207363726F6C6C656420766572746963616C6C792E203E30206D65616E73207468652063616E76617320686173207363726F6C6C656420646F776E2E
		Private mScrollOffsetY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652073656374696F6E732077697468696E207468697320696E73706563746F722E
		Private mSections() As XUIInspectorSection
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620706978656C73207765277665207363726F6C6C656420766572746963616C6C792E203E30206D65616E73207468652063616E76617320686173207363726F6C6C656420646F776E2E
		#tag Getter
			Get
			  Return mScrollOffsetY
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Compute the maximum vertical scroll offset.
			  Var maxScrollY As Integer = Max(mCachedRequiredHeight - Self.Height, 0)
			  
			  mScrollOffsetY = XUIMaths.Clamp(value, 0, maxScrollY)
			End Set
		#tag EndSetter
		ScrollOffsetY As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E742073656374696F6E20696E20666F6375732E204D6179206265204E696C2E
		#tag Getter
			Get
			  If ItemWithFocus = Nil Then
			    Return Nil
			  Else
			    Return ItemWithFocus.Section
			  End If
			  
			End Get
		#tag EndGetter
		SectionWithFocus As XUIInspectorSection
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468697320696E73706563746F7227732064726177696E67207374796C652E
		Style As XUIInspectorStyle
	#tag EndProperty


	#tag Constant, Name = CAPTION_CONTROL_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Public, Description = 546865206E756D626572206F6620706978656C7320746F20706164206265747765656E20612063617074696F6E20616E6420616E2061646A6163656E7420636F6E74726F6C2E
	#tag EndConstant

	#tag Constant, Name = CONTROL_BORDER_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Public, Description = 546865206E75696D626572206F6620706978656C7320746F20706164206265747765656E206120636F6E74726F6C20616E642074686520696E73706563746F72277320626F726465722E
	#tag EndConstant

	#tag Constant, Name = NOTIFICATION_ITEM_CHANGED, Type = String, Dynamic = False, Default = \"Inspector.ItemChanged", Scope = Public, Description = 416E206974656D20686173206368616E67656420696E20736F6D657761792E
	#tag EndConstant

	#tag Constant, Name = VSCROLL_SENSITIVITY, Type = Double, Dynamic = False, Default = \"2.5", Scope = Private, Description = 486967686572206E756D626572203D206D6F7265206C696E6573207363726F6C6C6564207768656E20717569636B6C79207363726F6C6C696E6720766572746963616C6C792E2056616C756573206265747765656E2031202D203320776F726B2077656C6C2E
	#tag EndConstant

	#tag Constant, Name = WIDGET_HEIGHT_COLLAPSED, Type = Double, Dynamic = False, Default = \"10", Scope = Public, Description = 5468652068656967687420696E20706978656C73206F662074686520636F6C6C61707365642028726967687477617264732D666163696E672920646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = WIDGET_HEIGHT_EXPANDED, Type = Double, Dynamic = False, Default = \"5", Scope = Public, Description = 54686520686569676874206F662074686520657870616E6465642028646F776E77617264732D666163696E672920646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = WIDGET_WIDTH_COLLAPSED, Type = Double, Dynamic = False, Default = \"6", Scope = Public, Description = 54686520776964746820696E20706978656C73206F662074686520636F6C6C61707365642028726967687477617264732D666163696E672920646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = WIDGET_WIDTH_EXPANDED, Type = Double, Dynamic = False, Default = \"10", Scope = Public, Description = 546865207769647468206F662074686520657870616E6465642028646F776E77617264732D666163696E672920646973636C6F73757265207769646765742E
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasTopBorder"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBottomBorder"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasLeftBorder"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasRightBorder"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollOffsetY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowInertialScrolling"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretVisible"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastClickWasContextual"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastMouseDownY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastMouseDownX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
