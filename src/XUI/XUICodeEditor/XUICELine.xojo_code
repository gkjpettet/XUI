#tag Class
Protected Class XUICELine
Inherits XUITextLine
	#tag Method, Flags = &h0, Description = 52657475726E732060636F756E746020636861726163746572732066726F6D2074686973206C696E65207374617274696E6720617420607374617274506F73602E
		Function CharactersFromCaretPos(startPos As Integer, count As Integer) As String
		  /// Returns `count` characters from this line starting at `startPos`.
		  
		  #Pragma BreakOnExceptions False
		  
		  // Convert the passed caret position to a column.
		  Var col As Integer = startPos - Self.Start
		  
		  If col < 0 Or col > Self.Finish Then
		    Raise New InvalidArgumentException("Invalid `startPos`")
		  End If
		  
		  Return mContents.MiddleCharacters(col, count)
		  
		  Exception OutOfBoundsException // HACK: Need to pin down why this occurs sometimes.
		    Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732060636F756E746020636861726163746572732066726F6D2074686973206C696E65207374617274696E672061742074686520302D626173656420607374617274436F6C602E
		Function CharactersFromColumn(startCol As Integer, count As Integer) As String
		  /// Returns `count` characters from this line starting at the 0-based `startCol`.
		  
		  #Pragma BreakOnExceptions False
		  
		  Return mContents.MiddleCharacters(startCol, count)
		  
		  Exception e As OutOfBoundsException
		    // HACK: For reasons that are presently unclear, occasionally the passed arguments are
		    // out of bounds. As a workaround we will just return an empty string.
		    Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206368617261637465727320656E636C6F7365642062792074686520706173736564206073656C656374696F6E602E
		Function CharactersInSelection(selection As XUICETextSelection) As String
		  /// Returns the characters enclosed by the passed `selection`.
		  
		  Var portion As XUICESelectedColumns = selection.SelectedColumnsInLine(Self)
		  
		  If portion = Nil Then
		    Return ""
		  ElseIf portion.SelectionEndsAfterLine Then
		    Return CharactersFromColumn(portion.Start, Self.Length - portion.Start)
		  Else
		    Return CharactersFromColumn(portion.Start, portion.Finish - portion.Start)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206368617261637465727320757020746F20627574206E6F7420696E636C7564696E672060636F6C756D6E602E
		Function CharactersToColumn(column As Integer) As String
		  /// Returns the characters up to but not including `column`.
		  
		  If column = 0 Then Return ""
		  
		  Var s() As String
		  
		  For i As Integer = 0 To column - 1
		    s.Add(Characters(i))
		  Next i
		  
		  Return String.FromArray(s, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43686F7073202872656D6F766573292060636F756E746020636861726163746572732066726F6D2074686520656E64206F6620746865206C696E6520616E642072657475726E73207468656D2E
		Function ChopCharacters(count As Integer) As String
		  /// Chops (removes) `count` characters from the end of the line and returns them.
		  
		  If count = 0 Then Return ""
		  
		  Var chopped As String = mContents.RightCharacters(count)
		  SetContents(mContents.LeftCharacters(Length - count))
		  Return chopped
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43686F7073202872656D6F766573292074686520636861726163746572732066726F6D2060636F6C756D6E6020746F2074686520656E64206F6620746865206C696E6520616E642072657475726E73207468656D2E
		Function ChopCharactersFrom(column As Integer, shouldTokenise As Boolean = True) As String
		  /// Chops (removes) the characters from `column` to the end of the line and returns them.
		  
		  Var chopped As String = mContents.MiddleCharacters(column)
		  SetContents(mContents.LeftCharacters(column), shouldTokenise)
		  Return chopped
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520636F6C756D6E20617420706978656C20706F736974696F6E206078602077686572652060306020697320746865206C696E652073746172742E2052657475726E7320602D3160206966206F7574206F662072616E67652E
		Function ColumnAtX(x As Integer, g As Graphics) As Integer
		  /// Returns the column at pixel position `x` where `0` is the line start.
		  /// Returns `-1` if out of range.
		  ///
		  /// `x` is relative to this line's `TextStartX` property.
		  /// `g` is the graphics context used to measure text width.
		  
		  // The fudge factor accounts for the width of the caret
		  Const FUDGE = 2
		  
		  If g = Nil Then Return -1
		  If x < 0 Then Return -1
		  
		  Var contentsW As Double = g.TextWidth(mContents)
		  If x > contentsW Then Return -1
		  
		  // Now we need to test each character's width. 
		  Var s As String
		  For i As Integer = 0 To Characters.LastIndex
		    s = s + Characters(i)
		    If x <= g.TextWidth(s) - FUDGE Then Return i
		  Next i
		  
		  Return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(owner As XUICELineManager, lineNumber As Integer, startPos As Integer, lineContents As String, shouldTokenise As Boolean = True)
		  /// Default constructor.
		  ///
		  /// - `owner` is the `XUILineManager` that manages this line. Will be kept as a `WeakRef`.
		  /// - `lineNumber` is this line's 1-based line number.
		  /// - `startPos` is the 0-based position in the source code that this line begins at.
		  /// - `lineContents` is the contents of this line.
		  /// - `shouldTokenise` determines if this line should be tokenised by the 
		  ///   line manager's code editor's active formatter upon instantiation. Default is `True`.
		  
		  mOwnerRef = New WeakRef(owner)
		  Self.Number = lineNumber
		  Self.Start = startPos
		  SetContents(lineContents, shouldTokenise)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C65746573207468652063686172616374657220617420606361726574506F73602066726F6D2074686973206C696E652E
		Sub DeleteCharacterAtCaretPos(caretPos As Integer, shouldTokenise As Boolean = True)
		  /// Deletes the character at `caretPos` from this line.
		  ///
		  /// Raises an `InvalidArgumentException` if `caretPos` is out of range.
		  
		  // Sanity check.
		  If caretPos < 0 Then
		    Raise New InvalidArgumentException("`caretPos` cannot be < 0")
		  End If
		  
		  // If this line is empty then there's nothing to do.
		  If Length = 0 Then Return
		  
		  // Convert the passed caret position to the character's line column.
		  Var column As Integer = caretPos - Self.Start
		  
		  If column < 0 Or column > Characters.LastIndex Then
		    Raise New InvalidArgumentException("Invalid `caretPos`")
		  End If
		  
		  Characters.RemoveAt(column)
		  SetContents(String.FromArray(Characters, ""), shouldTokenise)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C657465732060636F756E746020636861726163746572732066726F6D2074686973206C696E6520626567696E6E696E6720617420606361726574506F73602E
		Sub DeleteCharactersFromCaretPos(caretPos As Integer, count As Integer, shouldTokenise As Boolean = True)
		  /// Deletes `count` characters from this line beginning at `caretPos`.
		  
		  // Sanity check.
		  If caretPos < Start Or caretPos + count > Finish Then
		    Raise New InvalidArgumentException("Invalid range to delete")
		  End If
		  
		  // Delete the characters.
		  Var startCol As Integer = caretPos - Start
		  Var iMax As Integer = startCol + count - 1
		  For i As Integer = startCol To iMax
		    Characters.RemoveAt(startCol)
		  Next i
		  
		  // Update the contents to trigger tokenisation, etc.
		  SetContents(String.FromArray(Characters, ""), shouldTokenise)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656C657465732060636F756E746020636861726163746572732066726F6D2074686520656E64206F6620746865206C696E652E
		Sub DeleteCharactersFromEnd(count As Integer, shouldTokenise As Boolean = True)
		  /// Deletes `count` characters from the end of the line.
		  
		  If count > 0 And count <= Length Then
		    SetContents(mContents.LeftCharacters(Length - count), shouldTokenise)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177732074686973206C696E6520746F206067602E
		Sub Draw(g As Graphics, topLeftX As Double, topLeftY As Double, lineH As Double, gutterWidth As Double, containsCaret As Boolean, maxLineNumWidth As Double)
		  /// Draws this line to `g`.
		  ///
		  /// - `topLeftX` is the X coord of the top left corner of the line.
		  /// - `topLeftY` is the Y coord of the top left corner of the line.
		  /// - `lineH` is the height of the line.
		  /// - `gutterWidth` is the width of the gutter.
		  /// - `maxLineNumWidth` is the width of the bounding rectangle around the longest 
		  ///   line number in the gutter.
		  ///
		  /// A line includes the gutter, any spacing for indentation and the line 
		  /// contents itself.
		  ///
		  /// Anti-aliasing needs to be disabled whenever we draw on Windows _except_ for 
		  /// text (which looks rubbish if anti-aliasing is off).
		  ///
		  /// Assumes that the graphics context has anti-aliasing off in Windows builds.
		  
		  #Pragma Unused containsCaret
		  #Pragma Unused maxLineNumWidth
		  
		  // Grab a reference to this line's canvas.
		  Var editor As XUICodeEditor = LineManager.Owner
		  
		  // Cache the top left Y coordinate.
		  mTopLeftY = topLeftY
		  
		  // Compute the x, y coords of the start of the text.
		  mTextStartX = topLeftX + gutterWidth + editor.LINE_CONTENTS_LEFT_PADDING + _
		  WidthToColumn(0, g)
		  mTextStartY = topLeftY + (g.FontAscent + (lineH - g.TextHeight)/2)
		  
		  // ===================================
		  // BACKGROUND
		  // ===================================
		  If editor.HighlightCurrentLine And Self.Number = editor.CurrentLine.Number Then
		    // Fill this line's background with the appropriate colour.
		    g.DrawingColor = editor.CurrentLineHighlightColor
		  Else
		    // This line's background will be filled with the editor's background colour.
		    g.DrawingColor = editor.BackgroundColor
		  End If
		  g.FillRectangle(topLeftX, topLeftY, g.Width, lineH)
		  
		  // ===================================
		  // DEBUGGING LINE
		  // ===================================
		  If editor.DebuggingLine = Self.Number Then
		    // Fill the background behind the text of this line with a rounded rectangle.
		    DrawDebugHighlight(g, topLeftX, topLeftY, lineH, gutterWidth)
		  End If
		  
		  // ===================================
		  // LINE NUMBER
		  // ===================================
		  If editor.DisplayLineNumbers Then
		    DrawLineNumber(g, topLeftY, gutterWidth, lineH)
		  End If
		  
		  // ===================================
		  // TEXT SELECTION
		  // ===================================
		  Var selectedColumns As XUICESelectedColumns
		  If editor.CurrentSelection <> Nil Then
		    selectedColumns = editor.CurrentSelection.SelectedColumnsInLine(Self)
		    DrawSelection(selectedColumns, g, topLeftX, topLeftY, lineH, gutterWidth)
		  End If
		  
		  // ===================================
		  // DELIMITER HIGHLIGHTING
		  // ===================================
		  // If enabled and the user isn't currently typing and there's nothing selected, highlight 
		  // the delimiters nearest to the caret.
		  If editor.HighlightDelimitersAroundCaret And Not editor.Typing And Not editor.TextSelected Then
		    Var delimiters As XUICEDelimiter = LineManager.NearestDelimiters
		    If delimiters <> Nil Then
		      // There may be up to two delimiters on this line (an opener and a closer).
		      If delimiters.Opener.StartAbsolute >= Self.Start And delimiters.Opener.StartAbsolute <= Self.Finish Then
		        HighlightDelimiter(delimiters.Opener, g, topLeftX, topLeftY, lineH, gutterWidth)
		      End If
		      If delimiters.Closer.StartAbsolute >= Self.Start And delimiters.Closer.StartAbsolute <= Self.Finish Then
		        HighlightDelimiter(delimiters.closer, g, topLeftX, topLeftY, lineH, gutterWidth)
		      End If
		    End If
		  End If
		  
		  // ===================================
		  // BLOCK LINES
		  // ===================================
		  If editor.DrawBlockLines Then
		    DrawBlockLines(g, topLeftX + gutterWidth + editor.LINE_CONTENTS_LEFT_PADDING, topLeftY, lineH)
		  End If
		  
		  // ===================================
		  // LINE TEXT
		  // ===================================
		  // Reset the caret data (only required if the editor is actually
		  // using the block caret type but it's quicker to just clear it).
		  editor.CaretData.Character = ""
		  
		  // Draw the line's tokens.
		  Var style As XUICETokenStyle
		  Var tokenStartX As Double
		  
		  For i As Integer = 0 To Tokens.LastIndex
		    Var t As XUICELineToken = Tokens(i)
		    
		    // Get the text to draw.
		    Var s As String = CharactersFromColumn(t.StartLocal, t.Length)
		    
		    // Get this token's style
		    style = editor.Theme.StyleForToken(t)
		    
		    // Compute the X coordinate for the start of this token.
		    Var charsUpToTokenStart As String = CharactersToColumn(t.StartLocal)
		    tokenStartX = mTextStartX + (g.TextWidth(charsUpToTokenStart))
		    
		    // Draw the token's background (if it has one).
		    If style.HasBackgroundColour Then
		      g.DrawingColor = style.BackgroundColour
		      g.FillRectangle(tokenStartX, topLeftY, g.TextWidth(s)+1, lineH) //+1 is a fudge factor.
		      
		      If selectedColumns <> Nil Then
		        // At least part of this line is selected. Is any of this token selected?
		        // Determine which (if any) columns of this token are in the current selection.
		        Var overlap As Pair = TokenSelectionOverlap(t, selectedColumns)
		        If overlap <> Nil Then
		          // Redraw the selection colour over the selected columns in this token.
		          g.DrawingColor = editor.Theme.SelectionColor
		          
		          Var charsBeforeSelection As String = CharactersToColumn(overlap.Left)
		          Var tokSelStartX As Double = tokenStartX + (g.TextWidth(charsBeforeSelection))
		          
		          Var selectedChars As String = _
		          CharactersInSelection(New XUICETextSelection(overlap.Left, overlap.Left, overlap.Right, editor))
		          g.FillRectangle(tokSelStartX, topLeftY, g.TextWidth(selectedChars), lineH)
		        End If
		      End If
		    End If
		    
		    // Set the graphics object to the appropriate token style.
		    editor.SetGraphicsStyle(g, style)
		    
		    // Draw the token's text.
		    DrawText(g, s, tokenStartX, mTextStartY)
		    
		    // Compute the required data for a block type caret if required.
		    If editor.CaretType = XUICodeEditor.CaretTypes.Block And Self.Number = editor.CaretLineNumber Then
		      If editor.CaretColumn >= t.StartLocal And editor.CaretColumn <= t.EndLocal Then
		        editor.CaretData.Style = style
		        editor.CaretData.Character = CharactersFromColumn(editor.CaretColumn, 1)
		      End If
		    End If
		    
		    If i = Tokens.LastIndex Then
		      // As this is the last token, we can compute the X coordinate where this line's contents ends.
		      mTextEndX = tokenStartX + g.TextWidth(s)
		    End If
		  Next i
		  
		  // ===============
		  // AUTOCOMPLETION
		  // ===============
		  If Not IsEmpty And editor.CaretLineNumber = Self.Number And editor.CaretPosition = Self.Finish And _
		    Not editor.Formatter.TokenIsComment(LastToken) Then
		    // The caret is at the end of this non-empty, non-comment line. 
		    // Are there any available autocomplete options?
		    If editor.AutocompleteOptionsAvailable Then
		      // Set the graphics object to the autocomplete style.
		      editor.SetGraphicsStyle(g, editor.Theme.AutocompletePrefixStyle)
		      // Compute the X start coordinate for the suggestion.
		      Var optionX As Double = mTextStartX + (g.TextWidth(mContents))
		      If editor.AutoCompleteData.Options.Count = 1 Then
		        // Just one possible completion. Draw it as a placeholder.
		        DrawText(g, editor.AutoCompleteData.LongestCommonPrefix, optionX, mTextStartY)
		      Else
		        // Multiple suggestions available. 
		        // We will draw the longest common prefix (less the prefix triggering the autocomplete) 
		        // followed by an ellipsis.
		        DrawText(g, editor.AutoCompleteData.LongestCommonPrefix + ELLIPSIS, optionX, mTextStartY)
		      End If
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44726177732074686973206C696E65277320626C6F636B206C696E65732E
		Private Sub DrawBlockLines(g As Graphics, topLeftX As Double, topLeftY As Double, lineH As Double)
		  /// Draws this line's block lines.
		  ///
		  /// Block lines are a visual representation of the connections between blocks. 
		  /// We can quickly achieve this by drawing a vertical line at each indentation level.
		  
		  Const UNMATCHED_LINE_X_OFFSET = -10
		  
		  // What colour shall the line be?
		  If Unmatched Then
		    g.DrawingColor = LineManager.Owner.Theme.UnmatchedBlockLineColor
		  Else
		    g.DrawingColor = LineManager.Owner.Theme.BlockLineColor
		  End If
		  
		  // Compute the width of a character.
		  Var charWidth As Double = g.TextWidth("_")
		  
		  For level As Integer = 0 To IndentLevel
		    // Compute the start of this indent.
		    // We disregard the additional indentation that a line will have if it's a continuation.
		    Var x As Double = topLeftX + (level * charWidth * COLUMNS_PER_INDENT)
		    
		    // We don't draw the block line if we're on this line's indent level as it's ugly *unless* this line 
		    // is unmatched in which case we'll draw a line just to the left of the text.
		    If level = Self.IndentLevel Then
		      If Unmatched Then
		        x = x + UNMATCHED_LINE_X_OFFSET
		      Else
		        Return
		      End If
		    End If
		    
		    // Draw a simple vertical line.
		    g.DrawLine(x, topLeftY, x, topLeftY + lineH)
		  Next level
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4472617773206120726F756E64656420726563742061726F756E64207468652074657874206F6E2074686973206C696E652E205573656420746F20686967686C696768742061206C696E652074686174206973206265696E672064656275676765642E
		Private Sub DrawDebugHighlight(g As Graphics, topLeftX As Double, topLeftY As Double, lineH As Double, gutterWidth As Double)
		  /// Draws a rounded rect around the text on this line.
		  /// Used to highlight a line that is being debugged.
		  
		  Const HPADDING = 2
		  
		  Var editor As XUICodeEditor = LineManager.Owner
		  
		  If Self.IsEmpty Then Return
		  
		  g.DrawingColor = editor.DebugLineColour
		  
		  // Compute the X pos of the first character
		  Var selStartX As Double
		  selStartX = topLeftX + gutterWidth + editor.LINE_CONTENTS_LEFT_PADDING + _
		  WidthToColumn(0, g, False) - HPADDING
		  
		  g.FillRoundRectangle(selStartX, topLeftY, g.TextWidth(Self.Contents) + (2 * HPADDING), lineH, 3, 3)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4472617773206120746865206C696E65206E756D62657220746F207468652067757474657220696E206067602E
		Private Sub DrawLineNumber(g As Graphics, topLeftY As Double, gutterWidth As Double, lineH As Double)
		  /// Draws a the line number to the gutter in `g`.
		  ///
		  /// `gutterWidth` is the width of the this line's canvas' gutter.
		  /// `topLeftY` is the top left corner of the line.
		  /// `lineH` is the height of the line.
		  
		  #If TargetWindows
		    // Since we're drawing text, we need to temporarily enable anti-aliasing on 
		    // Windows since we've disabled it elsewhere.
		    g.AntiAliased = True
		  #EndIf
		  
		  Var editor As XUICodeEditor = LineManager.Owner
		  
		  // Set the graphics object to the correct line number font size.
		  g.FontSize = editor.LineNumberFontSize
		  Var y As Double = topLeftY + (g.FontAscent + (lineH - g.TextHeight)/2)
		  
		  // We use a text shape because it's easier to right align.
		  Var lnShape As New TextShape
		  lnShape.FontName = editor.FontName
		  lnShape.FontSize = editor.LineNumberFontSize
		  lnShape.HorizontalAlignment = TextShape.Alignment.Right
		  lnShape.X = gutterWidth - editor.BLOCK_GUTTER_MIN_WIDTH
		  lnShape.Y = y
		  lnShape.Value = Self.Number.ToString
		  
		  // Determine the correct colour to use for the line number.
		  If editor.CaretLineNumber = Self.Number Then
		    lnShape.FillColor = editor.CurrentLineNumberColor
		  Else
		    lnShape.FillColor = editor.LineNumberColor
		  End If
		  
		  g.DrawObject(lnShape)
		  
		  #If TargetWindows
		    // Disable anti-aliasing for subsequent drawing.
		    g.AntiAliased = False
		  #EndIf
		  
		  // Restore the font size.
		  g.FontSize = editor.FontSize
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4472617773207468652073656C656374656420636F6C756D6E732077697468696E2074686973206C696E652E
		Private Sub DrawSelection(selectedColumns As XUICESelectedColumns, g As Graphics, topLeftX As Double, topLeftY As Double, lineH As Double, gutterWidth As Double)
		  /// Draws the selected columns within this line.
		  
		  Var editor As XUICodeEditor = LineManager.Owner
		  
		  If selectedColumns = Nil Then Return
		  
		  g.DrawingColor = editor.SelectionColour
		  
		  // Compute the X pos of where the selection starts on this line.
		  Var selStartX As Double
		  If selectedColumns.SelectionBeginsBeforeLine Then
		    selStartX = topLeftX + gutterWidth + editor.LINE_CONTENTS_LEFT_PADDING
		  Else
		    selStartX = topLeftX + gutterWidth + editor.LINE_CONTENTS_LEFT_PADDING + _
		    WidthToColumn(selectedColumns.Start, g, False)
		  End If
		  
		  If selectedColumns.Finish = -1 Then
		    // The selection extends beyond this line. Draw a rectangle to the end of the line.
		    g.FillRectangle(selStartX, topLeftY, g.Width, lineH)
		    
		  Else
		    // The selection ends within this line.
		    // Compute the width of the selected characters.
		    Var selectedChars As String = _
		    mContents.MiddleCharacters(selectedColumns.Start, _
		    selectedColumns.Finish - selectedColumns.Start)
		    
		    If selectedColumns.SelectionBeginsBeforeLine Then
		      // Need to account for any indentation/ continuation space at the start of the line.
		      g.FillRectangle(selStartX, topLeftY, g.TextWidth(selectedChars) + IndentWidth(g.TextWidth("_")), lineH)
		    Else
		      g.FillRectangle(selStartX, topLeftY, g.TextWidth(selectedChars), lineH)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 447261777320616E20616E74692D616C696173656420737472696E67206073602061742074686520737065636966696564206C6F636174696F6E20696E206067602E
		Private Sub DrawText(g As Graphics, s As String, x As Double, y As Double, wrapWidth As Double = 0, condense As Boolean = False)
		  /// Draws an anti-aliased string `s` at the specified location in `g`.
		  ///
		  /// - `s` is the string to draw.
		  /// - `x` is the x coordinate.
		  /// - `y` is the y coordinate of the text baseline.
		  /// - `wrapWidth` is the width the text will wrap at.
		  /// - If `condense` is True then the string may be truncated with an ellipsis.
		  ///
		  /// This is essentially a wrapper to the `Graphics.DrawText` method. 
		  /// It exists because we need to disable anti-aliasing in the graphics contexts 
		  /// on Windows but it needs to be re-enabled when drawing text. Rather than 
		  /// litter the code base with calls to toggle the anti-aliasing state, this method 
		  /// does it for us.
		  
		  #If TargetWindows
		    g.AntiAliased = True
		    g.DrawText(s, x, y, wrapWidth, condense)
		    g.AntiAliased = False
		  #Else
		    g.DrawText(s, x, y, wrapWidth, condense)
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520666972737420746F6B656E206F662074686973206C696E65206F72204E696C20696620746865726520617265206E6F20746F6B656E732E
		Function FirstToken() As XUICELineToken
		  /// Returns the first token of this line or Nil if there are no tokens.
		  
		  If Tokens.Count = 0 Then
		    Return Nil
		  Else
		    Return Tokens(0)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 486967686C69676874732074686520706173736564206064656C696D6974657260206F6E2074686973206C696E652E
		Private Sub HighlightDelimiter(delimiter As XUICELineToken, g As Graphics, topLeftX As Double, topLeftY As Double, lineH As Double, gutterWidth As Double)
		  /// Highlights the passed `delimiter` on this line.
		  
		  Var editor As XUICodeEditor = LineManager.Owner
		  
		  // Compute the X pos of where the delimiter starts on this line.
		  Var startX As Double = topLeftX + gutterWidth + editor.LINE_CONTENTS_LEFT_PADDING + _
		  WidthToColumn(delimiter.StartAbsolute - Self.Start, g)
		  
		  // Get the delimiter string.
		  Var delimiterString As String = mContents.Middle(delimiter.StartLocal, delimiter.Length)
		  
		  // Compute the graphical width of the delimiter string.
		  Var delimiterWidth As Double = g.TextWidth(delimiterString)
		  
		  // Draw the fill colour.
		  If editor.Theme.DelimitersHaveFillColor Then
		    g.DrawingColor = editor.Theme.DelimitersFillColor
		    g.FillRectangle(startX, topLeftY, delimiterWidth, lineH)
		  End If
		  
		  // Draw the border.
		  If editor.Theme.DelimitersHaveBorder Then
		    g.DrawingColor = editor.Theme.DelimitersBorderColor
		    g.DrawRectangle(startX, topLeftY, delimiterWidth, lineH)
		  End If
		  
		  // Draw the underline.
		  If editor.Theme.DelimitersHaveUnderline Then
		    g.DrawingColor = editor.Theme.DelimitersUnderlineColor
		    Var penSizeCache As Double = g.PenSize
		    g.PenSize = 1
		    // -2 is a fudge factor otherwise the line isn't visible.
		    g.DrawLine(startX, topLeftY + lineH - 2, startX + delimiterWidth, topLeftY + lineH - 2)
		    g.PenSize = penSizeCache
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207769647468206F662074686520696E64656E746174696F6E206174207468652066726F6E74206F662074686973206C696E652E
		Function IndentWidth(charWidth As Double) As Double
		  /// Returns the width of the indentation at the front of this line.
		  ///
		  /// `charWidth` is the current width of a character in the editor.
		  
		  Return (IndentLevel * charWidth * COLUMNS_PER_INDENT) + If(IsContinuation, charWidth * COLUMNS_PER_INDENT, 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E73657274732060736020696E746F2074686973206C696E652061742060636F6C756D6E602E2052657475726E732074686520636172657420706F736974696F6E20666F6C6C6F77696E672074686520696E73657274696F6E2E
		Function Insert(column As Integer, s As String) As Integer
		  /// Inserts `s` into this line at `column`.
		  /// Returns the caret position following the insertion.
		  ///
		  /// Raises an `InvalidArgumentException` if `column` is out of range.
		  /// Assumes that `s` is not empty and does not contain newlines.
		  
		  // Sanity checks.
		  If column < 0 Then 
		    Raise New InvalidArgumentException("Invalid text insertion position")
		  End If
		  If column > Finish + 1 Then
		    Raise New InvalidArgumentException("Invalid text insertion position")
		  End If
		  
		  Var newCaretPos As Integer
		  
		  If column = 0 Then
		    // Prepend the passed string.
		    SetContents(s + Contents)
		    newCaretPos = Start + s.Length
		  ElseIf column >= Finish Then
		    // Append the passed string
		    SetContents(Contents + s)
		    newCaretPos = Finish
		  Else
		    Var left As String = Contents.LeftCharacters(column)
		    Var right As String = Contents.MiddleCharacters(column)
		    SetContents(left + s + right)
		    newCaretPos = Start + left.CharacterCount + s.CharacterCount
		  End If
		  
		  // Return the caret position at the end of the inserted text.
		  Return newCaretPos
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206C61737420746F6B656E206F6E2074686973206C696E65206F72204E696C20696620746865726520617265206E6F20746F6B656E732E
		Function LastToken() As XUICELineToken
		  /// Returns the last token on this line or Nil if there are no tokens.
		  
		  If Tokens.Count = 0 Then
		    Return Nil
		  Else
		    Return Tokens(Tokens.LastIndex)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732060636F756E7460206C6566742D6D6F737420636861726163746572732066726F6D2074686973206C696E652E
		Function Left(count As Integer) As String
		  /// Returns `count` left-most characters from this line.
		  
		  Return mContents.LeftCharacters(count)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520636172657420706F736974696F6E206F662074686520656E64206F662074686520776F72642061667465722074686520606361726574506F73602E
		Function NextWordEnd(caretPos As Integer) As Integer
		  /// Returns the caret position of the end of the word after the `caretPos`.
		  ///
		  /// If the caret is within the last word on this line then it returns the 
		  /// end position for the line.
		  ///
		  /// Raises an `InvalidArgumentException` if `caretPos` is out of range for this line.
		  
		  If caretPos < Start Or caretPos > Finish Then
		    Raise New InvalidArgumentException("Invalid `caretPos`")
		  End If
		  
		  // Edge case: at the end of the line.
		  If caretPos = Finish Then Return caretPos
		  
		  // Convert the passed caret position to a relative position in this line.
		  Var pos As Integer = caretPos - Start
		  
		  // A word end is the position immediately after the last run of alphanumeric characters.
		  Var iMax As Integer = Characters.LastIndex
		  Var seenAlpha As Boolean = False
		  For i As Integer = pos To iMax
		    If Characters(i).IsLetterOrDigit Then
		      seenAlpha = True
		      Continue
		    End If
		    If seenAlpha Then Return Start + i
		  Next i
		  
		  Return Finish
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 506F70732074686520737065636966696564206E756D626572206F6620636861726163746572732066726F6D2074686520656E64206F662074686973206C696E6520616E642072657475726E73207468656D2E
		Function PopCharacters(count As Integer, shouldTokenise As Boolean = True) As String
		  /// Pops the specified number of characters from the end of this line and returns them.
		  ///
		  /// If count > number of characters on the line we return the whole line.
		  /// Assumes `count > 0`.
		  
		  Var result As String
		  
		  // Should we return all characters?
		  If count >= Length Then
		    result = mContents
		    SetContents("")
		    Return result
		  End If
		  
		  result = mContents.RightCharacters(count)
		  SetContents(Contents.Left(Length - count), shouldTokenise)
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520636172657420706F73206F6620746865207374617274206F662074686520776F7264206265666F72652074686520606361726574506F73602E
		Function PreviousWordStart(caretPos As Integer) As Integer
		  /// Returns the caret pos of the start of the word before the `caretPos`.
		  ///
		  /// If `caretPos` is within the first word on the line then it returns the 
		  /// line start position.
		  /// Raises an `InvalidArgumentException` if `caretPos` is out of range for this line.
		  
		  If caretPos < Start Or caretPos > Finish Then
		    Raise New InvalidArgumentException("Invalid `caretPos`")
		  End If
		  
		  // Edge case: at the beginning of the line.
		  If caretPos = Start Then Return caretPos
		  
		  // Convert the passed caret position to a relative position in this line.
		  Var pos As Integer = caretPos - Start
		  
		  // A word start is the position immediately before a contiguous run of 
		  // alphanumeric characters.
		  Var seenAlpha, seenNonAlpha As Boolean = False
		  For i As Integer = pos - 1 DownTo 0
		    If Not Characters(i).IsLetterOrDigit Then
		      If seenAlpha Then
		        Return Start + i + 1
		      Else
		        seenNonAlpha = True
		        Continue
		      End If
		    Else
		      seenAlpha = True
		    End If
		  Next i
		  
		  Return Start
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732060636F756E74602072696768742D6D6F737420636861726163746572732066726F6D2074686973206C696E652E
		Function Right(count As Integer) As String
		  /// Returns `count` right-most characters from this line.
		  
		  #Pragma BreakOnExceptions False
		  
		  Return mContents.RightCharacters(count)
		  
		  // HACK: Workaround for occasional out of bounds exception.
		  Exception e As RuntimeException
		    Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520636F6E74656E7473206F662074686973206C696E6520746F206076616C7565602C206D61726B7320746865206C696E6520617320646972747920616E64206F7074696F6E616C6C7920747269676765727320746F6B656E69736174696F6E2E
		Sub SetContents(value As String, shouldTokenise As Boolean = True)
		  /// Sets the contents of this line to `value`, marks the line as dirty and optionally triggers tokenisation.
		  ///
		  /// Assumes that there are no newline characters in `value`.
		  
		  mContents = value
		  Characters = mContents.CharacterArray
		  IsDirty = True
		  
		  // Optionally tokenise this line and any others that are required.
		  If shouldTokenise Then
		    If LineManager.Owner.ContentType = XUICodeEditor.ContentTypes.Markdown Then
		      LineManager.TokeniseAllLines
		      
		    ElseIf LineManager.Owner.ContentType = XUICodeEditor.ContentTypes.SourceCode Then
		      LineManager.TokeniseAllLines
		      
		    Else
		      Raise New UnsupportedOperationException("Unknown XUICodeEditor.ContentsType")
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520746F6B656E20617420746865207370656369666965642060636F6C756D6E60206F72204E696C2069662074686572652069736E2774206F6E652E
		Function TokenAtColumn(column As Integer) As XUICELineToken
		  /// Returns the token at the specified `column` or Nil if there isn't one.
		  
		  If mContents = "" Or column < 0 Or column > Characters.LastIndex Then Return Nil
		  
		  For Each token As XUICELineToken In Tokens
		    If column >= token.StartLocal And column <= token.EndLocal Then
		      Return token
		    End If
		  Next token
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52652D746F6B656E697365732074686973206C696E6520616E6420616E79206F74686572732072657175697265642028646570656E64696E67206F6E206D6F6465292E
		Sub Tokenise()
		  /// Re-tokenises this line and any others required (depending on mode).
		  
		  Var formatter As XUICEFormatter = LineManager.Formatter
		  Var owner As XUICodeEditor = LineManager.Owner
		  
		  // Tell the formatter to tokenise, passing it the currently visible line numbers.
		  formatter.Tokenise(LineManager.Lines, owner.FirstVisibleLine, _
		  owner.LastVisibleLineNumber)
		  
		  // Tell the editor that we've just tokenised.
		  owner.JustTokenised = True
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320612060506169726020636F6E7461696E696E672074686520666972737420616E64206C61737420636F6C756D6E73206F662074686520746F6B656E20636F6E7461696E6564206279207468652073656C656374696F6E206F7220604E696C602069662074686520746F6B656E206973206E6F742073656C65637465642E
		Private Function TokenSelectionOverlap(t As XUICELineToken, selection As XUICESelectedColumns) As Pair
		  /// Returns a `Pair` containing the first and last columns of the token 
		  /// contained by the selection or `Nil` if the token is not selected.
		  ///
		  /// `t` is the token we want to check if enclosed by the passed selection.
		  /// `selection` is a selection representing the columns in this line that are selected.
		  ///
		  /// The returned pair's structure is:
		  /// `Left` = 0-based column of this token where the selection starts
		  /// `Right` = 0-based column of this token where the selection ends.
		  ///
		  /// Let's suppose the token has the lexeme "Hello" and characters "ell" are 
		  /// selected by the passed selection. We will return `1:3` (as the first
		  /// character selected is at column 1 and the last character selected is at 
		  /// column 3).
		  /// The important thing to remember is that the returned columns are local to **this** token, not the line.
		  ///
		  /// Assumes that at least part of this line is within the passed selection 
		  /// so there is at least a chance the passed token is selected.
		  
		  // Account for the fact that the passed in selection may have its end location 
		  // set to -1 if it extends beyond the bounds of this line. In this scenario, 
		  // we will set it to the end of the line.
		  // We need a local variable because we don't want to alter the selection 
		  // that has been passed in by reference.
		  
		  Var selEndCol As Integer
		  If selection.SelectionEndsAfterLine Then
		    selEndCol = Self.Length - 1
		  Else
		    selEndCol = selection.Finish
		  End If
		  
		  Var selStartCol As Integer = selection.Start
		  
		  // Is the token not in the selection?
		  If t.EndLocal < selStartCol Then Return Nil
		  If t.StartLocal > selEndCol Then Return Nil
		  
		  // At least part of the token is selected. Find the first column in the selection.
		  Var tokenSelStartCol As Integer = -1
		  For i As Integer = t.StartLocal To t.EndLocal
		    If i >= selStartCol Then
		      tokenSelStartCol = i
		      Exit
		    End If
		  Next i
		  
		  // Find the last column in the selection.
		  Var tokenSelEndCol As Integer = -1
		  For i As Integer = t.EndLocal DownTo t.StartLocal
		    If i <= selEndCol Then
		      tokenSelEndCol = i
		      Exit
		    End If
		  Next i
		  
		  Return tokenSelStartCol - t.StartLocal : tokenSelEndCol - t.StartLocal
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207769647468206F66207468652074657874206F662074686973206C696E6520757020616E6420696E636C7564696E67207468652063686172616374657220617420606361726574506F736020696E206067602E
		Function WidthToCaretPos(caretPos As Integer, g As Graphics) As Double
		  /// Returns the width of the text of this line up and including the character 
		  /// at `caretPos` in `g`.
		  ///
		  /// `caretPos` is the 0-based caret position, **not** the offset of the 
		  /// character in this line.
		  /// Assumes the `g` has the correct font size and family set.
		  
		  // Beginning of the line?
		  If caretPos = Start Then Return 0
		  
		  // Get the characters from the start of this line up to the computed offset.
		  Var chars As String = CharactersFromColumn(0, caretPos - Start)
		  
		  // Compute the width of this string.
		  Return g.TextWidth(chars)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F662074686973206C696E6520757020746F2060636F6C756D6E602E
		Function WidthToColumn(column As Integer, g As Graphics, ignoreIdentation As Boolean = False) As Double
		  /// The width of this line up to `column`.
		  ///
		  /// `g` is required to compute the width of the string.
		  ///
		  /// Does not include the gutter width.
		  /// Does not factor in padding around the text or the gutter.
		  
		  // Width of a single character.
		  Var charWidth As Double = g.TextWidth("_")
		  
		  // Beginning of the line?
		  If column = 0 Then
		    If ignoreIdentation Then
		      Return 0
		    Else
		      Return IndentWidth(charWidth)
		    End If
		  End If
		  
		  If column > Length Then
		    // Return the width of the entire line.
		    If ignoreIdentation Then
		      Return g.TextWidth(Contents)
		    Else
		      Return g.TextWidth(Contents) + IndentWidth(charWidth)
		    End If
		    
		  Else
		    // Return the width of the characters up to the requested column 
		    // plus the indentation width
		    Var s As String
		    For i As Integer = 0 To column - 1
		      s = s + Characters(i)
		    Next i
		    
		    If ignoreIdentation Then
		      Return g.TextWidth(s)
		    Else
		      Return g.TextWidth(s) + IndentWidth(charWidth)
		    End If
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520776F72642072756E6E696E6720757020746F20286E6F742D696E636C7564696E672920302D62617365642060636F6C756D6E602E2052657475726E732022222069662074686572652069736E2774206F6E652E
		Function WordToColumn(column As Integer) As String
		  /// Returns the word running up to (not-including) 0-based `column`.
		  /// Returns "" if there isn't one.
		  
		  // Easy checks.
		  If column < 1 Then Return ""
		  If column > Characters.LastIndex + 1 Then Return ""
		  
		  // Edge case: There is whitespace immediately before the specified column.
		  If Characters(column - 1).IsWhiteSpace Then Return ""
		  
		  Var start As Integer = 0
		  For i As Integer = column - 1 DownTo 0
		    Var c As String = Characters(i)
		    If Not c.IsLetterOrDigit And c <> "." Then
		      // We allow dots in words to support basic fully qualified identifiers.
		      start = i + 1
		      Exit
		    End If
		  Next i
		  
		  Return mContents.Middle(start, column - start)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Represents a single line of text in the `XUICodeEditor`.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 546865206C656E677468206F662074686973206C696E6520696E20636F6C756D6E732E204120636F6D62696E6174696F6E206F6620746865206E756D626572206F66206368617261637465727320616E642074686520616D6F756E74206F6620696E64656E746174696F6E2E
		#tag Getter
			Get
			  Return (IndentLevel * COLUMNS_PER_INDENT) + Length
			  
			End Get
		#tag EndGetter
		ColumnLength As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652072656164206F6E6C7920636F6E74656E7473206F662074686973206C696E652E20546F20616C746572207573652060536574436F6E74656E74732829602E
		#tag Getter
			Get
			  /// The contents of this line.
			  
			  Return mContents
			End Get
		#tag EndGetter
		Contents As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686973206C696E652773206C6576656C206F6620696E64656E746174696F6E202830203D206E6F20696E64656E746174696F6E292E20436C616D70656420746F203E3D20302E
		#tag Getter
			Get
			  Return mIndentLevel
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Clamp the indentation level above 0.
			  mIndentLevel = Max(value, 0)
			  
			End Set
		#tag EndSetter
		IndentLevel As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973206C696E65206973206120636F6E74696E756174696F6E206F6620746865206C696E652061626F76652E
		IsContinuation As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686973206C696E6520636F6E7461696E73206F6E6C79206E6F6E2D616C7068616E756D6572696320636861726163746572732E
		#tag Getter
			Get
			  /// True if this line contains only non-alphanumeric characters.
			  
			  If IsEmpty Then Return True
			  
			  For Each c As String In Characters
			    If c.IsLetterOrDigit Then Return False
			  Next c
			  
			  Return True
			  
			End Get
		#tag EndGetter
		IsOnlyNonAlpha As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C696E65206D616E616765722074686174206F776E732074686973206C696E652E
		#tag Getter
			Get
			  If mOwnerRef.Value <> Nil Then
			    Return XUICELineManager(mOwnerRef.Value)
			  Else
			    // Shouldn't happen. Every line should be owned by a line manager.
			    Return Nil
			  End If
			  
			End Get
		#tag EndGetter
		LineManager As XUICELineManager
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060496E64656E744C6576656C6020636F6D70757465642070726F70657274792E
		Private mIndentLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686973206C696E652773206F776E696E67206C696E65206D616E616765722E
		Private mOwnerRef As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F7220746865206054657874456E64586020636F6D70757465642070726F70657274792E
		Private mTextEndX As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72207468652060546578745374617274586020636F6D70757465642070726F70657274792E
		Private mTextStartX As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520636F6D7075746564206054657874537461727459602070726F70657274792E
		Private mTextStartY As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F70206C656674205920636F6F7264696E61746520746861742074686973206C696E6520697320647261776E2061742E
		Private mTopLeftY As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865205820636F6F7264696E617465206F662074686520656E64206F662074686973206C696E652773207465787420636F6D707574656420647572696E6720697473206C61737420647261772E
		#tag Getter
			Get
			  Return mTextEndX
			  
			End Get
		#tag EndGetter
		TextEndX As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865205820636F6F7264696E617465206F6620746865207374617274206F662074686973206C696E652773207465787420636F6D707574656420647572696E6720697473206C61737420647261772E20496E636C7564657320696E64656E746174696F6E2E
		#tag Getter
			Get
			  Return mTextStartX
			  
			End Get
		#tag EndGetter
		TextStartX As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865205920636F6F7264696E617465206F6620746865207374617274206F662074686973206C696E652773207465787420636F6D707574656420647572696E6720697473206C61737420647261772E
		#tag Getter
			Get
			  Return mTextStartY
			  
			End Get
		#tag EndGetter
		TextStartY As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686973206C696E65277320746F6B656E732E
		Tokens() As XUICELineToken
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973206C696E652069732070617274206F6620616E20756E6D61746368656420626C6F636B207374727563747572652E
		Unmatched As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 5765206F766572726964652060546578744C696E652E56616C75656020626563617573652074686520656469746F722073686F756C64207573652060436F6E74656E74736020696E73746561642E
		Private Value As String
	#tag EndComputedProperty


	#tag Constant, Name = COLUMNS_PER_INDENT, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 546865206E756D626572206F6620636F6C756D6E732065616368206C6576656C206F6620696E64656E746174696F6E206973206571756976616C656E7420746F2E
	#tag EndConstant

	#tag Constant, Name = ELLIPSIS, Type = String, Dynamic = False, Default = \"\xE2\x80\xA6", Scope = Private, Description = 54686520737472696E6720746F2064726177207768656E20746865726520617265206175746F636F6D706C6574652073756767657374696F6E7320617661696C61626C652E
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Number"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Start"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Finish"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsEmpty"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsBlank"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsDirty"
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
			Name="IndentLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnLength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsOnlyNonAlpha"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextEndX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextStartX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextStartY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
			Name="IsContinuation"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Unmatched"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
