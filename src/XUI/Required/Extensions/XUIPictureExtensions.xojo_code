#tag Module
Protected Module XUIPictureExtensions
	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720706963747572652074686174206973206120726573697A65642076657273696F6E206F66206070602E20496620606F6E6C79536872696E6B602069732054727565207468656E2077652077696C6C206E6576657220656E6C61726765206070602E
		Function ResizeToFit(Extends p As Picture, maxWidth As Integer, maxHeight As Integer, scaleMode As XUIPictureScaleModes = XUIPictureScaleModes.ToFit, onlyShrink As Boolean = False) As Picture
		  /// Returns a new picture that is a resized version of `p`.
		  /// If `onlyShrink` is True then we will never enlarge `p`.
		  ///
		  /// Based on code by [Sam Rowlands][1].
		  ///
		  /// [1]: https://forum.xojo.com/t/proportionally-resizing-a-picture/16732/11
		  
		  Var newSize As Size
		  
		  Select Case scaleMode
		  Case XUIPicturescaleModes.ToFit, XUIPicturescaleModes.ToFill
		    Var scale As Double
		    If scaleMode = XUIPicturescaleModes.ToFit Then
		      scale = Min(maxHeight / p.Height, maxWidth / p.Width)
		    Else
		      scale = Max(maxHeight / p.Height, maxWidth / p.Width)
		    End If
		    
		    If onlyShrink Then scale = Min(scale, 1.0 )
		    
		    newSize = New Size(Floor(p.Width * scale), Floor(p.Height * scale))
		    
		  Case XUIPictureScaleModes.StretchToFill
		    newSize = New Size(maxWidth, maxHeight)
		  End Select
		  
		  // Create the target image and draw our image into the centre.
		  Var newPic As New Picture(Min(newSize.Width, maxWidth), Min(newSize.Height, maxHeight))
		  newPic.Graphics.DrawPicture(p, (newPic.Width - newSize.Width) * 0.5, (newPic.Height - newSize.Height) * 0.5, _
		  newPic.Width, newPic.Height, 0, 0, p.Width, p.Height)
		  
		  Return newPic
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A module containing extension methods for the Xojo `Picture` class.
		
	#tag EndNote


	#tag Enum, Name = XUIPictureScaleModes, Type = Integer, Flags = &h0, Description = 54686520737570706F72746564207761797320746F207363616C65206120706963747572652E
		ToFill
		  ToFit
		StretchToFill
	#tag EndEnum


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
