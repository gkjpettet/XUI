#tag Class
Protected Class XUISourceListStyle
	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577207374796C6520776974682074686520636F6C6F75727320666F72206D61634F53204D6F6E74657265792773207374796C6520736F75726365206C697374732E
		Shared Function Monterey() As XUISourceListStyle
		  /// Returns a new style with the colours for macOS Monterey's style source lists.
		  
		  Var style As New XUISourceListStyle
		  
		  // General
		  style.BackgroundColor = New ColorGroup(&cF4F4F4, &c2A2A2A)
		  style.SelectedBackgroundColor = New ColorGroup(&cD5D4D5, &c3F4141)
		  style.SelectedColor = New ColorGroup(&C474747, Color.White)
		  
		  // Items.
		  style.ItemColor = New ColorGroup(&C474747, Color.White)
		  style.DisclosureWidgetColor = New ColorGroup(&C767877, &c666566)
		  
		  // Sections.
		  style.SectionColor = New ColorGroup(&C767877, &c666566)
		  style.SectionDisclosureWidgetColor = New ColorGroup(&C767877, &c666566)
		  
		  // Widget.
		  style.WidgetColor = New ColorGroup(&CBABABA, &c666566)
		  
		  // Badges.
		  style.BadgeColor = New ColorGroup(&cE3E5E2, &c3B3B3A)
		  style.BadgeValueColor = New ColorGroup(&C7D7D7D, Color.White)
		  
		  // Drop targets.
		  style.DropTargetBackgroundColor = New ColorGroup(&C2456DA, &c2454C5)
		  style.DropTargetColor = New ColorGroup(Color.White, Color.White)
		  
		  Return style
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520736F75726365206C697374206261636B67726F756E6420636F6C6F75722E
		BackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261646765206261636B67726F756E6420636F6C6F722E
		BadgeColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520626164676527732076616C75652E
		BadgeValueColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220726567756C6172206974656D20286E6F742073656374696F6E2920646973636C6F7375726520776964676574732E
		DisclosureWidgetColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F757220666F72206974656D73207768656E20746865792061726520612076616C69642064726F70207461726765742E
		DropTargetBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207465787420636F6C6F757220666F72206974656D73207768656E20746865792061726520612076616C69642064726F70207461726765742E
		DropTargetColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7220746F2075736520666F72206974656D207469746C6520746578742E
		ItemColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F722073656374696F6E207469746C65732E
		SectionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F722073656374696F6E20646973636C6F7375726520776964676574732E
		SectionDisclosureWidgetColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F662073656C6563746564206974656D732E
		SelectedBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207465787420636F6C6F7572206F662073656C6563746564206974656D732E
		SelectedColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7220746F2075736520666F7220647261776E206974656D20776964676574732E2054686973206973206F7074696F6E616C6C79207573656420627920736F6D652072656E6465726572732E
		WidgetColor As ColorGroup
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
			Name="SectionColor"
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
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ItemColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisclosureWidgetColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SectionDisclosureWidgetColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BadgeColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BadgeValueColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropTargetBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropTargetColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WidgetColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
