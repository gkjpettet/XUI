#tag Class
Protected Class XUITag
	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206172626974726172792064617461206173736F63696174656420776974682074686973207461672E
		Data As Variant
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620746869732074616720686173206120636C69636B61626C652064696E6775732028652E672E20636C6F73652069636F6E2C20646973636C6F7375726520747269616E676C6529207468656E207468657365206172652069747320626F756E64732C2072656C617469766520746F2074686520746F70206C65667420636F726E6572206F662074686520746167277320696D6167652E
		DingusBounds As Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620746869732069636F6E20686173206120636C69636B61626C652064696E6775732028652E672E206120636C6F73652069636F6E2C20646973636C6F7375726520747269616E676C652C20657463292E
		#tag Getter
			Get
			  Return DingusBounds <> Nil
			  
			End Get
		#tag EndGetter
		HasDingus As Boolean
	#tag EndComputedProperty

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
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Image"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasDingus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
