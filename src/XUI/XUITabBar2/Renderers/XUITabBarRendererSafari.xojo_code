#tag Class
Protected Class XUITabBarRendererSafari
Implements XUITabBarRenderer
	#tag Method, Flags = &h0, Description = 5468652063757272656E74207769647468206F66207468652062756666657220696E20706F696E74732E
		Function BufferWidth() As Integer
		  /// The current width of the buffer in points.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  If Owner = Nil Then Return 0
		  If mBuffer = Nil Then Return 0
		  Return mBuffer.Width
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITabBar2)
		  /// Part of the XUITabBarRenderer interface.
		  
		  If owner = Nil Then
		    mOwner = Nil
		  Else
		    mOwner = New WeakRef(owner)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44726177732074686520636C6F73652069636F6E20666F72206074616260206174206078602E20416C736F2073657473207468652074616227732060436C6F736549636F6E426F756E6473602E
		Private Sub DrawTabCloseIcon(tab As XUITabBar2Item, x As Integer, g As Graphics, style As XUITabBar2Style)
		  /// Draws the close icon for `tab` at `x`. Also sets the tab's `CloseIconBounds`.
		  
		  // Compute the mid height.
		  Var midY As Double = g.Height / 2
		  
		  // Set the bounds.
		  tab.CloseIconBounds = New Rect(x, midY - (CLOSE_ICON_HEIGHT / 2), CLOSE_ICON_WIDTH, CLOSE_ICON_HEIGHT)
		  
		  // The colour depends on whether the mouse is hovering over the close icon or not.
		  If tab.CloseIconBounds.Contains(Owner.MouseMoveX, Owner.MouseMoveY) Then
		    g.DrawingColor = style.HoverTabCloseColor
		  Else
		    g.DrawingColor = style.TabCloseColor
		  End If
		  
		  // Draw a cross.
		  g.PenSize = 2
		  g.DrawLine(x, midY - (CLOSE_ICON_HEIGHT / 2), x + CLOSE_ICON_WIDTH, midY + (CLOSE_ICON_HEIGHT / 2))
		  g.DrawLine(x, midY + (CLOSE_ICON_HEIGHT / 2), x + CLOSE_ICON_WIDTH, midY - (CLOSE_ICON_HEIGHT / 2))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F6620746865206C656674206D656E7520627574746F6E2028696620737570706F7274656420627920746869732072656E6465726572292E
		Function LeftMenuButtonWidth() As Double
		  /// The width Of the left menu button (If supported by this renderer).
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207461622062617220746869732072656E6465726572206F70657261746573206F6E2E
		Function Owner() As XUITabBar2
		  /// The tab bar this renderer operates on.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  If mOwner = Nil Or mOwner.Value = Nil Then
		    Return Nil
		  Else
		    Return XUITabBar2(mOwner.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696D61676520746F20626520647261776E20746F207468652074616220626172277320677261706869637320636F6E7465787420696E20697473205061696E74206576656E742E
		Sub Render(ownerGraphics As Graphics, scrollPosX As Integer, needsFullRedraw As Boolean = True)
		  /// Renders the tab bar to the passed graphics context at `scrollPosX`.
		  ///
		  /// Assumes that `ownerGraphics` is the graphics context from the tab bar's `Paint` event.
		  /// `scrollPosX` is the number of pixels (>= 0)the tab bar has been scrolled to the right. `0` is no scrolling.
		  /// `ownerGraphics` will be used as a temporary drawing scratch pad but will ultimately be overwritten when 
		  /// we draw the background and buffer to it.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  // Sanity checks.
		  If ownerGraphics = Nil Then
		    Raise New NilObjectException("Cannot render to a Nil graphics context.")
		  End If
		  If Owner = Nil Then
		    Raise New NilObjectException("Cannot render as the owning tab bar is Nil.")
		  End If
		  
		  // Can we get away without having to redraw everything?
		  If Not needsFullRedraw And mBuffer <> Nil And _
		    mBuffer.Width >= ownerGraphics.Width And mBuffer.Height >= ownerGraphics.Height Then
		    ownerGraphics.DrawPicture(mBuffer, -scrollPosX, 0)
		  End If
		  
		  // We need the owner's current style.
		  Var style As XUITabBar2Style = Owner.Style
		  If style = Nil Then
		    Raise New NilObjectException("Cannot render as the tab bar's style object is Nil.")
		  End If
		  
		  // Create a buffer of the required size. We need to sum the widths of the individual tabs.
		  // We'll also track the widest tab (since all tabs drawn by this renderer are the same width).
		  Var w, widestTab, tabW As Double = 0 
		  For Each tab As XUITabBar2Item In Owner.Tabs
		    tabW = TabWidth(tab, ownerGraphics, style)
		    widestTab = If(tabW > widestTab, tabW, widestTab)
		    w = w + tabW
		  Next tab
		  w = Max(Owner.Width, w)
		  mBuffer = Owner.Window.BitmapForCaching(w, TabBarHeight)
		  
		  // Ensure that the widest tab is widest enough to fill the tab bar and is wider than the minimum.
		  If widestTab * Owner.TabCount < mBuffer.Graphics.Width Then
		    widestTab = mBuffer.Graphics.Width / Owner.TabCount
		  End If
		  widestTab = Max(widestTab, MIN_TAB_WIDTH)
		  
		  // For brevity, grab a reference to the buffer's graphics context.
		  Var g As Graphics = mBuffer.Graphics
		  
		  // Draw the background colour.
		  g.DrawingColor = style.BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // Draw all tabs *except* the selected tab.
		  Var x, selectedTabX As Double = 0
		  Var tabs() As XUITabBar2Item = Owner.Tabs
		  For i As Integer = 0 To tabs.LastIndex
		    Var tab As XUITabBar2Item = tabs(i)
		    If i <> Owner.SelectedTabIndex Then
		      RenderTab(tab, g, x, style, widestTab)
		      x = tab.Bounds.Right
		    Else
		      // Need to store the left edge of the selected tab as we'll draw it shortly.
		      If i = 0 Then
		        selectedTabX = 0
		        // Need to increment `x` to skip over this tab.
		        x = widestTab
		      Else
		        selectedTabX = tabs(i - 1).Bounds.Right
		        // Need to increment `x` to skip over this tab.
		        x = selectedTabX + widestTab
		      End If
		    End If
		  Next i
		  
		  // Draw the selected tab.
		  If Owner.SelectedTabIndex <> -1 Then
		    If Owner.IsDraggingTab Then
		      // The selected tab is being dragged.
		      RenderTab(tabs(Owner.SelectedTabIndex), g, _
		      Owner.MouseDragX - Owner.DraggingTabLeftEdgeXOffset, style, widestTab)
		    Else
		      RenderTab(tabs(Owner.SelectedTabIndex), g, selectedTabX, style, widestTab)
		    End If
		  End If
		  
		  // Draw the buffer to the owner's graphics context.
		  ownerGraphics.DrawPicture(mBuffer, -scrollPosX, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E646572732060746162602077697468206077696474686020746F206067602C20706C6163696E6720697473206C65667420656467652061742060786020616E6420736574732069747320626F756E64732E
		Private Sub RenderTab(tab As XUITabBar2Item, g As Graphics, x As Double, style As XUITabBar2Style, width As Double)
		  /// Renders `tab` with `width` to `g`, placing its left edge at `x` and sets its bounds.
		  
		  Var leftEdge As Double = x
		  Var rightEdge As Double = x + width
		  
		  Var isSelected As Boolean = (tab = Owner.SelectedTab)
		  Var hoveredOver As Boolean = (Owner.MouseMoveX >= leftEdge And Owner.MouseMoveX <= rightEdge)
		  
		  // Background colour.
		  SetGraphicsBackgroundColor(tab, g, isSelected, hoveredOver, style)
		  g.FillRectangle(x, 0, width, g.Height)
		  
		  // ==================================================
		  // BORDERS
		  // ==================================================
		  If isSelected Then
		    // Bottom border.
		    g.DrawingColor = style.SelectedTabBottomBorderColor
		    g.DrawLine(x, g.Height - 1, x + width, g.Height - 1)
		  Else
		    g.DrawingColor = style.TabBorderColor
		    
		    // Top border.
		    g.DrawLine(x, 0, x + width, 0)
		    
		    // Bottom border.
		    g.DrawLine(x, g.Height - 1, x + width, g.Height - 1)
		  End If
		  
		  // Left border.
		  If x > 0 Or Owner.HasLeftBorder Then
		    g.DrawingColor = style.TabBorderColor
		    g.DrawLine(x, 0, x, g.Height)
		  End If
		  
		  // Right border.
		  If x < g.Width Or Owner.HasRightBorder Then
		    g.DrawingColor = style.TabBorderColor
		    g.DrawLine(x + width, 0, x + width, g.Height)
		  End If
		  
		  x = x + TAB_HORIZONTAL_PADDING
		  
		  // ==================================================
		  // CLOSE ICON
		  // ==================================================
		  If tab.Enabled And tab.Closable And hoveredOver Then
		    DrawTabCloseIcon(tab, x, g, style)
		    x = x + CLOSE_ICON_WIDTH + CLOSE_ICON_RIGHT_PADDING
		  End If
		  
		  // ==================================================
		  // CONTENT AREA
		  // ==================================================
		  // Compute the width of the icon and caption area.
		  SetGraphicsFontProperties(tab, g, isSelected, hoveredOver)
		  Var contentWidth As Double
		  If tab.Icon <> Nil Then
		    contentWidth = tab.Icon.Width + ICON_RIGHT_PADDING + g.TextWidth(tab.Caption)
		  Else
		    contentWidth = g.TextWidth(tab.Caption)
		  End If
		  
		  // Compute where the content area should be drawn at.
		  x = leftEdge + (width / 2) - (contentWidth / 2)
		  
		  // ==================================================
		  // ICON
		  // ==================================================
		  If tab.Icon <> Nil Then
		    g.DrawPicture(tab.Icon, x, (g.Height / 2) - (tab.Icon.Height / 2))
		    x = x + tab.Icon.Width + ICON_RIGHT_PADDING
		  End If
		  
		  // ==================================================
		  // CAPTION
		  // ==================================================
		  Var baseline As Double = g.FontAscent + (g.Height - g.TextHeight) / 2
		  g.DrawText(tab.Caption, x, baseline)
		  
		  // ==================================================
		  // TAB BOUNDS
		  // ==================================================
		  tab.Bounds = New Rect(leftEdge, 0, width, TabBarHeight)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468204F6620746865207269676874206D656E7520627574746F6E2028496620737570706F7274656420627920746869732072656E6465726572292E
		Function RightMenuButtonWidth() As Double
		  /// The width Of the right menu button (If supported by this renderer).
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5365747320746865206261636B67726F756E642064726177696E6720636F6C6F7572206F662060676020746F2074686F736520726571756972656420666F722074686973207461622E
		Private Sub SetGraphicsBackgroundColor(tab As XUITabBar2Item, g As Graphics, isSelected As Boolean, hoveredOver As Boolean, style As XUITabBar2Style)
		  /// Sets the background drawing colour of `g` to those required for `tab`.
		  
		  If isSelected Then
		    g.DrawingColor = style.SelectedTabBackgroundColor
		    
		  ElseIf tab.Enabled = False Then
		    g.DrawingColor = style.DisabledTabBackgroundColor
		    
		  ElseIf hoveredOver Then
		    g.DrawingColor = style.HoverTabBackgroundColor
		    
		  Else
		    // Inactive tab.
		    g.DrawingColor = style.InactiveTabBackgroundColor
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 536574732074686520666F6E742070726F70657274696573206F662060676020746F2074686F736520726571756972656420666F722060746162602E
		Private Sub SetGraphicsFontProperties(tab As XUITabBar2Item, g As Graphics, isSelected As Boolean, hoveredOver As Boolean)
		  /// Sets the font properties of `g` to those required for `tab`.
		  
		  Var style As XUITabBar2Style = Owner.Style
		  
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  g.Bold = False
		  g.Italic = False
		  
		  If isSelected Then
		    g.DrawingColor = style.SelectedTabTextColor
		    
		  ElseIf tab.Enabled = False Then
		    g.DrawingColor = style.DisabledTabTextColor
		    
		  ElseIf hoveredOver Then
		    g.DrawingColor = style.HoverTabTextColor
		    
		  Else
		    g.DrawingColor = style.InactiveTabTextColor
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620746869732072656E646572657220737570706F7274732074686520636F6E63657074206F662061206C656674206D656E7520627574746F6E2E
		Function SupportsLeftMenuButton() As Boolean
		  /// True if this renderer supports the concept of a left menu button.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620746869732072656E646572657220737570706F7274732074686520636F6E63657074206F662061207269676874206D656E7520627574746F6E2E
		Function SupportsRightMenuButton() As Boolean
		  /// True if this renderer supports the concept of a right menu button.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206865696768742074686520746162206261722077696C6C2062652072656E64657265642061742E
		Function TabBarHeight() As Integer
		  /// Returns the height the tab bar will be rendered at.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return 28
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865207769647468206F66206074616260206966206974207765726520647261776E20746F206067602E
		Private Function TabWidth(tab As XUITabBar2Item, g As Graphics, style As XUITabBar2Style) As Double
		  /// Returns the width of `tab` if it were drawn to `g`.
		  
		  // Factor in the horizontal padding.
		  Var w As Double = 2 * CONTENTS_HORIZONTAL_PADDING
		  
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  
		  // Close icon.
		  If tab.Enabled And tab.Closable Then
		    w = w + CLOSE_ICON_WIDTH + CLOSE_ICON_RIGHT_PADDING
		  End If
		  
		  // Icon & caption widths.
		  If tab.Icon <> Nil Then
		    w = w + tab.Icon.Width + ICON_RIGHT_PADDING + g.TextWidth(tab.Caption)
		  Else
		    w = w + g.TextWidth(tab.Caption)
		  End If
		  
		  // Ensure the tab is at least the minimal width.
		  Return Max(MIN_TAB_WIDTH, w)
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 4361636865206F662074686520506963747572652072657475726E65642066726F6D20746865206C6173742063616C6C20746F206058554954616242617252656E6465722E4275666665722829602E204D6179206265204E696C2E
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F207468652074616220626172207468617420746869732072656E6465726572206F70657261746573206F6E2E
		Private mOwner As WeakRef
	#tag EndProperty


	#tag Constant, Name = CLOSE_ICON_HEIGHT, Type = Double, Dynamic = False, Default = \"6", Scope = Private, Description = 54686520686569676874206F662074686520636C6F73652069636F6E2E
	#tag EndConstant

	#tag Constant, Name = CLOSE_ICON_RIGHT_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 486F77206D75636820746F2070616420746865207269676874206F662074686520636C6F73652069636F6E20286966207468652074616220697320636C6F7361626C65292E
	#tag EndConstant

	#tag Constant, Name = CLOSE_ICON_WIDTH, Type = Double, Dynamic = False, Default = \"6", Scope = Private, Description = 546865207769647468206F662074686520636C6F73652069636F6E2E
	#tag EndConstant

	#tag Constant, Name = CONTENTS_HORIZONTAL_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 486F77206D75636820746F20706164206C65667420616E64207269676874206F662074686520636F6E74656E7473206F6620746865207461622028636C6F73652069636F6E2C2069636F6E20616E642063617074696F6E292E
	#tag EndConstant

	#tag Constant, Name = ICON_RIGHT_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 686F77206D75636820746F20706164207468652072696768742073696465206F66207468652069636F6E2066726F6D207468652074616227732063617074696F6E2E
	#tag EndConstant

	#tag Constant, Name = MIN_TAB_WIDTH, Type = Double, Dynamic = False, Default = \"120", Scope = Private, Description = 546865206D696E696D756D2077696474682061207461622073686F756C642062652E
	#tag EndConstant

	#tag Constant, Name = TAB_HORIZONTAL_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private
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
