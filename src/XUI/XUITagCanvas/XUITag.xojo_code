#tag Class
Protected Class XUITag
	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206172626974726172792064617461206173736F63696174656420776974682074686973207461672E
		Data As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686973207461672773206865696768742E
		#tag Getter
			Get
			  If Self.Image <> Nil Then
			    Return Self.Image.Graphics.Height
			  Else
			    Return 0
			  End If
			End Get
		#tag EndGetter
		Height As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686973207461672773207069637475726520726570726573656E746174696F6E2E
		Image As Picture
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973207461672773207469746C652E
		Title As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546869732074616727732077696474682E
		#tag Getter
			Get
			  If Self.Image <> Nil Then
			    Return Self.Image.Graphics.Width
			  Else
			    Return 0
			  End If
			End Get
		#tag EndGetter
		Width As Integer
	#tag EndComputedProperty


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
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
