#tag Class
Protected Class XUIColorSwatchRendererMacOS
Implements XUIColorSwatchRenderer
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(owner As XUIColorSwatch)
		  /// Default constructor.
		  ///
		  /// - `owner` is the `XUIColorSwatch` that owns this renderer. A new `WeakRef` to it will be created.
		  
		  If owner = Nil Then
		    Raise New UnsupportedOperationException("A renderer's owner cannot be Nil.")
		  End If
		  
		  mOwner = New WeakRef(owner)
		  
		  InitialiseColorGroups
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E697469616C697365732074686520436F6C6F7247726F75702070726F706572746965732066726F6D206F7572206275696C742D696E20636F6E7374616E74732E
		Private Sub InitialiseColorGroups()
		  /// Initialises the ColorGroup properties from our built-in constants.
		  
		  mActiveBackgroundColor = New ColorGroup(ACTIVE_BACKGROUND_COLOR_LIGHT, ACTIVE_BACKGROUND_COLOR_DARK)
		  mBackgroundColor = New ColorGroup(BACKGROUND_COLOR_LIGHT, BACKGROUND_COLOR_DARK)
		  mInnerBorderColor = New ColorGroup(INNER_BORDER_COLOR_LIGHT, INNER_BORDER_COLOR_DARK)
		  mOuterBorderColor = New ColorGroup(OUTER_BORDER_COLOR_LIGHT, OUTER_BORDER_COLOR_DARK)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732072656E64657265722773206F776E696E6720436F6C6F725377617463682E
		Function Owner() As XUIColorSwatch
		  /// This renderer's owning ColorSwatch.
		  ///
		  /// Part of the XUIColorSwatchRenderer interface.
		  
		  If mOwner = Nil Or mOwner.Value = Nil Then
		    Return Nil
		  Else
		    Return XUIColorSwatch(mOwner.Value)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207265636F6D6D656E646564206865696768742074686520636F6C6F7572207377617463682073686F756C642062652E
		Function RecommendedHeight() As Double
		  /// The recommended height (in pixels) the colour swatch should be.
		  ///
		  /// Part of the XUIColorSwatchRenderer interface.
		  
		  Return 22
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207265636F6D6D656E6465642077696474682028696E20706978656C73292074686520636F6C6F7572207377617463682073686F756C642062652E
		Function RecommendedWidth() As Double
		  /// The recommended width (in pixels) the colour swatch should be.
		  ///
		  /// Part of the XUIColorSwatchRenderer interface.
		  
		  Return 48
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E64657273207468652073776174636820746F207468652070617373656420677261706869637320636F6E746578742E
		Sub Render(g As Graphics)
		  /// Renders the swatch to the passed graphics context.
		  ///
		  /// Part of the XUIColorSwatchRenderer interface.
		  
		  If Owner = Nil Then Return
		  
		  // Background.
		  g.DrawingColor = If(Owner.IsActive, mActiveBackgroundColor, mBackgroundColor)
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // Outer border.
		  g.DrawingColor = mOuterBorderColor
		  g.DrawRectangle(0, 0, g.Width, g.Height)
		  
		  // Compute the size of the value rectangle including the inner border.
		  Var valueSize As Size
		  If g.Width = RecommendedWidth And g.Height = RecommendedHeight Then
		    // The control is the recommended size.
		    valueSize = New Size(38, 12)
		  Else
		    valueSize = New Size(g.Width * 0.8, g.Height * 0.55)
		  End If
		  
		  // Compute the x, y coords of the value/inner border rectangle.
		  Var x As Double = (g.Width / 2) - (valueSize.Width / 2)
		  Var y As Double = (g.Height / 2) - (valueSize.Height / 2)
		  
		  // Draw the value.
		  If Owner.Value.Alpha = 0 Then
		    // Solid colour.
		    g.DrawingColor = Owner.Value
		    g.FillRectangle(x, y, valueSize.Width, valueSize.Height)
		  Else
		    // There is opacity.
		    // The value rectangle is drawn as two triangles with opposing alphas.
		    // Upper triangle.
		    g.DrawingColor = Color.RGB(Owner.Value.Red, Owner.Value.Green, Owner.Value.Blue, Abs(Owner.Value.Alpha - 255))
		    Var upper As New GraphicsPath
		    upper.MoveToPoint(x, y)
		    upper.AddLineToPoint(x + valueSize.Width, y)
		    upper.AddLineToPoint(x, y + valueSize.Height)
		    g.FillPath(upper, True)
		    
		    // Lower triangle.
		    g.DrawingColor = Owner.Value
		    Var lower As New GraphicsPath
		    lower.MoveToPoint(x, y + valueSize.Height)
		    lower.AddLineToPoint(x + valueSize.Width, y + valueSize.Height)
		    lower.AddLineToPoint(x + valueSize.Width, y)
		    g.FillPath(lower, True)
		  End If
		  
		  // Draw the inner border.
		  g.DrawingColor = mInnerBorderColor
		  g.DrawRectangle(x, y, valueSize.Width, valueSize.Height)
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Renders a color swatch mimicking macOS.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F722074686520737761746368206261636B67726F756E64207768656E206163746976652E
		Private mActiveBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F7220746865207377617463682773206261636B67726F756E64207768656E206E6F6E2D6163746976652E
		Private mBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F722074686520696E6E657220626F726465722E
		Private mInnerBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F7220746865206F7574657220626F726465722E
		Private mOuterBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F20746865206F776E696E6720436F6C6F725377617463682E
		Private mOwner As WeakRef
	#tag EndProperty


	#tag Constant, Name = ACTIVE_BACKGROUND_COLOR_DARK, Type = Color, Dynamic = False, Default = \"&c4C4A4D", Scope = Private, Description = 546865206461726B206D6F646520636F6C6F757220666F7220746865206261636B67726F756E64207768656E2074686520636F6C6F757220737761746368206973206163746976652E
	#tag EndConstant

	#tag Constant, Name = ACTIVE_BACKGROUND_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&C9F9F9F", Scope = Private, Description = 546865206C69676874206D6F646520636F6C6F757220666F7220746865206261636B67726F756E64207768656E2074686520636F6C6F757220737761746368206973206163746976652E
	#tag EndConstant

	#tag Constant, Name = BACKGROUND_COLOR_DARK, Type = Color, Dynamic = False, Default = \"&c303030", Scope = Private, Description = 546865206461726B206D6F646520636F6C6F757220666F7220746865206261636B67726F756E642E
	#tag EndConstant

	#tag Constant, Name = BACKGROUND_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&cF4F4F4", Scope = Private, Description = 546865206C69676874206D6F646520636F6C6F757220666F7220746865206261636B67726F756E642E
	#tag EndConstant

	#tag Constant, Name = INNER_BORDER_COLOR_DARK, Type = Color, Dynamic = False, Default = \"&c767777", Scope = Private, Description = 546865206461726B206D6F646520636F6C6F757220666F722074686520696E6E657220626F726465722E
	#tag EndConstant

	#tag Constant, Name = INNER_BORDER_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&c777677", Scope = Private, Description = 546865206C69676874206D6F646520636F6C6F757220666F722074686520696E6E657220626F726465722E
	#tag EndConstant

	#tag Constant, Name = OUTER_BORDER_COLOR_DARK, Type = Color, Dynamic = False, Default = \"&c4C4A4D", Scope = Private, Description = 546865206461726B206D6F646520636F6C6F757220666F7220746865206F7574657220626F726465722E
	#tag EndConstant

	#tag Constant, Name = OUTER_BORDER_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&C9F9F9F", Scope = Private, Description = 546865206C69676874206D6F646520636F6C6F757220666F7220746865206F7574657220626F726465722E
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
	#tag EndViewBehavior
End Class
#tag EndClass
