#tag Module
Protected Module XUIFonts
	#tag Method, Flags = &h1, Description = 52657475726E7320616E206172726179206F6620746865206E616D6573206F6620616C6C20666F6E747320617661696C61626C65206F6E20746869732073797374656D2E
		Protected Function All() As String()
		  /// Returns an array of the names of all fonts available on this system.
		  
		  // We create this variable once during its first call.
		  Static fonts() As String = All_
		  
		  Return fonts
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320616E206172726179206F6620746865206E616D6573206F6620616C6C206D6F6E6F737061636520666F6E747320617661696C61626C65206F6E20746869732073797374656D2E
		Protected Function AllMonospace() As String()
		  /// Returns an array of the names of all monospace fonts available on this system.
		  
		  Static monospace() As String = AllMonospace_
		  
		  Return monospace
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320616E206172726179206F6620746865206E616D6573206F6620616C6C206D6F6E6F737061636520666F6E747320617661696C61626C65206F6E20746869732073797374656D2E
		Private Function AllMonospace_() As String()
		  /// Internal use. Returns an array of the names of all monospace fonts available on this system.
		  ///
		  /// This is called internally by `AllMonospace()` when returning the list of fonts. 
		  
		  Var fonts() As String = All
		  
		  Var monospace() As String
		  For Each font As String In fonts
		    If IsMonospaceFont(font) Then monospace.Add(font)
		  Next font
		  
		  Return monospace
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320616E206172726179206F6620746865206E616D6573206F6620616C6C20666F6E747320617661696C61626C65206F6E20746869732073797374656D2E
		Private Function All_() As String()
		  /// Internal use. Returns an array of the names of all fonts available on this system.
		  ///
		  /// This is called internally by `All()` when returning the list of fonts. 
		  
		  Var fonts() As String
		  
		  For i As Integer = 0 To System.LastFontIndex
		    fonts.Add(System.FontAt(i))
		  Next i
		  
		  Return fonts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320605472756560206966207468657265206973206120666F6E74206E616D65642060666F6E744E616D656020617661696C61626C6520666F7220757365206F6E207468652073797374656D2E
		Protected Function FontAvailable(fontName As String) As Boolean
		  /// Returns `True` if there is a font named `fontName` available for use on the system.
		  
		  For i As Integer = 0 To System.LastFontIndex
		    If System.FontAt(i) = fontName Then
		      Return True
		    End If
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320605472756560206966206120666F6E74206E616D65642060666F6E744E616D656020657869737473206F6E207468652073797374656D20616E64206973206D6F6E6F73706163652E
		Protected Function IsMonospaceFont(fontName As String) As Boolean
		  /// Returns `True` if a font named `fontName` exists on the system and is monospace.
		  
		  If Not FontAvailable(fontName) Then Return False
		  
		  // We need a temporary picture to test the width of the font.
		  Var tmpPic As New Picture(10, 10)
		  tmpPic.Graphics.FontName = fontName
		  tmpPic.Graphics.FontSize = 12
		  
		  // The size of two different string with the same number of characters will be the same for monospace fonts.
		  Return tmpPic.Graphics.TextWidth("abc") = tmpPic.Graphics.TextWidth("XYZ")
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A module providing helper methods for working with fonts.
		
	#tag EndNote


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
End Module
#tag EndModule
