#tag Class
Protected Class XUICEAutocompleteOption
	#tag Method, Flags = &h0, Description = 52657475726E73206120636C6F6E65206F662074686973206F7074696F6E2E204E6F74652074686174206044617461602077696C6C206F6E6C79206265207368616C6C6F7720636C6F6E65642E
		Function Clone() As XUICEAutocompleteOption
		  /// Returns a clone of this option. Note that `Data` will only be shallow cloned.
		  
		  Return New XUICEAutocompleteOption(Self.Value, Self.Data)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E6577206175746F636F6D706C657465206F7074696F6E20776974682074686520757365722D666163696E67206076616C75656020616E64206F7074696F6E616C206064617461602E
		Sub Constructor(value As String, data As Variant = Nil)
		  /// Constructs a new autocomplete option with the user-facing `value` and optional `data`.
		  
		  Self.Value = value
		  Self.Data = data
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a single autocomplete option.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 41726269747261727920646174612E
		Data As Variant
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520737472696E672076697369626C6520746F20746865207573657220696E20746865206175746F636F6D706C6574696F6E206C6973742E
		Value As String
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
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
