#tag Class
Protected Class XUICEXojoFormatter
Inherits XUICEAbstractFormatter
Implements XUICEFormatter
	#tag Method, Flags = &h21
		Private Function AddComment() As Boolean
		  /// Attempts to add a comment beginning from the current position. Returns True if successful.
		  ///
		  /// Assumes the pointer is yet to consume the opening delimiter.
		  ///
		  /// Comments start with `//` , `'` or `rem` and end at the end of the line:
		  ///
		  /// ```xojo
		  /// // This is comment.
		  /// var age = 40 ' This is also a comment.
		  /// rem This is also a comment
		  /// ```
		  
		  Var peekChar As String = Peek
		  
		  Var isComment As Boolean = False
		  If peekChar = "/" Then
		    If Peek(2) = "/" Then
		      isComment = True
		    End If
		  ElseIf peekChar = "'" Then
		    isComment = True
		  ElseIf peekChar = "r" Then
		    If Peek(2) = "e" And Peek(3) = "m" And Peek(4) = " " Then
		      isComment = True
		    Else
		      Return False
		    End If
		  Else
		    Return False
		  End If
		  
		  If Not isComment Then
		    Return False
		  Else
		    // Advance to the end of the line.
		    mCurrent = mLine.Characters.LastIndex + 1
		    
		    mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_COMMENT))
		    
		    // Advance past the line end.
		    Advance(1)
		    
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416464732065697468657220616E206964656E746966696572206F72206B6579776F726420626567696E6E696E6720617420606D546F6B656E53746172744C6F63616C602E
		Private Sub AddIdentifierOrKeywordToken()
		  /// Adds either an identifier or keyword beginning at `mTokenStartLocal`.
		  ///
		  /// Assumes that `mTokenStartLocal` is a valid identifier or keyword starting 
		  /// character and that `mCurrent` is pointing to the character immediately following the starting character.
		  
		  While Peek.IsASCIILetterOrDigitOrUnderscore
		    Call Advance
		  Wend
		  
		  // Get the lexeme.
		  Var iMax As Integer = mCurrent - 1
		  Var tmp() As String
		  For i As Integer = mTokenStartLocal To iMax
		    tmp.Add(mLine.Characters(i))
		  Next i
		  Var lexeme As String = String.FromArray(tmp, "")
		  
		  // Keyword?
		  If Keywords.HasKey(lexeme) Then
		    Var kw As XojoKeywords = Keywords.Value(lexeme)
		    Var t As XUICELineToken = MakeGenericToken(XUICELineToken.TYPE_KEYWORD, "keyword" : kw)
		    
		    // If this is the first token on the line, is this token a block boundary (start or end)?
		    If mLine.Tokens.Count = 0 Then
		      Select Case kw
		      Case XojoKeywords.Case_, XojoKeywords.Catch_, XojoKeywords.ElseIf_, XojoKeywords.Else_, XojoKeywords.Finally_
		        // These keywords can start and end a block.
		        t.SetData("isBlockStart", True)
		        t.SetData("isBlockEnd", True)
		        BlockBoundaries.Add(t)
		        
		      Case XojoKeywords.Class_, XojoKeywords.Do_, XojoKeywords.Exception_, XojoKeywords.For_, _
		        XojoKeywords.Function_, XojoKeywords.If_, XojoKeywords.Interface_, _
		        XojoKeywords.Module_, XojoKeywords.Private_, XojoKeywords.Property_, XojoKeywords.Protected_, _
		        XojoKeywords.Public_, XojoKeywords.Select_, XojoKeywords.Shared_, XojoKeywords.Static_, _
		        XojoKeywords.Sub_, XojoKeywords.Try_, XojoKeywords.While_
		        // These keywords can start a new block.
		        t.SetData("isBlockStart", True)
		        t.SetData("isBlockEnd", False)
		        BlockBoundaries.Add(t)
		        
		      Case XojoKeywords.End_, XojoKeywords.Loop_, XojoKeywords.Next_, XojoKeywords.Wend_
		        // These keywords can only end a block.
		        t.SetData("isBlockStart", False)
		        t.SetData("isBlockEnd", True)
		        BlockBoundaries.Add(t)
		      End Select
		      
		    ElseIf mLine.Tokens.Count = 1 Then
		      If mLine.Tokens(0).HasDataKey("keyword") Then
		        Select Case mLine.Tokens(0).LookupData("keyword", Nil)
		        Case XojoKeywords.Private_, XojoKeywords.Protected_, XojoKeywords.Public_, XojoKeywords.Shared_, _
		          XojoKeywords.Static_
		          // Edge case: The first token on the line is a scope. If the current token is a keyword that can 
		          // follow a scope then the actual block boundary is **this** token not the scope token.
		          Select Case kw
		          Case XojoKeywords.Class_, XojoKeywords.Function_, XojoKeywords.Interface_, _
		            XojoKeywords.Module_, XojoKeywords.Property_, XojoKeywords.Sub_, XojoKeywords.Try_
		            // Remove the preceding scope token from the end of the `BlockBoundaries` array.
		            Call BlockBoundaries.Pop
		            t.SetData("isBlockStart", True)
		            t.SetData("isBlockEnd", False)
		            // Add this token instead.
		            BlockBoundaries.Add(t)
		          End Select
		          
		        End Select
		      End If
		    End If
		    
		    mLine.Tokens.Add(t)
		    Return
		  End If
		  
		  // Must be an identifier.
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_IDENTIFIER))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416464732074686520706173736564206D61746368696E6720706172656E74686573657320746F2074686520604D617463686564506172656E746865736573602064696374696F6E61727920616E642074686520604D6174636865644F70656E696E67506172656E746865736573602061727261792E
		Private Sub AddMatchingParentheses(lparen As XUICELineToken, rparen As XUICELineToken)
		  /// Adds the passed matching parentheses to the `MatchedParentheses` dictionary and 
		  /// the `MatchedOpeningParentheses` array.
		  ///
		  /// We add both parentheses as keys so we can find either.
		  
		  MatchedParentheses.Value(lparen) = rparen
		  MatchedParentheses.Value(rparen) = lparen
		  
		  MatchedLeftParentheses.Add(lparen)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E73756D657320616E6420616464732061206E756D62657220746F6B656E207374617274696E6720617420606D43757272656E74602E
		Private Sub AddNumberToken()
		  /// Consumes and adds a number token starting at `mCurrent`.
		  ///
		  /// Assumes that `mCurrent` points at a digit.
		  
		  While Peek.IsDigit
		    Advance
		  Wend
		  
		  // Is this a double?
		  If Peek = "." And Peek(2).IsDigit Then
		    // Consume the dot.
		    Advance
		    
		    // Consume the mantissa.
		    While Peek.IsDigit
		      Call Advance
		    Wend
		  End If
		  
		  // Is there an exponent?
		  If Peek = "e" Then
		    Var nextChar As String = Peek(2)
		    If nextChar = "-" Or nextChar = "+" Then
		      // Advance twice to consume the e/E and sign character.
		      Advance(2)
		      
		      // Consume the exponent.
		      While Peek.IsDigit
		        Call Advance
		      Wend
		      
		    ElseIf nextChar.IsDigit Then
		      // Consume the e/E character.
		      Advance
		      
		      // Consume the exponent.
		      While Peek.IsDigit
		        Call Advance
		      Wend
		    End If
		  End If
		  
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_NUMBER))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417474656D70747320746F20636F6E73756D6520616E6420616464206120707261676D6120746F6B656E207374617274696E6720617420606D43757272656E74602E
		Private Sub AddPragmaToken()
		  /// Attempts to consume and add a pragma token starting at `mCurrent`.
		  ///
		  /// Assumes we have just consumed the `#` character.
		  ///
		  /// ```
		  /// #Pragma Something
		  ///  ^
		  /// ```
		  
		  // Must see `Pragma`.
		  Var lexeme As String
		  For i As Integer = 1 to 6
		    Select Case Peek
		    Case &u0A, ""
		      Exit
		    End Select
		    lexeme = lexeme + Consume
		  Next i
		  
		  If lexeme <> "Pragma" Then
		    mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_ERROR))
		    Return
		  Else
		    mLine.Tokens.Add(MakeToken(TOKEN_PRAGMA, XUICELineToken.TYPE_KEYWORD))
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417474656D70747320746F20636F6E73756D6520616E6420616464206120737472696E6720746F6B656E207374617274696E6720617420606D43757272656E74602E
		Private Sub AddStringToken()
		  /// Attempts to consume and add a string token starting at `mCurrent`.
		  ///
		  /// Assumes we have just consumed a double quote (`"`):
		  ///
		  /// ```
		  /// name = "Hello"
		  ///         ^
		  /// ```
		  ///
		  /// A successful string will have seaprate tokens for its opening and closing delimiters.
		  /// This allows us to tokenise escaped quotes differently from the rest of the string.
		  
		  // We need an array of temporary tokens as they may be redundant if the string is not terminated.
		  Var tokens() As XUICELineToken
		  
		  // Add the opening delimiter (`"`).
		  Var startLocal As Integer = mCurrent - 1
		  tokens.Add(MakeGenericToken(XUICELineToken.TYPE_STRING))
		  
		  // The token now starts beyond the opening delimiter.
		  mTokenStartLocal = mCurrent
		  
		  Var terminated As Boolean = False
		  While Not AtLineEnd
		    
		    Select Case Peek
		    Case """"
		      If Peek(2) <> """" Then
		        // This is the end of the string.
		        Advance
		        tokens.Add(MakeGenericToken(XUICELineToken.TYPE_STRING))
		        terminated = True
		        Exit
		      Else
		        // Found `""` which is an escaped double quote.
		        // Create a string token up to (but not including) the `""`.
		        tokens.Add(MakeGenericToken(XUICELineToken.TYPE_STRING))
		        
		        mTokenStartLocal = mCurrent
		        
		        // Move past the two double quotes.
		        Advance(2)
		        
		        // Now add the `""` escaped token.
		        tokens.Add(MakeToken(TOKEN_ESCAPE, XUICELineToken.TYPE_STRING))
		        
		        mTokenStartLocal = mCurrent
		      End If
		      
		    Else
		      Advance
		    End Select
		  Wend
		  
		  If Not terminated Then
		    // Just add an error token.
		    mTokenStartLocal = startLocal
		    mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_ERROR))
		    Return
		    
		  Else
		    // Add the tokens to the line.
		    For Each token As XUICELineToken In tokens
		      mLine.Tokens.Add(token)
		    Next token
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320666F726D617474657220616C6C6F777320776869746573706163652061742074686520626567696E6E696E67206F662061206C696E652E2049662046616C73652C2074686520656469746F722077696C6C207374726970206974207768656E2070617374696E6720616E642070726576656E742069742066726F6D206265696E672074797065642E
		Function AllowsLeadingWhitespace() As Boolean
		  /// True if this formatter allows whitespace at the beginning of a line. 
		  /// If False, the editor will strip it when pasting and prevent it from being typed.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060626C6F636B456E64602063616E20636C6F73652060626C6F636B5374617274602E
		Private Function CanCloseBlock(blockStart As XojoKeywords, blockEnd As XojoKeywords) As Boolean
		  /// Returns True if `blockEnd` can close `blockStart`.
		  
		  Select Case blockStart
		    // Case.
		  Case XojoKeywords.Case_
		    Select Case blockEnd
		    Case XojoKeywords.Case_, XojoKeywords.End_
		      Return True
		    Else
		      Return False
		    End Select
		    
		    // Catch.
		  Case XojoKeywords.Catch_
		    Select Case blockEnd
		    Case XojoKeywords.Catch_, XojoKeywords.Finally_, XojoKeywords.Try_, XojoKeywords.End_
		      Return True
		    Else
		      Return False
		    End Select
		    
		    // Do.
		  Case XojoKeywords.Do_
		    Return blockEnd = XojoKeywords.Loop_
		    
		    // Finally.
		  Case XojoKeywords.Finally_
		    Select Case blockEnd
		    Case XojoKeywords.End_
		      Return True
		    Else
		      Return False
		    End Select
		    
		    // Else.
		  Case XojoKeywords.Else_
		    Select Case blockEnd
		    Case XojoKeywords.End_
		      Return True
		    Else
		      Return False
		    End Select
		    
		    // ElseIf.
		  Case XojoKeywords.ElseIf_
		    Select Case blockEnd
		    Case XojoKeywords.ElseIf_, XojoKeywords.Else_, XojoKeywords.End_
		      Return True
		    Else
		      Return False
		    End Select
		    
		    // Exception.
		  Case XojoKeywords.Exception_
		    // This is a weird case. We'll say anything can close it otherwise we'll always end up with 
		    // an unmatched block.
		    Return True
		    
		    // For.
		  Case XojoKeywords.For_
		    Return blockEnd = XojoKeywords.Next_
		    
		    // If.
		  Case XojoKeywords.If_
		    Select Case blockEnd
		    Case XojoKeywords.ElseIf_, XojoKeywords.Else_, XojoKeywords.End_
		      Return True
		    Else
		      Return False
		    End Select
		    
		    // Select.
		  Case XojoKeywords.Select_
		    Select Case blockEnd
		    Case XojoKeywords.Case_, XojoKeywords.End_
		      Return True
		    Else
		      Return False
		    End Select
		    
		    // While.
		  Case XojoKeywords.While_
		    Return blockEnd = XojoKeywords.Wend_
		    
		    // Class, Function, Interface, Module, Property, Sub, Try.
		  Case XojoKeywords.Class_, XojoKeywords.Function_, XojoKeywords.Interface_, XojoKeywords.Module_, _
		    XojoKeywords.Property_, XojoKeywords.Sub_, XojoKeywords.Try_
		    Select Case blockEnd
		    Case XojoKeywords.End_
		      Return True
		    Else
		      Return False
		    End Select
		    
		  Else
		    Return blockEnd = blockStart
		  End Select
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206C696E652061626F766520606C696E654E756D626572602074686174206973206E6F7420626C616E6B206E6F74206A757374206120636F6D6D656E74206C696E652E204D61792072657475726E204E696C2E
		Private Function ClosestCodeLineAbove(lines() As XUICELine, lineNumber As Integer) As XUICELine
		  /// Returns the line above `lineNumber` that is not blank not just a comment line. May return Nil.
		  
		  If lineNumber <= 1 Then Return Nil
		  If lineNumber > lines.Count Then Return Nil
		  
		  For i As Integer = lineNumber - 2 DownTo 0
		    Var line As XUICELine = lines(i)
		    If line.IsBlank Or IsCommentLine(line) Then
		      Continue
		    Else
		      Return line
		    End If
		  Next i
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520666972737420746F6B656E206F6E20606C696E65602074686174206973206E6F74206120636F6D6D656E74206F72204E696C20696620746865726520617265206E6F6E652E
		Private Function FirstNonCommentToken(line As XUICELine) As XUICELineToken
		  /// Returns the first token on `line` that is not a comment or Nil if there are none.
		  ///
		  /// Assumes `line` is not Nil.
		  
		  If line.Tokens.Count = 0 Then Return Nil
		  
		  For Each t As XUICELineToken In line.Tokens
		    If Not IsCommentToken(t) Then Return t
		  Next t
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 536574732074686520696E64656E746174696F6E202F20636F6E74696E756174696F6E20737461747573206F66207468652070617373656420606C696E6573602E
		Private Sub IndentLines(ByRef lines() As XUICELine)
		  /// Sets the indentation / continuation status of the passed `lines`.
		  
		  If lines.Count = 0 Then Return
		  
		  // The first line is never indented.
		  lines(0).IndentLevel = 0
		  lines(0).IsContinuation = False
		  lines(0).Unmatched = False
		  
		  // If there's only one line then there can be no indentation.
		  If lines.Count = 1 Then Return
		  
		  Var lineAbove As XUICELine
		  Var iMax As Integer = lines.LastIndex
		  For i As Integer = 1 To iMax
		    // Get this line and reset it.
		    Var line As XUICELine = lines(i)
		    line.IsContinuation = False
		    line.Unmatched = False
		    
		    // We need the line above. We ignore blank lines and comment-only lines. This may be Nil if the
		    // current line is the first actual code line in the source.
		    lineAbove = ClosestCodeLineAbove(lines, line.Number)
		    
		    If lineAbove = Nil Then
		      line.IndentLevel = 0
		      line.IsContinuation = False
		      Continue
		      
		    ElseIf line.IsBlank Then
		      line.IndentLevel = lineAbove.IndentLevel
		      line.IsContinuation = lineAbove.IsContinuation
		      Continue
		      
		    Else
		      // Start by inheriting the line above's indent level.
		      line.IndentLevel = lineAbove.IndentLevel
		      
		      // We need the first token of this line and the first token of the line above.
		      Var firstToken As XUICELineToken = line.FirstToken
		      If firstToken = Nil Then Continue
		      Var lineAboveFirstToken As XUICELineToken = lineAbove.FirstToken
		      If lineAboveFirstToken = Nil Then Continue
		      
		      // Does the first token of the line above indent this line?
		      If lineAboveFirstToken.Type = XUICELineToken.TYPE_KEYWORD Then
		        Select Case lineAboveFirstToken.LookupData("keyword", Nil)
		        Case XojoKeywords.Case_, XojoKeywords.Catch_, XojoKeywords.Class_, XojoKeywords.Do_, XojoKeywords.ElseIf_, _
		          XojoKeywords.Else_, XojoKeywords.Exception_, XojoKeywords.Finally_, XojoKeywords.For_, _
		          XojoKeywords.Function_, XojoKeywords.Interface_, XojoKeywords.Module_, _
		          XojoKeywords.Private_, XojoKeywords.Property_, XojoKeywords.Protected_, _
		          XojoKeywords.Public_, XojoKeywords.Select_, XojoKeywords.Shared_, XojoKeywords.Static_, _
		          XojoKeywords.Sub_, XojoKeywords.Try_, XojoKeywords.While_
		          line.IndentLevel = line.IndentLevel + 1
		          
		        Case XojoKeywords.If_
		          If Not IsSingleLineIfStatement(lineAbove) Then
		            line.IndentLevel = line.IndentLevel + 1
		          End If
		        End Select
		      End If
		      
		      // Does the first token dedent this line?
		      If firstToken.Type = XUICELineToken.TYPE_KEYWORD Then
		        Select Case firstToken.LookupData("keyword", Nil)
		        Case XojoKeywords.Case_, XojoKeywords.Catch_, XojoKeywords.ElseIf_, XojoKeywords.Else_, XojoKeywords.End_, _
		          XojoKeywords.Loop_, XojoKeywords.Next_, XojoKeywords.Wend_
		          line.IndentLevel = line.IndentLevel - 1
		        End Select
		      End If
		      
		      // Is this line a continuation of the line above?
		      Var lineAboveLastToken As XUICELineToken = LastNonCommentToken(lineAbove)
		      If lineAboveLastToken <> Nil And lineAboveLastToken.Type = XUICELineToken.TYPE_OPERATOR And _
		        lineAboveLastToken.LookupData("isLineContination", False) Then
		        line.IsContinuation = True
		      Else
		        line.IsContinuation = False
		      End If
		      
		    End If
		    
		  Next i
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320656E74697265206C696E65206973206120636F6D6D656E742E
		Function IsCommentLine(line As XUICELine) As Boolean
		  /// True if this entire line is a comment.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return TokenIsComment(line.FirstToken)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547275652069662060746F6B656E60206973206120636F6D6D656E742E
		Private Function IsCommentToken(token As XUICELineToken) As Boolean
		  /// True if `token` is a comment.
		  ///
		  /// Assumes `token` is not Nil.
		  
		  Return token.Type = XUICELineToken.TYPE_COMMENT
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5472756520696620606C696E656020697320612073696E676C65206C696E652069662073746174656D656E742E
		Private Function IsSingleLineIfStatement(line As XUICELine) As Boolean
		  /// True if `line` is a single line if statement.
		  
		  // A single line `if` needs at least three non-comment tokens. `if` must be first, `then` must be present 
		  // but not last on the line.
		  
		  If line.Tokens.Count < 3 Then Return False
		  
		  // The first token must be `if` to be a single line if statement.
		  Var firstToken As XUICELineToken = line.FirstToken
		  If firstToken = Nil Then Return False
		  If firstToken.LookupData("keyword", XojoKeywords.Const_) <> XojoKeywords.If_ Then Return False
		  
		  // The last (non-comment) token must not be `then` or `if`.
		  Var lastToken As XUICELineToken = LastNonCommentToken(line)
		  If lastToken = Nil Then Return False
		  If lastToken.LookupData("keyword", XojoKeywords.Const_) = XojoKeywords.If_ Then Return False
		  If lastToken.LookupData("keyword", XojoKeywords.Const_) = XojoKeywords.Then_ Then Return False
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206C61737420746F6B656E206F6E20606C696E65602074686174206973206E6F74206120636F6D6D656E74206F72204E696C206966207468657265206973206E6F6E652E
		Private Function LastNonCommentToken(line As XUICELine) As XUICELineToken
		  /// Returns the last token on `line` that is not a comment or Nil if there is none.
		  ///
		  /// Assumes `line` is not Nil.
		  
		  If line.Tokens.Count = 0 Then Return Nil
		  
		  For i As Integer = line.Tokens.LastIndex DownTo 0
		    If Not IsCommentToken(line.Tokens(i)) Then Return line.Tokens(i)
		  Next i
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E616D65206F66207468697320666F726D61747465722E
		Function Name() As String
		  /// The name of this formatter.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return "Xojo"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206E6561726573742064656C696D69746572732061742074686520676976656E20606361726574506F73602E204D6179206265204E696C2E
		Function NearestDelimitersForCaretPos(caretPos As Integer) As XUICEDelimiter
		  /// Returns the nearest delimiters at the given `caretPos`. May be Nil.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  // We iterate backwards over the matched parentheses starting from the last left parenthesis in the source code.
		  For i As Integer = MatchedLeftParentheses.LastIndex DownTo 0
		    Var lparen As XUICELineToken = MatchedLeftParentheses(i)
		    If lparen.StartAbsolute <= caretPos Then
		      // If this is matched after the caret (or not at all) then we're done.
		      If MatchedParentheses.HasKey(lparen) Then
		        Var rparen As XUICELineToken = MatchedParentheses.Value(lparen)
		        If rparen.StartAbsolute >= caretPos Then Return New XUICEDelimiter(lparen, rparen)
		      End If
		    End If
		  Next i
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 47656E65726174657320746865206E65787420746F6B656E20616E6420617070656E647320697420746F20606D4C696E652E546F6B656E73602E
		Private Sub NextToken()
		  /// Generates the next token and appends it to `mLine.Tokens`.
		  
		  // Have we reached the end?
		  If AtEnd Then Return
		  
		  // Skip over whitespace.
		  SkipWhitespace
		  
		  // Now have we reached the end?
		  If AtEnd Then Return
		  
		  // Store the current token start index.
		  mTokenStartLocal = mCurrent
		  
		  // =====================================
		  // COMMENTS
		  // =====================================
		  If AddComment Then Return
		  
		  // Get the character to evaluate.
		  Var c As String = Consume
		  
		  // If we're at the end of the line, move on.
		  If c = &u0A Then Return
		  
		  // =====================================
		  // NUMBERS
		  // =====================================
		  If IsNumeric(c) Then
		    AddNumberToken
		    Return
		  End If
		  
		  // =====================================
		  // OPERATORS
		  // =====================================
		  Select Case c
		  Case ".", "=", "-", "*", "/", "%", "+", "<", ">", ",", ":"
		    mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_OPERATOR))
		    Return
		    
		  Case "("
		    Var t As XUICELineToken = _
		    MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "delimiterType" : XUICEDelimiter.Types.LParen)
		    mLine.Tokens.Add(t)
		    Parentheses.Add(t)
		    Return
		    
		  Case ")"
		    Var t As XUICELineToken = MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "delimiterType" : XUICEDelimiter.Types.RParen)
		    mLine.Tokens.Add(t)
		    Parentheses.Add(t)
		    Return
		  End Select
		  
		  // =====================================
		  // AMPERSAND LITERALS
		  // =====================================
		  If c = "&" Then
		    Select Case Peek
		    Case "b"
		      Advance
		      If TryAddBinaryLiteral Then Return
		      
		    Case "h"
		      Advance
		      If TryAddHexLiteral Then Return
		      
		    Case "c"
		      Advance
		      If TryAddColorLiteral Then Return
		      
		    Case "o"
		      Advance
		      If TryAddOctalLiteral Then Return
		      
		    Case "u"
		      Advance
		      If TryAddUnicodeLiteral Then Return
		    End Select
		  End If
		  
		  // =======================
		  // STRINGS
		  // =======================
		  If c = """" Then
		    AddStringToken
		    Return
		  End If
		  
		  // =======================
		  // PRAGMAS
		  // =======================
		  If c = "#" Then
		    AddPragmaToken
		    Return
		  End If
		  
		  // =========================
		  // KEYWORDS & IDENTIFIERS
		  // =========================
		  If c.IsASCIILetter Then
		    AddIdentifierOrKeywordToken
		    Return
		  End If
		  
		  // =====================================
		  // LINE CONTINUATION
		  // =====================================
		  If c = "_" Then
		    mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "isLineContination" : True))
		    Return
		  End If
		  
		  // =====================================
		  // UNRECOGNISED CHARACTER
		  // =====================================
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_ERROR))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C656420706572696F646963616C6C792062792074686520656469746F722E20416E206F70706F7274756E69747920746F2070617273652074686520746F6B656E69736564206C696E65732E2057696C6C20616C776179732062652063616C6C656420616674657220746865206C696E65732068617665206265656E20746F6B656E697365642E
		Sub Parse(lines() As XUICELine)
		  /// Called periodically by the editor. An opportunity to parse the tokenised lines. 
		  /// Will always be called after the lines have been tokenised.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  ProcessParentheses
		  IndentLines(lines)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 46696E647320746865206C6F636174696F6E73206F6620706172656E74686573657320616E642061646473207468656D20746F20604D617463686564506172656E746865736573602E
		Private Sub ProcessParentheses()
		  /// Finds the locations of parentheses and adds them to `MatchedParentheses`.
		  
		  Var lparen As XUICEDelimiter.Types = XUICEDelimiter.Types.LParen
		  Var rparen As XUICEDelimiter.Types = XUICEDelimiter.Types.RParen
		  
		  MatchedLeftParentheses.RemoveAll
		  MatchedParentheses = New Dictionary
		  
		  // Don't waste resources parsing the parentheses if the editor has the option turned off.
		  If Not mLineManager.Owner.HighlightDelimitersAroundCaret Then
		    Return
		  End If
		  
		  Var iMax As Integer = Parentheses.LastIndex
		  For i As Integer = 0 To iMax
		    Var opener As XUICELineToken = Parentheses(i)
		    
		    // We're only interested in the left parentheses.
		    If opener.LookupData("delimiterType", XUICEDelimiter.Types.None) <> lparen Then
		      Continue For i
		    End If
		    
		    // Find the "closer" (matching right parenthesis) if present.
		    Var nestingLevel As Integer = 0
		    For j As Integer = i + 1 To iMax
		      Var closer As XUICELineToken = Parentheses(j)
		      
		      If closer.LookupData("delimiterType", XUICEDelimiter.Types.None) = lparen Then
		        nestingLevel = nestingLevel + 1
		        
		      ElseIf closer.LookupData("delimiterType", XUICEDelimiter.Types.None) = rparen Then
		        If nestingLevel = 0 Then
		          // Found it.
		          AddMatchingParentheses(opener, closer)
		          Continue For i
		        Else
		          nestingLevel = nestingLevel - 1
		        End If
		      End If
		    Next j
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416476616E636573207061737420776869746573706163652E
		Private Sub SkipWhitespace()
		  /// Advances past whitespace.
		  
		  Do
		    Select Case Peek
		    Case "" // End of the line.
		      Exit
		      
		    Case " ", &u0009
		      Advance
		      
		    Else
		      Exit
		    End Select
		  Loop
		  
		  // Update the start position of the next token.
		  mTokenStartLocal = mCurrent
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732054727565206173207468697320666F726D617474657220737570706F72747320686967686C69676874696E672074686520706172656E7468657365732061726F756E64207468652063617265742E
		Function SupportsDelimiterHighlighting() As Boolean
		  /// Returns True as this formatter supports highlighting the parentheses around the caret.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320666F726D617474657220686967686C696768747320756E6D61746368656420626C6F636B732E
		Function SupportsUnmatchedBlockHighlighting() As Boolean
		  /// True if this formatter highlights unmatched blocks.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 547275652069662060746F6B656E6020697320636F6E7369646572656420746F206265206120636F6D6D656E742E
		Function TokenIsComment(token As XUICELineToken) As Boolean
		  /// True if `token` is considered to be a comment.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  If token = Nil Then Return False
		  Return token.Type = XUICELineToken.TYPE_COMMENT
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E69736573206120706F7274696F6E206F6620606C696E6573602E
		Sub Tokenise(lines() As XUICELine, firstVisibleLineNumber As Integer, lastVisibleLineNumber As Integer)
		  /// Tokenises a portion of `lines`.
		  ///
		  /// Note that we tokenise all lines, even though this method is passed the visible line numbers.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  #Pragma Unused firstVisibleLineNumber
		  #Pragma Unused lastVisibleLineNumber
		  
		  TokeniseAll(lines)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E6973657320616E206172726179206F66206C696E65732E
		Sub TokeniseAll(lines() As XUICELine)
		  /// Tokenises an array of lines.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  If lines.Count = 0 Then Return
		  
		  Initialise(lines, 1)
		  
		  Parentheses.RemoveAll
		  BlockBoundaries.RemoveAll
		  
		  While Not AtEnd
		    NextToken
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620616E79206E6F6E207374616E6461726420746F6B656E2074797065732075736564206279207468697320666F726D61747465722E
		Function TokenTypes() As String()
		  /// Returns an array of any non standard token types used by this formatter.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return Array( _
		  TOKEN_ALPHA_COMPONENT, _
		  TOKEN_BLUE_COMPONENT, _
		  TOKEN_COLOR_PREFIX, _
		  TOKEN_ESCAPE, _
		  TOKEN_GREEN_COMPONENT, _
		  TOKEN_RED_COMPONENT _
		  )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F20636F6E73756D6520616E642061646420612062696E617279206C69746572616C20746F6B656E2E2052657475726E732054727565206966207375636365737366756C2E
		Private Function TryAddBinaryLiteral() As Boolean
		  /// Tries to consume and add a binary literal token. Returns True if successful.
		  ///
		  /// Assumes that `mCurrent` points here:
		  ///
		  /// ```
		  /// &b0110
		  ///   ^
		  /// ```
		  
		  // Need to see at least one binary digit.
		  If Not Peek.IsBinaryDigit Then Return False
		  
		  // Consume the binary digits.
		  While Peek.IsBinaryDigit
		    Advance
		  Wend
		  
		  // The next character must not be alphanumeric.
		  If Peek.IsASCIILetterOrDigit Then Return False
		  
		  // Binary literals are just numbers.
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_NUMBER))
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F20636F6E73756D6520616E6420616464206120436F6C6F72206C69746572616C20746F6B656E2E2052657475726E732054727565206966207375636365737366756C2E
		Private Function TryAddColorLiteral() As Boolean
		  /// Tries to consume and add a Color literal token. Returns True if successful.
		  ///
		  /// Assumes that `mCurrent` points here:
		  ///
		  /// ```
		  /// &c123456
		  ///   ^
		  /// ```
		  ///
		  /// Valid tokens (where R, G, B & A are hex digits):
		  ///
		  /// ```
		  /// &cRGB
		  /// &cRRGGBB
		  /// &cRRGGBBAA
		  /// ```
		  
		  Var lexemeStart As Integer = mCurrent
		  
		  // Get the lexeme (continguous hex digits).
		  Var lexeme() As String
		  While Peek.IsHexDigit
		    lexeme.Add(Consume)
		  Wend
		  
		  // Valid color literal lexemes are 3, 6 or 8 digits.
		  Select Case lexeme.Count
		  Case 3, 6, 8
		    // Create a prefix token.
		    mLine.Tokens.Add(New XUICELineToken(mline.Start + mTokenStartLocal, mTokenStartLocal, lexemeStart - mTokenStartLocal, _
		    mLineNumber, TOKEN_COLOR_PREFIX, XUICELineToken.TYPE_OPERATOR))
		    
		  Else
		    // Invalid.
		    Return False
		  End Select
		  
		  Var cachedCurrent As Integer = mCurrent
		  
		  // Handle the colour components.
		  Select Case lexeme.Count
		  Case 3
		    // Red.
		    mTokenStartLocal = lexemeStart
		    mCurrent = lexemeStart + 1
		    mLine.Tokens.Add(MakeToken(TOKEN_RED_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		    
		    // Green.
		    mTokenStartLocal = mTokenStartLocal + 1
		    mCurrent = mCurrent + 1
		    mLine.Tokens.Add(MakeToken(TOKEN_GREEN_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		    
		    // Blue.
		    mTokenStartLocal = mTokenStartLocal + 1
		    mCurrent = mCurrent + 1
		    mLine.Tokens.Add(MakeToken(TOKEN_BLUE_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		  Case 6
		    // Red.
		    mTokenStartLocal = lexemeStart
		    mCurrent = lexemeStart + 2
		    mLine.Tokens.Add(MakeToken(TOKEN_RED_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		    
		    // Green.
		    mTokenStartLocal = mTokenStartLocal + 2
		    mCurrent = mCurrent + 2
		    mLine.Tokens.Add(MakeToken(TOKEN_GREEN_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		    
		    // Blue.
		    mTokenStartLocal = mTokenStartLocal + 2
		    mCurrent = mCurrent + 2
		    mLine.Tokens.Add(MakeToken(TOKEN_BLUE_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		  Case 8
		    // Red.
		    mTokenStartLocal = lexemeStart
		    mCurrent = lexemeStart + 2
		    mLine.Tokens.Add(MakeToken(TOKEN_RED_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		    
		    // Green.
		    mTokenStartLocal = mTokenStartLocal + 2
		    mCurrent = mCurrent + 2
		    mLine.Tokens.Add(MakeToken(TOKEN_GREEN_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		    
		    // Blue.
		    mTokenStartLocal = mTokenStartLocal + 2
		    mCurrent = mCurrent + 2
		    mLine.Tokens.Add(MakeToken(TOKEN_BLUE_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		    
		    // Alpha.
		    mTokenStartLocal = mTokenStartLocal + 2
		    mCurrent = mCurrent + 2
		    mLine.Tokens.Add(MakeToken(TOKEN_ALPHA_COMPONENT, XUICELineToken.TYPE_OPERATOR))
		  Else
		    // Invalid.
		    Return False
		  End Select
		  
		  mCurrent = cachedCurrent
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F20636F6E73756D6520616E642061646420612068657861646563696D616C206C69746572616C20746F6B656E2E2052657475726E732054727565206966207375636365737366756C2E
		Private Function TryAddHexLiteral() As Boolean
		  /// Tries to consume and add a hexadecimal literal token. Returns True if successful.
		  ///
		  /// Assumes that `mCurrent` points here:
		  ///
		  /// ```
		  /// &hAB19
		  ///   ^
		  /// ```
		  
		  // Need to see at least one hex digit.
		  If Not Peek.IsHexDigit Then Return False
		  
		  // Consume the hex digits.
		  While Peek.IsHexDigit
		    Advance
		  Wend
		  
		  // Hex literals are just numbers.
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_NUMBER))
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F20636F6E73756D6520616E642061646420616E206F6374616C206C69746572616C20746F6B656E2E2052657475726E732054727565206966207375636365737366756C2E
		Private Function TryAddOctalLiteral() As Boolean
		  /// Tries to consume and add an octal literal token. Returns True if successful.
		  ///
		  /// Assumes that `mCurrent` points here:
		  ///
		  /// ```
		  /// &o0134
		  ///   ^
		  /// ```
		  
		  // Need to see at least one octal digit.
		  If Not Peek.IsOctalDigit Then Return False
		  
		  // Consume the octal digits.
		  While Peek.IsOctalDigit
		    Advance
		  Wend
		  
		  // The next character must not be a letter, 8 or 9
		  Var peekChar As String = Peek
		  If peekChar.IsASCIILetter Or peekChar = "8" Or peekChar = "9" Then
		    Return False
		  End If
		  
		  // Octal literals are just numbers.
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_NUMBER))
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F20636F6E73756D6520616E6420616464206120756E69636F6465206C69746572616C20746F6B656E2E2052657475726E732054727565206966207375636365737366756C2E
		Private Function TryAddUnicodeLiteral() As Boolean
		  /// Tries to consume and add a unicode literal token. Returns True if successful.
		  ///
		  /// Assumes that `mCurrent` points here:
		  ///
		  /// ```
		  /// &u13
		  ///   ^
		  /// ```
		  
		  // Need to see at least one hex digit.
		  If Not Peek.IsHexDigit Then Return False
		  
		  // Consume the hex digits.
		  While Peek.IsHexDigit
		    Advance
		  Wend
		  
		  // Unicode literals are strings.
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_STRING))
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A formatter for the Xojo language. In addition to tokenising the language components you'd expect (keywords, 
		operators, etc) it also tokenises the components of `Color` literals (like the Xojo IDE) and escaped double
		quotes within strings.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 4120736F72746564206172726179206F6620616C6C20746F6B656E732074686174206D61726B20746865207374617274206F7220656E64206F66206120626C6F636B2E
		Private BlockBoundaries() As XUICELineToken
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 4361736520696E73656E7369746976652064696374696F6E617279206F66206B6579776F7264732E204B6579203D204B6579776F72642C2056616C7565203D20586F6A6F4B6579776F72647320656E756D65726174696F6E2E
		#tag Getter
			Get
			  Static kw As New Dictionary( _
			  "AddHandler" : XojoKeywords.AddHandler_, _
			  "AddressOf" : XojoKeywords.AddressOf_, _
			  "Array" : XojoKeywords.Array_, _
			  "As" : XojoKeywords.As_, _
			  "Assigns" : XojoKeywords.Assigns_, _
			  "Break" : XojoKeywords.Break_, _
			  "ByRef" : XojoKeywords.ByRef_, _
			  "ByVal" : XojoKeywords.ByVal_, _
			  "Call" : XojoKeywords.Call_, _
			  "Catch" : XojoKeywords.Catch_, _
			    "Class" : XojoKeywords.Class_, _
			      "Const" : XojoKeywords.Const_, _
			      "Continue" : XojoKeywords.Continue_, _
			      "CType" : XojoKeywords.CType_, _
			      "Declare" : XojoKeywords.Declare_, _
			      "Dim" : XojoKeywords.Dim_, _
			      "Do" : XojoKeywords.Do_, _
			      "Loop" : XojoKeywords.Loop_, _
			      "DownTo" : XojoKeywords.DownTo_, _
			      "Else" : XojoKeywords.Else_, _
			        "ElseIf" : XojoKeywords.ElseIf_, _
			          "End" : XojoKeywords.End_, _
			          "Event" : XojoKeywords.Event_, _
			  "Exception" : XojoKeywords.Exception_, _
			    "Exit" : XojoKeywords.Exit_, _
			    "Extends" : XojoKeywords.Extends_, _
			  "Finally" : XojoKeywords.Finally_, _
			    "For" : XojoKeywords.For_, _
			    "Next" : XojoKeywords.Next_, _
			    "Each" : XojoKeywords.Each_, _
			    "Function" : XojoKeywords.Function_, _
			      "GetTypeInfo" : XojoKeywords.GetTypeInfo_, _
			      "Global" : XojoKeywords.Global_, _
			      "GoTo" : XojoKeywords.GoTo_, _
			      "If" : XojoKeywords.If_, _
			        "Then" : XojoKeywords.Then_, _
			        "Implements" : XojoKeywords.Implements_, _
			        "Inherits" : XojoKeywords.Inherits_, _
			        "Interface" : XojoKeywords.Interface_, _
			          "Module" : XojoKeywords.Module_, _
			            "Optional" : XojoKeywords.Optional_, _
			            "ParamArray" : XojoKeywords.ParamArray_, _
			            "Private" : XojoKeywords.Private_, _
			            "Property" : XojoKeywords.Property_, _
			            "Protected" : XojoKeywords.Protected_, _
			            "Public" : XojoKeywords.Public_, _
			            "Raise" : XojoKeywords.Raise_, _
			            "RaiseEvent" : XojoKeywords.RaiseEvent_, _
			            "Redim" : XojoKeywords.Redim_, _
			            "RemoveHandler" : XojoKeywords.RemoveHandler_, _
			            "Return" : XojoKeywords.Return_, _
			            "Select" : XojoKeywords.Select_, _
			            "Case" : XojoKeywords.Case_, _
			              "Self" : XojoKeywords.Self_, _
			              "Shared" : XojoKeywords.Shared_, _
			              "Static" : XojoKeywords.Static_, _
			              "Sub" : XojoKeywords.Sub_, _
			                "Super" : XojoKeywords.Super_, _
			                "Try" : XojoKeywords.Try_, _
			                  "Until" : XojoKeywords.Until_, _
			                  "Using" : XojoKeywords.Using_, _
			                  "Var" : XojoKeywords.Var_, _
			                  "While" : XojoKeywords.While_, _
			                  "Wend" : XojoKeywords.Wend_)
			                  
			                  Return kw
			                  
			End Get
		#tag EndGetter
		Private Keywords As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 416E206172726179206F6620616C6C206C65667420706172656E74686573657320776974682061206D61746368696E6720726967687420706172656E74686573697320736F7274656420627920746865697220706F736974696F6E20696E2074686520736F7572636520636F64652028696E6465782030203D206669727374206D6174636865642070616972206F6620706172656E74686573657320696E2074686520736F7572636520636F6465292E
		Private MatchedLeftParentheses() As XUICELineToken
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 416C6C207061697273206F66206D61746368696E6720706172656E74686573657320696E2074686520736F7572636520636F64652E204B6579203D204C65667420706172656E74686573697320286058554943454C696E65546F6B656E60292C2056616C7565203D204D61746368696E6720726967687420706172656E74686573697320286058554943454C696E65546F6B656E60292E
		Private MatchedParentheses As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4120736F72746564206172726179206F6620616C6C20706172656E74686573697320746F6B656E7320696E2074686520736F7572636520636F64652E
		Private Parentheses() As XUICELineToken
	#tag EndProperty


	#tag Constant, Name = TOKEN_ALPHA_COMPONENT, Type = String, Dynamic = False, Default = \"colorAlpha", Scope = Public, Description = 54686520616C70686120636F6D706F6E656E74206F66206120636F6C6F72206C69746572616C2E
	#tag EndConstant

	#tag Constant, Name = TOKEN_BLUE_COMPONENT, Type = String, Dynamic = False, Default = \"colorBlue", Scope = Public, Description = 54686520626C756520636F6D706F6E656E74206F66206120636F6C6F72206C69746572616C2E
	#tag EndConstant

	#tag Constant, Name = TOKEN_COLOR_PREFIX, Type = String, Dynamic = False, Default = \"colorPrefix", Scope = Public, Description = 5573656420666F722074686520602663602070726566697820696E20436F6C6F72206C69746572616C732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ESCAPE, Type = String, Dynamic = False, Default = \"escape", Scope = Public, Description = 5573656420666F72206573636170652073657175656E6365732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_GREEN_COMPONENT, Type = String, Dynamic = False, Default = \"colorGreen", Scope = Public, Description = 54686520677265656E20636F6D706F6E656E74206F66206120636F6C6F72206C69746572616C2E
	#tag EndConstant

	#tag Constant, Name = TOKEN_PRAGMA, Type = String, Dynamic = False, Default = \"pragma", Scope = Public, Description = 5573656420666F722074686520707261676D61206B6579776F72642E
	#tag EndConstant

	#tag Constant, Name = TOKEN_RED_COMPONENT, Type = String, Dynamic = False, Default = \"colorRed", Scope = Public, Description = 5468652072656420636F6D706F6E656E74206F66206120636F6C6F72206C69746572616C2E
	#tag EndConstant


	#tag Enum, Name = XojoKeywords, Flags = &h0, Description = 586F6A6F2773206B6579776F7264732E
		AddHandler_
		  AddressOf_
		  Array_
		  As_
		  Assigns_
		  Break_
		  ByRef_
		  ByVal_
		  Call_
		  Case_
		  Catch_
		  Class_
		  Const_
		  Continue_
		  CType_
		  Declare_
		  Dim_
		  Do_
		  DownTo_
		  Each_
		  Else_
		  ElseIf_
		  End_
		  Event_
		  Exception_
		  Exit_
		  Extends_
		  Finally_
		  For_
		  Function_
		  GetTypeInfo_
		  Global_
		  GoTo_
		  If_
		  Implements_
		  Inherits_
		  Interface_
		  Loop_
		  Module_
		  Next_
		  Optional_
		  ParamArray_
		  Private_
		  Property_
		  Protected_
		  Public_
		  Raise_
		  RaiseEvent_
		  Redim_
		  RemoveHandler_
		  Return_
		  Select_
		  Self_
		  Shared_
		  Static_
		  Sub_
		  Super_
		  Then_
		  Try_
		  Until_
		  Using_
		  Var_
		  While_
		Wend_
	#tag EndEnum


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
	#tag EndViewBehavior
End Class
#tag EndClass
