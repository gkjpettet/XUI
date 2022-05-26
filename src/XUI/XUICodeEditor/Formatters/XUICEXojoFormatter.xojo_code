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
		    
		    mLine.Tokens.Add(MakeToken(TOKEN_COMMENT))
		    
		    // Advance past the line end.
		    Advance(1)
		    
		    Return True
		  End If
		  
		  ' If Peek(2) = "/" Then
		  ' // ====================
		  ' // SINGLE LINE COMMENT
		  ' // ====================
		  ' // Advance to the end of the line.
		  ' mCurrent = mLine.Characters.LastIndex + 1
		  ' 
		  ' mLine.Tokens.Add(MakeToken(TOKEN_COMMENT))
		  ' 
		  ' // Advance past the line end.
		  ' Advance(1)
		  ' 
		  ' Return True
		  ' End If
		  ' 
		  ' Return False
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
		    mLine.Tokens.Add(MakeToken(TOKEN_KEYWORD))
		    Return
		  End If
		  
		  // Must be an identifier.
		  mLine.Tokens.Add(MakeToken(TOKEN_IDENTIFIER))
		  
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
		  
		  mLine.Tokens.Add(MakeToken(TOKEN_NUMBER))
		  
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
		  tokens.Add(MakeToken(TOKEN_STRING))
		  
		  // The token now starts beyond the opening delimiter.
		  mTokenStartLocal = mCurrent
		  
		  Var terminated As Boolean = False
		  While Not AtLineEnd
		    
		    Select Case Peek
		    Case """"
		      If Peek(2) <> """" Then
		        // This is the end of the string.
		        Advance
		        tokens.Add(MakeToken(TOKEN_STRING))
		        terminated = True
		        Exit
		      Else
		        // Found `""` which is an escaped double quote.
		        // Create a string token up to (but not including) the `""`.
		        tokens.Add(MakeToken(TOKEN_STRING))
		        
		        mTokenStartLocal = mCurrent
		        
		        // Move past the two double quotes.
		        Advance(2)
		        
		        // Now add the `""` escaped token.
		        tokens.Add(MakeToken(TOKEN_ESCAPE))
		        
		        mTokenStartLocal = mCurrent
		      End If
		      
		    Else
		      Advance
		    End Select
		  Wend
		  
		  If Not terminated Then
		    // Just add an error token.
		    mTokenStartLocal = startLocal
		    mLine.Tokens.Add(MakeToken(TOKEN_ERROR))
		    Return
		    
		  Else
		    // Add the tokens to the line.
		    For Each token As XUICELineToken In tokens
		      mLine.Tokens.Add(token)
		    Next token
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320656E74697265206C696E65206973206120636F6D6D656E742E
		Function IsCommentLine(line As XUICELine) As Boolean
		  /// True if this entire line is a comment.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  #Pragma Warning "TODO"
		  
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
		  
		  #Pragma Warning "TODO"
		  
		  
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
		    mLine.Tokens.Add(MakeToken(TOKEN_OPERATOR))
		    Return
		    
		  Case "("
		    Var t As XUICELineToken = _
		    MakeToken(TOKEN_OPERATOR, "delimiterType" : XUICEDelimiter.Types.LParen)
		    mLine.Tokens.Add(t)
		    Delimiters.Add(t)
		    Return
		    
		  Case ")"
		    Var t As XUICELineToken = MakeToken(TOKEN_OPERATOR, "delimiterType" : XUICEDelimiter.Types.RParen)
		    mLine.Tokens.Add(t)
		    Delimiters.Add(t)
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
		      #Pragma Warning "TODO: Color literals"
		      
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
		  mLine.Tokens.Add(MakeToken(TOKEN_ERROR))
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

	#tag Method, Flags = &h0, Description = 547275652069662060746F6B656E6020697320636F6E7369646572656420746F206265206120636F6D6D656E742E
		Function TokenIsComment(token As XUICELineToken) As Boolean
		  /// True if `token` is considered to be a comment.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  #Pragma Warning "TODO"
		  
		  
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
		  
		  #Pragma Warning "TODO: Implement parsing / delimiter computation"
		  
		  If lines.Count = 0 Then Return
		  
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
		  
		  #Pragma Warning "TODO: Ensure all are added"
		  
		  Return Array( _
		  TOKEN_COMMENT, _
		  TOKEN_DEFAULT, _
		  TOKEN_ERROR, _
		  TOKEN_ESCAPE, _
		  TOKEN_IDENTIFIER, _
		  TOKEN_KEYWORD, _
		  TOKEN_NUMBER, _
		  TOKEN_OPERATOR, _
		  TOKEN_STRING _
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
		  mLine.Tokens.Add(MakeToken(TOKEN_NUMBER))
		  
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
		  mLine.Tokens.Add(MakeToken(TOKEN_NUMBER))
		  
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
		  mLine.Tokens.Add(MakeToken(TOKEN_NUMBER))
		  
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
		  mLine.Tokens.Add(MakeToken(TOKEN_STRING))
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 4120736F72746564206172726179206F6620616C6C2064656C696D6974657220746F6B656E7320696E2074686520736F7572636520636F64652E
		Private Delimiters() As XUICELineToken
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 4361736520696E73656E7369746976652064696374696F6E617279206F66206B6579776F7264732E204B6579203D204B6579776F72642C2056616C7565203D204E696C2E
		#tag Getter
			Get
			  Static d As New Dictionary( _
			  "AddHandler" : Nil, _
			  "AddressOf" : Nil, _
			  "Array" : Nil, _
			  "As" : Nil, _
			  "Assigns" : Nil, _
			  "Break" : Nil, _
			  "ByRef" : Nil, _
			  "ByVal" : Nil, _
			  "Call" : Nil, _
			  "Catch" : Nil, _
			    "Class" : Nil, _
			      "Const" : Nil, _
			      "Continue" : Nil, _
			      "CType" : Nil, _
			      "Declare" : Nil, _
			      "Dim" : Nil, _
			      "Do" : Nil, _
			      "Loop" : Nil, _
			      "DownTo" : Nil, _
			      "Else" : Nil, _
			        "ElseIf" : Nil, _
			          "End" : Nil, _
			          "Event" : Nil, _
			  "Exception" : Nil, _
			    "Exit" : Nil, _
			    "Extends" : Nil, _
			  "Finally" : Nil, _
			    "For" : Nil, _
			    "Next" : Nil, _
			    "Each" : Nil, _
			    "Function" : Nil, _
			      "GetTypeInfo" : Nil, _
			      "Global" : Nil, _
			      "GoTo" : Nil, _
			      "If" : Nil, _
			        "Then" : Nil, _
			        "Implements" : Nil, _
			        "Inherits" : Nil, _
			        "Interface" : Nil, _
			          "Module" : Nil, _
			            "Optional" : Nil, _
			            "ParamArray" : Nil, _
			            "Private" : Nil, _
			            "Property" : Nil, _
			            "Protected" : Nil, _
			            "Public" : Nil, _
			            "Raise" : Nil, _
			            "RaiseEvent" : Nil, _
			            "Redim" : Nil, _
			            "RemoveHandler" : Nil, _
			            "Return" : Nil, _
			            "Select" : Nil, _
			            "Case" : Nil, _
			              "Self" : Nil, _
			              "Shared" : Nil, _
			              "Static" : Nil, _
			              "Sub" : Nil, _
			                "Super" : Nil, _
			                "Try" : Nil, _
			                  "Until" : Nil, _
			                  "Using" : Nil, _
			                  "Var" : Nil, _
			                  "While" : Nil, _
			                  "Wend" : Nil _
			                  )
			                  
			                  Return d
			                  
			End Get
		#tag EndGetter
		Private Keywords As Dictionary
	#tag EndComputedProperty


	#tag Constant, Name = TOKEN_COMMENT, Type = String, Dynamic = False, Default = \"comment", Scope = Public, Description = 5573656420666F7220636F6D6D656E74732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_DEFAULT, Type = String, Dynamic = False, Default = \"default", Scope = Public, Description = 5573656420666F722064656661756C7420746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ERROR, Type = String, Dynamic = False, Default = \"error", Scope = Public, Description = 5573656420666F72206572726F72732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ESCAPE, Type = String, Dynamic = False, Default = \"escape", Scope = Public, Description = 5573656420666F72206573636170652073657175656E6365732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_IDENTIFIER, Type = String, Dynamic = False, Default = \"identifier", Scope = Public, Description = 5573656420666F72206964656E746966696572732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_KEYWORD, Type = String, Dynamic = False, Default = \"keyword", Scope = Public, Description = 5573656420666F72206B6579776F7264732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_NUMBER, Type = String, Dynamic = False, Default = \"number", Scope = Public, Description = 5573656420666F72206E756D626572206C69746572616C732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_OPERATOR, Type = String, Dynamic = False, Default = \"operator", Scope = Public, Description = 5573656420666F72206F70657261746F72732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_STRING, Type = String, Dynamic = False, Default = \"string", Scope = Public, Description = 5573656420666F7220737472696E67732E
	#tag EndConstant


End Class
#tag EndClass
