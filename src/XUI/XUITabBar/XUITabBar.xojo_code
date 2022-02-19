#tag Class
Protected Class XUITabBar
Inherits DesktopCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  mMouseDownTicks = System.Ticks
		  
		  // At the exact moment the mouse is clicked we aren't dragging yet.
		  mDragging = False
		  
		  // Cache the x, y coords that this mouse down event occurs at.
		  mLastMouseDownX = x
		  mLastMouseDownY = y
		  mMouseDownIndex = TabIndexAtX(x)
		  mMouseOverMenuButton = OverMenuButton(x)
		  
		  // Right click?
		  mLastClickWasContextual = IsContextualClick
		  If mLastClickWasContextual Then Return True
		  
		  // Nothing else to do if there are no tabs.
		  If mTabs.Count = 0 Then Return True
		  
		  If mMouseOverMenuButton And HasMenuButton Then
		    // Have clicked on the menu button. This will be handled in `MouseUp()`.
		    Return True
		  Else
		    // Get the index of the tab under the mouse.
		    Var index As Integer = TabIndexAtX(x)
		    If index < 0 Or index > mTabs.LastIndex Then
		      // No tab under the mouse.
		      Return True
		    End If
		    
		    Var tab As XUITabBarItem = mTabs(index)
		    
		    // If the tab is enabled then select it.
		    If tab.Enabled Then SelectTabAtIndex(index)
		  End If
		  
		  // Permit the `MouseUp` event to fire.
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(x As Integer, y As Integer)
		  If Not AllowDragReordering Then Return
		  
		  If System.Ticks - mMouseDownTicks > DRAG_THRESHOLD_TICKS Then
		    
		    mMouseDownTicks = System.Ticks
		    
		    If Abs(x - mLastMouseDownX) > DRAG_THRESHOLD_DISTANCE Or _
		      Abs(y - mLastMouseDownY) > DRAG_THRESHOLD_DISTANCE Then
		      
		      If Not ValidTabIndex(mMouseDownIndex) Then Return
		      
		      mMouseOverIndex = -1
		      
		      Var startedDragging As Boolean = False
		      If Not mDragging Then
		        // Have just started dragging. Compute the offset from the selected tab's left edge that the
		        // mouse is currently at.
		        startedDragging = True
		        mDragXLeftEdgeOffset = (x - mSelectedTabIndex * mWidestTab)
		      End If
		      
		      mDragging = True
		      mDragX = x
		      mDragIndex = TabIndexAtX(x)
		      
		      If x > Self.Width - DRAG_SCROLL_THRESHOLD Then
		        ScrollPosX = ScrollPosX + DRAG_SCROLL_THRESHOLD
		      ElseIf x < DRAG_SCROLL_THRESHOLD Then
		        ScrollPosX = ScrollPosX - DRAG_SCROLL_THRESHOLD
		      End If
		      
		      If mDragIndex <> mSelectedTabIndex Then
		        SwapTabs(mSelectedTabIndex, mDragIndex, False)
		        mSelectedTabIndex = mDragIndex
		        Redraw
		      Else
		        Redraw
		      End If
		      
		      If startedDragging And mSelectedTabIndex <> -1 Then
		        RaiseEvent DidStartDragging(mTabs(mSelectedTabIndex), mSelectedTabIndex)
		      End If
		      
		    End If
		    
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  mMouseOverIndex = -1
		  mMouseOverMenuButton = False
		  mMouseMoveX = -1
		  mMouseMoveY = -1
		  
		  Redraw
		  
		  RaiseEvent MouseExit
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(x As Integer, y As Integer)
		  mMouseOverIndex = TabIndexAtX(x)
		  
		  mMouseOverMenuButton = OverMenuButton(x)
		  If mMouseOverMenuButton And HasMenuButton Then mMouseOverIndex = -1
		  
		  mMouseMoveX = x
		  mMouseMoveY = y
		  
		  Redraw
		  
		  RaiseEvent MouseMove(x, y)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  If mDragging Then
		    // Must have finished dragging.
		    mDragging = False
		    mDragX = 0
		    mDragIndex = -1
		    Redraw
		    If mSelectedTabIndex <> -1 Then RaiseEvent DidFinishDragging(mTabs(mSelectedTabIndex), mSelectedTabIndex)
		    Return
		  End If
		  
		  // If this event was triggered by a right click then bail as right clicks should get handled in 
		  /// the `ConstructContextualMenu` event.
		  If mLastClickWasContextual Then
		    RaiseEvent DidContextualClick(x, y)
		    Return
		  End If
		  
		  // Close this tab?
		  If OverCloseIconAtIndex(mMouseOverIndex) Then
		    RemoveTabAt(mMouseOverIndex)
		    Return
		  End If
		  
		  // Clicked the menu button?
		  If HasMenuButton And mMouseOverMenuButton Then
		    RaiseEvent PressedMenuButton
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  If deltaX <> 0 Then
		    // deltaX reported by Xojo is very small. Beef it up a little.
		    deltaX = deltaX * 5
		    ScrollPosX = ScrollPosX + deltaX
		    Redraw
		  End If
		  
		  RaiseEvent MouseWheel(x, y, deltaX, deltaY)
		End Function
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  #If TargetWindows
		    // Anti-aliasing needs to be off on Windows.
		    g.AntiAliased = False
		  #EndIf
		  
		  If mNeedsRedrawing Or mBuffer = Nil Or _
		    mBuffer.Graphics.Width < g.Width Or mBuffer.Graphics.Height < g.Height Then
		    RebuildBuffer
		  End If
		  
		  // Draw the back buffer to the screen.
		  g.DrawPicture(mBuffer, -ScrollPosX, 0)
		  
		  // Draw the optional menu button.
		  If HasMenuButton Then DrawMenuButton(g, Me.Width - MenuButtonWidth)
		  
		  RaiseEvent Paint(g)
		End Sub
	#tag EndEvent

	#tag Event
		Sub ScaleFactorChanged()
		  Redraw
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 416464732061206E6577207461622061742074686520302D62617365642060696E646578602E2057696C6C20726169736520616E20604F75744F66426F756E6473457863657074696F6E602069662060696E6465786020697320696E76616C69642E
		Sub AddTabAt(index As Integer, caption As String, icon As Picture = Nil, tag As Variant = Nil, closable As Boolean = True, enabled As Boolean = True)
		  /// Adds a new tab at the 0-based `index`. 
		  /// Will raise an `OutOfBoundsException` if `index` is invalid.
		  
		  mTabs.AddAt(index, New XUITabBarItem(Self, caption, icon, tag, closable, enabled))
		  
		  Redraw
		  
		  DidAddTab(mTabs(index), index)
		  
		  Exception e As OutOfBoundsException
		    Raise New OutOfBoundsException("Cannot add a tab at index `" + index.ToString + "`.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 417070656E64732061206E65772074616220746F207468697320746162206261722E
		Sub AppendTab(caption As String, icon As Picture = Nil, tag As Variant = Nil, closable As Boolean = True, enabled As Boolean = True)
		  /// Appends a new tab to this tab bar.
		  
		  Self.AddTabAt(mTabs.Count, caption, icon, tag, closable, enabled)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D707574657320746865207769647468206F66207468652062756666657220616E642074686520776964657374207461622E205365747320606D526571756972656442756666657257696474686020616E6420606D576964657374546162602E
		Private Sub ComputeBufferWidthAndWidestTab()
		  /// Computes the width of the buffer and the widest tab. Sets `mRequiredBufferWidth` and `mWidestTab`.
		  ///
		  /// The buffer will always be at least as wide as the tab bar's current width.
		  
		  Var g As Graphics
		  Var p As Picture
		  If mBuffer = Nil Then
		    // Edge case: The canvas is embedded in a DesktopContainer  that is not
		    // yet embedded in a window. In this scenario, `TrueWindow` is Nil.
		    If Self.Window <> Nil Then
		      p = Self.Window.BitmapForCaching(10, 10)
		    Else
		      p = New Picture(10, 10)
		    End If
		    g = p.Graphics
		  Else
		    g = mBuffer.Graphics
		  End If
		  
		  Var w As Double
		  
		  // Find the widest tab.
		  mWidestTab = 0
		  Var tmp As Double
		  For i As Integer = 0 To mTabs.LastIndex
		    tmp = mTabs(i).Width(g, i = mSelectedTabIndex)
		    If tmp > mWidestTab Then mWidestTab = tmp
		  Next i
		  
		  If (mTabs.Count * mWidestTab) < Self.AvailableTabSpace Then
		    mWidestTab = Self.AvailableTabSpace / mTabs.Count
		  End If
		  
		  w = w + (mTabs.Count * mWidestTab)
		  
		  mRequiredBufferWidth = Max(w, Self.Width)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  Self.Style = New XUITabBarStyle
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 447261777320746865206D656E7520627574746F6E206174206078602E
		Private Sub DrawMenuButton(g As Graphics, x As Integer)
		  /// Draws the menu button at `x`.
		  ///
		  /// Assumes the tab bar should have a menu button.
		  
		  // Background.
		  g.DrawingColor = If(mMouseOverMenuButton, Style.MenuButtonHoverBackgroundColor, _
		  Style.MenuButtonBackgroundColor)
		  g.FillRectangle(x, 0, MenuButtonWidth, g.Height)
		  
		  // Border.
		  g.DrawingColor = Style.MenuButtonBorderColor
		  g.PenSize = 1
		  g.DrawRectangle(x, 0, MenuButtonWidth, g.Height)
		  
		  // Icon.
		  Var icon As Picture
		  If mMouseOverMenuButton Then
		    If mMenuButtonHoverIcon = Nil Then
		      icon = mMenuButtonIcon
		    Else
		      icon = mMenuButtonHoverIcon
		    End If
		  Else
		    icon = mMenuButtonIcon
		  End If
		  
		  If icon <> Nil Then
		    Var iconX As Double = x + (MenuButtonWidth / 2) - (icon.Width / 2)
		    Var iconY As Double = (g.Height / 2) - (icon.Height / 2)
		    g.DrawPicture(icon, iconX, iconY)
		  Else
		    // Draw a `+`.
		    g.DrawingColor = If(mMouseOverMenuButton, Style.MenuButtonHoverColor, Style.MenuButtonColor)
		    Const PLUS_WIDTH = 10
		    Const PLUS_HEIGHT = 10
		    g.PenSize = 1
		    Var plusLeft As Double = x + (MenuButtonWidth / 2) - (PLUS_WIDTH / 2)
		    Var midY As Double = g.Height / 2
		    Var plusTop As Double = midY - (PLUS_HEIGHT / 2)
		    g.DrawLine(plusLeft, midY, plusLeft + PLUS_WIDTH, midY)
		    g.DrawLine(x + midY, plusTop, x + midY, plusTop + PLUS_HEIGHT)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function OverCloseIconAtIndex(index As Integer) As Boolean
		  /// True if the mouse is over the close icon of the tab at `index`.
		  
		  // Sanity checks.
		  If mTabs.Count = 0 Then Return False
		  If index < 0 Or index > mTabs.LastIndex Then Return False
		  If mMouseMoveX = -1 Or mMouseMoveY = -1 Then Return False
		  If Not mTabs(index).Closable Then Return False
		  
		  // Compute the x coord of the left edge of this tab.
		  Var leftEdgeTab As Integer = (mWidestTab * index)
		  
		  // Compute the left edge of the close icon.
		  Var leftEdgeClose As Integer = leftEdgeTab + XUITabBarItem.CLOSE_PADDING
		  
		  // Var compute the top edge of the close icon. -1 is a fudge.
		  Var topEdgeClose As Integer = (Self.Height / 2) - (XUITabBarItem.CLOSE_HEIGHT / 2) - 1
		  
		  // We know where the mouse was during the last mouse move but we need to account for any scrolling.
		  Var x As Integer = mMouseMoveX + ScrollPosX
		  
		  // The +2 values are just fudges.
		  If x >= leftEdgeClose And x < leftEdgeClose + XUITabBarItem.CLOSE_WIDTH + 2 And _
		    mMouseMoveY >= topEdgeClose And mMouseMoveY <= topEdgeClose + XUITabBarItem.CLOSE_HEIGHT + 2 Then
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73205472756520696620607860206973206F76657220746865206D656E7520627574746F6E2E
		Private Function OverMenuButton(x As Integer) As Boolean
		  /// Returns True if `x` is over the menu button.
		  
		  If Not HasMenuButton Then Return False
		  
		  Return x >= Self.Width - MenuButtonWidth
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F766573207468652073656C65637465642074616220746F207468652074616220746F20746865206C656674206F66207468652063757272656E746C792073656C6563746564207461622E
		Sub PageLeft()
		  /// Moves the selected tab to the tab to the left of the currently selected tab.
		  
		  If mTabs.Count <= 1 Then Return
		  If mSelectedTabIndex = -1 Then Return
		  
		  If mSelectedTabIndex = 0 Then
		    mSelectedTabIndex = mTabs.LastIndex
		  Else
		    mSelectedTabIndex = mSelectedTabIndex - 1
		  End If
		  
		  Redraw
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F766573207468652073656C65637465642074616220746F207468652074616220746F20746865207269676874206F66207468652063757272656E746C792073656C6563746564207461622E
		Sub PageRight()
		  /// Moves the selected tab to the tab to the right of the currently selected tab.
		  
		  If mTabs.Count <= 1 Then Return
		  If mSelectedTabIndex = -1 Then Return
		  
		  If mSelectedTabIndex = mTabs.LastIndex Then
		    mSelectedTabIndex = 0
		  Else
		    mSelectedTabIndex = mSelectedTabIndex + 1
		  End If
		  
		  Redraw
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 506F7073207468652072696768742D6D6F737420746162206F6666206F6620746865207461622062617220616E642072657475726E732069742E204D61792072657475726E204E696C20696620746865726520617265206E6F20746162732E
		Function PopTab() As XUITabBarItem
		  /// Pops the right-most tab off of the tab bar and returns it. May return Nil if there are no tabs.
		  
		  If mTabs.Count < 1 Then Return Nil
		  
		  Var popped As XUITabBarItem = mTabs.Pop
		  
		  Redraw
		  
		  DidRemoveTab(popped)
		  
		  Return popped
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656275696C64732074686520656E74697265206275666665722062792064726177696E6720616C6C2076697369626C6520636F6E74656E7420746F2069742E
		Private Sub RebuildBuffer()
		  /// Rebuilds the entire buffer by drawing all visible content to it.
		  
		  ComputeBufferWidthAndWidestTab
		  
		  // Create a new HiDPI aware back buffer picture.
		  mBuffer = Window.BitmapForCaching(mRequiredBufferWidth, Height)
		  
		  If mTabs.Count = 0 Then Return
		  
		  // Grab a reference to the buffer's graphics context.
		  Var g As Graphics = mBuffer.Graphics
		  
		  #If TargetWindows
		    // Anti-aliasing needs to be off on Windows.
		    g.AntiAliased = False
		  #EndIf
		  
		  Var x, selectedTabX As Integer = 0
		  For i As Integer = 0 To mTabs.LastIndex
		    Var tab As XUITabBarItem = mTabs(i)
		    If i <> mSelectedTabIndex Then
		      x = tab.Draw(g, x, False, i = mMouseOverIndex, OverCloseIconAtIndex(i), mWidestTab)
		    Else
		      selectedTabX = x
		      x = x + mWidestTab
		    End If
		  Next i
		  
		  // Draw the selected tab.
		  If mSelectedTabIndex <> -1 Then
		    If mDragging Then
		      Call mTabs(mSelectedTabIndex).Draw(g, mDragX - mDragXLeftEdgeOffset, True, False, False, mWidestTab)
		    Else
		      Call mTabs(mSelectedTabIndex).Draw(g, selectedTabX, True, _
		      mSelectedTabIndex = mMouseOverIndex, OverCloseIconAtIndex(mSelectedTabIndex), mWidestTab)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 466F7263657320616E20696D6D6564696174652066756C6C20726564726177206F662074686520636F6E74726F6C2E
		Sub Redraw()
		  /// Forces an immediate full redraw of the control.
		  
		  mNeedsRedrawing = True
		  
		  Refresh(True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616C6C20746162732C207374617274696E672066726F6D207468652072696768742D6D6F7374207461622E
		Sub RemoveAll()
		  /// Removes all tabs, starting from the right-most tab.
		  
		  For i As Integer = mTabs.LastIndex DownTo 0
		    Call PopTab
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320746865207461622061742060696E646578602E2057696C6C20726169736520616E20604F75744F66426F756E6473457863657074696F6E602069662060696E6465786020697320696E76616C6964
		Sub RemoveTabAt(index As Integer)
		  /// Removes the tab at `index`. 
		  /// Will raise an `OutOfBoundsException` if `index` is invalid 
		  
		  Var removed As XUITabBarItem = mTabs(index)
		  
		  mTabs.RemoveAt(index)
		  
		  // Handle selection.
		  If mTabs.Count = 0 Then
		    mSelectedTabIndex = -1
		  ElseIf mSelectedTabIndex > mTabs.LastIndex Then
		    mSelectedTabIndex = mTabs.LastIndex
		  ElseIf mSelectedTabIndex > 0 Then
		    mSelectedTabIndex = mSelectedTabIndex - 1
		  End If
		  
		  Redraw
		  
		  DidRemoveTab(removed)
		  
		  Exception e As OutOfBoundsException
		    Raise New OutOfBoundsException("Cannot remove tab at index `" + index.ToString + "` as it is invalid.")
		    
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265706C6163657320746865207461622061742060696E64657860207769746820606E6577546162602E2057696C6C20726169736520616E20604F75744F66426F756E6473457863657074696F6E602069662060696E6465786020697320696E76616C69642E
		Sub ReplaceTabAt(index As Integer, newTab As XUITabBarItem)
		  /// Replaces the tab at `index` with `newTab` and selects it.
		  /// Will raise an `OutOfBoundsException` if `index` is invalid.
		  
		  mTabs(index) = newTab
		  
		  mSelectedTabIndex = index
		  
		  Redraw
		  
		  DidAddTab(newTab, index)
		  
		  Exception e As OutOfBoundsException
		    Raise New OutOfBoundsException("Cannot replace the tab at index `" + index.ToString + _
		    "` as the index is invalid.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53656C6563747320746865207461622061742060696E646578602E2057696C6C20726169736520616E20604F75744F66426F756E6473457863657074696F6E602069662060696E6465786020697320696E76616C69642E
		Sub SelectTabAtIndex(index As Integer)
		  /// Selects the tab at `index`.
		  /// Will raise an `OutOfBoundsException` if `index` is invalid.
		  
		  If index < 0 Or index > mTabs.LastIndex Then
		    Raise New OutOfBoundsException("Cannot select the tab at index `" + index.ToString + _
		    "` as that index is invalid.")
		  End If
		  
		  mSelectedTabIndex = index
		  
		  Redraw
		  
		  DidSelectTab(mTabs(index), index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SwapTabs(index1 As Integer, index2 As Integer, shouldRedraw As Boolean = True)
		  /// Swaps the tabs at the passed indices and redraws the tab bar.
		  
		  If mTabs.Count = 0. Then Return
		  
		  If index1 < 0 Or index1 > mTabs.LastIndex Then Return
		  If index2 < 0 Or index2 > mTabs.LastIndex Then Return
		  
		  Var tab2 As XUITabBarItem = mTabs(index2)
		  mTabs(index2) = mTabs(Index1)
		  mTabs(Index1) = tab2
		  
		  If shouldRedraw Then Redraw
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520696E646578206F662074686520746162206174206D6F75736520706F736974696F6E20607860206F72202D312069662074686572652069736E2774206F6E652E
		Private Function TabIndexAtX(x As Double) As Integer
		  /// Returns the index of the tab at mouse position `x` or -1 if there isn't one.
		  ///
		  /// `x` is the absolute coordinate from the left edge of the tab bar. It does not account for any
		  /// scrolling of the tab bar.
		  
		  // Adjust for scrolling.
		  x = x + ScrollPosX
		  
		  // Sanity checks.
		  If mTabs.Count = 0 Then Return -1
		  If x < 0 Then Return -1
		  If mBuffer = Nil Then Return -1
		  If x > mBuffer.Width Then Return -1
		  
		  Var index As Integer = Floor(x / mWidestTab)
		  
		  If index < 0 Then
		    Return -1
		  Else
		    Return MathsKit.Clamp(index, 0, mTabs.LastIndex)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060696E6465786020697320612076616C69642074616220696E6465782E
		Private Function ValidTabIndex(index As Integer) As Boolean
		  /// Returns True if `index` is a valid tab index.
		  
		  If index < 0 Then Return False
		  If mTabs.Count = 0 Then Return False
		  If index > mTabs.LastIndex Then Return False
		  
		  Return True
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 412074616220776173206A75737420616464656420746F2074686520746162206261722061742060696E646578602E
		Event DidAddTab(tab As XUITabBarItem, index As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865207573657220636F6E7465787574616C20636C69636B65642028726967687420636C69636B65642920696E736964652074686520746162206261722061742074686520706173736564206C6F63616C20636F6F7264696E617465732E
		Event DidContextualClick(x As Integer, y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 5468652075736572206A7573742066696E6973686564206472616767696E67206074616260202877686963682068617320612063757272656E7420696E646578206F662060696E64657860292E
		Event DidFinishDragging(tab As XUITabBarItem, index As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 412074616220686173206A757374206265656E2072656D6F7665642066726F6D2074686520746162206261722E
		Event DidRemoveTab(tab As XUITabBarItem)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520746162206174207468652073706563696669656420696E64657820776173206A7573742073656C65637465642E
		Event DidSelectTab(tab As XUITabBarItem, index As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 5468652075736572206A75737420626567616E206472616767696E67206074616260202877686963682068617320612063757272656E7420696E646578206F662060696E64657860292E
		Event DidStartDragging(tab As XUITabBarItem, index As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865206D6F75736520686173206A757374206578697465642074686520636F6E74726F6C2E
		Event MouseExit()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865206D6F75736520686173206A757374206D6F7665642077697468696E2074686520636F6E74726F6C2E
		Event MouseMove(x As Integer, y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865206D6F757365207363726F6C6C20776865656C2068617320747269676765726564206F7665722074686520636F6E74726F6C2E
		Event MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520636F6E74726F6C20686173206A7573742072657061696E7465642E
		Event Paint(g As Graphics)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865207573657220686173206A757374206A757374207072657373656420746865206D656E7520627574746F6E2E
		Event PressedMenuButton()
	#tag EndHook


	#tag Property, Flags = &h0, Description = 5472756520696620746162732063616E2062652072656F726465726564206279206472616767696E67207769746820746865206D6F7573652E
		AllowDragReordering As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 54686520776964746820617661696C61626C6520746F2072656E64657220746162732C20666163746F72696E6720696E207468652070726573656E6365206F7220616273656E6365206F6620746865206F7074696F6E616C206D656E7520627574746F6E2E
		#tag Getter
			Get
			  Return Self.Width - If(HasMenuButton, MenuButtonWidth, 0)
			  
			End Get
		#tag EndGetter
		Private AvailableTabSpace As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206974656D7320696E2074686520746162206261722E
		#tag Getter
			Get
			  Return mTabs.Count
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652066697273742074616220697320666978656420696E20706C61636520616E642063616E6E6F7420626520647261672D72656F7264657265642E
		HasAnchoredFirstTab As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686520746162206261722073686F756C6420647261772061206C65667420626F72646572206F6E20746865206C6566742D6D6F7374207461622E
		HasLeftBorder As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E2061206D656E7520627574746F6E2077696C6C20626520647261776E20746F20746865207269676874206F662074686520746162206261722E
		#tag Getter
			Get
			  Return mHasMenuButton
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasMenuButton = value
			  Redraw
			End Set
		#tag EndSetter
		HasMenuButton As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686520746162206261722073686F756C642064726177206120726967687420626F72646572206F6E207468652072696768742D6D6F7374207461622E
		HasRightBorder As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620746865206D6F75736520697320686F766572696E67206F7665722061207461622E
		#tag Getter
			Get
			  Return mMouseOverIndex <> -1
			End Get
		#tag EndGetter
		IsHoveringOverTab As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 41207069637475726520636F6E7461696E696E67207468652066756C6C20776964746820746162206261722E
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206D6F7573652069732063757272656E746C79206472616767696E672E
		Private mDragging As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5768656E206472616767696E672061207461622C20746869732069732074686520696E646578206265696E67206472616767656420746F2E
		Private mDragIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060786020636F6F7264696E61746520696E20746865206C61737420604D6F7573654472616760206576656E742E
		Private mDragX As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620706978656C732066726F6D20746865206C6566742065646765206F66207468652063757272656E746C7920647261676765642074616220746865206D6F75736520637572736F7220776173207768656E206472616767696E6720626567616E2E
		Private mDragXLeftEdgeOffset As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F7074696F6E616C2069636F6E20666F7220746865206D656E7520627574746F6E207768656E20686F7665726564206F7665722E
		#tag Getter
			Get
			  Return mMenuButtonHoverIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mMenuButtonHoverIcon = value
			  Redraw
			End Set
		#tag EndSetter
		MenuButtonHoverIcon As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F7074696F6E616C2069636F6E20666F7220746865206D656E7520627574746F6E2E
		#tag Getter
			Get
			  Return mMenuButtonIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mMenuButtonIcon = value
			  Redraw
			End Set
		#tag EndSetter
		MenuButtonIcon As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207769647468206F6620746865206F7074696F6E616C206D656E7520627574746F6E2E
		#tag Getter
			Get
			  Return mMenuButtonWidth
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mMenuButtonWidth = value
			  
			  Redraw
			End Set
		#tag EndSetter
		MenuButtonWidth As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2061206D656E7520627574746F6E2077696C6C20626520647261776E20746F20746865207269676874206F662074686520746162206261722E
		Private mHasMenuButton As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206D696E756D756D2077696474682061207461622077696C6C2062652E
		MinimumTabWidth As Double = 250
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206D6F75736520636C69636B2074686174206A757374206F6363757272656420696E2074686520604D6F757365446F776E60206576656E7420776173206120636F6E7465787475616C20636C69636B2E
		Private mLastClickWasContextual As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205820636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742E
		Private mLastMouseDownX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205920636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742E
		Private mLastMouseDownY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206F7074696F6E616C2069636F6E20666F7220746865206D656E7520627574746F6E207768656E20686F7665726564206F7665722E
		Private mMenuButtonHoverIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206F7074696F6E616C2069636F6E20666F7220746865206D656E7520627574746F6E2E
		Private mMenuButtonIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207769647468206F6620746865206F7074696F6E616C206D656E7520627574746F6E2E
		Private mMenuButtonWidth As Integer = 32
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E646578206F66207468652074616220756E64657220746865206D6F75736520647572696E6720746865206C617374204D6F757365446F776E206576656E742E
		Private mMouseDownIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207469636B73207768656E20746865206C617374204D6F757365446F776E206576656E74206F636375727265642E
		Private mMouseDownTicks As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205820636F6F7264696E61746520647572696E6720746865206C61737420604D6F7573654D6F7665282960206576656E742E
		Private mMouseMoveX As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205920636F6F7264696E61746520647572696E6720746865206C61737420604D6F7573654D6F7665282960206576656E742E
		Private mMouseMoveY As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E646578206F662074686520746162207468617420746865206D6F7573652069732063757272656E746C79206F766572206F7220602D3160206966206E6F74206F766572206F6E652E
		Private mMouseOverIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 43616368656420636F6D7075746174696F6E206F6660204F7665724D656E75427574746F6E6020636F6D707574656420696E20604D6F7573654D6F76652829602E
		Private mMouseOverMenuButton As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520746162206E6565647320726564726177696E672E
		Private mNeedsRedrawing As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520776964746820746865206275666665722073686F756C642062652E2053657420696E2060436F6D707574654275666665725769647468416E64576964657374546162602E
		Private mRequiredBufferWidth As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520686F72697A6F6E74616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720746F207468652072696768742E204261636B732074686520605363726F6C6C506F73586020636F6D70757465642070726F70657274792E
		Private mScrollPosX As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E646578206F66207468652063757272656E746C792073656C6563746564207461622E
		Private mSelectedTabIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207374796C65732075736564206279207468697320746162206261722E
		Private mStyle As XUITabBarStyle
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320746162206261722773206974656D732E
		Private mTabs() As XUITabBarItem
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207769647468206F662074686520776964657374207461622E2053657420696E2060436F6D707574654275666665725769647468416E64576964657374546162602E
		Private mWidestTab As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 54686520686F72697A6F6E74616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720746F207468652072696768742E
		#tag Getter
			Get
			  Return mScrollPosX
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Update how much the tab bar is horizontally scrolled.
			  
			  // Compute the maximum allowed X scroll position.
			  Var maxScrollPosX As Integer = Max(mRequiredBufferWidth - Self.Width, 0)
			  
			  // Set the value of ScrollPosX, not exceeding the maximum value.
			  mScrollPosX = MathsKit.Clamp(value, 0, maxScrollPosX)
			  
			  Redraw
			End Set
		#tag EndSetter
		Private ScrollPosX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520302D626173656420696E646578206F66207468652063757272656E746C792073656C6563746564207461622E20602D3160206966206E6F7468696E672069732073656C65637465642E
		#tag Getter
			Get
			  Return mSelectedTabIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value > mTabs.LastIndex Then Return
			  
			  mSelectedTabIndex = value
			  
			  Redraw
			End Set
		#tag EndSetter
		SelectedTabIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207374796C65732075736564206279207468697320746162206261722E
		#tag Getter
			Get
			  Return mStyle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mStyle = value
			  Redraw
			End Set
		#tag EndSetter
		Style As XUITabBarStyle
	#tag EndComputedProperty


	#tag Constant, Name = DRAG_SCROLL_THRESHOLD, Type = Double, Dynamic = False, Default = \"40", Scope = Private, Description = 546865206E756D626572206F6620706978656C732066726F6D207468652065646765207768656E206472616767696E6720746865206D6F757365206E6565647320746F2062652077697468696E20746F207363726F6C6C2074686520746162206261722E
	#tag EndConstant

	#tag Constant, Name = DRAG_THRESHOLD_DISTANCE, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320646966666572656E6365206265747765656E207468652063757272656E74206D6F75736520706F736974696F6E20616E6420746865206C61737420746F207472696767657220612064726167206F7065726174696F6E2E
	#tag EndConstant

	#tag Constant, Name = DRAG_THRESHOLD_TICKS, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F66207469636B732074686174206D757374206861766520656C6170736564206265747765656E20746865206C6173742064726167206F7065726174696F6E20746F207472696767657220616E6F7468657220647261672E
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
			InitialValue=""
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
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="200"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="28"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowDragReordering"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasAnchoredFirstTab"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumTabWidth"
			Visible=true
			Group="Behavior"
			InitialValue="250"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasLeftBorder"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasRightBorder"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Count"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedTabIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsHoveringOverTab"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasMenuButton"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuButtonWidth"
			Visible=true
			Group="Behavior"
			InitialValue="28"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuButtonIcon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuButtonHoverIcon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
