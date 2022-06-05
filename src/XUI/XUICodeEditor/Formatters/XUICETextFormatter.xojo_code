#tag Class
Protected Class XUICETextFormatter
Implements XUICEFormatter
	#tag Method, Flags = &h0, Description = 54727565206966207468697320666F726D617474657220616C6C6F777320776869746573706163652061742074686520626567696E6E696E67206F662061206C696E652E2049662046616C73652C2074686520656469746F722077696C6C207374726970206974207768656E2070617374696E6720616E642070726576656E742069742066726F6D206265696E672074797065642E
		Function AllowsLeadingWhitespace() As Boolean
		  /// True if this formatter allows whitespace at the beginning of a line. 
		  /// If False, the editor will strip it when pasting and prevent it from being typed.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320656E74697265206C696E65206973206120636F6D6D656E742E
		Function IsCommentLine(line As XUICELine) As Boolean
		  /// True if this entire line is a comment.
		  ///
		  /// There are no comment lines in the plain text formatter.
		  
		  #Pragma Unused line
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E616D65206F66207468697320666F726D61747465722E
		Function Name() As String
		  /// The name of this formatter.
		  
		  Return "Plain Text"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206E6561726573742064656C696D69746572732061742074686520676976656E20606361726574506F73602E20416C776179732072657475726E73204E696C206173207468697320666F726D617474657220646F65736E277420737570706F7274207468697320666561747572652E
		Function NearestDelimitersForCaretPos(caretPos As Integer) As XUICEDelimiter
		  /// Returns the nearest delimiters at the given `caretPos`. 
		  /// Always returns Nil as this formatter doesn't support this feature.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  #Pragma Unused caretPos
		  
		  // This formatter doesn't support matching delimiters.
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C656420706572696F646963616C6C792062792074686520656469746F722E20416E206F70706F7274756E69747920746F2070617273652074686520746F6B656E69736564206C696E65732E2057696C6C20616C776179732062652063616C6C656420616674657220746865206C696E65732068617665206265656E20746F6B656E697365642E
		Sub Parse(lines() As XUICELine)
		  /// Called periodically by the editor. An opportunity to parse the tokenised lines. 
		  /// Will always be called after the lines have been tokenised.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  #Pragma Unused lines
		  
		  // We do nothing here as this is just a simple formatter.
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57686574686572207468697320666F726D617474657220737570706F72747320686967686C69676874696E67207468652064656C696D69746572732061726F756E64207468652063617265742E20416C776179732072657475726E732046616C73652E
		Function SupportsDelimiterHighlighting() As Boolean
		  /// Whether this formatter supports highlighting the delimiters around the caret. 
		  /// Always returns False.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return False
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
		  
		  #Pragma Unused token
		  
		  // As this is a plain text formatter, there is no such thing as a comment.
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E69736573206120706F7274696F6E206F6620606C696E6573602E
		Sub Tokenise(lines() As XUICELine, firstVisibleLineNumber As Integer, lastVisibleLineNumber As Integer)
		  /// Tokenises a portion of `lines`.
		  ///
		  /// Note that we tokenise all lines, even though this method is passed the visible 
		  /// line numbers.
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
		  
		  For Each line As XUICELine In lines
		    TokeniseLine(line)
		  Next line
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 546F6B656E6973657320612073696E676C65206C696E652E
		Private Sub TokeniseLine(line As XUICELine)
		  /// Tokenises a single line.
		  
		  line.Tokens.RemoveAll
		  line.Tokens.Add(New XUICELineToken(line.Start, 0, line.Length, line.Number, "default"))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620616C6C20746F6B656E2074797065732075736564206279207468697320666F726D61747465722E
		Function TokenTypes() As String()
		  /// Returns an array of all token types used by this formatter.
		  
		  // This simple formatter only has one token type.
		  Return Array(TOKEN_DEFAULT)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A plain text formatter for the `XUICodeEditor`.
		
	#tag EndNote


	#tag Constant, Name = TOKEN_DEFAULT, Type = String, Dynamic = False, Default = \"default", Scope = Public, Description = 546865206064656661756C746020746F6B656E2028746865206F6E6C7920746F6B656E2067656E657261746564206279207468697320666F726D6174746572292E
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
