#tag Class
Protected Class XUIWindowsTagRenderer
Implements XUITagRenderer
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITagCanvas)
		  mOwner = New WeakRef(owner)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206F776E696E67207461672063616E7661732E
		Function Owner() As XUITagCanvas
		  /// Returns the owning tag canvas.
		  ///
		  /// Part of the `XUITagFormatter` interface.
		  
		  If mOwner = Nil Or mOwner.Value = Nil Then
		    Return Nil
		  Else
		    Return XUITagCanvas(mOwner.Value)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320607461676020746F206067602061742060782C2079602E2052657475726E7320746865207820636F6F7264696E6174652061742074686520666172207269676874206F66207468652072656E6465726564207461672E
		Function Render(tag As XUITag, g As Graphics, x As Integer, y As Integer) As Double
		  /// Renders `tag` to `g` at `x, y`. Returns the x coordinate at the far right of the rendered tag.
		  ///
		  /// Part of the XUITagFormatter interface.
		  
		  // Ensure that anti-aliasing is enabled on Windows.
		  #If TargetWindows
		    g.AntiAliased = True
		  #EndIf
		  
		  // Adjust y to account for this renderer's suggested vertical padding.
		  y = y + TagVerticalPadding
		  
		  // Compute the width of the title.
		  g.FontSize = Owner.Style.FontSize
		  g.FontName = Owner.Style.FontName
		  Var titleWidth As Double = g.TextWidth(tag.Title)
		  
		  // Compute the tag height and cache (as we use it more than once).
		  Var tagH As Double = TagHeight(g)
		  
		  // Compute the width (and height as they're the same) of the close icon (dingus).
		  Var dingusWidth, dingusHeight As Double = (0.8 * tagH) / 2
		  
		  // Compute the total width of the tag and cache it.
		  Var tagW As Double = TagWidth(tag, g)
		  
		  // Tag background.
		  g.DrawingColor = Owner.Style.TagBackgroundColor
		  g.FillRoundRectangle(x, y, tagW, tagH, 2, 2)
		  
		  // Draw the title.
		  Var titleBaseline As Double = y + (g.FontAscent + (tagH - g.TextHeight) / 2)
		  g.DrawingColor = Owner.Style.TagTextColor
		  g.DrawText(tag.Title, x + mTitlePadding, titleBaseline)
		  
		  // These tags have a clickable close icon as their dingus.
		  g.DrawingColor = Owner.Style.DingusColor
		  g.PenSize = 1
		  Var dingusX As Double = x + mTitlePadding + titleWidth + mDingusLeftPadding
		  Var dingusTopLeftY As Integer = y + (tagH / 2) - (dingusHeight / 2)
		  Var dingusBottomRightY As Integer = y + (tagH / 2) + (dingusHeight / 2)
		  g.DrawLine(dingusX, dingusTopLeftY, dingusX + dingusWidth, dingusBottomRightY)
		  g.DrawLine(dingusX, dingusTopLeftY + dingusHeight, dingusX + dingusWidth, dingusTopLeftY)
		  
		  // Assign the tag's absolute bounds.
		  tag.Bounds = New Rect(x, y, tagW, tagH)
		  
		  // Assign the dingus bounds to the passed tag.
		  tag.DingusBounds = New Rect(dingusX, dingusTopLeftY, dingusWidth, dingusHeight)
		  
		  Return tagW + TagHorizontalPadding
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520686569676874206F66206120746167206261736564206F6E20746865206F776E657227732063757272656E74207374796C652E
		Function TagHeight(g As Graphics) As Integer
		  /// Returns the height of a tag based on the owner's current style.
		  ///
		  /// `g` is the graphics context that the tag would be drawn to if it was being drawn.
		  ///
		  /// Part of the XUITagFormatter interface.
		  
		  g.SaveState
		  
		  g.FontSize = Owner.Style.FontSize
		  g.FontName = Owner.Style.FontName
		  
		  Var h As Double = g.TextHeight + (2 * mVerticalPadding)
		  
		  g.RestoreState
		  
		  Return h
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520737567676573746564206E756D626572206F6620706978656C7320746F20706164206569746865722073696465206F66207461677320696E20746865207461672063616E7661732E
		Function TagHorizontalPadding() As Integer
		  /// The suggested number of pixels to pad either side of tags in the tag canvas.
		  
		  Return 3
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520737567676573746564206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F77207461677320696E20746865207461672063616E7661732E
		Function TagVerticalPadding() As Integer
		  /// The suggested number of pixels to pad above and below tags in the tag canvas.
		  
		  Return 2
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70757465732074686520746F74616C207769647468206F6620607461676020696620647261776E20746F207468652073706563696669656420677261706869637320636F6E74657874206067602E
		Function TagWidth(tag As XUITag, g As Graphics) As Double
		  /// Computes the total width of `tag` if drawn to the specified graphics context `g`.
		  
		  // Compute the width of the title.
		  g.SaveState
		  g.FontSize = Owner.Style.FontSize
		  g.FontName = Owner.Style.FontName
		  Var titleWidth As Double = g.TextWidth(tag.Title)
		  g.RestoreState
		  
		  // Compute the width of the dingus.
		  Var dingusWidth As Double = (0.8 * TagHeight(g)) / 2
		  
		  // Return the total width.
		  Return (mTitlePadding * 2) + titleWidth + _
		  mDingusLeftPadding + mDingusRightPadding + dingusWidth
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746F20746865206C656674206F662074686520636C6F73652069636F6E2E
		Private mDingusLeftPadding As Integer = 8
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746F20746865207269676874206F662074686520636C6F73652069636F6E2E
		Private mDingusRightPadding As Integer = 2
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F20746865206F776E696E67207461672063616E7661732E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C7320746F20706164206C65667420616E64207269676874206F6620746865207461672773207469746C652E
		Private mTitlePadding As Integer = 6
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F7720746865207461672773207469746C652E
		Private mVerticalPadding As Integer = 5
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
	#tag EndViewBehavior
End Class
#tag EndClass
