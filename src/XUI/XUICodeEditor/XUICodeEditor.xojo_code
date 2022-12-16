#tag Class
Protected Class XUICodeEditor
Inherits NSScrollViewCanvas
Implements XUINotificationListener
	#tag Event
		Function ConstructContextualMenu(base As DesktopMenuItem, x As Integer, y As Integer) As Boolean
		  /// The user contextual clicked with CTRL-click on macOS.
		  ///
		  /// I think this should also fire when the user simply right-clicks but that 
		  /// isn't happening on 10.15 so we handle right clicks in the `MouseUp` event
		  /// instead (by checking for a right click with mLastClickWasContextual`).
		  
		  #Pragma Unused base
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  // Store that the click that just happened was contextual (right click).
		  mLastClickWasContextual = True
		  
		End Function
	#tag EndEvent

	#tag Event
		Function DoCommand(command As String) As Boolean
		  /// Handles `command`.
		  ///
		  /// `command` is a string constant telling us which command we need to handle.
		  
		  // Are we still typing? Most of these commands are considered as "not typing" 
		  // for the purposes of our undo engine.
		  CurrentUndoID = System.Ticks
		  Select Case command
		  Case CmdInsertNewline, CmdInsertTab
		    mLastKeyDownTicks = System.Ticks
		  Else
		    // Act as if we haven't pressed a key for ages.
		    mLastKeyDownTicks = 0
		  End Select
		  
		  // =========================================
		  // SUGGESTIONS POPUP
		  // =========================================
		  If mAutocompletePopup.Visible Then
		    Select Case command
		    Case CmdMoveDown
		      mAutocompletePopup.SelectedIndex = mAutocompletePopup.SelectedIndex + 1
		      Refresh
		      Return True
		      
		    Case CmdMoveUp
		      mAutocompletePopup.SelectedIndex = mAutocompletePopup.SelectedIndex - 1
		      Refresh
		      Return True
		      
		    Case CmdInsertTab, CmdInsertNewline
		      AcceptCurrentAutocompleteOption
		      Return True
		      
		    Else
		      HideAutocompletePopup
		      mSuppressAutocompletePopup = True
		      Refresh
		    End Select
		  End If
		  
		  Select Case command
		    // =========================================
		    // MOVING THE CARET
		    // =========================================
		  Case CmdScrollPageDown
		    // `Fn-Down Arrow` on macOS.
		    ScrollPageDown(True)
		    
		  Case CmdScrollPageUp
		    // `Fn-Up Arrow` on macOS
		    ScrollPageUp(True)
		    
		  Case CmdPageDown
		    // `Page down` key on Windows / Linux. 
		    ScrollPageDown(True)
		    
		  Case CmdPageUp
		    // `Page up` key on Windows / Linux.
		    ScrollPageUp(True)
		    
		  Case CmdMoveDown
		    MoveCaretDown
		    
		  Case CmdMoveLeft, CmdMoveBackward
		    MoveCaretLeft
		    
		  Case CmdMoveRight, CmdMoveForward
		    MoveCaretRight
		    
		  Case CmdMoveToBeginningOfDocument, CmdScrollToBeginningOfDocument
		    MoveToBeginningOfDocument
		    
		  Case CmdMoveToBeginningOfLine, CmdMoveToLeftEndOfLine
		    MoveToBeginningOfLine
		    
		  Case CmdMoveToEndOfDocument, CmdScrollToEndOfDocument
		    MoveToEndOfDocument
		    
		  Case CmdMoveToEndOfLine, CmdMoveToRightEndOfLine
		    MoveToEndOfLine
		    
		  Case CmdMoveWordLeft
		    MoveCaretToPreviousWordStart
		    
		  Case CmdMoveWordRight
		    MoveCaretToNextWordEnd
		    
		  Case CmdMoveUp
		    MoveCaretUp
		    
		    // =========================================
		    // DELETING
		    // =========================================
		  Case CmdDeleteBackward
		    // Remove the character before the caret.
		    DeleteBackward(True)
		    
		  Case CmdDeleteForward
		    // Remove the character after the caret.
		    DeleteForward(True)
		    
		    // =========================================
		    // INSERTING
		    // =========================================
		  Case CmdInsertNewline
		    // Occurs when the canvas has focus and the user presses Return or Enter.
		    HandleReturnKey(True)
		    
		    // =========================================
		    // SELECTING TEXT
		    // =========================================
		  Case CmdMoveLeftAndModifySelection
		    MoveLeftAndModifySelection
		    
		  Case CmdMoveWordLeftAndModifySelection
		    MoveWordLeftAndModifySelection
		    
		  Case CmdMoveWordRightAndModifySelection
		    MoveWordRightAndModifySelection
		    
		  Case CmdMoveRightAndModifySelection
		    MoveRightAndModifySelection
		    
		  Case CmdMoveToLeftEndOfLineAndModifySelection
		    MoveToLeftEndOfLineAndModifySelection
		    
		  Case CmdMoveToRightEndOfLineAndModifySelection
		    MoveToRightEndOfLineAndModifySelection
		    
		  Case CmdMoveUpAndModifySelection
		    MoveUpAndModifySelection
		    
		  Case CmdMoveDownAndModifySelection
		    MoveDownAndModifySelection
		    
		  Case CmdPageDownAndModifySelection
		    PageDownAndModifySelection
		    
		  Case CmdPageUpAndModifySelection
		    PageUpAndModifySelection
		    
		  Case CmdMoveToBeginningOfDocumentAndModifySelection
		    MoveToDocumentBeginningAndModifySelection
		    
		  Case CmdMoveToEndOfDocumentAndModifySelection
		    MoveToDocumentEndAndModifySelection
		    
		    // =========================================
		    // MISC
		    // =========================================
		  Case CmdInsertTab
		    If AutocompleteCombo = AutocompleteCombos.Tab Then
		      // The tab key is set to trigger autocomplete.
		      HandleAutocompleteKeyPress
		    Else
		      Insert(TabToSpaces, CaretPosition, True)
		    End If
		    
		  Case CmdInsertBacktab
		    // Shift-Tab. This always acts like a tab insertion (permits the insertion of a tab
		    // even when tab is used for autocomplete).
		    Insert(TabToSpaces, CaretPosition, True)
		    
		  Case "noop:"
		    If Keyboard.AsyncControlKey And Keyboard.AsyncKeyDown(&h31) Then
		      // Ctrl+Space pressed.
		      HandleCtrlSpace
		    End If
		    
		  End Select
		  
		  // Return True to prevent the event from propagating.
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub FocusLost()
		  /// The canvas just lost the focus.
		  
		  mHasFocus = False
		  
		  // No need to blink the caret.
		  mCaretBlinker.RunMode = Timer.RunModes.Off
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub FocusReceived()
		  /// The canvas has just received the focus.
		  
		  mHasFocus = True
		  
		  // Make sure the caret blinker timer is running.
		  mCaretBlinker.RunMode = Timer.RunModes.Multiple
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function FontNameAtLocation(location As Integer) As String
		  /// Returns the current font name.
		  ///
		  /// The editor only supports a uniform font name for all tokens.
		  
		  #Pragma Unused location
		  
		  Return Self.FontName
		  
		End Function
	#tag EndEvent

	#tag Event
		Function FontSizeAtLocation(location As Integer) As Single
		  /// Returns the current font size.
		  ///
		  /// The editor only supports a uniform font size for all tokens.
		  
		  #Pragma Unused location
		  
		  Return Self.FontSize
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub InsertText(text As String, range As TextRange)
		  // Inserts a single character.
		  
		  // Track that the user is typing.
		  mLastKeyDownTicks = System.Ticks
		  
		  // The user has pressed CtrlSpace on Windows/Linux. The `InsertText` event fires
		  // before the `KeyDown` event so if Ctrl is being held down at this point we need to *not* insert
		  // the space character.
		  #If TargetWindows Or TargetLinux
		    If Keyboard.AsyncControlKey And Text = " " Then Return
		  #EndIf
		  
		  InsertCharacter(Text, True, range)
		End Sub
	#tag EndEvent

	#tag Event
		Function IsEditable() As Boolean
		  /// Returns False if the canvas is read-only or True if it's editable.
		  
		  Return Not mReadOnly
		  
		End Function
	#tag EndEvent

	#tag Event
		Function KeyDown(key As String) As Boolean
		  #Pragma Unused Key
		  
		  // Track that the user is typing.
		  mLastKeyDownTicks = System.Ticks
		  
		  // Catch the Esc key on Windows & Linux.
		  // This is handled on macOS within `DoCommand`.
		  #If TargetWindows Or TargetLinux
		    If Key.Asc = &h1B Then // Esc.
		      HandleEscKey
		      Return True
		    End If
		  #EndIf
		  
		  // Catch Ctrl-Space key on Windows & Linux.
		  // This is handled on macOS within `DoCommand` as "noop:"
		  #If TargetWindows Or TargetLinux
		    If Keyboard.AsyncControlKey And Keyboard.AsyncKeyDown(&h31) Then
		      HandleCtrlSpace
		      Return True
		    End If
		  #EndIf
		  
		End Function
	#tag EndEvent

	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  // Give the canvas the focus.
		  Me.SetFocus
		  
		  // At the exact moment the mouse is clicked we aren't dragging yet.
		  mDragging = False
		  
		  // Cache the x, y coords that this mouse down event occurs at.
		  mLastMouseDownX = x
		  mLastMouseDownY = y
		  
		  // Right click?
		  mLastClickWasContextual = IsContextualClick
		  
		  // Dragging a scrollbar?
		  #If TargetWindows Or TargetLinux
		    If mVerticalScrollbar <> Nil And mVerticalScrollbarThumbBounds.Contains(x, y) Then
		      mDraggingVerticalScrollbarThumb = True
		      mDraggingHorizontalScrollbarThumb = False
		    ElseIf mHorizontalScrollbar <> Nil And mHorizontalScrollbarThumbBounds.Contains(x, y) Then
		      mDraggingHorizontalScrollbarThumb = True
		      mDraggingVerticalScrollbarThumb = False
		    Else
		      mDraggingHorizontalScrollbarThumb = False
		      mDraggingVerticalScrollbarThumb = False
		    End If
		  #Else
		    mDraggingHorizontalScrollbarThumb = False
		    mDraggingVerticalScrollbarThumb = False
		  #EndIf
		  
		  // Permit the `MouseUp` event to fire.
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(x As Integer, y As Integer)
		  /// The user is dragging the mouse in the editor.
		  
		  // Determine if the mouse has moved and we are actually dragging.
		  If Abs(mLastMouseDownX - X) < 4 And Abs(mLastMouseDownY - Y) < 4 Then Return
		  
		  // Don't ever show the autocomplete popup when dragging.
		  mSuppressAutocompletePopup = True
		  
		  // We need to know if we were dragging last time this event fired so we can decide if we should start 
		  // a new selection or continue from a pre-existing selection.
		  Var wasDragging As Boolean = mDragging
		  
		  // Must be actually dragging the mouse.
		  mDragging = True
		  
		  // Dragging a scrollbar?
		  #If TargetWindows Or TargetLinux
		    Var dragDiffX As Integer = If(mLastMouseDragX = -1, 0, x - mLastMouseDragX)
		    Var dragDiffY As Integer = If(mLastMouseDragY = -1, 0, y - mLastMouseDragY)
		    
		    If mDraggingVerticalScrollbarThumb Then
		      If dragDiffY < 0 Then
		        ScrollUp(-dragDiffY / 2, False, True)
		      ElseIf dragDiffY > 0 Then
		        ScrollDown(dragDiffY / 2, False, True)
		      End If
		      
		    ElseIf mDraggingHorizontalScrollbarThumb Then
		      ScrollPosX = ScrollPosX + dragDiffX
		      Refresh
		    End If
		  #EndIf
		  
		  // Store these coordinates.
		  mLastMouseDragX = x
		  mLastMouseDragY = y
		  
		  // If we're dragging the scrollbar thumb, don't alter selections.
		  If mDraggingHorizontalScrollbarThumb Or mDraggingVerticalScrollbarThumb Then Return
		  
		  // Update the location under the mouse.
		  mLocationUnderMouse = LocationAtXY(x, y)
		  
		  // Move the caret to the drag location but don't redraw yet.
		  If mLocationUnderMouse = Nil Then
		    // Move the caret to the end of the document.
		    MoveCaretToPos(LineManager.LastLine.Finish, False)
		  Else
		    MoveCaretToPos(mLocationUnderMouse.CaretPos, False)
		  End If
		  
		  // Update the selection.
		  If mCurrentSelection = Nil Or Not wasDragging Then
		    // Just started dragging. We need to set the caret position to where the mouse is now because
		    // normally it gets moved on mouse up but in this scenario the mouse has been depressed but not released.
		    If mLocationUnderMouse = Nil Then Return
		    CaretPosition = mLocationUnderMouse.CaretPos + 1
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, CaretPosition, Self)
		  Else
		    If CaretPosition < mCurrentSelection.Anchor Then
		      // Adjust the start of the selection.
		      mCurrentSelection.StartLocation = CaretPosition
		    Else 
		      // Adjust the end of the selection.
		      mCurrentSelection.EndLocation = CaretPosition
		    End If
		  End If
		  
		  NeedsFullRedraw = True
		  Refresh
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  Self.MouseCursor = System.Cursors.IBeam
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(x As Integer, y As Integer)
		  /// The mouse has moved over the canvas.
		  ///
		  /// `x` is the X coordinate of the mouse local to the canvas.
		  /// `y` is the Y coordinate of the mouse local to the canvas.
		  
		  // Update the current location (line number and column) the mouse is over.
		  mLocationUnderMouse = LocationAtXY(x, y)
		  
		  // By default the mouse cursor is an IBeam but we'll change it back to the 
		  // standard pointer if the mouse is to the left of a line (i.e. over the gutter).
		  If Not TargetMacOS And (IsOverHorizontalScrollbar(x, y) Or IsOverVerticalScrollbar(x, y)) Then
		    Self.MouseCursor = System.Cursors.StandardPointer
		  Else
		    If mLocationUnderMouse <> Nil Then
		      If mLocationUnderMouse.ActuallyOverLine = False And mLocationUnderMouse.Column = 0 Then
		        Self.MouseCursor = System.Cursors.StandardPointer
		      Else
		        Self.MouseCursor = System.Cursors.IBeam
		      End If
		    Else
		      Self.MouseCursor = System.Cursors.StandardPointer
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  /// A mouse button has just been released in the editor.
		  
		  mLastMouseDragX = -1
		  mLastMouseDragY = -1
		  
		  If mDraggingHorizontalScrollbarThumb Or mDraggingVerticalScrollbarThumb Then
		    // Must have finished dragging the thumb.
		    mDragging = False
		    mDraggingHorizontalScrollbarThumb = False
		    mDraggingVerticalScrollbarThumb = False
		    Return
		  End If
		  
		  If mDragging Then
		    // Must have finished dragging.
		    mDragging = False
		    Return
		  End If
		  
		  // ========================
		  // RIGHT CLICKS
		  // ========================
		  // If this event was triggered by a right click then bail as right clicks should get handled in 
		  /// the `ConstructContextualMenu` event.
		  If mLastClickWasContextual Then
		    // Disallow double right clicks.
		    mIsDoubleClick = False
		    RaiseEvent DidContextualClick(x, y)
		    Return
		  End If
		  
		  // ========================
		  // DOUBLE AND TRIPLE CLICKS
		  // ========================
		  // Check for a triple click and handle it.
		  If Not IsTripleClick(x,y) Then
		    // Wasn't a triple click. Check for a double click and handle it.
		    If Not IsDoubleClick(x,y) Then
		      // This click was not a double click so clear our flag.
		      mIsDoubleClick = False
		    Else
		      // It was a double click. We're done.
		      Return
		    End If
		  Else
		    // It was a triple click. We're done.
		    Return
		  End If
		  
		  // ==================================
		  // LEFT CLICKED ON A SCROLLBAR TRACK?
		  // ==================================
		  #If TargetWindows Or TargetLinux
		    If IsWithinHorizontalScrollbarTrack(x, y) Then
		      HandleHorizontalScrollbarTrackClick(x, y)
		      Return
		    ElseIf IsWithinVerticalScrollbarTrack(x, y) Then
		      HandleVerticalScrollbarTrackClick(x, y)
		      Return
		    End If
		  #EndIf
		  
		  // ==========================
		  // LEFT CLICKED IN THE CANVAS
		  // ==========================
		  // Clear the current selection.
		  If TextSelected Then CurrentSelection = Nil
		  
		  // Move the caret.
		  If mLocationUnderMouse = Nil Then
		    // Position the caret at the end of the text.
		    MoveCaretToPos(LineManager.LastLine.Finish)
		  Else
		    // Position the caret where the user clicked.
		    MoveCaretToPos(LocationToCaretPos(mLocationUnderMouse))
		  End If
		  
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
		  
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  #If TargetMacOS Then
		    Return True
		  #EndIf
		  
		  Var shouldInvalidate As Boolean = False
		  
		  // =================================
		  // HORIZONTAL SCROLLING
		  // =================================
		  If deltaX <> 0 Then
		    // deltaX reported by Xojo is very small. Beef it up a little.
		    deltaX = deltaX * 5
		    ScrollPosX = ScrollPosX + deltaX
		    shouldInvalidate = True
		  End If
		  
		  // =================================
		  // VERTICAL SCROLLING
		  // =================================
		  Const SLOW_THRESHOLD = 10
		  If deltaY < 0 Then
		    // Scroll up.
		    If AllowInertialScrolling Then
		      If Abs(deltaY) < SLOW_THRESHOLD Then
		        ScrollUp(1, False, True)
		      Else
		        ScrollUp((-deltaY / 10) * VSCROLL_SENSITIVITY, False, True)
		      End If
		    Else
		      // Just scroll up by a fixed line.
		      ScrollUp(1, False, True)
		    End If
		  ElseIf deltaY > 0 Then
		    // Scroll down
		    If AllowInertialScrolling Then
		      If Abs(deltaY) < SLOW_THRESHOLD Then
		        ScrollDown(1, False, True)
		      Else
		        ScrollDown((deltaY / 10) * VSCROLL_SENSITIVITY, False, True)
		      End If
		    Else
		      // Just scroll down by a fixed line.
		      ScrollDown(1, False, True)
		    End If
		  End If
		  
		  If shouldInvalidate Then Refresh
		  
		  // Prevent the event propagating further.
		  Return True
		  
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
		  
		  // =================================
		  // VERTICAL SCROLLING
		  // =================================
		  If ScrollY_ > 0 Then
		    // In order to see all of the lowest most line to be visible, we need to increase `ScrollY_` a bit.
		    Var y As Integer = ScrollY_ + (mLineHeight * 2)
		    mFirstVisibleLine = Floor(y / mLineHeight)
		    mFirstVisibleLine = XUIMaths.Clamp(mFirstVisibleLine, 1, LineManager.LineCount)
		    NeedsFullRedraw = True
		  Else
		    mFirstVisibleLine = 1
		    NeedsFullRedraw = True
		  End If
		  mScrollPosY = ScrollY_
		  
		  // =================================
		  // HORIZONTAL SCROLLING
		  // =================================
		  If ScrollX_ >= 0 Then
		    ScrollPosX = ScrollX_
		  End If
		  
		  Refresh
		End Sub
	#tag EndEvent

	#tag Event , Description = 5468652063616E766173206973206F70656E696E672E
		Sub Opening()
		  /// Sets some reasonable defaults for our computed properties.
		  /// These have to be set in `Open` rather than the constructor because the 
		  /// designer of Xojo was a maniac.
		  VerticalLinePadding = 2
		  
		  // Start on the first line.
		  CaretLineNumber = 1
		  FirstVisibleLine = 1
		  ScrollPosX = 0
		  
		  #If TargetMacOS
		    Me.SetDocumentSize(Me.Width, Me.Height)
		  #EndIf
		  
		  mCurrentUndoID = System.Ticks
		  
		  // Set sensible defaults for the editor's computed properties.
		  mDisplayLineNumbers = True
		  mCaretType = CaretTypes.VerticalBar
		  
		  // Try to default to some sensible monospace typography.
		  // If we can't find the expected font we'll default to "System" which isn't monospace and will cause issues.
		  FontSize = DEFAULT_FONT_SIZE
		  AutocompletePopupFontSize = DEFAULT_AUTOCOMPLETE_POPUP_FONT_SIZE
		  LineNumberFontSize = DEFAULT_LINE_NUMBER_FONT_SIZE
		  #If TargetMacOS Then
		    If XUIFonts.FontAvailable("Menlo") Then
		      FontName = "Menlo"
		      AutocompletePopupFontName = "Menlo"
		    Else
		      FontName = "System"
		      AutocompletePopupFontName = "System"
		    End If
		  #ElseIf TargetWindows Then
		    If XUIFonts.FontAvailable("Consolas") Then
		      FontName = "Consolas"
		      AutocompletePopupFontName = "Consolas"
		    Else
		      FontName = "System"
		      AutocompletePopupFontName = "System"
		    End If
		  #ElseIf TargetLinux Then
		    If XUIFonts.FontAvailable("DejaVu Sans Mono") Then
		      FontName = "DejaVu Sans Mono"
		      AutocompletePopupFontName = "DejaVu Sans Mono"
		    Else
		      FontName = "System"
		      AutocompletePopupFontName = "System"
		    End If
		  #EndIf
		  
		  // Attach the autocomplete popup to the canvas.
		  Self.Window.AddControl(mAutocompletePopup)
		  
		  RegisterForNotifications
		  
		  // Raise our Opening event before we do any drawing (so the user can assign a theme).
		  RaiseEvent Opening
		  
		  RebuildBackBuffer
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Xojo.Rect)
		  #Pragma Unused areas
		  
		  If Me.Theme = Nil Then Return
		  
		  #If TargetWindows
		    // Anti-aliasing needs to be off on Windows.
		    g.AntiAliased = False
		  #EndIf
		  
		  // Cache the scale factors so we can read them from outside this event.
		  mGraphicsScaleX = g.ScaleX
		  mGraphicsScaleY = g.ScaleY
		  
		  // The entire thing needs redrawing if:
		  // 1. The backing buffer dimensions/scale factor are smaller than the canvas.
		  // 2. The control has been marked for a full redraw elsewhere.
		  // 3. The longest line has changed and the buffer is no longer wide enough to 
		  //    contain the longest line in its entirety.
		  If NeedsFullRedraw Or mBackBuffer = Nil Or _
		    mBackBuffer.Graphics.Width < g.Width Or _ 
		    mBackBuffer.Graphics.Height < g.Height Then
		    RebuildBackBuffer
		    
		  ElseIf LongestLineChanged Then
		    LongestLineChanged = False
		    If mBackBuffer.Graphics.Width < mCachedRequiredBufferWidth Then
		      RebuildBackBuffer
		    Else
		      // The longest line has changed but the buffer is wide enough. 
		      // We only need to redraw the dirty lines.
		      RedrawDirtyLines
		    End If
		    
		  Else
		    // We only need to draw the dirty lines.
		    RedrawDirtyLines
		  End If
		  
		  // Draw the back buffer to the screen.
		  g.DrawPicture(mBackBuffer, -ScrollPosX, 0)
		  
		  // Borders?
		  DrawBorders(g)
		  
		  // On macOS we need to update the document size to get fancy scrollbars.
		  #If TargetMacOS
		    SetDocumentSize(mBackBuffer.Graphics.Width, LineManager.LineCount * mLineHeight)
		  #EndIf
		  
		  // Draw the scrollbars if needed on Windows and Linux.
		  #If TargetWindows Or TargetLinux
		    If mVerticalScrollbar <> Nil Then
		      g.DrawPicture(mVerticalScrollbar, g.Width - mVerticalScrollbar.Graphics.Width, 0)
		    End If
		    If mHorizontalScrollbar <> Nil Then
		      g.DrawPicture(mHorizontalScrollbar, 0, g.Height - mHorizontalScrollbar.Graphics.Height)
		    End If
		  #EndIf
		  
		  // Handle the autocomplete popup.
		  If AutocompleteData <> Nil And Not mSuppressAutocompletePopup Then
		    If mHasFocus Then ShowAutocompletePopup
		  Else
		    HideAutocompletePopup(mHasFocus)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function RectForRange(ByRef range As TextRange) As Xojo.Rect
		  /// Return a range for macOS to display the character picker.
		  ///
		  /// I'm being lazy here and returning an arbitrary width and height because for our purposes we are only
		  /// interested in the popup being positioned at the correct location. This will likely mean that I'm not fully
		  /// supporting advanced uses of this event but since I don't actually understand the event, that's OK by me.
		  
		  #Pragma Unused range
		  
		  Var x, y As Double
		  XYAtCaretPos(CaretPosition, x, y)
		  Return New Rect(x, y, 20, 20) // 20, 20 is arbitrary.
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub ScaleFactorChanged(newScaleFactor as Double)
		  /// The canvas has moved onto a monitor with a different scale factor.
		  
		  #Pragma Unused newScaleFactor
		  
		  RebuildBackBuffer
		  RebuildScrollbars
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 41636365707473207468652063757272656E746C792073656C65637465642073756767657374696F6E20696E207468652073756767657374696F6E7320706F7075702E
		Sub AcceptCurrentAutocompleteOption()
		  /// Accepts the currently selected option in the autocomplete popup.
		  
		  // Sanity checks.
		  If AutoCompleteData = Nil Then Return
		  If mAutocompletePopup.SelectedIndex < 0 Or _
		    mAutocompletePopup.SelectedIndex > AutoCompleteData.Options.LastIndex Then
		    Return
		  End If
		  
		  // Get the value of the suggestion to insert.
		  Var value As String = AutoCompleteData.Options(mAutocompletePopup.SelectedIndex).Value
		  
		  // We need to remove the prefix that's already been typed from the value.
		  value = value.Replace(AutoCompleteData.Prefix, "")
		  
		  Insert(value, CaretPosition, True)
		  
		  mSuppressAutocompletePopup = True
		  HideAutocompletePopup
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620746865726520617265206175746F636F6D706C6574696F6E206F7074696F6E7320617661696C61626C65206174207468652063757272656E7420636172657420706F736974696F6E2E
		Function AutocompleteOptionsAvailable() As Boolean
		  /// True if there are autocompletion options available at the current caret position.
		  
		  Return AllowAutocomplete And AutocompleteData <> Nil And AutocompleteData.Options.Count > 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54727565206966207468652063617265742069732061742074686520656E64206F66207468652063757272656E74206C696E652E
		Private Function CaretAtCurrentLineEnd() As Boolean
		  /// True if the caret is at the end of the current line.
		  
		  Return CaretPosition = CurrentLine.Finish
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 546F67676C657320746865207669736962696C697479206F66207468652063617265742E2043616C6C656420627920606D4361726574426C696E6B65722E416374696F6E602E
		Private Sub CaretBlinkerAction(caretBlinker As Timer)
		  /// Toggles the visibility of the caret. Called by `mCaretBlinker.Action`.
		  
		  #Pragma Unused caretBlinker
		  
		  // The caret is hidden if there is selected text or the editor is read-only.
		  If mCurrentSelection <> Nil Or Me.ReadOnly Then
		    mCaretVisible = False
		  Else
		    If BlinkCaret Then
		      mCaretVisible = Not mCaretVisible
		    Else
		      // Always keep the caret visible.
		      mCaretVisible = True
		    End If
		  End If
		  
		  // Redraw the canvas.
		  Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662074686520746F6B656E206174207468652063757272656E7420636172657420706F736974696F6E206973206120636F6D6D656E742E
		Private Function CaretIsInComment() As Boolean
		  /// Returns True if the token at the current caret position is a comment.
		  
		  Var tokenAtCaret As XUICELineToken = CurrentLine.TokenAtColumn(CaretColumn - 1)
		  If tokenAtCaret <> Nil Then
		    Return Formatter.TokenIsComment(tokenAtCaret)
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C656172732074686520636F6E74656E7473206F662074686520656469746F722E
		Sub Clear()
		  /// Clears the contents of the editor.
		  
		  Me.SelectAll
		  Me.DeleteSelection(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662061206C696E652069732063757272656E746C79206265696E6720686967686C69676874656420666F7220646562756767696E672069742077696C6C206E6F206C6F6E67657220626520686967686C6967687465642074686973207761792E
		Sub ClearDebuggingLine()
		  /// If a line is currently being highlighted for debugging it will no longer be highlighted this way.
		  
		  DebuggingLine = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70757465732074686520776964746820696E20706978656C73206F662074686520677574746572207573696E67207468652070617373656420606C696E654E756D6265725769647468602E
		Private Function ComputeGutterWidth(lineNumberWidth As Double) As Double
		  /// Computes the width in pixels of the gutter using the passed `lineNumberWidth`.
		  
		  // Gutter structure:
		  //
		  // ```no-highlight
		  // ________________
		  // |           |  |
		  // |           |  |
		  // ----------------
		  //   ↑          ↑  
		  //  LNW         BG
		  // ```
		  //
		  // _LNW (Line number width)_: The width of the rectangle containing the line number.
		  //
		  // _BG (Block gutter min width)_: The minimal width of the gutter containing 
		  //                            the block indicators. This is variable but must be a minimal width.
		  
		  Return lineNumberWidth + BLOCK_GUTTER_MIN_WIDTH
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor()
		  /// Default constructor.
		  
		  Super.Constructor
		  
		  Self.LineManager = New XUICELineManager(Self)
		  
		  CaretData = New XUICECaretData("", Nil)
		  
		  // Initialise the caret blinker timer.
		  mCaretBlinker = New Timer
		  mCaretBlinker.RunMode = Timer.RunModes.Multiple
		  mCaretBlinker.Period = CARET_BLINK_PERIOD
		  AddHandler mCaretBlinker.Action, AddressOf CaretBlinkerAction
		  
		  // Initialise the delimiter highlighter timer.
		  mDelimiterTimer = New Timer
		  mDelimiterTimer.RunMode = Timer.RunModes.Multiple
		  mDelimiterTimer.Period = DELIMITER_TIMER_PERIOD
		  AddHandler mDelimiterTimer.Action, AddressOf DelimiterTimerAction
		  
		  // Initialise the parsing timer.
		  mParseTimer = New Timer
		  mParseTimer.RunMode = Timer.RunModes.Multiple
		  mParseTimer.Period = PARSE_TIMER_PERIOD
		  AddHandler mParseTimer.Action, AddressOf ParseTimerAction
		  
		  // Initialise the autocomplete popup.
		  AutocompleteData = Nil
		  mAutocompletePopup = New XUICodeEditorAutocompletePopup(Self)
		  mAutocompletePopup.Visible = False
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526169736573207468697320656469746F7227732060436F6E74656E74734469644368616E676560206576656E742E
		Sub ContentsDidChange()
		  /// Raises this editor's `ContentsDidChange` event.
		  
		  RaiseEvent ContentsDidChange
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C657465732074686520636861726163746572206265666F72652074686520636172657420616E6420696E76616C696461746573207468652063616E7661732E
		Sub DeleteBackward(allowUndo As Boolean, raiseContentsDidChange As Boolean = True)
		  /// Deletes the character before the caret and invalidates the canvas.
		  ///
		  /// If `allowUndo` is True then this action will be undoable.
		  /// If `raiseContentsDidChange` is True then we will also raise the `ContentsDidChange` event.
		  /// By default, `ContentsDidChange` is raised but sometimes (e.g. when this method is called internally
		  /// by other methods) we don't.
		  
		  CurrentUndoID = System.Ticks
		  
		  // =======================================================================
		  // If there is a text selection then we just need to delete the selection.
		  // =======================================================================
		  If TextSelected Then
		    LineManager.DeleteSelection(allowUndo, True, raiseContentsDidChange)
		    Return
		  End If
		  
		  // Nothing to do if we're at the start of the document.
		  If CaretPosition = 0 Then Return
		  
		  // ==================================================
		  // The caret is at the beginning of the current line.
		  // ==================================================
		  If CaretPosition = CurrentLine.Start Then
		    If allowUndo And UndoManager <> Nil  Then
		      Var action As New XUICEUndoableDelete(Self, CurrentUndoID, "Delete", &u0A, _
		      New XUICETextSelection(CaretPosition - 1, CaretPosition - 1, CaretPosition, Self))
		      UndoManager.Push(action)
		    End If
		    
		    // Append the contents of the current line to the line above.
		    Var prevLine As XUICELine = LineManager.LineAt(CurrentLine.Number - 1)
		    prevLine.SetContents(prevLine.Contents + CurrentLine.Contents, False)
		    
		    // Delete the current line and adjust subsequent offsets by -1.
		    LineManager.DeleteLineAt(CurrentLine.Number, -1)
		    
		    LineManager.TokeniseAllLines
		    
		    // Move the caret to the previous end position of what was the previous line.
		    CaretPosition = CaretPosition - 1
		    
		    // Always redraw the whole canvas when we delete a line.
		    NeedsFullRedraw = True
		    
		    ScrollToCaretPos(True)
		    If raiseContentsDidChange Then RaiseEvent ContentsDidChange
		    Return
		  End If
		  
		  // ==========================================================
		  // The caret is at the end of this line.
		  // ==========================================================
		  If CaretPosition = CurrentLine.Finish Then
		    // Pop the last character from this line.
		    Var charToDelete As String = CurrentLine.PopCharacters(1, False)
		    
		    If allowUndo And UndoManager <> Nil Then
		      Var action As New XUICEUndoableDelete(Self, CurrentUndoID, "Delete", charToDelete, _
		      New XUICETextSelection(CaretPosition - 1, CaretPosition - 1, CaretPosition, Self))
		      UndoManager.Push(action)
		    End If
		    
		    // Adjust the offsets of the subsequent lines by the one character we've deleted.
		    LineManager.AdjustLineOffsets(CurrentLine.Number + 1, -1, 0)
		    
		    LineManager.TokeniseAllLines
		    
		    // Move the caret back one position.
		    CaretPosition = CaretPosition - 1
		    
		    ScrollToCaretPos(True)
		    If raiseContentsDidChange Then RaiseEvent ContentsDidChange
		    Return
		  End If
		  
		  // ==========================================================
		  // The caret is in the middle of the current line.
		  // ==========================================================
		  If CaretPosition <> CurrentLine.Start Then
		    If allowUndo And UndoManager <> Nil Then
		      Var action As New XUICEUndoableDelete(Self, CurrentUndoID, "Delete", _
		      CurrentLine.CharactersFromCaretPos(CaretPosition - 1, 1), _
		      New XUICETextSelection(CaretPosition - 1, CaretPosition - 1, CaretPosition, Self))
		      UndoManager.Push(action)
		    End If
		    
		    // Remove the character from this line.
		    CurrentLine.DeleteCharacterAtCaretPos(CaretPosition - 1, False)
		    
		    // Adjust the offsets of the subsequent lines by the one character we've deleted.
		    LineManager.AdjustLineOffsets(CurrentLine.Number + 1, -1, 0)
		    
		    LineManager.TokeniseAllLines
		    
		    // Move the caret back one position.
		    CaretPosition = CaretPosition - 1
		    
		    ScrollToCaretPos(True)
		    If raiseContentsDidChange Then RaiseEvent ContentsDidChange
		    Return
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C65746573207468652063686172616374657220696D6D6564696174656C7920696E2066726F6E74206F662074686520636172657420616E6420696E76616C696461746573207468652063616E7661732E
		Sub DeleteForward(allowUndo As Boolean, raiseContentsDidChange As Boolean = True)
		  /// Deletes the character immediately in front of the caret and invalidates the canvas.
		  ///
		  /// If `allowUndo` is True then this action will be undoable.
		  /// If `raiseContentsDidChange` is True then we will also raise the `ContentsDidChange` event.
		  /// By default, `ContentsDidChange` is raised but sometimes (e.g. when this method is called internally
		  /// by other methods) we don't.
		  
		  CurrentUndoID = System.Ticks
		  
		  // =======================================================================
		  // If there is a text selection then we just need to delete the selection.
		  // =======================================================================
		  If TextSelected Then
		    LineManager.DeleteSelection(allowUndo, True, raiseContentsDidChange)
		    Return
		  End If
		  
		  // Nothing to do if the caret is at the end of the document.
		  If CaretPosition = LineManager.LastLine.Finish Then Return
		  
		  // ======================================================
		  // Easy case - the caret is not at the end of the line.
		  // ======================================================
		  If CaretPosition <> CurrentLine.Finish Then
		    If allowUndo And UndoManager <> Nil  Then
		      Var action As New XUICEUndoableDelete(Self, CurrentUndoID, "Delete", _
		      CurrentLine.CharactersFromCaretPos(CaretPosition, 1), _
		      New XUICETextSelection(CaretPosition, CaretPosition, CaretPosition + 1, Self))
		      UndoManager.Push(action)
		    End If
		    
		    CurrentLine.DeleteCharacterAtCaretPos(CaretPosition)
		    
		    // Adjust the offsets of the subsequent lines by the one character we've deleted.
		    LineManager.AdjustLineOffsets(CurrentLine.Number + 1, -1, 0)
		    
		    ScrollToCaretPos(True)
		    If raiseContentsDidChange Then RaiseEvent ContentsDidChange
		    Return
		  End If
		  
		  // ====================================
		  // The caret is at the end of the line.
		  // ====================================
		  If allowUndo And UndoManager <> Nil  Then
		    Var action As New XUICEUndoableDelete(Self, CurrentUndoID, "Delete", &u0A, _
		    New XUICETextSelection(CaretPosition, CaretPosition, CaretPosition + 1, Self))
		    UndoManager.Push(action)
		  End If
		  
		  // Append the contents of the next line to the current line.
		  Var nextLine As XUICELine = LineManager.LineAt(CurrentLine.Number + 1)
		  CurrentLine.SetContents(CurrentLine.Contents + nextLine.Contents)
		  
		  // Delete the line below the current line and adjust subsequent offsets by the 
		  // length of the line appended.
		  LineManager.DeleteLineAt(CurrentLine.Number + 1, -nextLine.Length)
		  
		  // Always redraw the whole canvas when we delete a line.
		  NeedsFullRedraw = True
		  
		  ScrollToCaretPos(True)
		  If raiseContentsDidChange Then RaiseEvent ContentsDidChange
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C65746573207468652063757272656E742073656C656374696F6E2E
		Sub DeleteSelection(allowUndo As Boolean, shouldInvalidate As Boolean = True, raiseContentsDidChange As Boolean = True, undoMessage As String = "")
		  /// Deletes the current selection.
		  ///
		  /// If `allowUndo` is True then this action will be pushed to the undo manager.
		  /// If `shouldInvalidate` is True then the canvas will immediately invalidate.
		  /// If `raiseContentsDidChange` is True then we will raise the `ContentsDidChange` event.
		  /// `undoMessage` is an optional override message for undoable actions.
		  
		  CurrentUndoID = System.Ticks
		  
		  undoMessage = If(undoMessage = "", "Delete Selection", undoMessage)
		  
		  // If there is a text selection then we just need to delete the selection.
		  If TextSelected Then
		    LineManager.DeleteSelection(allowUndo, False, raiseContentsDidChange, undoMessage)
		    ScrollToCaretPos
		    If shouldInvalidate Then Refresh
		    If raiseContentsDidChange Then RaiseEvent ContentsDidChange
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320746865206E6561726573742064656C696D697465727320746F2074686520636172657420706572696F646963616C6C792E2043616C6C656420627920606D44656C696D6974657254696D65722E416374696F6E602E
		Private Sub DelimiterTimerAction(delimiterTimer As Timer)
		  /// Updates the nearest delimiters to the caret periodically. Called by `mDelimiterTimer.Action`.
		  
		  #Pragma Unused delimiterTimer
		  
		  If Not HighlightDelimitersAroundCaret Then Return
		  
		  If LineManager <> Nil Then
		    LineManager.UpdateNearestDelimiters(CaretPosition)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652073697A65206F662074686520656E7469726520636F6E74656E7473206172656120696E20706978656C732E
		Function DocumentSize() As Rect
		  /// Returns the size of the entire contents area in pixels.
		  
		  Return New Rect(0, 0, RequiredBufferWidth, LineManager.LineCount * mLineHeight)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 447261777320616E7920656E61626C656420626F72646572732E
		Private Sub DrawBorders(g As Graphics)
		  /// Draws any enabled borders.
		  
		  g.DrawingColor = BorderColor
		  g.PenSize = 1
		  
		  If HasTopBorder Then
		    g.DrawLine(0, 0, g.Width, 0)
		  End If
		  
		  If HasBottomBorder Then
		    g.DrawLine(0, g.Height - 1, g.Width, g.Height - 1)
		  End If
		  
		  If HasLeftBorder Then
		    g.DrawLine(0, 0, 0, g.Height)
		  End If
		  
		  If HasRightBorder Then
		    g.DrawLine(g.Width - 1, 0, g.Width - 1, g.Height)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265717565737473206175746F636F6D706C657465206461746120666F722074686520776F726420696D6D6564696174656C7920696E2066726F6E74206F66207468652063617265742E
		Private Sub FetchAutocompleteData()
		  /// Requests autocomplete data for the word immediately in front of the caret.
		  
		  mSuppressAutocompletePopup = True
		  
		  // Clear out any existing autocomplete data.
		  AutocompleteData = Nil
		  
		  // Quick exit if autocompletion disabled.
		  If Not AllowAutocomplete Then Return
		  
		  // Sanity check.
		  If CurrentLine = Nil Then Return
		  
		  // Disable autocomplete in comments if that's the behaviour the user wants.
		  If Not AllowAutoCompleteInComments And CaretIsInComment Then Return
		  
		  // Get the word up to the caret. This is our prefix.
		  Var prefix As String = CurrentLine.WordToColumn(CaretColumn)
		  
		  // If there is no word up to the caret then there will be no suggestions.
		  If prefix = "" Then Return
		  
		  // Is the prefix long enough to trigger autocompletion?
		  If prefix.Length < MinimumAutocompletionLength Then Return
		  
		  // Now we know the prefix, request the autocompletion data.
		  AutocompleteData = AutocompleteDataForPrefix(prefix, CaretLineNumber, CaretColumn)
		  
		  If AutoCompleteData <> Nil And AutocompleteData.Options.Count = 0 Then
		    // The autocomplete engine has no options for the user.
		    AutocompleteData = Nil
		    
		  ElseIf AutocompleteData <> Nil Then
		    // Make sure that the autocomplete data has the correct prefix assigned.
		    AutocompleteData.Prefix = prefix
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ForceRedraw()
		  /// Immediately redraws the canvas.
		  
		  NeedsFullRedraw = True
		  
		  Self.Refresh(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206E756D626572206F66207469636B7320746861742074776F20636C69636B73206D757374206F636375722077697468696E20746F20626520636F6E73696465726564206120646F75626C6520636C69636B2E
		Private Function GetDoubleClickTimeTicks() As Integer
		  /// Returns the number of ticks that two clicks must occur within to be considered a double click.
		  
		  // Choose a reasonable default in case any of the declares fail.
		  Const DEFAULT_TICKS = 30 // 30 ticks = 500ms
		  
		  Var doubleClickTime As Integer
		  
		  #If TargetMacOS
		    Const CocoaLib As String = "Cocoa.framework"
		    Declare Function NSClassFromString Lib CocoaLib(aClassName As CFStringRef) As Ptr
		    Declare Function doubleClickInterval Lib CocoaLib Selector "doubleClickInterval" (aClass As Ptr) As Double
		    Try
		      Var RefToClass As Ptr = NSClassFromString("NSEvent")
		      doubleClickTime = doubleClickInterval(RefToClass) * 60
		    Catch err As ObjCException
		      doubleClickTime = DEFAULT_TICKS
		    End Try
		  #EndIf
		  
		  #If TargetWindows Then
		    Try
		      Declare Function GetDoubleClickTime Lib "User32.DLL" () As Integer
		      doubleClickTime = GetDoubleClickTime()
		      // `doubleClickTime` now holds the number of milliseconds - convert to ticks.
		      doubleClickTime = doubleClickTime / 1000.0 * 60
		    Catch e
		      doubleClickTime = DEFAULT_TICKS
		    End Try
		  #EndIf
		  
		  #If TargetLinux Then
		    Const libname = "libgtk-3"
		    Soft Declare Function gtk_settings_get_default Lib libname () As Ptr
		    Soft Declare Sub g_object_get Lib libname (Obj As Ptr, first_property_name As CString, ByRef doubleClicktime As Integer, Null As Integer)
		    If Not system.IsFunctionAvailable ("gtk_settings_get_default", libname) Then
		      doubleClickTime = DEFAULT_TICKS
		    Else
		      Var gtkSettings As Ptr = gtk_settings_get_default()
		      g_object_get (gtkSettings, "gtk-double-click-time", doubleClickTime, 0)
		      // `doubleClickTime` now holds the number of milliseconds - convert to ticks.
		      doubleClickTime = doubleClickTime / 1000.0 * 60
		    End If
		  #EndIf
		  
		  // Catch any other platforms.
		  If doubleClickTime <= 0 Then
		    doubleClickTime = DEFAULT_TICKS
		  End If
		  
		  Return doubleClickTime
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C657320746865207072657373696E67206F6620746865206175746F636F6D706C657465206B65792E
		Private Sub HandleAutocompleteKeyPress()
		  /// Handles the pressing of the autocomplete key.
		  
		  // Firstly assume we won't have to show the autocomplete popup.
		  mSuppressAutocompletePopup = True
		  
		  // Bail early if there are no autocomplete suggestions available.
		  If AutoCompleteData = Nil Or AutocompleteData.Options.Count = 0 Then
		    Refresh
		    Return
		  End If
		  
		  If CaretAtCurrentLineEnd And AutoCompleteData.Options.Count = 1 Then
		    // Insert the only option at the caret position.
		    Insert(AutoCompleteData.LongestCommonPrefix, CaretPosition, True)
		    
		  ElseIf CaretAtCurrentLineEnd And AutoCompleteData.LongestCommonPrefix <> "" Then
		    // At the end of the line but there are multiple options available.
		    // Insert the longest common prefix and fetch additional autocomplete data.
		    Insert(AutoCompleteData.LongestCommonPrefix, CaretPosition, True)
		    FetchAutocompleteData
		    mSuppressAutocompletePopup = False
		    
		  Else
		    // There are suggestions available that require the autocomplete popup.
		    mSuppressAutocompletePopup = False
		    Refresh
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C657320746865207072657373696E67206F6620746865204374726C2B5370616365206B657920636F6D62696E6174696F6E2E
		Private Sub HandleCtrlSpace()
		  /// Handles the pressing of the Ctrl+Space key combination.
		  
		  If AutocompleteCombo = AutocompleteCombos.CtrlSpace Then
		    HandleAutocompleteKeyPress
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C6573206120646F75626C6520636C69636B206F6363757272696E672061742074686520706173736564206078602C20607960206D6F75736520636F6F7264696E617465732E
		Private Sub HandleDoubleClick(x As Integer, y As Integer)
		  /// Handles a double click occurring at the passed `x`, `y` mouse coordinates.
		  ///
		  /// 1. Double-clicking when not over a line highlights the last word of the last line.
		  /// 2. Double-clicking at the end of a line highlights the last word of that line.
		  /// 3. Double-clicking on whitespace highlights the run of whitespace.
		  /// 4. Double-clicking on a non-alphanumeric character highlights the character.
		  /// 5. Double-clicking within an alphanumeric word selects the word.
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  // Edge case 1: No text in the canvas.
		  If LineManager.IsEmpty Then Return
		  
		  // ============================================================================
		  // 1. Double-clicked not over a line. Highlight the last word of the last line.
		  // ============================================================================
		  If mLocationUnderMouse = Nil Then
		    // Highlight the last word of the last line.
		    Var line As XUICELine = LineManager.LastLine
		    
		    // Move the caret to the end of the line but don't redraw yet.
		    MoveCaretToPos(line.Finish, False)
		    
		    // Select the previous word and redraw.
		    mCurrentSelection = Nil
		    MoveWordLeftAndModifySelection
		    Return
		  End If
		  
		  // Edge case 2: The line under the mouse is empty. In this case we simply
		  // move the caret to that line but select nothing.
		  If mLocationUnderMouse.Line.IsEmpty Then
		    mCurrentSelection = Nil
		    MoveCaretToPos(mLocationUnderMouse.Line.Start)
		    Return
		  End If
		  
		  // ==============================================================================
		  // 2. Double-clicking at the end of a line highlights the last word of that line.
		  // ==============================================================================
		  If mLocationUnderMouse.Column = mLocationUnderMouse.Line.Length Then
		    Var line As XUICELine = mLocationUnderMouse.Line
		    Var lastChar As String = line.Right(1)
		    If lastChar = " " Then
		      MoveCaretToPos(line.Finish, False)
		      // If the last caret is whitespace then select all whitespace at the end of the line.
		      SelectWhitespaceAroundCaret(True)
		      Return
		      
		    ElseIf Not lastChar.IsLetterOrDigit Then
		      // The last character is punctuation - just select it.
		      mCurrentSelection = New XUICETextSelection(line.Finish, line.Finish - 1, line.Finish, Self)
		      // We will need a full redraw.
		      NeedsFullRedraw = True
		      // Move the caret to the penultimate position in the line.
		      MoveCaretToPos(line.Finish - 1)
		      Return
		      
		    Else
		      // First move the caret to the end of the line but don't redraw yet.
		      MoveCaretToPos(line.Finish, False)
		      // Select the last word.
		      mCurrentSelection = Nil
		      MoveWordLeftAndModifySelection
		      Return
		    End If
		  End If
		  
		  // The user has clicked somewhere actually on the line.
		  // Position the caret where the user clicked but don't redraw yet.
		  MoveCaretToPos(LocationToCaretPos(mLocationUnderMouse), False)
		  ScrollToCaretPos(False)
		  
		  // Get the character at the caret.
		  Var currentChar As String = mCurrentLine.CharactersFromColumn(CaretColumn, 1)
		  
		  // ==================================================================
		  // 3. Double-clicking on whitespace highlights the run of whitespace.
		  // ==================================================================
		  If currentChar = " " Then
		    SelectWhitespaceAroundCaret(True)
		    Return
		  End If
		  
		  // ============================================================================
		  // 4. Double-clicking on a non-alphanumeric character highlights the character.
		  // ============================================================================
		  If Not currentChar.IsLetterOrDigit Then
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, CaretPosition + 1, Self)
		    NeedsFullRedraw = True
		    Refresh
		    Return
		  End If
		  
		  // ================================================================
		  // 5. Double-clicking within an alphanumeric word selects the word.
		  // ================================================================
		  SelectWordAtCaret(True)
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 48616E646C657320616E20457363206B6579207072657373206174207468652063757272656E7420636172657420706F736974696F6E2E
		Sub HandleEscKey(shouldInvalidate As Boolean = True)
		  /// Handles an Esc key press at the current caret position.
		  
		  If shouldInvalidate Then Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C6573206120636C69636B20696E2074686520686F72697A6F6E74616C207363726F6C6C62617220747261636B2E
		Private Sub HandleHorizontalScrollbarTrackClick(x As Integer, y As Integer)
		  /// Handles a click in the horizontal scrollbar track.
		  ///
		  /// Assumes the click location has been verified prior to this with a call to `IsWithinHorizontalScrollbarTrack()`.
		  /// We mimic Window's behaviour so if we left of the thumb we move the thumb up so its left edge is 
		  /// positioned at the mouse click. If we click to the right of the thumb we move the thumb rightwards so 
		  /// its right edge is positioned at the mouse click.
		  /// Only valid on Windows and Linux.
		  
		  #Pragma Unused y
		  
		  // Compute the maximum permissible X scroll position.
		  Var maxScrollPosX As Integer = Max(mCachedRequiredBufferWidth - Width, 0)
		  
		  Var minX As Integer = SCROLLBAR_THUMB_PADDING
		  Var maxX As Integer = _
		  mHorizontalScrollbar.Graphics.Width - mHorizontalScrollbarThumbBounds.Width - SCROLLBAR_THUMB_PADDING
		  
		  If x <= mHorizontalScrollbarThumbBounds.Left Then
		    // Clicked to the left of the thumb.
		    ScrollPosX = (x / (maxX - minX)) * maxScrollPosX
		  Else
		    // Clicked to the right of the thumb.
		    ScrollPosX = ((x - mHorizontalScrollbarThumbBounds.Width) / (maxX - minX)) * maxScrollPosX
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 48616E646C657320612052657475726E206B6579207072657373206174207468652063757272656E7420636172657420706F736974696F6E2E
		Sub HandleReturnKey(allowUndo As Boolean, raiseContentsDidChange As Boolean = True)
		  /// Handles a Return key press at the current caret position.
		  ///
		  /// If `allowUndo` is True then this action will be undoable.
		  /// If `raiseContentsDidChange` is True then we will raise the `ContentsDidChange` event.
		  ///
		  /// Three Scenarios: 
		  ///
		  /// 1. The caret is at the end of the line (blank line inserted below with caret at its start).
		  /// 2. The caret is at the beginning of the line (blank line inserted above with caret at start of this line).
		  /// 3. The caret is in the middle of the line (line is broken and caret is placed at start of new line below).
		  ///
		  /// We then need to scroll to the current caret position.
		  
		  // Ending a line starts a new undoable event block.
		  CurrentUndoID = System.Ticks
		  
		  // If there's a current selection, delete that first.
		  If TextSelected Then
		    LineManager.DeleteSelection(allowUndo, False)
		  End If
		  
		  // ==========================================================
		  // The caret is at the end of a line.
		  // ==========================================================
		  If CaretPosition = mCurrentLine.Finish Then
		    // Insert a new line after the current line.
		    Var newline As XUICELine = LineManager.InsertLineAt(CaretLineNumber + 1, "")
		    
		    If allowUndo And UndoManager <> Nil  Then
		      UndoManager.Push(New XUICEUndoableInsertLine(Self, CurrentUndoID, "Insert Newline", _
		      CaretLineNumber + 1, CaretPosition, ""))
		    End If
		    
		    // Move the caret to the beginning of the new line.
		    CaretPosition = newline.Start
		    
		    // ==========================================================
		    // The caret is at the beginning of a line.
		    // ==========================================================
		  ElseIf CaretPosition = mCurrentLine.Start Then
		    // Insert a new line above the current line.
		    Call LineManager.InsertLineAt(CaretLineNumber, "", 0)
		    
		    If allowUndo And UndoManager <> Nil  Then
		      UndoManager.Push(New XUICEUndoableInsertLine(Self, CurrentUndoID, "Insert Newline", _
		      CaretLineNumber - 1, CaretPosition, ""))
		    End If
		    
		    // Move the caret to the beginning of the current line.
		    CaretPosition = mCurrentLine.Start
		    
		    // ==========================================================
		    // The caret is in the middle of a line.
		    // ==========================================================
		  Else
		    // Break the line at the current caret position.
		    If allowUndo And UndoManager <> Nil Then
		      UndoManager.Push(_
		      New XUICEUndoableInsertLineBreak(Self, CurrentUndoID, "Insert Line Break", CaretPosition))
		    End If
		    
		    // How many characters will be deleted from this line?
		    Var delCount As Integer = mCurrentLine.Finish - CaretPosition - 1
		    
		    // Chop the contents of the current line after the caret.
		    Var newLineContents As String = mCurrentLine.ChopCharactersFrom(CaretColumn, False)
		    
		    // Add a newline after the current line containing the chopped characters.
		    Var newLine As XUICELine = LineManager.InsertLineAt(CaretLineNumber + 1, newLineContents, -delCount)
		    
		    // Move the caret to the beginning of the new line.
		    CaretPosition = newline.Start
		  End If
		  
		  ScrollToCaretPos
		  If raiseContentsDidChange Then RaiseEvent ContentsDidChange
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C6573206120747269706C6520636C69636B206F6363757272696E672061742074686520706173736564206078602C20607960206D6F75736520636F6F7264696E617465732E2053656C6563747320746865206C696E6520756E6465722074686520636C69636B2E
		Private Sub HandleTripleClick(x As Integer, y As Integer)
		  /// Handles a triple click occurring at the passed `x`, `y` mouse coordinates.
		  /// Selects the line under the click.
		  ///
		  /// This will always occur after a double click so `HandleDoubleClick` will 
		  /// have been called prior to this method.
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  // Edge case: No text in the canvas.
		  If LineManager.IsEmpty Then Return
		  
		  // Get the line to select.
		  Var line As XUICELine
		  If mLocationUnderMouse = Nil Then
		    // Triple clicking when not over a line selects the last line.
		    line = LineManager.LastLine
		  Else
		    // Select the line under the mouse.
		    line = mLocationUnderMouse.Line
		  End If
		  
		  // Select the whole line.
		  mCurrentSelection = New XUICETextSelection(line.Start, line.Start, line.Finish, Self)
		  
		  // Force a full redraw.
		  NeedsFullRedraw = True
		  
		  // Set the caret to the start of the line selected.
		  MoveCaretToPos(mCurrentSelection.StartLocation)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C6573206120636C69636B20696E2074686520766572746963616C207363726F6C6C62617220747261636B2E
		Private Sub HandleVerticalScrollbarTrackClick(x As Integer, y As Integer)
		  /// Handles a click in the vertical scrollbar track.
		  ///
		  /// Assumes the click location has been verified prior to this with a call to `IsWithinVerticalScrollbarTrack()`.
		  /// We mimic Window's behaviour so if we click above the thumb we move the thumb up so its top is 
		  /// positioned at the mouse click. If we click below the thumb we move the thumb down so its bottom is
		  /// positioned at the mouse click.
		  /// Only valid on Windows and Linux.
		  
		  #Pragma Unused x
		  
		  If y <= mVerticalScrollbarThumbBounds.Top Then
		    // Clicked above the thumb.
		    FirstVisibleLine = _
		    (y / (mVerticalScrollbar.Graphics.Height - (SCROLLBAR_THUMB_PADDING * 2))) * LineManager.LineCount
		  Else
		    // Clicked below the thumb.
		    FirstVisibleLine = _
		    ((y - mVerticalScrollbarThumbBounds.Height ) / (mVerticalScrollbar.Graphics.Height - (SCROLLBAR_THUMB_PADDING * 2))) * LineManager.LineCount
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 486964657320746865206175746F636F6D706C65746520706F7075702E
		Private Sub HideAutocompletePopup(shouldSetFocus As Boolean = True)
		  /// Hides the autocomplete popup.
		  
		  mAutocompletePopup.Visible = False
		  mAutocompletePopup.ScrollPosY = 0
		  mAutocompletePopup.SelectedIndex = 0
		  
		  If shouldSetFocus Then Self.SetFocus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E736572747320607360206174207468652073706563696669656420636172657420706F736974696F6E2E
		Sub Insert(s As String, pos As Integer, allowUndo As Boolean, shouldInvalidate As Boolean = True, raiseContentsDidChange As Boolean = True)
		  /// Inserts `s` at the specified caret position.
		  ///
		  /// If `allowUndo` is True then this action will be undoable.
		  /// If `raiseContentsDidChange` then we will also raise the `ContentsDidChange` event.
		  
		  CurrentUndoID = System.Ticks
		  
		  // Clear any text selection.
		  mCurrentSelection = Nil
		  
		  // Any newlines present in the text will be replaced with Unix ones (&u0A).
		  s = s.ReplaceLineEndings(&u0A)
		  
		  // Sanity check.
		  If pos < 0 Or pos > LineManager.LastLine.Finish Then
		    Raise New InvalidArgumentException("The chosen insertion position is out of bounds")
		  End If
		  
		  // Are we just inserting a simple single character (not a newline)?
		  If s.CharacterCount = 1 And s <> &u0A Then
		    LineManager.InsertCharacter(pos, s, allowUndo, raiseContentsDidChange)
		  Else
		    LineManager.InsertText(pos, s, allowUndo, shouldInvalidate, raiseContentsDidChange)
		  End If
		  
		  // Scroll the canvas as necessary to the new caret position.
		  ScrollToCaretPos
		  
		  // Redraw the canvas.
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E736572747320612073696E676C6520636861726163746572206174207468652063757272656E7420636172657420706F736974696F6E2E
		Sub InsertCharacter(char As String, raiseContentsDidChange As Boolean = True, range As TextRange = Nil)
		  /// Inserts a single character at the current caret position.
		  ///
		  /// Assumes `char` is only one character. For longer strings, use `Insert()`.
		  
		  If Not Typing Or System.Ticks > UndoIDThreshold Then
		    CurrentUndoID = System.Ticks
		  End If
		  
		  If range <> Nil And Not TextSelected And TargetMacOS Then
		    // The user has pressed and held down a character and has selected a special character from the 
		    // popup to insert. Replace the character before the caret with `char`.
		    DeleteBackward(True, False)
		    LineManager.InsertCharacter(CaretPosition, char, True, raiseContentsDidChange)
		  Else
		    If TextSelected Then
		      // Replace the selection and update the caret position.
		      LineManager.ReplaceSelection(char, True, raiseContentsDidChange)
		    Else
		      // If the user is inserting `(`, `{` or `[` and we're not in a comment then close the bracket for
		      // them if that's the desired behaviour.
		      If AutocloseBrackets And Not CaretIsInComment Then
		        Select Case char
		        Case "(", "{", "["
		          // First insert the opening bracket.
		          LineManager.InsertCharacter(CaretPosition, char, True, raiseContentsDidChange)
		          // Now the correct closing bracket.
		          LineManager.InsertCharacter(CaretPosition, ClosingBracketForOpener.Value(char), _
		          True, raiseContentsDidChange)
		          // Move the caret back one place so it's within the brackets.
		          MoveCaretLeft
		        Else
		          // Not an opening bracket. Just insert the character at the current caret position.
		          LineManager.InsertCharacter(CaretPosition, char, True, raiseContentsDidChange)
		        End Select
		      Else
		        // Insert the character at the current caret position.
		        LineManager.InsertCharacter(CaretPosition, char, True, raiseContentsDidChange)
		      End If
		    End If
		  End If
		  
		  ScrollToCaretPos
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4966206120646F75626C6520636C69636B206F636375727265642C2074686973206D6574686F642068616E646C657320697420616E642072657475726E7320547275652E204F74686572776973652069742072657475726E732046616C73652E
		Private Function IsDoubleClick(x As Integer, y As Integer) As Boolean
		  /// If a double click occurred, this method handles it and returns True. Otherwise it returns False.
		  
		  Const SPACE_DELTA = 4
		  
		  Var currentClickTicks As Integer
		  Var result As Boolean = False
		  
		  currentClickTicks = System.Ticks
		  
		  // Did the two clicks happen close enough together in time?
		  If (currentClickTicks - mLastClickTicks) <= GetDoubleClickTimeTicks Then
		    // Did they happen close enough together in space?
		    If Abs(x - mLastMouseUpX) <= SPACE_DELTA And Abs(y - mLastMouseUpY) <= SPACE_DELTA Then
		      // A double click has occurred.
		      mIsDoubleClick = True
		      HandleDoubleClick(x, y)
		      result = True
		    Else
		      // Not a double click.
		      mIsDoubleClick = False
		    End If
		  End If
		  
		  mLastClickTicks = currentClickTicks
		  mLastMouseUpX = x
		  mLastMouseUpY = y
		  
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060782C207960206973206F76657220616E792070617274206F662074686520686F72697A6F6E74616C207363726F6C6C626172202857696E646F77732026204C696E7578206F6E6C79292E
		Private Function IsOverHorizontalScrollbar(x As Integer, y As Integer) As Boolean
		  /// Returns True if `x, y` is over any part of the horizontal scrollbar (Windows & Linux only).
		  
		  #Pragma Unused x
		  
		  If mHorizontalScrollbar = Nil Then Return False
		  
		  Return y >= Height - HORIZONTAL_SCROLLBAR_HEIGHT
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060782C207960206973206F76657220616E792070617274206F662074686520766572746963616C207363726F6C6C626172202857696E646F77732026204C696E7578206F6E6C79292E
		Private Function IsOverVerticalScrollbar(x As Integer, y As Integer) As Boolean
		  /// Returns True if `x, y` is over any part of the vertical scrollbar (Windows & Linux only).
		  
		  #Pragma Unused y
		  
		  If mVerticalScrollbar = Nil Then Return False
		  
		  Return x >= Width - VERTICAL_SCROLLBAR_WIDTH
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4966206120747269706C6520636C69636B206A7573742068617070656E65642C2074686973206D6574686F642068616E646C657320697420616E642072657475726E7320547275652E204F74686572776973652069742072657475726E732046616C73652E
		Private Function IsTripleClick(x As Integer, y As Integer) As Boolean
		  /// If a triple click just happened, this method handles it and returns True. Otherwise it returns False.
		  ///
		  /// If a triple click occurs, calls the `HandleTripleClick()` method.
		  
		  Const SPACE_DELTA = 4
		  
		  If mIsDoubleClick Then
		    // At least a double click has occurred.
		    Var doubleClickTime, currentClickTicks As Integer
		    Var result As Boolean = False
		    
		    doubleClickTime = GetDoubleClickTimeTicks
		    currentClickTicks = System.Ticks
		    
		    // Did the three clicks happen close enough together in time?
		    If (currentClickTicks - mLastTripleClickTicks) <= doubleClickTime Then
		      // Did the three clicks happen close enough together in space?
		      If Abs(x - mLastMouseUpX) <= SPACE_DELTA And Abs(y - mLastMouseUpY) <= SPACE_DELTA Then
		        // A triple click occurred so handle it.
		        HandleTripleClick(x, y)
		        result = True
		      End If
		    End If
		    
		    // Cache required values.
		    mLastTripleClickTicks = currentClickTicks
		    mLastMouseUpX = x
		    mLastMouseUpY = y
		    mIsDoubleClick = False
		    Return result
		  Else
		    // Even a double click hasn't occurred.
		    mIsDoubleClick = False
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060782C2079602069732077697468696E20612076697369626C6520686F72697A6F6E74616C207363726F6C6C62617220747261636B20286E6F7420746865207468756D62292E
		Private Function IsWithinHorizontalScrollbarTrack(x As Integer, y As Integer) As Boolean
		  /// Returns True if `x, y` is within a visible horizontal scrollbar track (not the thumb).
		  
		  If mHorizontalScrollbar = Nil Then Return False
		  If y < Height - mHorizontalScrollbar.Height Then Return False
		  If mHorizontalScrollbarThumbBounds = Nil Then Return False
		  
		  Return Not mHorizontalScrollbarThumbBounds.Contains(x, y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060782C2079602069732077697468696E20612076697369626C6520766572746963616C207363726F6C6C62617220747261636B20286E6F7420746865207468756D62292E
		Private Function IsWithinVerticalScrollbarTrack(x As Integer, y As Integer) As Boolean
		  /// Returns True if `x, y` is within a visible vertical scrollbar track (not the thumb).
		  
		  If mVerticalScrollbar = Nil Then Return False
		  If x < Width - mVerticalScrollbar.Width Then Return False
		  If mVerticalScrollbarThumbBounds = Nil Then Return False
		  
		  Return Not mVerticalScrollbarThumbBounds.Contains(x, y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520312D6261736564206C696E65206E756D626572206F6620746865206C6173742076697369626C65206C696E652E
		Function LastVisibleLineNumber() As Integer
		  /// The 1-based line number of the last visible line. 
		  ///
		  /// The line may be only partially visible.
		  
		  Var i As Integer = mFirstVisibleLine + MaxVisibleLines(LineHeight)
		  Return Min(i, LineManager.LastLine.Number)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73205472756520696620606C696E65602069732066756C6C792076697369626C65206F6E207468652063616E7661732E
		Private Function LineFullyVisible(line As XUICELine) As Boolean
		  /// Returns True if `line` is fully visible on the canvas.
		  
		  If line.Number < FirstVisibleLine Then Return False
		  
		  If line.Number > (FirstVisibleLine + MaxVisibleLines(LineHeight) - 1) Then
		    Return False
		  End If
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206865696768742028696E20706978656C7329206F662061206C696E652E
		Function LineHeight() As Double
		  /// The height (in pixels) of a line.
		  
		  Const TEXT_DESCENT_FUDGE = 1
		  
		  If mBackBuffer <> Nil Then
		    // We compute line height based on the source code font size and family.
		    // Since we can't guarantee where this method is called from, we'll
		    // cache the current value of these properties, temporarily set the
		    // graphics content to the source code font family and size and then
		    // restore the original properties.
		    Var tmpFontSize As Integer = mBackBuffer.Graphics.FontSize
		    
		    // Set.
		    mBackBuffer.Graphics.FontSize = FontSize
		    
		    // Compute.
		    Var lh As Double = mBackBuffer.Graphics.TextHeight + (2 * VerticalLinePadding) + _
		    TEXT_DESCENT_FUDGE
		    
		    // Restore.
		    mBackBuffer.Graphics.FontSize = tmpFontSize
		    
		    Return lh
		  Else
		    // Edge case: The canvas is embedded in a DesktopControl that is not
		    // yet embedded in a window. In this scenario, `Window` is Nil.
		    Var p As Picture
		    If Self.Window <> Nil Then
		      p = Self.Window.BitmapForCaching(5, 5)
		    Else
		      p = New Picture(5, 5)
		    End If
		    p.Graphics.FontSize = FontSize
		    
		    // Compute.
		    Return p.Graphics.TextHeight + (2 * VerticalLinePadding) + TEXT_DESCENT_FUDGE
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206C696E65206C6F636174696F6E20617420636F6F7264696E61746573206078602C20607960206F7220604E696C60206966207468657265206973206E6F206C696E652061742074686F736520636F6F7264696E617465732E
		Private Function LocationAtXY(x As Integer, y As Integer) As XUICELocation
		  /// Returns the line location at coordinates `x`, `y` or `Nil` if there is no line at those coordinates.
		  ///
		  /// If `x` is beyond the end of a line then the last column for that line is 
		  /// specified in the returned line location.
		  
		  // Adjust `x` to account for horizontal scrolling.
		  x = x + mScrollPosX
		  
		  // Get the line number at this Y coordinate.
		  Var lineNum As Integer = Floor(y / LineHeight) + FirstVisibleLine
		  
		  // Try to get the line at this line number.
		  Var line As XUICELine = LineManager.LineAt(lineNum)
		  If line = Nil Then Return Nil
		  
		  Var overLine As Boolean // True if the coordinates are over an actual column in the line.
		  
		  // Compute the column.
		  Var column As Integer
		  If x < line.TextStartX Then
		    // Before the line's text.
		    column = 0
		    overLine = False
		  ElseIf x >= line.TextEndX Then
		    // At the end of the line.
		    column = line.Length
		    overLine = False
		  Else
		    // X should be in the line contents.
		    column = line.ColumnAtX(x - line.TextStartX, mBackBuffer.Graphics)
		    If column = -1 Then
		      column = 0
		      overLine = False
		    Else
		      overLine = True
		    End If
		  End If
		  
		  Return New XUICELocation(line, line.Start + column, column, overLine)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520636172657420706F736974696F6E207370656369666965642062792074686520706173736564206C6F636174696F6E2E
		Private Function LocationToCaretPos(location As XUICELocation) As Integer
		  /// Returns the caret position specified by the passed location.
		  
		  Return location.Line.Start + location.Column
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 546865206D6178696D756D206E756D626572206F66206C696E65732074686174206172652076697369626C6520696E207468652063616E7661732E204164646974696F6E616C6C7920636163686573207468652076616C756520696E20606D4D617856697369626C654C696E6573602E
		Private Function MaxVisibleLines(lineHeight As Double) As Integer
		  /// The maximum number of lines that are visible in the canvas. 
		  ///
		  /// Will never be more than the maximum number of lines in existence.
		  
		  #If TargetMacOS
		    mMaxVisibleLines = Min(Me.Height / lineHeight, LineManager.LineCount)
		  #Else
		    mMaxVisibleLines = Min((Me.Height - HORIZONTAL_SCROLLBAR_HEIGHT) / lineHeight, LineManager.LineCount)
		  #EndIf
		  
		  Return mMaxVisibleLines
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520636172657420646F776E2061206C696E652E
		Private Sub MoveCaretDown()
		  /// Moves the caret down a line.
		  
		  If TextSelected Then
		    // If the user presses the down arrow key when there is selected text, we move the 
		    // caret to the end of the selected text and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.EndLocation
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		    MoveCaretToPos(caretPos)
		  Else
		    If CaretLineNumber = LineManager.LastLine.Number Then
		      // When we're on the last line, pressing down moves to the end of the document.
		      MoveCaretToPos(LineManager.LastLine.Finish)
		    Else
		      // Move the caret down one line to the same (or closest) column.
		      MoveCaretToColumn(CurrentLine.Number + 1, CaretColumn)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520636172657420746F20746865206C656674206F6E6520706F736974696F6E2E
		Private Sub MoveCaretLeft()
		  /// Moves the caret to the left one position.
		  
		  If TextSelected Then
		    // Move the caret to the selected text's start location and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.StartLocation
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		    MoveCaretToPos(caretPos)
		  Else
		    MoveCaretToPos(CaretPosition - 1)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F76657320746865206361726574206F6E6520706F736974696F6E20746F207468652072696768742E
		Private Sub MoveCaretRight()
		  /// Moves the caret one position to the right.
		  
		  If TextSelected Then
		    // Move the caret to the selection's end location and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.EndLocation
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		    MoveCaretToPos(caretPos)
		  Else
		    MoveCaretToPos(CaretPosition + 1)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MoveCaretToColumn(lineNumber As Integer, column As Integer, shouldInvalidate As Boolean = True)
		  /// Moves the caret to the column on the specified line.
		  ///
		  /// If `shouldInvalidate` is False then the canvas will not be immediately invalidated.
		  /// 
		  /// Raises an `InvalidArgumentException` if `lineNumber` is out of range.
		  /// If `column` is greater than the number of columns in the target line then 
		  /// it moves the caret to the end of the target line.
		  
		  // Sanity checks.
		  If lineNumber < 1 Or lineNumber > LineManager.LastLine.Number Then
		    Raise New InvalidArgumentException("Invalid line number to move to")
		  End If
		  If column < 0 Then
		    Raise New InvalidArgumentException("Invalid target column. Must be >= 0")
		  End If
		  
		  // Get the target line to move to.
		  Var targetLine As XUICELine = LineManager.LineAt(lineNumber)
		  
		  // If the column to move to is greater than the number of columns in the 
		  // target line, move to the end of the target line.
		  If column > targetLine.Length Then column = targetLine.Length
		  
		  // Update the caret position.
		  CaretPosition = targetLine.Start + column
		  
		  // Scroll if required.
		  ScrollToCaretPos
		  
		  If shouldInvalidate Then Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520636172657420746F2074686520656E64206F6620746865206E65787420776F72642E
		Private Sub MoveCaretToNextWordEnd()
		  /// Moves the caret to the end of the next word.
		  
		  If TextSelected Then
		    // Move the caret to the selection's end location and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.EndLocation
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		    MoveCaretToPos(caretPos)
		  Else
		    MoveCaretToPos(LineManager.NextWordEnd(CaretPosition))
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F7665732074686520636172657420746F2074686520302D626173656420606E6577506F73602C20636C616D706564206265747765656E2074686520737461727420616E6420656E64206F662074686520746578742E
		Sub MoveCaretToPos(newPos As Integer, shouldInvalidate As Boolean = True)
		  /// Moves the caret to the 0-based `newPos`, clamped between the start and end of the text.
		  ///
		  /// If `shouldInvalidate` is False then the canvas will not be immediately invalidated.
		  /// If `newPos < 0` then the caret is moved to the start of the text.
		  /// If `newPos` > last valid caret position then the caret is moved to the end of the text.
		  
		  // Clamp the new position to a valid range.
		  newPos = XUIMaths.Clamp(newPos, 0, LineManager.LastLine.Finish)
		  
		  // Set the new caret position.
		  CaretPosition = newPos
		  
		  // Scroll if required.
		  ScrollToCaretPos
		  
		  // Redraw the canvas (unless instructed not to).
		  If shouldInvalidate Then Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520636172657420746F20746865207374617274206F66207468652070726576696F757320776F72642E
		Private Sub MoveCaretToPreviousWordStart()
		  /// Moves the caret to the start of the previous word.
		  
		  If TextSelected Then
		    // Move the caret to the selected text's start location and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.StartLocation
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		    MoveCaretToPos(caretPos)
		  Else
		    MoveCaretToPos(LineManager.PreviousWordStart(CaretPosition))
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F766573207468652063617265742075702061206C696E652E
		Private Sub MoveCaretUp()
		  /// Moves the caret up a line.
		  
		  If TextSelected Then
		    // Move the caret to the selected text's start location and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.StartLocation
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		    MoveCaretToPos(caretPos)
		  Else
		    If CaretLineNumber = 1 Then
		      // When on the first line, pressing up moves to the beginning of the document.
		      MoveCaretToPos(0)
		    Else
		      // Move the caret up one line to the same (or closest) column.
		      MoveCaretToColumn(CurrentLine.Number - 1, CaretColumn)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F76657320646F776E20616E64206D6F646966696573207468652073656C656374696F6E2E
		Private Sub MoveDownAndModifySelection()
		  /// Moves down and modifies the selection.
		  
		  If Not TextSelected Then
		    // Create a new selection that starts, ends and is anchored at the current caret position.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, CaretPosition, Self)
		  End If
		  
		  // Compute the new selection end position.
		  If CaretLineNumber = LineManager.LastLine.Number Then
		    // The caret is on the last line so select to the end of the document.
		    mCurrentSelection.EndLocation = LineManager.LastLine.Finish
		  Else
		    // Get the line below.
		    Var lineBelow As XUICELine = LineManager.LineAt(CaretLineNumber + 1)
		    
		    // If the column to move to is greater than the number of columns in the line below then move 
		    // to the end of the line below.
		    If CaretColumn > lineBelow.Length Then
		      mCurrentSelection.EndLocation = lineBelow.Finish
		    Else
		      mCurrentSelection.EndLocation = lineBelow.Start + CaretColumn
		    End If
		  End If
		  
		  // Set the selection anchor point to the caret position.
		  mCurrentSelection.Anchor = CaretPosition
		  
		  // Always redraw the entire canvas to ensure that old selections are removed.
		  NeedsFullRedraw = True
		  
		  // Move the caret to the end of the selection.
		  MoveCaretToPos(mCurrentSelection.EndLocation)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F76657320746865206361726574206F6E6520706F736974696F6E20746F20746865206C65667420616E64206D6F646966696573207468652063757272656E742073656C656374696F6E2E
		Private Sub MoveLeftAndModifySelection()
		  /// Moves the caret one position to the left and modifies the current selection.
		  ///
		  /// The user has pressed Shift+Left arrow.
		  
		  // Edge case: At the beginning of the document.
		  If CaretPosition = 0 Then Return
		  
		  If mCurrentSelection = Nil Then
		    // Create a new selection anchored at the current caret position, starting a character before.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition - 1, CaretPosition, Self)
		  Else
		    If CaretPosition = mCurrentSelection.Anchor + 1 Then
		      // Edge case: We are moving leftwards and will meet the anchor. This is 
		      // equivalent to having no selection.
		      mCurrentSelection = Nil
		    ElseIf CaretPosition > mCurrentSelection.Anchor Then
		      // We are shrinking the selection's length by 1.
		      mCurrentSelection.EndLocation = mCurrentSelection.EndLocation - 1
		    Else
		      // Move the selection's starting location leftwards by 1.
		      mCurrentSelection.StartLocation = mCurrentSelection.StartLocation - 1
		    End If
		  End If
		  
		  // Always redraw the entire canvas to ensure that old selections are removed.
		  NeedsFullRedraw = True
		  
		  // Move the caret leftwards 1 position and refresh.
		  MoveCaretToPos(CaretPosition - 1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F76657320746865206361726574206F6E6520706F736974696F6E20746F2074686520726967687420616E64206D6F646966696573207468652063757272656E742073656C656374696F6E2E
		Private Sub MoveRightAndModifySelection()
		  /// Moves the caret one position to the right and modifies the current selection.
		  ///
		  /// The user has pressed Shift+Right arrow.
		  
		  // Edge case: At the end of the document.
		  If CaretPosition = LineManager.LastLine.Finish Then Return
		  
		  If mCurrentSelection = Nil Then
		    // Create a new selection anchored at the current caret position, ending at the next character.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, CaretPosition + 1, Self)
		  Else
		    If CaretPosition = mCurrentSelection.Anchor - 1 Then
		      // Edge case: We are moving rightwards and will meet the anchor. Equivalent to having no selection.
		      mCurrentSelection = Nil
		    ElseIf CaretPosition > mCurrentSelection.Anchor Then
		      // We are increasing the selection's length by 1.
		      mCurrentSelection.EndLocation = mCurrentSelection.EndLocation + 1
		    Else
		      // Move the selection's starting location rightwards by 1.
		      mCurrentSelection.StartLocation = mCurrentSelection.StartLocation + 1
		    End If
		  End If
		  
		  // Always redraw the entire canvas to ensure that old selections are removed.
		  NeedsFullRedraw = True
		  
		  // Move the caret rightwards 1 position and refresh.
		  MoveCaretToPos(CaretPosition + 1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520636172657420746F2074686520626567696E6E696E67206F662074686520646F63756D656E742E
		Private Sub MoveToBeginningOfDocument()
		  /// Moves the caret to the beginning of the document.
		  
		  // Clear any selected text.
		  If TextSelected Then
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		  End If
		  
		  // Move to the beginning of the text.
		  MoveCaretToPos(0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520636172657420746F2074686520626567696E6E696E67206F6620746865206C696E652E
		Private Sub MoveToBeginningOfLine()
		  /// Moves the caret to the beginning of the line.
		  
		  // Clear any existing text selection.
		  If TextSelected Then
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		  End If
		  
		  MoveCaretToPos(mCurrentLine.Start)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F76657320746F2074686520746F70206F662074686520626567696E6E696E67206F662074686520646F63756D656E7420616E64206D6F646966696573207468652073656C656374696F6E2E
		Private Sub MoveToDocumentBeginningAndModifySelection()
		  /// Moves to the top of the beginning of the document and modifies the selection.
		  
		  If Not TextSelected Then
		    // Create a new selection that starts at the top of the document, ends at 
		    // the current caret position and is anchored at the current caret position.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, 0, CaretPosition, Self)
		  End If
		  
		  // Always redraw the entire canvas to ensure that old selections are removed.
		  NeedsFullRedraw = True
		  
		  // Move the caret to the top of the document
		  MoveCaretToPos(0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F76657320746F2074686520656E64206F662074686520646F63756D656E7420616E64206D6F646966696573207468652073656C656374696F6E2E
		Private Sub MoveToDocumentEndAndModifySelection()
		  /// Moves to the end of the document and modifies the selection.
		  
		  If Not TextSelected Then
		    // Create a new selection that starts and is anchored at the current caret 
		    // position but ends at the end of the document.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, LineManager.LastLine.Finish, Self)
		  End If
		  
		  // Always redraw the entire canvas to ensure that old selections are removed.
		  NeedsFullRedraw = True
		  
		  // Move the caret to the end of the selection.
		  MoveCaretToPos(mCurrentSelection.EndLocation)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520636172657420746F2074686520656E64206F662074686520646F63756D656E742E
		Private Sub MoveToEndOfDocument()
		  /// Moves the caret to the end of the document.
		  
		  // Clear any selected text.
		  If TextSelected Then
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		  End If
		  
		  // Move the caret to the end of the text.
		  MoveCaretToPos(LineManager.LastLine.Finish)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520636172657420746F2074686520656E64206F6620746865206C696E652E
		Private Sub MoveToEndOfLine()
		  /// Moves the caret to the end of the line.
		  
		  // Clear any existing text selection.
		  If TextSelected Then
		    mCurrentSelection = Nil
		    // Always redraw the entire canvas to ensure that old selections are removed.
		    NeedsFullRedraw = True
		  End If
		  
		  MoveCaretToPos(mCurrentLine.Finish)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F766573207468652073656C656374696F6E20746F20746865206C65667420656E64206F6620746865206C696E652E
		Private Sub MoveToLeftEndOfLineAndModifySelection()
		  /// Moves the selection to the left end of the line.
		  
		  // Edge case: Already at the left end of the current line.
		  If CaretPosition = mCurrentLine.Start Then Return
		  
		  If mCurrentSelection = Nil Then
		    // Create a new selection anchored and ending at the current caret position
		    // but starting at the beginning of the current line.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, mCurrentLine.Start, CaretPosition, Self)
		  Else
		    // Get the start position of the line that the selection begins at.
		    Var selStartLine As XUICELine = LineManager.LineForCaretPos(mCurrentSelection.StartLocation)
		    If CaretPosition > mCurrentSelection.Anchor Then
		      // Change the selection such that it begins at the start of the line that the 
		      // selection currently starts at, keeps it current anchor point and ends at the anchor point.
		      mCurrentSelection.StartLocation = selStartLine.Start
		      mCurrentSelection.EndLocation = mCurrentSelection.Anchor
		    Else
		      // Start the selection at the start of the line that the selection begins on.
		      mCurrentSelection.StartLocation = selStartLine.Start
		    End If
		  End If
		  
		  // Always redraw the entire canvas to ensure that old selections are removed.
		  NeedsFullRedraw = True
		  
		  // Move the caret to the selection start position.
		  MoveCaretToPos(mCurrentSelection.StartLocation)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F766573207468652073656C656374696F6E20746F2074686520726967687420656E64206F6620746865206C696E652E
		Private Sub MoveToRightEndOfLineAndModifySelection()
		  /// Moves the selection to the right end of the line.
		  
		  // Edge case: At the end of the document.
		  If CaretPosition = LineManager.LastLine.Finish Then Return
		  
		  If Not TextSelected Then
		    // Create a new selection, anchored and starting at the caret and ending at the end of the current line.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, mCurrentLine.Finish, Self)
		  Else
		    If CaretPosition > mCurrentSelection.Anchor Then
		      mCurrentSelection.EndLocation = mCurrentLine.Finish
		    Else
		      // Set the start of the selection to the current anchor.
		      mCurrentSelection.StartLocation = mCurrentSelection.Anchor
		      mCurrentSelection.EndLocation = mCurrentLine.Finish
		    End If
		  End If
		  
		  // Always redraw the entire canvas to ensure that old selections are removed.
		  NeedsFullRedraw = True
		  
		  // Move the caret to the end of the selection.
		  MoveCaretToPos(mCurrentSelection.EndLocation)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F76657320757020616E64206D6F646966696573207468652073656C656374696F6E2E
		Private Sub MoveUpAndModifySelection()
		  /// Moves up and modifies the selection.
		  
		  If Not TextSelected Then
		    // Create a new selection that starts, ends and is anchored at the current caret position.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, CaretPosition, Self)
		  End If
		  
		  // Compute the new selection start position.
		  If CaretLineNumber = 1 Then
		    mCurrentSelection.StartLocation = 0
		  Else
		    // Get the line above.
		    Var lineAbove As XUICELine = LineManager.LineAt(CaretLineNumber - 1)
		    
		    // If the column to move to is greater than the number of columns in the line, 
		    // above then move to the end of the line above.
		    If CaretColumn > lineAbove.Length Then
		      mCurrentSelection.StartLocation = lineAbove.Finish
		    Else
		      mCurrentSelection.StartLocation = lineAbove.Start + CaretColumn
		    End If
		  End If
		  
		  // Set the selection anchor point to the caret position.
		  mCurrentSelection.Anchor = CaretPosition
		  
		  // Always redraw the entire canvas to ensure that old selections are removed.
		  NeedsFullRedraw = True
		  
		  // Move the caret to the start of the selection.
		  MoveCaretToPos(mCurrentSelection.StartLocation)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 53656C6563742074686520746578742066726F6D2074686520626567696E6E696E67206F662074686520776F726420746F20746865206C656674206F662074686520636172657420746F207468652063757272656E7420636172657420706F736974696F6E2E
		Private Sub MoveWordLeftAndModifySelection()
		  /// Selects the text from the beginning of the word to the left of the caret to 
		  /// the current caret position.
		  
		  // Edge case: At the beginning of the document.
		  If CaretPosition = 0 Then Return
		  
		  Var prevWordStart As Integer = LineManager.PreviousWordStart(CaretPosition)
		  
		  If mCurrentSelection = Nil Then
		    // Create a new selection anchored at the current caret position, starting at the 
		    // beginning of the word to the left of the caret. 
		    mCurrentSelection = New XUICETextSelection(CaretPosition, prevWordStart, CaretPosition, Self)
		  Else
		    If prevWordStart = mCurrentSelection.Anchor Then
		      // Edge case: We are moving leftwards and will meet the anchor. Equivalent to having no selection.
		      mCurrentSelection = Nil
		    ElseIf CaretPosition > mCurrentSelection.Anchor Then
		      mCurrentSelection.EndLocation = prevWordStart
		      If mCurrentSelection.Anchor > mCurrentSelection.EndLocation Then
		        mCurrentSelection.Anchor = mCurrentSelection.EndLocation
		      End If
		    Else
		      // Move the selection start leftwards.
		      mCurrentSelection.StartLocation = prevWordStart
		    End If
		  End If
		  
		  // Move the caret to the previous word start.
		  MoveCaretToPos(prevWordStart)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C6573206D6F64696679696E67207468652073656C656374696F6E20746F2074686520656E64206F662074686520776F72642E
		Private Sub MoveWordRightAndModifySelection()
		  /// Handles modifying the selection to the end of the word.
		  ///
		  /// On macOS this is `Shift+Opt+Right Arrow`
		  
		  // Edge case: At the end of the document.
		  If CaretPosition = LineManager.LastLine.Finish Then Return
		  
		  Var nextWordEndPos As Integer = LineManager.NextWordEnd(CaretPosition)
		  
		  If mCurrentSelection = Nil Then
		    // Create a new selection anchored and starting at the current caret position 
		    // and ending at the end of the word boundary.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, nextWordEndPos, Self)
		  Else
		    If nextWordEndPos > mCurrentSelection.Anchor Then
		      // Move the end position of the selection to the end of the word.
		      mCurrentSelection.EndLocation = nextWordEndPos
		    Else
		      // Set the selection start to the current anchor position and the selection end to the next word end.
		      mCurrentSelection.StartLocation = nextWordEndPos
		      If mCurrentSelection.Anchor < mCurrentSelection.StartLocation Then
		        mCurrentSelection.Anchor = mCurrentSelection.StartLocation
		      End If
		    End If
		  End If
		  
		  // Always redraw the entire canvas to ensure that old selections are removed.
		  NeedsFullRedraw = True
		  
		  // Move the caret to the next word end.
		  MoveCaretToPos(nextWordEndPos)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41206E6F74696669636174696F6E20686173206265656E2072656365697665642066726F6D20746865204E6F74696669636174696F6E2043656E7465722E
		Sub NotificationReceived(n As XUINotification)
		  /// A notification has been received from the Notification Center.
		  ///
		  /// Part of the XUINotificationListener interface.
		  
		  Select Case n.Key
		  Case App.NOTIFICATION_APPEARANCE_CHANGED
		    // A light/dark mode switch has occurred. 
		    NeedsFullRedraw = True
		    Refresh(True)
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506167657320646F776E20616E64206D6F646966696573207468652073656C656374696F6E2E
		Private Sub PageDownAndModifySelection()
		  /// Pages down and modifies the selection.
		  
		  If Not TextSelected Then
		    // Create a new text selection starting, ending and anchored at the caret position.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, CaretPosition, Self)
		  End If
		  
		  // Scroll the page down, moving the caret but not invalidating the canvas yet.
		  ScrollPageDown(True, False)
		  
		  // Set the selected text end point to the new caret position.
		  mCurrentSelection.EndLocation = CaretPosition
		  
		  // Redraw.
		  NeedsFullRedraw = True
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5363726F6C6C7320746865207061676520757020616E64206D6F646966696573207468652073656C656374696F6E2E
		Private Sub PageUpAndModifySelection()
		  /// Scrolls the page up and modifies the selection.
		  
		  If Not TextSelected Then
		    // Create a new text selection starting, ending and anchored at the caret position.
		    mCurrentSelection = New XUICETextSelection(CaretPosition, CaretPosition, CaretPosition, Self)
		  End If
		  
		  // Scroll the page up, moving the caret but not invalidating the canvas yet.
		  ScrollPageUp(True, False)
		  
		  // Set the selected text start point to the new caret position.
		  mCurrentSelection.StartLocation = CaretPosition
		  
		  // Redraw.
		  NeedsFullRedraw = True
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061696E74732074686520626C6F636B206361726574206F6E20606760206174206078602C206079602E
		Private Sub PaintBlockCaret(g As Graphics, x As Double, y As Double)
		  /// Paints the block caret on `g` at `x`, `y`.
		  ///
		  /// Assumes the drawing colour of `g` has been set to the correct colour for the caret.
		  /// Assumes that the font properties of `g` object have been set to the correct style.
		  
		  // Draw the block.
		  g.FillRectangle(x, y - VerticalLinePadding, g.TextWidth("_"), _
		  g.TextHeight + (2 * VerticalLinePadding))
		  
		  // Draw the character behind the block (if any).
		  If CaretData.Character = "" Then Return
		  
		  // First set the font style
		  SetGraphicsStyle(g, CaretData.Style)
		  
		  // When drawing text we must temporariliy switch on anti-aliasing on Windows.
		  #If TargetWindows
		    g.AntiAliased = True
		    g.DrawText(CaretData.Character, x, CurrentLine.TextStartY)
		    g.AntiAliased = False
		  #Else
		    g.DrawText(CaretData.Character, x, CurrentLine.TextStartY)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061696E74732074686520636172657420746F206067602061742074686520302D62617365642060706F73602E
		Private Sub PaintCaret(g As Graphics, pos As Integer)
		  /// Paints the caret to `g` at the 0-based `pos`.
		  
		  // Whilst dragging, the CaretPosition may be temporarily inaccurate.
		  // To prevent a hard crash caused by an OutOfBoundsError we will 
		  // disable drawing the caret whilst dragging.
		  If mDragging Then Return
		  
		  // Compute the x, y coordinates at the passed caret position.
		  Var x, y As Double = 0
		  XYAtCaretPos(pos, x, y)
		  
		  // Adjust y to account for the vertical line padding.
		  y = y + VerticalLinePadding
		  
		  // Draw it.
		  g.DrawingColor = CaretColour
		  Select Case CaretType
		  Case CaretTypes.VerticalBar
		    g.DrawLine(x, y, x, y + g.TextHeight)
		    
		  Case CaretTypes.Underscore
		    g.DrawLine(x, y + g.TextHeight, x + g.TextWidth("_"), y + g.TextHeight)
		    
		  Case CaretTypes.Block
		    PaintBlockCaret(g, x, y)
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320746865206E6561726573742064656C696D697465727320746F2074686520636172657420706572696F646963616C6C792E2043616C6C656420627920606D44656C696D6974657254696D65722E416374696F6E602E
		Private Sub ParseTimerAction(parseTimer As Timer)
		  /// Checks to see if enough time has elapsed that we should invoke the formatter's `Parse()` method.
		  
		  #Pragma Unused parseTimer
		  
		  If JustTokenised And System.Microseconds - LastParseMicroseconds >= (MinimumParseInterval * 1000) Then
		    JustTokenised = False
		    LastParseMicroseconds = System.Microseconds
		    Formatter.Parse(LineManager.Lines)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656275696C64732074686520656E74697265206261636B206275666665722062792064726177696E6720616C6C2076697369626C6520636F6E74656E7420746F2069742E
		Private Sub RebuildBackBuffer()
		  /// Rebuilds the entire back buffer by drawing all visible content to it.
		  
		  If Me.Theme = Nil Then Return
		  
		  // Cache the required back buffer width.
		  mCachedRequiredBufferWidth = RequiredBufferWidth
		  
		  // Create a new HiDPI aware back buffer picture.
		  mBackBuffer = Window.BitmapForCaching(mCachedRequiredBufferWidth, Height)
		  
		  // Grab a reference to the back buffer's graphics context.
		  Var g As Graphics = mBackBuffer.Graphics
		  
		  #If TargetWindows
		    // Anti-aliasing needs to be off on Windows.
		    g.AntiAliased = False
		  #EndIf
		  
		  // Cache the width of a line number character.
		  // NB: Assumes we are using a monospace font.
		  g.FontName = FontName
		  g.FontSize = LineNumberFontSize
		  Var lineNumCharWidth As Double = g.TextWidth("0")
		  
		  // Set the font size to the default for source code.
		  g.FontSize = FontSize
		  
		  // Draw the background.
		  g.DrawingColor = BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // Compute the width of the bounding box for the line number string.
		  If DisplayLineNumbers Then
		    // Make sure we compute the width of a minimum of two characters, 
		    // otherwise the gutter resizes when you get to 9 lines.
		    // +10 is a fudge to make the textShape drawn by the line align better.
		    mLineNumWidth = _
		    (Max(LineManager.LineCount.ToString.Length, 2) * lineNumCharWidth) + 10
		  Else
		    mLineNumWidth = MIN_LINE_NUMBER_WIDTH
		  End If
		  
		  // Recompute the gutter width and cache it.
		  mGutterWidth = ComputeGutterWidth(mLineNumWidth)
		  
		  // Cache the current line height as it's computed.
		  mLineHeight = LineHeight
		  
		  // Compute the top-left Y coordinate for the first visible line.
		  Var lineStartY As Double = 0
		  
		  // Cache `LastVisibleLineNumber` (as it's computed).
		  Var iMax As Integer = LastVisibleLineNumber
		  
		  // Iterate over the visible lines and draw every line.
		  For i As Integer = mFirstVisibleLine To iMax
		    Var line As XUICELine = LineManager.LineAt(i)
		    line.Draw(g, 0, lineStartY, mLineHeight, _
		    mGutterWidth, CaretLineNumber = line.Number, mLineNumWidth)
		    lineStartY = lineStartY + mLineHeight
		  Next i
		  
		  // Draw the caret.
		  If mCaretVisible Then
		    PaintCaret(g, mCaretPosition)
		  End If
		  
		  NeedsFullRedraw = False
		  
		  // Update the scrollbars.
		  #If TargetWindows Or TargetLinux
		    RebuildScrollbars
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656275696C64732074686520766572746963616C207363726F6C6C20626172206F72207365747320697420746F204E696C2069662069742773206E6F74206E65656465642E
		Private Sub RebuildHorizontalScrollbar()
		  /// Rebuilds the horizontal scroll bar or sets it to Nil if it's not needed.
		  
		  If Not RequiresHorizontalScrollbar Then
		    mHorizontalScrollbar = Nil
		    mHorizontalScrollbarThumbBounds = Nil
		    Return
		  End If
		  
		  // Create a new picture, the required size of the track.
		  mHorizontalScrollbar = Window.BitmapForCaching(Width - VERTICAL_SCROLLBAR_WIDTH, HORIZONTAL_SCROLLBAR_HEIGHT)
		  
		  // For brevity grab the graphics context.
		  Var g As Graphics = mHorizontalScrollbar.Graphics
		  
		  // Compute the maximum permissible X scroll position.
		  Var maxScrollPosX As Integer = Max(mCachedRequiredBufferWidth - Width, 0)
		  
		  // Compute the width of the thumb.
		  Var thumbW As Double = (g.Width / mBackBuffer.Graphics.Width) * (g.Width - (SCROLLBAR_THUMB_PADDING * 2))
		  
		  // Compute the X coordinate of the left of the thumb.
		  Var minX As Integer = SCROLLBAR_THUMB_PADDING
		  Var maxX As Integer = g.Width - thumbW - SCROLLBAR_THUMB_PADDING
		  Var thumbX As Integer = XUIMaths.Clamp((ScrollPosX / maxScrollPosX) * (maxX - minX), minX, maxX)
		  
		  // Compute the thumb Y position.
		  Var thumbY As Double = (g.Height / 2) - (HORIZONTAL_SCROLLBAR_THUMB_HEIGHT / 2)
		  
		  // Draw the track background.
		  g.DrawingColor = Me.Theme.ScrollbarBackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // Track borders.
		  g.DrawingColor = Me.Theme.ScrollbarBorderColor
		  g.DrawRectangle(0, 0, g.Width, g.Height)
		  
		  // Thumb.
		  g.DrawingColor = Me.Theme.ScrollbarThumbColor
		  g.FillRoundRectangle(thumbX, thumbY, thumbW, HORIZONTAL_SCROLLBAR_THUMB_HEIGHT, 3, 3)
		  
		  // Update the thumb bounds. We use the entire height of the track not the thumb height for easier clickability.
		  mHorizontalScrollbarThumbBounds = _
		  New Rect(thumbX, Height - HORIZONTAL_SCROLLBAR_HEIGHT, thumbW, HORIZONTAL_SCROLLBAR_HEIGHT)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656275696C647320626F74682074686520766572746963616C20616E6420686F72697A6F6E74616C207363726F6C6C62617273206F722073657473207468656D20746F204E696C2069662074686579206172656E2774206E65656465642E
		Private Sub RebuildScrollbars()
		  /// Rebuilds both the vertical and horizontal scrollbars or sets them to Nil if they aren't needed.
		  
		  RebuildVerticalScrollbar
		  RebuildHorizontalScrollbar
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656275696C64732074686520766572746963616C207363726F6C6C20626172206F72207365747320697420746F204E696C2069662069742773206E6F74206E65656465642E
		Private Sub RebuildVerticalScrollbar()
		  /// Rebuilds the vertical scroll bar or sets it to Nil if it's not needed.
		  
		  If Not RequiresVerticalScrollbar Then
		    mVerticalScrollbar = Nil
		    mVerticalScrollbarThumbBounds = Nil
		    Return
		  End If
		  
		  // Create a new picture, the required size of the track.
		  mVerticalScrollbar = Window.BitmapForCaching(VERTICAL_SCROLLBAR_WIDTH, Height)
		  
		  // For brevity grab the graphics context.
		  Var g As Graphics = mVerticalScrollbar.Graphics
		  
		  // Compute the Y coordinate of the top of the thumb.
		  Var thumbY As Integer = (FirstVisibleLine / LineManager.LineCount) * (g.Height - (SCROLLBAR_THUMB_PADDING * 2))
		  
		  // Compute the height of the thumb.
		  Var thumbH As Integer = (mMaxVisibleLines / LineManager.LineCount) * (g.Height - (SCROLLBAR_THUMB_PADDING * 2))
		  
		  // Compute the thumb left X edge.
		  Var thumbX As Double = (g.Width / 2) - (VERTICAL_SCROLLBAR_THUMB_WIDTH / 2)
		  
		  // Draw the track background.
		  g.DrawingColor = Me.Theme.ScrollbarBackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // Track borders.
		  g.DrawingColor = Me.Theme.ScrollbarBorderColor
		  g.DrawRectangle(0, 0, g.Width, g.Height)
		  
		  // Thumb.
		  g.DrawingColor = Me.Theme.ScrollbarThumbColor
		  g.FillRoundRectangle(thumbX, thumbY, VERTICAL_SCROLLBAR_THUMB_WIDTH, thumbH, 3, 3)
		  
		  // Update the thumb bounds. We use the entire width of the track not the thumb width for easier clickability.
		  mVerticalScrollbarThumbBounds = _
		  New Rect(Width - VERTICAL_SCROLLBAR_WIDTH, thumbY, VERTICAL_SCROLLBAR_WIDTH, thumbH)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265647261777320616C6C206469727479206C696E657320746F20746865206261636B206275666665722E
		Private Sub RedrawDirtyLines()
		  /// Redraws all dirty lines to the back buffer.
		  ///
		  /// Assumes that the back buffer exists and is the correct size.
		  
		  // Cache the required back buffer width.
		  mCachedRequiredBufferWidth = RequiredBufferWidth
		  
		  // Grab a reference to the back buffer's graphics context.
		  Var g As Graphics = mBackBuffer.Graphics
		  
		  // Cache the current line height.
		  mLineHeight = LineHeight
		  
		  // Compute the top-left Y coordinate for the first visible line.
		  Var lineStartY As Double = 0
		  
		  // Cache `LastVisibleLineNumber` (as it's computed).
		  Var iMax As Integer = LastVisibleLineNumber
		  
		  // Iterate over the visible lines and redraw the dirty ones.
		  For i As Integer = mFirstVisibleLine To iMax
		    Var line As XUICELine = LineManager.LineAt(i)
		    
		    If line.IsDirty Then
		      line.Draw(g, 0, lineStartY, mLineHeight, _
		      mGutterWidth, CaretLineNumber = line.Number, mLineNumWidth)
		    End If
		    lineStartY = lineStartY + mLineHeight
		  Next i
		  
		  // Draw the caret.
		  If mCaretVisible Then
		    PaintCaret(g, mCaretPosition)
		  End If
		  
		  // Update the scrollbars.
		  #If TargetWindows Or TargetLinux
		    RebuildScrollbars
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265676973746572732074686520656469746F7220666F722064657369726564206E6F74696669636174696F6E732E
		Private Sub RegisterForNotifications()
		  /// Registers the editor for desired notifications.
		  
		  If App IsA XUIApp Then
		    Self.ListenForKey(App.NOTIFICATION_APPEARANCE_CHANGED)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265706C61636573207468652063757272656E742073656C656374696F6E2077697468206073602E
		Sub ReplaceCurrentSelection(s As String)
		  /// Replaces the current selection with `s`.
		  
		  CurrentUndoID = System.Ticks
		  
		  If CurrentSelection = Nil Then Return
		  
		  // Any newlines present in the text will be replaced with Unix ones (&u0A).
		  s = s.ReplaceLineEndings(&u0A)
		  
		  LineManager.ReplaceSelection(s, True, True, True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652077696474682028696E20706978656C7329207468617420746865206261636B206275666665722073686F756C6420626520746F206163636F6D6F6461746520746865206C6F6E67657374206C696E652C2070616464696E6720616E64206775747465722E
		Private Function RequiredBufferWidth() As Double
		  /// Returns the width (in pixels) that the back buffer should be to 
		  /// accomodate the longest line, padding and gutter.
		  ///
		  /// Will always be at least as wide as the canvas' current width.
		  
		  Var longestLine As XUICELine = LineManager.LongestLine
		  
		  Var g As Graphics
		  Var p As Picture
		  If mBackBuffer = Nil Then
		    // Edge case: The canvas is embedded in a DesktopContainer  that is not
		    // yet embedded in a window. In this scenario, `TrueWindow` is Nil.
		    If Self.Window <> Nil Then
		      p = Self.Window.BitmapForCaching(10, 10)
		    Else
		      p = New Picture(10, 10)
		    End If
		    g = p.Graphics
		  Else
		    g = mBackBuffer.Graphics
		  End If
		  
		  Var w As Double = longestLine.WidthToColumn(longestLine.Length, g)
		  
		  // Add in the gutter width and any padding.
		  w = w + ComputeGutterWidth(mLineNumWidth) + RIGHT_SCROLL_PADDING
		  
		  Return Max(w, Self.Width)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732054727565206966206120686F72697A6F6E74616C207363726F6C6C6261722069732072657175697265642028696E657870656E7369766520636F6D7075746174696F6E292E
		Private Function RequiresHorizontalScrollbar() As Boolean
		  /// Returns True if a horizontal scrollbar is required (inexpensive computation).
		  
		  Return mCachedRequiredBufferWidth > Self.Width
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732054727565206966206120766572746963616C207363726F6C6C6261722069732072657175697265642E20496E657870656E7369766520636F6D7075746174696F6E2E
		Private Function RequiresVerticalScrollbar() As Boolean
		  /// Returns True if a vertical scrollbar is required. Inexpensive computation.
		  
		  If LineManager.LineCount = mMaxVisibleLines Then Return False
		  
		  // Compute the maximum vertical scrollbar value.
		  Var vScrollBarMax As Integer = Max(LineManager.LineCount - mMaxVisibleLines, mFirstVisibleLine)
		  
		  // Edge case.
		  If vScrollBarMax = 1 And FirstVisibleLine = 1 Then Return False
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363726F6C6C73207468652063616E76617320646F776E20606C696E6573546F5363726F6C6C60206C696E65732E
		Sub ScrollDown(linesToScroll As Integer, moveCaret As Boolean, shouldInvalidate As Boolean = True)
		  /// Scrolls the canvas down `linesToScroll` lines.
		  ///
		  /// If `moveCaret` is True then the caret will be moved down by the number of lines we scroll down.
		  /// If `shouldInvalidate` is False then the canvas will not be immediately invalidated.
		  
		  // Cache the last fully visible line number as it's computed.
		  Var lastVisible As Integer = LastFullyVisibleLineNumber
		  
		  // No need to scroll if the last line is already visible.
		  If lastVisible = LineManager.LastLine.Number Then
		    If moveCaret Then
		      // Move the caret to the end of the end of the document.
		      MoveCaretToPos(LineManager.LastLine.Finish, shouldInvalidate)
		    End If
		    Return
		  End If
		  
		  // Cache the number of visible lines as it's computed.
		  Var linesVisible As Integer = MaxVisibleLines(LineHeight)
		  
		  // The maximum number of lines we can ever scroll down is the number of 
		  // lines that are visible on the screen. However, we will never scroll 
		  // past the last line.
		  linesToScroll = XUIMaths.Clamp(linesToScroll, 0, linesVisible)
		  
		  If moveCaret Then
		    // Move the caret down by the same number of lines, to the same 
		    // column position.
		    // The `MoveCaretToColumn` method will invalidate the canvas for us.
		    MoveCaretToColumn(_
		    Min(CaretLineNumber + linesToScroll, LineManager.LastLine.Number), _
		    CaretColumn, shouldInvalidate)
		  Else
		    FirstVisibleLine = FirstVisibleLine + linesToScroll
		    NeedsFullRedraw = True
		    If shouldInvalidate Then Refresh
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363726F6C6C73207468652063616E76617320646F776E2061207061676520616E64206F7074696F6E616C6C79206D6F7665732074686520636172657420646F776E2061732077656C6C2E
		Sub ScrollPageDown(moveCaret As Boolean, shouldInvalidate As Boolean = True)
		  /// Scrolls the canvas down a page and optionally moves the caret down as well.
		  ///
		  /// If `moveCaret` is True then the caret will be moved down by the number of lines we scroll down.
		  /// If `shouldInvalidate` is False then the canvas will **not** be immediately invalidated.
		  
		  // Cache the last fully visible line number as it's computed.
		  Var lastVisible As Integer = LastFullyVisibleLineNumber
		  
		  // No need to scroll if the last line is already visible.
		  If lastVisible = LineManager.LastLine.Number Then
		    If moveCaret Then
		      // Move the caret to the end of the end of the document.
		      MoveCaretToPos(LineManager.LastLine.Finish, shouldInvalidate)
		    End If
		    Return
		  End If
		  
		  // Cache the number of visible lines as it's computed.
		  Var linesVisible As Integer = MaxVisibleLines(LineHeight)
		  
		  // The maximum number of lines we can ever scroll down is the number of lines that 
		  // are visible on the screen. However, we will never scroll past the last line.
		  Var linesToScroll As Integer
		  If lastVisible + linesVisible < LineManager.LineCount + 1 Then
		    // There are sufficient lines off screen that we can scroll an entire page.
		    linesToScroll = linesVisible
		  Else
		    linesToScroll = LineManager.LineCount - lastVisible
		  End If
		  
		  If moveCaret Then
		    // Move the caret down by the same number of lines, to the same column position.
		    // The `MoveCaretToColumn` method will invalidate the canvas for us.
		    MoveCaretToColumn(Min(CaretLineNumber + linesToScroll, LineManager.LastLine.Number), _
		    CaretColumn, shouldInvalidate)
		  Else
		    FirstVisibleLine = FirstVisibleLine + linesToScroll
		    NeedsFullRedraw = True
		    If shouldInvalidate Then Refresh
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363726F6C6C73207468652063616E7661732075702061207061676520616E64206F7074696F6E616C6C79206D6F766573207468652063617265742075702061732077656C6C2E
		Sub ScrollPageUp(moveCaret As Boolean, shouldInvalidate As Boolean = True)
		  /// Scrolls the canvas up a page and optionally moves the caret up as well.
		  ///
		  /// If `moveCaret` is True then the caret will be moved up by the number of lines we scroll up.
		  /// If `shouldInvalidate` is False then the canvas will not be immediately invalidated.
		  
		  // No need to scroll if the first line is already visible.
		  If FirstVisibleLine = 1 Then
		    If moveCaret Then
		      // Move the caret to the beginning of the document.
		      MoveCaretToPos(0, shouldInvalidate)
		    End If
		    Return
		  End If
		  
		  // Cache the number of visible lines as it's computed.
		  Var linesVisible As Integer = MaxVisibleLines(LineHeight)
		  
		  // The maximum number of lines we can ever scroll up is the number of lines that 
		  // are visible on the screen. However, we will never scroll past the first line.
		  Var linesToScroll As Integer
		  If FirstVisibleLine - linesVisible >= 1 Then
		    // There are sufficient lines off screen that we can scroll an entire page up.
		    linesToScroll = linesVisible
		  Else
		    linesToScroll = FirstVisibleLine - 1
		  End If
		  
		  If moveCaret Then
		    // Move the caret up by the same number of lines, to the same column position.
		    // The `MoveCaretToColumn` method will invalidate the canvas for us.
		    MoveCaretToColumn(Max(CaretLineNumber - linesToScroll, 1), CaretColumn, shouldInvalidate)
		  Else
		    FirstVisibleLine = FirstVisibleLine - linesToScroll
		    NeedsFullRedraw = True
		    If shouldInvalidate Then Refresh
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363726F6C6C73207468652063616E76617320286966206E65636573736172792920746F207468652063757272656E7420636172657420706F736974696F6E2E
		Sub ScrollToCaretPos(shouldInvalidate As Boolean = False)
		  /// Scrolls the canvas (if necessary) to the current caret position.
		  ///
		  /// If `shouldInvalidate` is True then the canvas will immediately redraw.
		  
		  If mBackBuffer = Nil Then Return
		  
		  #If TargetMacOS
		    // Get the absolute X coordinate of the caret.
		    Var caretX As Integer = CaretXCoordinate
		    
		    // Do we need to scroll horizontally?
		    If CaretPosition = mCurrentLine.Start Then
		      // Ensure we can see the gutter when the caret is at the beginning of the line.
		      ScrollPosX = 0
		    ElseIf caretX - mScrollPosX + RIGHT_SCROLL_PADDING > Self.Width Then
		      // Scroll right.
		      Var widthDiff As Double = mCachedRequiredBufferWidth - Self.Width
		      ScrollPosX = XUIMaths.Clamp(mScrollPosX + caretX - Self.Width + RIGHT_SCROLL_PADDING, 0, widthDiff)
		    ElseIf caretX < mScrollPosX Then
		      // Scroll left.
		      ScrollPosX = Max(caretX - LEFT_SCROLL_PADDING, 0)
		    ElseIf mScrollPosX > mCachedRequiredBufferWidth - Me.Width Then
		      ScrollPosX = Max(caretX - LEFT_SCROLL_PADDING, 0)
		    End If
		    
		    // Do we need to scroll vertically?
		    If CaretLineNumber < FirstVisibleLine Or CaretLineNumber >LastFullyVisibleLineNumber Then
		      If CaretLineNumber = LastFullyVisibleLineNumber + 1 Then
		        // Scroll down a single line.
		        mScrollPosY = mScrollPosY + mLineHeight
		      ElseIf CaretLineNumber = FirstVisibleLine - 1 Then
		        // Scroll up a single line.
		        mScrollPosY = mScrollPosY - mLineHeight
		      Else
		        mScrollPosY = CaretLineNumber * mLineHeight
		      End If
		      mScrollPosY = XUIMaths.Clamp(mScrollPosY, 0, (LineManager.LineCount * mLineHeight) - mLineHeight)
		    End If
		    
		    // Scroll.
		    ScrollToPoint(ScrollPosX, mScrollPosY)
		    
		    // Update ScrollPosY.
		    mScrollPosY = ScrollY_
		    
		    If shouldInvalidate Then Refresh
		    
		  #Else
		    #Pragma Warning "CHECK: Does this work as expected on Windows & Linux?"
		    Var cachedMaxVisible As Integer = MaxVisibleLines(mLineHeight)
		    
		    // ===============================
		    // HORIZONTAL SCROLLING
		    // ===============================
		    // Get the X coord of the caret.
		    Var x As Integer = CaretXCoordinate
		    If CaretPosition = mCurrentLine.Start Then
		      // Make sure we can see the gutter when the caret is at the beginning of the line.
		      ScrollPosX = 0
		    ElseIf x - mScrollPosX + RIGHT_SCROLL_PADDING > Self.Width Then
		      // Scroll right.
		      Var widthDiff As Double = mCachedRequiredBufferWidth - Self.Width
		      ScrollPosX = XUIMaths.Clamp(mScrollPosX + x - Self.Width + RIGHT_SCROLL_PADDING, 0, widthDiff)
		    ElseIf x < mScrollPosX Then
		      // Scroll left.
		      ScrollPosX = Max(x - LEFT_SCROLL_PADDING, 0)
		    ElseIf mScrollPosX > mCachedRequiredBufferWidth - Me.Width Then
		      ScrollPosX = Max(x - LEFT_SCROLL_PADDING, 0)
		    End If
		    
		    // ===============================
		    // VERTICAL SCROLLING
		    // ===============================
		    If CaretLineNumber < FirstVisibleLine Then
		      // We need to scroll up.
		      FirstVisibleLine = CaretLineNumber
		      NeedsFullRedraw = True
		    ElseIf FirstVisibleLine > 1 And cachedMaxVisible = LineManager.LineCount Then
		      FirstVisibleLine = 1
		    ElseIf Not LineFullyVisible(mCurrentLine) Then
		      // We need to scroll down until the caret line is the lowest most visible line.
		      FirstVisibleLine = CaretLineNumber - cachedMaxVisible + 1
		      NeedsFullRedraw = True
		    End If
		    
		    If shouldInvalidate Then Refresh
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5363726F6C6C73207468652063616E766173207570205B6C696E6573546F5363726F6C6C5D206C696E65732E
		Sub ScrollUp(linesToScroll As Integer, moveCaret As Boolean, shouldInvalidate As Boolean = True)
		  /// Scrolls the canvas up `linesToScroll` lines.
		  ///
		  /// If `moveCaret` is True then the caret will be moved up by the number of lines we scroll up.
		  /// If `shouldInvalidate` is False then the canvas will not be immediately invalidated.
		  
		  // No need to scroll if the first line is already visible.
		  If FirstVisibleLine = 1 Then
		    If moveCaret Then
		      // Move the caret to the beginning of the document.
		      MoveCaretToPos(0, shouldInvalidate)
		    End If
		    Return
		  End If
		  
		  // Cache the number of visible lines as it's computed.
		  Var linesVisible As Integer = MaxVisibleLines(LineHeight)
		  
		  // The maximum number of lines we can ever scroll up is the number of lines 
		  // that are visible on the screen. However, we will never scroll past 
		  // the first line.
		  linesToScroll = XUIMaths.Clamp(linesToScroll, 0, linesVisible)
		  
		  If moveCaret Then
		    // Move the caret up by the same number of lines, to the same column position.
		    // The `MoveCaretToColumn` method will invalidate the canvas for us.
		    MoveCaretToColumn(Max(CaretLineNumber - linesToScroll, 1), CaretColumn, shouldInvalidate)
		  Else
		    FirstVisibleLine = FirstVisibleLine - linesToScroll
		    NeedsFullRedraw = True
		    If shouldInvalidate Then Refresh
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53656C656374732065766572797468696E6720696E2074686520656469746F722E
		Sub SelectAll(shouldInvalidate As Boolean = True)
		  /// Selects everything in the editor.
		  ///
		  /// If `shouldInvalidate` is True then the editor will immediately refresh.
		  
		  CurrentUndoID = System.Ticks
		  
		  MoveCaretToPos(LineManager.LastLine.Finish, False)
		  CurrentSelection = New XUICETextSelection(0, 0, CaretPosition, Self)
		  
		  If shouldInvalidate Then Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 53656C6563747320616C6C20776869746573706163652061726F756E64207468652063757272656E7420636172657420706F736974696F6E206F6E2074686520636172657427732063757272656E74206C696E652E
		Private Sub SelectWhitespaceAroundCaret(shouldInvalidate As Boolean)
		  /// Selects all whitespace around the current caret position on the caret's current line.
		  ///
		  /// If `shouldInvalidate` is True then the canvas will be invalidated. If False 
		  /// then it's merely marked for a full redraw.
		  
		  // Clear the current selection and mark for redrawing.
		  CurrentSelection = Nil
		  
		  If mCurrentLine.Length = 0 Then
		    If shouldInvalidate Then Refresh
		    Return
		  End If
		  
		  // Find where the whitespace begins on this line.
		  Var startCol As Integer = CaretColumn
		  Var iStart As Integer = Min(CaretColumn, mCurrentLine.Characters.LastIndex)
		  For i As Integer = iStart DownTo 0
		    If mCurrentLine.Characters(i) <> " " Then
		      Exit
		    Else
		      startCol = i
		    End If
		  Next i
		  
		  // Find where the whitespace ends.
		  Var endCol As Integer = startCol + 1
		  Var iMax As Integer = mCurrentLine.Characters.LastIndex
		  For i As Integer = CaretColumn To iMax
		    If mCurrentLine.Characters(i).IsWhiteSpace Then
		      endCol = i 
		    Else
		      Exit
		    End If
		  Next i
		  If CaretPosition = mCurrentLine.Finish Then
		    endCol = mCurrentLine.Characters.LastIndex + 1
		  Else
		    endCol = endCol + 1
		  End If
		  
		  // Convert these column positions to caret positions.
		  Var startPos As Integer = mCurrentLine.Start + startCol
		  Var endPos As Integer = mCurrentLine.Start + endCol
		  
		  // Select between these positions.
		  mCurrentSelection = New XUICETextSelection(startPos, startPos, endPos, Self)
		  
		  // Move the caret to the selection's anchor point.
		  MoveCaretToPos(mCurrentSelection.Anchor)
		  
		  If shouldInvalidate Then Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 53656C656374732074686520776F7264207468652063617265742069732077697468696E20616E64206D61726B73207468652063616E76617320666F7220726564726177696E672E
		Private Sub SelectWordAtCaret(shouldInvalidate As Boolean)
		  /// Selects the word the caret is within and marks the canvas for redrawing.
		  /// 
		  /// If `shouldInvalidate` is True then the canvas will be invalidated. 
		  /// If False then it is merely marked for a full redraw.
		  
		  // Clear the current selection and mark for redrawing.
		  CurrentSelection = Nil
		  
		  If CurrentLine.Length = 0 Then
		    If shouldInvalidate Then Refresh
		    Return
		  End If
		  
		  // Find the first alphanumeric character before the caret
		  Var startCol As Integer = CaretColumn
		  Var iStart As Integer = Min(CaretColumn, mCurrentLine.Characters.LastIndex)
		  For i As Integer = iStart DownTo 0
		    If Not mCurrentLine.Characters(i).IsLetterOrDigit Then
		      Exit
		    Else
		      startCol = i
		    End If
		  Next i
		  
		  // Find where the alphanumeric characters end.
		  Var endCol As Integer = startCol + 1
		  Var iMax As Integer = mCurrentLine.Characters.LastIndex
		  For i As Integer = CaretColumn To iMax
		    If Not mCurrentLine.Characters(i).IsLetterOrDigit Then
		      Exit
		    Else
		      endCol = i
		    End If
		  Next i
		  endCol = endCol + 1
		  
		  // Convert these column positions to caret positions.
		  Var startPos As Integer = mCurrentLine.Start + startCol
		  Var endPos As Integer = mCurrentLine.Start + endCol
		  
		  // Select between these positions.
		  mCurrentSelection = New XUICETextSelection(startPos, startPos, endPos, Self)
		  
		  // Move the caret to the selection's anchor point.
		  MoveCaretToPos(mCurrentSelection.Anchor)
		  
		  If shouldInvalidate Then Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520666F6E742070726F70657274696573206F662060676020746F207468652073706563696669656420746F6B656E20607374796C65602E
		Sub SetGraphicsStyle(g As Graphics, style As XUICETokenStyle)
		  /// Sets the font properties of `g` to the specified token `style`.
		  
		  g.Bold = style.Bold
		  g.DrawingColor = style.Colour
		  g.FontName = FontName
		  g.FontSize = FontSize
		  g.Italic = style.Italic
		  g.Underline = style.Underline
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 53686F777320746865206175746F636F6D706C65746520706F7075702061742074686520636172657420706F736974696F6E2E
		Private Sub ShowAutocompletePopup()
		  /// Shows the autocomplete popup at the caret position.
		  
		  // Get the (x, y) coordinates of the top left aspect of the caret, relative to the code editor.
		  Var x, y As Double = 0
		  XYAtCaretPos(CaretPosition, x, y)
		  
		  // Compute the maximum height available for the popup. Usually we'll want to display the popup beneath
		  // the caret but if the available height is too small we'll display it above the caret.
		  Var availableHeightBelow As Integer = Self.Window.Height - Self.Top - y
		  Var availableHeightAbove As Integer = Self.Top + y
		  Var minOptionsToShow As Integer = If(AutocompleteData.Options.Count = 1, 1, 2)
		  Var displayBelowCaret As Boolean = True
		  Var maxPopupHeight As Integer
		  If availableHeightBelow < availableHeightAbove Then
		    If availableHeightBelow < mAutocompletePopup.AutocompleteOptionHeight * minOptionsToShow Then
		      maxPopupHeight = availableHeightAbove
		      displayBelowCaret = False
		    Else
		      maxPopupHeight = availableHeightBelow
		    End If
		  Else
		    maxPopupHeight = availableHeightBelow
		  End If
		  
		  // Compute the maximum width for the popup.
		  Var maxPopupWidth As Integer = Self.Width
		  
		  // Tell the popup to update itself using this tag canvas' public autocomplete data.
		  mAutocompletePopup.Update(maxPopupWidth, maxPopupHeight)
		  
		  // ==================
		  // Popup x coordinate
		  // ==================
		  If x + mAutocompletePopup.Width + POPUP_PADDING > (Self.Width + ScrollPosX) Then
		    x = Self.Width - POPUP_PADDING - mAutocompletePopup.Width
		  End If
		  x = x + Self.Left
		  
		  // ==================
		  // Popup y coordinate
		  // ==================
		  If displayBelowCaret Then
		    // Position the popup beneath the caret.
		    y = y + mLineHeight + Self.Top
		  Else
		    // We need to draw above the caret.
		    y = y - mAutocompletePopup.Height + Self.Top
		  End If
		  
		  mAutocompletePopup.Left = x
		  mAutocompletePopup.Top = y
		  If mAutocompletePopup.SelectedIndex = -1 Then mAutocompletePopup.SelectedIndex = 0
		  mAutocompletePopup.Visible = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320612074616220636861726163746572732061732061206669786564207769647468206F6620737061636520636861726163746572732E2044657465726D696E65642062792060537061636573506572546162602E
		Private Function TabToSpaces() As String
		  /// Returns a tab characters as a fixed width of space characters. Determined by `SpacesPerTab`.
		  
		  If SpacesPerTab = 2 Then
		    Return "  "
		  ElseIf SpacesPerTab = 4 Then
		    Return "    "
		  Else
		    Var s() As String
		    For i As Integer = 1 To SpacesPerTab
		      s.Add(" ")
		    Next i
		    Return String.FromArray(s)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468652075736572206973207374696C6C2074686F7567687420746F20626520747970696E672E
		Function Typing() As Boolean
		  /// True if the user is still thought to be typing.
		  ///
		  /// We make this decision based on the time the last key was depressed
		  /// and released as well as an acceptable interval between depressions.
		  
		  If System.Ticks - mLastKeyDownTicks > TYPING_SPEED_TICKS Then
		    Return False
		  End If
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70757465732028427952656629207468652063616E76617320782C207920636F6F7264696E617465732061742074686520302D626173656420606361726574506F73602E
		Private Sub XYAtCaretPos(caretPos As Integer, ByRef x As Double, ByRef y As Double)
		  /// Computes (ByRef) the canvas x, y coordinates at the 0-based `caretPos`.
		  
		  Var line As XUICELine = LineManager.LineAt(LineManager.LineNumberForCaretPos(caretPos))
		  
		  // X
		  Var sx As Integer = mGutterWidth + LINE_CONTENTS_LEFT_PADDING + _
		  line.IndentWidth(mBackBuffer.Graphics.TextWidth("_"))
		  x = sx + line.WidthToCaretPos(caretPos, mBackBuffer.Graphics)
		  
		  // Y
		  y = (line.Number - FirstVisibleLine) * LineHeight
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 54686520636F646520656469746F722069732061736B696E6720666F72206175746F636F6D706C6574696F6E206F7074696F6E7320666F72207468652073706563696669656420607072656669786020617420606361726574436F6C756D6E60206F6E206C696E65206E756D626572206063617265744C696E65602E20596F752073686F756C642072657475726E204E696C20696620746865726520617265206E6F6E652E
		Event AutocompleteDataForPrefix(prefix As String, caretLine As Integer, caretColumn As Integer) As XUICEAutocompleteData
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865207465787420636F6E74656E7473206F662074686520656469746F7220686173206368616E6765642E
		Event ContentsDidChange()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865207573657220636F6E7465787574616C20636C69636B65642028726967687420636C69636B65642920696E736964652074686520656469746F722061742074686520706173736564206C6F63616C20636F6F7264696E617465732E
		Event DidContextualClick(x As Integer, y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520656469746F722069732061626F757420746F20626520646973706C617965642E
		Event Opening()
	#tag EndHook


	#tag Note, Name = About
		A powerful and highly customisable code editor control based on the open source `TextInputCanvas` control.
		It supports themes, multiple languages, autocompletion and features a robust undo engine.
	#tag EndNote


	#tag Property, Flags = &h0, Description = 547275652069662074686520656469746F7220737570706F727473206175746F636F6D706C6574696F6E2E
		AllowAutocomplete As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E20746865206175746F636F6D706C65746520656E67696E652077696C6C20616C736F2066756E6374696F6E20696E7369646520636F6D6D656E74732E
		AllowAutoCompleteInComments As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E207468652063616E7661732077696C6C20766572746963616C6C79207363726F6C6C2066617374657220696620746865206D6F75736520776865656C206973206D6F766564206661737465722E
		AllowInertialScrolling As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520656469746F722077696C6C206175746F6D61746963616C6C7920636C6F736520706172656E7468657365732C2073717561726520627261636B65747320616E64206375726C7920627261636B657473207768656E20616E206F70656E696E6720627261636B657420697320656E746572656420616E6420746865206361726574206973206E6F7420696E206120636F6D6D656E742E
		AutocloseBrackets As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206B6579626F6172642073686F7274637574207573656420746F2074726967676572206175746F636F6D706C6574696F6E2E
		AutocompleteCombo As XUICodeEditor.AutocompleteCombos = XUICodeEditor.AutocompleteCombos.Tab
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206175746F636F6D706C657465206F7074696F6E7320666F722070726566697820696E2066726F6E74206F66207468652063617265742E204D6179206265204E696C2E
		AutocompleteData As XUICEAutocompleteData
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520666F6E742066616D696C7920746F2075736520666F72206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		AutocompletePopupFontName As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206175746F636F6D706C65746520706F707570206F7074696F6E20666F6E742073697A652E
		AutocompletePopupFontSize As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520656469746F722773206261636B67726F756E6420636F6C6F75722E
		#tag Getter
			Get
			  Return Theme.BackgroundColor
			End Get
		#tag EndGetter
		BackgroundColor As Color
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652063617265742073686F756C6420706572696F646963616C6C7920626C696E6B2E
		BlinkCaret As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520656469746F72277320626F726465722028696620656E61626C6564292E
		#tag Getter
			Get
			  // Prevent a Nil object exception.
			  If mBorderColor = Nil Then
			    mBorderColor = New ColorGroup(Color.Black, Color.Black)
			  End If
			  
			  Return mBorderColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mBorderColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		BorderColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636172657420636F6C6F75722E
		#tag Getter
			Get
			  Return Theme.CaretColor
			  
			End Get
		#tag EndGetter
		CaretColour As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E7420302D626173656420636F6C756D6E2074686520636172657420697320696E2E
		#tag Getter
			Get
			  Return mCaretPosition - mCurrentLine.Start
			  
			End Get
		#tag EndGetter
		CaretColumn As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4461746120726571756972656420666F722064726177696E672074686520626C6F636B20747970652063617265742E
		CaretData As XUICECaretData
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620746865206C696E65207468652063617265742069732063757272656E746C79206F6E2E
		#tag Getter
			Get
			  Return mCurrentLine.Number
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Sets the line that the caret is currently on. The caret will be the set
			  /// to the start of the line.
			  
			  If value < 1 Then value = 1
			  
			  If mCurrentLine <> Nil Then
			    // Mark the current line as dirty (since the caret has left it).
			    mCurrentLine.IsDirty = True
			  End If
			  
			  // Get the line we're now on.
			  mCurrentLine = LineManager.LineAt(value)
			  
			  // Put the caret at the beginning of this line.
			  mCaretPosition = mCurrentLine.Start
			  
			  // Mark the new current line as dirty (since the caret is blinking on it).
			  mCurrentLine.IsDirty = True
			  
			End Set
		#tag EndSetter
		CaretLineNumber As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E7420706F736974696F6E206F662074686520636172657420696E2074686520656469746F722028302D6261736564292E
		#tag Getter
			Get
			  Return mCaretPosition
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Update the new caret line number.
			  CaretLineNumber = LineManager.LineNumberForCaretPos(value)
			  
			  // Store the new position.
			  mCaretPosition = value
			  
			  // Fetch autocomplete suggestions.
			  FetchAutocompleteData
			  
			End Set
		#tag EndSetter
		CaretPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652074797065206F66206361726574207468652063616E7661732073686F756C64207573652E
		#tag Getter
			Get
			  Return mCaretType
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCaretType = value
			  Me.Refresh
			  
			End Set
		#tag EndSetter
		CaretType As CaretTypes
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206162736F6C757465205820636F6F7264696E617465206F6620746865206361726574206174206974732063757272656E7420706F736974696F6E2028636F6D707574656420616E6420657870656E73697665292E
		#tag Getter
			Get
			  Return mGutterWidth + LINE_CONTENTS_LEFT_PADDING + _
			  mCurrentLine.WidthToCaretPos(CaretPosition, mBackBuffer.Graphics)
			End Get
		#tag EndGetter
		CaretXCoordinate As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21, Description = 4D617073206F70656E696E6720627261636B6574732028652E672E20225B222920746F20746865697220636C6F7365722028652E672E20225D22292E204B6579203D206F70656E696E6720627261636B65742028737472696E67292C2056616C7565203D206D61746368696E6720636C6F73696E6720627261636B65742028737472696E67292E
		#tag Getter
			Get
			  Static d As New Dictionary( _
			  "(" : ")", _
			  "[" : "]", _
			  "{" : "}" )
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Private ClosingBracketForOpener As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207465787420636F6E74656E7473206F662074686520656469746F722E
		#tag Getter
			Get
			  Return LineManager.Contents
			End Get
		#tag EndGetter
		Contents As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652074797065206F6620636F6E74656E747320696E2074686520656469746F7220284D61726B646F776E206F7220736F7572636520636F6465292E
		ContentType As XUICodeEditor.ContentTypes = XUICodeEditor.ContentTypes.SourceCode
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C696E652074686174207468652063617265742069732063757272656E746C79206F6E2E
		#tag Getter
			Get
			  Return mCurrentLine
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCurrentLine = value
			  
			End Set
		#tag EndSetter
		CurrentLine As XUICELine
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520746F20686967686C69676874207468652063757272656E74206C696E652028696620656E61626C6564292E
		#tag Getter
			Get
			  Return theme.CurrentLineHighlightColor
			End Get
		#tag EndGetter
		CurrentLineHighlightColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865206C696E65206E756D626572206966206974206973207468652063757272656E74206C696E652E
		#tag Getter
			Get
			  Return theme.CurrentLineNumberColor
			End Get
		#tag EndGetter
		CurrentLineNumberColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E746C792073656C656374656420746578742072616E676520286F72204E696C206966206E6F7468696E672073656C6563746564292E
		#tag Getter
			Get
			  Return mCurrentSelection
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCurrentSelection = value
			  NeedsFullRedraw = True
			  
			  
			End Set
		#tag EndSetter
		CurrentSelection As XUICETextSelection
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865204944206F66207468652067726F7570206F6620756E646F20616374696F6E7320746861742061726520636F6E73696465726564206F6E6520226576656E742220666F722074686520707572706F736573206F6620756E646F2E
		#tag Getter
			Get
			  Return mCurrentUndoID
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCurrentUndoID = value
			  
			End Set
		#tag EndSetter
		CurrentUndoID As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C696E65206E756D62657220746F20686967686C6967687473206173206265696E672063757272656E746C792064656275676765642E2053657420746F2030206966206E6F206C696E652073686F756C6420626520686967686C69676874656420696E2074686973207761792E
		#tag Getter
			Get
			  Return mDebuggingLine
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDebuggingLine = XUIMaths.Clamp(value, 0, Self.LineManager.LineCount)
			  NeedsFullRedraw = True
			End Set
		#tag EndSetter
		DebuggingLine As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F757220746F20757365207768656E20686967686C69676874696E672061206C696E6520666F7220646562756767696E672E
		#tag Getter
			Get
			  Return theme.DebugLineColor
			End Get
		#tag EndGetter
		DebugLineColour As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54727565206966206C696E65206E756D626572732073686F756C6420626520646973706C617965642E
		#tag Getter
			Get
			  Return mDisplayLineNumbers
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDisplayLineNumbers = value
			  NeedsFullRedraw = True
			  Refresh
			  
			End Set
		#tag EndSetter
		DisplayLineNumbers As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E2074686520656469746F722077696C6C206472617720626C6F636B206C696E657320666F7220736F7572636520636F64652E
		#tag Getter
			Get
			  Return mDrawBlockLines
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDrawBlockLines = value
			  NeedsFullRedraw = True
			  Refresh
			End Set
		#tag EndSetter
		DrawBlockLines As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620746865206C696E652076697369626C652061742074686520746F70206F66207468652063616E7661732E20416C746572656420627920766572746963616C207363726F6C6C696E672E
		#tag Getter
			Get
			  Return mFirstVisibleLine
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFirstVisibleLine = XUIMaths.Clamp(value, 1, LineManager.LineCount)
			  NeedsFullRedraw = True
			  
			End Set
		#tag EndSetter
		FirstVisibleLine As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520666F6E742066616D696C79207573656420696E207468652063616E7661732E
		#tag Getter
			Get
			  Return mFontName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFontName = value
			  NeedsFullRedraw = True
			  Refresh
			  
			End Set
		#tag EndSetter
		FontName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520666F6E742073697A6520746F2075736520666F72207465787420696E2074686520656469746F722E
		#tag Getter
			Get
			  Return mFontSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFontSize = value
			  NeedsFullRedraw = True
			  Refresh
			  
			End Set
		#tag EndSetter
		FontSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520666F726D6174746572207573656420746F20666F726D617420746578742E
		#tag Getter
			Get
			  Return mFormatter
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFormatter = value
			  LineManager.TokeniseAllLines
			  NeedsFullRedraw = True
			  Me.Refresh(True)
			End Set
		#tag EndSetter
		Formatter As XUICEFormatter
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E206120626F726465722077696C6C20626520647261776E2061742074686520626F74746F6D206F662074686520656469746F722E
		#tag Getter
			Get
			  Return mHasBottomBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasBottomBorder = value
			  
			  NeedsFullRedraw = True
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		HasBottomBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686520656469746F722063757272656E746C79206861732074686520666F6375732E
		#tag Getter
			Get
			  Return mHasFocus
			  
			End Get
		#tag EndGetter
		HasFocus As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E206120626F726465722077696C6C20626520647261776E20617420746865206C6566742065646765206F662074686520656469746F722E
		#tag Getter
			Get
			  Return mHasLeftBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasLeftBorder = value
			  
			  NeedsFullRedraw = True
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		HasLeftBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E206120626F726465722077696C6C20626520647261776E206174207468652072696768742065646765206F662074686520656469746F722E
		#tag Getter
			Get
			  Return mHasRightBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasRightBorder = value
			  
			  NeedsFullRedraw = True
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		HasRightBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E206120626F726465722077696C6C20626520647261776E2061742074686520746F70206F662074686520656469746F722E
		#tag Getter
			Get
			  Return mHasTopBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasTopBorder = value
			  
			  NeedsFullRedraw = True
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		HasTopBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E20746865206C696E65207468652063617265742069732063757272656E746C79206F6E2077696C6C20626520686967686C6967687465642E
		#tag Getter
			Get
			  Return mHighlightCurrentLine
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHighlightCurrentLine = value
			  NeedsFullRedraw = True
			  
			End Set
		#tag EndSetter
		HighlightCurrentLine As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E2064656C696D697465727320287375636820617320607B6020616E6420607D60292077696C6C20626520686967686C6967687465642061726F756E64207468652063617265742E204F6E6C7920737570706F7274656420627920736F6D6520666F726D6174746572732E
		#tag Getter
			Get
			  Return mHighlightDelimitersAroundCaret
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHighlightDelimitersAroundCaret = value
			  NeedsFullRedraw = True
			  Refresh
			End Set
		#tag EndSetter
		HighlightDelimitersAroundCaret As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 496E7465726E616C6C792073657420746F2054727565207768656E657665722074686520746F6B656E69736174696F6E20686173206F636375727265642E
		JustTokenised As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C696E65206E756D626572206F6620746865206C617374202A66756C6C792A2076697369626C65206C696E652E
		#tag Getter
			Get
			  // Find the lowest-most fully visible line.
			  Var i As Integer = mFirstVisibleLine + MaxVisibleLines(LineHeight) - 1
			  Return Min(i, LineManager.LastLine.Number)
			End Get
		#tag EndGetter
		LastFullyVisibleLineNumber As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652074696D65202866726F6D206053797374656D2E4D6963726F7365636F6E64736029207468617420746865206C6173742060466F726D61747465722E506172736528296020696E766F636174696F6E206F636375727265642E
		LastParseMicroseconds As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41207265666572656E636520746F207468697320636F646520656469746F722773206C696E65206D616E616765722E
		LineManager As XUICELineManager
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C696E65206E756D62657220636F6C6F757220666F72206C696E6573207468617420617265206E6F74207468652063757272656E74206C696E652E
		#tag Getter
			Get
			  Return theme.LineNumberColor
			End Get
		#tag EndGetter
		LineNumberColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C696E65206E756D62657220666F6E742073697A652E204D757374206265206C657373207468616E2060466F6E7453697A65602E
		#tag Getter
			Get
			  Return mLineNumberFontSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mLineNumberFontSize = value
			  NeedsFullRedraw = True
			  Refresh
			  
			End Set
		#tag EndSetter
		LineNumberFontSize As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520746865726520686173206265656E2061206368616E676520696E20746865206C656E677468206F6620746865206C6F6E67657374206C696E652E
		LongestLineChanged As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320636F646520656469746F722773206175746F636F6D706C65746520706F70757020636F6E74726F6C2E
		Private mAutocompletePopup As XUICodeEditorAutocompletePopup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652062756666657220776520647261772074686520656469746F7220636F6E74656E747320746F20616E64207468656E20626C697420746F207468652073637265656E2065616368206672616D652E
		Private mBackBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572206F662074686520656469746F72277320626F726465722028696620656E61626C6564292E
		Private mBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41206361636865206F66207468652072657175697265642062756666657220776964746820636F6D707574656420696E20746865206C61737420605061696E7460206576656E742E
		Private mCachedRequiredBufferWidth As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652074696D657220726573706F6E7369626C6520666F7220626C696E6B696E67207468652063617265742E
		Private mCaretBlinker As Timer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520604361726574506F736974696F6E6020636F6D70757465642070726F70657274792E
		Private mCaretPosition As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520604361726574547970656020636F6D70757465642070726F70657274792E
		Private mCaretType As CaretTypes
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652063617265742068617320626C696E6B65642076697369626C652C2046616C7365206966206E6F742E
		Private mCaretVisible As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F7220746865206043757272656E744C696E656020636F6D70757465642070726F70657274792E
		Private mCurrentLine As XUICELine
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F7220746865206043757272656E7453656C656374696F6E6020636F6D70757465642070726F70657274792E
		Private mCurrentSelection As XUICETextSelection
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F7220746865206043757272656E74556E646F49446020636F6D70757465642070726F70657274792E
		Private mCurrentUndoID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C696E65206E756D62657220746F20686967686C6967687473206173206265696E672063757272656E746C792064656275676765642E2053657420746F2030206966206E6F206C696E652073686F756C6420626520686967686C69676874656420696E2074686973207761792E
		Private mDebuggingLine As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 52756E7320706572696F646963616C6C7920746F2075706461746520746865206E6561726573742064656C696D697465727320746F2074686520636172657420706F736974696F6E2E
		Private mDelimiterTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060446973706C61794C696E654E756D626572736020636F6D70757465642070726F70657274792E
		Private mDisplayLineNumbers As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206D6F7573652069732063757272656E746C79206472616767696E672E
		Private mDragging As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53657420746F205472756520696E204D6F757365446F776E2069662074686520757365722068617320636C69636B65642074686520686F72697A6F6E74616C207363726F6C6C626172207468756D62206F6E2057696E646F77732026204C696E75782E
		Private mDraggingHorizontalScrollbarThumb As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53657420746F205472756520696E204D6F757365446F776E2069662074686520757365722068617320636C69636B65642074686520766572746963616C207363726F6C6C626172207468756D62206F6E2057696E646F77732026204C696E75782E
		Private mDraggingVerticalScrollbarThumb As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2074686520656469746F722077696C6C206472617720626C6F636B206C696E657320666F7220736F7572636520636F64652E204261636B7320746865206044726177426C6F636B4C696E65736020636F6D70757465642070726F70657274792E
		Private mDrawBlockLines As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060466972737456697369626C654C696E656020636F6D70757465642070726F70657274792E
		Private mFirstVisibleLine As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060466F6E744E616D656020636F6D70757465642070726F70657274792E
		Private mFontName As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060466F6E7453697A656020636F6D70757465642070726F70657274792E
		Private mFontSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520666F726D6174746572207573656420746F20666F726D617420746578742E204261636B73207468652060466F726D61747465726020636F6D70757465642070726F70657274792E
		Private mFormatter As XUICEFormatter
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206361636865642063616E766173206047726170686963732E5363616C6558602076616C75652E
		Private mGraphicsScaleX As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206361636865642063616E766173206047726170686963732E5363616C6559602076616C75652E
		Private mGraphicsScaleY As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 416E20696E7465726E616C206361636865206F66207468652067757474657220776964746820696E20706978656C732E
		Private mGutterWidth As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E206120626F726465722077696C6C20626520647261776E2061742074686520626F74746F6D206F662074686520656469746F722E
		Private mHasBottomBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060486173466F6375736020636F6D70757465642070726F70657274792E
		Private mHasFocus As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E206120626F726465722077696C6C20626520647261776E20617420746865206C6566742065646765206F662074686520656469746F722E
		Private mHasLeftBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E206120626F726465722077696C6C20626520647261776E206174207468652072696768742065646765206F662074686520656469746F722E
		Private mHasRightBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E206120626F726465722077696C6C20626520647261776E2061742074686520746F70206F662074686520656469746F722E
		Private mHasTopBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060486967686C6967687443757272656E744C696E656020636F6D70757465642070726F70657274792E
		Private mHighlightCurrentLine As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2064656C696D697465727320287375636820617320607B6020616E6420607D60292077696C6C20626520686967686C6967687465642061726F756E64207468652063617265742E204F6E6C7920737570706F7274656420627920736F6D6520666F726D6174746572732E
		Private mHighlightDelimitersAroundCaret As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520686F72697A6F6E74616C207363726F6C6C62617220696D61676520746F20647261772E204D6179206265204E696C206966206E6F742072657175697265642E
		Private mHorizontalScrollbar As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E7420626F756E6473206F662074686520686F72697A6F6E74616C207363726F6C6C626172207468756D622E2057696C6C206265204E696C2069662074686520766572746963616C207363726F6C6C626172206973206E6F742076697369626C652E20416C77617973204E696C206F6E206D61634F532E
		Private mHorizontalScrollbarThumbBounds As Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206D696E696D756D206E756D626572206F662063686172616374657273207265717569726564206265666F7265206175746F636F6D706C6574696F6E206973206F6666657265642E204D757374206265203E3D20322E
		#tag Getter
			Get
			  Return mMinimumAutocompletionLength
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mMinimumAutocompletionLength = Max(value, 2)
			  
			End Set
		#tag EndSetter
		MinimumAutocompletionLength As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865206D696E696D756D2074696D652028696E206D696C6C697365636F6E647329206265747765656E2063616C6C7320746F2074686520656469746F72277320666F726D6174746572277320605061727365282960206D6574686F642E
		MinimumParseInterval As Integer = 500
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206C61737420636C69636B2074686174206F6363757272656420776173206120646F75626C6520636C69636B2E
		Private mIsDoubleClick As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207469636B73207468617420746865206C617374206D6F75736520636C69636B206F636375727265642061742E
		Private mLastClickTicks As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206D6F75736520636C69636B2074686174206A757374206F6363757272656420696E2074686520604D6F757365446F776E60206576656E7420776173206120636F6E7465787475616C20636C69636B2E
		Private mLastClickWasContextual As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652074696D65206F6620746865206C61737420604B6579446F776E60206576656E742E205573656420746F2064657465726D696E65206966207468652075736572206973207374696C6C20747970696E672E
		Private mLastKeyDownTicks As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205820636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742E
		Private mLastMouseDownX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205920636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742E
		Private mLastMouseDownY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205820636F6F7264696E61746520647572696E6720746865206C617374204D6F75736544726167206576656E74206F72202D3120696620746865206D6F75736520686173206265656E2072656C65617365642073696E636520746865206C6173742064726167206576656E742E
		Private mLastMouseDragX As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205920636F6F7264696E61746520647572696E6720746865206C617374204D6F75736544726167206576656E74206F72202D3120696620746865206D6F75736520686173206265656E2072656C65617365642073696E636520746865206C6173742064726167206576656E742E
		Private mLastMouseDragY As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652058206D6F75736520636F6F7264696E6174652066726F6D207468652070726576696F757320604D6F757365557060206576656E742E
		Private mLastMouseUpX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652059206D6F75736520636F6F7264696E6174652066726F6D207468652070726576696F757320604D6F757365557060206576656E742E
		Private mLastMouseUpY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207469636B73207468617420746865206C61737420747269706C6520636C69636B206F636375727265642061742E
		Private mLastTripleClickTicks As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C206361636865206F66207468652063757272656E74206C696E65206865696768742E
		Private mLineHeight As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520636F6D707574656420604C696E654E756D626572466F6E7453697A65602E
		Private mLineNumberFontSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C206361636865206F6620746865206C696E65206E756D62657220776964746820696E20746865206775747465722E
		Private mLineNumWidth As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C696E65206C6F636174696F6E20756E6465726E6561746820746865206D6F75736520637572736F722E
		Private mLocationUnderMouse As XUICELocation
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41206361636865206F6620746865206C6173742076616C75652072657475726E65642062792074686520604D617856697369626C654C696E657360206D6574686F642E204974277320746865206D6178696D756D206E756D626572206F66206C696E65732076697369626C6520696E207468652063616E7661732E2057696C6C206E65766572206265206D6F7265207468616E20746865206E756D626572206F66206C696E657320696E206578697374656E63652E
		Private mMaxVisibleLines As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206D696E696D756D206E756D626572206F662063686172616374657273207265717569726564206265666F7265206175746F636F6D706C6574696F6E206973206F6666657265642E204261636B732074686520604D696E696D756D4175746F636F6D706C6574696F6E4C656E6774686020636F6D70757465642070726F70657274792E
		Private mMinimumAutocompletionLength As Integer = 2
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 506572696F646963616C6C7920636865636B7320746F207365652069662074686520666F726D61747465722063616E2070617273652074686520636F6E74656E74732E
		Private mParseTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E672073746F726520666F72207468652060526561644F6E6C796020636F6D70757465642070726F70657274792E
		Private mReadOnly As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520605363726F6C6C506F73586020636F6D70757465642070726F70657274792E
		Private mScrollPosX As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205920636F6F7264696E617465207468652063616E766173206C617374207363726F6C6C656420746F2E
		Private mScrollPosY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F662073706163657320746F20696E7365727420696E20706C616365206F662074686520746162206368617261637465722E
		Private mSpacesPerTab As Integer = 4
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E20746865206175746F636F6D706C65746520706F7075702069732073757070726573736564206576656E206966207468657265206973206175746F636F6D706C657465206461746120617661696C61626C652E20536574206166746572207468652075736572206861732063616E63656C6C6564206F72206163636570746564206175746F636F6D706C6574652E
		Private mSuppressAutocompletePopup As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520656469746F7227732063757272656E74207468656D6520286261636B732074686520605468656D656020636F6D70757465642070726F7065727479292E
		Private mTheme As XUICETheme
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060566572746963616C4C696E6550616464696E676020636F6D70757465642070726F70657274792E
		Private mVerticalLinePadding As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520766572746963616C207363726F6C6C62617220696D61676520746F20647261772E204D6179206265204E696C206966206E6F742072657175697265642E
		Private mVerticalScrollbar As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E7420626F756E6473206F662074686520766572746963616C207363726F6C6C626172207468756D622E2057696C6C206265204E696C2069662074686520766572746963616C207363726F6C6C626172206973206E6F742076697369626C652E20416C77617973204E696C206F6E206D61634F532E
		Private mVerticalScrollbarThumbBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652063616E766173206E6565647320612066756C6C207265647261772E
		NeedsFullRedraw As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E207468652063616E76617320697320726561642D6F6E6C792028692E652E206E6F74206564697461626C65292E
		#tag Getter
			Get
			  Return mReadOnly
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mReadOnly = value
			  
			End Set
		#tag EndSetter
		ReadOnly As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520686F72697A6F6E74616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720746F207468652072696768742E
		#tag Getter
			Get
			  Return mScrollPosX
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Update how much the canvas is horizontally scrolled.
			  
			  // Compute the maximum allowed X scroll position.
			  Var maxScrollPosX As Integer = Max(mCachedRequiredBufferWidth - Self.Width, 0)
			  
			  // Set the value of ScrollPosX, not exceeding the maximum value.
			  mScrollPosX = XUIMaths.Clamp(value, 0, maxScrollPosX)
			  
			End Set
		#tag EndSetter
		ScrollPosX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652073656C656374696F6E20636F6C6F75722E
		#tag Getter
			Get
			  Return theme.SelectionColor
			End Get
		#tag EndGetter
		SelectionColour As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F662073706163657320746F20696E7365727420696E20706C616365206F662074686520746162206368617261637465722E
		#tag Getter
			Get
			  Return mSpacesPerTab
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mSpacesPerTab = value
			  Refresh
			End Set
		#tag EndSetter
		SpacesPerTab As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620746865726520697320616E7920746578742063757272656E746C792073656C65637465642E
		#tag Getter
			Get
			  /// True if there is any text currently selected.
			  
			  Return mCurrentSelection <> Nil
			  
			End Get
		#tag EndGetter
		TextSelected As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520656469746F7227732063757272656E74207468656D652E
		#tag Getter
			Get
			  Return mTheme
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mTheme = value
			End Set
		#tag EndSetter
		Theme As XUICETheme
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21, Description = 546865206E756D626572206F66207469636B73207468617420726570726573656E747320746865207374617274206F662061206E657720756E646F206576656E7420626C6F636B2E
		#tag Getter
			Get
			  /// The number of ticks that represents the start of a new undo event block.
			  
			  Return mCurrentUndoID + (60 * UNDO_EVENT_BLOCK_SECONDS)
			End Get
		#tag EndGetter
		Private UndoIDThreshold As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 41207265666572656E636520746F207468697320656469746F72277320756E646F206D616E616765722E
		UndoManager As XUIUndoManager
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F207061642061206C696E65206F6E2069747320746F7020616E6420626F74746F6D2065646765732E
		#tag Getter
			Get
			  Return mVerticalLinePadding
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mVerticalLinePadding = value
			  NeedsFullRedraw = True
			  Refresh
			  
			End Set
		#tag EndSetter
		VerticalLinePadding As Integer
	#tag EndComputedProperty


	#tag Constant, Name = BLOCK_GUTTER_MIN_WIDTH, Type = Double, Dynamic = False, Default = \"18", Scope = Public, Description = 546865206D696E696D616C207769647468206F66207468652067757474657220636F6E7461696E696E672074686520626C6F636B20696E64696361746F72732E
	#tag EndConstant

	#tag Constant, Name = CARET_BLINK_PERIOD, Type = Double, Dynamic = False, Default = \"500", Scope = Private, Description = 54686520696E74657276616C2028696E206D7329206265747765656E20636172657420626C696E6B732E
	#tag EndConstant

	#tag Constant, Name = DEFAULT_AUTOCOMPLETE_POPUP_FONT_SIZE, Type = Double, Dynamic = False, Default = \"13", Scope = Public, Description = 5468652064656661756C7420666F6E742073697A6520666F7220746865206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F70757020746F20757365206966206E6F74206F76657272696464656E2E
	#tag EndConstant

	#tag Constant, Name = DEFAULT_FONT_SIZE, Type = Double, Dynamic = False, Default = \"13", Scope = Public, Description = 5468652064656661756C7420666F6E742073697A6520746F20757365206966206E6F74206F76657272696464656E2E
	#tag EndConstant

	#tag Constant, Name = DEFAULT_LINE_NUMBER_FONT_SIZE, Type = Double, Dynamic = False, Default = \"13", Scope = Public, Description = 5468652064656661756C7420666F6E742073697A6520746F2075736520666F72206C696E65206E756D62657273206966206E6F74206F76657272696464656E2E
	#tag EndConstant

	#tag Constant, Name = DELIMITER_TIMER_PERIOD, Type = Double, Dynamic = False, Default = \"500", Scope = Private, Description = 546865206E756D626572206F66206D696C6C697365636F6E6473206265747765656E207570646174696E6720746865206E6561726573742064656C696D697465727320746F207468652063617265742E
	#tag EndConstant

	#tag Constant, Name = HORIZONTAL_SCROLLBAR_HEIGHT, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 546865207769647468206F662074686520766572746963616C207363726F6C6C6261722E
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"16"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"20"
	#tag EndConstant

	#tag Constant, Name = HORIZONTAL_SCROLLBAR_THUMB_HEIGHT, Type = Double, Dynamic = False, Default = \"", Scope = Private, Description = 546865207769647468206F662074686520766572746963616C207363726F6C6C626172207468756D622E
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"4"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"10"
	#tag EndConstant

	#tag Constant, Name = LEFT_SCROLL_PADDING, Type = Double, Dynamic = False, Default = \"50", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F20706164206C656674207768656E207363726F6C6C696E67206C65667477617264732E
	#tag EndConstant

	#tag Constant, Name = LINE_CONTENTS_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Public, Description = 5468652070616464696E67206265747765656E2074686520726967687420677574746572206564676520616E6420746865206C696E6520636F6E74656E74732E
	#tag EndConstant

	#tag Constant, Name = MIN_LINE_NUMBER_WIDTH, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 4966206C696E65206E756D6265727320617265202A6E6F742A20647261776E2C207468697320697320746865206D696E696D756D207769647468206F6620746865206C696E65206E756D6265722073656374696F6E206F6620746865206775747465722E
	#tag EndConstant

	#tag Constant, Name = PARSE_TIMER_PERIOD, Type = Double, Dynamic = False, Default = \"250", Scope = Private, Description = 546865206E756D626572206F66206D696C6C697365636F6E6473206265747765656E20636865636B7320746F207365652069662077652073686F756C6420696E766F6B652074686520666F726D6174746572277320605061727365282960206D6574686F642E
	#tag EndConstant

	#tag Constant, Name = POPUP_PADDING, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 546865206E756D626572206F6620706978656C73206265747765656E20746865206175746F636F6D706C65746520706F70757020616E64207468652065646765206F66207468652063616E7661732E
	#tag EndConstant

	#tag Constant, Name = RIGHT_SCROLL_PADDING, Type = Double, Dynamic = False, Default = \"40", Scope = Private, Description = 467564676520666163746F7220666F722070616464696E6720746865207269676874206F66206C696E6573207768656E20686F72697A6F6E74616C207363726F6C6C696E672E
	#tag EndConstant

	#tag Constant, Name = SCROLLBAR_THUMB_PADDING, Type = Double, Dynamic = False, Default = \"4", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F20706164206569746865722073696465206F6620746865207363726F6C6C626172207468756D622E
	#tag EndConstant

	#tag Constant, Name = TYPING_SPEED_TICKS, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 546865206E756D626572206F66207469636B73206265747765656E206B65797374726F6B657320746F207374696C6C20626520636F6E73696465726564206173206163746976656C7920747970696E672E
	#tag EndConstant

	#tag Constant, Name = UNDO_EVENT_BLOCK_SECONDS, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 546865206E756D626572206F66207365636F6E64732077697468696E20776869636820756E646F61626C6520616374696F6E2077696C6C2062652067726F7570656420746F67657468657220617320612073696E676C6520756E646F61626C6520616374696F6E2E
	#tag EndConstant

	#tag Constant, Name = VERTICAL_SCROLLBAR_THUMB_WIDTH, Type = Double, Dynamic = False, Default = \"", Scope = Private, Description = 546865207769647468206F662074686520766572746963616C207363726F6C6C626172207468756D622E
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"4"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"10"
	#tag EndConstant

	#tag Constant, Name = VERTICAL_SCROLLBAR_WIDTH, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 546865207769647468206F662074686520766572746963616C207363726F6C6C6261722E
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"16"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"20"
	#tag EndConstant

	#tag Constant, Name = VSCROLL_SENSITIVITY, Type = Double, Dynamic = False, Default = \"2.5", Scope = Private, Description = 486967686572206E756D626572203D206D6F7265206C696E6573207363726F6C6C6564207768656E20717569636B6C79207363726F6C6C696E6720766572746963616C6C792E2056616C756573206265747765656E2031202D203320776F726B2077656C6C2E
	#tag EndConstant


	#tag Enum, Name = AutocompleteCombos, Type = Integer, Flags = &h0, Description = 5468652061636365707461626C65206B657920636F6D62696E6174696F6E7320666F722074726967676572696E67206175746F636F6D706C6574696F6E2E
		CtrlSpace
		Tab
	#tag EndEnum

	#tag Enum, Name = CaretTypes, Type = Integer, Flags = &h0, Description = 54686520646966666572656E74207479706573206F66206361726574207468652063616E76617320737570706F7274732E
		Block
		  Underscore
		VerticalBar
	#tag EndEnum

	#tag Enum, Name = ContentTypes, Type = Integer, Flags = &h0, Description = 5468652074797065206F6620636F6E74656E742074686520656469746F722069732070726F63657373696E672E
		Markdown
		SourceCode
	#tag EndEnum


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
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BlinkCaret"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NeedsFullRedraw"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollPosX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LongestLineChanged"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Behavior"
			InitialValue="System"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Behavior"
			InitialValue="12"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayLineNumbers"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="VerticalLinePadding"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FirstVisibleLine"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretLineNumber"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineNumberFontSize"
			Visible=true
			Group="Behavior"
			InitialValue="12"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretType"
			Visible=true
			Group="Behavior"
			InitialValue="1"
			Type="CaretTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Block"
				"1 - Underscore"
				"2 - VerticalBar"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasFocus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentUndoID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextSelected"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HighlightCurrentLine"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentLineHighlightColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretColour"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionColour"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentLineNumberColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineNumberColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastFullyVisibleLineNumber"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretColumn"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Contents"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="CaretXCoordinate"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawBlockLines"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutocomplete"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoCompleteInComments"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumAutocompletionLength"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompletePopupFontName"
			Visible=true
			Group="Behavior"
			InitialValue="System"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompletePopupFontSize"
			Visible=true
			Group="Behavior"
			InitialValue="12"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderColor"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasTopBorder"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBottomBorder"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasLeftBorder"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasRightBorder"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SpacesPerTab"
			Visible=true
			Group="Behavior"
			InitialValue="4"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HighlightDelimitersAroundCaret"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastParseMicroseconds"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumParseInterval"
			Visible=true
			Group="Behavior"
			InitialValue="500"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="JustTokenised"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocloseBrackets"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebuggingLine"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugLineColour"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompleteCombo"
			Visible=false
			Group="Behavior"
			InitialValue="XUICodeEditor.AutocompleteCombos.Tab"
			Type="XUICodeEditor.AutocompleteCombos"
			EditorType="Enum"
			#tag EnumValues
				"0 - CtrlSpace"
				"1 - Tab"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentType"
			Visible=false
			Group="Behavior"
			InitialValue="XUICodeEditor.ContentTypes.SourceCode"
			Type="XUICodeEditor.ContentTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Markdown"
				"1 - SourceCode"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
