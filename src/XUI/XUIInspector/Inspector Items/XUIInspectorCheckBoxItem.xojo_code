#tag Class
Protected Class XUIInspectorCheckBoxItem
Implements XUIInspectorItem
	#tag Method, Flags = &h0, Description = 54686520626F756E6473206F662074686973206974656D2077697468696E2074686520696E73706563746F722E
		Function Bounds() As Rect
		  /// The bounds of this item within the inspector.
		  
		  Return mBounds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520626F756E6473206F662074686973206974656D20696E2074686520696E73706563746F722E
		Sub Bounds(Assigns b As Rect)
		  /// Sets the bounds of this item in the inspector.
		  
		  mBounds = b
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320547275652069662074686973206974656D2069732061626C6520746F206163636570742074686520666F637573207669612074686520746162206B65792E
		Function CanAcceptTab() As Boolean
		  /// Returns True if this item is able to accept the focus via the tab key.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E657720636865636B626F78206974656D2E206063617074696F6E576964746860206973207468652064657369726564207769647468206F66207468652063617074696F6E20616E64206076616C7565602069732074686520696E697469616C20636865636B626F782073746174652E
		Sub Constructor(ID As String, caption As String, captionWidth As Integer, value As Boolean)
		  /// Constructs a new checkbox item. `captionWidth` is the desired width of the caption and `value` is the initial checkbox state.
		  
		  mID = ID
		  Self.Caption = caption
		  Self.CaptionWidth = captionWidth
		  mValue = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4172626974726172792064617461206173736F63696174656420776974682074686973206974656D2E
		Function Data() As Variant
		  /// Arbitrary data associated with this item. 
		  
		  Return mData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4172626974726172792064617461206173736F63696174656420776974682074686973206974656D2E
		Sub Data(Assigns v As Variant)
		  /// Arbitrary data associated with this item.
		  
		  mData = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686973206974656D20686173206A7573742072656365697665642074686520666F63757320766961207468652073686966742D746162206B657920636F6D626F202874686520226261636B2074616222292E
		Sub DidReceiveBackTab()
		  /// This item has just received the focus via the shift-tab key combo (the "back tab").
		  ///
		  /// Part of the `XUIInspectorItem` interface.
		  
		  // Nothing to do since this item can't accept the focus via the back-tab key combo. 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686973206974656D20686173206A7573742072656365697665642074686520666F637573207669612074686520746162206B65792E
		Sub DidReceiveTabFocus()
		  /// This item has just received the focus via the tab key.
		  
		  // Nothing to do since this item can't accept the focus via the tab key.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44726177732074686520636865636B626F7820746F207468652070617373656420677261706869637320636F6E746578742061742074686520707265636F6D707574656420782C207920706F736974696F6E2E
		Private Sub DrawCheckbox(g As Graphics, x As Double, y As Double, style As XUIInspectorStyle)
		  /// Draws the checkbox to the passed graphics context at the precomputed x, y position.
		  
		  g.SaveState
		  
		  // Draw the box.
		  g.DrawingColor = style.ControlBackgroundColor
		  g.FillRoundRectangle(x, y, CHECKBOX_SIZE, CHECKBOX_SIZE, 2, 2)
		  g.DrawingColor = style.ControlBorderColor
		  g.PenSize = 1
		  g.DrawRoundRectangle(x, y, CHECKBOX_SIZE, CHECKBOX_SIZE, 2, 2)
		  
		  // If needed, draw the tick.
		  If Value Then
		    g.DrawingColor = style.AccentColor
		    g.FontSize = CHECKBOX_SIZE * 0.8
		    g.Bold = True
		    Var tickX As Double = x + (CHECKBOX_SIZE / 2) - (g.TextWidth("✓") / 2)
		    Var tickY As Double = (y + g.FontAscent + (CHECKBOX_SIZE - g.TextHeight)/2)
		    g.DrawText("✓", tickX, tickY)
		  End If
		  
		  // Update the hit bounds of the checkbox.
		  mCheckboxBounds = New Rect(x, y, CHECKBOX_SIZE, CHECKBOX_SIZE)
		  
		  g.RestoreState
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720636865636B626F78206974656D2066726F6D206120544F4D4C20737472696E672E
		Function FromTOML(toml As String) As XUIInspectorCheckBoxItem
		  /// Returns a new checkbox item from a TOML string.
		  
		  Var d As Dictionary = TOMLKit.ParseTOML(toml)
		  
		  Try
		    Var caption As String = d.Value("caption")
		    Var captionWidth As Integer = d.Value("captionWidth")
		    Var value As Boolean = d.Value("value")
		    Var id As String = d.Value("id")
		    Return New XUIInspectorCheckBoxItem(id, caption, captionWidth, value)
		  Catch KeyNotFoundException
		    Raise New InvalidArgumentException("Cannot create new checkbox item. Invalid TOML.")
		  End Try
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520686569676874206F662074686973206974656D20676976656E207468652064657369726564207374796C652E
		Function Height(style As XUIInspectorStyle) As Double
		  /// The height of this item given the desired style.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Return Max(style.FontSize + (2 * VPADDING), CHECKBOX_SIZE + (2 * VPADDING))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5573656420746F206964656E746966792074686973206974656D20696E206E6F74696669636174696F6E732E20596F752073686F756C6420656E7375726520697420697320756E697175652077697468696E2074686520696E73706563746F722E
		Function ID() As String
		  /// Used to identify this item in notifications. You should ensure it is unique within the inspector.
		  
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

	#tag Method, Flags = &h0, Description = 54656C6C7320746865206974656D20746861742061206D6F75736520646F776E206576656E7420686173206F636375727265642077697468696E2069747320626F756E64732E20782C20792061726520746865206162736F6C75746520636F6F7264696E617465732072656C617469766520746F2074686520696E73706563746F72202861646A757374656420666F72207363726F6C6C696E67292E2052657475726E732061204D6F757365446F776E4461746120696E7374616E636520696E737472756374696E672074686520696E73706563746F7220686F7720746F2068616E646C6520746865206576656E74206F72204E696C2069662074686520636C69636B206469646E27742068617070656E20696E2074686973206974656D2E
		Function MouseDown(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseDownData
		  /// Tells the item that a mouse down event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseDownData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't happen in this item.
		  
		  // This item only responds to single clicks.
		  If clickType <> XUI.ClickTypes.SingleClick Then Return Nil
		  
		  If mCheckboxBounds <> Nil And mCheckboxBounds.Contains(x, y) Then
		    // Toggle the checkbox value.
		    Value = Not Value
		    
		    // Notify a change occurred.
		    XUINotificationCenter.Send(Self, XUIInspector.NOTIFICATION_ITEM_CHANGED, Value)
		    
		    // The the inspector a visual change has occurred.
		    Return New XUIInspectorMouseDownData
		  End If
		  
		  // The click didn't occur in this item.
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5573656420746F2074656C6C2074686973206974656D207468617420746865206D6F75736520686173206A757374206578697465642069742E2052657475726E7320547275652069662074686520696E73706563746F722073686F756C64207265647261772E
		Function MouseExit() As Boolean
		  /// Used to tell this item that the mouse has just exited it.
		  /// Returns True if the inspector should redraw.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  // There is nothing to do since there are no visual effects caused by mouse movement in the checkbox item.
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
		  
		  // Moving the over the checkbox item does nothing so we'll just return Nil.
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C7320746865206974656D20746861742061206D6F757365207570206576656E7420686173206F636375727265642077697468696E2069747320626F756E64732E20782C20792061726520746865206162736F6C75746520636F6F7264696E617465732072656C617469766520746F2074686520696E73706563746F72202861646A757374656420666F72207363726F6C6C696E67292E2052657475726E732061204D6F75736555704461746120696E7374616E636520696E737472756374696E672074686520696E73706563746F7220686F7720746F2068616E646C6520746865206576656E74206F72204E696C2069662074686520636C69636B206469646E27742068617070656E20696E2074686973206974656D2E
		Function MouseUp(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseUpData
		  /// Tells the item that a mouse up event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseUpData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't happen in this item.
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  // This item only responds to single clicks.
		  If clickType <> XUI.ClickTypes.SingleClick Then Return Nil
		  
		  // We toggle the checkbox value on mouse down so there's nothing to do here.
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686973206974656D2062656C6F6E677320746F2E
		Function Owner() As XUIInspector
		  /// A weak reference to the inspector this item belongs to.
		  
		  If Section = Nil Then
		    Return Nil
		  Else
		    Return Section.Owner
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C732074686973206974656D207468617420616E7920706F707570206974207468696E6B732069742068617320646973706C6179656420686173206265656E206469736D69737365642077697468206E6F20616374696F6E2E
		Sub PopupDismissed()
		  /// Tells this item that any popup it thinks it has displayed has been dismissed with no action.
		  ///
		  /// Part of the `XUIInspectorItem` interface.
		  
		  // Since the checkbox item doesn't display a popup menu, there's nothing to do.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520656E7472792061742060696E6465786020686173206265656E2073656C656374656420696E2074686973206974656D277320706F707570206D656E752E
		Sub PopupItemSelected(index As Integer)
		  /// The entry at `index` has been selected in this item's popup menu.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  // Since the checkbox item doesn't display a popup, there's nothing to do.
		  #Pragma Unused index
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206974656D2073686F756C642072656E64657220697473656C6620746F207468652070617373656420677261706869637320636F6E746578742061742074686520737065636966696564206C6F636174696F6E2E2052657475726E732074686520706F736974696F6E206F6620746865206974656D277320626F74746F6D20656467652E
		Function Render(g As Graphics, x As Double, y As Double, width As Double, style As XUIInspectorStyle) As Double
		  /// The item should render itself to the passed graphics context at the specified location. Returns the position of the item's bottom edge.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  ///
		  /// ```nohighlight
		  /// |------------------|
		  /// | CAPTION       [] |
		  /// |------------------|
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
		  g.DrawText(Caption, x + HPADDING + Max((CaptionWidth - g.TextWidth(Caption)), 0), captionBaseline, CaptionWidth, True)
		  
		  // Draw the checkbox.
		  DrawCheckbox(g, x + HPADDING + CaptionWidth + XUIInspector.CAPTION_CONTROL_PADDING, y + (h/2) - (CHECKBOX_SIZE / 2), style)
		  
		  g.RestoreState
		  
		  // Update the item's bounds.
		  mBounds = New Rect(x, y, width, h)
		  
		  Return y + h
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41207765616B207265666572656E636520746F207468652073656374696F6E2074686973206974656D20697320696E2E
		Function Section() As XUIInspectorSection
		  /// A weak reference to the section this item is in.
		  
		  If mSection = Nil Or mSection.Value = Nil Then
		    Return Nil
		  Else
		    Return XUIInspectorSection(mSection.Value)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652073656374696F6E2074686973206974656D2069732077697468696E20746F2E2041207765616B207265666572656E63652077696C6C20626520637265617465642E
		Sub Section(Assigns section As XUIInspectorSection)
		  /// The section this item is within to. A weak reference will be created.
		  
		  If section = Nil Then
		    mSection = Nil
		  Else
		    mSection = New WeakRef(section)
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Used to display a checkbox with a caption in the inspector.
		
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

	#tag Property, Flags = &h0, Description = 546865207769647468207468652063617074696F6E2073686F756C6420626520636F6E73747261696E656420746F2E
		CaptionWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F662074686973206974656D2E
		Private mBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063617074696F6E20746F20646973706C617920626573696465732074686520636865636B626F782E
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F662074686520636865636B626F782E205573656420666F72206869742D74657374696E672E
		Private mCheckboxBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4172626974726172792064617461206173736F63696174656420776974682074686973206974656D2E
		Private mData As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5573656420746F206964656E746966792074686973206974656D20696E206E6F74696669636174696F6E732E20596F752073686F756C6420656E7375726520697420697320756E697175652077697468696E2074686520696E73706563746F722E
		Private mID As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722073656374696F6E2074686973206974656D2069732077697468696E2E204D6179206265204E696C2E
		Private mSection As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636865636B626F782076616C75652E2054727565203D20636865636B65642C2046616C7365203D20756E636865636B65642E
		Private mValue As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636865636B626F782076616C75652E2054727565203D20636865636B65642C2046616C7365203D20756E636865636B65642E
		#tag Getter
			Get
			  Return mValue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mValue = value
			End Set
		#tag EndSetter
		Value As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = CHECKBOX_SIZE, Type = Double, Dynamic = False, Default = \"18", Scope = Private, Description = 5468652073697A65206F662074686520636865636B626F78207371756172652E
	#tag EndConstant

	#tag Constant, Name = HPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206974656D277320636F6E74656E74206C65667420616E642072696768742E
	#tag EndConstant

	#tag Constant, Name = VPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206974656D277320636F6E74656E742061626F766520616E642062656C6F772E
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
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
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
