#tag Class
Protected Class XUIInspectorStyle
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Initialise all ColorGroups to prevent Nil object exceptions in subclasses that don't initialise them.
		  
		  AccentColor = New ColorGroup(Color.Black, Color.Black)
		  BackgroundColor = New ColorGroup(Color.Black, Color.Black)
		  BorderColor = New ColorGroup(Color.Black, Color.Black)
		  ControlBackgroundColor = New ColorGroup(Color.Black, Color.Black)
		  ControlBorderColor = New ColorGroup(Color.Black, Color.Black)
		  FocusColor = New ColorGroup(Color.Black, Color.Black)
		  ItemDisclosureWidgetColor = New ColorGroup(Color.Black, Color.Black)
		  PlaceholderTextColor = New ColorGroup(Color.Black, Color.Black)
		  SectionBackColor = New ColorGroup(Color.Black, Color.Black)
		  SectionBorderColor = New ColorGroup(Color.Black, Color.Black)
		  SelectionColor = New ColorGroup(Color.Black, Color.Black)
		  SwitchColor = New ColorGroup(Color.Black, Color.Black)
		  TextColor = New ColorGroup(Color.Black, Color.Black)
		  TextFieldCaptionBackgroundColor = New ColorGroup(Color.Black, Color.Black)
		  TextFieldCaptionTextColor = New ColorGroup(Color.Black, Color.Black)
		  
		  Name = "Blank Style"
		  FontName = "System"
		  FontSize = 12
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652064656661756C74207374796C6520666F722074686520696E73706563746F722E
		Shared Function Default() As XUIInspectorStyle
		  /// Returns the default style for the inspector.
		  ///
		  /// Feel free to create your own.
		  
		  Var style As New XUIInspectorStyle
		  
		  Const ALMOST_BLACK = &c171717
		  
		  Const LIGHT_ACCENT = &c3D71E3
		  Const LIGHT_BORDER = &cCACBCB
		  Const LIGHT_CONTROL_BACKGROUND = Color.White
		  Const LIGHT_CONTROL_BORDER = &cCACBCB
		  Const LIGHT_ITEM_DISCLOSURE_WIDGET = Color.Black
		  Const LIGHT_PLACEHOLDER_GREY = &cBFBFBF
		  Const LIGHT_SECTION_BACKCOLOR = &cFDFFFF
		  Const LIGHT_SECTION_DISCLOSURE_WIDGET = Color.Black
		  Const LIGHT_SECTION_BORDER = &cCACBCB
		  Const LIGHT_SELECTION = &cA4CBFE
		  Const LIGHT_SWITCH = &cD7D7D7
		  Const LIGHT_TEXTFIELD_CAPTION_BACKGROUND = Color.White
		  
		  Const DARK_ACCENT = &c3968D4
		  Const DARK_BORDER = &c353636
		  Const DARK_CONTROL_BACKGROUND = &c262626
		  Const DARK_CONTROL_BORDER = &c353636
		  Const DARK_ITEM_DISCLOSURE_WIDGET = Color.White
		  Const DARK_PLACEHOLDER_GREY = &c535353
		  Const DARK_SECTION_DISCLOSURE_WIDGET = Color.White
		  Const DARK_SECTION_BACKCOLOR = &c1D1C1C
		  Const DARK_SECTION_BORDER = &c353636
		  Const DARK_SELECTION = &c304F77
		  Const DARK_SWITCH = &cDBDCDC
		  Const DARK_TEXTFIELD_CAPTION_BACKGROUND = &c171717
		  
		  style.AccentColor = New ColorGroup(LIGHT_ACCENT, DARK_ACCENT)
		  style.BackgroundColor = New ColorGroup(Color.White, ALMOST_BLACK)
		  style.BorderColor = New ColorGroup(LIGHT_BORDER, DARK_BORDER)
		  style.ControlBackgroundColor = New ColorGroup(LIGHT_CONTROL_BACKGROUND, DARK_CONTROL_BACKGROUND)
		  style.ControlBorderColor = New ColorGroup(LIGHT_CONTROL_BORDER, DARK_CONTROL_BORDER)
		  style.FocusColor = New ColorGroup(LIGHT_ACCENT, DARK_ACCENT)
		  style.ItemDisclosureWidgetColor = New ColorGroup(LIGHT_ITEM_DISCLOSURE_WIDGET, DARK_ITEM_DISCLOSURE_WIDGET)
		  style.PlaceholderTextColor = New ColorGroup(LIGHT_PLACEHOLDER_GREY, DARK_PLACEHOLDER_GREY)
		  style.SectionBackColor = New ColorGroup(LIGHT_SECTION_BACKCOLOR, DARK_SECTION_BACKCOLOR)
		  style.SectionBorderColor = New ColorGroup(LIGHT_SECTION_BORDER, DARK_SECTION_BORDER)
		  style.SectionDisclosureWidgetColor = New ColorGroup(LIGHT_SECTION_DISCLOSURE_WIDGET, DARK_SECTION_DISCLOSURE_WIDGET)
		  style.SelectionColor = New ColorGroup(LIGHT_SELECTION, DARK_SELECTION)
		  style.SwitchColor = New ColorGroup(LIGHT_SWITCH, DARK_SWITCH)
		  style.TextColor = New ColorGroup(Color.Black, Color.White)
		  style.TextFieldCaptionBackgroundColor = New ColorGroup(LIGHT_TEXTFIELD_CAPTION_BACKGROUND, DARK_TEXTFIELD_CAPTION_BACKGROUND)
		  style.TextFieldCaptionTextColor = New ColorGroup(Color.Black, Color.White)
		  
		  style.Name = "Default"
		  style.FontName = "System"
		  style.FontSize = 12
		  
		  Return style
		End Function
	#tag EndMethod


	#tag Note, Name = About
		`XUIInspector` is highly customisable. This class contains the various properties that can be 
		styled in an inspector that should be honoured by well behaved XUIInspectorItems.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520616363656E7420636F6C6F75722E
		AccentColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520707265666572726564206261636B67726F756E6420636F6C6F75722E
		BackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520696E73706563746F72277320626F72646572732E
		BorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F757220666F7220636F6E74726F6C732E
		ControlBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220636F6E74726F6C20626F72646572732E
		ControlBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572207573656420746F20656D7068617369736520666F6375732E
		FocusColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520666F6E7420746F207573652E
		FontName As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206465736972656420666F6E742073697A6520666F7220746578742E
		FontSize As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66206974656D20646973636C6F7375726520776964676574732E
		ItemDisclosureWidgetColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973207374796C652773206E616D652E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620706C616365686F6C64657220746578742E
		PlaceholderTextColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F662073656374696F6E2068656164696E67732E
		SectionBackColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652073656374696F6E20626F7264657220636F6C6F75722E
		SectionBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66207468652073656374696F6E20646973636C6F73757265207769646765742E
		SectionDisclosureWidgetColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652073656C656374696F6E20636F6C6F75722E
		SelectionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F722074686520636972636C6520696E206120746F67676C65207377697463682E
		SwitchColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520707265666572726564207465787420636F6C6F75722E
		TextColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620746865206F7074696F6E616C2063617074696F6E20696E20612074657874206669656C642E
		TextFieldCaptionBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220746865206F7074696F6E616C2063617074696F6E20646973706C6179656420696E2074657874206669656C64732E
		TextFieldCaptionTextColor As ColorGroup
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
			Name="BackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=false
			Group="Behavior"
			InitialValue="10"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ControlBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AccentColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SectionBackColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ControlBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SectionBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FocusColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlaceholderTextColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ItemDisclosureWidgetColor"
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
			Name="SwitchColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
