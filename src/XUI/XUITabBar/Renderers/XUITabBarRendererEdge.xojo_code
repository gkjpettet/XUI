#tag Class
Protected Class XUITabBarRendererEdge
Implements XUITabBarRenderer
	#tag Method, Flags = &h0, Description = 5468652063757272656E74207769647468206F66207468652062756666657220696E20706F696E74732E
		Function BufferWidth() As Integer
		  /// The current width of the buffer in points.
		  ///
		  /// Part of the `XUITabBarRenderer` interface.
		  
		  If Owner = Nil Then Return 0
		  If mBuffer = Nil Then Return 0
		  Return mBuffer.Width
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 606F776E657260206973207468652060585549546162426172602074686174206F776E7320746869732072656E64657265722E204120605765616B526566602077696C6C20626520637265617465642E
		Sub Constructor(owner As XUITabBar)
		  /// `owner` is the `XUITabBar` that owns this renderer. A `WeakRef` will be created.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  If owner = Nil Then
		    mOwner = Nil
		  Else
		    mOwner = New WeakRef(owner)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4472617773207468652074616220626F726465727320746F20606760207573696E6720607374796C65602E
		Private Sub DrawTabBorders(g As Graphics, style As XUITabBarStyle)
		  /// Draws the tab borders to `g` using `style`.
		  ///
		  /// This is the last step in rendering the tab bar's buffer. We do it separate from rendering the tabs
		  /// because there are several edge cases to deal with that we can more gracefully handle after all
		  /// tabs have been rendered.
		  
		  Var tabs() As XUITabBarItem = Owner.Tabs
		  
		  If tabs.Count = 0 Then Return
		  
		  g.DrawingColor = style.TabBorderColor
		  g.PenSize = 1
		  
		  Var borderTop As Double = BORDER_VERT_PADDING
		  Var borderHeight As Double = g.Height - (2 * BORDER_VERT_PADDING)
		  Var borderBottom As Double = borderTop + borderHeight
		  
		  // Edge case: The first tab needs a left border if it is not selected.
		  If Owner.SelectedTabIndex <> 0 And Owner.HasLeftMenuButton Then
		    g.DrawLine(tabs(0).Bounds.Left, borderTop, tabs(0).Bounds.Left, borderBottom)
		  End If
		  
		  // Every *unselected* tab needs a right border *except* the tab before the selected one.
		  // Find the index of this tab to skip.
		  Var skipIndex As Integer = -1
		  If Owner.SelectedTabIndex > 0 Then skipIndex = Owner.SelectedTabIndex - 1
		  
		  // Draw the right borders on the selected tabs.
		  For i As Integer = 0 To tabs.LastIndex
		    If i = Owner.SelectedTabIndex Then Continue
		    If i = skipIndex Then Continue
		    Var tab As XUITabBarItem = tabs(i)
		    g.DrawLine(tab.Bounds.Right - 1, borderTop, tab.Bounds.Right - 1, borderBottom)
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawTabCloseIcon(tab As XUITabBarItem, g As Graphics, x As Double, style As XUITabBarStyle)
		  /// Draws this tab's close icon to `g` at `x`. Also sets the tab's `CloseIconBounds`.
		  ///
		  /// Assumes this tab has a close icon.
		  
		  // Compute the mid height.
		  Var midY As Double = g.Height / 2
		  
		  // Set the bounds.
		  tab.CloseIconBounds = New Rect(x, midY - (CLOSE_ICON_HEIGHT / 2), CLOSE_ICON_WIDTH, CLOSE_ICON_HEIGHT)
		  
		  // The appearance depends on whether the mouse is hovering over the close icon or not.
		  Var hoveringOverCloseIcon As Boolean = _
		  tab.CloseIconBounds.Contains(Owner.MouseMoveX + Owner.ScrollPosX, Owner.MouseMoveY)
		  
		  // Draw a rounded rect background if hovered over.
		  If hoveringOverCloseIcon Then
		    g.DrawingColor = style.HoverTabCloseColor
		    g.FillRoundRectangle(tab.CloseIconBounds.Left, tab.CloseIconBounds.Top, _
		    tab.CloseIconBounds.Width, tab.CloseIconBounds.Height, 3, 3)
		  End If
		  
		  // Draw a cross.
		  If hoveringOverCloseIcon Then
		    g.DrawingColor = style.HoverTabTextColor
		  Else
		    g.DrawingColor = style.TabCloseColor
		  End If
		  g.PenSize = 2
		  // Every -1 below is a fudge.
		  Var crossStartX As Double = x + (CLOSE_ICON_WIDTH / 2) - (CLOSE_ICON_CROSS_WIDTH / 2) - 1
		  Var crossEndX As Double = crossStartX + CLOSE_ICON_CROSS_WIDTH
		  Var halfCrossH As Double = CLOSE_ICON_CROSS_HEIGHT / 2
		  g.DrawLine(crossStartX, midY - halfCrossH - 1, crossEndX, midY + halfCrossH - 1)
		  g.DrawLine(crossStartX, midY + halfCrossH - 1, crossEndX, midY - halfCrossH - 1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F6620746865206C656674206D656E7520627574746F6E2028696620737570706F7274656420627920746869732072656E6465726572292E
		Function LeftMenuButtonWidth() As Double
		  /// The width of the left menu button (if supported by this renderer).
		  ///
		  /// Part of the `XUITabBarRenderer` interface.
		  
		  Return (2 * LEFT_MENU_BUTTON_PADDING) + _
		  If(Owner.LeftMenuButtonIcon <> Nil, Owner.LeftMenuButtonIcon.Width, LEFT_MENU_BUTTON_HOVER_WIDTH)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E616D65206F6620746869732072656E64657265722E
		Function Name() As String
		  /// The name of this renderer.
		  
		  Return "Edge"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207461622062617220746869732072656E6465726572206F70657261746573206F6E2E
		Function Owner() As XUITabBar
		  /// The tab bar this renderer operates on.
		  ///
		  /// Part of the `XUITabBarRenderer` interface.
		  
		  If mOwner = Nil Or mOwner.Value = Nil Then
		    Return Nil
		  Else
		    Return XUITabBar(mOwner.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320746865207461622062617220746F207468652070617373656420677261706869637320636F6E7465787420617420607363726F6C6C506F7358602E
		Sub Render(ownerGraphics As Graphics, scrollPosX As Integer, needsFullRedraw As Boolean = True)
		  /// Renders the tab bar to the passed graphics context at `scrollPosX`.
		  ///
		  /// Assumes that `ownerGraphics` is the graphics context from the tab bar's `Paint` event.
		  /// `scrollPosX` is the number of pixels (>= 0) the tab bar has been scrolled to the right. `0` is no scrolling.
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
		  Var style As XUITabBarStyle = Owner.Style
		  If style = Nil Then
		    Raise New NilObjectException("Cannot render as the tab bar's style object is Nil.")
		  End If
		  
		  // =====================
		  // CREATE THE BUFFER
		  // =====================
		  // We need to sum the widths of the individual tabs.
		  Var w As Double = 0 
		  For Each tab As XUITabBarItem In Owner.Tabs
		    w = w + TabWidth(tab, ownerGraphics, style)
		  Next tab
		  
		  // Add in left and right menus (if enabled).
		  If Owner.HasLeftMenuButton Then
		    w = w + LeftMenuButtonWidth
		  End If
		  If Owner.HasRightMenuButton Then
		    w = w + RightMenuButtonWidth
		  End If
		  w = Max(Owner.Width, w)
		  mBuffer = Owner.Window.BitmapForCaching(w, TabBarHeight)
		  
		  // For brevity, grab a reference to the buffer's graphics context.
		  Var g As Graphics = mBuffer.Graphics
		  
		  // Draw the background colour.
		  g.DrawingColor = style.BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		  // =====================
		  // UNSELECTED TABS
		  // =====================
		  Var x As Double = If(Owner.HasLeftMenuButton, LeftMenuButtonWidth, 0)
		  Var tabs() As XUITabBarItem = Owner.Tabs
		  For i As Integer = 0 To tabs.LastIndex
		    Var tab As XUITabBarItem = tabs(i)
		    Var currentTabWidth As Double = TabWidth(tab, g, style)
		    If i <> Owner.SelectedTabIndex Then
		      // Unselected tab.
		      RenderUnselectedTab(tab, g, x, style, currentTabWidth)
		      x = tab.Bounds.Right
		    Else
		      // Selected tab. We won't draw now but we will compute its bounds.
		      If i = 0 Then
		        tab.Bounds = New Rect(x, 0, currentTabWidth, TabBarHeight)
		      Else
		        tab.Bounds = New Rect(tabs(i - 1).Bounds.Right, 0, currentTabWidth, TabBarHeight)
		      End If
		      // Need to increment `x` to skip over this tab.
		      x = tab.Bounds.Right
		    End If
		  Next i
		  
		  // =====================
		  // SELECTED TAB
		  // =====================
		  Var selectedTab As XUITabBarItem = Owner.SelectedTab
		  If selectedTab <> Nil Then
		    Var tabW As Double = TabWidth(selectedTab, g, style)
		    If Owner.IsDraggingTab Then
		      // The selected tab is being dragged.
		      RenderSelectedTab(g, Owner.MouseDragX - Owner.DraggingTabLeftEdgeXOffset, style, tabW)
		    Else
		      RenderSelectedTab(g, selectedTab.Bounds.Left, style, tabW)
		    End If
		  End If
		  
		  // =====================
		  // MENU BUTTONS
		  // =====================
		  If Owner.HasLeftMenuButton Then
		    RenderLeftMenuButton(g, style)
		  Else
		    Owner.LeftMenuButtonBounds = Nil
		  End If
		  If Owner.HasRightMenuButton Then
		    RenderRightMenuButton(g, style, tabs(tabs.LastIndex).Bounds.Right)
		  Else
		    Owner.RightMenuButtonBounds = Nil
		  End If
		  
		  // =====================
		  // TAB BORDERS
		  // =====================
		  DrawTabBorders(g, style)
		  
		  // Draw the buffer to the owner's graphics context.
		  ownerGraphics.DrawPicture(mBuffer, -scrollPosX, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E6465727320746865206C656674206D656E7520627574746F6E20746F20606760206174206078602E
		Private Sub RenderLeftMenuButton(g As Graphics, style As XUITabBarStyle)
		  /// Renders the left menu button to `g` at `x`.
		  
		  If Owner.LeftMenuButtonIcon <> Nil Then
		    Var buttonTop As Double = (g.Height / 2) - (Owner.LeftMenuButtonIcon.Height / 2)
		    // Left menu icon overridden.
		    g.DrawPicture(Owner.LeftMenuButtonIcon, LEFT_MENU_BUTTON_PADDING, buttonTop)
		    
		    // Set the bounds.
		    Owner.LeftMenuButtonBounds = _
		    New Rect(LEFT_MENU_BUTTON_PADDING, buttonTop, _
		    Owner.LeftMenuButtonIcon.Width, Owner.LeftMenuButtonIcon.Height)
		    
		  Else
		    // Hovered over?
		    Var hovering As Boolean = Owner.MouseMoveX + Owner.ScrollPosX >= LEFT_MENU_BUTTON_PADDING And _
		    Owner.MouseMoveX + Owner.ScrollPosX <= LEFT_MENU_BUTTON_PADDING + LEFT_MENU_BUTTON_HOVER_WIDTH
		    
		    If hovering Then
		      // Draw the hovering background.
		      g.DrawingColor = style.MenuButtonHoverBackgroundColor
		      g.FillRoundRectangle(LEFT_MENU_BUTTON_PADDING, LEFT_MENU_BUTTON_HOVER_VERT_PADDING, _
		      LEFT_MENU_BUTTON_HOVER_WIDTH, g.Height - (2 * LEFT_MENU_BUTTON_HOVER_VERT_PADDING), 5, 5)
		    End If
		    
		    // Compute the left and top of the button (the icon we'll draw).
		    Var buttonLeft As Double = _
		    LEFT_MENU_BUTTON_PADDING + ((LEFT_MENU_BUTTON_HOVER_WIDTH / 2) - (LEFT_MENU_BUTTON_WIDTH / 2))
		    Var buttonTop As Double = (g.Height / 2) - (LEFT_MENU_BUTTON_HEIGHT / 2)
		    
		    // ===================================================
		    // DRAW THE ICON
		    // ===================================================
		    g.DrawingColor = If(hovering, style.MenuButtonHoverColor, style.MenuButtonColor)
		    g.PenSize = 1
		    
		    // Draw the external frame.
		    g.DrawRoundRectangle(buttonLeft, buttonTop, LEFT_MENU_BUTTON_WIDTH, LEFT_MENU_BUTTON_HEIGHT, 5, 5)
		    
		    // Draw the left inner vertical line.
		    g.DrawLine(buttonLeft + 4, buttonTop, buttonLeft + 4, buttonTop + LEFT_MENU_BUTTON_HEIGHT - 1)
		    
		    // Draw the top filled rect.
		    g.FillRoundRectangle(buttonLeft, buttonTop, LEFT_MENU_BUTTON_WIDTH, 4, 5, 5)
		    g.FillRectangle(buttonLeft, buttonTop + 2, LEFT_MENU_BUTTON_WIDTH, 2)
		    
		    // ===================================================
		    // Set the bounds.
		    If hovering Then
		      Owner.LeftMenuButtonBounds = _
		      New Rect(LEFT_MENU_BUTTON_PADDING, LEFT_MENU_BUTTON_HOVER_VERT_PADDING, _
		      LEFT_MENU_BUTTON_HOVER_WIDTH, g.Height - (2 * LEFT_MENU_BUTTON_HOVER_VERT_PADDING))
		    Else
		      Owner.LeftMenuButtonBounds = New Rect(LEFT_MENU_BUTTON_PADDING, buttonTop, _
		      LEFT_MENU_BUTTON_WIDTH, LEFT_MENU_BUTTON_HEIGHT)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E6465727320746865207269676874206D656E7520627574746F6E20746F20606760206174206078602E
		Private Sub RenderRightMenuButton(g As Graphics, style As XUITabBarStyle, x As Double)
		  /// Renders the right menu button to `g` at `x`.
		  
		  If Owner.RightMenuButtonIcon <> Nil Then
		    Var buttonTop As Double = (g.Height / 2) - (Owner.RightMenuButtonIcon.Height / 2)
		    // Right menu icon overridden.
		    g.DrawPicture(Owner.RightMenuButtonIcon, x + RIGHT_MENU_BUTTON_PADDING, buttonTop)
		    
		    // Set the bounds.
		    Owner.RightMenuButtonBounds = _
		    New Rect(x + RIGHT_MENU_BUTTON_PADDING, buttonTop, _
		    Owner.RightMenuButtonIcon.Width, Owner.RightMenuButtonIcon.Height)
		    
		  Else
		    // Hovered over?
		    Var hovering As Boolean = Owner.MouseMoveX + Owner.ScrollPosX >= x + RIGHT_MENU_BUTTON_PADDING And _
		    Owner.MouseMoveX + Owner.ScrollPosX <= x + RIGHT_MENU_BUTTON_PADDING + RIGHT_MENU_BUTTON_HOVER_WIDTH
		    
		    If hovering Then
		      // Draw the hovering background.
		      g.DrawingColor = style.MenuButtonHoverBackgroundColor
		      g.FillRoundRectangle(x + RIGHT_MENU_BUTTON_PADDING, RIGHT_MENU_BUTTON_HOVER_VERT_PADDING, _
		      RIGHT_MENU_BUTTON_HOVER_WIDTH, g.Height - (2 * RIGHT_MENU_BUTTON_HOVER_VERT_PADDING), 5, 5)
		    End If
		    
		    // Compute the left and top of the button (the icon we'll draw).
		    Var buttonLeft As Double = _
		    x + RIGHT_MENU_BUTTON_PADDING + ((RIGHT_MENU_BUTTON_HOVER_WIDTH / 2) - (RIGHT_MENU_BUTTON_WIDTH / 2))
		    Var buttonTop As Double = (g.Height / 2) - (RIGHT_MENU_BUTTON_HEIGHT / 2)
		    
		    // ===================================================
		    // DRAW THE ICON
		    // ===================================================
		    g.DrawingColor = If(hovering, style.MenuButtonHoverColor, style.MenuButtonColor)
		    g.PenSize = 1
		    
		    // Draw the plus.
		    g.DrawLine(buttonLeft + (RIGHT_MENU_BUTTON_WIDTH / 2), buttonTop, _
		    buttonLeft + (RIGHT_MENU_BUTTON_WIDTH / 2), buttonTop + RIGHT_MENU_BUTTON_HEIGHT)
		    g.DrawLine(buttonLeft, buttonTop + (RIGHT_MENU_BUTTON_HEIGHT / 2), _
		    buttonLeft + RIGHT_MENU_BUTTON_WIDTH, buttonTop + (RIGHT_MENU_BUTTON_HEIGHT / 2))
		    
		    // ===================================================
		    // Set the bounds.
		    If hovering Then
		      Owner.RightMenuButtonBounds = _
		      New Rect(x + RIGHT_MENU_BUTTON_PADDING, RIGHT_MENU_BUTTON_HOVER_VERT_PADDING, _
		      RIGHT_MENU_BUTTON_HOVER_WIDTH, g.Height - (2 * RIGHT_MENU_BUTTON_HOVER_VERT_PADDING))
		    Else
		      Owner.RightMenuButtonBounds = New Rect(x + RIGHT_MENU_BUTTON_PADDING, buttonTop, _
		      RIGHT_MENU_BUTTON_WIDTH, RIGHT_MENU_BUTTON_HEIGHT)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E64657273207468652073656C656374656420607461626020746F206067602C20706C6163696E6720697473206C65667420656467652061742060786020616E6420736574732069747320626F756E64732E
		Private Sub RenderSelectedTab(g As Graphics, x As Double, style As XUITabBarStyle, width As Double)
		  /// Renders the selected to `g`, placing its left edge at `x` and sets its bounds.
		  
		  Var tab As XUITabBarItem = Owner.SelectedTab
		  
		  If tab = Nil Then Return
		  
		  Var leftEdge As Double = x
		  Var rightEdge As Double = x + width
		  
		  Var hoveredOver As Boolean = (Owner.MouseMoveX + Owner.ScrollPosX >= leftEdge And _
		  Owner.MouseMoveX + Owner.ScrollPosX <= rightEdge)
		  
		  // Background colour.
		  SetGraphicsBackgroundColor(tab, g, True, hoveredOver, style)
		  // Top half.
		  g.FillRoundRectangle(x, 0, width, g.Height, 14, 14)
		  // Bottom half.
		  g.FillRectangle(x, 10, width, g.Height - 10)
		  
		  // ==================================================
		  // CONTENT AREA
		  // ==================================================
		  // The content area is the optional icon and the caption combined.
		  SetGraphicsFontProperties(tab, g, True, hoveredOver)
		  
		  // Cache this as it's computed.
		  Var tabWLessCaption As Double = TabWidthExcludingCaption(tab)
		  
		  // Do we need to condense the caption?
		  Var condense As Boolean = g.TextWidth(tab.Caption) > width - tabWLessCaption
		  
		  // Compute the wrap width for the caption in case it's too wide.
		  Var wrapWidth As Double = g.TextWidth(tab.Caption)
		  If condense Then wrapWidth = width - tabWLessCaption
		  
		  Var contentWidth As Double
		  If tab.Icon <> Nil Then
		    contentWidth = ICON_PADDING + tab.Icon.Width
		  End If
		  contentWidth = contentWidth + wrapWidth
		  
		  // Compute where the content area should be drawn at.
		  x = leftEdge + CONTENTS_HORIZONTAL_PADDING
		  
		  // ==================================================
		  // ICON
		  // ==================================================
		  If tab.Icon <> Nil Then
		    g.DrawPicture(tab.Icon, x, (g.Height / 2) - (tab.Icon.Height / 2))
		    x = x + tab.Icon.Width + ICON_PADDING
		  End If
		  
		  // ==================================================
		  // CAPTION
		  // ==================================================
		  Var baseline As Double = g.FontAscent + (g.Height - g.TextHeight) / 2
		  If condense Then
		    g.DrawText(tab.Caption, x, baseline, wrapWidth, True)
		  Else
		    g.DrawText(tab.Caption, x, baseline)
		  End If
		  
		  // ==================================================
		  // CLOSE ICON
		  // ==================================================
		  If tab.Enabled And tab.Closable Then
		    x = x + wrapWidth + CLOSE_ICON_LEFT_PADDING
		    DrawTabCloseIcon(tab, g, x, style)
		    x = x + CLOSE_ICON_WIDTH
		  End If
		  
		  // ==================================================
		  // TAB BOUNDS
		  // ==================================================
		  tab.Bounds = New Rect(leftEdge, 0, width, TabBarHeight)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E646572732074686520756E73656C65637465642060746162602077697468206077696474686020746F206067602C20706C6163696E6720697473206C65667420656467652061742060786020616E6420736574732069747320626F756E64732E
		Private Sub RenderUnselectedTab(tab As XUITabBarItem, g As Graphics, x As Double, style As XUITabBarStyle, width As Double)
		  /// Renders the unselected `tab` with `width` to `g`, placing its left edge at `x` and 
		  /// sets its bounds.
		  
		  Var leftEdge As Double = x
		  Var rightEdge As Double = x + width
		  
		  Var hoveredOver As Boolean = (Owner.MouseMoveX + Owner.ScrollPosX >= leftEdge And _
		  Owner.MouseMoveX + Owner.ScrollPosX <= rightEdge)
		  
		  // Background colour.
		  SetGraphicsBackgroundColor(tab, g, False, hoveredOver, style)
		  g.FillRectangle(x, 0, width, g.Height)
		  
		  // ==================================================
		  // CONTENT AREA
		  // ==================================================
		  // The content area is the optional icon and the caption combined.
		  SetGraphicsFontProperties(tab, g, False, hoveredOver)
		  
		  // Cache this as it's computed.
		  Var tabWLessCaption As Double = TabWidthExcludingCaption(tab)
		  
		  // Do we need to condense the caption?
		  Var condense As Boolean = g.TextWidth(tab.Caption) > width - tabWLessCaption
		  
		  // Compute the wrap width for the caption in case it's too wide.
		  Var wrapWidth As Double = g.TextWidth(tab.Caption)
		  If condense Then wrapWidth = width - tabWLessCaption
		  
		  Var contentWidth As Double
		  If tab.Icon <> Nil Then
		    contentWidth = ICON_PADDING + tab.Icon.Width
		  End If
		  contentWidth = contentWidth + wrapWidth
		  
		  // Compute where the content area should be drawn at.
		  x = leftEdge + CONTENTS_HORIZONTAL_PADDING
		  
		  // ==================================================
		  // ICON
		  // ==================================================
		  If tab.Icon <> Nil Then
		    g.DrawPicture(tab.Icon, x, (g.Height / 2) - (tab.Icon.Height / 2))
		    x = x + tab.Icon.Width + ICON_PADDING
		  End If
		  
		  // ==================================================
		  // CAPTION
		  // ==================================================
		  Var baseline As Double = g.FontAscent + (g.Height - g.TextHeight) / 2
		  If condense Then
		    g.DrawText(tab.Caption, x, baseline, wrapWidth, True)
		  Else
		    g.DrawText(tab.Caption, x, baseline)
		  End If
		  
		  // ==================================================
		  // CLOSE ICON
		  // ==================================================
		  If tab.Enabled And tab.Closable Then
		    x = x + wrapWidth + CLOSE_ICON_LEFT_PADDING
		    DrawTabCloseIcon(tab, g, x, style)
		    x = x + CLOSE_ICON_WIDTH
		  End If
		  
		  // ==================================================
		  // TAB BOUNDS
		  // ==================================================
		  tab.Bounds = New Rect(leftEdge, 0, width, TabBarHeight)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F6620746865207269676874206D656E7520627574746F6E2028696620737570706F7274656420627920746869732072656E6465726572292E
		Function RightMenuButtonWidth() As Double
		  /// The width of the right menu button (if supported by this renderer).
		  ///
		  /// Part of the `XUITabBarRenderer` interface.
		  
		  Return (2 * RIGHT_MENU_BUTTON_PADDING) + _
		  If(Owner.RightMenuButtonIcon <> Nil, Owner.RightMenuButtonIcon.Width, RIGHT_MENU_BUTTON_HOVER_WIDTH)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5365747320746865206261636B67726F756E642064726177696E6720636F6C6F7572206F662060676020746F2074686F736520726571756972656420666F722074686973207461622E
		Private Sub SetGraphicsBackgroundColor(tab As XUITabBarItem, g As Graphics, isSelected As Boolean, hoveredOver As Boolean, style As XUITabBarStyle)
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
		Private Sub SetGraphicsFontProperties(tab As XUITabBarItem, g As Graphics, isSelected As Boolean, hoveredOver As Boolean)
		  /// Sets the font properties of `g` to those required for `tab`.
		  
		  Var style As XUITabBarStyle = Owner.Style
		  
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
		  /// Part of the `XUITabBarRenderer` interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620746869732072656E646572657220737570706F7274732074686520636F6E63657074206F662061207269676874206D656E7520627574746F6E2E
		Function SupportsRightMenuButton() As Boolean
		  /// True if this renderer supports the concept of a right menu button.
		  ///
		  /// Part of the `XUITabBarRenderer` interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206865696768742074686520746162206261722077696C6C2062652072656E64657265642061742E
		Function TabBarHeight() As Integer
		  /// Returns the height the tab bar will be rendered at.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return 32
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865207769647468206F66206074616260206966206974207765726520647261776E20746F206067602E
		Private Function TabWidth(tab As XUITabBarItem, g As Graphics, style As XUITabBarStyle) As Double
		  /// Returns the width of `tab` if it were drawn to `g`.
		  
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  
		  Var w As Double = TabWidthExcludingCaption(tab)  + g.TextWidth(tab.Caption)
		  
		  // Ensure the tab is between the min and max widths.
		  Return XUIMaths.Clamp(w, MIN_TAB_WIDTH, MAX_TAB_WIDTH)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865207769647468206F66206074616260206578636C7564696E67206974732063617074696F6E2E
		Private Function TabWidthExcludingCaption(tab As XUITabBarItem) As Double
		  /// Returns the width of `tab` excluding its caption.
		  
		  Var w As Double = (2 * CONTENTS_HORIZONTAL_PADDING) + ICON_PADDING
		  
		  If tab.Icon <> Nil Then w = w + tab.Icon.Width
		  
		  If tab.Closable Then w = w + CLOSE_ICON_LEFT_PADDING + CLOSE_ICON_WIDTH
		  
		  Return w
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		
		A tab bar renderer that renders a `XUITabBar` similar to that seen in Microsoft Edge.
	#tag EndNote


	#tag Property, Flags = &h21, Description = 4361636865206F662074686520506963747572652072657475726E65642066726F6D20746865206C6173742063616C6C20746F206058554954616242617252656E6465722E4275666665722829602E204D6179206265204E696C2E
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F207468652074616220626172207468617420746869732072656E6465726572206F70657261746573206F6E2E
		Private mOwner As WeakRef
	#tag EndProperty


	#tag Constant, Name = BORDER_VERT_PADDING, Type = Double, Dynamic = False, Default = \"3", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F7720746865206C65667420616E642072696768742074616220626F72646572732E
	#tag EndConstant

	#tag Constant, Name = CLOSE_ICON_CROSS_HEIGHT, Type = Double, Dynamic = False, Default = \"6", Scope = Private, Description = 54686520686569676874206F662074686520636C6F73652069636F6E2063726F73732E
	#tag EndConstant

	#tag Constant, Name = CLOSE_ICON_CROSS_WIDTH, Type = Double, Dynamic = False, Default = \"6", Scope = Private, Description = 546865207769647468206F662074686520636C6F73652069636F6E2063726F73732E
	#tag EndConstant

	#tag Constant, Name = CLOSE_ICON_HEIGHT, Type = Double, Dynamic = False, Default = \"16", Scope = Private, Description = 54686520686569676874206F662074686520636C6F73652069636F6E20726F756E64656420726563742E
	#tag EndConstant

	#tag Constant, Name = CLOSE_ICON_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 486F77206D75636820746F2070616420746865206C656674206F662074686520636C6F73652069636F6E20286966207468652074616220697320636C6F7361626C65292E
	#tag EndConstant

	#tag Constant, Name = CLOSE_ICON_WIDTH, Type = Double, Dynamic = False, Default = \"16", Scope = Private, Description = 546865207769647468206F662074686520636C6F73652069636F6E20726F756E64656420726563742E
	#tag EndConstant

	#tag Constant, Name = CONTENTS_HORIZONTAL_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 486F77206D75636820746F20706164206C65667420616E64207269676874206F662074686520636F6E74656E7473206F6620746865207461622028636C6F73652069636F6E2C2069636F6E20616E642063617074696F6E292E
	#tag EndConstant

	#tag Constant, Name = ICON_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 686F77206D75636820746F2070616420746865206C65667420616E64207269676874207369646573206F66207468652069636F6E2066726F6D207468652074616227732063617074696F6E2E
	#tag EndConstant

	#tag Constant, Name = LEFT_MENU_BUTTON_HEIGHT, Type = Double, Dynamic = False, Default = \"14", Scope = Private, Description = 54686520686569676874206F6620746865206C656674206D656E7520627574746F6E2E
	#tag EndConstant

	#tag Constant, Name = LEFT_MENU_BUTTON_HOVER_VERT_PADDING, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 486F77206D75636820746F207061642061626F766520616E642062656C6F772074686520726F756E6465642072656374616E676C6520647261776E207768656E20686F766572696E67206F76657220746865206C656674206D656E7520627574746F6E206966207468657265206973206E6F206C656674206D656E7520627574746F6E2069636F6E2E
	#tag EndConstant

	#tag Constant, Name = LEFT_MENU_BUTTON_HOVER_WIDTH, Type = Double, Dynamic = False, Default = \"30", Scope = Private, Description = 546865207769647468206F6620746865206C656674206D656E7520627574746F6E207768656E20686F7665726564206F766572206966206E6F2069636F6E207370656369666965642E
	#tag EndConstant

	#tag Constant, Name = LEFT_MENU_BUTTON_PADDING, Type = Double, Dynamic = False, Default = \"12", Scope = Private, Description = 486F77206D75636820746F2070616420746865206C65667420616E64207269676874206F6620746865206C656674206D656E7520627574746F6E2069662070726573656E742E
	#tag EndConstant

	#tag Constant, Name = LEFT_MENU_BUTTON_WIDTH, Type = Double, Dynamic = False, Default = \"14", Scope = Private, Description = 546865207769647468206F6620746865206C656674206D656E7520627574746F6E2E
	#tag EndConstant

	#tag Constant, Name = MAX_TAB_WIDTH, Type = Double, Dynamic = False, Default = \"240", Scope = Private, Description = 546865206D6178696D756D2077696474682061207461622063616E2062652E
	#tag EndConstant

	#tag Constant, Name = MIN_TAB_WIDTH, Type = Double, Dynamic = False, Default = \"50", Scope = Private, Description = 546865206D696E696D756D2077696474682061207461622063616E2062652E
	#tag EndConstant

	#tag Constant, Name = RIGHT_MENU_BUTTON_HEIGHT, Type = Double, Dynamic = False, Default = \"14", Scope = Private, Description = 54686520686569676874206F6620746865207269676874206D656E7520627574746F6E2E
	#tag EndConstant

	#tag Constant, Name = RIGHT_MENU_BUTTON_HOVER_VERT_PADDING, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 486F77206D75636820746F207061642061626F766520616E642062656C6F772074686520726F756E6465642072656374616E676C6520647261776E207768656E20686F766572696E67206F76657220746865207269676874206D656E7520627574746F6E206966207468657265206973206E6F207269676874206D656E7520627574746F6E2069636F6E2E
	#tag EndConstant

	#tag Constant, Name = RIGHT_MENU_BUTTON_HOVER_WIDTH, Type = Double, Dynamic = False, Default = \"30", Scope = Private, Description = 546865207769647468206F6620746865207269676874206D656E7520627574746F6E207768656E20686F7665726564206F766572206966206E6F2069636F6E207370656369666965642E
	#tag EndConstant

	#tag Constant, Name = RIGHT_MENU_BUTTON_PADDING, Type = Double, Dynamic = False, Default = \"8", Scope = Private, Description = 486F77206D75636820746F2070616420746865206C65667420616E64207269676874206F6620746865207269676874206D656E7520627574746F6E2069662070726573656E742E
	#tag EndConstant

	#tag Constant, Name = RIGHT_MENU_BUTTON_WIDTH, Type = Double, Dynamic = False, Default = \"14", Scope = Private, Description = 546865207769647468206F6620746865207269676874206D656E7520627574746F6E2E
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
