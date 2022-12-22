#tag Class
Protected Class XUIInspectorPopupItem
Implements XUIInspectorItem
	#tag Method, Flags = &h0, Description = 54686520626F756E6473206F662074686973206974656D2077697468696E2074686520696E73706563746F722E
		Function Bounds() As Rect
		  /// The bounds of this item within the inspector.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Return mBounds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520626F756E6473206F662074686973206974656D20696E2074686520696E73706563746F722E
		Sub Bounds(Assigns b As Rect)
		  /// Sets the bounds of this item in the inspector.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  mBounds = b
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320547275652069662074686973206974656D2069732061626C6520746F206163636570742074686520666F637573207669612074686520746162206B65792E
		Function CanAcceptTabFocus() As Boolean
		  /// Returns True if this item is able to accept the focus via the tab key.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E6577206974656D20636F6E7461696E696E67206120706F707570206D656E7520616E6420612063617074696F6E2E20606974656D73282960206172652074686520706F707570206D656E75206974656D732E
		Sub Constructor(ID As String, caption As String, captionWidth As Integer, items() As String)
		  /// Constructs a new item containing a popup menu and a caption.
		  /// `items()` are the popup menu items.
		  
		  mID = ID
		  Self.Caption = caption
		  Self.CaptionWidth = captionWidth
		  mItems = items
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064617461206E65656465642062792074686520696E73706563746F7220746F20637265617465206120706F707570206D656E7520616E63686F72656420746F20746865207269676874206F662074686973206974656D2C206C696E65642075702077697468207468652065646765206F662074686520636C6F73656420706F70757020626F782E
		Private Function CreatePopupMenu() As XUIInspectorItemPopupMenu
		  /// Returns the data needed by the inspector to create a popup menu anchored to the right of this item, 
		  /// lined up with the edge of the closed popup box.
		  
		  Return New XUIInspectorItemPopupMenu(Self, mItems, mSelectedIndex, mClosedPopupRightEdge, _
		  XUIInspectorItemPopupMenu.Anchors.Right, _
		  mClosedPopupBottomEdge, mClosedPopupTopEdge)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686973206974656D20686173206A7573742072656365697665642074686520666F637573207669612074686520746162206B65792E
		Sub DidReceiveTabFocus()
		  /// This item has just received the focus via the tab key.
		  
		  // Nothing to do since this item can't accept the focus via the tab key.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44726177732074686520706F70757020626F7820746F2074686520636F6E74657874206067602E
		Private Sub DrawPopupBox(x As Double, y As Double, g As Graphics, style As XUIInspectorStyle)
		  /// Draws the popup box to the context `g`.
		  ///
		  /// x: The left border of the popup menu.
		  /// y: The top of the item bounds.
		  
		  g.SaveState
		  
		  Var popupH As Double = style.FontSize + (2 * POPUP_INTERNAL_VPADDING)
		  
		  // Background.
		  g.DrawingColor = style.ControlBackgroundColor
		  g.FillRectangle(x, y, mPopupWidth, popupH)
		  
		  // Set the bounds of the popup to the entire box.
		  mPopupBounds = New Rect(x, y, mPopupWidth, popupH)
		  
		  // Selected item.
		  g.DrawingColor = If(mOpen, style.FocusColor, style.TextColor)
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  Var itemBaseline As Double = (g.FontAscent + (popupH - g.TextHeight) / 2 + y)
		  Var selectedItem As String = mItems(mSelectedIndex)
		  g.DrawText(selectedItem, x + POPUP_CONTENTS_HPADDING, itemBaseline, mPopupWidth - HPADDING - WIDGET_WIDTH - WIDGET_RPADDING, True)
		  
		  // Border.
		  g.DrawingColor = style.ControlBorderColor
		  g.PenSize = 1
		  g.DrawRectangle(x, y, mPopupWidth, popupH)
		  
		  // Draw the disclosure.
		  x = x + mPopupWidth - WIDGET_WIDTH - WIDGET_RPADDING
		  y = y + (popupH / 2) - (XUIInspector.WIDGET_HEIGHT_EXPANDED / 2)
		  Call XUIInspector.RenderDisclosureWidget(g, x, y, If(mOpen, style.FocusColor, style.ItemDisclosureWidgetColor), True, False)
		  
		  g.RestoreState
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520686569676874206F662074686973206974656D20676976656E207468652064657369726564207374796C652E
		Function Height(style As XUIInspectorStyle) As Double
		  /// The height of this item given the desired style.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Return style.FontSize + (2 * VPADDING) + (2 * POPUP_INTERNAL_VPADDING)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5573656420746F206964656E746966792074686973206974656D20696E206E6F74696669636174696F6E732E20596F752073686F756C6420656E7375726520697420697320756E697175652077697468696E2074686520696E73706563746F722E
		Function ID() As String
		  /// Used to identify this item in notifications. You should ensure it is unique within the inspector.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Return mID
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686973206974656D206A757374206C6F73742074686520666F6375732E
		Sub LostFocus()
		  /// This item just lost the focus.
		  ///
		  /// Part of the `XUIInspectorItem` interface.
		  
		  // There is nothing to do for this type of item.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C7320746865206974656D20746861742061206D6F75736520646F776E206576656E7420686173206F636375727265642077697468696E2069747320626F756E64732E20782C20792061726520746865206162736F6C75746520636F6F7264696E617465732072656C617469766520746F2074686520696E73706563746F72202861646A757374656420666F72207363726F6C6C696E67292E2052657475726E732061204D6F757365446F776E4461746120696E7374616E636520696E737472756374696E672074686520696E73706563746F7220686F7720746F2068616E646C6520746865206576656E74206F72204E696C2069662074686520636C69636B206469646E2774206F6363757220696E2074686973206974656D2E
		Function MouseDown(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseDownData
		  /// Tells the item that a mouse down event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseDownData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't occur in this item.
		  ///
		  /// Note: A click in this item when it has a popup menu displayed will be handled in `PopupItemSelected`()`.
		  
		  // This item only responds to single clicks.
		  If clickType <> XUI.ClickTypes.SingleClick Then Return Nil
		  
		  // Did the click happen within the closed popup box bounds?
		  If mPopupBounds.Contains(x, y) Then
		    mOpen = Not mOpen
		    
		    If mOpen Then
		      // Pass the data required to create a popup menu back to the inspector and
		      // indicate a visual change has occurred.
		      Return New XUIInspectorMouseDownData(CreatePopupMenu)
		    Else
		      Return New XUIInspectorMouseDownData
		    End If
		  End If
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5573656420746F2074656C6C2074686973206974656D207468617420746865206D6F75736520686173206A757374206578697465642069742E2052657475726E7320547275652069662074686520696E73706563746F722073686F756C64207265647261772E
		Function MouseExit() As Boolean
		  /// Used to tell this item that the mouse has just exited it.
		  /// Returns True if the inspector should redraw.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  // There is nothing to do since there are no visual effects caused by mouse movement in the popup item.
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206D6F75736520686173206A757374206D6F766564206F7665722074686973206974656D2E2052657475726E73206461746120746F20696E666F726D2074686520696E73706563746F7220686F7720746F2068616E646C6520746865206D6F76656D656E742E204D61792072657475726E204E696C2E
		Function MouseMoved(x As Double, y As Double) As XUIInspectorMouseMoveData
		  /// The mouse has just moved over this item. Returns data to inform the inspector how to handle the movement.
		  /// May return Nil.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  // Moving the over the popup item does nothing so we'll just return Nil.
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C7320746865206974656D20746861742061206D6F757365207570206576656E7420686173206F636375727265642077697468696E2069747320626F756E64732E20782C20792061726520746865206162736F6C75746520636F6F7264696E617465732072656C617469766520746F2074686520696E73706563746F72202861646A757374656420666F72207363726F6C6C696E67292E2052657475726E732061204D6F75736555704461746120696E7374616E636520696E737472756374696E672074686520696E73706563746F7220686F7720746F2068616E646C6520746865206576656E74206F72204E696C2069662074686520636C69636B206469646E2774206F6363757220696E2074686973206974656D2E
		Function MouseUp(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseUpData
		  /// Tells the item that a mouse up event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseUpData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't occur in this item.
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  #Pragma Unused clickType
		  
		  // We handle displaying the popup menu in the MouseDown event so there's nothing to do here
		  Return Nil
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686973206974656D2062656C6F6E677320746F2E
		Function Owner() As XUIInspector
		  /// A weak reference to the inspector this item belongs to.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  If mOwner = Nil Or mOwner.Value = Nil Then
		    Return Nil
		  Else
		    Return XUIInspector(mOwner.Value)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520696E73706563746F722074686973206974656D2062656C6F6E677320746F2E2041207765616B207265666572656E63652077696C6C20626520637265617465642E
		Sub Owner(Assigns inspector As XUIInspector)
		  /// The inspector this item belongs to. A weak reference will be created.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  If inspector = Nil Then
		    mOwner = Nil
		  Else
		    mOwner = New WeakRef(inspector)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C732074686973206974656D207468617420616E7920706F707570206974207468696E6B732069742068617320646973706C6179656420686173206265656E206469736D69737365642077697468206E6F20616374696F6E2E
		Sub PopupDismissed()
		  /// Tells this item that any popup it thinks it has displayed has been dismissed with no action.
		  ///
		  /// Part of the `XUIInspectorItem` interface.
		  
		  // Ensure we internally record this.
		  mOpen = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520656E7472792061742060696E6465786020686173206265656E2073656C656374656420696E2074686973206974656D277320706F707570206D656E752E
		Sub PopupItemSelected(index As Integer)
		  /// The entry at `index` has been selected in this item's popup menu.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  // Update the currently selected item.
		  If index >= 0 And index <= mItems.LastIndex Then
		    mSelectedIndex = index
		    // Notify a change occurred passing in the new value.
		    XUINotificationCenter.Send(Self, XUIInspector.NOTIFICATION_ITEM_CHANGED, mItems(index))
		  Else
		    mSelectedIndex = -1
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206974656D2073686F756C642072656E64657220697473656C6620746F207468652070617373656420677261706869637320636F6E746578742061742074686520737065636966696564206C6F636174696F6E2E2052657475726E732074686520706F736974696F6E206F6620746865206974656D277320626F74746F6D20656467652E
		Function Render(g As Graphics, x As Double, y As Double, width As Double, style As XUIInspectorStyle) As Double
		  /// The item should render itself to the passed graphics context at the specified location.
		  /// Returns the position of the item's bottom edge.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  ///
		  /// ```nohighlight
		  /// |-------------------------|
		  /// | CAPTION      [ OPTION ] |
		  /// |-------------------------|
		  /// ```
		  
		  g.SaveState
		  
		  // Cache this item's height.
		  Var h As Double = Height(style)
		  
		  // Draw this item's background.
		  g.DrawingColor = style.BackgroundColor
		  g.FillRectangle(x, y, width, h)
		  
		  // Set the font family and size.
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  
		  // Compute the baseline for the caption.
		  Var captionBaseline As Double = (g.FontAscent + (h - g.TextHeight)/2 + y)
		  
		  // Draw the right-aligned caption in the vertical centre of the item.
		  g.DrawingColor = style.TextColor
		  Var captionLeftX As Double = x + HPADDING + Max((CaptionWidth - g.TextWidth(Caption)), 0)
		  g.DrawText(Caption, captionLeftX, captionBaseline, CaptionWidth, True)
		  Var captionRightX As Double = x + HPADDING + CaptionWidth
		  
		  // Compute the width of the popup menu if needed.
		  If mPopupWidth = 0 Then
		    mPopupWidth = width - XUIInspector.CONTROL_BORDER_PADDING - captionRightX - XUIInspector.CAPTION_CONTROL_PADDING
		  End If
		  
		  // Regardless of whether the popup menu is open or closed, we always draw the closed popup box.
		  DrawPopupBox(x + width - mPopupWidth - XUIInspector.CONTROL_BORDER_PADDING, y + VPADDING, g, style)
		  
		  g.RestoreState
		  
		  // Cache the edges of the closed popup box as this is needed to draw the open popup menu.
		  mClosedPopupRightEdge = x + width - XUIInspector.CAPTION_CONTROL_PADDING
		  mClosedPopupTopEdge = y
		  mClosedPopupBottomEdge = y + h
		  
		  // Update the item's bounds.
		  mBounds = New Rect(x, y, width, h)
		  
		  Return y + h
		End Function
	#tag EndMethod


	#tag Note, Name = About
		An item containing a popup menu and caption.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 5468652063617074696F6E20746F20646973706C617920626573696465732074686520636865636B626F782E
		#tag Getter
			Get
			  Return mCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCaption = value
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652064657369726564207769647468206F66207468652063617074696F6E2E
		CaptionWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F662074686973206974656D2E
		Private mBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063617074696F6E20746F20646973706C617920626573696465732074686520636865636B626F782E
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436163686564205920706F736974696F6E206F662074686520626F74746F6D2065646765206F662074686520636C6F73656420706F70757020626F782E20526571756972656420746F206472617720746865206F70656E20706F70757020626F782E205468697320697320636F6D707574656420696E206052656E6465722829602E
		Private mClosedPopupBottomEdge As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436163686564205820706F736974696F6E206F66207468652072696768742065646765206F662074686520636C6F73656420706F70757020626F782E20526571756972656420746F206472617720746865206F70656E20706F70757020626F782E205468697320697320636F6D707574656420696E206052656E6465722829602E
		Private mClosedPopupRightEdge As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436163686564205920706F736974696F6E206F662074686520746F702065646765206F662074686520636C6F73656420706F70757020626F782E20526571756972656420746F206472617720746865206F70656E20706F70757020626F782E205468697320697320636F6D707574656420696E206052656E6465722829602E
		Private mClosedPopupTopEdge As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5573656420746F206964656E746966792074686973206974656D20696E206E6F74696669636174696F6E732E20596F752073686F756C6420656E7375726520697420697320756E697175652077697468696E2074686520696E73706563746F722E
		Private mID As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206974656D7320696E2074686520706F7075702E
		Private mItems() As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520706F7075702069732063757272656E746C79206F70656E2E
		Private mOpen As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686973206974656D2062656C6F6E677320746F2E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652068697420626F756E647320666F722074686520706F7075702E
		Private mPopupBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C61737420636F6D7075746564207769647468206F662074686520706F707570206D656E75202863616368656420696E2060506F7075705769647468282960292E
		Private mPopupWidth As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E646578206F6620746865206974656D20696E20606D4974656D736020746861742069732063757272656E746C792073656C65637465642E
		Private mSelectedIndex As Integer = 0
	#tag EndProperty


	#tag Constant, Name = HPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206974656D277320636F6E74656E74206C65667420616E642072696768742E
	#tag EndConstant

	#tag Constant, Name = ITEM_WIDGET_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C73206265747765656E2074686520706F707570206974656D207465787420616E6420746865206C6566742D65646765206F6620746865206172726F77207769646765742E
	#tag EndConstant

	#tag Constant, Name = ITEM_WIDGET_WIDTH, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 546865207769647468206F6620746865206172726F77207769646765742E
	#tag EndConstant

	#tag Constant, Name = POPUP_CONTENTS_HPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F20706164206569746865722073696465206F662065616368206974656D20696E2074686520706F707570206D656E752E
	#tag EndConstant

	#tag Constant, Name = POPUP_INTERNAL_VPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520636F6E74656E7473206F662074686520706F70757020626F782061626F766520616E642062656C6F772E
	#tag EndConstant

	#tag Constant, Name = VPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206974656D277320636F6E74656E742061626F766520616E642062656C6F772E
	#tag EndConstant

	#tag Constant, Name = WIDGET_HEIGHT, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 54686520686569676874206F662074686520646F776E776172647320666163696E6720646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = WIDGET_RPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F20706164207468652072696768742065646765206F662074686520646973636C6F73757265207769646765742066726F6D207468652072696768742065646765206F662074686520706F707570206D656E752E
	#tag EndConstant

	#tag Constant, Name = WIDGET_WIDTH, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865207769647468206F662074686520646F776E776172647320666163696E6720646973636C6F73757265207769646765742E
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
			Name="Caption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaptionWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
