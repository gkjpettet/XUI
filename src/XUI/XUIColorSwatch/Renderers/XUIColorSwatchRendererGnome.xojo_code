#tag Class
Protected Class XUIColorSwatchRendererGnome
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
		  mBorderColor = New ColorGroup(BORDER_COLOR_LIGHT, BORDER_COLOR_DARK)
		  
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
		  
		  Return 30
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207265636F6D6D656E6465642077696474682028696E20706978656C73292074686520636F6C6F7572207377617463682073686F756C642062652E
		Function RecommendedWidth() As Double
		  /// The recommended width (in pixels) the colour swatch should be.
		  ///
		  /// Part of the XUIColorSwatchRenderer interface.
		  
		  Return 38
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
		  g.FillRoundRectangle(0, 0, g.Width, g.Height, 5, 5)
		  
		  // Outer border.
		  g.DrawingColor = mBorderColor
		  g.DrawRoundRectangle(0, 0, g.Width, g.Height, 5, 5)
		  
		  // Compute the size of the value rectangle including the inner border.
		  Var valueSize As New Size(g.Width * 0.75, g.Height * 0.75)
		  
		  // Compute the x, y coords of the value/inner border rectangle.
		  Var x As Double = (g.Width / 2) - (valueSize.Width / 2)
		  Var y As Double = (g.Height / 2) - (valueSize.Height / 2)
		  
		  // Draw the value.
		  g.DrawingColor = Owner.Value
		  g.FillRoundRectangle(x, y, valueSize.Width, valueSize.Height, 5, 5)
		  
		  // Draw the inner border.
		  g.DrawingColor = mBorderColor
		  g.DrawRoundRectangle(x, y, valueSize.Width, valueSize.Height, 5, 5)
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Renders a color swatch mimicking Gnome (e.g. as used by Ubuntu, Fedora, etc).
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F722074686520737761746368206261636B67726F756E64207768656E206163746976652E
		Private mActiveBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F7220746865207377617463682773206261636B67726F756E64207768656E206E6F6E2D6163746976652E
		Private mBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F722074686520696E6E657220616E64206F7574657220626F72646572732E
		Private mBorderColor As ColorGroup
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

	#tag Constant, Name = BORDER_COLOR_DARK, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Private, Description = 546865206461726B206D6F646520636F6C6F757220666F722074686520626F726465722E
	#tag EndConstant

	#tag Constant, Name = BORDER_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Private, Description = 546865206C69676874206D6F646520636F6C6F757220666F722074686520626F726465722E
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
