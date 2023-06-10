#tag Class
Protected Class XUICEObjoScriptFormatter
Inherits XUICEAbstractFormatter
Implements XUICEFormatter
	#tag Method, Flags = &h21, Description = 417474656D70747320746F20616464206120636F6D6D656E7420626567696E6E696E672066726F6D207468652063757272656E7420706F736974696F6E2E2052657475726E732054727565206966207375636365737366756C2E
		Private Function AddComment() As Boolean
		  /// Attempts to add a comment beginning from the current position. Returns True if successful.
		  ///
		  /// Assumes the pointer is yet to consume the opening delimiter.
		  ///
		  /// Comments start with `#` and end at the end of the line:
		  ///
		  /// ```objo
		  /// # This is comment.
		  /// var age = 40 # This is also a comment.
		  /// ```
		  
		  If Peek <> "#" Then Return False
		  
		  // Advance to the end of the line.
		  mCurrent = mLine.Characters.LastIndex + 1
		  
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_COMMENT))
		  
		  // Advance past the line end.
		  Advance(1)
		  
		  Return True
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E73756D657320616E642061646473206120686578206E756D62657220746F6B656E207374617274696E6720617420606D43757272656E74602E
		Private Sub AddHexNumberToken()
		  /// Consumes and adds a hex number token starting at `mCurrent`.
		  ///
		  /// Assumes that `mCurrent` points at the first hex digit (which has been verified to exist).
		  /// ```
		  /// 0xFF
		  ///   ^
		  /// ```
		  
		  // Advance past the `x`.
		  Advance(1)
		  
		  // Consume all hex digits.
		  While Peek.IsHexDigit
		    Call Advance
		  Wend
		  
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_NUMBER))
		  
		End Sub
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
		    mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_KEYWORD))
		    Return
		  End If
		  
		  // Must be an identifier.
		  mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_IDENTIFIER))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416464732074686520706173736564206D61746368696E672064656C696D69746572732074686520604D61746368656444656C696D6974657273602064696374696F6E61727920616E64207468652060536F727465644D61746368656444656C696D6974657273602061727261792E
		Private Sub AddMatchingDelimiters(openingDelimiter As XUICELineToken, closingDelimiter As XUICELineToken)
		  /// Adds the passed matching delimiters the `MatchedDelimiters` dictionary and 
		  /// the `SortedMatchedDelimiters` array.
		  ///
		  /// We add both delimiters as keys so we can find either.
		  
		  MatchedDelimiters.Value(openingDelimiter) = closingDelimiter
		  MatchedDelimiters.Value(closingDelimiter) = openingDelimiter
		  
		  MatchedOpeningDelimiters.Add(openingDelimiter)
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
		  /// A successful string will have separate tokens for its opening and closing delimiters.
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

	#tag Method, Flags = &h21, Description = 52657475726E732074686520666972737420746F6B656E206F6E20606C696E65602074686174206973206E6F74206120636F6D6D656E74206F72204E696C20696620746865206C696E6520746865726520617265206E6F6E652E
		Private Function FirstNonCommentToken(line As XUICELine) As XUICELineToken
		  /// Returns the first token on `line` that is not a comment or Nil if the line there are none.
		  ///
		  /// Assumes `line` is not Nil.
		  
		  If line.Tokens.Count = 0 Then Return Nil
		  
		  For Each t As XUICELineToken In line.Tokens
		    If Not IsCommentToken(t) Then Return t
		  Next t
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 536574732074686520696E64656E746174696F6E20616E6420636F6E74696E756174696F6E206C6576656C7320666F722065616368206C696E652E
		Private Sub IndentLines()
		  /// Sets the indentation and continuation levels for each line.
		  ///
		  /// Assumes `ProcessDelimiters()` has been called prior to this method.
		  
		  If mLines.Count = 0 Then Return
		  
		  // The first line is never indented.
		  mLines(0).IndentLevel = 0
		  mLines(0).IsContinuation = False
		  mLines(0).Unmatched = False
		  
		  // If there's only one line then there can be no indentation.
		  If mLines.Count = 1 Then Return
		  
		  Var previousLine As XUICELine = mLines(0)
		  For i As Integer = 1 To mLinesLastIndex
		    Var line As XUICELine = mLines(i)
		    previousLine = mLines(i - 1)
		    
		    line.IsContinuation = False
		    line.Unmatched = False
		    
		    If line.IsBlank Then
		      line.IndentLevel = previousLine.IndentLevel
		      line.IsContinuation = previousLine.IsContinuation
		      Continue
		    End If
		    
		    Var firstToken As XUICELineToken = FirstNonCommentToken(line)
		    
		    // Does this line start with a closing delimiter like `}`, `)` or `]`?.
		    If firstToken <> Nil And IsClosingDelimiter(firstToken) Then
		      If MatchedDelimiters.HasKey(firstToken) Then
		        // This line starts with a closing delimiter. Its indent level is the same as its 
		        // matching opening delimiter. `-1` as `mLines` needs an index not a line number.
		        line.IndentLevel = mLines(XUICELineToken(MatchedDelimiters.Value(firstToken)).LineNumber - 1).IndentLevel
		        SetContinuationStatus(line, LastNonCommentToken(previousLine))
		        Continue
		      Else
		        // This line starts with a closing delimiter but there is no matching opener so its indent level is 0.
		        line.Unmatched = True
		        line.IndentLevel = 0
		        SetContinuationStatus(line, LastNonCommentToken(previousLine))
		        Continue
		      End If
		    End If
		    
		    // Does the previous line end with a block opening brace (`{`)?
		    Var previousLineLastToken As XUICELineToken = LastNonCommentToken(previousLine)
		    If previousLineLastToken <> Nil And IsLCurly(previousLineLastToken) Then
		      // The line above ends with a left curly brace delimiter.
		      line.IndentLevel = previousLine.IndentLevel + 1
		      SetContinuationStatus(line, previousLineLastToken)
		      Continue
		    End If
		    
		    // Does the previous line end with a closing delimiter like `}`, `)` or `]`?
		    If previousLineLastToken <> Nil And IsClosingDelimiter(previousLineLastToken) Then
		      If MatchedDelimiters.HasKey(previousLineLastToken) Then
		        // This line's indent is the same as the line containing the matching opening delimiter.
		        Var opener As XUICELineToken = MatchedDelimiters.Value(previousLineLastToken)
		        line.IndentLevel = mLines(opener.LineNumber - 1).IndentLevel
		        SetContinuationStatus(line, previousLineLastToken)
		        Continue
		      Else
		        // The line above ends with a closing delimiter but there is no matching opener so its indent level is
		        // the same as the line above.
		        line.Unmatched = True
		        line.IndentLevel = previousLine.IndentLevel
		        SetContinuationStatus(line, previousLineLastToken)
		        Continue
		      End If
		    End If
		    
		    // If this line ends with an opening delimiter but has no matching closing delimiter then it is unmatched.
		    Var lastToken As XUICELineToken = LastNonCommentToken(line)
		    If lastToken <> Nil And IsOpeningDelimiter(lastToken) And Not MatchedDelimiters.HasKey(lastToken) Then
		      line.Unmatched = True
		    End If
		    
		    // Just a regular line.
		    line.IndentLevel = previousLine.IndentLevel
		    SetContinuationStatus(line, previousLineLastToken)
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206F66204F626A6F5363726970742773206B6579776F726473202F20726573657276656420776F7264732E
		Private Function InitialiseKeywordsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary of ObjoScript's keywords / reserved words.
		  
		  Var d As Dictionary = ParseJSON("{}") // Case-sensitive hack.
		  
		  d.Value("and")         = Nil
		  d.Value("as")          = Nil
		  d.Value("assert")      = Nil
		  d.Value("breakpoint")  = Nil
		  d.Value("case")        = Nil
		  d.Value("class")       = Nil
		  d.Value("continue")    = Nil
		  d.Value("constructor") = Nil
		  d.Value("do")          = Nil
		  d.Value("else")        = Nil
		  d.Value("exit")        = Nil
		  d.Value("export")      = Nil
		  d.Value("false")       = Nil
		  d.Value("for")         = Nil
		  d.Value("foreach")     = Nil
		  d.Value("foreign")     = Nil
		  d.Value("function")    = Nil
		  d.Value("if")          = Nil
		  d.Value("import")      = Nil
		  d.Value("in")          = Nil
		  d.Value("is")          = Nil
		  d.Value("loop")        = Nil
		  d.Value("not")         = Nil
		  d.Value("nothing")     = Nil
		  d.Value("or")          = Nil
		  d.Value("return")      = Nil
		  d.Value("static")      = Nil
		  d.Value("super")       = Nil
		  d.Value("switch")      = Nil
		  d.Value("then")        = Nil
		  d.Value("this")        = Nil
		  d.Value("true")        = Nil
		  d.Value("until")       = Nil
		  d.Value("var")         = Nil
		  d.Value("while")       = Nil
		  d.Value("xor")         = Nil
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5472756520696620607460206973206120636C6F73696E672064656C696D69746572206C696B6520607D602C20602960206F7220605D602E
		Private Function IsClosingDelimiter(t As XUICELineToken) As Boolean
		  /// True if `t` is a closing delimiter like `}`, `)` or `]`.
		  ///
		  /// Assumes `t` is not Nil.
		  
		  If t.Type <> XUICELineToken.TYPE_OPERATOR Then Return False
		  
		  Select Case t.LookupData("delimiterType", XUICEDelimiter.Types.None)
		  Case XUICEDelimiter.Types.RCurly, XUICEDelimiter.Types.RParen, XUICEDelimiter.Types.RSquare
		    Return True
		  Else
		    Return False
		  End Select
		  
		End Function
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

	#tag Method, Flags = &h21, Description = 54727565206966206074602069732061206C656674206375726C7920627261636B65742E
		Private Function IsLCurly(t As XUICELineToken) As Boolean
		  /// True if `t` is a left curly bracket.
		  ///
		  /// Assumes `t` is not Nil.
		  
		  If t.Type <> XUICELineToken.TYPE_OPERATOR Then Return False
		  
		  Return t.LookupData("delimiterType", XUICEDelimiter.Types.None) = XUICEDelimiter.Types.LCurly
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547275652069662060746020697320616E206F70656E696E672064656C696D69746572206C696B6520607B602C20602860206F7220605B602E
		Private Function IsOpeningDelimiter(t As XUICELineToken) As Boolean
		  /// True if `t` is an opening delimiter like `{`, `(` or `[`.
		  ///
		  /// Assumes `t` is not Nil.
		  
		  If t.Type <> XUICELineToken.TYPE_OPERATOR Then Return False
		  
		  Select Case t.LookupData("delimiterType", XUICEDelimiter.Types.None)
		  Case XUICEDelimiter.Types.LCurly, XUICEDelimiter.Types.LParen, XUICEDelimiter.Types.LSquare
		    Return True
		  Else
		    Return False
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206C61737420746F6B656E206F6E20606C696E65602074686174206973206E6F74206120636F6D6D656E74206F72204E696C20696620746865206C696E6520746865726520617265206E6F6E652E
		Private Function LastNonCommentToken(line As XUICELine) As XUICELineToken
		  /// Returns the last token on `line` that is not a comment or Nil if the line there are none.
		  ///
		  /// Assumes `line` is not Nil.
		  
		  If line.Tokens.Count = 0 Then Return Nil
		  
		  Var iMax As Integer = line.Tokens.LastIndex
		  For i As Integer = iMax DownTo 0
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
		  
		  Return "ObjoScript"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206E6561726573742064656C696D69746572732061742074686520676976656E20606361726574506F73602E204D6179206265204E696C2E
		Function NearestDelimitersForCaretPos(caretPos As Integer) As XUICEDelimiter
		  /// Returns the nearest delimiters at the given `caretPos`. May be Nil.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  // We iterate backwards over the delimiters starting from the last opener in the source code.
		  For i As Integer = MatchedOpeningDelimiters.LastIndex DownTo 0
		    Var opener As XUICELineToken = MatchedOpeningDelimiters(i)
		    If opener.StartAbsolute <= caretPos Then
		      // If this is matched after the caret (or not at all) then we're done.
		      If MatchedDelimiters.HasKey(opener) Then
		        Var closer As XUICELineToken = MatchedDelimiters.Value(opener)
		        If closer.StartAbsolute >= caretPos Then Return New XUICEDelimiter(opener, closer)
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
		  If c = "0" And Peek.IsExactly("x") And Peek(2).IsHexDigit Then
		    AddHexNumberToken
		    Return
		  ElseIf IsNumeric(c) Then
		    AddNumberToken
		    Return
		  End If
		  
		  // =====================================
		  // OPERATORS
		  // =====================================
		  Select Case c
		  Case ".", "=", "-", "~", "*", "/", "%", "+", "^", "<", ">", "&", "|", "?", ",", ":", ";"
		    mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_OPERATOR))
		    Return
		    
		  Case "("
		    Var t As XUICELineToken = _
		    MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "delimiterType" : XUICEDelimiter.Types.LParen)
		    mLine.Tokens.Add(t)
		    Delimiters.Add(t)
		    Return
		    
		  Case ")"
		    Var t As XUICELineToken = MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "delimiterType" : XUICEDelimiter.Types.RParen)
		    mLine.Tokens.Add(t)
		    Delimiters.Add(t)
		    Return
		    
		  Case "["
		    Var t As XUICELineToken = _
		    MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "delimiterType" : XUICEDelimiter.Types.LSquare, "canBeContinued" : True)
		    mLine.Tokens.Add(t)
		    Delimiters.Add(t)
		    Return
		    
		  Case "]"
		    Var t As XUICELineToken = MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "delimiterType" : XUICEDelimiter.Types.RSquare)
		    mLine.Tokens.Add(t)
		    Delimiters.Add(t)
		    Return
		    
		  Case "{"
		    Var t As XUICELineToken = MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "delimiterType" : XUICEDelimiter.Types.LCurly)
		    mLine.Tokens.Add(t)
		    Delimiters.Add(t)
		    Return
		    
		  Case "}"
		    Var t As XUICELineToken = MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "delimiterType" : XUICEDelimiter.Types.RCurly)
		    mLine.Tokens.Add(t)
		    Delimiters.Add(t)
		    Return
		  End Select
		  
		  // =====================================
		  // LINE CONTINUATION
		  // =====================================
		  If c = "_" Then
		    mLine.Tokens.Add(MakeGenericToken(XUICELineToken.TYPE_OPERATOR, "canBeContinued" : True))
		    Return
		  End If
		  
		  // =======================
		  // STRINGS
		  // =======================
		  If c = """" Then
		    AddStringToken
		    Return
		  End If
		  
		  // =========================
		  // KEYWORDS & IDENTIFIERS
		  // =========================
		  If c.IsASCIILetterOrUnderscore Then
		    AddIdentifierOrKeywordToken
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
		  
		  Initialise(lines, 1, False)
		  
		  ProcessDelimiters
		  
		  IndentLines
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 46696E647320746865206C6F636174696F6E73206F66206D61746368696E672064656C696D69746572732028652E673A206272616365732C20706172656E7468657365732C206574632920616E642061646473207468656D20746F20604D61746368656444656C696D6974657273602E
		Private Sub ProcessDelimiters()
		  /// Finds the locations of matching delimiters (e.g: braces, parentheses, etc) and 
		  /// adds them to `MatchedDelimiters`.
		  
		  MatchedOpeningDelimiters.RemoveAll
		  MatchedDelimiters = New Dictionary
		  
		  Var iMax As Integer = Delimiters.LastIndex
		  For i As Integer = 0 To iMax
		    Var delimiter As XUICELineToken = Delimiters(i)
		    Var type As XUICEDelimiter.Types = delimiter.LookupData("delimiterType", XUICEDelimiter.Types.None)
		    Var closingType As XUICEDelimiter.Types
		    
		    Select Case type
		    Case XUICEDelimiter.Types.LCurly
		      closingType = XUICEDelimiter.Types.RCurly
		      
		    Case XUICEDelimiter.Types.LParen
		      closingType = XUICEDelimiter.Types.RParen
		      
		    Case XUICEDelimiter.Types.LSquare
		      closingType = XUICEDelimiter.Types.RSquare
		      
		    Else
		      Continue For i
		    End Select
		    
		    // Find the matching closing delimiter (if present)
		    Var nestingLevel As Integer = 0
		    For j As Integer = i + 1 To iMax
		      Var closingDelimiter As XUICELineToken = Delimiters(j)
		      If closingDelimiter.LookupData("delimiterType", XUICEDelimiter.Types.None) = type Then
		        nestingLevel = nestingLevel + 1
		      ElseIf closingDelimiter.LookupData("delimiterType", XUICEDelimiter.Types.None) = closingType Then
		        If nestingLevel = 0 Then
		          // Found it.
		          AddMatchingDelimiters(delimiter, closingDelimiter)
		          Continue For i
		        Else
		          nestingLevel = nestingLevel - 1
		        End If
		      End If
		    Next j
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5365747320606C696E652E4973436F6E74696E756174696F6E60206261736564206F6E20746865206C61737420746F6B656E206F66207468652070726576696F7573206C696E652E
		Private Sub SetContinuationStatus(line As XUICELine, previousLineLastToken As XUICELineToken)
		  /// Sets `line.IsContinuation` based on the last token of the previous line.
		  ///
		  /// Assumes `line` is not Nil.
		  /// `previousLineLastToken` may be Nil.
		  
		  If previousLineLastToken = Nil Then
		    line.IsContinuation = False
		    Return
		  End If
		  
		  // During tokenisation, those tokens that can be continued will set their `canBeContinued` data to True.
		  line.IsContinuation = previousLineLastToken.LookupData("canBeContinued", False)
		  
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

	#tag Method, Flags = &h0, Description = 52657475726E732054727565206173207468697320666F726D617474657220737570706F72747320686967686C69676874696E67207468652064656C696D69746572732061726F756E64207468652063617265742E
		Function SupportsDelimiterHighlighting() As Boolean
		  /// Returns True as this formatter supports highlighting the delimiters around the caret.
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
		  
		  Return True
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
		  
		  // =============
		  // TOKENISE
		  // =============
		  Initialise(lines, 1)
		  
		  Delimiters.RemoveAll
		  
		  While Not AtEnd
		    NextToken
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620616C6C20746F6B656E2074797065732075736564206279207468697320666F726D61747465722E
		Function TokenTypes() As String()
		  /// Returns an array of all token types used by this formatter.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return Array(TOKEN_ESCAPE)
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A `XUICodeEditor` formatter for the [Wren][1] programming language.
		
		[1]: https://wren.io
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 4120736F72746564206172726179206F6620616C6C2064656C696D6974657220746F6B656E7320696E2074686520736F7572636520636F64652E
		Private Delimiters() As XUICELineToken
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 436173652073656E7369746976652064696374696F6E617279206F66206B6579776F7264732E204B6579203D204B6579776F72642C2056616C7565203D204E696C2E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseKeywordsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Private Keywords As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 416C6C206D6174636865642064656C696D697465727320696E2074686520736F7572636520636F64652E204B6579203D206044656C696D6974657220416020286058554943454C696E65546F6B656E60292C2056616C7565203D2044656C696D69746572206D61746368696E67206044656C696D6974657220416020286058554943454C696E65546F6B656E60292E
		Private MatchedDelimiters As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 416E206172726179206F6620616C6C206F70656E696E672064656C696D6974657273207468617420686176652061206D61746368696E6720636C6F73696E672064656C696D6974657220736F7274656420627920746865697220706F736974696F6E20696E2074686520736F7572636520636F64652028696E6465782030203D206669727374206D6174636865642064656C696D6974657220696E2074686520736F7572636520636F6465292E
		Private MatchedOpeningDelimiters() As XUICELineToken
	#tag EndProperty


	#tag Constant, Name = TOKEN_ESCAPE, Type = String, Dynamic = False, Default = \"escape", Scope = Public, Description = 5573656420666F72206573636170652073657175656E6365732E
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
	#tag EndViewBehavior
End Class
#tag EndClass
