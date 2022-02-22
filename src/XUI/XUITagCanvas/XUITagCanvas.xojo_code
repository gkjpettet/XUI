#tag Class
Protected Class XUITagCanvas
Inherits DesktopTextInputCanvas
	#tag Event
		Function DoCommand(command As String) As Boolean
		  /// Handles `command`.
		  ///
		  /// `command` is a string constant telling us which command we need to handle.
		  
		  Select Case command
		  Case CmdCancelOperation
		    HandleEscKey
		    
		  Case CmdDeleteBackward
		    HandleDeleteBackwards
		    
		  Case CmdInsertTab
		    InsertCharacter(&u09)
		    
		    // ================
		    // MOVEMENT
		    // ================
		  Case CmdMoveLeft, CmdMoveToBeginningOfLine
		    // Scroll all the way to the left.
		    ScrollPosX = 0
		    
		  Case CmdMoveRight, CmdMoveToEndOfLine
		    // Scroll all the way to the right.
		    ScrollToCaret
		    
		  Case CmdMoveUp
		    ScrollUp(1)
		    
		  Case CmdMoveDown
		    ScrollDown(1)
		    
		  Case CmdMoveToBeginningOfDocument
		    mCurrentLine = mLines(0)
		    Refresh
		    
		  Case CmdMoveToEndOfDocument
		    mCurrentLine = mLines(mLines.LastIndex)
		    Refresh
		    
		  End Select
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
		Sub InsertText(text As String, range As TextRange)
		  // Inserts a single character.
		  
		  InsertCharacter(text, range)
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
		  #If TargetMacOS
		    #Pragma Unused Key
		  #EndIf
		  
		  // Catch the Esc key on Windows & Linux.
		  // This is handled on macOS within `DoCommand`.
		  #If TargetWindows Or TargetLinux
		    If Key.Asc = &h1B Then // Esc.
		      HandleEscKey
		      Return True
		    End If
		  #EndIf
		  
		End Function
	#tag EndEvent

	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  /// The mouse has wheeled.
		  ///
		  /// [x] is the X coord relative to the control that has received the event.
		  /// [y] is the Y coord relative to the control that has received the event.
		  /// [deltaX] is the number of horizontal scroll lines moved.
		  /// [deltaY] is the number of vertical scroll lines moved.
		  ///
		  /// Returns True to prevent propagating the event further.
		  ///
		  /// [deltaX] is positive when the user scrolls right and negative when scrolling left. 
		  /// [deltaY] is positive when the user scrolls down and negative when scrolling up.
		  
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  // =================================
		  // HORIZONTAL SCROLLING
		  // =================================
		  If deltaX <> 0 Then
		    // deltaX reported by Xojo is very small. Beef it up a little.
		    deltaX = deltaX * 5
		    ScrollPosX = ScrollPosX + deltaX
		  End If
		  
		  // =================================
		  // VERTICAL SCROLLING
		  // =================================
		  ScrollPosY = ScrollPosY + (deltaY)
		  
		  // Prevent the event propagating further.
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Xojo.Rect)
		  #Pragma Unused areas
		  
		  RebuildBuffer
		  
		  g.DrawingColor = Style.BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  g.DrawPicture(mBuffer, -ScrollPosX, -ScrollPosY)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ScaleFactorChanged(newScaleFactor as Double)
		  /// The canvas has moved onto a monitor with a different scale factor.
		  
		  #Pragma Unused newScaleFactor
		  
		  RebuildBuffer
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, Description = 546F67676C657320746865207669736962696C697479206F66207468652063617265742E2043616C6C6564206279205B6D4361726574426C696E6B65722E416374696F6E5D2E
		Private Sub CaretBlinkerAction(caretBlinker As Timer)
		  /// Toggles the visibility of the caret. Called by [mCaretBlinker.Action].
		  
		  #Pragma Unused caretBlinker
		  
		  mCaretVisible = Not mCaretVisible
		  
		  // Redraw the canvas.
		  Refresh
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D707574657320746865207769647468206F6620746865206275666665722E205365747320606D52657175697265644275666665725769647468602E
		Private Sub ComputeBufferWidth()
		  /// Computes the width of the buffer. Sets `mRequiredBufferWidth`.
		  ///
		  /// The buffer will always be at least as wide as the tag canvas' current width.
		  
		  Var g As Graphics
		  Var p As Picture
		  If mBuffer = Nil Then
		    // Edge case: The canvas is embedded in a DesktopContainer  that is not
		    // yet embedded in a window. In this scenario, `Window` is Nil.
		    If Self.Window <> Nil Then
		      p = Self.Window.BitmapForCaching(10, 10)
		    Else
		      p = New Picture(10, 10)
		    End If
		    g = p.Graphics
		  Else
		    g = mBuffer.Graphics
		  End If
		  
		  // Compute the width of the buffer.
		  Var w As Double = CurrentLineWidth + LEFT_SCROLL_PADDING
		  mRequiredBufferWidth = Max(w, Self.Width)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  // Initialise the caret blinker timer.
		  mCaretBlinker = New Timer
		  mCaretBlinker.RunMode = Timer.RunModes.Multiple
		  mCaretBlinker.Period = CaretBlinkPeriod
		  AddHandler mCaretBlinker.Action, AddressOf CaretBlinkerAction
		  
		  // Always start with a single line.
		  mLines.Add(New XUITagCanvasLine(Self, 1))
		  mCurrentLine = mLines(0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520746F74616C207769647468206F66207468652063757272656E74206C696E652028696E636C7564696E672069747320636F6E74656E747320616E6420616C6C2070616464696E67292E
		Private Function CurrentLineWidth() As Double
		  /// Returns the total width of the current line (including its contents and all padding).
		  
		  If mBuffer <> Nil Then
		    Return mCurrentLine.ContentsWidth(mBuffer.Graphics) + LEFT_PADDING
		  Else
		    // Edge case: The buffer has not yet been created.
		    Var tmp As Picture = Window.BitmapForCaching(10, 10)
		    Return mCurrentLine.ContentsWidth(tmp.Graphics) + LEFT_PADDING
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C657465732074686520636861726163746572206F722074616720696D6D6564696174656C7920696E2066726F6E74206F66207468652063617265742E
		Private Sub HandleDeleteBackwards()
		  /// Deletes the character or tag immediately in front of the caret.
		  
		  If mCurrentLine.UnparsedText.CharacterCount > 0 Then
		    mCurrentLine.UnparsedText = _
		    mCurrentLine.UnparsedText.LeftCharacters(mCurrentLine.UnparsedText.CharacterCount - 1)
		    
		  ElseIf mCurrentLine.Tags.Count > 0 Then
		    Call mCurrentLine.Tags.Pop
		  End If
		  
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C657320616E20457363206B6579207072657373206174207468652063757272656E7420636172657420706F736974696F6E2E
		Private Sub HandleEscKey(shouldInvalidate As Boolean = True)
		  /// Handles an Esc key press at the current caret position.
		  
		  #Pragma Warning "TODO"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E736572747320612073696E676C6520636861726163746572206174207468652063757272656E7420636172657420706F736974696F6E2E
		Sub InsertCharacter(char As String, range As TextRange = Nil)
		  /// Inserts a single character at the current caret position.
		  ///
		  /// Assumes [char] is only one character.
		  
		  If IsTrigger(char) And Parse Then
		    Return
		  End If
		  
		  If range <> Nil And TargetMacOS Then
		    // The user has pressed and held down a character and has selected a special character from the 
		    // popup to insert. Replace the character before the caret with `char`.
		    HandleDeleteBackwards
		  End If
		  
		  mCurrentLine.Append(char)
		  
		  #Pragma Warning "TODO: Autocomplete"
		  
		  ScrollToCaret
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547275652069662060636861726020697320612074726967676572206368617261637465722E
		Private Function IsTrigger(char As String) As Boolean
		  /// True if `char` is a trigger character.
		  
		  If char = &u0A And ParseOnReturn Then Return True
		  If char = &u09 And ParseOnTab Then Return True
		  If char = "," And ParseOnComma Then Return True
		  
		  For Each trigger As String In mTriggers
		    If char = trigger Then Return True
		  Next trigger
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206865696768742028696E20706978656C7329206F662061206C696E652E
		Function LineHeight() As Double
		  /// The height (in pixels) of a line.
		  
		  If mBuffer <> Nil Then
		    Return Self.Formatter.TagHeight(mBuffer.Graphics) + (2 * TagVerticalPadding)
		  Else
		    // Edge case: The buffer has not yet been created.
		    Var tmp As Picture = Window.BitmapForCaching(10, 10)
		    Return Self.Formatter.TagHeight(tmp.Graphics) + (2 * TagVerticalPadding)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 546865206D6178696D756D206E756D626572206F66206C696E65732074686174206172652076697369626C6520696E207468652063616E7661732E
		Private Function MaxVisibleLines(lineHeight As Double) As Integer
		  /// The maximum number of lines that are visible in the canvas. 
		  ///
		  /// Will never be more than the maximum number of lines in existence.
		  
		  Return Min(Me.Height / lineHeight, mLines.Count)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061696E7473207468652063617265742061742074686520656E64206F66207468652063757272656E74206C696E652E
		Private Sub PaintCaret(g As Graphics)
		  /// Paints the caret at the end of the current line.
		  
		  // Compute the x, y coordinates at the passed caret position.
		  Var x, y As Double = 0
		  XYAtCaretPos(x, y)
		  
		  y = y + TagVerticalPadding
		  
		  g.DrawingColor = Style.CaretColor
		  g.DrawLine(x, y, x, y + (mLineHeight - (2 * TagVerticalPadding)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417474656D70747320746F2070617273652074686520756E7061727365642074657874206F6E207468652063757272656E74206C696E6520696E746F2061207461672E2052657475726E732046616C736520696620756E61626C652E20526566726573686573207468652063616E766173206966207375636365737366756C2E
		Private Function Parse() As Boolean
		  /// Attempts to parse the unparsed text on the current line into a tag. Returns False if unable.
		  /// Refreshes the canvas if successful.
		  
		  Var tagData As XUITagData = Self.Parselet.Parse(mCurrentLine.UnparsedText)
		  
		  If tagData = Nil Then Return False
		  
		  mCurrentLine.Tags.Add(Self.Formatter.CreateTag(tagData, mBuffer.Graphics))
		  
		  mCurrentLine.UnparsedText = ""
		  
		  // If the tag just added makes the current line longer than the visible width we need to add another line.
		  If CurrentLineWidth > Self.Width Then
		    Var line As New XUITagCanvasLine(Self, mCurrentLine.Number + 1)
		    line.Tags.Add(mCurrentLine.Tags.Pop)
		    mLines.Add(line)
		    mCurrentLine = mLines(mLines.LastIndex)
		  End If
		  
		  ScrollToCaret
		  
		  Return True
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656275696C6473207468652062756666657220666F7220612073696E676C65206C696E652063616E7661732E
		Private Sub RebuildBuffer()
		  /// Rebuilds the entire buffer by drawing all visible content to it.
		  
		  ComputeBufferWidth
		  
		  // Create a new HiDPI aware buffer picture.
		  Var bufferH As Double
		  If Multiline Then
		    bufferH = Max(LineHeight * mLines.Count, Self.Height)
		  Else
		    bufferH = LineHeight
		  End If
		  mBuffer = Window.BitmapForCaching(mRequiredBufferWidth, bufferH)
		  
		  // Grab a reference to the buffer's graphics context.
		  Var g As Graphics = mBuffer.Graphics
		  
		  If Style = Nil Then Return
		  
		  // Background.
		  g.DrawingColor = Style.BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // Cache the current line height as it's computed.
		  mLineHeight = LineHeight
		  
		  // Iterate over the visible lines and draw every line.
		  Var lineStartY As Double = TOP_PADDING
		  For Each line As XUITagCanvasLine In mLines
		    line.Draw(g, LEFT_PADDING, lineStartY, mLineHeight)
		    lineStartY = lineStartY + mLineHeight
		  Next line
		  
		  // Draw the caret.
		  If mCaretVisible Then
		    PaintCaret(g)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5363726F6C6C73207468652063616E76617320646F776E20606C696E6573546F5363726F6C6C60206C696E65732E
		Private Sub ScrollDown(linesToScroll As Integer)
		  /// Scrolls the canvas down `linesToScroll` lines.  Refreshes the canvas.
		  
		  // Vertical scrolling only occurs in multiline tag canvas controls.
		  If Not Multiline Then Return
		  
		  // Cache the number of visible lines as it's computed.
		  Var linesVisible As Integer = MaxVisibleLines(LineHeight)
		  
		  // The maximum number of lines we can ever scroll down is the number of 
		  // lines that are visible on the screen. However, we will never scroll past the last line.
		  linesToScroll = MathsKit.Clamp(linesToScroll, 0, linesVisible)
		  
		  ScrollPosY = ScrollPosY + (linesToScroll * LineHeight)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5363726F6C6C73207468652063616E76617320286966206E65636573736172792920746F207468652063617265742E20526566726573686573207468652063616E7661732E
		Private Sub ScrollToCaret()
		  /// Scrolls the canvas (if necessary) to the caret. Refreshes the canvas.
		  
		  // ===============================
		  // HORIZONTAL SCROLLING
		  // ===============================
		  // Get the X coord of the caret.
		  Var x As Integer = CaretXCoordinate
		  If mCurrentLine.Tags.Count = 0 And mCurrentLine.UnparsedText.Length = 0 Then
		    ScrollPosX = 0
		    
		  ElseIf x - mScrollPosX + RIGHT_SCROLL_PADDING > Self.Width Then
		    // Scroll right.
		    Var widthDiff As Double = mRequiredBufferWidth - Self.Width
		    ScrollPosX = MathsKit.Clamp(mScrollPosX + x - Self.Width + RIGHT_SCROLL_PADDING, 0, widthDiff)
		    
		  ElseIf x < mScrollPosX Then
		    // Scroll left.
		    ScrollPosX = Max(x - LEFT_SCROLL_PADDING, 0)
		    
		  ElseIf mScrollPosX > mRequiredBufferWidth - Me.Width Then
		    ScrollPosX = Max(x - LEFT_SCROLL_PADDING, 0)
		  End If
		  
		  // ===============================
		  // VERTICAL SCROLLING
		  // ===============================
		  ScrollPosY = mBuffer.Graphics.Height
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5363726F6C6C73207468652063616E76617320757020606C696E6573546F5363726F6C6C60206C696E65732E20526566726573686573207468652063616E7661732E
		Private Sub ScrollUp(linesToScroll As Integer)
		  /// Scrolls the canvas up `linesToScroll` lines. Refreshes the canvas.
		  
		  // Vertical scrolling only occurs in multiline tag canvas controls.
		  If Not Multiline Then Return
		  
		  // Cache the number of visible lines as it's computed.
		  Var linesVisible As Integer = MaxVisibleLines(LineHeight)
		  
		  // The maximum number of lines we can ever scroll up is the number of lines 
		  // that are visible on the screen. However, we will never scroll past the first line.
		  linesToScroll = MathsKit.Clamp(linesToScroll, 0, linesVisible)
		  
		  ScrollPosY = ScrollPosY - (linesToScroll * LineHeight)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70757465732028427952656629207468652063616E76617320782C207920636F6F7264696E61746573206174207468652063757272656E7420636172657420706F736974696F6E2E
		Private Sub XYAtCaretPos(ByRef x As Double, ByRef y As Double)
		  /// Computes (ByRef) the canvas x, y coordinates at the current caret position.
		  
		  x = mCurrentLine.ContentsWidth(mBuffer.Graphics) + LEFT_PADDING
		  
		  y = (CaretLineNumber - 1) * LineHeight
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 546865207461672063616E7661732069732061736B696E6720666F72206175746F636F6D706C6574696F6E206F7074696F6E7320666F7220746865207370656369666965642060707265666978602E20596F752073686F756C642072657475726E204E696C20696620746865726520617265206E6F6E652E
		Event AutocompleteOptionsForPrefix(prefix As String) As XUITagAutocompleteOption()
	#tag EndHook


	#tag Property, Flags = &h0, Description = 49662054727565207468656E207468652063616E7661732077696C6C20766572746963616C6C79207363726F6C6C2066617374657220696620746865206D6F75736520776865656C206973206D6F766564206661737465722E
		AllowInertialScrolling As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696E74657276616C2028696E206D7329206265747765656E20636172657420626C696E6B732E
		#tag Getter
			Get
			  If mCaretBlinker <> Nil Then
			    Return mCaretBlinker.Period
			  Else
			    Return 0
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mCaretBlinker <> Nil Then mCaretBlinker.Period = CaretBlinkPeriod
			End Set
		#tag EndSetter
		CaretBlinkPeriod As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620746865206C696E65207468652063617265742069732063757272656E746C79206F6E2E
		#tag Getter
			Get
			  Return mCurrentLine.Number
			End Get
		#tag EndGetter
		CaretLineNumber As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206162736F6C757465205820636F6F7264696E617465206F6620746865206361726574206174206974732063757272656E7420706F736974696F6E2028636F6D707574656420616E6420657870656E73697665292E
		#tag Getter
			Get
			  Return mCurrentLine.ContentsWidth(mBuffer.Graphics) + LEFT_PADDING
			End Get
		#tag EndGetter
		CaretXCoordinate As Integer
	#tag EndComputedProperty

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
		CurrentLine As XUITagCanvasLine
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520666F726D617474657220746F2075736520746F206472617720746865207461677320696E207468652063616E7661732E
		Formatter As XUITagFormatter
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652062756666657220776520647261772074686520636F6E74656E747320746F20616E64207468656E20626C697420746F207468652073637265656E2065616368206672616D652E
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652074696D657220726573706F6E7369626C6520666F7220626C696E6B696E67207468652063617265742E
		Private mCaretBlinker As Timer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652063617265742068617320626C696E6B65642076697369626C652C2046616C7365206966206E6F742E
		Private mCaretVisible As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F7220746865206043757272656E744C696E656020636F6D70757465642070726F70657274792E
		Private mCurrentLine As XUITagCanvasLine
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060486173466F6375736020636F6D70757465642070726F70657274792E
		Private mHasFocus As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C206361636865206F66207468652063757272656E74206C696E65206865696768742E
		Private mLineHeight As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C696E657320696E20746869732063616E7661732E
		mLines() As XUITagCanvasLine
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E672073746F726520666F72207468652060526561644F6E6C796020636F6D70757465642070726F70657274792E
		Private mReadOnly As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520776964746820746865206275666665722073686F756C642062652E2053657420696E2060436F6D707574654275666665725769647468602E
		Private mRequiredBufferWidth As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520686F72697A6F6E74616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720746F207468652072696768742E204261636B732074686520605363726F6C6C506F73586020636F6D70757465642070726F70657274792E
		Private mScrollPosX As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207665746963616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720646F776E2E204261636B732074686520605363726F6C6C506F73596020636F6D70757465642070726F70657274792E
		Private mScrollPosY As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572207374796C6520746F2075736520666F7220746865207461672063616E76617320616E6420746167732E
		Private mStyle As XUITagCanvasStyle
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4164646974696F6E616C206368617261637465727320746861742074726967676572207461672070617273696E672E205365742077697468207468652060506172736554726967676572736020636F6D70757465642070726F70657274792E
		Private mTriggers() As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E20746167732077696C6C207772617020746F206E6577206C696E65732E
		Multiline As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652070617273656C657420746F2075736520746F207061727365207465787420656E746572656420696E20746865207461672063616E7661732E
		Parselet As XUITagParselet
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520636F6D6D61206B6579207472696767657273207468652070617273696E67206F6620616E7920636F6E746967756F75732074657874206E6F7420796574207061727365642061732061207461672E
		ParseOnComma As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E207468652072657475726E206B6579207472696767657273207468652070617273696E67206F6620616E7920636F6E746967756F75732074657874206E6F7420796574207061727365642061732061207461672E
		ParseOnReturn As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520746167206B6579207472696767657273207468652070617273696E67206F6620616E7920636F6E746967756F75732074657874206E6F7420796574207061727365642061732061207461672E
		ParseOnTab As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4120636F6D6D612064656C696D69746564206C697374206F66206368617261637465727320746861742077696C6C2074726967676572207461672070617273696E672E2052657475726E2C2074616220616E6420636F6D6D612063686172616374657273206172652073746970756C6174656420627920746865206050617273654F6E2E2E2E602070726F706572746965732E
		#tag Getter
			Get
			  Return String.FromArray(mTriggers, "")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var tmp() As String = value.Split(",")
			  mTriggers.RemoveAll
			  
			  For Each trigger As String In tmp
			    
			    If trigger.CharacterCount <> 1 Then
			      Raise New InvalidArgumentException("Parse triggers must be exactly one character in length.")
			    End If
			    
			    Select Case trigger
			    Case &u0A, &u09, ","
			      Raise New InvalidArgumentException("To use the return key, tabs or commas as parse triggers, " + _
			      "enable `ParseOnReturn`, `ParseOnTab` and/or `ParseOnComma` as needed.")
			      
			    Else
			      If tmp.IndexOf(trigger) <> -1 Then mTriggers.Add(trigger)
			    End Select
			    
			  Next trigger
			  
			  
			End Set
		#tag EndSetter
		ParseTriggers As String
	#tag EndComputedProperty

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

	#tag ComputedProperty, Flags = &h0, Description = 54686520686F72697A6F6E74616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720746F207468652072696768742E20526566726573686573207468652063616E7661732E
		#tag Getter
			Get
			  Return mScrollPosX
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Update how much the canvas is horizontally scrolled.
			  
			  // Compute the maximum allowed X scroll position.
			  Var maxScrollPosX As Integer
			  If mBuffer = Nil Then
			    maxScrollPosX = 0
			  Else
			    maxScrollPosX = Max(mBuffer.Graphics.Width - Self.Width, 0)
			  End If
			  
			  // Set the value of ScrollPosX, not exceeding the maximum value.
			  mScrollPosX = MathsKit.Clamp(value, 0, maxScrollPosX)
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		ScrollPosX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21, Description = 54686520766572746963616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720646F776E2E20526566726573686573207468652063616E7661732E
		#tag Getter
			Get
			  Return mScrollPosY
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Update how much the canvas is vertically scrolled.
			  
			  // Compute the maximum allowed Y scroll position.
			  Var maxScrollPosY As Integer
			  If mBuffer = Nil Then
			    maxScrollPosY = 0
			  Else
			    maxScrollPosY = Max(mBuffer.Graphics.Height - Self.Height, 0)
			  End If
			  
			  // Set the value of ScrollPosY, not exceeding the maximum value.
			  mScrollPosY = MathsKit.Clamp(value, 0, maxScrollPosY)
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		Private ScrollPosY As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572207374796C6520746F2075736520666F7220746865207461672063616E76617320616E6420746167732E
		#tag Getter
			Get
			  Return mStyle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mStyle = value
			  Refresh
			End Set
		#tag EndSetter
		Style As XUITagCanvasStyle
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746F20746865206C65667420616E64207269676874206F662065616368207461672E
		TagHorizontalPadding As Integer = 5
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F772065616368207461672E
		TagVerticalPadding As Integer = 5
	#tag EndProperty


	#tag Constant, Name = LEFT_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420636F6E74656E742066726F6D20746865206C6566742065646765206F66207468652063616E7661732E
	#tag EndConstant

	#tag Constant, Name = LEFT_SCROLL_PADDING, Type = Double, Dynamic = False, Default = \"50", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F20706164206C656674207768656E207363726F6C6C696E67206C65667477617264732E
	#tag EndConstant

	#tag Constant, Name = RIGHT_SCROLL_PADDING, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 467564676520666163746F7220666F722070616464696E6720746865207269676874206F66206C696E6573207768656E20686F72697A6F6E74616C207363726F6C6C696E672E
	#tag EndConstant

	#tag Constant, Name = TOP_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520746F70206F6620746865206669727374206C696E652E
	#tag EndConstant

	#tag Constant, Name = TYPING_SPEED_TICKS, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 546865206E756D626572206F66207469636B73206265747765656E206B65797374726F6B657320746F207374696C6C20626520636F6E73696465726564206173206163746976656C7920747970696E672E
	#tag EndConstant

	#tag Constant, Name = UNDO_EVENT_BLOCK_SECONDS, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 546865206E756D626572206F66207365636F6E64732077697468696E20776869636820756E646F61626C6520616374696F6E2077696C6C2062652067726F7570656420746F67657468657220617320612073696E676C6520756E646F61626C6520616374696F6E2E
	#tag EndConstant

	#tag Constant, Name = VSCROLL_SENSITIVITY, Type = Double, Dynamic = False, Default = \"2.5", Scope = Private, Description = 486967686572206E756D626572203D206D6F7265206C696E6573207363726F6C6C6564207768656E20717569636B6C79207363726F6C6C696E6720766572746963616C6C792E2056616C756573206265747765656E2031202D203320776F726B2077656C6C2E
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="120"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="22"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
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
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
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
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Multiline"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
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
			Name="CaretBlinkPeriod"
			Visible=true
			Group="Behavior"
			InitialValue="500"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParseOnReturn"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParseOnTab"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParseOnComma"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParseTriggers"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="TagVerticalPadding"
			Visible=false
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TagHorizontalPadding"
			Visible=false
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
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
			Name="ScrollPosX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowInertialScrolling"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
