#tag Class
Protected Class XUITagCanvasStyle
	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577207374796C6520776974682074686520636F6C6F75727320666F72206D61634F53207374796C6520746167732E
		Shared Function MacOS() As XUITagCanvasStyle
		  /// Returns a new style with the colours for macOS style tags.
		  
		  Var style As New XUITagCanvasStyle
		  
		  style.BackgroundColor = Color.White
		  style.TagBackgroundColor = Color.FromString("&h00C2D6FD")
		  style.TagBorderColor = Color.FromString("&h00C2D6FD")
		  style.TagTextColor = Color.Black
		  style.CaretColor = Color.Black
		  style.DingusColor = Color.Black
		  
		  style.AutocompletePopupBackgroundColor = Color.FromString("&h00ECECEC")
		  style.HasAutocompletePopupBorder = True
		  style.AutocompletePopupBorderColor = Color.FromString("&h00B8B9B9")
		  style.SelectedAutocompleteOptionBackgroundColor = Color.FromString("&h001043C7")
		  style.SelectedAutocompleteOptionColor = Color.White
		  style.AutocompleteOptionColour = Color.Black
		  
		  #If TargetWindows
		    style.FontSize = 14
		  #Else
		    style.FontSize = 0
		  #EndIf
		  
		  Return style
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577207374796C6520776974682074686520636F6C6F75727320666F722057696E646F7773207374796C6520746167732E
		Shared Function Windows() As XUITagCanvasStyle
		  /// Returns a new style with the colours for Windows style tags.
		  
		  Var style As New XUITagCanvasStyle
		  
		  style.BackgroundColor = Color.White
		  style.TagBackgroundColor = Color.FromString("&h00F2F2F2")
		  style.TagBorderColor = Color.Black
		  style.TagTextColor = Color.Black
		  style.CaretColor = Color.Black
		  style.DingusColor = Color.Black
		  
		  style.AutocompletePopupBackgroundColor = Color.FromString("&h00E6E6E6")
		  style.HasAutocompletePopupBorder = True
		  style.AutocompletePopupBorderColor = Color.Black
		  style.SelectedAutocompleteOptionBackgroundColor = Color.FromString("&h00D3D3D3")
		  style.SelectedAutocompleteOptionColor = Color.Black
		  style.AutocompleteOptionColour = Color.Black
		  
		  #If TargetWindows
		    style.FontSize = 14
		  #Else
		    style.FontSize = 0
		  #EndIf
		  
		  Return style
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66207468652074657874206F6620756E73656C6563746564206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		AutocompleteOptionColour As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220746865206261636B67726F756E64206F6620746865206175746F636F6D706C65746520706F7075702E
		AutocompletePopupBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620746865206175746F636F6D706C65746520706F70757020686173206120626F72646572207468656E20746869732069732069747320636F6C6F75722E
		AutocompletePopupBorderColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F6620746865207461672063616E7661732E
		BackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520636172657420696E20746865207461672063616E7661732E
		CaretColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66206F7074696F6E616C207461672064696E67757365732E
		DingusColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620756E70617273656420746578742E
		FontColor As Color
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

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F757220666F72207468652063757272656E746C792073656C6563746564206F7074696F6E20696E20746865206175746F636F6D706C65746520706F7075702E
		SelectedAutocompleteOptionBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66207468652074657874206F66207468652063757272656E746C792073656C6563746564206F7074696F6E20696E20746865206175746F636F6D706C65746520706F7075702E
		SelectedAutocompleteOptionColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F7572206F662061207461672E
		TagBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520626F7264657220636F6C6F7572206F662061207461672E
		TagBorderColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520746167207465787420636F6C6F75722E
		TagTextColor As Color
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
			Name="CaretColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
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
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TagTextColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DingusColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompletePopupBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
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
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedAutocompleteOptionBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedAutocompleteOptionColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompleteOptionColour"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
