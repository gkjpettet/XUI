#tag Class
Protected Class XUITabBarRendererEdge
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

	#tag Method, Flags = &h0, Description = 50617274206F66207468652058554954616242617252656E646572657220696E746572666163652E
		Sub Constructor(owner As XUITabBar)
		  /// Part of the XUITabBarRenderer interface.
		  
		  If owner = Nil Then
		    mOwner = Nil
		  Else
		    mOwner = New WeakRef(owner)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F6620746865206C656674206D656E7520627574746F6E2028696620737570706F7274656420627920746869732072656E6465726572292E
		Function LeftMenuButtonWidth() As Double
		  /// The width of the left menu button (if supported by this renderer).
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return 45
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
		  /// Part of the XUITabBarRenderer interface.
		  
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
		  
		  // Create a buffer of the required size. We need to sum the widths of the individual tabs.
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
		  
		  // Draw all tabs *except* the selected tab.
		  Var x, selectedTabX As Double = If(Owner.HasLeftMenuButton, LeftMenuButtonWidth, 0)
		  Var tabs() As XUITabBarItem = Owner.Tabs
		  For i As Integer = 0 To tabs.LastIndex
		    Var tab As XUITabBarItem = tabs(i)
		    Var currentTabWidth As Double = TabWidth(tab, g, style)
		    If i <> Owner.SelectedTabIndex Then
		      RenderTab(tab, g, x, style, currentTabWidth)
		      x = tab.Bounds.Right
		    Else
		      // Need to store the left edge of the selected tab as we'll draw it shortly.
		      If i = 0 Then
		        selectedTabX = 0
		        // Need to increment `x` to skip over this tab.
		        x = currentTabWidth
		      Else
		        selectedTabX = tabs(i - 1).Bounds.Right
		        // Need to increment `x` to skip over this tab.
		        x = selectedTabX + TabWidth(tabs(i - 1), g, style)
		      End If
		    End If
		  Next i
		  
		  // Draw the selected tab.
		  #Pragma Warning "TODO: Draw the selected tab"
		  
		  #Pragma Warning "TODO: Draw left / right menu buttons"
		  #Pragma Warning "TODO: Set left/right menu button bounds"
		  
		  // Draw the buffer to the owner's graphics context.
		  ownerGraphics.DrawPicture(mBuffer, -scrollPosX, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E646572732060746162602077697468206077696474686020746F206067602C20706C6163696E6720697473206C65667420656467652061742060786020616E6420736574732069747320626F756E64732E
		Private Sub RenderTab(tab As XUITabBarItem, g As Graphics, x As Double, style As XUITabBarStyle, width As Double)
		  /// Renders `tab` with `width` to `g`, placing its left edge at `x` and sets its bounds.
		  
		  #Pragma Warning "TODO: Finish"
		  
		  Var leftEdge As Double = x
		  Var rightEdge As Double = x + width
		  
		  Var isSelected As Boolean = (tab = Owner.SelectedTab)
		  Var hoveredOver As Boolean = (Owner.MouseMoveX >= leftEdge And Owner.MouseMoveX <= rightEdge)
		  
		  // Background colour.
		  SetGraphicsBackgroundColor(tab, g, isSelected, hoveredOver, style)
		  g.FillRectangle(x, 0, width, g.Height)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F6620746865207269676874206D656E7520627574746F6E2028696620737570706F7274656420627920746869732072656E6465726572292E
		Function RightMenuButtonWidth() As Double
		  /// The width of the right menu button (if supported by this renderer).
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return 30
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

	#tag Method, Flags = &h0, Description = 5472756520696620746869732072656E646572657220737570706F7274732074686520636F6E63657074206F662061206C656674206D656E7520627574746F6E2E
		Function SupportsLeftMenuButton() As Boolean
		  /// True if this renderer supports the concept of a left menu button.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620746869732072656E646572657220737570706F7274732074686520636F6E63657074206F662061207269676874206D656E7520627574746F6E2E
		Function SupportsRightMenuButton() As Boolean
		  /// True if this renderer supports the concept of a right menu button.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206865696768742074686520746162206261722077696C6C2062652072656E64657265642061742E
		Function TabBarHeight() As Integer
		  /// Returns the height the tab bar will be rendered at.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return 30
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865207769647468206F66206074616260206966206974207765726520647261776E20746F206067602E
		Private Function TabWidth(tab As XUITabBarItem, g As Graphics, style As XUITabBarStyle) As Double
		  /// Returns the width of `tab` if it were drawn to `g`.
		  
		  // Factor in the horizontal padding.
		  Var w As Double = 2 * CONTENTS_HORIZONTAL_PADDING
		  
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  
		  // Icon & caption widths.
		  If tab.Icon <> Nil Then
		    w = w + tab.Icon.Width + ICON_RIGHT_PADDING + g.TextWidth(tab.Caption)
		  Else
		    w = w + g.TextWidth(tab.Caption)
		  End If
		  
		  // Close icon.
		  If tab.Enabled And tab.Closable Then
		    w = w + CLOSE_ICON_WIDTH + CLOSE_ICON_LEFT_PADDING
		  End If
		  
		  // Ensure the tab is between the min and max widths.
		  Return XUIMaths.Clamp(w, MAX_TAB_WIDTH, MAX_TAB_WIDTH)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 4361636865206F662074686520506963747572652072657475726E65642066726F6D20746865206C6173742063616C6C20746F206058554954616242617252656E6465722E4275666665722829602E204D6179206265204E696C2E
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F207468652074616220626172207468617420746869732072656E6465726572206F70657261746573206F6E2E
		Private mOwner As WeakRef
	#tag EndProperty


	#tag Constant, Name = CLOSE_ICON_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 486F77206D75636820746F2070616420746865206C656674206F662074686520636C6F73652069636F6E20286966207468652074616220697320636C6F7361626C65292E
	#tag EndConstant

	#tag Constant, Name = CLOSE_ICON_WIDTH, Type = Double, Dynamic = False, Default = \"6", Scope = Private, Description = 546865207769647468206F662074686520636C6F73652069636F6E2E
	#tag EndConstant

	#tag Constant, Name = CONTENTS_HORIZONTAL_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 486F77206D75636820746F20706164206C65667420616E64207269676874206F662074686520636F6E74656E7473206F6620746865207461622028636C6F73652069636F6E2C2069636F6E20616E642063617074696F6E292E
	#tag EndConstant

	#tag Constant, Name = ICON_RIGHT_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 686F77206D75636820746F20706164207468652072696768742073696465206F66207468652069636F6E2066726F6D207468652074616227732063617074696F6E2E
	#tag EndConstant

	#tag Constant, Name = MAX_TAB_WIDTH, Type = Double, Dynamic = False, Default = \"240", Scope = Private, Description = 546865206D6178696D756D2077696474682061207461622063616E2062652E
	#tag EndConstant

	#tag Constant, Name = MIN_TAB_WIDTH, Type = Double, Dynamic = False, Default = \"50", Scope = Private, Description = 546865206D696E696D756D2077696474682061207461622063616E2062652E
	#tag EndConstant


End Class
#tag EndClass
