#tag Class
Protected Class XUITagAutocompleteOption
	#tag Method, Flags = &h0, Description = 52657475726E73206120636C6F6E65206F662074686973206F7074696F6E2E204E6F746520746861742060546167446174612E44617461602077696C6C206F6E6C79206265207368616C6C6F7720636C6F6E65642E
		Function Clone() As XUITagAutocompleteOption
		  /// Returns a clone of this option. Note that `TagData.Data` will only be shallow cloned.
		  
		  Return New XUITagAutocompleteOption(Self.Value, Self.TagData)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(value As String, tagData As XUITagData)
		  /// Default constructor.
		  ///
		  /// - `value` is the string that will be visible to the user in the autocomplete popup.
		  /// - `tagData` is the data required to create a tag instance.
		  
		  Self.Value = value
		  Self.TagData = tagData
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a single autocomplete option for the tag canvas.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 546865206461746120726571756972656420746F206372656174652061207461672E
		TagData As XUITagData
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
