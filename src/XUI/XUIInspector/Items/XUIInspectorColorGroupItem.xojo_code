#tag Class
Protected Class XUIInspectorColorGroupItem
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

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E6577206974656D20636F6E7461696E696E67206120636F6C6F7572207377617463682077686963682063616E20626520616C746572656420627920636C69636B696E672069742E206076616C7565602069732074686520696E697469616C20436F6C6F7247726F75702E
		Sub Constructor(ID As String, caption As String, captionWidth As Integer, value As ColorGroup)
		  /// Constructs a new item containing a colour swatch which can be altered by clicking it. 
		  /// `value` is the initial ColorGroup.
		  
		  mID = ID
		  Self.Caption = caption
		  Self.CaptionWidth = captionWidth
		  mValue = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320547275652069662074686973206974656D206861732068616E646C6564206265696E672074616262656420746F206F722046616C73652069662074686973206974656D20646F6573206E6F74206163636570742074686520666F637573207669612074686520746162206B65792E
		Function DidReceiveTabFocus() As Boolean
		  /// Returns True if this item has handled being tabbed to or False if this item does not accept the focus via the tab key.
		  
		  // This item does not accept the focus via the tab key.
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4472617773207468652074776F20636F6C6F757220737761746368657320746F207468652070617373656420677261706869637320636F6E746578742061742074686520707265636F6D707574656420706F736974696F6E206F662077696474682060776020616E64206865696768742060686020616E64207570646174657320746865697220626F756E64732E
		Private Sub DrawColorSwatches(g As Graphics, lightSwatchX As Double, y As Double, style As XUIInspectorStyle, w As Double, h As Double)
		  /// Draws the two colour swatches to the passed graphics context at the precomputed position 
		  /// of width `w` and height `h` and updates their bounds.
		  ///
		  /// `lightSwatchX` is the start X coordinate of the light swatch.
		  
		  #Pragma Unused style
		  
		  g.SaveState
		  
		  // Light value.
		  g.DrawingColor = mValue.Light
		  g.FillRectangle(lightSwatchX, y, w, h)
		  
		  // Light value border.
		  g.DrawingColor = Color.Black
		  g.DrawRectangle(lightSwatchX, y, w, h)
		  
		  // Dark value.
		  Var darkSwatchX As Double = lightSwatchX + w + XUIInspector.CONTROL_BORDER_PADDING
		  g.DrawingColor = mValue.Dark
		  g.FillRectangle(darkSwatchX, y, w, h)
		  
		  // Dark value border.
		  g.DrawingColor = Color.Black
		  g.DrawRectangle(darkSwatchX, y, w, h)
		  
		  g.RestoreState
		  
		  // Update the hit bounds of the colour swatches.
		  mLightSwatchBounds = New Rect(lightSwatchX, y, w, h)
		  mDarkSwatchBounds = New Rect(darkSwatchX, y, w, h)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520686569676874206F662074686973206974656D20676976656E207468652064657369726564207374796C652E
		Function Height(style As XUIInspectorStyle) As Double
		  /// The height of this item given the desired style.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Return Max(style.FontSize + (2 * VPADDING), SwatchHeight(style) + (2 * VPADDING))
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
		  
		  // Nothing to do.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C7320746865206974656D20746861742061206D6F75736520646F776E206576656E7420686173206F636375727265642077697468696E2069747320626F756E64732E20782C20792061726520746865206162736F6C75746520636F6F7264696E617465732072656C617469766520746F2074686520696E73706563746F72202861646A757374656420666F72207363726F6C6C696E67292E2052657475726E732061204D6F757365446F776E4461746120696E7374616E636520696E737472756374696E672074686520696E73706563746F7220686F7720746F2068616E646C6520746865206576656E74206F72204E696C2069662074686520636C69636B206469646E27742068617070656E20696E2074686973206974656D2E
		Function MouseDown(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseDownData
		  /// Tells the item that a mouse down event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseDownData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't happen in this item.
		  
		  #Pragma Unused clickType
		  
		  If mBounds <> Nil And Not mBounds.Contains(x, y) THen
		    // The mouse down did not occur in this item.
		    Return Nil
		  Else
		    // We handle mouse events in MouseUp but we still need to return a MouseDownData instance
		    // If the click occurred in this item to tell the inspector that we're done.
		    Return New XUIInspectorMouseDownData
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5573656420746F2074656C6C2074686973206974656D207468617420746865206D6F75736520686173206A757374206578697465642069742E2052657475726E7320547275652069662074686520696E73706563746F722073686F756C64207265647261772E
		Function MouseExit() As Boolean
		  /// Used to tell this item that the mouse has just exited it.
		  /// Returns True if the inspector should redraw.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  // There is nothing to do since there are no visual effects caused by mouse movement in the colour swatch item.
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
		  
		  // Moving the over the colour swatch item does nothing so we'll just return Nil.
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
		  
		  If mBounds <> Nil And Not mBounds.Contains(x, y) Then
		    // Not over this item.
		    Return Nil
		  End If
		  
		  // The item should always have a valid inspector but we'll check.
		  If Owner = Nil Or Owner.Window = Nil Then Return Nil
		  
		  If mLightSwatchBounds <> Nil And mLightSwatchBounds.Contains(x, y) Then
		    If Not mColorPickerVisible Then
		      Var cp As New XUIColorPicker(Self.Value)
		      AddHandler cp.Closing, AddressOf PickerClosing
		      mActiveSwatch = ActiveSwatches.Light
		      mColorPickerVisible = True
		      cp.ShowModal(Owner.Window)
		    End If
		    
		  ElseIf mDarkSwatchBounds <> Nil And mDarkSwatchBounds.Contains(x, y) Then
		    If Not mColorPickerVisible Then
		      Var cp As New XUIColorPicker(Self.Value)
		      AddHandler cp.Closing, AddressOf PickerClosing
		      mActiveSwatch = ActiveSwatches.Dark
		      mColorPickerVisible = True
		      cp.ShowModal(Owner.Window)
		    End If
		  End If
		  
		  Return New XUIInspectorMouseUpData(True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686973206974656D2062656C6F6E677320746F2E
		Function Owner() As XUIInspector
		  /// A weak reference to the inspector this item belongs to.
		  
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
		  
		  If inspector = Nil Then
		    mOwner = Nil
		  Else
		    mOwner = New WeakRef(inspector)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C65676174652063616C6C6564207768656E206120636F6C6F7220737761746368277320636F6C6F72207069636B657220697320636C6F73696E672E
		Private Sub PickerClosing(picker As XUIColorPicker)
		  /// Delegate called when a color swatch's color picker is closing.
		  
		  If mActiveSwatch = ActiveSwatches.None Then Return
		  
		  Var newColor As Color = picker.CurrentColor
		  
		  If mValue = Nil Then
		    // This isn't supposed to happen but we'll cater for it anyway.
		    If mActiveSwatch = ActiveSwatches.Dark Then
		      mValue = New ColorGroup(Color.Black, newColor)
		    ElseIf mActiveSwatch = ActiveSwatches.Light Then
		      mValue = New ColorGroup(newColor, Color.Black)
		    End If
		  Else
		    Select Case mActiveSwatch
		    Case ActiveSwatches.Dark
		      If mValue.Dark = newColor Then
		        // No change.
		        Return
		      Else
		        mValue = New ColorGroup(mValue.Light, newColor)
		      End If
		      
		    Case ActiveSwatches.Light
		      If mValue.Light = newColor Then
		        // No change.
		        Return
		      Else
		        mValue = New ColorGroup(newColor, mValue.Dark)
		      End If
		    End Select
		  End If
		  
		  mColorPickerVisible = False
		  mActiveSwatch = ActiveSwatches.None
		  XUINotificationCenter.Send(Self, XUIInspector.NOTIFICATION_ITEM_CHANGED, mValue)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C732074686973206974656D207468617420616E7920706F707570206974207468696E6B732069742068617320646973706C6179656420686173206265656E206469736D69737365642077697468206E6F20616374696F6E2E
		Sub PopupDismissed()
		  /// Tells this item that any popup it thinks it has displayed has been dismissed with no action.
		  ///
		  /// Part of the `XUIInspectorItem` interface.
		  
		  // Since the colour swatch item doesn't display a popup menu, there's nothing to do.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520656E7472792061742060696E6465786020686173206265656E2073656C656374656420696E2074686973206974656D277320706F707570206D656E752E
		Sub PopupItemSelected(index As Integer)
		  /// The entry at `index` has been selected in this item's popup menu.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  // Since the colour swatch item doesn't display a popup, there's nothing to do.
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
		  /// |----------------------|
		  /// | CAPTION     [      ] |
		  /// |----------------------|
		  /// ```
		  
		  #Pragma Warning "TODO: Improve the layout/appearance"
		  
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
		  g.DrawText(Caption, x + HPADDING + Max(0, (CaptionWidth - g.TextWidth(Caption))), captionBaseline, CaptionWidth, True)
		  Var captionRightX As Double = x + HPADDING + CaptionWidth
		  
		  // Compute the width of each swatch.
		  Var swatchWidth As Double = _
		  (width - XUIInspector.CONTROL_BORDER_PADDING - captionRightX - XUIInspector.CAPTION_CONTROL_PADDING - XUIInspector.CONTROL_BORDER_PADDING) / 2
		  
		  // Cache the swatch height as it's computed.
		  Var cachedSwatchHeight As Double = SwatchHeight(style)
		  
		  // Draw the colour swatches and update thier bounds.
		  DrawColorSwatches(g, x + HPADDING + CaptionWidth + XUIInspector.CAPTION_CONTROL_PADDING, y + (h/2) - (cachedSwatchHeight / 2), style, swatchWidth, cachedSwatchHeight)
		  
		  g.RestoreState
		  
		  // Update the item's bounds.
		  mBounds = New Rect(x, y, width, h)
		  
		  Return y + h
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54686520686569676874206F66207468652073776174636820676976656E207468652063757272656E74207374796C652E
		Private Function SwatchHeight(style As XUIInspectorStyle) As Double
		  /// The height of the swatch given the current style.
		  
		  Return style.FontSize + SWATCH_VPADDING
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		An item containing a two colour swatches and a caption. Used to set ColorGroups for light and dark mode
		 applications.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 5468652063617074696F6E20746F20646973706C617920626573696465732074686520636F6C6F75722073776174636865732E
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

	#tag Property, Flags = &h21, Description = 5468652063757272656E746C7920616374697665207377617463682E
		Private mActiveSwatch As ActiveSwatches = ActiveSwatches.None
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F662074686973206974656D2E
		Private mBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063617074696F6E20746F20646973706C617920626573696465732074686520636F6C6F75722073776174636865732E
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520636F6C6F72207069636B65722069732076697369626C652E
		Private mColorPickerVisible As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F6620746865206461726B206D6F646520636F6C6F7572207377617463682E205573656420666F72206869742D74657374696E672E
		Private mDarkSwatchBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5573656420746F206964656E746966792074686973206974656D20696E206E6F74696669636174696F6E732E20596F752073686F756C6420656E7375726520697420697320756E697175652077697468696E2074686520696E73706563746F722E
		Private mID As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F6620746865206C69676874206D6F646520636F6C6F7572207377617463682E205573656420666F72206869742D74657374696E672E
		Private mLightSwatchBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686973206974656D2062656C6F6E677320746F2E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652076616C7565206173206120436F6C6F7247726F75702E
		Private mValue As ColorGroup
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652076616C7565206173206120436F6C6F7247726F75702E
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
		Value As ColorGroup
	#tag EndComputedProperty


	#tag Constant, Name = HPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206974656D277320636F6E74656E74206C65667420616E642072696768742E
	#tag EndConstant

	#tag Constant, Name = SWATCH_VPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 54686520686569676874206F6620746865207377617463682069732074686520686569676874206F66207468652063617074696F6E20706C757320746869732076616C75652E
	#tag EndConstant

	#tag Constant, Name = VPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206974656D277320636F6E74656E742061626F766520616E642062656C6F772E
	#tag EndConstant


	#tag Enum, Name = ActiveSwatches, Type = Integer, Flags = &h21, Description = 5468652074797065206F662063757272656E746C7920616374697665207377617463682E
		None
		  Light
		Dark
	#tag EndEnum


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
			InitialValue="&c000000"
			Type="ColorGroup"
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
