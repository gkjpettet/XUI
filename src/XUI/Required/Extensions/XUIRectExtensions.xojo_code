#tag Module
Protected Module XUIRectExtensions
	#tag Method, Flags = &h0, Description = 52657475726E73207468652061726561206F662052656374206072602E
		Function Area(Extends r As Rect) As Double
		  /// Returns the area of Rect `r`.
		  
		  Return r.Width * r.Height
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652070657263656E74616765206F66206F7665726C6170206265747765656E2052656374732060416020616E64206042602E20312E302069732070657266656374206F7665726C61702C20302E30206973206E6F206F7665726C61702E
		Function Overlap(Extends A As Rect, B As Rect) As Double
		  /// Returns the percentage of overlap between Rects `A` and `B`. 1.0 is perfect overlap, 0.0 is no overlap.
		  ///
		  /// [StackOverflow post][1].
		  /// 
		  /// [1]: https://stackoverflow.com/questions/9324339/how-much-do-two-rectangles-overlap
		  
		  Var intersectingArea As Double = _
		  Max(0, Min(A.Origin.X + A.Width, B.Origin.X + B.Width) - Max(A.Origin.X, B.Origin.X)) * _
		  Max(0, Min(A.Origin.Y + A.Height, B.Origin.Y + B.Height) - Max(A.Origin.Y, B.Origin.Y))
		  
		  Return intersectingArea / (A.Area + B.Area - intersectingArea)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A module containing extension methods for the Xojo `Rect` class.
		
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
