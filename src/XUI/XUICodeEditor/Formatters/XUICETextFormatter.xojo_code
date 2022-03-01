#tag Class
Protected Class XUICETextFormatter
Implements XUICEFormatter
	#tag Method, Flags = &h0, Description = 52657475726E7320746865206E6561726573742064656C696D69746572732061742074686520676976656E205B6361726574506F735D2E204D6179206265204E696C2E
		Function NearestDelimitersForCaretPos(caretPos As Integer) As XUICEDelimiter
		  /// Returns the nearest delimiters at the given [caretPos]. May be Nil.
		  ///
		  /// Part of the XUICEFormatter interface.
		  
		  #Pragma Unused caretPos
		  
		  // This formatter doesn't support matching delimiters.
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E6973657320616E206172726179206F66206C696E65732E
		Sub Tokenise(lines() As XUICELine, firstVisibleLineNumber As Integer, lastVisibleLineNumber As Integer)
		  /// Tokenises an array of lines.
		  ///
		  /// Part of the XUICEFormatter interface.
		  
		  #Pragma Unused firstVisibleLineNumber
		  #Pragma Unused lastVisibleLineNumber
		  
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


	#tag Constant, Name = TOKEN_DEFAULT, Type = String, Dynamic = False, Default = \"default", Scope = Public
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
