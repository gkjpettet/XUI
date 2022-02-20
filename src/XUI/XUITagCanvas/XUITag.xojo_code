#tag Interface
Protected Interface XUITag
	#tag Method, Flags = &h0, Description = 416E79206172626974726172792064617461206173736F636961746564207769746820746869732074616720286D6179206265204E696C292E
		Function Data() As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520686569676874206F6620746865207461672E
		Function Height() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520312D6261736564206C696E65206E756D6265722074686973207461672061707065617273206F6E2E
		Function LineNumber() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520737472696E6720636F6E74656E7473206F662074686973207461672E
		Function ToString() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F662074686973207461672E
		Function Width() As Double
		  
		End Function
	#tag EndMethod


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
