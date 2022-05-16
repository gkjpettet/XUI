#tag Class
Protected Class XUIDotLabel
Inherits DesktopCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  If Caption = "" Then
		    Call DrawDot(g, 0)
		    
		  Else
		    Var captionX As Double = DrawDot(g, 0)
		    DrawCaption(g, captionX)
		    
		  End If
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 5468652064656661756C7420636F6E7374727563746F722E
		Sub Constructor()
		  /// The default constructor.
		  
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  mDisabledCaptionColor = New ColorGroup(DISABLED_COLOR_CAPTION_LIGHT, DISABLED_COLOR_CAPTION_DARK)
		  mDisabledDotColor = New ColorGroup(DISABLED_COLOR_DOT_LIGHT, DISABLED_COLOR_DOT_DARK)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652063757272656E7420646F74207261646975732E
		Private Function DotRadius() As Double
		  /// Returns the current dot radius.
		  
		  Return DotDiameter / 2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4472617773207468652063617074696F6E20746F20606760207374617274696E67206174206078602E
		Private Sub DrawCaption(g As Graphics, x As Double)
		  /// Draws the caption to `g` starting at `x`.
		  
		  If Caption = "" Then Return
		  
		  g.FontName = FontName
		  g.FontSize = FontSize
		  g.DrawingColor = If(Me.Enabled, CaptionColor, mDisabledCaptionColor)
		  
		  Var wrapWidth As Double = 0
		  If CondenseCaption Then
		    wrapWidth = g.Width - DotDiameter - DotPadding
		  End If
		  
		  Var baseline As Double = (g.FontAscent + (g.Height - g.TextHeight)/2)
		  
		  If wrapWidth > 0 Then
		    g.DrawText(Caption, x, baseline, wrapWidth, True)
		  Else
		    g.DrawText(Caption, x, baseline)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44726177732074686520646F7420746F20606760207374617274696E67206174206078602E2052657475726E7320746865205820636F6F7264696E6174652061667465722074686520646F742C20696E636C7564696E672070616464696E672E
		Private Function DrawDot(g As Graphics, x As Double) As Double
		  /// Draws the dot to `g` starting at `x`. Returns the X coordinate after the dot, including padding.
		  
		  g.DrawingColor = If(Me.Enabled, DotColor, mDisabledDotColor)
		  g.FillOval(0, (g.Height / 2) - DotRadius, DotDiameter, DotDiameter)
		  
		  // Border?
		  If DotHasBorder And DotBorderColor <> Nil Then
		    g.DrawingColor = If(Me.Enabled, DotBorderColor, mDisabledDotColor)
		    g.DrawOval(0, (g.Height / 2) - DotRadius, DotDiameter, DotDiameter)
		  End If
		  
		  Return x + DotDiameter + DotPadding
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A simple UI control that draws a customisable dot (rounded circle). Useful for representing 
		state (e.g. a red dot if something is disconnected or a green dot if something is active).
		
		Supports an optional caption.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 4F7074696F6E616C2063617074696F6E20746F20646973706C6179206265736964652074686520646F742E
		#tag Getter
			Get
			  Return mCaption
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCaption = value
			  Refresh
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220746865206F7074696F6E616C2063617074696F6E2E
		#tag Getter
			Get
			  Return mCaptionColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCaptionColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		CaptionColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E207468652063617074696F6E2077696C6C20626520636F6E64656E736564207769746820616E20656C6C697073697320696620697420697320746F6F206C6F6E6720746F2066697420696E2074686520617661696C61626C652073706163652E
		#tag Getter
			Get
			  Return mCondenseCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCondenseCaption = value
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		CondenseCaption As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520646F74277320626F726465722028696620656E61626C6564292E
		#tag Getter
			Get
			  Return mDotBorderColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDotBorderColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		DotBorderColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520646F742E
		#tag Getter
			Get
			  Return mDotColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDotColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		DotColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206469616D65746572206F662074686520646F7420696E20706978656C732E
		#tag Getter
			Get
			  Return mDotDiameter
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDotDiameter = Max(value, MIN_DOT_DIAMETER)
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		DotDiameter As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686520646F7420686173206120626F726465722E
		#tag Getter
			Get
			  Return mDotHasBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDotHasBorder = value
			  
			  Refresh
			End Set
		#tag EndSetter
		DotHasBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620706978656C73206265747765656E2074686520646F7420616E64206F7074696F6E616C2063617074696F6E2E
		#tag Getter
			Get
			  Return mDotPadding
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDotPadding = value
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		DotPadding As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520666F6E7420746F2075736520666F72207468652063617074696F6E2E
		#tag Getter
			Get
			  Return mFontName
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFontName = value
			  
			  Refresh
			End Set
		#tag EndSetter
		FontName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520666F6E742073697A6520746F2075736520666F72207468652063617074696F6E2E
		#tag Getter
			Get
			  Return mFontSize
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFontSize = Max(value, MIN_CAPTION_FONT_SIZE)
			  
			  Refresh
			End Set
		#tag EndSetter
		FontSize As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 4F7074696F6E616C2063617074696F6E20746F20646973706C6179206265736964652074686520646F742E
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F7220746865206F7074696F6E616C2063617074696F6E2E
		Private mCaptionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E207468652063617074696F6E2077696C6C20626520636F6E64656E736564207769746820616E20656C6C697073697320696620697420697320746F6F206C6F6E6720746F2066697420696E2074686520617661696C61626C652073706163652E
		Private mCondenseCaption As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F72207468652063617074696F6E207768656E2074686520636F6E74726F6C2069732064697361626C65642E
		Private mDisabledCaptionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F722074686520646F74207768656E2074686520636F6E74726F6C2069732064697361626C65642E
		Private mDisabledDotColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572206F662074686520646F74277320626F726465722028696620656E61626C6564292E
		Private mDotBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572206F662074686520646F742E
		Private mDotColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206469616D65746572206F662074686520646F7420696E20706978656C732E
		Private mDotDiameter As Double = 16
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520646F7420686173206120626F726465722E
		Private mDotHasBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C73206265747765656E2074686520646F7420616E64206F7074696F6E616C2063617074696F6E2E
		Private mDotPadding As Integer = 5
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520666F6E7420746F2075736520666F72207468652063617074696F6E2E
		Private mFontName As String = "System"
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520666F6E742073697A6520746F2075736520666F72207468652063617074696F6E2E
		Private mFontSize As Integer = 0
	#tag EndProperty


	#tag Constant, Name = DISABLED_COLOR_CAPTION_DARK, Type = Color, Dynamic = False, Default = \"&cADACAC", Scope = Private, Description = 546865206461726B206D6F646520636F6C6F757220746F2075736520666F72207468652063617074696F6E207768656E2074686520636F6E74726F6C2069732064697361626C65642E
	#tag EndConstant

	#tag Constant, Name = DISABLED_COLOR_CAPTION_LIGHT, Type = Color, Dynamic = False, Default = \"&cADACAC", Scope = Private, Description = 546865206C69676874206D6F646520636F6C6F757220746F2075736520666F72207468652063617074696F6E207768656E2074686520636F6E74726F6C2069732064697361626C65642E
	#tag EndConstant

	#tag Constant, Name = DISABLED_COLOR_DOT_DARK, Type = Color, Dynamic = False, Default = \"&cADACAC", Scope = Private, Description = 546865206461726B206D6F646520636F6C6F757220746F2075736520666F722074686520646F74207768656E2074686520636F6E74726F6C2069732064697361626C65642E
	#tag EndConstant

	#tag Constant, Name = DISABLED_COLOR_DOT_LIGHT, Type = Color, Dynamic = False, Default = \"&cADACAC", Scope = Private, Description = 546865206C69676874206D6F646520636F6C6F757220746F2075736520666F722074686520646F74207768656E2074686520636F6E74726F6C2069732064697361626C65642E
	#tag EndConstant

	#tag Constant, Name = MIN_CAPTION_FONT_SIZE, Type = Double, Dynamic = False, Default = \"6", Scope = Private, Description = 546865206D696E696D756D207065726D697474656420666F6E742073697A6520666F72207468652063617074696F6E2E
	#tag EndConstant

	#tag Constant, Name = MIN_DOT_DIAMETER, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 546865206D696E696D756D207065726D6974746564206469616D65746572206F662074686520646F742E
	#tag EndConstant


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
			InitialValue=""
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="120"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="20"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DotColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c00FF00"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Visible=true
			Group="Behavior"
			InitialValue="Caption"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaptionColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DotHasBorder"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DotBorderColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Behavior"
			InitialValue="System"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Behavior"
			InitialValue="12"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CondenseCaption"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DotPadding"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DotDiameter"
			Visible=true
			Group="Behavior"
			InitialValue="16"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
