#tag Class
Protected Class XUITabBarStyle
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Ensure that all color groups are initialised to avoid Nil object exceptions.
		  // For conspicuousness we;ll set the colours to black and red.
		  
		  Me.BackgroundColor = New ColorGroup(Color.Black, Color.Red)
		  Me.DisabledTabBackgroundColor = New ColorGroup(Color.Black, Color.Red)
		  Me.DisabledTabTextColor = New ColorGroup(Color.Black, Color.Red)
		  Me.HoverTabBackgroundColor = New ColorGroup(Color.Black, Color.Red)
		  Me.HoverTabCloseColor = New ColorGroup(Color.Black, Color.Red)
		  Me.HoverTabTextColor = New ColorGroup(Color.Black, Color.Red)
		  Me.InactiveTabBackgroundColor = New ColorGroup(Color.Black, Color.Red)
		  Me.InactiveTabTextColor = New ColorGroup(Color.Black, Color.Red)
		  Me.MenuButtonBackgroundColor = New ColorGroup(Color.Black, Color.Red)
		  Me.MenuButtonBorderColor = New ColorGroup(Color.Black, Color.Red)
		  Me.MenuButtonColor = New ColorGroup(Color.Black, Color.Red)
		  Me.MenuButtonHoverBackgroundColor = New ColorGroup(Color.Black, Color.Red)
		  Me.MenuButtonHoverColor = New ColorGroup(Color.Black, Color.Red)
		  Me.SelectedTabBackgroundColor = New ColorGroup(Color.Black, Color.Red)
		  Me.SelectedTabBottomBorderColor = New ColorGroup(Color.Black, Color.Red)
		  Me.SelectedTabTextColor = New ColorGroup(Color.Black, Color.Red)
		  Me.SelectedTabTopBorderColor = New ColorGroup(Color.Black, Color.Red)
		  Me.TabBorderColor = New ColorGroup(Color.Black, Color.Red)
		  Me.TabCloseColor = New ColorGroup(Color.Black, Color.Red)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E732061206E6577207374796C652074686174206D696D696373207468652074616273207365656E20696E205361666172692E
		Shared Function Safari() As XUITabBarStyle
		  /// Creates and returns a new style that mimics the tabs seen in Safari.
		  
		  Var style As New XUITabBarStyle
		  
		  style.Name = "Safari"
		  
		  style.BackgroundColor = New ColorGroup(&cEFEFEF, &c111111)
		  style.DisabledTabBackgroundColor = New ColorGroup(&cEFEFEF, &c111111)
		  style.DisabledTabTextColor = New ColorGroup(&c606060, &c7F7F7F)
		  style.HoverTabBackgroundColor = New ColorGroup(&cDDDFDF, &c181818)
		  style.HoverTabCloseColor = New ColorGroup(&c626262, &c868686)
		  style.HoverTabTextColor = New ColorGroup(&c626262, &c868686)
		  style.InactiveTabBackgroundColor = New ColorGroup(&cEFEFEF, &c111111)
		  style.InactiveTabTextColor = New ColorGroup(&c606060, &c7F7F7F)
		  style.MenuButtonBackgroundColor = New ColorGroup(Color.White, &c1D1D1D)
		  style.MenuButtonBorderColor = New ColorGroup(&cD7D9D9, &c2A2A2A)
		  style.MenuButtonColor = New ColorGroup(&c606060, &c7F7F7F)
		  style.MenuButtonHoverBackgroundColor = New ColorGroup(Color.White, &c1D1D1D)
		  style.MenuButtonHoverColor = New ColorGroup(&c2E2E2E, Color.White)
		  style.SelectedTabBackgroundColor = New ColorGroup(Color.White, &c1D1D1D)
		  style.SelectedTabBottomBorderColor = New ColorGroup(&cD7D9D9, &c2A2A2A)
		  style.SelectedTabTextColor = New ColorGroup(&c606060, Color.White)
		  style.SelectedTabTopBorderColor = New ColorGroup(&cD7D9D9, &c2A2A2A)
		  style.TabBorderColor = New ColorGroup(&cD7D9D9, &c2A2A2A)
		  style.TabCloseColor = New ColorGroup(&c626262, &c868686)
		  
		  Return style
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520746162206261722773206261636B67726F756E6420636F6C6F75722E2049742069732076697369626C65207768656E20746162732061726520647261676765642061726F756E642E
		BackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		DisabledTabBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		DisabledTabTextColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		FontName As String = "System"
	#tag EndProperty

	#tag Property, Flags = &h0
		FontSize As Integer = 12
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865206261636B67726F756E64206F662074686520746162206265696E6720686F7665726564206F7665722E
		HoverTabBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F72206F662074686520636C6F73652069636F6E207768656E20686F7665726564206F7665722E
		HoverTabCloseColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865207465787420696E2074686520746162206265696E6720686F7665726564206F7665722E
		HoverTabTextColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620696E61637469766520746162732E
		InactiveTabBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207465787420636F6C6F757220666F7220696E61637469766520746162732E
		InactiveTabTextColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620746865206F7074696F6E616C2074616220626172206D656E7520627574746F6E2E
		MenuButtonBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520626F7264657220636F6C6F7572206F6620746865206F7074696F6E616C2074616220626172206D656E7520627574746F6E2E
		MenuButtonBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620746865206D656E7520627574746F6E20686173206E6F2069636F6E2C20746869732069732074686520636F6C6F7572206F662074686520647261776E2069636F6E2E
		MenuButtonColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620746865206F7074696F6E616C2074616220626172206D656E7520627574746F6E207768656E20686F7665726564206F7665722E
		MenuButtonHoverBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620746865206D656E7520627574746F6E20686173206E6F2069636F6E2C20746869732069732074686520636F6C6F7572206F662074686520647261776E2069636F6E207768656E20686F7665726564206F7665722E
		MenuButtonHoverColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 416E206F7074696F6E616C206E616D6520666F722074686973207374796C652E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectedTabBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectedTabBottomBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectedTabTextColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		SelectedTabTopBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		TabBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F72206F662074686520636C6F73652069636F6E207768656E206E6F7420686F7665726564206F7665722E
		TabCloseColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206172626974726172792064617461206173736F63696174656420776974682074686973207374796C652E
		Tag As Variant
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
			Name="SelectedTabBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedTabTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InactiveTabBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InactiveTabTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisabledTabBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisabledTabTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedTabBottomBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=false
			Group="Behavior"
			InitialValue="System"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=false
			Group="Behavior"
			InitialValue="12"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverTabBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverTabTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverTabCloseColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabCloseColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuButtonBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuButtonBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuButtonColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuButtonHoverBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuButtonHoverColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedTabTopBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
