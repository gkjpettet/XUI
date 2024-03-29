#tag Class
Protected Class XUITagCanvasStyle
	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577207374796C6520776974682074686520636F6C6F75727320666F72206D61634F53204D6F6E7465726579207374796C6520746167732E
		Shared Function Monterey() As XUITagCanvasStyle
		  /// Returns a new style with the colours for macOS Monterey style tags.
		  
		  Var style As New XUITagCanvasStyle
		  
		  style.Name = "Monterey"
		  
		  // Autocomplete.
		  style.HasAutocompletePopupBorder = True
		  style.AutocompleteOptionColor = New ColorGroup(Color.Black, Color.White)
		  style.AutocompletePopupBackgroundColor = New ColorGroup(&cE6E7E7, &c262626)
		  style.AutocompletePopupBorderColor = New ColorGroup(&cB9BBBB, Color.Black)
		  style.SelectedAutocompleteOptionBackgroundColor = New ColorGroup(&c002BC3, &c356FFF)
		  style.SelectedAutocompleteOptionColor = New ColorGroup(Color.White)
		  
		  // General.
		  style.BackgroundColor = New ColorGroup(Color.White, &c171717)
		  style.BorderColor = New ColorGroup(&cDDDFDF, &c282828)
		  style.CaretColor = New ColorGroup(Color.Black, Color.White)
		  style.TagBackgroundColor = New ColorGroup(&cAFCCFF, &c192D4F)
		  style.TagBorderColor = New ColorGroup(&cAFCCFF, &c192D4F)
		  style.TagTextColor = New ColorGroup(Color.Black, Color.White)
		  style.WidgetColor = New ColorGroup(Color.Black, Color.White)
		  
		  // Font.
		  #If TargetWindows
		    style.FontSize = 14
		  #Else
		    style.FontSize = 0
		  #EndIf
		  style.FontColor = New ColorGroup(Color.Black, Color.White)
		  
		  Return style
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577207374796C6520776974682074686520636F6C6F75727320666F722057696E646F7773207374796C6520746167732E
		Shared Function Windows() As XUITagCanvasStyle
		  /// Returns a new style with the colours for Windows style tags.
		  
		  Var style As New XUITagCanvasStyle
		  
		  style.Name = "Windows 11"
		  
		  // General.
		  style.BackgroundColor = New ColorGroup(Color.White, &c303030)
		  style.BorderColor = New ColorGroup(&cECECEC, &c303030)
		  style.CaretColor = New ColorGroup(Color.Black, Color.White)
		  style.TagBackgroundColor = New ColorGroup(&cE4E9EE, &c1E2327)
		  style.TagBorderColor = New ColorGroup(Color.Black, &c1E2327)
		  style.TagTextColor = New ColorGroup(Color.Black, Color.White)
		  style.WidgetColor = New ColorGroup(Color.Black, Color.White)
		  
		  // Autocomplete.
		  style.HasAutocompletePopupBorder = True
		  style.AutocompleteOptionColor = New ColorGroup(Color.Black, Color.White)
		  style.AutocompletePopupBorderColor = New ColorGroup(&cECECEC, &c303030)
		  style.AutocompletePopupBackgroundColor = New ColorGroup(&cFFFFFF, &c262626)
		  style.SelectedAutocompleteOptionBackgroundColor = New ColorGroup(&cF4F4F4, &c303030)
		  style.SelectedAutocompleteOptionColor = New ColorGroup(Color.Black, Color.White)
		  
		  // Font.
		  #If TargetWindows
		    style.FontSize = 14
		  #Else
		    style.FontSize = 0
		  #EndIf
		  style.FontColor = New ColorGroup(Color.Black, Color.White)
		  
		  Return style
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		This class stores the style properties (such as colours and font size) that should be used when
		rendering a `XUITagCanvas` and any tags it contains.
		
		Contains shared methods that conveniently return preconfigured styles for common operating systems.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66207468652074657874206F6620756E73656C6563746564206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		AutocompleteOptionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220746865206261636B67726F756E64206F6620746865206175746F636F6D706C65746520706F7075702E
		AutocompletePopupBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620746865206175746F636F6D706C65746520706F70757020686173206120626F72646572207468656E20746869732069732069747320636F6C6F75722E
		AutocompletePopupBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620746865207461672063616E7661732E
		BackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520626F7264657220636F6C6F75722028696620656E61626C6564292E
		BorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520636172657420696E20746865207461672063616E7661732E
		CaretColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620756E70617273656420746578742E
		FontColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520666F6E7420746F2075736520666F7220746865207461672063616E7661732E
		FontName As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520666F6E742073697A6520746F2075736520666F7220746865207461672063616E7661732E
		FontSize As Integer = 12
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5472756520696620746865206175746F636F6D706C65746520706F70757020686173206120626F726465722E
		HasAutocompletePopupBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973207374796C652773206E616D652E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F757220666F72207468652063757272656E746C792073656C6563746564206F7074696F6E20696E20746865206175746F636F6D706C65746520706F7075702E
		SelectedAutocompleteOptionBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66207468652074657874206F66207468652063757272656E746C792073656C6563746564206F7074696F6E20696E20746865206175746F636F6D706C65746520706F7075702E
		SelectedAutocompleteOptionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F662061207461672E
		TagBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520626F7264657220636F6C6F7572206F662061207461672E
		TagBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520746167207465787420636F6C6F75722E
		TagTextColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66206F7074696F6E616C207461672064696E67757365732E
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
			Name="TagBackgroundColor"
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
			Name="CaretColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontColor"
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
			InitialValue=""
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
			Name="TagBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TagTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WidgetColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompletePopupBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasAutocompletePopupBorder"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompletePopupBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedAutocompleteOptionBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedAutocompleteOptionColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompleteOptionColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
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
	#tag EndViewBehavior
End Class
#tag EndClass
