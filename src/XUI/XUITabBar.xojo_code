#tag Class
Protected Class XUITabBar
Inherits DesktopCanvas
	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  If deltaX <> 0 Then
		    // deltaX reported by Xojo is very small. Beef it up a little.
		    deltaX = deltaX * 5
		    ScrollPosX = ScrollPosX + deltaX
		    Redraw
		  End If
		  
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
		  
		  If (mTabs.Count * mWidestTab) < Self.Width Then
		    mWidestTab = Self.Width / mTabs.Count
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
		  
		  // Draw all tabs to the buffer except for the active one.
		  Var x, selectedTabX As Integer = 0
		  For i As Integer = 0 To mTabs.LastIndex
		    Var tab As XUITabBarItem = mTabs(i)
		    If i <> mSelectedTabIndex Then
		      x = tab.Draw(g, x, False, mWidestTab)
		    Else
		      selectedTabX = x
		      x = x + mWidestTab
		    End If
		  Next i
		  
		  // Draw the selected tab.
		  If mSelectedTabIndex <> -1 Then
		    Call mTabs(mSelectedTabIndex).Draw(g, selectedTabX, True, mWidestTab)
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
		  If mSelectedTabIndex = index Then
		    // We just removed the selected tab. Select the tab to the left of this.
		    mSelectedTabIndex = index - 1
		  ElseIf index < mSelectedTabIndex Then
		    // We removed a tab to the left of the currently selected tab. Adjust.
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


	#tag Hook, Flags = &h0, Description = 412074616220776173206A75737420616464656420746F2074686520746162206261722061742060696E646578602E
		Event DidAddTab(tab As XUITabBarItem, index As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 412074616220686173206A757374206265656E2072656D6F7665642066726F6D2074686520746162206261722E
		Event DidRemoveTab(tab As XUITabBarItem)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520746162206174207468652073706563696669656420696E64657820776173206A7573742073656C65637465642E
		Event DidSelectTab(tab As XUITabBarItem, index As Integer)
	#tag EndHook


	#tag Property, Flags = &h0, Description = 5472756520696620746162732063616E2062652072656F726465726564206279206472616767696E67207769746820746865206D6F7573652E
		AllowDragReordering As Boolean
	#tag EndProperty

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

	#tag Property, Flags = &h0, Description = 547275652069662074686520746162206261722073686F756C642064726177206120726967687420626F72646572206F6E207468652072696768742D6D6F7374207461622E
		HasRightBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207069637475726520636F6E7461696E696E67207468652066756C6C20776964746820746162206261722E
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206D696E756D756D2077696474682061207461622077696C6C2062652E
		MinimumTabWidth As Double = 250
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
			Name="AllowDragReordering"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasAnchoredFirstTab"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
