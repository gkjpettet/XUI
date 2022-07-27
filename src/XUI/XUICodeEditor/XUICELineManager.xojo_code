#tag Class
Protected Class XUICELineManager
	#tag Method, Flags = &h0, Description = 41646A757374732074686520737461727420616E6420656E6420706F736974696F6E73206F66206576657279206C696E6520626567696E6E696E67206174206066697273744C696E654E756D62657260206279206076616C7565602E
		Sub AdjustLineOffsets(firstLineNumber As Integer, value As Integer, lineNumberDelta As Integer)
		  /// Adjusts the start and end positions of every line beginning at 
		  /// `firstLineNumber` by `value`.
		  ///
		  /// `lineNumberDelta` is the number to adjust the line numbers by.
		  
		  // Sanity check.
		  If firstLineNumber < 1 Then
		    Raise New InvalidArgumentException("`firstLineNumber` is out of range")
		  End If
		  
		  // Bail early?
		  If firstLineNumber > Lines.Count Then Return
		  
		  mLastChanged = System.Microseconds
		  
		  Var iMax As Integer = Lines.LastIndex
		  Var line As XUICELine
		  For i As Integer = firstLineNumber - 1 To iMax
		    line = Lines(i)
		    
		    // Adjust the start position.
		    line.Start = line.Start + value
		    
		    // Update the line number.
		    line.Number = line.Number + lineNumberDelta
		    
		    // Mark the line as dirty as it's line number may have changed.
		    line.IsDirty = True
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206E756D626572206F66206C696E6573206F6620636F646520286578636C7564657320656D707479206C696E657320616E6420636F6D6D656E742D6F6E6C79206C696E6573292E
		Function CodeLineCount() As Integer
		  /// Returns the number of lines of code (excludes empty lines and comment-only lines).
		  
		  Var count As Integer = 0
		  For Each line As XUICELine In Lines
		    If Not line.IsEmpty And Not Formatter.IsCommentLine(line) Then
		      count = count + 1
		    End If
		  Next line
		  
		  Return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 606F776E657260206973207468652060585549436F6465456469746F72602074686174206F776E732074686973206C696E65206D616E616765722E
		Sub Constructor(owner As XUICodeEditor)
		  /// `owner` is the `XUICodeEditor` that owns this line manager.
		  
		  mOwnerRef = New WeakRef(owner)
		  
		  // Start with a single empty line.
		  Lines.Add(New XUICELine(Self, 1, 0, ""))
		  
		  mLongestLine = Lines(0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520636F6E74656E7473206F66206576657279206C696E652E
		Function Contents() As String
		  /// Returns the contents of every line.
		  
		  Var s() As String
		  For Each line As XUICELine In Lines
		    s.Add(line.Contents)
		  Next line
		  
		  Return String.FromArray(s, &u0A)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520636F6E74656E7473206F66206576657279206C696E6520696E20746865207061737365642072616E67652028696E636C7573697665292E
		Function ContentsFrom(startLineNumber As Integer, endLineNum As Integer = -1) As String
		  /// Returns the contents of every line in the passed range (inclusive).
		  ///
		  /// - `startLineNum` is the 1-based number of the line to start at.
		  /// - `endLineNum` is the 1-based number of the line to end at.
		  ///
		  /// If `endLineNum = -1` then we get all contents from `startLineNum` to the last line.
		  
		  If endLineNum = -1 Then endLineNum = Lines.Count
		  
		  // Sanity checks.
		  If startLineNumber < 1 Or endLineNum < startLineNumber Or _
		    endLineNum > LineCount Then
		    Raise New InvalidArgumentException("Invalid range")
		  End If
		  
		  Var s() As String
		  Var iMax As Integer = endLineNum - 1
		  For i As Integer = startLineNumber - 1 To iMax
		    s.Add(Lines(i).Contents)
		  Next i
		  
		  Return String.FromArray(s, &u0A)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C6574657320616C6C206C696E657320616E6420757064617465732074686520636172657420706F736974696F6E2E
		Sub DeleteAllLines(allowUndo As Boolean, shouldInvalidate As Boolean, raiseContentsDidChange As Boolean = True)
		  /// Deletes all lines and updates the caret position.
		  ///
		  /// If `allowUndo` is True then this action will be undoable.
		  /// If `shouldInvalidate` is False then the canvas will not be immediately invalidated.
		  
		  mLastChanged = System.Microseconds
		  
		  If allowUndo And Owner.UndoManager <> Nil Then
		    Var action As New XUICEUndoableDelete(Owner, Owner.CurrentUndoID, "Delete All Lines", _
		    Contents, New XUICETextSelection(0, 0, 0, Owner))
		    Owner.UndoManager.Push(action)
		  End If
		  
		  Lines.RemoveAll
		  Lines.Add(New XUICELine(Self, 1, 0, ""))
		  UpdateLongestLine
		  Owner.CaretPosition = 0
		  Owner.CurrentSelection = Nil
		  If shouldInvalidate Then Owner.Refresh
		  If raiseContentsDidChange Then Owner.ContentsDidChange
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C6574657320746865206C696E6520617420606C696E654E756D6265726020616E642061646A757374732073756273657175656E74206C696E65206F666673657473206279206061646A7573744279602E20446F6573206E6F74206D6F7665207468652063617265742E
		Sub DeleteLineAt(lineNumber As Integer, adjustBy As Integer)
		  /// Deletes the line at `lineNumber` and adjusts subsequent line offsets by `adjustBy`. 
		  /// Does not move the caret.
		  ///
		  /// Raises an `InvalidArgumentException` if `lineNumber` is out of range.
		  
		  mLastChanged = System.Microseconds
		  
		  // Sanity checks.
		  If lineNumber < 1 Or lineNumber > LineCount Then
		    Raise New InvalidArgumentException("Invalid `lineNumber`")
		  End If
		  
		  // Remove the line.
		  Lines.RemoveAt(lineNumber - 1)
		  
		  // Adjust the offsets of the lines following the deleted line.
		  AdjustLineOffsets(lineNumber, adjustBy, -1)
		  
		  // Did we just delete the longest line?
		  If mLongestLine.Number = lineNumber Then
		    // Yes we did.
		    UpdateLongestLine
		  End If
		  
		  // If the number of numerals in the highest line number has increased then we 
		  // will require a full redraw because the gutter will need to be redrawn 
		  // for every line (as it will have changed in width).
		  If Owner.DisplayLineNumbers Then
		    Owner.NeedsFullRedraw = True
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C65746573207468652063757272656E7420746578742073656C656374696F6E20616E6420757064617465732074686520636172657420706F736974696F6E2E
		Sub DeleteSelection(allowUndo As Boolean, shouldInvalidate As Boolean, raiseContentsDidChange As Boolean = True, undoMessage As String = "")
		  /// Deletes the current text selection and updates the caret position.
		  ///
		  /// - If `allowUndo` is True then this action should be pushed to the undo manager.
		  /// - If `shouldInvalidate` is True then the canvas will be invalidated after the deletion.
		  /// - If `raiseContentsDidChange` is True then we will raise the editor's `ContentsDidChange event`.
		  /// - `undoMessage` is an optional override message for undoable actions.
		  ///
		  /// There are 6 scenarios:
		  ///
		  /// 1. A single whole line is selected.
		  /// 2. Only text on a single line is selected.
		  /// 3. Contiguous complete lines are selected.
		  /// 4. All of the start line but only part of the end line is selected.
		  /// 5. Part of the start line and all of the end line is selected.
		  /// 6. Part of the start line and part of the end line are selected.
		  
		  undoMessage = If(undoMessage = "", "Delete Selection", undoMessage)
		  
		  mDidDeleteContiguousLines = False
		  
		  // Get the current selection.
		  Var selection As XUICETextSelection = Owner.CurrentSelection
		  
		  // Quick exit if there's nothing selected.
		  If selection = Nil Then Return
		  
		  mLastChanged = System.Microseconds
		  
		  // Get the lines that the selection starts and ends on.
		  Var startLine As XUICELine = LineForCaretPos(selection.StartLocation)
		  Var endLine As XUICELine = LineForCaretPos(selection.EndLocation)
		  
		  // =============================================
		  // Case 1: A single whole line is selected.
		  // =============================================
		  If startLine.Number = endLine.Number And selection.ContainsLine(startLine) Then
		    If allowUndo And Owner.UndoManager <> Nil Then
		      Owner.UndoManager.Push(_
		      New XUICEUndoableDelete(Owner, Owner.CurrentUndoID, undoMessage, _
		      startLine.Contents, selection.Clone))
		    End If
		    startLine.SetContents("", False)
		    AdjustLineOffsets(startLine.Number + 1, -selection.Length, 0)
		    TokeniseAllLines
		    
		    Owner.MoveCaretToPos(startLine.Start, False)
		    UpdateLongestLine
		    Owner.CurrentSelection = Nil
		    If shouldInvalidate Then Owner.Refresh
		    If raiseContentsDidChange Then Owner.ContentsDidChange
		    Return
		  End If
		  
		  // ===============================================
		  // Case 2: Only text on a single line is affected.
		  // ===============================================
		  If startLine.Number = endLine.Number Then
		    If allowUndo And Owner.UndoManager <> Nil Then
		      Var action As New XUICEUndoableDelete(Owner, Owner.CurrentUndoID, undoMessage, _
		      startLine.CharactersFromCaretPos(selection.StartLocation, selection.Length), selection.Clone)
		      Owner.UndoManager.Push(action)
		    End If
		    
		    startLine.DeleteCharactersFromCaretPos(selection.StartLocation, selection.Length, False)
		    AdjustLineOffsets(startLine.Number + 1, -selection.Length, 0)
		    TokeniseAllLines
		    
		    Owner.MoveCaretToPos(selection.StartLocation, False)
		    UpdateLongestLine
		    Owner.CurrentSelection = Nil
		    If shouldInvalidate Then Owner.Refresh
		    If raiseContentsDidChange Then Owner.ContentsDidChange
		    Return
		  End If
		  
		  // ====================================================
		  // Case 3: Contiguous complete lines are being removed.
		  // ====================================================
		  If selection.ContainsLine(startLine) And selection.ContainsLine(endLine) Then
		    mDidDeleteContiguousLines = True
		    
		    // How many lines are we deleting?
		    Var delCount As Integer = endLine.Number - startLine.Number + 1
		    
		    If delCount = LineCount Then
		      // Delete everything.
		      DeleteAllLines(allowUndo, shouldInvalidate, raiseContentsDidChange)
		      Return
		    Else
		      // Deleting a block of contiguous lines.
		      If allowUndo And Owner.UndoManager <> Nil Then
		        Var action As New XUICEUndoableDelete(Owner, Owner.CurrentUndoID, undoMessage, _
		        ContentsFrom(startLine.Number, endLine.Number) + &u0A, selection.Clone)
		        Owner.UndoManager.Push(action)
		      End If
		      
		      For i As Integer = endLine.Number - 1 DownTo startLine.Number - 1
		        Lines.RemoveAt(i)
		      Next i
		      
		      AdjustLineOffsets(startLine.Number, -selection.Length - 1, -delCount)
		      
		      TokeniseAllLines
		      
		      Owner.MoveCaretToPos(selection.StartLocation, False)
		      UpdateLongestLine
		      Owner.CurrentSelection = Nil
		      If shouldInvalidate Then Owner.Refresh
		      If raiseContentsDidChange Then Owner.ContentsDidChange
		      Return
		    End If
		  End If
		  
		  // ====================================================================================
		  // Case 4: All of the start line is selected but only part of the end line is selected.
		  // ====================================================================================
		  If selection.ContainsLine(startLine) And Not selection.ContainsLine(endLine) Then
		    // In order to undo, we need to record the text that'll be deleted.
		    Var deletedText As String = selection.ToString
		    
		    // Delete the start line and every line up to (but not including) the end line.
		    Var linesDeleted As Integer
		    For i As Integer = endLine.Number - 2 DownTo startLine.Number - 1
		      Lines.RemoveAt(i)
		      linesDeleted = linesDeleted + 1
		    Next i
		    
		    // Determine how many characters need removing from the front of the end line.
		    Var charCountToDel As Integer = selection.EndLocation - endLine.Start
		    
		    // Remove the selected portion of text at the begining of the end line.
		    endLine.SetContents(endLine.Contents.RightCharacters(endLine.Length - charCountToDel), False)
		    
		    AdjustLineOffsets(startLine.Number, -selection.Length, -linesDeleted)
		    
		    // Need to tweak the end line's start and end positions as they will be off
		    // by the number of characters deleted.
		    endLine.Start = endLine.Start + charCountToDel
		    
		    If allowUndo And Owner.UndoManager <> Nil Then
		      Var action As New XUICEUndoableDelete(Owner, Owner.CurrentUndoID, undoMessage, _
		      deletedText, selection.Clone)
		      Owner.UndoManager.Push(action)
		    End If
		    
		    TokeniseAllLines
		    Owner.MoveCaretToPos(selection.StartLocation, False)
		    UpdateLongestLine
		    Owner.CurrentSelection = Nil
		    Owner.NeedsFullRedraw = True
		    If shouldInvalidate Then Owner.Refresh
		    If raiseContentsDidChange Then Owner.ContentsDidChange
		    Return
		  End If
		  
		  // ====================================================================
		  // Case 5: Part of the start line and all of the end line are selected.
		  // ====================================================================
		  If Not selection.ContainsLine(startLine) And selection.ContainsLine(endLine) Then
		    // In order to undo, we need to record the text deleted.
		    Var deletedText As String = selection.ToString
		    
		    // Chop the selection from the end of the start line.
		    startLine.DeleteCharactersFromEnd(startLine.Finish - selection.StartLocation, False)
		    
		    // Delete the rest of the lines in the selection.
		    Var linesDeleted As Integer
		    For i As Integer = endLine.Number - 1 DownTo startLine.Number
		      Lines.RemoveAt(i)
		      linesDeleted = linesDeleted + 1
		    Next i
		    
		    If allowUndo And Owner.UndoManager <> Nil Then
		      Var action As New XUICEUndoableDelete(Owner, Owner.CurrentUndoID, undoMessage, _
		      deletedText, selection.Clone)
		      Owner.UndoManager.Push(action)
		    End If
		    
		    AdjustLineOffsets(startLine.Number + 1, -selection.Length, -linesDeleted)
		    
		    TokeniseAllLines
		    
		    Owner.MoveCaretToPos(selection.StartLocation, False)
		    UpdateLongestLine
		    Owner.CurrentSelection = Nil
		    If shouldInvalidate Then Owner.Refresh
		    If raiseContentsDidChange Then Owner.ContentsDidChange
		    Return
		  End If
		  
		  // =====================================================================
		  // Case 6: Part of the start line and part of the end line are selected.
		  // =====================================================================
		  If Not selection.ContainsLine(startLine) And Not selection.ContainsLine(endLine) Then
		    // In order to undo, we need to record the text deleted.
		    Var deletedText As String = selection.ToString
		    
		    // Get the non-selected lefthand characters on the start line to preserve.
		    Var newContents As String = startLine.Left(selection.StartLocation - startLine.Start)
		    
		    // Merge the non-selected characters from the end line into the new contents.
		    newContents = newContents + endLine.Right(endLine.Finish - selection.EndLocation)
		    
		    startLine.SetContents(newContents, False)
		    
		    // Delete all the lines in the selection except the start line.
		    Var linesDeleted As Integer
		    For i As Integer = endLine.Number - 1 DownTo startLine.Number
		      Lines.RemoveAt(i)
		      linesDeleted = linesDeleted + 1
		    Next i
		    
		    If allowUndo And Owner.UndoManager <> Nil Then
		      Var action As New XUICEUndoableDelete(Owner, Owner.CurrentUndoID, undoMessage, _
		      deletedText, selection.Clone)
		      Owner.UndoManager.Push(action)
		    End If
		    
		    AdjustLineOffsets(startLine.Number + 1, -selection.Length, -linesDeleted)
		    
		    TokeniseAllLines
		    
		    Owner.MoveCaretToPos(selection.StartLocation, False)
		    UpdateLongestLine
		    Owner.CurrentSelection = Nil
		    If shouldInvalidate Then Owner.Refresh
		    If raiseContentsDidChange Then Owner.ContentsDidChange
		    Return
		  End If
		  
		  // If we get here then we've reached a condition I haven't thought of :(
		  Raise New UnsupportedOperationException("Unknown delete selection condition")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E73657274732060636861726020617420606361726574506F736020616E6420757064617465732074686520746865206F776E696E6720656469746F72277320636172657420706F736974696F6E2E
		Sub InsertCharacter(caretPos As Integer, char As String, allowUndo As Boolean, raiseContentsDidChange As Boolean = True)
		  /// Inserts `char` at `caretPos` and updates the the owning editor's caret position.
		  ///
		  /// If `allowUndo` is True then this action will be undoable.
		  /// If `raiseContentsDidChange` is True then we raise the editor's `ContentsDidChange` event.
		  ///
		  /// For performance, we make a number of assumptions:
		  /// - Assumes that `char` is a single character.
		  /// - Assumes `0 <= caretPos > (LastLine.EndPosition + 1)`.
		  /// - Assumes `char` is not a newline character.
		  
		  // Some formatters disallow whitespace at the beginning of the line.
		  // We consider space and tab to be whitespace.
		  If Not Formatter.AllowsLeadingWhitespace And Owner.CaretColumn = 0 Then
		    If char = " " Or char = &u009 Then Return
		  End If
		  
		  mLastChanged = System.Microseconds
		  
		  // Cache the current line count.
		  Var oldLineCount As Integer = Lines.Count
		  
		  // Get the line to insert into.
		  Var line As XUICELine = LineForCaretPos(caretPos)
		  
		  // Cache the length of the current longest line in case we modify it.
		  Var longestLineLength As Integer = mLongestLine.ColumnLength
		  
		  // Insert the character at the correct starting position and store where the caret
		  // needs placing after offset adustment.
		  Var newCaretPos As Integer = line.Insert(caretPos - line.Start, char)
		  
		  If allowUndo And Owner.UndoManager <> Nil Then
		    // Create an undoable action for this character insertion.
		    Owner.UndoManager.Push(_
		    New XUICEUndoableInsertText(Owner, Owner.CurrentUndoID, "Insert Text", caretPos, char))
		  End If
		  
		  // Adjust the starting positions and line numbers of every line after the 
		  // modified one by 1 (as we're inserting just a single character)
		  If line.Number < Lines.Count Then AdjustLineOffsets(line.Number + 1, 1, 0)
		  
		  // Has the longest line changed?
		  If line.ColumnLength > longestLineLength Then
		    // Yes it has.
		    mLongestLine = line
		    Owner.LongestLineChanged = True
		  End If
		  
		  // If the line count has changed and the number of numerals in the highest
		  // line number has increased then we will require a full redraw because the 
		  // gutter will need to be redrawn for every line (as it will have changed in width).
		  If Owner.DisplayLineNumbers And _
		    oldLineCount.ToString.CharacterCount <> Lines.Count.ToString.CharacterCount Then
		    Owner.NeedsFullRedraw = True
		  End If
		  
		  // Set the caret position.
		  Owner.CaretPosition = newCaretPos
		  
		  If raiseContentsDidChange Then Owner.ContentsDidChange
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E6420696E73657274732061206E6577206C696E6520617420606C696E654E756D6265726020636F6E7461696E696E672060636F6E74656E7473602C2072657475726E696E6720746865206E6577206C696E652E
		Function InsertLineAt(lineNumber As Integer, contents As String, adjustBy As Integer = 0) As XUICELine
		  /// Creates and inserts a new line at `lineNumber` containing `contents`, returning the new line.
		  ///
		  /// `adjustBy` is an (additional) value to adjust all subsequent line offsets by.
		  /// Raises an `InvalidArgumentException` if `lineNumber` is out of range.
		  
		  mLastChanged = System.Microseconds
		  
		  // Cache the current line count.
		  Var oldLineCount As Integer = LineCount
		  
		  Var line As XUICELine
		  
		  If lineNumber = 1 Then
		    // The first line is a special case.
		    line = New XUICELine(Self, 1, 0, contents)
		  Else
		    // Get the line before this one.
		    Var prevLine As XUICELine
		    Try
		      prevLine = Lines(lineNumber - 2)
		    Catch e As OutOfBoundsException
		      Raise New InvalidArgumentException("`lineNumber` is invalid")
		    End Try
		    // Create the line to insert.
		    line = New XUICELine(Self, lineNumber, prevLine.Finish + 1, contents, False)
		  End If
		  
		  // Insert the line.
		  Lines.AddAt(lineNumber - 1, line)
		  
		  // Adjust the offsets of every line after this newly inserted one.
		  AdjustLineOffsets(lineNumber + 1, Max(1, contents.Length) + adjustBy, 1)
		  
		  // Is the newly inserted line now the longest line?
		  If line.ColumnLength > mLongestLine.ColumnLength Then
		    mLongestLine = line
		    Owner.LongestLineChanged = True
		  End If
		  
		  // If the number of numerals in the highest line number has increased then we 
		  // will require a full redraw because the gutter will need to be redrawn 
		  // for every line (as it will have changed in width).
		  If Owner.DisplayLineNumbers Then
		    // Has adding a new line increased the width of the line number string?
		    // This occurs in scenarios such as `99` --> `100`.
		    If oldlineCount.ToString.Length <> LineCount.ToString.Length Then
		      Owner.NeedsFullRedraw = True
		    End If
		  End If
		  
		  // Tokenise the line.
		  line.Tokenise
		  
		  // Return the newly created line.
		  Return line
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E73657274732060736020696E746F2074686520656469746F7220617420606361726574506F73602E20607360206D617920636F6E7461696E206E65776C696E65732E20557064617465732074686520636172657420706F736974696F6E2E
		Sub InsertText(caretPos As Integer, s As String, allowUndo As Boolean, shouldInvalidate As Boolean, raiseContentsDidChange As Boolean)
		  /// Inserts `s` into the editor at `caretPos`. `s` may contain newlines. Updates the caret position.
		  ///
		  /// If `allowUndo` is True then push this action to the undo manager.
		  /// If `shouldInvalidate` is False then the canvas will not immediately invalidate.
		  /// If `raiseContentsDidChange` is True then we'll raise the editor's `ContentsDidChange` event.
		  ///
		  /// Assumes that `s` is not empty.
		  /// `s` may contain newlines. If present they must have been standardised to `&u0A`.
		  /// Clears any selection present prior to the insertion.
		  ///
		  /// There are three scenarios:
		  ///
		  /// 1. A solitary newline character is being inserted.
		  /// 2. The text to insert does not contain newlines.
		  /// 3. The text to insert contains at least one newline.
		  
		  mLastChanged = System.Microseconds
		  
		  // Clear any pre-existing text selection.
		  If Owner.TextSelected Then Owner.CurrentSelection = Nil
		  
		  // Get the line to begin the insertion at.
		  Var startLine As XUICELine = LineForCaretPos(caretPos)
		  
		  // Some formatters disallow whitespace at the beginning of the line.
		  // We consider space and tab to be whitespace.
		  // Strip any that is present.
		  If Not Formatter.AllowsLeadingWhitespace Then
		    If s.Contains(" ", False) Or s.Contains(&u009, False) Then
		      If s.Contains(&u0A, False) Then
		        Var tmp() As String = s.Split(&u0A)
		        For i As Integer = 0 To tmp.LastIndex
		          tmp(i) = tmp(i).TrimLeft
		        Next i
		        s = String.FromArray(tmp, &u0A)
		      Else
		        s = s.TrimLeft
		      End If
		    End If
		  End If
		  
		  // =======================================================
		  // Case 1: A solitary newline character is being inserted.
		  // =======================================================
		  If s = &u0A Then
		    Owner.CaretPosition = caretPos
		    owner.HandleReturnKey(allowUndo, raiseContentsDidChange)
		    Return
		  End If
		  
		  // =====================================================
		  // Case 2: The text to insert does not contain newlines.
		  // =====================================================
		  If Not s.Contains(&u0A, False) Then
		    If caretPos = startLine.Finish Then
		      // Append the text to this line.
		      startLine.SetContents(startLine.Contents + s)
		      
		      If allowUndo And Owner.UndoManager <> Nil Then
		        If Owner.UndoManager <> Nil Then Owner.UndoManager.Push(_
		        New XUICEUndoableInsertText(Owner, Owner.CurrentUndoID, "Insert Text", caretPos, s))
		      End If
		      
		    ElseIf caretPos = startLine.Start Then
		      // Prepend the text to this line.
		      startLine.SetContents(s + startLine.Contents)
		      
		      If allowUndo And Owner.UndoManager <> Nil Then
		        Owner.UndoManager.Push(_
		        New XUICEUndoableInsertText(Owner, Owner.CurrentUndoID, "Insert Text", caretPos, s))
		      End If
		      
		    Else
		      // Insert this text into the middle of this line.
		      Var left As String = startLine.Left(caretPos - startLine.Start)
		      Var right As String = startLine.Right(startLine.Finish - caretPos)
		      startLine.SetContents(left + s + right)
		      
		      If allowUndo And Owner.UndoManager <> Nil Then
		        Owner.UndoManager.Push(_
		        New XUICEUndoableInsertText(Owner, Owner.CurrentUndoID, "Insert Text", caretPos, s))
		      End If
		    End If
		    
		    AdjustLineOffsets(startLine.Number + 1, s.Length, 0)
		    If startLine.Length > mLongestLine.Length Then UpdateLongestLine
		    Owner.NeedsFullRedraw = True
		    Owner.MoveCaretToPos(Min(caretPos + s.Length, LastLine.Finish), shouldInvalidate)
		    If raiseContentsDidChange Then Owner.ContentsDidChange
		    If shouldInvalidate Then Owner.Refresh
		    Return
		  End If
		  
		  // =========================================================
		  // Case 3: The text to insert contains at least one newline.
		  // =========================================================
		  // We will tokenise lines after all new lines have been inserted.
		  
		  Var linesOfText() As String = s.Split(&u0A)
		  
		  // Cache the contents of the start line so we can undo what's coming.
		  Var originalStartLineContents As String = startLine.Contents
		  
		  // Remove and cache what's after the caret on the start line as they'll be appended to the last line inserted.
		  Var appendToEnd As String = startLine.Right(startLine.Finish - caretPos)
		  
		  // Set the start line's content to the characters before the caret plus the first line of text to insert.
		  Var newStartLineContents As String  = startLine.Left(caretPos - startLine.Start) + linesOfText(0)
		  
		  // Set the start line contents.
		  startLine.SetContents(newStartLineContents, False)
		  
		  If allowUndo And Owner.UndoManager <> Nil Then
		    // Undo the modification of the start line.
		    Var action As New XUICEUndoableReplaceLineContents(Owner, Owner.CurrentUndoID, "Insert Text", _
		    startLine.Number, originalStartLineContents, startLine.Contents, caretPos)
		    Owner.UndoManager.Push(action)
		  End If
		  
		  // The remaining lines of text are just inserted as new lines.
		  Var lineNum As Integer = startLine.Number + 1
		  Var newLine, prevLine As XUICELine
		  Var newLineContents As String
		  Var iMax As Integer = linesOfText.LastIndex
		  For i As Integer = 1 To iMax
		    prevLine = LineAt(lineNum - 1)
		    
		    // Construct the XUICELine to insert.
		    newLineContents = If(i = iMax, linesOfText(i) + appendToEnd, linesOfText(i))
		    newLine = New XUICELine(Self, lineNum, prevLine.Finish + 1, newLineContents, False)
		    Lines.AddAt(lineNum - 1, newLine)
		    
		    If allowUndo And Owner.UndoManager <> Nil Then
		      Owner.UndoManager.Push(_
		      New XUICEUndoableInsertLine(Owner, Owner.CurrentUndoID, "Insert Text", _
		      newLine.Number, newLine.Start - 1, newLine.Contents))
		    End If
		    
		    lineNum = lineNum + 1
		  Next i
		  
		  // Adjust the offsets of the remaining lines. We need to account for any
		  // newlines that would have been entered (hence `linesOfText.Count - 1`).
		  AdjustLineOffsets(lineNum, s.CharacterCount + linesOfText.Count - 1, linesOfText.Count - 1)
		  
		  UpdateLongestLine
		  Owner.NeedsFullRedraw = True
		  Owner.MoveCaretToPos(Min(caretPos + s.Length, LastLine.Finish), shouldInvalidate)
		  TokeniseAllLines
		  If shouldInvalidate Then Owner.Refresh
		  If raiseContentsDidChange Then Owner.ContentsDidChange
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468657265206973206E6F207465787420696E207468652063616E7661732E
		Function IsEmpty() As Boolean
		  /// True if there is no text in the canvas.
		  ///
		  /// There may be no text but there will always be at least on line.
		  
		  Return LineCount = 1 And LastLine.Length = 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6173742028692E652E2068696768657374206E756D626572656429206C696E652E
		Function LastLine() As XUICELine
		  /// The last (i.e. highest numbered) line.
		  
		  Return Lines(Lines.LastIndex)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206C696E6520617420606C696E654E756D62657260206F72204E696C2E
		Function LineAt(lineNumber As Integer) As XUICELine
		  /// Returns the line at `lineNumber` or Nil.
		  
		  If lineNumber < 1 Or (lineNumber - 1) > Lines.LastIndex Then
		    Return Nil
		  Else
		    Return Lines(lineNumber - 1)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206C696E65207468617420776F756C6420636F6E7461696E2074686520302D626173656420606361726574506F73602E
		Function LineForCaretPos(caretPos As Integer) As XUICELine
		  /// Returns the line that would contain the 0-based `caretPos`.
		  ///
		  /// Raises an `InvalidArgumentException` if `caretPos` is out of range.
		  
		  Return LineAt(LineNumberForCaretPos(caretPos))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206C696E65206E756D62657220666F72207468652073706563696669656420636172657420706F736974696F6E2E
		Function LineNumberForCaretPos(pos As Integer) As Integer
		  /// Returns the line number for the specified caret position.
		  ///
		  /// Raises an `InvalidArgumentException` if `pos` is out of range.
		  
		  // Easy if there's only one line.
		  If Lines.Count = 1 Then Return 1
		  
		  If pos > LastLine.Finish + 1 Then
		    Raise New InvalidArgumentException("`pos` is out of range")
		  End If
		  
		  // Binary search.
		  Var low As Integer = 0
		  Var high As Integer = Lines.LastIndex
		  Var mid As Integer
		  Var line As XUICELine
		  While low < high
		    mid = (high + low) / 2
		    line = Lines(mid)
		    If line.Start = pos Then
		      low = mid
		      Exit
		    ElseIf line.Start > pos Then
		      high = mid - 1
		    Else
		      low = mid + 1
		    End If
		  Wend
		  
		  If Lines(low).Start > pos Then Return low
		  Return low + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520636172657420706F736974696F6E206F662074686520656E64206F662074686520776F72642061667465722074686520606361726574506F73602E
		Function NextWordEnd(caretPos As Integer) As Integer
		  /// Returns the caret position of the end of the word after the `caretPos`.
		  ///
		  /// Raises an `InvalidArgumentException` if `caretPos` is out of range for this line.
		  
		  // Sanity checks.
		  If caretPos < 0 Or caretPos > LastLine.Finish Then
		    Raise New InvalidArgumentException("Invalid `caretPos`")
		  End If
		  
		  // Edge case 1: At the end of the document.
		  If caretPos = LastLine.Finish Then Return caretPos
		  
		  // Start on the line containing `caretPos`.
		  Var line As XUICELine = LineForCaretPos(caretPos)
		  
		  // Edge case 2: At the end of a line.
		  If caretPos = line.Finish Then
		    // Default to placing the caret at the end of the document.
		    caretPos = LastLine.Finish
		    
		    // Find the first alphanumeric character starting from the next line.
		    // This is where we will begin searching for a word end from.
		    Var iMax As Integer = Lines.LastIndex
		    For i As Integer = line.Number To iMax
		      If (Lines(i).IsEmpty Or Lines(i).IsOnlyNonAlpha) = False Then
		        caretPos = Lines(i).Start
		        Exit For
		      End If
		    Next i
		    
		    // Get the line at this new caret position.
		    line = LineForCaretPos(caretPos)
		    Return line.NextWordEnd(caretPos)
		  End If
		  
		  // Find the word end on this line.
		  Return line.NextWordEnd(caretPos)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520636172657420706F73206F6620746865207374617274206F662074686520776F7264206265666F72652074686520606361726574506F73602E
		Function PreviousWordStart(caretPos As Integer) As Integer
		  /// Returns the caret pos of the start of the word before the `caretPos`.
		  ///
		  /// Raises an `InvalidArgumentException` if `caretPos` is out of range for this line.
		  
		  // Sanity checks.
		  If caretPos < 0 Or caretPos > LastLine.Finish Then
		    Raise New InvalidArgumentException("Invalid `caretPos`")
		  End If
		  
		  // Edge case 1: At the start of the document.
		  If caretPos = 0 Then Return caretPos
		  
		  // Start on the line containing `caretPos`.
		  Var line As XUICELine = LineForCaretPos(caretPos)
		  
		  // Edge case 2: At the start of a line (but not the first one).
		  If caretPos = line.Start Then
		    // Default to placing the caret at the start of the document.
		    caretPos = 0
		    
		    // Find the last alphanumeric character starting from the *previous* line.
		    // This is where we will begin searching for a word start from.
		    For i As Integer = line.Number - 2 DownTo 0
		      If (Lines(i).IsEmpty Or Lines(i).IsOnlyNonAlpha) = False Then
		        caretPos = Lines(i).Finish
		        Exit
		      End If
		    Next i
		    
		    // Get the line at this new caret position.
		    line = LineForCaretPos(caretPos)
		    Return line.PreviousWordStart(caretPos)
		  End If
		  
		  // Find the word start on this line.
		  Return line.PreviousWordStart(caretPos)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265706C616365732074686520746578742073656C656374696F6E20696E20746865206F776E696E672063616E76617320776974682060736020616E6420757064617465732074686520636172657420706F736974696F6E2E
		Sub ReplaceSelection(s As String, allowUndo As Boolean, shouldInvalidate As Boolean, raiseContentsDidChange As Boolean = True)
		  /// Replaces the text selection in the owning canvas with `s` and updates the caret position.
		  ///
		  /// If `allowUndo` is True then this replacement will be undoable.
		  /// If `shouldInvalidate` is False then the canvas will not be immediately invalidated.
		  /// If `raiseContentsDidChange` is True then we raise the editor's `ContentsDidChange` event.
		  ///
		  /// Assumes that if `s` contains newlines that they have been 
		  /// standardised to UNIX (`&u0A`).
		  
		  // Quick exit if there is no text selected in the canvas presently.
		  If Not Owner.TextSelected Then Return
		  
		  // Is this just a deletion?
		  If s = "" Then
		    DeleteSelection(allowUndo, shouldInvalidate, raiseContentsDidChange)
		    Return
		  End If
		  
		  // Cache where the selection begins as we will purge it momentarily.
		  Var selStart As Integer = Owner.CurrentSelection.StartLocation
		  
		  // Cache the line number that the selection begins on as this is the line we will insert into.
		  Var targetLineNum As Integer = LineForCaretPos(Owner.CurrentSelection.StartLocation).Number
		  
		  // Delete the contents of the selection and don't redraw or raise the `ContentsDidChange` event.
		  DeleteSelection(allowUndo, False, False)
		  
		  // Edge case: Detect if the deletion removed the line we need to replace into.
		  // This happens if the selection ran up to the beginning of a line when deleted.
		  If LineNumberForCaretPos(selStart) <> targetLineNum Then
		    // Insert an empty line beginning at selStart that we can then replace text into it.
		    If allowUndo And Owner.UndoManager <> Nil Then
		      Owner.UndoManager.Push(_
		      New XUICEUndoableInsertLine(Owner, Owner.CurrentUndoID, "Insert Newline", _
		      targetLineNum, selStart, ""))
		    End If
		    Call InsertLineAt(targetLineNum, "", 0)
		  End If
		  
		  // Now insert the text where the selection began.
		  Owner.Insert(s, selStart, allowUndo, shouldInvalidate)
		  
		  // HACK: Prior to the replacement, if we deleted contiguous lines then we may 
		  // need to insert a line break at the current caret position. We can do this by 
		  // simulating the user pressing the Return key.
		  If mDidDeleteContiguousLines And (owner.CaretPosition <> LastLine.Finish And s <> &u0A) Then
		    Owner.HandleReturnKey(allowUndo, False)
		    Owner.MoveCaretToPos(owner.CaretPosition - 1)
		  End If
		  
		  If raiseContentsDidChange Then Owner.ContentsDidChange
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52652D746F6B656E69736573206576657279206C696E652E
		Sub TokeniseAllLines()
		  /// Re-tokenises every line.
		  
		  If Owner = Nil Or Owner.Formatter = Nil Then Return
		  
		  Owner.Formatter.TokeniseAll(Lines)
		  
		  Owner.NeedsFullRedraw = True
		  
		  // Tell the editor that we've just tokenised.
		  owner.JustTokenised = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320746865206361636865206F6620746865206C6F6E67657374206C696E652E
		Private Sub UpdateLongestLine()
		  /// Updates the cache of the longest line.
		  
		  mLongestLine = Lines(0)
		  For Each line As XUICELine In Lines
		    If line.ColumnLength > mLongestLine.ColumnLength Then
		      mLongestLine = line
		    End If
		  Next line
		  
		  // Tell the canvas that the longest line has changed - may require a full redraw.
		  Owner.LongestLineChanged = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5570646174657320746865206E6561726573742064656C696D697465727320746F207468652073706563696669656420606361726574506F73602E
		Sub UpdateNearestDelimiters(caretPos As Integer)
		  /// Updates the nearest delimiters to the specified `caretPos`.
		  
		  // If the caret hasn't move since we last called this method then there's nothing to do.
		  If caretPos = mCaretPosCache Then
		    Return
		  Else
		    mCaretPosCache = caretPos
		  End If
		  
		  // Cache the previously computed value.
		  Var previous As XUICEDelimiter = mNearestDelimiters
		  
		  If Formatter = Nil Then Return
		  
		  // Get the nearest delimiters to the caret position.
		  mNearestDelimiters = Formatter.NearestDelimitersForCaretPos(caretPos)
		  
		  // If nothing has changed then we can bail early.
		  If previous <> Nil And previous.EquivalentTo(mNearestDelimiters) Then Return
		  
		  // Mark the previous delimiter lines as being dirty.
		  If previous <> Nil Then
		    Var prevLineOpener As XUICELine = LineAt(previous.Opener.LineNumber)
		    If prevLineOpener <> Nil Then prevLineOpener.IsDirty = True
		    Var prevLineCloser As XUICELine= LineAt(previous.Closer.LineNumber)
		    If prevLineCloser <> Nil Then prevLineCloser.IsDirty = True
		  End If
		  
		  // Mark the new delimiter lines as dirty.
		  If mNearestDelimiters <> Nil Then
		    Var lineOpener As XUICELine = LineAt(mNearestDelimiters.Opener.LineNumber)
		    If lineOpener <> Nil Then lineOpener.IsDirty = True
		    Var lineCloser As XUICELine = LineAt(mNearestDelimiters.Closer.LineNumber)
		    If lineCloser <> Nil Then lineCloser.IsDirty = True
		  End If
		  
		  Owner.Refresh
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Every `XUICodeEditor` has a _Line Manager_ that is represented by an instance of this class.
		
		It is the responsibility of the line manager to handle the manipulation of lines of code 
		within an editor.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 54686520666F726D6174746572207573656420746F20666F726D6174207465787420696E2074686520656469746F722E
		#tag Getter
			Get
			  Return Owner.Formatter
			End Get
		#tag EndGetter
		Formatter As XUICEFormatter
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652074696D65207374616D702028696E206D6963726F7365636F6E647329207468617420746865206C617374206368616E676520746F6F6B20706C6163652E
		#tag Getter
			Get
			  Return mLastChanged
			End Get
		#tag EndGetter
		LastChanged As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206C696E657320696E2074686520656469746F722E
		#tag Getter
			Get
			  Return Lines.Count
			  
			End Get
		#tag EndGetter
		LineCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865206C696E6573206F662074657874206D616E6167656420627920746865206C696E65206D616E616765722E
		Lines() As XUICELine
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E74206C6F6E67657374206C696E652E
		#tag Getter
			Get
			  Return mLongestLine
			  
			End Get
		#tag EndGetter
		LongestLine As XUICELine
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 4361636865642076616C7565206F662074686520606361726574506F736020617267756D656E742070617373656420746F20605570646174654E65617265737444656C696D6974657273602E
		Private mCaretPosCache As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206C696E65206D616E61676572206A7573742064656C6574656420636F6E746967756F7573206C696E65732E
		Private mDidDeleteContiguousLines As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520604C6173744368616E6765646020636F6D70757465642070726F70657274792E
		Private mLastChanged As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520604C6F6E676573744C696E65602070726F70657274792E
		Private mLongestLine As XUICELine
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53746F72657320746865206C61737420636F6D7075746564206D61746368696E672064656C696D69746572732E205573656420696E7465726E616C6C792077697468696E20605570646174654E65617265737444656C696D69746572732829602E204D6179206265204E696C2E
		Private mNearestDelimiters As XUICEDelimiter
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F207468652060585549436F6465456469746F72602074686174206F776E732074686973206C696E65206D616E616765722E
		Private mOwnerRef As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 53746F72657320746865206C61737420636F6D7075746564206D61746368696E672064656C696D697465727320746F207468652063617265742E204D6179206265204E696C2E
		#tag Getter
			Get
			  Return mNearestDelimiters
			End Get
		#tag EndGetter
		NearestDelimiters As XUICEDelimiter
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652060585549436F6465456469746F72602074686174206F776E732074686973206C696E65206D616E616765722E
		#tag Getter
			Get
			  If mOwnerRef.Value <> Nil Then
			    Return XUICodeEditor(mOwnerRef.Value)
			  Else
			    // This should never happen as a line manager must always be owned.
			    Return Nil
			  End If
			  
			End Get
		#tag EndGetter
		Owner As XUICodeEditor
	#tag EndComputedProperty


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
			Name="LineCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastChanged"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
