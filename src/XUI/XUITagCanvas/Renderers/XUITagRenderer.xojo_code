#tag Interface
Protected Interface XUITagRenderer
	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E732061206E6577207461672077697468207468652073706563696669656420646174612E
		Function CreateTag(tagData As XUITagData, g As Graphics) As XUITag
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Owner() As XUITagCanvas
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520686569676874206F662061207461672E
		Function TagHeight(g As Graphics) As Integer
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Responsible for rendering tag data into a visible tag.
		
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
