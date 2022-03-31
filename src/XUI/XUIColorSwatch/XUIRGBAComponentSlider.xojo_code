#tag Class
Protected Class XUIRGBAComponentSlider
Inherits DesktopCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  // ===========
		  // SLIDER
		  // ===========
		  If mLinearBrush = Nil Or mNeedsFullRedraw Then
		    UpdateLinearBrush(g)
		  End If
		  g.Brush = mLinearBrush
		  If Self.ComponentType <> ComponentTypes.Alpha Then
		    g.FillRoundRectangle(0, 0, g.Width, g.Height, g.Height, g.Height)
		  Else
		    Var pb As New PictureBrush
		    pb.Image = CheckerboardPattern
		    pb.Mode = PictureBrush.Modes.Tile
		    g.Brush = pb
		    g.FillRoundRectangle(0, 0, g.Width, g.Height, g.Height, g.Height)
		    g.Brush = mLinearBrush
		    g.FillRoundRectangle(0, 0, g.Width, g.Height, g.Height, g.Height)
		  End If
		  
		  // Clear out the brush.
		  g.Brush = Nil
		  
		  // Draw the slider border.
		  g.DrawingColor = mSliderBorderColor
		  g.DrawRoundRectangle(0, 0, g.Width, g.Height, g.Height, g.Height)
		  
		  // ===========
		  // SCRUBBER
		  // ===========
		  Var scrubberDiameter As Double = g.Height - 2
		  
		  // Compute the x position of the scrubber along the spectrum. -1 is a fudge.
		  Var x As Double = XUIMaths.Clamp((ComponentValue / 255) * g.Width, 0, g.Width - scrubberDiameter - 1)
		  
		  // Draw the scrubber.
		  g.ShadowBrush = mScrubberShadowBrush
		  g.DrawingColor = mScrubberColor
		  g.PenSize = 2
		  g.DrawOval(x, (g.Height / 2) - (scrubberDiameter / 2), scrubberDiameter, scrubberDiameter)
		  g.ShadowBrush = Nil
		  
		  mNeedsFullRedraw = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		  mScrubberColor = New ColorGroup(Color.White, Color.White)
		  mSliderBorderColor = New ColorGroup(&c777777, &c333434)
		  
		  mScrubberShadowBrush = New ShadowBrush
		  mScrubberShadowBrush.BlurAmount = 3
		  mScrubberShadowBrush.ShadowColor = Color.Gray
		  mScrubberShadowBrush.Offset = New Point(0, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 55706461746573206F757220636163686564206C696E65617220627275736820606D4C696E65617242727573686020666F72207468652063757272656E742060436F6D706C657465436F6C6F72602E
		Private Sub UpdateLinearBrush(g As Graphics)
		  /// Updates our cached linear brush `mLinearBrush` for the current `CompleteColor`.
		  ///
		  /// The gradient runs from &h00 on the left to &hFF on the right of this slider's component type.
		  /// For example, if the current colour is &c48ADEF and this is a red component slider then the left hand
		  /// gradient will be &c00ADEF and the right hand gradient will be &cFFADEF.
		  /// So for a red component slider, we vary the red component between &h00 and &hFF but keep the green, blue and 
		  /// alpha components the same.
		  
		  mLinearBrush = New LinearGradientBrush
		  
		  Var startPoint, endPoint As Point
		  If ComponentType = ComponentTypes.Alpha Then
		    startPoint = New Point(g.Width, g.Height)
		    endPoint = New Point(0, 0)
		  Else
		    startPoint = New Point(0, 0)
		    endPoint = New Point(g.Width, g.Height)
		  End If
		  
		  mLinearBrush.StartPoint = startPoint
		  mLinearBrush.EndPoint = endPoint
		  
		  Var red As Integer = CompleteColor.Red
		  Var green As Integer = CompleteColor.Green
		  Var blue As Integer = CompleteColor.Blue
		  Var alpha As Integer = CompleteColor.Alpha
		  
		  // Compute the gradient points.
		  Var stop0, stop1, stop2, stop3, stop4, stop5, stop6, stop7, stop8, stop9, stop10 As Color
		  Select Case Self.ComponentType
		  Case ComponentTypes.Red
		    stop0 = Color.RGB(0, green, blue, alpha)
		    stop1 = Color.RGB(25, green, blue, alpha)
		    stop2 = Color.RGB(50, green, blue, alpha)
		    stop3 = Color.RGB(75, green, blue, alpha)
		    stop4 = Color.RGB(100, green, blue, alpha)
		    stop5 = Color.RGB(125, green, blue, alpha)
		    stop6 = Color.RGB(150, green, blue, alpha)
		    stop7 = Color.RGB(175, green, blue, alpha)
		    stop8 = Color.RGB(200, green, blue, alpha)
		    stop9 = Color.RGB(225, green, blue, alpha)
		    stop10 = Color.RGB(255, green, blue, alpha)
		    
		  Case ComponentTypes.Green
		    stop0 = Color.RGB(red, 0, blue, alpha)
		    stop1 = Color.RGB(red, 25, blue, alpha)
		    stop2 = Color.RGB(red, 50, blue, alpha)
		    stop3 = Color.RGB(red, 75, blue, alpha)
		    stop4 = Color.RGB(red, 100, blue, alpha)
		    stop5 = Color.RGB(red, 125, blue, alpha)
		    stop6 = Color.RGB(red, 150, blue, alpha)
		    stop7 = Color.RGB(red, 175, blue, alpha)
		    stop8 = Color.RGB(red, 200, blue, alpha)
		    stop9 = Color.RGB(red, 225, blue, alpha)
		    stop10 = Color.RGB(red, 255, blue, alpha)
		    
		  Case ComponentTypes.Blue
		    stop0 = Color.RGB(red, green, 0, alpha)
		    stop1 = Color.RGB(red, green, 25, alpha)
		    stop2 = Color.RGB(red, green, 50, alpha)
		    stop3 = Color.RGB(red, green, 75, alpha)
		    stop4 = Color.RGB(red, green, 100, alpha)
		    stop5 = Color.RGB(red, green, 125, alpha)
		    stop6 = Color.RGB(red, green, 150, alpha)
		    stop7 = Color.RGB(red, green, 175, alpha)
		    stop8 = Color.RGB(red, green, 200, alpha)
		    stop9 = Color.RGB(red, green, 225, alpha)
		    stop10 = Color.RGB(red, green, 255, alpha)
		    
		  Case ComponentTypes.Alpha
		    stop0 = Color.RGB(red, green, blue, 255)
		    stop1 = Color.RGB(red, green, blue, 225)
		    stop2 = Color.RGB(red, green, blue, 200)
		    stop3 = Color.RGB(red, green, blue, 175)
		    stop4 = Color.RGB(red, green, blue, 150)
		    stop5 = Color.RGB(red, green, blue, 125)
		    stop6 = Color.RGB(red, green, blue, 100)
		    stop7 = Color.RGB(red, green, blue, 75)
		    stop8 = Color.RGB(red, green, blue, 50)
		    stop9 = Color.RGB(red, green, blue, 25)
		    stop10 = Color.RGB(red, green, blue, 0)
		  End Select
		  
		  // Add the gradient stops.
		  mLinearBrush.GradientStops.Add(New Pair(0.0, stop0))
		  mLinearBrush.GradientStops.Add(New Pair(0.1, stop1))
		  mLinearBrush.GradientStops.Add(New Pair(0.2, stop2))
		  mLinearBrush.GradientStops.Add(New Pair(0.3, stop3))
		  mLinearBrush.GradientStops.Add(New Pair(0.4, stop4))
		  mLinearBrush.GradientStops.Add(New Pair(0.5, stop5))
		  mLinearBrush.GradientStops.Add(New Pair(0.6, stop6))
		  mLinearBrush.GradientStops.Add(New Pair(0.7, stop7))
		  mLinearBrush.GradientStops.Add(New Pair(0.8, stop8))
		  mLinearBrush.GradientStops.Add(New Pair(0.9, stop9))
		  mLinearBrush.GradientStops.Add(New Pair(1.0, stop10))
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6D706C65746520636F6C6F75722074686174207468697320636F6D706F6E656E7420726570726573656E74732070617274206F662E
		#tag Getter
			Get
			  Return mCompleteColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCompleteColor = value
			  mNeedsFullRedraw = True
			  Refresh
			End Set
		#tag EndSetter
		CompleteColor As Color
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ComponentType As XUIRGBAComponentSlider.ComponentTypes = XUIRGBAComponentSlider.ComponentTypes.Red
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652076616C7565206F66207468697320636F6D706F6E656E742E
		#tag Getter
			Get
			  Return mComponentValue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mComponentValue = value
			  Refresh
			  
			End Set
		#tag EndSetter
		ComponentValue As Byte
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 54686520636F6D706C65746520636F6C6F75722074686174207468697320636F6D706F6E656E7420726570726573656E74732070617274206F662E
		Private mCompleteColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652076616C7565206F66207468697320636F6D706F6E656E742E
		Private mComponentValue As Byte = 255
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C696E65617220627275736820746F2075736520666F72207468652063757272656E742060436F6D706C657465436F6C6F726020736C69646572206772616469656E7420696E2074686520605061696E7460206576656E742E20436F6D707574656420696E20605570646174654C696E65617242727573682829602E
		Private mLinearBrush As LinearGradientBrush
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520736C69646572206E6565647320612066756C6C207265647261772E
		Private mNeedsFullRedraw As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrubberColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520736861646F7720627275736820746F20757365207768656E2064726177696E67207468652073637275626265722E
		Private mScrubberShadowBrush As ShadowBrush
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572206F662074686520736C6964657220626F726465722E
		Private mSliderBorderColor As ColorGroup
	#tag EndProperty


	#tag Enum, Name = ComponentTypes, Type = Integer, Flags = &h0
		Alpha
		  Blue
		  Green
		Red
	#tag EndEnum


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
			InitialValue="200"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="16"
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
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
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
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
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
			Name="ComponentType"
			Visible=true
			Group="Behavior"
			InitialValue="XUIColorComponentSlider.Types.Red"
			Type="XUIRGBAComponentSlider.ComponentTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Alpha"
				"1 - Blue"
				"2 - Green"
				"3 - Red"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="CompleteColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ComponentValue"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Byte"
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
