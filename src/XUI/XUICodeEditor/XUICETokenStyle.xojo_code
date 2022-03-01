#tag Class
Protected Class XUICETokenStyle
	#tag Method, Flags = &h0, Description = 52657475726E73206120636C6F6E65206F662074686973206F626A6563742E
		Function Clone() As XUICETokenStyle
		  /// Returns a clone of this object.
		  
		  Return New XUICETokenStyle(Self.Colour, Self.Bold, Self.Italic, Self.Underline, _
		  Self.BackgroundColour, Self.HasBackgroundColour)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(colour As Color = &c000000, bold As Boolean = False, italic As Boolean = False, underline As Boolean = False, backgroundColour As Color = &c000000, hasBackgroundColour As Boolean = False)
		  Self.Colour = colour
		  Self.Bold = bold
		  Self.Italic = italic
		  Self.Underline = underline
		  Self.BackgroundColour = backgroundColour
		  Self.HasBackgroundColour = hasBackgroundColour
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(d As Dictionary)
		  If d = Nil Then
		    Raise New InvalidArgumentException("Cannot instantiate a token style from a Nil dictionary.")
		  End If
		  
		  // Set defaults.
		  Self.BackgroundColour = Color.White
		  Self.Bold = False
		  Self.Colour = Color.Black
		  Self.HasBackgroundColour = False
		  Self.Italic = False
		  Self.Underline = False
		  
		  For Each entry As DictionaryEntry In d
		    If entry.Key.Type <> Variant.TypeString Then
		      Raise New InvalidArgumentException("Expected a string key.")
		    End If
		    
		    Select Case entry.Key
		    Case "backgroundColor"
		      Self.BackgroundColour = entry.Value
		      
		    Case "bold"
		      Self.Bold = entry.Value
		      
		    Case "color"
		      Self.Colour = entry.Value
		      
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

	#tag Method, Flags = &h0, Description = 52657475726E73207468697320746F6B656E207374796C652061732061204A534F4E206F626A6563742E
		Function ToJSON() As String
		  /// Returns this token style as a JSON object.
		  
		  Var json() As String
		  
		  json.Add("{")
		  
		  // Background colour.
		  json.Add(GenerateJSON(KEY_BACKGROUND_COLOUR)) + ":"
		  json.Add(GenerateJSON(BackgroundColour.ToString))
		  json.Add(",")
		  
		  // Bold.
		  json.Add(GenerateJSON(KEY_BOLD)) + ":"
		  json.Add(GenerateJSON(Bold))
		  json.Add(",")
		  
		  // Colour.
		  json.Add(GenerateJSON(KEY_COLOUR)) + ":"
		  json.Add(GenerateJSON(Colour.ToString))
		  json.Add(",")
		  
		  // HasBackgroundColour.
		  json.Add(GenerateJSON(KEY_HAS_BACKGROUND_COLOUR)) + ":"
		  json.Add(GenerateJSON(HasBackgroundColour))
		  json.Add(",")
		  
		  // Italic.
		  json.Add(GenerateJSON(KEY_ITALIC)) + ":"
		  json.Add(GenerateJSON(Italic))
		  json.Add(",")
		  
		  // Underline.
		  json.Add(GenerateJSON(KEY_UNDERLINE)) + ":"
		  json.Add(GenerateJSON(Underline))
		  
		  json.Add("}")
		  
		  Return String.FromArray(json, "")
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66207468697320746F6B656E2773206261636B67726F756E642028696620656E61626C6564292E
		BackgroundColour As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Bold As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Colour As Color
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
