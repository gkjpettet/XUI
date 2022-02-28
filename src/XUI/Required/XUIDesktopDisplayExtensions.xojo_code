#tag Module
Protected Module XUIDesktopDisplayExtensions
	#tag Method, Flags = &h0, Description = 52657475726E732074686520626F756E6473206F6620606460206173206120526563742E
		Function Bounds(Extends d As DesktopDisplay) As Rect
		  /// Returns the bounds of `d` as a Rect.
		  
		  Return New Rect(d.Left, d.Top, d.AvailableWidth, d.AvailableHeight)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520646973706C6179207468617420636F6E7461696E73207468652067726561746573742070726F706F7274696F6E206F6620607760206F72204E696C206966206E6F20646973706C617920636F6E7461696E732069742E
		Function Display(Extends w As DesktopWindow) As DesktopDisplay
		  /// Returns the display that contains the greatest proportion of `w` or Nil if no display contains it.
		  
		  Var index As Integer = w.DisplayIndex
		  
		  If index = -1 Then
		    Return Nil
		  Else
		    Return DesktopDisplay.DisplayAt(index)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696E646578206F662074686520666972737420646973706C61792060776020697320666F756E64206F6E206F7220602D3160206966206E6F7420666F756E642E
		Function DisplayIndex(Extends w As DesktopWindow) As Integer
		  /// Returns the index of the first display `w` is found on or `-1` if not found.
		  
		  Var maxOverlap As Double = 0
		  Var maxOverlapIndex As Integer = -1
		  For i As Integer = 0 To DesktopDisplay.DisplayCount - 1
		    Var overlap As Double = DesktopDisplay.DisplayAt(i).Bounds.Overlap(w.Bounds)
		    
		    If overlap = 1.0 Then
		      // Perfect overlap. The display bounds completely overlaps the window bounds.
		      Return i
		    ElseIf overlap > maxOverlap Then
		      maxOverlap = overlap
		      maxOverlapIndex = i
		    End If
		  Next i
		  
		  Return maxOverlapIndex
		  
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