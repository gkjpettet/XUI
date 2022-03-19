#tag Module
Protected Module XUI
	#tag Method, Flags = &h1, Description = 52657475726E732054727565206966207468657265206973206120666F6E74206E616D65642060666F6E744E616D656020617661696C61626C6520666F7220757365206F6E207468652073797374656D2E
		Protected Function FontAvailable(fontName As String) As Boolean
		  /// Returns True if there is a font named `fontName` available for use on the system.
		  
		  For i As Integer = 0 To System.LastFontIndex
		    If System.FontAt(i) = fontName Then
		      Return True
		    End If
		  Next
		  
		  Return False
		End Function
	#tag EndMethod


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
