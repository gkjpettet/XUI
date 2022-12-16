#tag Class
Protected Class XUIInspector
Inherits NSScrollViewCanvas
	#tag Event
		Function DoCommand(command As String) As Boolean
		  /// A key command has occurred.
		  
		  // Delegate to the item currently in focus.
		  If ItemWithFocus <> Nil And ItemWithFocus IsA XUIInspectorItemKeyHandler Then
		    XUIInspectorItemKeyHandler(ItemWithFocus).DoCommand(command)
		  End If
		  
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
		      data = section.MouseDown(x, y)
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
		  
		  // Get the section clicked in.
		  Var data As XUIInspectorMouseUpData
		  For Each section As XUIInspectorSection In mSections
		    If section.Bounds <> Nil And section.Bounds.Contains(x, y) Then
		      data = section.MouseUp(x, y)
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

	#tag Method, Flags = &h0
		Sub Constructor()
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

	#tag Method, Flags = &h21
		Private Sub RebuildBackBuffer()
		  If Self.Window = Nil Then
		    Return
		  Else
		    mBackBuffer = Self.Window.BitmapForCaching(Me.Width, RequiredHeight)
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


	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520696E73706563746F722077696C6C20766572746963616C6C79207363726F6C6C2066617374657220696620746865206D6F75736520776865656C206973206D6F766564206661737465722E
		AllowInertialScrolling As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4966205472756520616E6420612074657874206669656C6420697320696E20666F637573207468656E20746865206373617265742069732076697369626C652C206F7468657277697365207468652063617265742069732068696464656E2E
		CaretVisible As Boolean = False
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
			  If mItemWithFocus <> Nil Then
			    mItemWithFocus.LostFocus
			  End If
			  
			  mItemWithFocus = value
			  
			End Set
		#tag EndSetter
		ItemWithFocus As XUIInspectorItem
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBackBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41206361636865206F66207468652068656967687420726571756972656420746F20647261772074686520696E73706563746F7220696E2066756C6C20676976656E2074686520636F6C6C617073656420737461747573206F6620616C6C2073656374696F6E7320636F6D707574656420696E20746865206C61737420605061696E74282960206576656E742E
		Private mCachedRequiredHeight As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 48616E646C657320626C696E6B696E6720746865206361726574206F6620616E79206163746976652074657874206669656C6420696E2074686520696E73706563746F722E
		Private mCaretBlinkerTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasBottomBorder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasLeftBorder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasRightBorder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasTopBorder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E74206974656D20776974682074686520666F6375732E204D6179206265204E696C2E
		Private mItemWithFocus As XUIInspectorItem
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C617374206974656D206D6F766564206F76657220627920746865206D6F7573652E204D6179206265204E696C2E
		Private mLastMovedItem As XUIInspectorItem
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

	#tag Property, Flags = &h0, Description = 5468697320696E73706563746F7227732064726177696E67207374796C652E
		Style As XUIInspectorStyle
	#tag EndProperty


	#tag Constant, Name = NOTIFICATION_ITEM_CHANGED, Type = String, Dynamic = False, Default = \"Inspector.ItemChanged", Scope = Public
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
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="300"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="500"
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
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
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
	#tag EndViewBehavior
End Class
#tag EndClass
