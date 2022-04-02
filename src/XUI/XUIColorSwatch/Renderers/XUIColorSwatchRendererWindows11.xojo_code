#tag Class
Protected Class XUIColorSwatchRendererWindows11
Implements XUIColorSwatchRenderer
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUIColorSwatch)
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
		  
		  mActiveBorderColor = New ColorGroup(ACTIVE_BORDER_COLOR_LIGHT, ACTIVE_BORDER_COLOR_DARK)
		  
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
		  
		  Return 50
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207265636F6D6D656E6465642077696474682028696E20706978656C73292074686520636F6C6F7572207377617463682073686F756C642062652E
		Function RecommendedWidth() As Double
		  /// The recommended width (in pixels) the colour swatch should be.
		  ///
		  /// Part of the XUIColorSwatchRenderer interface.
		  
		  Return 50
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E64657273207468652073776174636820746F207468652070617373656420677261706869637320636F6E746578742E
		Sub Render(g As Graphics)
		  /// Renders the swatch to the passed graphics context.
		  ///
		  /// Part of the XUIColorSwatchRenderer interface.
		  
		  If Owner = Nil Then Return
		  
		  // Value.
		  g.DrawingColor = Owner.Value
		  g.FillRoundRectangle(0, 0, g.Width, g.Height, 5, 5)
		  
		  // Border?
		  If Owner.IsActive Then
		    g.DrawingColor = mActiveBorderColor
		    g.PenSize = 1
		    g.DrawRoundRectangle(0, 0, g.Width, g.Height, 5, 5)
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Renders a color swatch mimicking Windows 11.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F72207468652073776174636820626F72646572207768656E206163746976652E
		Private mActiveBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F20746865206F776E696E6720436F6C6F725377617463682E
		Private mOwner As WeakRef
	#tag EndProperty


	#tag Constant, Name = ACTIVE_BORDER_COLOR_DARK, Type = Color, Dynamic = False, Default = \"&cffffff", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ACTIVE_BORDER_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Private
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
