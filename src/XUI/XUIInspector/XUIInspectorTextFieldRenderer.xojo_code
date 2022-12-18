#tag Class
Protected Class XUIInspectorTextFieldRenderer
	#tag Method, Flags = &h21, Description = 54727565206966207468652063617265742069732061742074686520656E64206F662074686520746578742E
		Private Function CaretAtEnd() As Boolean
		  /// True if the caret is at the end of the text.
		  
		  Return CaretPosition >= mCharacters.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206E756D626572206F6620706978656C732066726F6D20746865206C6566742065646765206F662074686520746578746669656C64207468652063617265742063757272656E746C792069732E
		Function CaretXCoordinate() As Integer
		  /// Returns the number of pixels from the left edge of the textfield the caret currently is.
		  
		  Return HPADDING + mBuffer.Graphics.TextWidth(CharsToCaret) - mScrollOffset
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206368617261637465727320757020746F207468652063617265742E
		Private Function CharsToCaret() As String
		  /// Returns the characters up to the caret.
		  
		  Var s() As String
		  Var iLimit As Integer = CaretPosition - 1
		  For i As Integer = 0 To iLimit
		    s.Add(mCharacters(i))
		  Next i
		  
		  Return String.FromArray(s, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C65617273207468652073656C656374696F6E20286966207468657265206973206F6E65292E
		Sub ClearSelection()
		  /// Clears the selection (if there is one).
		  
		  mCurrentSelection = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(owner As XUIInspector, placeholder As String = "", caption As String = "")
		  Self.Owner = owner
		  Self.Placeholder = placeholder
		  Self.Caption = caption
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C657465732074686520636861726163746572206265666F72652074686520636172657420616E6420696E76616C696461746573207468652063616E7661732E
		Sub DeleteBackward()
		  /// Deletes the character before the caret.
		  
		  // If there is a text selection then we just need to delete the selection.
		  If TextSelected Then
		    DeleteSelection
		    Return
		  End If
		  
		  // Nothing to do if we're at the start of the document.
		  If CaretPosition = 0 Then Return
		  
		  // Delete the previous character and move the caret back one place.
		  CaretPosition = CaretPosition - 1
		  mCharacters.RemoveAt(CaretPosition)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C65746573207468652063686172616374657220696D6D6564696174656C7920696E2066726F6E74206F66207468652063617265742E
		Sub DeleteForward()
		  /// Deletes the character immediately in front of the caret.
		  
		  // If there is a text selection then we just need to delete the selection.
		  If TextSelected Then
		    DeleteSelection
		    Return
		  End If
		  
		  // Nothing to do if we're at the end of the line.
		  If CaretPosition = mCharacters.Count Then Return
		  
		  // Delete the next character and move the caret forwards one place.
		  mCharacters.RemoveAt(CaretPosition)
		  CaretPosition = CaretPosition
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C6574657320746865207465787420696E207468652063757272656E742073656C656374696F6E2E
		Sub DeleteSelection()
		  /// Deletes the text in the current selection.
		  
		  // Quick exit if there is nothing selected.
		  If mCurrentSelection = Nil Then Return
		  
		  // Edge case 1: Is the whole line selected?
		  If mCurrentSelection.StartLocation = 0 And mCurrentSelection.Length = mCharacters.Count Then
		    Contents = ""
		    CaretPosition = 0
		    Return
		  End If
		  
		  // Rpelace the selected text with nothing.
		  Contents = Contents.Replace(SelectedText, "")
		  
		  // Reposition the caret.
		  CaretPosition = mCurrentSelection.StartLocation
		  
		  // Clear the selection.
		  mCurrentSelection = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E736572747320612073696E676C6520636861726163746572206174207468652063757272656E7420636172657420706F736974696F6E2E
		Sub InsertCharacter(char As String, range As TextRange)
		  /// Inserts a single character at the current caret position.
		  
		  ' // Prepend?
		  ' If CaretPosition = 0 Then
		  ' Contents = s + contents
		  ' CaretPosition = s.Length
		  ' Return
		  ' End If
		  ' 
		  ' // Append?
		  ' If CaretAtEnd Then
		  ' Contents = Contents + s
		  ' CaretPosition = mCharacters.Count
		  ' Return
		  ' End If
		  ' 
		  ' // Insert.
		  ' Var beforeCaret As String = Contents.Left(CaretPosition)
		  ' Contents = beforeCaret + s + Contents.Right(Contents.Length - CaretPosition)
		  ' CaretPosition = CaretPosition + s.Length 
		  
		  If range <> Nil And Not TextSelected And TargetMacOS Then
		    // The user has pressed and held down a character and has selected a special character from the 
		    // popup to insert. Replace the character before the caret with `char`.
		    DeleteBackward
		    InsertCharacter(char, Nil)
		  Else
		    If TextSelected Then
		      // Replace the selection and update the caret position.
		      ReplaceSelection(char)
		    Else
		      mCharacters.AddAt(CaretPosition, char)
		      CaretPosition = CaretPosition + 1
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F7665732074686520636172657420746F20746865206C656674206F6E6520706F736974696F6E2E
		Sub MoveCaretLeft()
		  /// Moves the caret to the left one position.
		  
		  If TextSelected Then
		    // Move the caret to the selected text's start location and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.StartLocation
		    mCurrentSelection = Nil
		    CaretPosition = caretPos
		  Else
		    CaretPosition = CaretPosition - 1
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F76657320746865206361726574206F6E6520706F736974696F6E20746F207468652072696768742E
		Sub MoveCaretRight()
		  /// Moves the caret one position to the right.
		  
		  If TextSelected Then
		    // Move the caret to the selection's end location and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.EndLocation
		    mCurrentSelection = Nil
		    CaretPosition = caretPos
		  Else
		    CaretPosition = CaretPosition + 1
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F7665732074686520636172657420746F2074686520656E64206F6620746865206E65787420776F72642E
		Sub MoveCaretToNextWordEnd()
		  /// Moves the caret to the end of the next word.
		  
		  If TextSelected Then
		    // Move the caret to the selection's end location and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.EndLocation
		    mCurrentSelection = Nil
		    CaretPosition = caretPos
		  Else
		    CaretPosition = NextWordEnd(CaretPosition)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F7665732074686520636172657420746F20746865207374617274206F66207468652070726576696F757320776F72642E
		Sub MoveCaretToPreviousWordStart()
		  /// Moves the caret to the start of the previous word.
		  
		  If TextSelected Then
		    // Move the caret to the selected text's start location and clear the selection.
		    Var caretPos As Integer = mCurrentSelection.StartLocation
		    mCurrentSelection = Nil
		    CaretPosition = caretPos
		  Else
		    CaretPosition = PreviousWordStart(CaretPosition)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F76657320646F776E20616E64206D6F646966696573207468652073656C656374696F6E2E
		Sub MoveDownAndModifySelection()
		  /// Moves down and modifies the selection.
		  
		  If Not TextSelected Then
		    // Create a new selection that starts, ends and is anchored at the current caret position.
		    mCurrentSelection = New XUIInspectorTextSelection(CaretPosition, CaretPosition, CaretPosition)
		  End If
		  
		  // The selection should end at the end of the line.
		  mCurrentSelection.EndLocation = mCharacters.Count
		  
		  // Set the selection anchor point to the caret position.
		  mCurrentSelection.Anchor = CaretPosition
		  
		  // Move the caret to the end of the selection.
		  CaretPosition = mCurrentSelection.EndLocation
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F76657320746865206361726574206F6E6520706F736974696F6E20746F20746865206C65667420616E64206D6F646966696573207468652063757272656E742073656C656374696F6E2E
		Sub MoveLeftAndModifySelection()
		  /// Moves the caret one position to the left and modifies the current selection.
		  ///
		  /// The user has pressed Shift+Left arrow.
		  
		  // Edge case: At the beginning of the line.
		  If CaretPosition = 0 Then Return
		  
		  If mCurrentSelection = Nil Then
		    // Create a new selection anchored at the current caret position, starting a character before.
		    mCurrentSelection = New XUIInspectorTextSelection(CaretPosition, CaretPosition - 1, CaretPosition)
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
		  
		  // Move the caret left one place.
		  CaretPosition = CaretPosition - 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F76657320746865206361726574206F6E6520706F736974696F6E20746F2074686520726967687420616E64206D6F646966696573207468652063757272656E742073656C656374696F6E2E
		Sub MoveRightAndModifySelection()
		  /// Moves the caret one position to the right and modifies the current selection.
		  ///
		  /// The user has pressed Shift+Right arrow.
		  
		  // Edge case: At the end of the line.
		  If CaretPosition = mCharacters.Count Then Return
		  
		  If mCurrentSelection = Nil Then
		    // Create a new selection anchored at the current caret position, ending at the next character.
		    mCurrentSelection = New XUIInspectorTextSelection(CaretPosition, CaretPosition, CaretPosition + 1)
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
		  
		  // Move the caret right onew place.
		  CaretPosition = CaretPosition + 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F7665732074686520636172657420746F2074686520626567696E6E696E67206F6620746865206C696E652E
		Sub MoveToBeginningOfLine()
		  /// Moves the caret to the beginning of the line.
		  
		  // Clear any existing text selection.
		  If TextSelected Then
		    mCurrentSelection = Nil
		  End If
		  
		  CaretPosition = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F7665732074686520636172657420746F2074686520656E64206F6620746865206C696E652E
		Sub MoveToEndOfLine()
		  /// Moves the caret to the end of the line.
		  
		  // Clear any existing text selection.
		  If TextSelected Then
		    mCurrentSelection = Nil
		  End If
		  
		  CaretPosition = mCharacters.Count
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F766573207468652073656C656374696F6E20746F20746865206C65667420656E64206F6620746865206C696E652E
		Sub MoveToLeftEndOfLineAndModifySelection()
		  /// Moves the selection to the left end of the line.
		  
		  // Edge case: Already at the left end of the current line.
		  If CaretPosition = 0 Then Return
		  
		  If mCurrentSelection = Nil Then
		    // Create a new selection anchored and ending at the current caret position
		    // but starting at the beginning of the line.
		    mCurrentSelection = New XUIInspectorTextSelection(CaretPosition, 0, CaretPosition)
		  Else
		    // Get the start position the selection begins at.
		    If CaretPosition > mCurrentSelection.Anchor Then
		      // Change the selection such that it begins at the start of the line, 
		      // keeps it current anchor point and ends at the anchor point.
		      mCurrentSelection.StartLocation = 0
		      mCurrentSelection.EndLocation = mCurrentSelection.Anchor
		    Else
		      // Start the selection at the start of the line that the selection begins on.
		      mCurrentSelection.StartLocation = 0
		    End If
		  End If
		  
		  // Move the caret to the selection start position.
		  CaretPosition = mCurrentSelection.StartLocation
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F766573207468652073656C656374696F6E20746F2074686520726967687420656E64206F6620746865206C696E652E
		Sub MoveToRightEndOfLineAndModifySelection()
		  /// Moves the selection to the right end of the line.
		  
		  // Edge case: At the end of the document.
		  If CaretPosition = mCharacters.Count Then Return
		  
		  If Not TextSelected Then
		    // Create a new selection, anchored and starting at the caret and ending at the end of the line.
		    mCurrentSelection = New XUIInspectorTextSelection(CaretPosition, CaretPosition, mCharacters.Count)
		  Else
		    If CaretPosition > mCurrentSelection.Anchor Then
		      mCurrentSelection.EndLocation = mCharacters.Count
		    Else
		      // Set the start of the selection to the current anchor.
		      mCurrentSelection.StartLocation = mCurrentSelection.Anchor
		      mCurrentSelection.EndLocation = mCharacters.Count
		    End If
		  End If
		  
		  // Move the caret to the end of the selection.
		  CaretPosition = mCurrentSelection.EndLocation
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F76657320757020616E64206D6F646966696573207468652073656C656374696F6E2E
		Sub MoveUpAndModifySelection()
		  /// Moves up and modifies the selection.
		  
		  If Not TextSelected Then
		    // Create a new selection that starts, ends and is anchored at the current caret position.
		    mCurrentSelection = New XUIInspectorTextSelection(CaretPosition, CaretPosition, CaretPosition)
		  End If
		  
		  // The selection begins at the beginning of the line.
		  mCurrentSelection.StartLocation = 0
		  
		  // Set the selection anchor point to the caret position.
		  mCurrentSelection.Anchor = CaretPosition
		  
		  // Move the caret to the start of the selection.
		  CaretPosition = mCurrentSelection.StartLocation
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53656C6563742074686520746578742066726F6D2074686520626567696E6E696E67206F662074686520776F726420746F20746865206C656674206F662074686520636172657420746F207468652063757272656E7420636172657420706F736974696F6E2E
		Sub MoveWordLeftAndModifySelection()
		  /// Selects the text from the beginning of the word to the left of the caret to 
		  /// the current caret position.
		  
		  // Edge case: At the beginning of the line.
		  If CaretPosition = 0 Then Return
		  
		  Var prevWordStart As Integer = PreviousWordStart(CaretPosition)
		  
		  If mCurrentSelection = Nil Then
		    // Create a new selection anchored at the current caret position, starting at the 
		    // beginning of the word to the left of the caret. 
		    mCurrentSelection = New XUIInspectorTextSelection(CaretPosition, prevWordStart, CaretPosition)
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
		  CaretPosition = prevWordStart
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520636172657420706F736974696F6E206F662074686520656E64206F662074686520776F72642061667465722074686520606361726574506F73602E
		Private Function NextWordEnd(caretPos As Integer) As Integer
		  /// Returns the caret position of the end of the word after the `caretPos`.
		  ///
		  /// Raises an `InvalidArgumentException` if `caretPos` is out of range for this line.
		  
		  // Sanity checks.
		  If caretPos < 0 Or caretPos > mCharacters.Count Then
		    Raise New InvalidArgumentException("Invalid `caretPos`")
		  End If
		  
		  // Edge case 1: At the end of the line.
		  If caretPos = mCharacters.Count Then Return caretPos
		  
		  // A word end is the position immediately after the last run of alphanumeric characters.
		  Var iMax As Integer = mCharacters.LastIndex
		  Var seenAlpha As Boolean = False
		  For i As Integer = caretPos To iMax
		    If mCharacters(i).IsLetterOrDigit Then
		      seenAlpha = True
		      Continue
		    End If
		    If seenAlpha Then Return i
		  Next i
		  
		  Return mCharacters.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686973206974656D2062656C6F6E677320746F2E
		Function Owner() As XUIInspector
		  /// A weak reference to the inspector this item belongs to.
		  
		  If mOwner = Nil Or mOwner.Value = Nil Then
		    Return Nil
		  Else
		    Return XUIInspector(mOwner.Value)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061696E747320746865206361726574202869662076697369626C6529206174207468652063757272656E7420636172657420706F736974696F6E2E
		Private Sub PaintCaret(style As XUIInspectorStyle)
		  /// Paints the caret (if visible) at the current caret position.
		  ///
		  /// Assumes `mBuffer` is not Nil.
		  
		  // Get the characters up to the caret.
		  Var chars As String = CharsToCaret
		  
		  Var g As Graphics = mBuffer.Graphics
		  g.SaveState
		  g.FontSize = style.FontSize
		  g.FontName = style.FontName
		  
		  // Compute the x coordinate of the caret.
		  Var x As Double = HPADDING + g.TextWidth(chars)
		  
		  // Draw the caret.
		  g.DrawingColor = style.TextColor
		  g.DrawLine(x, VPADDING, x, g.Height - (2 * VPADDING))
		  
		  g.RestoreState
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061696E7473207468652073656C656374696F6E206261636B67726F756E6420746F20606D4275666665726020696620746865726520697320612073656C656374696F6E2E
		Private Sub PaintSelection(selectionColor As ColorGroup)
		  /// Paints the selection background to `mBuffer` if there is a selection.
		  ///
		  /// Assumes `mBuffer` is not Nil.
		  
		  If mCurrentSelection = Nil Then Return
		  If mBuffer = Nil Then Return
		  
		  // Compute the x coordinate of where the selection begins.
		  Var selectionX As Double = HPADDING + WidthToColumn(mCurrentSelection.StartLocation, mBuffer.Graphics)
		  
		  // Compute the width of the selection.
		  Var selectionW As Double = mBuffer.Graphics.TextWidth(SelectedText)
		  
		  // Draw the selection background.
		  mBuffer.Graphics.DrawingColor = selectionColor
		  mBuffer.Graphics.FillRectangle(selectionX, 1, selectionW, mBuffer.Height - 2)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520636172657420706F73206F6620746865207374617274206F662074686520776F7264206265666F72652074686520606361726574506F73602E
		Function PreviousWordStart(caretPos As Integer) As Integer
		  /// Returns the caret pos of the start of the word before the `caretPos`.
		  ///
		  /// Raises an `InvalidArgumentException` if `caretPos` is out of range.
		  
		  // Sanity checks.
		  If caretPos < 0 Or caretPos > mCharacters.Count Then
		    Raise New InvalidArgumentException("Invalid `caretPos`")
		  End If
		  
		  // Edge case 1: At the start of the line.
		  If caretPos = 0 Then Return 0
		  
		  // A word start is the position immediately before a contiguous run of 
		  // alphanumeric characters.
		  Var seenAlpha, seenNonAlpha As Boolean = False
		  For i As Integer = caretPos - 1 DownTo 0
		    If Not mCharacters(i).IsLetterOrDigit Then
		      If seenAlpha Then
		        Return i + 1
		      Else
		        seenNonAlpha = True
		        Continue
		      End If
		    Else
		      seenAlpha = True
		    End If
		  Next i
		  
		  Return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E64657220746869732074657874206669656C6420746F206067602061742060782C20796020776974682074686520737065636966696564206077696474686020616E642060686569676874602E
		Sub Render(g As Graphics, x As Double, y As Double, width As Double, height As Double, style As XUIInspectorStyle, hasFocus As Boolean)
		  /// Render this text field to `g` at `x, y` with the specified `width` and `height`.
		  
		  If Owner = Nil Or Owner.Window = Nil Then Return
		  
		  g.SaveState
		  
		  // Cache the computed contents.
		  Var cachedContents As String = Contents
		  
		  // Cache the style and width.
		  mStyle = style
		  mCachedVisibleWidth = width
		  
		  // Compute the required width of the buffer.
		  Var bufferW As Double = Max(g.TextWidth(cachedContents) + (2 * HPADDING), width)
		  
		  // Compute the required height of the buffer.
		  Var bufferH As Double = Max(g.TextHeight + g.FontAscent, height)
		  
		  // Create the buffer.
		  mBuffer = Owner.Window.BitmapForCaching(bufferW, bufferH)
		  
		  // Brevity.
		  Var bufferG As Graphics = mBuffer.Graphics
		  
		  // Set the font properties.
		  bufferG.FontName = style.FontName
		  bufferG.FontSize = style.FontSize
		  
		  // Background.
		  mBuffer.Graphics.DrawingColor = style.ControlBackgroundColor
		  mBuffer.Graphics.FillRectangle(0, 0, mBuffer.Graphics.Width, mBuffer.Graphics.Height)
		  
		  // Selected text background.
		  PaintSelection(style.SelectionColor)
		  
		  // Get the text to draw.
		  Var textToDraw As String = If(mCharacters.Count = 0, Placeholder, cachedContents)
		  
		  // Compute the text baseline.
		  Const BASELINE_FUDGE = 10
		  Var baseline As Double = (bufferH / 2) - (bufferG.TextHeight / 2) + BASELINE_FUDGE
		  
		  // Text.
		  If mCharacters.Count = 0 Then
		    bufferG.DrawingColor = style.PlaceholderTextColor
		  Else
		    bufferG.DrawingColor = style.TextColor
		  End If
		  bufferG.DrawText(textToDraw, HPADDING, baseline)
		  
		  If hasFocus And Owner.CaretVisible Then
		    PaintCaret(style)
		  End If
		  
		  // Draw the buffer to the graphics context.
		  g.DrawPicture(mBuffer, x, y, width, height, mScrollOffset, 0)
		  
		  // Draw the border.
		  g.PenSize = 1
		  If hasFocus Then
		    g.DrawingColor = style.AccentColor
		  Else
		    g.DrawingColor = style.ControlBorderColor
		  End If
		  g.DrawRectangle(x, y, width, height)
		  
		  g.RestoreState
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265706C61636573207468652063757272656E742073656C656374696F6E2077697468206073602E
		Sub ReplaceSelection(s As String)
		  /// Replaces the current selection with `s`.
		  
		  // Quick exit if there is nothing selected.
		  If mCurrentSelection = Nil Then Return
		  
		  // Edge case 1: Is the whole line selected?
		  If mCurrentSelection.StartLocation = 0 And mCurrentSelection.Length = mCharacters.Count Then
		    Contents = s
		    CaretPosition = s.Length
		    mCurrentSelection = Nil
		    Return
		  End If
		  
		  // Rpelace the selected text with `s`.
		  Contents = Contents.Replace(SelectedText, s)
		  
		  // Reposition the caret.
		  CaretPosition = mCurrentSelection.EndLocation
		  
		  // Clear the selection.
		  mCurrentSelection = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D707574657320746865207265717569726564207363726F6C6C206F666673657420746F20656E737572652074686174207468652063617265742069732076697369626C652077697468696E206076697369626C655769647468602E
		Private Sub ScrollToCaret(visibleWidth As Double)
		  /// Computes the required scroll offset to ensure that the caret is visible within `visibleWidth`.
		  ///
		  /// Assumes `mBuffer` is not Nil.
		  
		  Var g As Graphics = mBuffer.Graphics
		  
		  Var caretX As Double = HPADDING + WidthToColumn(CaretPosition, g)
		  
		  If CaretPosition = 0 Then
		    // No need to scroll
		    mScrollOffset = 0
		    
		  ElseIf caretX > visibleWidth Then
		    // Scroll right.
		    Var widthDiff As Double = g.Width - visibleWidth
		    mScrollOffset = Max(caretX - visibleWidth + widthDiff + RIGHT_SCROLL_PADDING, 0)
		    
		  ElseIf caretX < mScrollOffset Then
		    // Scroll left.
		    mScrollOffset = Max(caretX - LEFT_SCROLL_PADDING, 0)
		    
		  ElseIf mScrollOffset > g.Width - visibleWidth Then
		    mScrollOffset = Max(caretX - LEFT_SCROLL_PADDING, 0)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53656C6563742074686520656E7469726520636F6E74656E7473206F66207468652074657874206669656C642E
		Sub SelectAll()
		  /// Select the entire contents of the text field.
		  
		  mCurrentSelection = New XUIInspectorTextSelection(0, 0, mCharacters.Count)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652063757272656E746C792073656C65637465642074657874206F72202222206966207468657265206973206E6F2073656C656374696F6E2E
		Function SelectedText() As String
		  /// Returns the currently selected text or "" if there is no selection.
		  
		  // Nothing selected?
		  If mCurrentSelection = Nil Or (mCurrentSelection.StartLocation = mCurrentSelection.EndLocation) Then
		    Return ""
		  End If
		  
		  Return Contents.Middle(mCurrentSelection.StartLocation, mCurrentSelection.Length)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 55706461746573207468652063757272656E7420636172657420706F736974696F6E206261736564206F6E206120636C69636B2061742060782C2079602E
		Sub UpdateCaretPosition(x As Double, y As Double)
		  /// Updates the current caret position based on a click at `x, y`.
		  ///
		  /// `x, y` does *not* factor in scrolling.
		  /// Assumes `mBuffer` is not Nil.
		  /// Assumes `Render` has been called at least once prior to this as we rely on it caching the style.
		  
		  #Pragma Unused y
		  
		  // Adjust for scrolling.
		  x = x + mScrollOffset - If(mScrollOffset > 0, mBuffer.Graphics.Width - mCachedVisibleWidth, 0)
		  
		  // Easy case, the caret is before the first character.
		  If x < HPADDING Then
		    mCaretPosition = 0
		    Return
		  End If
		  
		  // Brevity.
		  Var g As Graphics = mBuffer.Graphics
		  
		  Var cumul As String
		  For i As Integer = 0 To mCharacters.LastIndex
		    cumul = cumul + mCharacters(i)
		    Var widthToChar As Double = HPADDING + g.TextWidth(cumul)
		    If x <= widthToChar Then
		      mCaretPosition = i
		      Return
		    End If
		  Next i
		  
		  // Must be at the end of the text field.
		  mCaretPosition = mCharacters.Count
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54686520776964746820696E20706978656C732066726F6D20746865207374617274206F6620746865206C696E6520746F2060636F6C756D6E602E20446F6573206E6F74206163636F75746E20666F7220616E7920686F72697A6F6E74616C2070616464696E672E20417373756D6573206067602069732074686520636F6E7465787420746861742077696C6C20626520647261776E20746F20616E6420746861742074686520666F6E742070726F70657274696573206861766520616C7265616479206265656E207365742E
		Private Function WidthToColumn(column As Integer, g As Graphics) As Double
		  /// The width in pixels from the start of the line to `column`. Does not accoutn for any horizontal padding.
		  /// Assumes `g` is the context that will be drawn to and that the font properties have already been set.
		  
		  column = XUIMaths.Clamp(column, 0, mCharacters.Count)
		  
		  If column = 0 Then Return 0
		  
		  Var s As String = Contents.Middle(0, column)
		  
		  Return g.TextWidth(s)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Handles rendering a text field to a graphics context.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2063617074696F6E20746F20646973706C61792077697468696E207468652074657874206669656C642061742074686520696E6E6572206C65667420656467652E
		Caption As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E7420636172657420706F736974696F6E2E20603060206973206265666F726520746865206669727374206368617261637465722E
		#tag Getter
			Get
			  Return mCaretPosition
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCaretPosition = XUIMaths.Clamp(value, 0, mCharacters.Count)
			  
			  ScrollToCaret(mCachedVisibleWidth)
			End Set
		#tag EndSetter
		CaretPosition As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6E74656E7473206F6620746869732074657874206669656C642E
		#tag Getter
			Get
			  Return String.FromArray(mCharacters, "")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCharacters = value.Split("")
			End Set
		#tag EndSetter
		Contents As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520686569676874206F66207468652074657874206669656C642E
		Height As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520627566666572207069637475726520726570726573656E74696E6720746869732074657874206669656C6420696E2069747320656E74697265747920286578636C7564696E6720626F726465727320616E6420666F6375732072696E67292E
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436163686564207265666572656E636520746F20746865206077696474686020706172616D657465722070617373656420746F74206865206052656E64657260206D6574686F642E
		Private mCachedVisibleWidth As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E7420636172657420706F736974696F6E2E20603060206973206265666F726520746865206669727374206368617261637465722E
		Private mCaretPosition As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E207468652063617265742077696C6C20626520647261776E2E
		Private mCaretVisible As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207261772063686172616374657273206F6620746869732074657874206669656C642E
		Private mCharacters() As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F7220746865206043757272656E7453656C656374696F6E6020636F6D70757465642070726F70657274792E
		Private mCurrentSelection As XUIInspectorTextSelection
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E20746869732074657874206669656C64206861732074686520666F6375732E
		Private mHasFocus As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520585549496E73706563746F72207768696368206F776E7320746869732074657874206669656C642E204D6179206265204E696C2E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652058207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F7369746976652076616C75657320696E646963617465207363726F6C6C696E6720746F207468652072696768742E
		Private mScrollOffset As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436163686564207265666572656E636520746F20746865206C617374207374796C65207573656420696E20746865206052656E64657260206D6574686F642E
		Private mStyle As XUIInspectorStyle
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207765616B207265666572656E636520746F20746865206F776E696E6720696E73706563746F722E204D6179206265204E696C206966206E6F742079657420616464656420746F20616E20696E73706563746F722E
		#tag Getter
			Get
			  If mOwner = Nil Or mOwner.Value = Nil Then
			    Return Nil
			  Else
			    Return XUIInspector(mOwner.Value)
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value = Nil Then
			    mOwner = Nil
			  Else
			    mOwner = New WeakRef(value)
			  End If
			  
			End Set
		#tag EndSetter
		Owner As XUIInspector
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C20706C616365686F6C64657220746578742E
		Placeholder As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620746865726520697320616E7920746578742063757272656E746C792073656C65637465642E
		#tag Getter
			Get
			  /// True if there is any text currently selected.
			  
			  Return mCurrentSelection <> Nil
			  
			End Get
		#tag EndGetter
		TextSelected As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865207769647468206F66207468652074657874206669656C642E
		Width As Double
	#tag EndProperty


	#tag Constant, Name = HPADDING, Type = Double, Dynamic = False, Default = \"7", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520636F6E74656E7473206C65667420616E642072696768742E
	#tag EndConstant

	#tag Constant, Name = LEFT_SCROLL_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F20706164206C656674207768656E207363726F6C6C696E67206C65667477617264732E
	#tag EndConstant

	#tag Constant, Name = RIGHT_SCROLL_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 467564676520666163746F7220666F722070616464696E6720746865207269676874206F6620746865206C696E65207768656E20686F72697A6F6E74616C207363726F6C6C696E672E
	#tag EndConstant

	#tag Constant, Name = VPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520636F6E74656E747320746F7020616E6420626F74746F6D2E
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
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
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="Width"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Placeholder"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="TextSelected"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
