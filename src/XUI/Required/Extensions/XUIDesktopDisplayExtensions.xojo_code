#tag Module
Protected Module XUIDesktopDisplayExtensions
	#tag Method, Flags = &h0, Description = 52657475726E732074686520626F756E6473206F6620606460206173206120526563742E
		Function Bounds(Extends d As DesktopDisplay) As Rect
		  /// Returns the bounds of `d` as a Rect.
		  
		  Return New Rect(d.Left, d.Top, d.AvailableWidth, d.AvailableHeight)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A module containing extension methods for the Xojo `DesktopDisplay` class.
		
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
