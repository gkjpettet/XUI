#tag Class
Protected Class XUISourceListStyle
	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577207374796C6520776974682074686520636F6C6F75727320666F72206D61634F53207374796C6520736F75726365206C697374732E
		Shared Function MacOS() As XUISourceListStyle
		  /// Returns a new style with the colours for macOS style source lists.
		  
		  Var style As New XUISourceListStyle
		  
		  // General
		  style.BackgroundColor = New ColorGroup(Color.FromString("&h00F6F6F6"), Color.FromString("&h00383838"))
		  style.SelectedColor = New ColorGroup(Color.FromString("&h00DDDDDD"), Color.FromString("&h00515151"))
		  
		  // Items.
		  style.ItemColor = New ColorGroup(Color.FromString("&h00474747"), Color.FromString("&h00EAEBEB"))
		  style.DisclosureWidgetColor = New ColorGroup(Color.FromString("&h00767877"), Color.FromString("&h00B3B4B4"))
		  
		  // Sections.
		  style.SectionColor = New ColorGroup(Color.FromString("&h00B6B6B6"), Color.FromString("&h00797979"))
		  style.SectionDisclosureWidgetColor = _
		  New ColorGroup(Color.FromString("&h00BABABA"), Color.FromString("&h00707070"))
		  
		  Return style
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520736F75726365206C697374206261636B67726F756E6420636F6C6F75722E
		BackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220726567756C6172206974656D20286E6F742073656374696F6E2920646973636C6F7375726520776964676574732E
		DisclosureWidgetColor As ColorGroup
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
		SelectedColor As ColorGroup
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
			Name="SelectedColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
