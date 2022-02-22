#tag Class
Protected Class XUIWindowsTagRenderer
Implements XUITagRenderer
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITagCanvas)
		  mOwner = New WeakRef(owner)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E73206120746167207374796C6564206C696B6520746865207461677320696E2057696E646F77277320546F6B656E697A696E67546578744669656C6420636F6E74726F6C2E
		Function CreateTag(tagData As XUITagData, g As Graphics) As XUITag
		  /// Creates and returns a tag styled like the tags in Window's TokenizingTextField control.
		  ///
		  /// `g` is the tag canvas' graphics context that the tag will be drawn to. It is required to compute the
		  /// width of the tag and ensure the correct scale factor.
		  ///
		  /// Part of the XUITagFormatter interface.
		  
		  #Pragma Warning "TODO: Style like the Windows tokenizing text field control"
		  
		  // Compute the width of the title. Only temporarily alter the passed in graphics context.
		  g.SaveState
		  g.FontSize = Owner.Style.FontSize
		  g.FontName = Owner.Style.FontName
		  Var titleWidth As Double = g.TextWidth(tagData.Title)
		  
		  // Compute the tag height and cache (as we use it more than once).
		  Var tagH As Double = TagHeight(g)
		  
		  // Compute the width (and height as they're the same) of the close icon (dingus).
		  Var dingusWidth, dingusHeight As Double = (0.8 * tagH) / g.ScaleX
		  
		  // Compute the total width of the tag.
		  Var tagWidth As Double = (mTitlePadding * 2) + titleWidth + _
		  mDingusLeftPadding + mDingusRightPadding + dingusWidth
		  
		  // Create the blank tag image.
		  Var p As Picture = Owner.Window.BitmapForCaching(tagWidth, tagH)
		  
		  // Tag background.
		  p.Graphics.DrawingColor = Owner.Style.TagBackgroundColor
		  p.Graphics.FillRoundRectangle(0, 0, p.Graphics.Width, p.Graphics.Height, 2, 2)
		  
		  // Draw the title.
		  p.Graphics.FontName = Owner.Style.FontName
		  p.Graphics.FontSize = Owner.Style.FontSize
		  Var titleBaseline As Double = p.Graphics.FontAscent + (p.Graphics.Height - p.Graphics.TextHeight) / 2
		  p.Graphics.DrawingColor = Owner.Style.TagTextColor
		  p.Graphics.DrawText(tagData.Title, mTitlePadding, titleBaseline)
		  
		  // These tags have a clickable close icon as their dingus.
		  p.Graphics.DrawingColor = Owner.Style.DingusColor
		  p.Graphics.PenSize = 1
		  Var dingusX As Double = mTitlePadding + titleWidth + mDingusLeftPadding
		  Var dingusTopLeftY As Integer = (p.Graphics.Height / 2) - (dingusHeight / 2)
		  Var dingusBottomRightY As Integer = (p.Graphics.Height / 2) + (dingusHeight / 2)
		  p.Graphics.DrawLine(dingusX, dingusTopLeftY, dingusX + dingusWidth, dingusBottomRightY)
		  p.Graphics.DrawLine(dingusX, dingusTopLeftY + dingusHeight, dingusX + dingusWidth, dingusTopLeftY)
		  
		  Var tag As New XUITag
		  tag.Image = p
		  tag.Title = tagData.Title
		  tag.Data = tagData.Data
		  
		  g.RestoreState
		  
		  Return tag
		  
		  
		End Function
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

	#tag Method, Flags = &h0
		Sub Render(tag As XUITag, g As Graphics, x As Integer, y As Integer)
		  
		End Sub
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
