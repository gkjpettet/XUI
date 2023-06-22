#tag Class
Protected Class XUITabBar
Inherits DesktopCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  mMouseDownTicks = System.Ticks
		  
		  // At the exact moment the mouse is clicked we aren't dragging yet.
		  mIsDraggingTab = False
		  
		  // Cache the x, y coords that this mouse down event occurs at.
		  mMouseDownX = x
		  mMouseDownY = y
		  mMouseDownIndex = TabIndexAtXY(x, y)
		  mMouseOverLeftMenuButton = OverLeftMenuButton(x, y)
		  mMouseOverRightMenuButton = OverRightMenuButton(x, y)
		  
		  // Right click?
		  mLastClickWasContextual = IsContextualClick
		  If mLastClickWasContextual Then Return True
		  
		  // Nothing else to do if there are no tabs.
		  If mTabs.Count = 0 Then Return True
		  
		  If HasLeftMenuButton And mMouseOverLeftMenuButton Then
		    // Have clicked on the left menu button. This will be handled in `MouseUp()`.
		    Return True
		  ElseIf HasRightMenuButton And mMouseOverRightMenuButton Then
		    // Have clicked on the right menu button. This will be handled in `MouseUp()`.
		    Return True
		  End If
		  
		  // Get the index of the tab under the mouse.
		  Var index As Integer = TabIndexAtXY(x, y)
		  If index < 0 Or index > mTabs.LastIndex Then
		    // No tab under the mouse.
		    Return True
		  End If
		  
		  Var tab As XUITabBarItem = mTabs(index)
		  
		  // If the tab is enabled then select it.
		  If tab.Enabled Then SelectTabAtIndex(index)
		  
		  // Permit the `MouseUp` event to fire.
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(x As Integer, y As Integer)
		  If Not AllowDragReordering Then Return
		  
		  If System.Ticks - mMouseDownTicks > DRAG_THRESHOLD_TICKS Then
		    
		    mMouseDownTicks = System.Ticks
		    
		    If Abs(x - mMouseDownX) > DRAG_THRESHOLD_DISTANCE Or _
		      Abs(y - mMouseDownY) > DRAG_THRESHOLD_DISTANCE Then
		      
		      If Not ValidTabIndex(mMouseDownIndex) Then Return
		      
		      // Should we disallow dragging the first tab?
		      If FirstTabIsFixed And mMouseDownIndex = 0 Then Return
		      
		      Var startedDragging As Boolean = False
		      If Not mIsDraggingTab Then
		        // Have just started dragging. Compute the offset from the selected tab's left edge that the
		        // mouse is currently at.
		        startedDragging = True
		        Var selectedTab As XUITabBarItem = mTabs(mSelectedTabIndex)
		        mDraggingTabLeftEdgeXOffset = (x - selectedTab.Bounds.Left)
		      End If
		      
		      mIsDraggingTab = True
		      mMouseDragX = x
		      mMouseDragY = y
		      mDragIndex = TabIndexAtXY(x, y, True)
		      
		      // Should we scroll the tab bar?
		      If x > Self.Width - DRAG_SCROLL_THRESHOLD Then
		        ScrollPosX = ScrollPosX + DRAG_SCROLL_THRESHOLD
		      ElseIf x < DRAG_SCROLL_THRESHOLD Then
		        ScrollPosX = ScrollPosX - DRAG_SCROLL_THRESHOLD
		      End If
		      
		      If FirstTabIsFixed And mDragIndex = 0 Then
		        // Disallow dragging another tab into the first tab's position.
		        Refresh
		      ElseIf ValidTabIndex(mDragIndex) And mDragIndex <> mSelectedTabIndex Then
		        SwapTabs(mSelectedTabIndex, mDragIndex, False)
		        mSelectedTabIndex = mDragIndex
		        Refresh
		      Else
		        Refresh
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
		  mMouseMoveX = -1
		  mMouseMoveY = -1
		  mMouseOverIndex = -1
		  mMouseOverLeftMenuButton = False
		  mMouseOverRightMenuButton = False
		  
		  Refresh
		  
		  RaiseEvent MouseExit
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(x As Integer, y As Integer)
		  mMouseMoveX = x
		  mMouseMoveY = y
		  mMouseOverIndex = TabIndexAtXY(x, y)
		  mMouseOverLeftMenuButton = OverLeftMenuButton(x, y)
		  mMouseOverRightMenuButton = OverRightMenuButton(x, y)
		  
		  Refresh
		  
		  RaiseEvent MouseMove(x, y)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  If mIsDraggingTab Then
		    // Must have finished dragging.
		    mIsDraggingTab = False
		    mMouseDragX = 0
		    mMouseDragY = 0
		    mDragIndex = -1
		    Refresh
		    If mSelectedTabIndex <> -1 Then RaiseEvent DidFinishDragging(mTabs(mSelectedTabIndex), mSelectedTabIndex)
		    Return
		  End If
		  
		  // Right click?
		  If mLastClickWasContextual Then
		    If mMouseOverLeftMenuButton Then
		      DidContextualClickLeftMenuButton(x, y)
		    ElseIf mMouseOverRightMenuButton Then
		      DidContextualClickRightMenuButton(x, y)
		    ElseIf ValidTabIndex(mMouseOverIndex) Then
		      RaiseEvent DidContextualClickTab(mTabs(mMouseDownIndex), x, y)
		      Return
		    End If
		  End If
		  
		  // Close this tab?
		  If OverCloseIconAtIndex(mMouseOverIndex) Then
		    RemoveTabAt(mMouseOverIndex)
		    Return
		  End If
		  
		  // Clicked a menu button?
		  If HasLeftMenuButton And mMouseOverLeftMenuButton Then
		    RaiseEvent PressedLeftMenuButton
		  ElseIf HasRightMenuButton And mMouseOverRightMenuButton Then
		    RaiseEvent PressedRightMenuButton
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  If deltaX <> 0 Then
		    // deltaX reported by Xojo is very small. Beef it up a little.
		    deltaX = deltaX * 5
		    ScrollPosX = ScrollPosX + deltaX
		    Refresh
		  End If
		  
		  RaiseEvent MouseWheel(x, y, deltaX, deltaY)
		End Function
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  // Cache the scale factor.
		  mScaleX = g.ScaleX
		  
		  If Renderer = Nil Then Return
		  
		  // If the tab bar has resized or been repositioned since the last paint we need to do a full 
		  // redraw and reset the scrolling.
		  If (mPaintWidth <> Self.Width) Or (mPaintTop <> Self.Top) Or (mPaintLeft <> Self.Left) Then
		    mNeedsFullRedraw = True
		    ScrollPosX = 0
		    mPaintLeft = Self.Left
		    mPaintTop = Self.Top
		    mPaintWidth = Self.Width
		  End If
		  
		  Renderer.Render(g, ScrollPosX, mNeedsFullRedraw)
		End Sub
	#tag EndEvent

	#tag Event
		Sub ScaleFactorChanged()
		  Refresh
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 416464732061206E6577207461622061742074686520302D62617365642060696E646578602E2057696C6C20726169736520616E20604F75744F66426F756E6473457863657074696F6E602069662060696E6465786020697320696E76616C69642E
		Sub AddTabAt(index As Integer, caption As String, icon As Picture = Nil, tag As Variant = Nil, closable As Boolean = True, enabled As Boolean = True)
		  /// Adds a new tab at the 0-based `index`. 
		  /// Will raise an `OutOfBoundsException` if `index` is invalid.
		  
		  mTabs.AddAt(index, New XUITabBarItem(Self, caption, icon, tag, closable, enabled))
		  
		  Refresh
		  
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

	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor()
		  /// Default constructor.
		  
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  Self.Style = New XUITabBarStyle
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function OverCloseIconAtIndex(index As Integer) As Boolean
		  /// True if the mouse is over the close icon of the tab at `index`.
		  
		  // Sanity checks.
		  If mTabs.Count = 0 Then Return False
		  If index < 0 Or index > mTabs.LastIndex Then Return False
		  If mMouseMoveX = -1 Or mMouseMoveY = -1 Then Return False
		  
		  // Get the tab.
		  Var tab As XUITabBarItem = mTabs(index)
		  
		  If Not tab.Closable Then Return False
		  If tab.CloseIconBounds = Nil Then Return False
		  
		  // We know where the mouse was during the last mouse move but we need to account for any scrolling.
		  Var x As Integer = mMouseMoveX + ScrollPosX
		  
		  Return tab.CloseIconBounds.Contains(x, mMouseMoveY)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547275652069662060782C207960206973206F76657220746865206C656674206D656E7520627574746F6E2E
		Private Function OverLeftMenuButton(x As Integer, y As Integer) As Boolean
		  /// True if `x, y` is over the left menu button.
		  ///
		  /// `x` is the absolute coordinate from the left edge of the tab bar. It does not account for any
		  /// scrolling of the tab bar.
		  /// `y` is the absolute coordinate from the top left edge of the tab bar.
		  
		  // Adjust for scrolling.
		  x = x + ScrollPosX
		  
		  If Not HasLeftMenuButton Then Return False
		  If Not Renderer.SupportsLeftMenuButton Then Return False
		  If LeftMenuButtonBounds = Nil Then Return False
		  
		  Return LeftMenuButtonBounds.Contains(x, y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547275652069662060782C207960206973206F76657220746865207269676874206D656E7520627574746F6E2E
		Private Function OverRightMenuButton(x As Integer, y As Integer) As Boolean
		  /// True if `x, y` is over the right menu button.
		  ///
		  /// `x` is the absolute coordinate from the left edge of the tab bar. It does not account for any
		  /// scrolling of the tab bar.
		  /// `y` is the absolute coordinate from the top left edge of the tab bar.
		  
		  // Adjust for scrolling.
		  x = x + ScrollPosX
		  
		  If Not HasRightMenuButton Then Return False
		  If Not Renderer.SupportsRightMenuButton Then Return False
		  If RightMenuButtonBounds = Nil Then Return False
		  
		  Return RightMenuButtonBounds.Contains(x, y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F766573207468652073656C65637465642074616220746F207468652074616220746F20746865206C656674206F66207468652063757272656E746C792073656C6563746564207461622C207772617070696E6720726F756E6420746F207468652072696768742D6D6F73742074616220696620706167696E672066726F6D20746865206C6566742D6D6F7374207461622E
		Sub PageLeft()
		  /// Moves the selected tab to the tab to the left of the currently selected tab, wrapping round to the right-most
		  /// tab if paging from the left-most tab.
		  
		  If mTabs.Count <= 1 Then Return
		  If mSelectedTabIndex = -1 Then Return
		  
		  If mSelectedTabIndex = 0 Then
		    mSelectedTabIndex = mTabs.LastIndex
		  Else
		    mSelectedTabIndex = mSelectedTabIndex - 1
		  End If
		  
		  Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F766573207468652073656C65637465642074616220746F207468652074616220746F20746865207269676874206F66207468652063757272656E746C792073656C6563746564207461622C207772617070696E672061726F756E6420746F2074686520666972737420746162206966206F6E207468652072696768742D6D6F7374207461622070726573656E746C792E
		Sub PageRight()
		  /// Moves the selected tab to the tab to the right of the currently selected tab, wrapping around to the first
		  /// tab if on the right-most tab presently.
		  
		  If mTabs.Count <= 1 Then Return
		  If mSelectedTabIndex = -1 Then Return
		  
		  If mSelectedTabIndex = mTabs.LastIndex Then
		    mSelectedTabIndex = 0
		  Else
		    mSelectedTabIndex = mSelectedTabIndex + 1
		  End If
		  
		  Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 506F7073207468652072696768742D6D6F737420746162206F6666206F6620746865207461622062617220616E642072657475726E732069742E204D61792072657475726E204E696C20696620746865726520617265206E6F20746162732E
		Function PopTab() As XUITabBarItem
		  /// Pops the right-most tab off of the tab bar and returns it. May return Nil if there are no tabs.
		  
		  If mTabs.Count < 1 Then Return Nil
		  
		  Var popped As XUITabBarItem = mTabs.Pop
		  
		  Refresh
		  
		  DidRemoveTab(popped)
		  
		  Return popped
		  
		End Function
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
		  
		  Refresh
		  
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
		  
		  Refresh
		  
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
		  
		  Refresh
		  
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
		  
		  If shouldRedraw Then Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520696E646578206F662074686520746162206174206D6F75736520706F736974696F6E2060782C207960206F72202D312069662074686572652069736E2774206F6E652E
		Private Function TabIndexAtXY(x As Integer, y As Integer, excludeSelected As Boolean = False) As Integer
		  /// Returns the index of the tab at mouse position `x, y` or -1 if there isn't one.
		  ///
		  /// - `x` is the absolute coordinate from the left edge of the tab bar. It does not account for any
		  /// scrolling of the tab bar.
		  /// - `y` is the absolute coordinate from the top left edge of the tab bar.
		  /// - If `excludeSelected` then we don't check the currently selected tab's bounds.
		  
		  // Adjust for scrolling.
		  x = x + ScrollPosX
		  
		  // Sanity checks.
		  If mTabs.Count = 0 Then Return -1
		  If x < 0 Then Return -1
		  
		  Var selectedTab As XUITabBarItem
		  If ValidTabIndex(mSelectedTabIndex) Then
		    selectedTab = mTabs(mSelectedTabIndex)
		  Else
		    selectedTab = Nil
		  End If
		  
		  For i As Integer = 0 To mTabs.LastIndex
		    Var tab As XUITabBarItem = mTabs(i)
		    If excludeSelected And tab = selectedTab Then Continue
		    
		    If tab.Bounds <> Nil And tab.Bounds.Contains(x, y) Then Return i
		  Next i
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652074616220626172277320746162732E20546869732061727261792073686F756C6420626520636F6E736964657265642072656164206F6E6C792E20446F206E6F74206D6F6469667920697421
		Function Tabs() As XUITabBarItem()
		  /// Returns the tab bar's tabs. This array should be considered read only. Do not modify it!
		  
		  Return mTabs
		  
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

	#tag Hook, Flags = &h0, Description = 546865207573657220636F6E7465787574616C20636C69636B65642028726967687420636C69636B656429206F76657220746865206C656674206D656E7520627574746F6E206174207468652070617373656420636F6F7264696E617465732E2054686520636F6F7264696E6174657320617265206C6F63616C20746F2074686520746F70206C65667420636F726E6572206F662074686520746162206261722E
		Event DidContextualClickLeftMenuButton(x As Integer, y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865207573657220636F6E7465787574616C20636C69636B656420286C65667420636C69636B656429206F76657220746865206C656674206D656E7520627574746F6E206174207468652070617373656420636F6F7264696E617465732E2054686520636F6F7264696E6174657320617265206C6F63616C20746F2074686520746F70206C65667420636F726E6572206F662074686520746162206261722E
		Event DidContextualClickRightMenuButton(x As Integer, y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865207573657220636F6E7465787574616C20636C69636B65642028726967687420636C69636B656429206F766572206120746162206174207468652070617373656420636F6F7264696E617465732E2054686520636F6F7264696E6174657320617265206C6F63616C20746F2074686520746F70206C65667420636F726E6572206F662074686520746162206261722E
		Event DidContextualClickTab(tab As XUITabBarItem, x As Integer, y As Integer)
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

	#tag Hook, Flags = &h0, Description = 546865207573657220686173206A757374206A757374207072657373656420746865206C656674206D656E7520627574746F6E2E
		Event PressedLeftMenuButton()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865207573657220686173206A757374206A757374207072657373656420746865207269676874206D656E7520627574746F6E2E
		Event PressedRightMenuButton()
	#tag EndHook


	#tag Note, Name = About
		`XUITabBar` is a beautiful, flexible and powerful UI control. It provides an easy-to-use 
		implementation of a _source list_. Source lists are a familiar UI control typically used as a 
		navigation sidebar in applications. Examples are the sidebar in the Finder on macOS and the 
		navigator in the Xojo IDE.
		
		`XUITabBar` abstracts away a lot of the complexity of managing a navigation sidebar so you don't
		have to worry about it.
		
		The control supports drag reordering, unlimited item depths, badge counts, custom widgets and 
		more.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5472756520696620746162732063616E2062652072656F726465726564206279206472616767696E67207769746820746865206D6F7573652E
		AllowDragReordering As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520776964746820617661696C61626C6520746F2072656E64657220746162732C20666163746F72696E6720696E207468652070726573656E6365206F7220616273656E6365206F6620746865206F7074696F6E616C206D656E7520627574746F6E732E
		#tag Getter
			Get
			  Var menuButtonSpace As Integer
			  If HasLeftMenuButton And Renderer.SupportsLeftMenuButton Then
			    menuButtonSpace = menuButtonSpace + Renderer.LeftMenuButtonWidth
			  End If
			  If HasRightMenuButton And Renderer.SupportsRightMenuButton Then
			    menuButtonSpace = menuButtonSpace + Renderer.RightMenuButtonWidth
			  End If
			  
			  Return Self.Width - menuButtonSpace
			End Get
		#tag EndGetter
		AvailableTabSpace As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F66667365742066726F6D20746865206C6566742065646765206F66207468652074616220746861742773206265696E6720647261676765642E
		#tag Getter
			Get
			  Return mDraggingTabLeftEdgeXOffset
			End Get
		#tag EndGetter
		DraggingTabLeftEdgeXOffset As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E20746865206669727374207461622028696E64657820302920697320666978656420616E642063616E6E6F74206265206472616767656420746F2061206E657720706F736974696F6E2E
		FirstTabIsFixed As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686520746162206261722073686F756C6420647261772061206C65667420626F72646572206F6E20746865206C6566742D6D6F7374207461622E
		HasLeftBorder As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4966205472756520616E6420746865202872656E6465726572207375706F72747320697429207468656E2061206D656E7520627574746F6E2077696C6C20626520647261776E20746F20746865206C656674206F662074686520746162206261722E
		#tag Getter
			Get
			  Return mHasLeftMenuButton
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasLeftMenuButton = value
			  Refresh
			End Set
		#tag EndSetter
		HasLeftMenuButton As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686520746162206261722073686F756C642064726177206120726967687420626F72646572206F6E207468652072696768742D6D6F7374207461622E
		HasRightBorder As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4966205472756520616E6420746865202872656E6465726572207375706F72747320697429207468656E2061206D656E7520627574746F6E2077696C6C20626520647261776E20746F20746865207269676874206F662074686520746162206261722E
		#tag Getter
			Get
			  Return mHasRightMenuButton
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasRightMenuButton = value
			  Refresh
			End Set
		#tag EndSetter
		HasRightMenuButton As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662061207461622069732063757272656E746C79206265696E6720647261676765642E
		#tag Getter
			Get
			  Return mIsDraggingTab
			End Get
		#tag EndGetter
		IsDraggingTab As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520626F756E6473206F6620746865206C656674206D656E7520627574746F6E2028696620656E61626C6564292E20536574206279207468652072656E64657265722E204D6179206265204E696C2E
		LeftMenuButtonBounds As Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 496620746865206C656674206D656E7520627574746F6E20697320656E61626C65642C2074686973206973207468652069636F6E20746F207573652E
		#tag Getter
			Get
			  Return mLeftMenuButtonIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mLeftMenuButtonIcon = value
			  
			  Refresh
			End Set
		#tag EndSetter
		LeftMenuButtonIcon As Picture
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 546865206F66667365742066726F6D20746865206C6566742065646765206F66207468652074616220746861742773206265696E6720647261676765642E
		Private mDraggingTabLeftEdgeXOffset As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5768656E206472616767696E672061207461622C20746869732069732074686520696E646578206265696E67206472616767656420746F2E
		Private mDragIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4966205472756520616E6420746865202872656E6465726572207375706F72747320697429207468656E2061206D656E7520627574746F6E2077696C6C20626520647261776E20746F20746865206C656674206F662074686520746162206261722E
		Private mHasLeftMenuButton As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4966205472756520616E6420746865202872656E6465726572207375706F72747320697429207468656E2061206D656E7520627574746F6E2077696C6C20626520647261776E20746F20746865207269676874206F662074686520746162206261722E
		Private mHasRightMenuButton As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662061207461622069732063757272656E746C79206265696E6720647261676765642E
		Private mIsDraggingTab As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206D6F75736520636C69636B2074686174206A757374206F6363757272656420696E2074686520604D6F757365446F776E60206576656E7420776173206120636F6E7465787475616C20636C69636B2E
		Private mLastClickWasContextual As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496620746865206C656674206D656E7520627574746F6E20697320656E61626C65642C2074686973206973207468652069636F6E20746F207573652E
		Private mLeftMenuButtonIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E646578206F66207468652074616220756E64657220746865206D6F75736520647572696E6720746865206C61737420604D6F757365446F776E60206576656E742E20602D3160206966207468657265207761736E2774206F6E652E
		Private mMouseDownIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207469636B73207768656E20746865206C617374204D6F757365446F776E206576656E74206F636375727265642E
		Private mMouseDownTicks As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060586020636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742E
		Private mMouseDownX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060596020636F6F7264696E617465206F6620746865206C61737420604D6F757365446F776E60206576656E742E
		Private mMouseDownY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060586020636F6F7264696E61746520696E20746865206C61737420604D6F7573654472616760206576656E742E
		Private mMouseDragX As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060596020636F6F7264696E61746520696E20746865206C61737420604D6F7573654472616760206576656E742E
		Private mMouseDragY As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520582076616C756520647572696E6720746865206C61737420604D6F7573654D6F766560206576656E742E2053657420746F202D3120696620746865206D6F757365206C65617665732074686520746162206261722E
		Private mMouseMoveX As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520592076616C756520647572696E6720746865206C61737420604D6F7573654D6F766560206576656E742E2053657420746F202D3120696620746865206D6F757365206C65617665732074686520746162206261722E
		Private mMouseMoveY As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E646578206F662074686520746162207468617420746865206D6F7573652069732063757272656E746C79206F766572206F7220602D3160206966206E6F74206F766572206F6E652E
		Private mMouseOverIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 43616368656420636F6D7075746174696F6E206F6660204F7665724C6566744D656E75427574746F6E6020636F6D707574656420696E20604D6F7573654D6F76652829602E
		Private mMouseOverLeftMenuButton As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 43616368656420636F6D7075746174696F6E206F6660204F76657252696768744D656E75427574746F6E6020636F6D707574656420696E20604D6F7573654D6F76652829602E
		Private mMouseOverRightMenuButton As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652074616220626172206E6565647320612066756C6C2072656472617720647572696E6720697473206E65787420605061696E74282960206576656E742E
		Private mNeedsFullRedraw As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652060586020636F6F7264696E61746520696E20746865206C61737420604D6F7573654472616760206576656E742E2052656164206F6E6C792E
		#tag Getter
			Get
			  Return mMouseDragX
			End Get
		#tag EndGetter
		MouseDragX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652060596020636F6F7264696E61746520696E20746865206C61737420604D6F7573654472616760206576656E742E2052656164206F6E6C792E
		#tag Getter
			Get
			  Return mMouseDragY
			End Get
		#tag EndGetter
		MouseDragY As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520582076616C756520647572696E6720746865206C61737420604D6F7573654D6F766560206576656E742E2053657420746F202D3120696620746865206D6F757365206C65617665732074686520746162206261722E
		#tag Getter
			Get
			  Return mMouseMoveX
			End Get
		#tag EndGetter
		MouseMoveX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520592076616C756520647572696E6720746865206C61737420604D6F7573654D6F766560206576656E742E2053657420746F202D3120696620746865206D6F757365206C65617665732074686520746162206261722E
		#tag Getter
			Get
			  Return mMouseMoveY
			End Get
		#tag EndGetter
		MouseMoveY As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 546865206C656674206F662074686520636F6E74726F6C20647572696E6720746865206C61737420605061696E7460206576656E742E
		Private mPaintLeft As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F70206F662074686520636F6E74726F6C20647572696E6720746865206C61737420605061696E7460206576656E742E
		Private mPaintTop As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207769647468206F662074686520636F6E74726F6C20647572696E6720746865206C61737420605061696E7460206576656E742E
		Private mPaintWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652072656E646572657220746F2075736520666F722074686520746162206261722E
		Private mRenderer As XUITabBarRenderer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496620746865207269676874206D656E7520627574746F6E20697320656E61626C65642C2074686973206973207468652069636F6E20746F207573652E
		Private mRightMenuButtonIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4361636865642076616C7565206F662060672E5363616C6558602066726F6D20746865206C61737420605061696E7460206576656E742E
		Private mScaleX As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520686F72697A6F6E74616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720746F207468652072696768742E204261636B732074686520605363726F6C6C506F73586020636F6D70757465642070726F70657274792E
		Private mScrollPosX As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E646578206F66207468652063757272656E746C792073656C6563746564207461622E
		Private mSelectedTabIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572207374796C6520746F2075736520666F722074686520746162206261722E
		Private mStyle As XUITabBarStyle
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320746162206261722773206974656D732E
		Private mTabs() As XUITabBarItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652072656E646572657220746F2075736520666F722074686520746162206261722E
		#tag Getter
			Get
			  Return mRenderer
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRenderer = value
			  
			  If value = Nil Then Return
			  
			  
			End Set
		#tag EndSetter
		Renderer As XUITabBarRenderer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520626F756E6473206F6620746865207269676874206D656E7520627574746F6E2028696620656E61626C6564292E20536574206279207468652072656E64657265722E204D6179206265204E696C2E
		RightMenuButtonBounds As Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 496620746865207269676874206D656E7520627574746F6E20697320656E61626C65642C2074686973206973207468652069636F6E20746F207573652E
		#tag Getter
			Get
			  Return mRightMenuButtonIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRightMenuButtonIcon = value
			  
			  Refresh
			End Set
		#tag EndSetter
		RightMenuButtonIcon As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520686F72697A6F6E74616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720746F207468652072696768742E
		#tag Getter
			Get
			  Return mScrollPosX
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Update how much the tab bar is horizontally scrolled.
			  
			  If Renderer = Nil Then Return
			  
			  // Compute the maximum allowed X scroll position.
			  Var maxScrollPosX As Integer = Max((Renderer.BufferWidth / mScaleX) - Self.Width, 0)
			  
			  // Set the value of ScrollPosX, not exceeding the maximum value.
			  mScrollPosX = Maths.Clamp(value, 0, maxScrollPosX)
			  
			  Refresh
			End Set
		#tag EndSetter
		ScrollPosX As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E746C792073656C6563746564207461622E204D6179206265204E696C2E
		#tag Getter
			Get
			  If mSelectedTabIndex < 0 Or mSelectedTabIndex > mTabs.LastIndex Then
			    Return Nil
			  Else
			    Return mTabs(mSelectedTabIndex)
			  End If
			End Get
		#tag EndGetter
		SelectedTab As XUITabBarItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696E646578206F66207468652063757272656E746C792073656C6563746564207461622E2052656164206F6E6C792E20557365206053656C6563745461624174496E6465786020746F2073656C6563742061207461622E
		#tag Getter
			Get
			  Return mSelectedTabIndex
			End Get
		#tag EndGetter
		SelectedTabIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572207374796C6520746F2075736520666F722074686520746162206261722E
		#tag Getter
			Get
			  If mStyle = Nil Then mStyle = New XUITabBarStyle
			  
			  Return mStyle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mStyle = value
			  If Self.Renderer <> Nil Then Refresh
			End Set
		#tag EndSetter
		Style As XUITabBarStyle
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66207461627320696E2074686520746162206261722E
		#tag Getter
			Get
			  Return mTabs.Count
			End Get
		#tag EndGetter
		TabCount As Integer
	#tag EndComputedProperty


	#tag Constant, Name = DRAG_SCROLL_THRESHOLD, Type = Double, Dynamic = False, Default = \"40", Scope = Private, Description = 546865206E756D626572206F6620706978656C732066726F6D207468652065646765207768656E206472616767696E67207468617420746865206D6F757365206E6565647320746F2062652077697468696E20746F207363726F6C6C2074686520746162206261722E
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
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
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
			InitialValue="True"
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
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
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
			Name="HasLeftMenuButton"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasRightMenuButton"
			Visible=true
			Group="Behavior"
			InitialValue="False"
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
			Name="AvailableTabSpace"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasLeftBorder"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasRightBorder"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MouseMoveX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MouseMoveY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsDraggingTab"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MouseDragX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MouseDragY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DraggingTabLeftEdgeXOffset"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LeftMenuButtonIcon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RightMenuButtonIcon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollPosX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FirstTabIsFixed"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
