#tag Class
Protected Class XUITagData
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(title As String, data As Variant = Nil)
		  /// Default constructor.
		  ///
		  /// - `title` is the tag text visible to the user.
		  /// - `data` is optional arbitrary data associated with the tag to be created.
		  
		  Self.Title = title
		  Self.Data = data
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		This class stores the necessary information required to create a tag.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2061726269747261727920646174612E
		Data As Variant
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207461672773207469746C652E
		Title As String
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
			Name="Title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
