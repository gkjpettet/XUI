#tag Class
Protected Class XUITagCanvasLine
	#tag Method, Flags = &h0
		Sub Constructor(lineNumber As Integer)
		  Self.Number = lineNumber
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 5468652074616773206F6E2074686973206C696E652E
		Private mTags() As XUITag
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973206C696E65277320312D6261736564206E756D6265722E
		Number As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 436F6E746967756F75732074657874206F6E2074686973206C696E65207468617420686173206E6F7420796574206265656E2070617273656420696E746F2061207461672E
		UnparsedText As String
	#tag EndProperty


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
