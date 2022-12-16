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
		  PlaceholderTextColor = New ColorGroup(Color.Black, Color.Black)
		  SectionBackColor = New ColorGroup(Color.Black, Color.Black)
		  SectionBorderColor = New ColorGroup(Color.Black, Color.Black)
		  SelectionColor = New ColorGroup(Color.Black, Color.Black)
		  TextColor = New ColorGroup(Color.Black, Color.Black)
		  
		  Name = "Blank Style"
		  FontName = "System"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652064656661756C74207374796C6520666F722074686520696E73706563746F722E
		Shared Function Default() As XUIInspectorStyle
		  /// Returns the default style for the inspector.
		  ///
		  /// Feel free to create your own.
		  
		  Var style As New XUIInspectorStyle
		  
		  Const ALMOST_BLACK = &c171717
		  Const LIGHT_GREY = &cCACBCB
		  Const DARK_GREY = &c353636
		  Const LIGHT_SELECTION_BLUE = &cA4CBFE
		  Const DARK_SELECTION_BLUE = &c304F77
		  Const LIGHT_ACCENT_BLUE = &c3D71E3
		  Const DARK_ACCENT_BLUE = &c3968D4
		  Const LIGHT_PLACEHOLDER_GREY = &cBFBFC1
		  Const DARK_PLACEHOLDER_GREY = &c252626
		  
		  style.AccentColor = New ColorGroup(LIGHT_ACCENT_BLUE, DARK_ACCENT_BLUE)
		  style.BackgroundColor = New ColorGroup(Color.White, ALMOST_BLACK)
		  style.BorderColor = New ColorGroup(LIGHT_GREY, DARK_GREY)
		  style.ControlBackgroundColor = New ColorGroup(Color.White, ALMOST_BLACK)
		  style.ControlBorderColor = New ColorGroup(LIGHT_GREY, DARK_GREY)
		  style.FocusColor = New ColorGroup(LIGHT_ACCENT_BLUE, DARK_ACCENT_BLUE)
		  style.PlaceholderTextColor = New ColorGroup(LIGHT_PLACEHOLDER_GREY, DARK_PLACEHOLDER_GREY)
		  style.SectionBackColor = New ColorGroup(LIGHT_PLACEHOLDER_GREY, DARK_PLACEHOLDER_GREY)
		  style.SelectionColor = New ColorGroup(LIGHT_SELECTION_BLUE, DARK_SELECTION_BLUE)
		  style.TextColor = New ColorGroup(Color.Black, Color.White)
		  
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
		FontSize As Double = 10
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

	#tag Property, Flags = &h0, Description = 5468652073656C656374696F6E20636F6C6F75722E
		SelectionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520707265666572726564207465787420636F6C6F75722E
		TextColor As ColorGroup
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
	#tag EndViewBehavior
End Class
#tag EndClass
