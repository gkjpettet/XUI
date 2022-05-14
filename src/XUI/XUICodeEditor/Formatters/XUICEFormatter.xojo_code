#tag Interface
Protected Interface XUICEFormatter
	#tag Method, Flags = &h0, Description = 54727565206966207468697320656E74697265206C696E65206973206120636F6D6D656E742E
		Function IsCommentLine(line As XUICELine) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E616D65206F66207468697320666F726D61747465722E
		Function Name() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206E6561726573742064656C696D69746572732061742074686520676976656E20606361726574506F73602E204D6179206265204E696C2E
		Function NearestDelimitersForCaretPos(caretPos As Integer) As XUICEDelimiter
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320666F726D617474657220737570706F72747320686967686C69676874696E67207468652064656C696D69746572732061726F756E64207468652063617265742E
		Function SupportsDelimiterHighlighting() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 547275652069662060746F6B656E6020697320636F6E7369646572656420746F206265206120636F6D6D656E742E
		Function TokenIsComment(token As XUICELineToken) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E69736573206120706F7274696F6E206F6620616E206172726179206F66206C696E65732E
		Sub Tokenise(lines() As XUICELine, firstVisibleLineNumber As Integer, lastVisibleLineNumber As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E6973657320616E206172726179206F66206C696E65732E
		Sub TokeniseAll(lines() As XUICELine)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620616C6C20746F6B656E2074797065732075736564206279207468697320666F726D61747465722E
		Function TokenTypes() As String()
		  
		End Function
	#tag EndMethod


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
End Interface
#tag EndInterface
