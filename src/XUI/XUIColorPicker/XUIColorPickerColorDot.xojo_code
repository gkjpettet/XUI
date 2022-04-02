#tag Class
Protected Class XUIColorPickerColorDot
	#tag Method, Flags = &h0
		Sub Constructor(colour As Color, name As String, ParamArray palette() As Color)
		  Self.Colour = colour
		  Self.Name = name
		  
		  // Clone the passed array.
		  For Each c As color In palette
		    Self.Palette.Add(c)
		  Next c
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a coloured dot on the ColorPicker swatches panel.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520646F74277320626F756E64732C206C6F63616C20746F2074686520585549436F6C6F725069636B6572436F6C6F72446F7443616E766173207468697320646F742061707065617273206F6E2E205573656420666F722068697420646574656374696F6E2E
		Bounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320646F74277320636F6C6F75722E
		Colour As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320646F742773206E616D652E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320646F742773206173736F6369617465642070616C65747465206F6620636F6C6F7572732E
		Palette() As Color
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
			Name="Colour"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
