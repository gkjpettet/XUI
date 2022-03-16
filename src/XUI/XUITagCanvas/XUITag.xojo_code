#tag Class
Protected Class XUITag
	#tag Method, Flags = &h0
		Sub Constructor(title As String, data As Variant)
		  Self.Title = title
		  Self.Data = data
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206162736F6C75746520626F756E6473206F662074686973207461672C2072656C617469766520746F20746865206261636B696E6720627566666572277320746F70206C65667420636F726E65722E
		Bounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206172626974726172792064617461206173736F63696174656420776974682074686973207461672E
		Data As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620746869732069636F6E20686173206120636C69636B61626C652064696E6775732028652E672E206120636C6F73652069636F6E2C20646973636C6F7375726520747269616E676C652C20657463292E
		#tag Getter
			Get
			  Return WidgetBounds <> Nil
			  
			End Get
		#tag EndGetter
		HasWidget As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686973207461672773207469746C652E
		Title As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620746869732074616720686173206120636C69636B61626C652064696E6775732028652E672E20636C6F73652069636F6E2C20646973636C6F7375726520747269616E676C6529207468656E207468657365206172652069747320626F756E64732C2072656C617469766520746F20746865206261636B696E6720627566666572277320746F70206C65667420636F726E65722E204D6179206265204E696C2E
		WidgetBounds As Rect
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
		#tag ViewProperty
			Name="HasWidget"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
