#tag Class
Protected Class XUIInspectorFullWidthButtonItem
Implements XUIInspectorItem
	#tag Method, Flags = &h0
		Function Bounds() As Rect
		  /// The bounds of this item within the inspector.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Return mBounds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Bounds(Assigns b As Rect)
		  /// Sets the bounds of this item in the inspector.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  mBounds = b
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320547275652069662074686973206974656D2069732061626C6520746F206163636570742074686520666F637573207669612074686520746162206B65792E
		Function CanAcceptTab() As Boolean
		  /// Returns True if this item is able to accept the focus via the tab key.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E6577206974656D20636F6E7461696E696E6720612066756C6C20776964746820627574746F6E2E
		Sub Constructor(id As String, buttonCaption As String)
		  /// Constructs a new item containing a full width button.
		  
		  mID = id
		  Self.Caption = buttonCaption
		  
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

	#tag Method, Flags = &h0, Description = 54686520686569676874206F662074686973206974656D20676976656E207468652064657369726564207374796C652E
		Function Height(style As XUIInspectorStyle) As Double
		  /// The height of this item given the desired style.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Return Max(style.FontSize + (2 * VPADDING), BUTTON_HEIGHT + (2 * VPADDING))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
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
		  
		  mMouseIsOver = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MouseDown(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseDownData
		  /// Tells the item that a mouse down event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseDownData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't happen in this item.
		  
		  // This item only responds to single clicks.
		  If clickType <> XUI.ClickTypes.SingleClick Then Return Nil
		  
		  If mButtonBounds <> Nil And mButtonBounds.Contains(x, y) Then
		    // The mouse must be over the button if it's clicked it.
		    mMouseIsOver = True
		    
		    // The the inspector a visual change has occurred.
		    Return New XUIInspectorMouseDownData
		  End If
		  
		  // The click didn't occur in this item.
		  mMouseIsOver = False
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5573656420746F2074656C6C2074686973206974656D207468617420746865206D6F75736520686173206A757374206578697465642069742E2052657475726E7320547275652069662074686520696E73706563746F722073686F756C64207265647261772E
		Function MouseExit() As Boolean
		  /// Used to tell this item that the mouse has just exited it.
		  /// Returns True if the inspector should redraw.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  If mMouseIsOver Then
		    // The mouse was over this item and has now left. We should redraw.
		    mMouseIsOver = False
		    Return True
		  Else
		    // The mouse was never over this item anyway so nothing to do.
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206D6F75736520686173206A757374206D6F766564206F7665722074686973206974656D2E2052657475726E73206461746120746F20696E666F726D2074686520696E73706563746F7220686F7720746F2068616E646C6520746865206D6F76656D656E742E204D61792072657475726E204E696C2E
		Function MouseMoved(x As Double, y As Double) As XUIInspectorMouseMoveData
		  /// The mouse has just moved over this item. Returns data to inform the inspector how to handle the movement.
		  /// May return Nil.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Var mouseWasOver As Boolean = mMouseIsOver
		  mMouseIsOver = mButtonBounds.Contains(x, y)
		  
		  Return New XUIInspectorMouseMoveData(Self, mMouseIsOver <> mouseWasOver)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C7320746865206974656D20746861742061206D6F757365207570206576656E7420686173206F636375727265642077697468696E2069747320626F756E64732E20782C20792061726520746865206162736F6C75746520636F6F7264696E617465732072656C617469766520746F2074686520696E73706563746F72202861646A757374656420666F72207363726F6C6C696E67292E2052657475726E732061204D6F75736555704461746120696E7374616E636520696E737472756374696E672074686520696E73706563746F7220686F7720746F2068616E646C6520746865206576656E74206F72204E696C2069662074686520636C69636B206469646E27742068617070656E20696E2074686973206974656D2E
		Function MouseUp(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseUpData
		  /// Tells the item that a mouse up event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseUpData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't happen in this item.
		  
		  // This item only responds to single clicks.
		  If clickType <> XUI.ClickTypes.SingleClick Then Return Nil
		  
		  If mButtonBounds <> Nil And mButtonBounds.Contains(x, y) Then
		    // The mouse must be over the button if it's clicked it.
		    mMouseIsOver = True
		    
		    // Notify a change occurred. Note we do this on mouse up not mouse down.
		    XUINotificationCenter.Send(Self, XUIInspector.NOTIFICATION_ITEM_CHANGED, Nil)
		    
		    // The the inspector a visual change has occurred.
		    Return New XUIInspectorMouseUpData(True)
		  End If
		  
		  // The click didn't occur in this item.
		  mMouseIsOver = False
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

	#tag Method, Flags = &h0
		Sub PopupDismissed()
		  /// Tells this item that any popup it thinks it has displayed has been dismissed with no action.
		  ///
		  /// Part of the `XUIInspectorItem` interface.
		  
		  // The button item doesn't utilise popups so there's nothing to do.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520656E7472792061742060696E6465786020686173206265656E2073656C656374656420696E2074686973206974656D277320706F707570206D656E752E
		Sub PopupItemSelected(index As Integer)
		  /// The entry at `index` has been selected in this item's popup menu.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  // The button item doesn't utilise popups so there's nothing to do.
		  #Pragma Unused index
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Render(g As Graphics, x As Double, y As Double, width As Double, style As XUIInspectorStyle) As Double
		  /// The item should render itself to the passed graphics context at the specified location.
		  /// Returns the position of the item's bottom edge.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  g.SaveState
		  
		  // Cache this item's height.
		  Var h As Double = Height(style)
		  
		  // Draw the button.
		  g.DrawingColor = If(mMouseIsOver, style.AccentColor, style.ControlBackgroundColor)
		  Var buttonX As Double = x + HPADDING
		  Var buttonY As Double = y + VPADDING
		  Var buttonW As Double = width - (2 * HPADDING)
		  Var buttonH As Double = h - (2 * VPADDING)
		  g.FillRectangle(buttonX, buttonY, buttonW, buttonH)
		  g.DrawingColor = style.ControlBorderColor
		  g.DrawRectangle(buttonX, buttonY, buttonW, buttonH)
		  
		  // Update the button's bounds.
		  mButtonBounds = New Rect(buttonX, buttonY, buttonW, buttonH)
		  
		  // Set the font family and size.
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  
		  // Compute the available width for the caption.
		  Var captionW As Double = width - (2 * HPADDING) - BUTTON_HEIGHT
		  
		  // Compute the baseline for the caption.
		  Var captionBaseline As Double = (g.FontAscent + (h - g.TextHeight)/2 + y)
		  
		  // Draw the caption in the centre of the item.
		  g.DrawingColor = style.TextColor
		  g.DrawText(Caption, mButtonBounds.Center.X - (g.TextWidth(Caption) / 2), captionBaseline, captionW, True)
		  
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
		Used to display a full width button in the inspector.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 5468652063617074696F6E20746F20646973706C617920696E2074686520627574746F6E2E
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

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F662074686973206974656D2E
		Private mBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F662074686520627574746F6E2E20436F6D707574656420696E206052656E6465722829602E
		Private mButtonBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063617074696F6E20746F20646973706C617920696E2074686520627574746F6E2E
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4172626974726172792064617461206173736F63696174656420776974682074686973206974656D2E
		Private mData As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5573656420746F206964656E746966792074686973206974656D20696E206E6F74696669636174696F6E732E20596F752073686F756C6420656E7375726520697420697320756E697175652077697468696E2074686520696E73706563746F722E
		Private mID As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206D6F757365206973206F7665722074686520627574746F6E2E
		Private mMouseIsOver As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722073656374696F6E2074686973206974656D2069732077697468696E2E204D6179206265204E696C2E
		Private mSection As WeakRef
	#tag EndProperty


	#tag Constant, Name = BUTTON_HEIGHT, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 54686520686569676874206F662074686520627574746F6E2E
	#tag EndConstant

	#tag Constant, Name = HPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520627574746F6E20746F20746865206C65667420616E642072696768742E
	#tag EndConstant

	#tag Constant, Name = VPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520627574746F6E2061626F766520616E642062656C6F772E
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
	#tag EndViewBehavior
End Class
#tag EndClass
