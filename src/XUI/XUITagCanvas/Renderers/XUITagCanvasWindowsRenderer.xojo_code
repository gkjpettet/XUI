#tag Class
Protected Class XUITagCanvasWindowsRenderer
Implements XUITagCanvasRenderer
	#tag Method, Flags = &h0, Description = 54686520737567676573746564206E756D626572206F6620706978656C7320746F2070616420746F20746865206C65667420616E64207269676874206F66206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		Function AutocompleteHorizontalPadding() As Integer
		  /// The suggested number of pixels to pad to the left and right of autocomplete options in 
		  /// the autocomplete popup.
		  ///
		  /// Part of the XUITagCanvasRenderer interface.
		  
		  Return 10
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520686569676874206F6620616E206175746F636F6D706C657465206F7074696F6E20696E20746865206175746F636F6D706C65746520706F707570206261736564206F6E20746865206F776E657227732063757272656E74207374796C652E
		Function AutocompleteOptionHeight() As Integer
		  /// Returns the height of an autocomplete option in the autocomplete popup based on the 
		  /// owner's current style.
		  ///
		  /// Part of the XUITagCanvasRenderer interface.
		  
		  Var tmp As Picture = Owner.Window.BitmapForCaching(10, 10)
		  
		  tmp.Graphics.FontSize = Owner.Style.FontSize
		  tmp.Graphics.FontName = Owner.Style.FontName
		  
		  Var h As Double = tmp.Graphics.TextHeight + (2 * mVerticalPadding)
		  
		  Return h
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520737567676573746564206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F77206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		Function AutocompleteOptionVerticalPadding() As Integer
		  /// The suggested number of pixels to pad above and below autocomplete options in the autocomplete popup.
		  ///
		  /// Part of the XUITagCanvasRenderer interface.
		  
		  Return 2
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520626F7264657220726164697573206F6620746865206175746F636F6D706C65746520706F7075702E
		Function AutocompletePopupBorderRadius() As Integer
		  /// The border radius of the autocomplete popup.
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F76652074686520666972737420616E642062656C6F7720746865206C61737420206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		Function AutocompleteVerticalPadding() As Integer
		  /// The number of pixels to pad above the first and below the last  autocomplete options in the autocomplete popup.
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITagCanvas)
		  mOwner = New WeakRef(owner)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E20696D616765206F6620616C6C206175746F636F6D706C657465206F7074696F6E7320666F722072656E646572696E6720746F20746865206175746F636F6D706C65746520706F7075702E
		Function ImageForAutocompletePopup(maxWidth As Integer, selectedIndex As Integer) As Picture
		  /// Rebuilds the entire buffer by drawing all visible content to it.
		  
		  Var buffer As Picture
		  
		  // We need a temporary graphics context to get the width of the longest option.
		  Var tmpPic As Picture = Owner.Window.BitmapForCaching(1, 1)
		  tmpPic.Graphics.FontName = Owner.Style.FontName
		  tmpPic.Graphics.FontSize = Owner.Style.FontSize
		  
		  // Compute the required width of the buffer.
		  Var longestOptionW As Double = tmpPic.Graphics.TextWidth(Owner.AutocompleteData.LongestOptionValue)
		  Var bufferW As Double = Min(longestOptionW + (2 * AutocompleteHorizontalPadding), maxWidth)
		  
		  Var lineH As Double = AutocompleteOptionHeight
		  
		  // Compute the required height of the buffer.
		  Var bufferH As Integer = (lineH * Owner.AutocompleteData.Options.Count) + _
		  (Owner.AutocompleteData.Options.Count * AutocompleteOptionVerticalPadding)
		  
		  // Create a new HiDPI aware buffer picture.
		  buffer = Owner.Window.BitmapForCaching(bufferW, bufferH)
		  
		  // Grab a reference to the buffer's graphics context.
		  Var g As Graphics = buffer.Graphics
		  
		  // For bevity grab a reference to the style to use.
		  Var style As XUITagCanvasStyle = Owner.Style
		  
		  // Background.
		  g.DrawingColor = style.AutocompletePopupBackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  g.FontName = Owner.Style.FontName
		  g.FontSize = Owner.Style.FontSize
		  
		  // If there's only one option, make sure it's selected.
		  If Owner.AutocompleteData.Options.Count = 1 Then selectedIndex = 0
		  If selectedIndex = -1 Then selectedIndex = 0
		  
		  // Draw the options.
		  Var textH As Double = g.TextHeight
		  Var x As Double = AutocompleteHorizontalPadding
		  Var optionBaseline As Double = g.FontAscent + ((lineH - textH) / 2)
		  Var y As Double = AutocompleteVerticalPadding + AutocompleteOptionVerticalPadding
		  Var iMax As Integer = Owner.AutocompleteData.Options.LastIndex
		  For i As Integer = 0 To iMax
		    Var option As XUITagAutocompleteOption = Owner.AutocompleteData.Options(i)
		    If i = SelectedIndex Then
		      // Draw the selection background.
		      g.DrawingColor = style.SelectedAutocompleteOptionBackgroundColor
		      g.FillRectangle(0, y, g.Width, lineH)
		    End If
		    
		    // Draw the option value.
		    If i = selectedIndex Then
		      g.DrawingColor = style.SelectedAutocompleteOptionColor
		    Else
		      g.DrawingColor = style.AutocompleteOptionColour
		    End If
		    g.DrawText(option.Value, x, y + optionBaseline)
		    
		    y = y + lineH + AutocompleteOptionVerticalPadding
		  Next i
		  
		  Return buffer
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

	#tag Method, Flags = &h0, Description = 52656E6465727320607461676020746F206067602061742060782C2079602E2052657475726E7320746865207820636F6F7264696E6174652061742074686520666172207269676874206F66207468652072656E6465726564207461672E
		Function Render(tag As XUITag, g As Graphics, x As Integer, y As Integer, hasDingus As Boolean) As Double
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
		  Var dingusWidth, dingusHeight As Double = 0
		  If hasDingus Then
		    dingusWidth = (0.8 * tagH) / 2
		    dingusHeight = dingusWidth
		  End If
		  
		  // Compute the total width of the tag and cache it.
		  Var tagW As Double = TagWidth(tag, g)
		  
		  // Tag background.
		  g.DrawingColor = Owner.Style.TagBackgroundColor
		  g.FillRoundRectangle(x, y, tagW, tagH, 2, 2)
		  
		  // Draw the title.
		  Var titleBaseline As Double = y + (g.FontAscent + (tagH - g.TextHeight) / 2)
		  g.DrawingColor = Owner.Style.TagTextColor
		  g.DrawText(tag.Title, x + mTitlePadding, titleBaseline)
		  
		  Var dingusX, dingusTopLeftY As Double = 0
		  If hasDingus Then
		    // These tags have a clickable close icon as their dingus.
		    g.DrawingColor = Owner.Style.DingusColor
		    g.PenSize = 1
		    dingusX = x + mTitlePadding + titleWidth + mDingusLeftPadding
		    dingusTopLeftY = y + (tagH / 2) - (dingusHeight / 2)
		    Var dingusBottomRightY As Integer = y + (tagH / 2) + (dingusHeight / 2)
		    g.DrawLine(dingusX, dingusTopLeftY, dingusX + dingusWidth, dingusBottomRightY)
		    g.DrawLine(dingusX, dingusTopLeftY + dingusHeight, dingusX + dingusWidth, dingusTopLeftY)
		  End If
		  
		  // Assign the tag's absolute bounds.
		  tag.Bounds = New Rect(x, y, tagW, tagH)
		  
		  // Assign the dingus bounds to the passed tag.
		  If hasDingus Then
		    tag.DingusBounds = New Rect(dingusX, dingusTopLeftY, dingusWidth, dingusHeight)
		  Else
		    tag.DingusBounds = Nil
		  End If
		  
		  Return tagW + TagHorizontalPadding
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520686569676874206F66206120746167206261736564206F6E20746865206F776E657227732063757272656E74207374796C652E
		Function TagHeight(g As Graphics) As Integer
		  /// Returns the height of a tag based on the owner's current style.
		  ///
		  /// `g` is the graphics context that the tag would be drawn to if it was being drawn.
		  ///
		  /// Part of the XUITagCanvasRenderer interface.
		  
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
		  
		  // Compute the width of the dingus and any padding.
		  Var dingusWidth As Double = 0
		  Var dingusPadding As Integer = 0
		  If Owner.TagsHaveDingus Then
		    dingusWidth = (0.8 * TagHeight(g)) / 2
		    dingusPadding = mDingusLeftPadding + mDingusRightPadding
		  End If
		  
		  // Return the total width.
		  Return (mTitlePadding * 2) + titleWidth + dingusPadding + dingusWidth
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
