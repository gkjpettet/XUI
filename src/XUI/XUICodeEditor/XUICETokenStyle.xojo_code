#tag Class
Protected Class XUICETokenStyle
	#tag Method, Flags = &h0, Description = 52657475726E73206120636C6F6E65206F662074686973206F626A6563742E
		Function Clone() As XUICETokenStyle
		  /// Returns a clone of this object.
		  
		  Var style As New XUICETokenStyle
		  
		  style.BackgroundColour = Self.BackgroundColour
		  style.Bold = Self.Bold
		  style.Colour = Self.Colour
		  style.HasBackgroundColour = Self.HasBackgroundColour
		  style.Italic = Self.Italic
		  style.Underline = Self.Underline
		  
		  Return style
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Initialise all ColorGroup properties to prevent Nil object exceptions.
		  
		  Me.BackgroundColour = New ColorGroup(Color.Black, Color.Black)
		  Me.Colour = New ColorGroup(Color.Black, Color.Black)
		  
		  // Set defaults.
		  Self.Bold = False
		  Self.HasBackgroundColour = False
		  Self.Italic = False
		  Self.Underline = False
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(d As Dictionary)
		  /// Instantiates a new token style from a Dictionary.
		  ///
		  /// Assumes that ColorGroup values are strings in the following format:
		  /// &hAARRGGBB   or  &hAARRGGBB,&hAARRGGBB
		  /// If only one colour is provided it is used in both light and dark mode. If two colours are provided (separated
		  /// by a comma) then the first is used in light mode and the second in dark mode. 
		  /// If two colours are provided and the OS doesn't support dark mode then the first colour is used.
		  
		  Constructor
		  
		  If d = Nil Then
		    Raise New InvalidArgumentException("Cannot instantiate a token style from a Nil dictionary.")
		  End If
		  
		  For Each entry As DictionaryEntry In d
		    If entry.Key.Type <> Variant.TypeString Then
		      Raise New InvalidArgumentException("Expected a string key.")
		    End If
		    
		    Select Case entry.Key
		    Case "backgroundColor"
		      Self.BackgroundColour = XUIColorGroups.FromString(entry.Value)
		      
		    Case "bold"
		      Self.Bold = entry.Value
		      
		    Case "color"
		      Self.Colour = XUIColorGroups.FromString(entry.Value)
		      
		    Case "hasBackgroundColor"
		      Self.HasBackgroundColour = entry.Value
		      
		    Case "italic"
		      Self.Italic = entry.Value
		      
		    Case "underline"
		      Self.Underline = entry.Value
		      
		    Else
		      Raise New InvalidArgumentException("Unexpected key/value in token style dictionary.")
		    End Select
		  Next entry
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66207468697320746F6B656E2773206261636B67726F756E642028696620656E61626C6564292E
		BackgroundColour As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		Bold As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Colour As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973207374796C65206861732061206261636B67726F756E6420636F6C6F75722E
		HasBackgroundColour As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Italic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Underline As Boolean = False
	#tag EndProperty


	#tag Constant, Name = KEY_BACKGROUND_COLOUR, Type = String, Dynamic = False, Default = \"backgroundColour", Scope = Private, Description = 546865204A534F4E206B657920666F722074686973207374796C652773206261636B67726F756E6420636F6C6F75722E
	#tag EndConstant

	#tag Constant, Name = KEY_BOLD, Type = String, Dynamic = False, Default = \"bold", Scope = Private, Description = 546865204A534F4E206B657920666F722074686973207374796C65277320626F6C64207374617475732E
	#tag EndConstant

	#tag Constant, Name = KEY_COLOUR, Type = String, Dynamic = False, Default = \"colour", Scope = Private, Description = 546865204A534F4E206B657920666F722074686973207374796C65277320636F6C6F75722E
	#tag EndConstant

	#tag Constant, Name = KEY_HAS_BACKGROUND_COLOUR, Type = String, Dynamic = False, Default = \"hasBackgroundColour", Scope = Private, Description = 546865204A534F4E206B657920666F722074686973207374796C652773204861734261636B67726F756E64436F6C6F7572207374617475732E
	#tag EndConstant

	#tag Constant, Name = KEY_ITALIC, Type = String, Dynamic = False, Default = \"italic", Scope = Private, Description = 546865204A534F4E206B657920666F722074686973207374796C652773206974616C6963207374617475732E
	#tag EndConstant

	#tag Constant, Name = KEY_UNDERLINE, Type = String, Dynamic = False, Default = \"underline", Scope = Private, Description = 546865204A534F4E206B657920666F722074686973207374796C65277320756E6465726C696E65207374617475732E
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
		#tag ViewProperty
			Name="Bold"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Colour"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColour"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackgroundColour"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
