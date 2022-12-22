#tag Class
Protected Class XUIInspectorSection
	#tag Method, Flags = &h0, Description = 417070656E647320606974656D6020746F2074686520656E64206F6620746869732073656374696F6E2E
		Sub AddItem(item As XUIInspectorItem)
		  /// Appends `item` to the end of this section.
		  
		  mItems.Add(item)
		  
		  item.Owner = Self.Owner
		  item.Section = Self
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddItemAt(index As Integer, item As XUIInspectorItem)
		  /// Adds `item` at the specified index.
		  /// Raises an `OutOfBoundsException` if `index` is out of bounds.
		  
		  mItems.AddAt(index, item)
		  
		  item.Owner = Self.Owner
		  item.Section = Self
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E65772073656374696F6E2E
		Sub Constructor(name As String, collapsible As Boolean, expanded As Boolean = True)
		  /// Constructs a new section.
		  
		  Self.Name = name
		  Self.Collapsible = collapsible
		  Self.Expanded = expanded
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206669727374206974656D20696E20746869732073656374696F6E20746861742063616E206163636570742074616220666F637573206F72204E696C206966206E6F6E65206172652061626C6520746F2E
		Function FirstItemThatCanAcceptTabFocus() As XUIInspectorItem
		  /// Returns the first item in this section that can accept tab focus or Nil if none are able to.
		  
		  // If this section is not expanded then none of its items will be able to receive the focus.
		  If Not Expanded Then Return Nil
		  
		  For Each item As XUIInspectorItem In mItems
		    If item.CanAcceptTabFocus Then
		      Return item
		    End If
		  Next item
		  
		  // No items in this section can receive tab focus.
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652063757272656E7420686569676874206F66207468652073656374696F6E2C20666163746F72696E6720696E207768657468657220697420697320636F6C6C6170736564206F7220657870616E6465642E
		Function Height(style As XUIInspectorStyle) As Double
		  /// Returns the current height of the section, factoring in whether it is collapsed or expanded.
		  
		  Var h As Double = HEADER_HEIGHT + HEADER_BOTTOM_PADDING
		  
		  If Expanded Then
		    For Each item As XUIInspectorItem In mItems
		      h = h + item.Height(style)
		    Next item
		  End If
		  
		  Return h
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C73207468652073656374696F6E20746861742061206D6F75736520646F776E206576656E7420686173206F636375727265642077697468696E2069747320626F756E64732E20782C20792061726520746865206162736F6C75746520636F6F7264696E617465732072656C617469766520746F2074686520696E73706563746F72202861646A757374656420666F72207363726F6C6C696E67292E2052657475726E732061204D6F757365446F776E4461746120696E7374616E636520696E737472756374696E672074686520696E73706563746F7220686F7720746F2068616E646C6520746865206576656E742E
		Function MouseDown(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseDownData
		  /// Tells the section that a mouse down event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseDownData instance instructing the inspector how to handle the event or Nil if the
		  /// the click didn't happen in this section.
		  
		  // Did the user click the disclosure widget?
		  If DisclosureBounds <> Nil And DisclosureBounds.Contains(x, y) Then
		    Expanded = Not Expanded
		    
		    If Not Expanded And Owner.ItemWithFocus <> Nil Then
		      // If one of this section's items was in focus, if should lose it.
		      For Each item As XUIInspectorItem In mItems
		        If item = Owner.ItemWithFocus Then
		          Owner.ItemWithFocus = Nil
		          Exit
		        End If
		      Next item
		    End If
		    
		    Return New XUIInspectorMouseDownData
		  End If
		  
		  // Did the user click on an item?
		  For Each item As XUIInspectorItem In mItems
		    If item.Bounds <> Nil And item.Bounds.Contains(x, y) Then
		      Var result As XUIInspectorMouseDownData = item.MouseDown(x, y, clickType)
		      If result <> Nil And Owner.ItemWithFocus <> item Then
		        Owner.ItemWithFocus = item
		      End If
		      Return result
		    End If
		  Next item
		  
		  // The click did not happen in this section.
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206D6F75736520686173206A757374206D6F766564206F76657220746869732073656374696F6E2E2052657475726E73204E696C206966206E6F206974656D732077657265206D6F766564206F766572206F74686572776973652072657475726E7320646174612061626F757420746865206974656D206D6F766564206F7665722E
		Function MouseMoved(x As Double, y As Double) As XUIInspectorMouseMoveData
		  /// The mouse has just moved over this section.
		  /// Returns Nil if no items were moved over otherwise returns data about the item moved over.
		  
		  For Each item As XUIInspectorItem In mItems
		    If item.Bounds.Contains(x, y) Then
		      Return item.MouseMoved(x, y)
		    End If
		  Next item
		  
		  // No items moved over.
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C73207468652073656374696F6E20746861742061206D6F75736520646F776E206576656E7420686173206F636375727265642077697468696E2069747320626F756E64732E20782C20792061726520746865206162736F6C75746520636F6F7264696E617465732072656C617469766520746F2074686520696E73706563746F72202861646A757374656420666F72207363726F6C6C696E67292E2052657475726E732061204D6F757365446F776E4461746120696E7374616E636520696E737472756374696E672074686520696E73706563746F7220686F7720746F2068616E646C6520746865206576656E742E
		Function MouseUp(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseUpData
		  /// Tells the section that a mouse up event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseUpData instance instructing the inspector how to handle the event or Nil if the
		  /// the click didn't happen in this section.
		  
		  // Did the user click the disclosure widget?
		  If DisclosureBounds <> Nil And DisclosureBounds.Contains(x, y) Then
		    // We do nothing since toggling the expansion status is handled upon MouseDown.
		    Return New XUIInspectorMouseUpData(False)
		  End If
		  
		  // Did the user click on an item?
		  For Each item As XUIInspectorItem In mItems
		    If item.Bounds <> Nil And item.Bounds.Contains(x, y) Then
		      Var result As XUIInspectorMouseUpData = item.MouseUp(x, y, clickType)
		      If result <> Nil And Owner <> Nil And Owner.ItemWithFocus <> item Then
		        Owner.ItemWithFocus = item
		      End If
		      Return result
		    End If
		  Next item
		  
		  // The click did not happen in this section.
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveFocusToNextItem(currentItemWithFocus As XUIInspectorItem) As XUIInspectorItem
		  /// Returns the next item that can receive tab focus given `currentItemWithFocus` or Nil if there
		  /// is no item in this section after `currentItemWithFocus` that can receive tab focus.
		  
		  // If the section is collapsed then none of its items can receive the focus.
		  If Not Expanded Then Return Nil
		  
		  // currentItemWithFocus may not be in this section in which case we return the first item that 
		  // can receive focus (if any).
		  Var currentItemIndex As Integer = mItems.IndexOf(currentItemWithFocus)
		  If currentItemIndex = -1 Then
		    Return FirstItemThatCanAcceptTabFocus
		  End If
		  
		  // Edge case: The current item contains multiple controls that can accept tab focus
		  // (such as a dual text field item).
		  If currentItemWithFocus IsA XUIInspectorItemWithMultipleTabFocusControls Then
		    If XUIInspectorItemWithMultipleTabFocusControls(currentItemWithFocus).CanAcceptAnotherTabFocus Then
		      Return currentItemWithFocus
		    End If
		  End If
		  
		  // currentItemWithFocus is in this section and it is an item that only contains one
		  // tabbale control.
		  // Starting from the item after it, return the next valid item.
		  For i As Integer = currentItemIndex + 1 To mItems.LastIndex
		    If mItems(i).CanAcceptTabFocus Then
		      Return mItems(i)
		    End If
		  Next i
		  
		  // If we've reached here then there are no more items that can receive the tab focus.
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320606974656D602066726F6D20746869732073656374696F6E20696620666F756E642E
		Sub Remove(item As XUIInspectorItem)
		  /// Removes `item` from this section if found.
		  
		  Var index As Integer = mItems.IndexOf(item)
		  If index <> -1 Then
		    mItems(index).Owner = Nil
		    mItems.RemoveAt(index)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320746865206974656D2061742060696E646578602E2052616973657320616E20604F75744F66426F756E6473457863657074696F6E602069662060696E6465786020696E20696E76616C69642E
		Sub RemoveAt(index As Integer)
		  /// Removes the item at `index`.
		  /// Raises an `OutOfBoundsException` if `index` in invalid.
		  
		  mItems(index).Owner = Nil
		  mItems.RemoveAt(index)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320746869732073656374696F6E20746F2060676020776974682069747320746F702D6C65667420636F726E657220617420782C20792E2052657475726E7320746865206C6F636174696F6E20746F206472617720746865206E6578742073656374696F6E277320746F702D6C65667420636F726E65722E
		Function Render(g As Graphics, x As Double, y As Double, style As XUIInspectorStyle) As Double
		  /// Renders this section to `g` with its top-left corner at x, y.
		  /// Returns the location to draw the next section's top-left corner.
		  ///
		  /// Assumes the owning inspector is not Nil.
		  
		  g.SaveState
		  
		  // Cache the top position so we can compute this section's bounds when we're done.
		  Var sectionTop As Double = y
		  
		  // Header background.
		  g.DrawingColor = style.SectionBackColor
		  g.FillRectangle(x, y, g.Width, HEADER_HEIGHT)
		  
		  // Border.
		  g.DrawingColor = style.SectionBorderColor
		  If TargetMacOS And Owner.HasVerticalScrollbar And NSScrollViewCanvas.NSScrollerStyle = NSScrollViewCanvas.NSScrollerStyles.Legacy Then
		    // Don't draw the right border as it looks bad next to the vertical scrollbar on macOS.
		    g.DrawLine(x, y, x + g.Width, y) // Top.
		    g.DrawLine(x, y, x, y + HEADER_HEIGHT) // Left.
		    g.DrawLine(x, y + HEADER_HEIGHT - 1, x + g.Width, y + HEADER_HEIGHT - 1) // Bottom.
		  Else
		    g.DrawRectangle(x, y, g.Width, HEADER_HEIGHT)
		  End If
		  
		  // Section name.
		  g.DrawingColor = style.TextColor
		  g.FontSize = style.FontSize
		  g.FontName = style.FontName
		  Var nameBaseline As Double = sectionTop + (g.FontAscent + (HEADER_HEIGHT - g.TextHeight)/2)
		  g.DrawText(Name, x + HEADER_HPADDING, nameBaseline)
		  
		  // Disclosure widget.
		  If Collapsible Then
		    DisclosureBounds = RenderDisclosureWidget(sectionTop, g, style)
		  Else
		    DisclosureBounds = Nil
		  End If
		  
		  // Update `y` to the bottom of the section header.
		  y = y + HEADER_HEIGHT + HEADER_BOTTOM_PADDING
		  
		  // Draw the items.
		  y = RenderItems(g, x, y, g.Width, style)
		  
		  g.RestoreState
		  
		  // Update the section's bounds.
		  Bounds = New Rect(x, sectionTop, g.Width, y - sectionTop)
		  
		  Return y
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E64657273207468652073656374696F6E20646973636C6F737572652077696467657420746F2060676020696E207468652068656164657220616E642072657475726E73206974732068697420626F756E64732E
		Private Function RenderDisclosureWidget(sectionTop As Double, g As Graphics, style As XUIInspectorStyle) As Rect
		  /// Renders the section disclosure widget to `g` in the header and returns its hit bounds.
		  
		  Var x, y As Double
		  
		  // Compute the vertices.
		  If Expanded Then
		    x = g.Width - DISCLOSURE_RPADDING - XUIInspector.WIDGET_WIDTH_EXPANDED
		    y = sectionTop + HEADER_HEIGHT - DOWN_DISCLOSURE_OFFSET_FROM_BOTTOM - XUIInspector.WIDGET_HEIGHT_EXPANDED
		  Else
		    x = g.Width - DISCLOSURE_RPADDING - XUIInspector.WIDGET_WIDTH_COLLAPSED
		    y = sectionTop + HEADER_HEIGHT - DISCLOSURE_OFFSET_FROM_BOTTOM - XUIInspector.WIDGET_HEIGHT_COLLAPSED
		  End If
		  
		  // Return the rect bounds for this widget.
		  Return XUIInspector.RenderDisclosureWidget(g, x, y, style.SectionDisclosureWidgetColor, Expanded, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320746869732073656374696F6E2773206974656D7320746F206067602E20546865206669727374206974656D277320746F702D6C65667420636F726E657220697320617420782C20792E2052657475726E7320746865207920706F736974696F6E206F662074686520626F74746F6D206F6620746865206C617374206974656D2E
		Function RenderItems(g As Graphics, x As Double, y As Double, width As Double, style As XUIInspectorStyle) As Double
		  /// Renders this section's items to `g`. The first item's top-left corner is at x, y.
		  /// Returns the y position of the bottom of the last item.
		  
		  // There's nothing to do if the section is not expanded.
		  If Not Expanded Then
		    Return y
		  End If
		  
		  For Each item As XUIInspectorItem In mItems
		    y = item.Render(g, x, y, width, style)
		  Next item
		  
		  Return y
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Represents a section in the inspector.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520626F756E6473206F6620746869732073656374696F6E2077697468696E2074686520696E73706563746F722E
		Bounds As Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E20746869732073656374696F6E2063616E20626520657870616E64656420616E6420636F6C6C61707365642E2049662046616C7365207468656E207468652073656374696F6E20697320616C7761797320657870616E6465642E
		#tag Getter
			Get
			  Return mCollapsible
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCollapsible = value
			  
			  // If the section is **not** collapsible then ensure it is expanded.
			  If Not mCollapsible Then mExpanded = True
			  
			End Set
		#tag EndSetter
		Collapsible As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520626F756E6473206F6620746869732073656374696F6E277320646973636C6F737572652077696467657420666F7220657870616E64696E67202F20636F6C6C617073696E67207468652073656374696F6E2E2057696C6C206265204E696C206966207468652073656374696F6E206973206E6F7420636F6C6C61707369626C652E
		DisclosureBounds As Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 57686574686572206F72206E6F7420746869732073656374696F6E20697320657870616E646564206F7220636F6C6C61707365642E
		#tag Getter
			Get
			  Return mExpanded
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Collapsible Then
			    mExpanded = value
			  Else
			    // The section is always expanded.
			    mExpanded = True
			  End If
			  
			  If Owner <> Nil Then Owner.RedrawImmediately
			End Set
		#tag EndSetter
		Expanded As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E20746869732073656374696F6E2063616E20626520657870616E64656420616E6420636F6C6C61707365642E2049662046616C7365207468656E207468652073656374696F6E20697320616C7761797320657870616E6465642E
		Private mCollapsible As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 57686574686572206F72206E6F7420746869732073656374696F6E20697320657870616E646564206F7220636F6C6C61707365642E
		Private mExpanded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206974656D732077697468696E20746869732073656374696F6E2E2054686579206172652072656E646572656420696E20696E646578206F726465722E205468617420697320604974656D73283029602069732072656E64657265642066697273742C2061742074686520746F70206F66207468652073656374696F6E2E
		Private mItems() As XUIInspectorItem
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686174206F776E7320746869732073656374696F6E2E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F6620746869732073656374696F6E2E
		Name As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686174206F776E7320746869732073656374696F6E2E204D6179206265204E696C2E
		#tag Getter
			Get
			  If mOwner = Nil Then
			    Return Nil
			  Else
			    Return XUIInspector(mOwner.Value)
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value = Nil Then
			    mOwner = Nil
			  Else
			    mOwner = New WeakRef(value)
			  End If
			  
			End Set
		#tag EndSetter
		Owner As XUIInspector
	#tag EndComputedProperty


	#tag Constant, Name = DISCLOSURE_OFFSET_FROM_BOTTOM, Type = Double, Dynamic = False, Default = \"8", Scope = Private, Description = 546865206E756D626572206F6620706978656C732074686520626F74746F6D206F662074686520646973636C6F7375726520776964676574206973206F66667365742066726F6D2074686520626F74746F6D2065646765206F66207468652073656374696F6E206865616465722E
	#tag EndConstant

	#tag Constant, Name = DISCLOSURE_RPADDING, Type = Double, Dynamic = False, Default = \"15", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F20706164207468652072696768742065646765206F662074686520646973636C6F73757265207769646765742066726F6D207468652072696768742065646765206F66207468652073656374696F6E2E
	#tag EndConstant

	#tag Constant, Name = DOWN_DISCLOSURE_OFFSET_FROM_BOTTOM, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C732074686520626F74746F6D206F662074686520646F776E20646973636C6F7375726520776964676574206973206F66667365742066726F6D2074686520626F74746F6D2065646765206F66207468652073656374696F6E206865616465722E
	#tag EndConstant

	#tag Constant, Name = HEADER_BOTTOM_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616464206265747765656E2074686520626F74746F6D206F66207468652073656374696F6E2068656164657220616E642074686520746F70206F6620746865206669727374206974656D2E
	#tag EndConstant

	#tag Constant, Name = HEADER_HEIGHT, Type = Double, Dynamic = False, Default = \"26", Scope = Private, Description = 54686520686569676874206F6620612073656374696F6E2773206865616465722E
	#tag EndConstant

	#tag Constant, Name = HEADER_HPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 54686520686F72697A6F6E74616C2070616464696E672077697468696E20612073656374696F6E2773206865616465722E
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
		#tag ViewProperty
			Name="Collapsible"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Expanded"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
