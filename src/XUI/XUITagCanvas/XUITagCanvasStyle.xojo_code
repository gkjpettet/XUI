#tag Class
Protected Class XUITagCanvasStyle
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
			EditorType=""
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
	#tag EndViewBehavior
End Class
#tag EndClass
