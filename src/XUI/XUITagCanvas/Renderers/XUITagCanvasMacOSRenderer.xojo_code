#tag Class
Protected Class XUITagCanvasMacOSRenderer
Implements XUITagCanvasRenderer
	#tag Method, Flags = &h0
		Function AutocompleteHorizontalPadding() As Integer
		  /// The suggested number of pixels to pad to the left and right of autocomplete options in 
		  /// the autocomplete popup.
		  ///
		  /// Part of the XUITagCanvasRenderer interface.
		  
		  Return 10
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
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

	#tag Method, Flags = &h0
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
		  
		  Return 10
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F76652074686520666972737420616E642062656C6F7720746865206C617374206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		Function AutocompleteVerticalPadding() As Integer
		  /// The number of pixels to pad above the first and below the last 
		  /// autocomplete options in the autocomplete popup.
		  
		  Return 5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITagCanvas)
		  mOwner = New WeakRef(owner)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
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

	#tag Method, Flags = &h0, Description = 52656E6465727320616E642072657475726E732061207069637475726520666F72207468652063616E766173206175746F636F6D706C65746520706F7075702E
		Function RenderAutocompletePopup(maxWidth As Integer, selectedIndex As Integer) As Picture
		  /// Renders and returns a picture for the canvas autocomplete popup.
		  
		  Var buffer As Picture
		  
		  // We need a temporary graphics context to get the width of the longest option.
		  Var tmpPic As Picture = Owner.Window.BitmapForCaching(1, 1)
		  tmpPic.Graphics.FontName = Owner.Style.FontName
		  tmpPic.Graphics.FontSize = Owner.Style.FontSize
		  
		  // Compute the required width of the buffer.
		  Var longestOptionW As Double = tmpPic.Graphics.TextWidth(Owner.AutocompleteData.LongestOptionValue)
		  Var bufferW As Double = Min(longestOptionW + (2 * AutocompleteHorizontalPadding) + _
		  (2 * SELECTED_OPTION_H_PADDING), maxWidth)
		  
		  Var lineH As Double = AutocompleteOptionHeight
		  
		  // Compute the required height of the buffer.
		  Var bufferH As Integer = (lineH * Owner.AutocompleteData.Options.Count) + _
		  (Owner.AutocompleteData.Options.Count * AutocompleteOptionVerticalPadding) + _
		  (2 * AutocompleteVerticalPadding)
		  
		  // Create a new HiDPI aware buffer picture.
		  buffer = Owner.Window.BitmapForCaching(bufferW, bufferH)
		  
		  // Grab a reference to the buffer's graphics context.
		  Var g As Graphics = buffer.Graphics
		  
		  // For bevity grab a reference to the style to use.
		  Var style As XUITagCanvasStyle = Owner.Style
		  
		  // Background.
		  g.DrawingColor = style.AutocompletePopupBackgroundColor
		  g.FillRoundRectangle(0, 0, g.Width, g.Height, _
		  AutocompletePopupBorderRadius, AutocompletePopupBorderRadius)
		  
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
		    If i = selectedIndex Then
		      // Draw the selection background.
		      g.DrawingColor = style.SelectedAutocompleteOptionBackgroundColor
		      g.FillRoundRectangle(SELECTED_OPTION_H_PADDING, y, _
		      g.Width - (2 * SELECTED_OPTION_H_PADDING), lineH, _
		      SELECTED_OPTION_BORDER_RADIUS, SELECTED_OPTION_BORDER_RADIUS)
		    End If
		    
		    // Draw the option value.
		    If i = SelectedIndex Then
		      g.DrawingColor = style.SelectedAutocompleteOptionColor
		    Else
		      g.DrawingColor = style.AutocompleteOptionColour
		    End If
		    g.DrawText(option.Value, x + SELECTED_OPTION_H_PADDING, y + optionBaseline)
		    
		    y = y + lineH + AutocompleteOptionVerticalPadding
		  Next i
		  
		  Return buffer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RenderTag(tag As XUITag, g As Graphics, x As Integer, y As Integer, hasDingus As Boolean) As Double
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
		  
		  // Compute the width and height of the drop down icon (dingus).
		  Var dingusWidth, dingusHeight As Double = 0
		  If hasDingus Then
		    dingusWidth = (0.7 * tagH) / 2
		    dingusHeight = dingusWidth / 2
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
		  
		  Var dingusX, dingusTopY As Double = 0
		  If hasDingus Then
		    // These tags have a clickable drop down inverted caret icon as their dingus.
		    g.DrawingColor = Owner.Style.DingusColor
		    g.PenSize = 1
		    dingusX = x + mTitlePadding + titleWidth + mDingusLeftPadding
		    dingusTopY = y + (tagH / 2) - (dingusHeight / 2)
		    Var dingusBottomY As Double = y + (tagH / 2) + (dingusHeight / 2)
		    g.DrawLine(dingusX, dingusTopY, dingusX + (dingusWidth / 2), dingusBottomY)
		    g.DrawLine(dingusX + (dingusWidth / 2), dingusBottomY, dingusX + dingusWidth, dingusTopY)
		  End If
		  
		  // Assign the tag's absolute bounds.
		  tag.Bounds = New Rect(x, y, tagW, tagH)
		  
		  // Assign the dingus bounds to the passed tag.
		  If hasDingus Then
		    tag.DingusBounds = New Rect(dingusX, dingusTopY, dingusWidth, dingusHeight)
		  Else
		    tag.DingusBounds = Nil
		  End If
		  
		  Return tagW + TagHorizontalPadding
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
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

	#tag Method, Flags = &h0
		Function TagHorizontalPadding() As Integer
		  /// The suggested number of pixels to pad either side of tags in the tag canvas.
		  
		  Return 3
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TagVerticalPadding() As Integer
		  /// The suggested number of pixels to pad above and below tags in the tag canvas.
		  
		  Return 2
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
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


	#tag Note, Name = About
		Renders tags and the autocomplete popup in a way that mimics tags on macOS. Examples on macOS include
		Mail.app.
		
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746F20746865206C656674206F66207468652064726F7020646F776E2069636F6E2E
		Private mDingusLeftPadding As Integer = 4
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746F20746865207269676874206F66207468652064726F7020646F776E2069636F6E2E
		Private mDingusRightPadding As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F20746865206F776E696E67207461672063616E7661732E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C7320746F20706164206C65667420616E64207269676874206F6620746865207461672773207469746C652E
		Private mTitlePadding As Integer = 6
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F7720746865207461672773207469746C652E
		Private mVerticalPadding As Integer = 3
	#tag EndProperty


	#tag Constant, Name = SELECTED_OPTION_BORDER_RADIUS, Type = Double, Dynamic = False, Default = \"7", Scope = Private, Description = 54686520626F726465722072616469757320666F7220746865206261636B67726F756E64206F66207468652063757272656E746C792073656C6563746564206175746F636F6D706C657465206F7074696F6E20696E2074686520706F7075702E
	#tag EndConstant

	#tag Constant, Name = SELECTED_OPTION_H_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746F20746865206C65667420616E64207269676874206F6620612073656C6563746564206175746F636F6D706C657465206F7074696F6E20696E2074686520706F7075702E20
	#tag EndConstant


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
