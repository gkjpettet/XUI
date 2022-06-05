#tag Interface
Protected Interface XUICEFormatter
	#tag Method, Flags = &h0, Description = 54727565206966207468697320666F726D617474657220616C6C6F777320776869746573706163652061742074686520626567696E6E696E67206F662061206C696E652E2049662046616C73652C2074686520656469746F722077696C6C207374726970206974207768656E2070617374696E6720616E642070726576656E742069742066726F6D206265696E672074797065642E
		Function AllowsLeadingWhitespace() As Boolean
		  
		End Function
	#tag EndMethod

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

	#tag Method, Flags = &h0, Description = 43616C6C656420706572696F646963616C6C792062792074686520656469746F722E20416E206F70706F7274756E69747920746F2070617273652074686520746F6B656E69736564206C696E65732E2057696C6C20616C776179732062652063616C6C656420616674657220746865206C696E65732068617665206265656E20746F6B656E697365642E
		Sub Parse(lines() As XUICELine)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320666F726D617474657220737570706F72747320686967686C69676874696E67207468652064656C696D69746572732061726F756E64207468652063617265742E
		Function SupportsDelimiterHighlighting() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320666F726D617474657220686967686C696768747320756E6D61746368656420626C6F636B732E
		Function SupportsUnmatchedBlockHighlighting() As Boolean
		  
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


	#tag Note, Name = About
		The tokenisation and syntax manipulation of text within the code editor is handled by 
		_formatters_. A formatter is a class that implements this interface. In theory, the 
		code editor can handle the styling of any language with the appropriate formatter.
		
	#tag EndNote


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
