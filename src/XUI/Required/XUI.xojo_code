#tag Module
Protected Module XUI
	#tag Method, Flags = &h0, Description = 52657475726E732074686520666972737420646973706C61792060776020697320707265736574206F6E2E
		Function Display(Extends w As DesktopWindow) As DesktopDisplay
		  /// Returns the first display `w` is preset on.
		  
		  #Pragma Warning "TODO: Test this thoroughly"
		  
		  For i As Integer = 0 To DesktopDisplay.DisplayCount
		    Var display As DesktopDisplay = DesktopDisplay.DisplayAt(i)
		    
		    Var displayBounds As New Rect(display.Left, display.Top, display.AvailableWidth, display.AvailableHeight)
		    
		    If displayBounds.Intersects(w.Bounds) Then Return display
		    
		  Next i
		  
		  // Didn't find the containing display so just return the main display.
		  Return DesktopDisplay.DisplayAt(0)
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
