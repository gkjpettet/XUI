#tag Class
Protected Class XUICEAutocompleteData
	#tag Method, Flags = &h0, Description = 52657475726E7320746865206F7074696F6E207769746820746865206C6F6E676573742076616C75652E
		Function LongestOptionValue() As String
		  /// Returns the option with the longest value.
		  
		  Var longest As String
		  For Each option As XUICEAutocompleteOption In Options
		    If option.Value.Length > longest.Length Then
		      longest = option.Value
		    End If
		  Next option
		  
		  Return longest
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Contains the code editor autocomplete options for a given prefix. Returned by autocomplete engines when
		requested by the code editor.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 546865206C6F6E6765737420636F6D6D6F6E2070726566697820616D6F6E67737420616C6C2073756767657374696F6E73206D696E7573207468652074726967676572696E67207072656669782E
		LongestCommonPrefix As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206175746F636F6D706C657465206F7074696F6E7320617661696C61626C6520666F722074686520737065636966696564207072656669782E
		Options() As XUICEAutocompleteOption
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520707265666978207468617420746865206461746120636F6E7461696E65642077697468696E207468697320696E7374616E63652069732076616C696420666F722E
		Prefix As String
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
		#tag ViewProperty
			Name="LongestCommonPrefix"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Prefix"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
