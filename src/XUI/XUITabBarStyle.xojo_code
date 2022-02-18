#tag Class
Protected Class XUITabBarStyle
	#tag Property, Flags = &h0
		ActiveTabBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		ActiveTabBorderColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		ActiveTabHasBottomBorder As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2069662074686520616374697665207461622073686F756C642064726177206120626F74746F6D20626F72646572207468656E2069742077696C6C20626520746869636B6572207468616E2074686520626F74746F6D20626F72646572206F6E20696E61637469766520616E642064697361626C656420746162732E
		ActiveTabHasThickBottomBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2069662074686520616374697665207461622073686F756C642064726177206120746F7020626F72646572207468656E2069742077696C6C20626520746869636B6572207468616E2074686520746F7020626F72646572206F6E20696E61637469766520616E642064697361626C656420746162732E
		ActiveTabHasThickTopBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		ActiveTabHasTopBorder As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652074657874206F662074686520616374697665207461622073686F756C6420626520626F6C642E
		ActiveTabTextBold As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		ActiveTabTextColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652074657874206F662074686520616374697665207461622073686F756C64206265206974616C69632E
		ActiveTabTextItalic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		BackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		DisabledTabBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652074657874206F66207468652064697361626C6564207461622073686F756C6420626520626F6C642E
		DisabledTabTextBold As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		DisabledTabTextColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652074657874206F66207468652064697361626C6564207461622073686F756C64206265206974616C69632E
		DisabledTabTextItalic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		FontName As String = "System"
	#tag EndProperty

	#tag Property, Flags = &h0
		FontSize As Integer = 12
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F20706164207468652074616220636F6E74656E7473202863617074696F6E2C2069636F6E2C20636C6F73652069636F6E2920686F72697A6F6E74616C6C7920746F20746865206C65667420616E642072696768742E
		HorizontallPadding As Integer = 10
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865206261636B67726F756E64206F662074686520746162206265696E6720686F7665726564206F7665722E
		HoverTabBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F72206F662074686520636C6F73652069636F6E207768656E20686F7665726564206F7665722E
		HoverTabCloseColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652074657874206F662074686520746162206265696E6720686F7665726564206F7665722073686F756C6420626520626F6C642E
		HoverTabTextBold As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865207465787420696E2074686520746162206265696E6720686F7665726564206F7665722E
		HoverTabTextColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652074657874206F662074686520746162206265696E6720686F7665726564206F7665722073686F756C64206265206974616C69632E
		HoverTabTextItalic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620696E61637469766520746162732E
		InactiveTabBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652074657874206F662074686520696E616374697665207461622073686F756C6420626520626F6C642E
		InactiveTabTextBold As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207465787420636F6C6F757220666F7220696E61637469766520746162732E
		InactiveTabTextColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652074657874206F662074686520696E616374697665207461622073686F756C64206265206974616C69632E
		InactiveTabTextItalic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		TabBorderColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F72206F662074686520636C6F73652069636F6E207768656E206E6F7420686F7665726564206F7665722E
		TabCloseColor As Color
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
			Name="ActiveTabBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveTabTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InactiveTabBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InactiveTabTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisabledTabBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisabledTabTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveTabBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveTabHasBottomBorder"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveTabHasTopBorder"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
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
			Name="ActiveTabTextBold"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InactiveTabTextBold"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisabledTabTextBold"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveTabTextItalic"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InactiveTabTextItalic"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisabledTabTextItalic"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HorizontallPadding"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveTabHasThickTopBorder"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveTabHasThickBottomBorder"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverTabBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverTabTextBold"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverTabTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverTabTextItalic"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverTabCloseColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
