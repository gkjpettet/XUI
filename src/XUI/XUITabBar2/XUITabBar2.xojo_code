#tag Class
Protected Class XUITabBar2
Inherits DesktopCanvas
	#tag Method, Flags = &h0, Description = 416464732061206E6577207461622061742074686520302D62617365642060696E646578602E2057696C6C20726169736520616E20604F75744F66426F756E6473457863657074696F6E602069662060696E6465786020697320696E76616C69642E
		Sub AddTabAt(index As Integer, caption As String, icon As Picture = Nil, tag As Variant = Nil, closable As Boolean = True, enabled As Boolean = True)
		  /// Adds a new tab at the 0-based `index`. 
		  /// Will raise an `OutOfBoundsException` if `index` is invalid.
		  
		  mTabs.AddAt(index, New XUITabBar2Item(Self, caption, icon, tag, closable, enabled))
		  
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

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  Self.Style = New XUITabBar2Style
		  
		End Sub
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
		Function PopTab() As XUITabBar2Item
		  /// Pops the right-most tab off of the tab bar and returns it. May return Nil if there are no tabs.
		  
		  If mTabs.Count < 1 Then Return Nil
		  
		  Var popped As XUITabBar2Item = mTabs.Pop
		  
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
		  
		  Var removed As XUITabBar2Item = mTabs(index)
		  
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
		Sub ReplaceTabAt(index As Integer, newTab As XUITabBar2Item)
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
		  
		  Var tab2 As XUITabBar2Item = mTabs(index2)
		  mTabs(index2) = mTabs(Index1)
		  mTabs(Index1) = tab2
		  
		  If shouldRedraw Then Refresh
		End Sub
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
		Event DidAddTab(tab As XUITabBar2Item, index As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 412074616220686173206A757374206265656E2072656D6F7665642066726F6D2074686520746162206261722E
		Event DidRemoveTab(tab As XUITabBar2Item)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520746162206174207468652073706563696669656420696E64657820776173206A7573742073656C65637465642E
		Event DidSelectTab(tab As XUITabBar2Item, index As Integer)
	#tag EndHook


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

	#tag Property, Flags = &h21, Description = 4966205472756520616E6420746865202872656E6465726572207375706F72747320697429207468656E2061206D656E7520627574746F6E2077696C6C20626520647261776E20746F20746865206C656674206F662074686520746162206261722E
		Private mHasLeftMenuButton As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4966205472756520616E6420746865202872656E6465726572207375706F72747320697429207468656E2061206D656E7520627574746F6E2077696C6C20626520647261776E20746F20746865207269676874206F662074686520746162206261722E
		Private mHasRightMenuButton As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652072656E646572657220746F2075736520666F722074686520746162206261722E
		Private mRenderer As XUITabBarRenderer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E646578206F66207468652063757272656E746C792073656C6563746564207461622E
		Private mSelectedTabIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572207374796C6520746F2075736520666F722074686520746162206261722E
		Private mStyle As XUITabBar2Style
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320746162206261722773206974656D732E
		Private mTabs() As XUITabBar2Item
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
			  If mStyle = Nil Then mStyle = New XUITabBar2Style
			  
			  Return mStyle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mStyle = value
			  If Self.Renderer <> Nil Then Refresh
			End Set
		#tag EndSetter
		Style As XUITabBar2Style
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
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
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
			Name="TabPanelIndex"
			Visible=false
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
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
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
			Name="SelectedTabIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasLeftMenuButton"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasRightMenuButton"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowDragReordering"
			Visible=false
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
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasRightBorder"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
