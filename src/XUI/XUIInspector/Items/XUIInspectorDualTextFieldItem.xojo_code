#tag Class
Protected Class XUIInspectorDualTextFieldItem
Implements XUIInspectorItem,XUIInspectorItemKeyHandler
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

	#tag Method, Flags = &h0
		Sub Constructor(id As String, caption As String, captionWidth As Integer, topCaption As String, bottomCaption As String, topPlaceHolder As String = "", bottomPlaceHolder As String = "")
		  mID = id
		  Self.Caption = caption
		  Self.CaptionWidth = captionWidth
		  Self.TopCaption = topCaption
		  Self.BottomCaption = bottomCaption
		  
		  mTopTextField = New XUIInspectorTextFieldRenderer(Nil, topPlaceHolder)
		  mBottomTextField = New XUIInspectorTextFieldRenderer(Nil, bottomPlaceHolder)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41206B657920636F6D6D616E6420686173206F636375727265642E
		Sub DoCommand(command As String)
		  /// A key command has occurred.
		  ///
		  /// Part of the `XUIInspectorItemKeyHandler` interface.
		  
		  Var currentTextField As XUIInspectorTextFieldRenderer
		  If TopHasFocus Then
		    currentTextField = mTopTextField
		  Else
		    currentTextField = mBottomTextField
		  End If
		  
		  Select Case command
		    // =========================================
		    // MOVING THE CARET
		    // =========================================
		  Case XUIInspector.CmdMoveLeft, XUIInspector.CmdMoveBackward
		    currentTextField.MoveCaretLeft
		    
		  Case XUIInspector.CmdMoveRight, XUIInspector.CmdMoveForward
		    currentTextField.MoveCaretRight
		    
		  Case XUIInspector.CmdMoveToBeginningOfLine, XUIInspector.CmdMoveToLeftEndOfLine
		    currentTextField.MoveToBeginningOfLine
		    
		  Case XUIInspector.CmdMoveToEndOfLine, XUIInspector.CmdMoveToRightEndOfLine
		    currentTextField.MoveToEndOfLine
		    
		  Case XUIInspector.CmdMoveWordLeft
		    currentTextField.MoveCaretToPreviousWordStart
		    
		  Case XUIInspector.CmdMoveWordRight
		    currentTextField.MoveCaretToNextWordEnd
		    
		  Case XUIInspector.CmdMoveUp
		    currentTextField.MoveToBeginningOfLine
		    
		  Case XUIInspector.CmdMoveDown
		    currentTextField.MoveToEndOfLine
		    
		    // =========================================
		    // DELETING
		    // =========================================
		  Case XUIInspector.CmdDeleteBackward
		    // Remove the character before the caret.
		    currentTextField.DeleteBackward
		    
		  Case XUIInspector.CmdDeleteForward
		    // Remove the character after the caret.
		    currentTextField.DeleteForward
		    
		    // =========================================
		    // SELECTING TEXT
		    // =========================================
		  Case XUIInspector.CmdMoveLeftAndModifySelection
		    currentTextField.MoveLeftAndModifySelection
		    
		  Case XUIInspector.CmdMoveRightAndModifySelection
		    currentTextField.MoveRightAndModifySelection
		    
		  Case XUIInspector.CmdMoveToLeftEndOfLineAndModifySelection
		    currentTextField.MoveToLeftEndOfLineAndModifySelection
		    
		  Case XUIInspector.CmdMoveToRightEndOfLineAndModifySelection
		    currentTextField.MoveToRightEndOfLineAndModifySelection
		    
		  Case XUIInspector.CmdMoveWordLeftAndModifySelection
		    currentTextField.MoveWordLeftAndModifySelection
		    
		  Case XUIInspector.CmdMoveUpAndModifySelection
		    currentTextField.MoveUpAndModifySelection
		    
		  Case XUIInspector.CmdMoveDownAndModifySelection
		    currentTextField.MoveDownAndModifySelection
		    
		    // =========================================
		    // OTHER
		    // =========================================
		  Case XUIInspector.CmdInsertNewline
		    // The return key has been pressed.
		    currentTextField.SelectAll
		    If TopHasFocus Then
		      mTopContentsWhenActivated = currentTextField.Contents
		    ElseIf BottomHasFocus Then
		      mBottomContentsWhenActivated = currentTextField.Contents
		    End If
		    Var data As New Dictionary("top" : mTopTextField.Contents, "bottom" : mBottomTextField.Contents)
		    XUINotificationCenter.Send(Self, XUIInspector.NOTIFICATION_ITEM_CHANGED, data)
		    
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 447261777320612074657874206669656C642063617074696F6E2060736020746F206067602061742060782C20796020776974682077696474682060776020616E6420686569676874206068602E2049662060736020697320656D707479207468656E206E6F7468696E6720697320647261776E2E
		Private Sub DrawTextFieldCaption(s As String, baseline As Double, x As Double, y As Double, w As Double, h As Double, g As Graphics, style As XUIInspectorStyle)
		  /// Draws a text field caption `s` to `g` at `x, y` with width `w` and height `h`.
		  /// If `s` is empty then nothing is drawn.
		  
		  If s = "" Then Return
		  
		  g.SaveState
		  
		  Var lineH As Double = h - 1 // Fudge.
		  
		  // Background.
		  g.DrawingColor = style.TextFieldCaptionBackgroundColor
		  g.FillRectangle(x, y, w, h)
		  
		  // Borders. 
		  // We don't draw a right border as that will be drawn by the text field renderer.
		  g.DrawingColor = style.ControlBorderColor
		  // Top.
		  g.DrawLine(x, y, x + w, y)
		  // Left.
		  g.DrawLine(x, y, x, y + lineH)
		  // Bottom.
		  g.DrawLine(x, y + lineH, x + w, y + lineH)
		  
		  // Caption.
		  g.DrawingColor = style.TextFieldCaptionTextColor
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  g.DrawText(s, x + TEXTFIELD_CAPTION_INTERNAL_PADDING, baseline)
		  
		  g.RestoreState
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520686569676874206F662074686973206974656D20676976656E207468652064657369726564207374796C652E
		Function Height(style As XUIInspectorStyle) As Double
		  /// The height of this item given the desired style.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Return (2 * style.FontSize) + (4 * TEXTFIELD_CONTENT_VPADDING) + (2 * VPADDING) + TEXTFIELD_VPADDING
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

	#tag Method, Flags = &h0, Description = 546865207573657220697320617474656D7074696E6720746F20696E7365727420612073696E676C652063686172616374657220696E746F2074686973206974656D2E
		Sub InsertCharacter(char As String, range As TextRange)
		  /// The user is attempting to insert a single character into this item.
		  ///
		  /// Part of the `XUIInspectorItemKeyHandler` interface.
		  
		  If TopHasFocus Then
		    mTopTextField.InsertCharacter(char, range)
		  Else
		    mBottomTextField.InsertCharacter(char, range)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686973206974656D206A757374206C6F73742074686520666F6375732E
		Sub LostFocus()
		  /// This item just lost the focus.
		  ///
		  /// Part of the `XUIInspectorItem` interface.
		  
		  TopHasFocus = False
		  BottomHasFocus = False
		  mTopTextField.ClearSelection
		  mBottomTextField.ClearSelection
		  Owner.MouseCursor = System.Cursors.StandardPointer
		  
		  // Has the contents changed?
		  If Not mTopContentsWhenActivated.CompareCase(mTopTextField.Contents) Or _ 
		    Not mBottomContentsWhenActivated.CompareCase(mBottomTextField.Contents) Then
		    mTopContentsWhenActivated = mTopTextField.Contents
		    mBottomContentsWhenActivated = mBottomTextField.Contents
		    Var data As New Dictionary("top" : mTopTextField.Contents, "bottom" : mBottomTextField.Contents)
		    XUINotificationCenter.Send(Self, XUIInspector.NOTIFICATION_ITEM_CHANGED, data)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MouseDown(x As Integer, y As Integer) As XUIInspectorMouseDownData
		  /// Tells the item that a mouse down event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseDownData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't occur in this item.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  If mBounds <> Nil And Not mBounds.Contains(x, y) Then
		    // Didn't click in this item.
		    Return Nil
		  End If
		  
		  If mTopTextFieldBounds <> Nil And mTopTextFieldBounds.Contains(x, y) Then
		    // Clicked the top text field.
		    LostFocus
		    TopHasFocus = True
		    mTopTextField.UpdateCaretPosition(x - mTopTextFieldBounds.Left, y - mTopTextFieldBounds.Top)
		    
		  ElseIf mBottomTextFieldBounds <> Nil And mBottomTextFieldBounds.Contains(x, y) Then
		    // Clicked the bottom text field.
		    LostFocus
		    BottomHasFocus = True
		    mBottomTextField.UpdateCaretPosition(x - mBottomTextFieldBounds.Left, y - mBottomTextFieldBounds.Top)
		  End If
		  
		  Return New XUIInspectorMouseDownData
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5573656420746F2074656C6C2074686973206974656D207468617420746865206D6F75736520686173206A757374206578697465642069742E2052657475726E7320547275652069662074686520696E73706563746F722073686F756C64207265647261772E
		Function MouseExit() As Boolean
		  /// Used to tell this item that the mouse has just exited it.
		  /// Returns True if the inspector should redraw.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  // There is nothing to do since there are no visual effects caused by mouse movement in the text field item.
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
		  
		  // Moving the mouse over the text field changes the mouse cursor to the bar.
		  If mTopTextFieldBounds <> Nil And mTopTextFieldBounds.Contains(x, y) Then
		    // Over the top text field.
		    Owner.MouseCursor = System.Cursors.IBeam
		    
		  ElseIf mBottomTextFieldBounds <> Nil And mBottomTextFieldBounds.Contains(x, y) Then
		    // Over the bottom text field.
		    Owner.MouseCursor = System.Cursors.IBeam
		    
		  Else
		    Owner.MouseCursor = System.Cursors.StandardPointer
		  End If
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54656C6C7320746865206974656D20746861742061206D6F757365207570206576656E7420686173206F636375727265642077697468696E2069747320626F756E64732E20782C20792061726520746865206162736F6C75746520636F6F7264696E617465732072656C617469766520746F2074686520696E73706563746F72202861646A757374656420666F72207363726F6C6C696E67292E2052657475726E732061204D6F75736555704461746120696E7374616E636520696E737472756374696E672074686520696E73706563746F7220686F7720746F2068616E646C6520746865206576656E74206F72204E696C2069662074686520636C69636B206469646E2774206F6363757220696E2074686973206974656D2E
		Function MouseUp(x As Integer, y As Integer) As XUIInspectorMouseUpData
		  /// Tells the item that a mouse up event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseUpData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't occur in this item.
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  // Nothing to do here.
		  Return Nil
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
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

	#tag Method, Flags = &h0
		Sub Owner(Assigns inspector As XUIInspector)
		  /// The inspector this item belongs to. A weak reference will be created.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  If inspector = Nil Then
		    mOwner = Nil
		  Else
		    mOwner = New WeakRef(inspector)
		  End If
		  
		  mTopTextField.Owner = Self.Owner
		  mBottomTextField.Owner = Self.Owner
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopupDismissed()
		  /// Tells this item that any popup it thinks it has displayed has been dismissed with no action.
		  ///
		  /// Part of the `XUIInspectorItem` interface.
		  
		  // The text field item doesn't utilise popups so there's nothing to do.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520656E7472792061742060696E6465786020686173206265656E2073656C656374656420696E2074686973206974656D277320706F707570206D656E752E
		Sub PopupItemSelected(index As Integer)
		  /// The entry at `index` has been selected in this item's popup menu.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  // The text field item doesn't utilise popups so there's nothing to do.
		  #Pragma Unused index
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E20612072616E676520666F72206D61634F5320746F20646973706C61792074686520636861726163746572207069636B65722E
		Function RectForRange(range As TextRange) As Xojo.Rect
		  /// Return a range for macOS to display the character picker.
		  ///
		  /// I'm being lazy here and returning an arbitrary width and height because for our purposes we are only
		  /// interested in the popup being positioned at the correct location. This will likely mean that I'm not fully
		  /// supporting advanced uses of this event but since I don't actually understand the event, that's OK by me.
		  
		  #Pragma Unused range
		  
		  If TopHasFocus Then
		    Return New Rect(mTopTextFieldBounds.Left + mTopTextField.CaretXCoordinate, mTopTextFieldBounds.Top, 20, 20)
		  Else // Bottom.
		    Return New Rect(mBottomTextFieldBounds.Left + mBottomTextField.CaretXCoordinate, mBottomTextFieldBounds.Top, 20, 20)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Render(g As Graphics, x As Double, y As Double, width As Double, style As XUIInspectorStyle) As Double
		  /// The item should render itself to the passed graphics context at the specified location.
		  /// Returns the position of the item's bottom edge.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  ///
		  /// |----------------------------|
		  /// | CAPTION   T [ TEXT FIELD ] |
		  /// |           B [ TEXT FIELD ] |
		  /// |----------------------------|
		  ///
		  /// T: Top caption.
		  /// B: Bottom caption.
		  
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
		  // This will be the same for the top textfield's caption.
		  Var singleLineH As Double = style.FontSize + (2 * TEXTFIELD_CONTENT_VPADDING) + (2 * VPADDING)
		  Var captionBaseline As Double = (g.FontAscent + (singleLineH - g.TextHeight)/2 + y)
		  
		  // Compute the width of the widest text field caption.
		  mMaxTextFieldCaptionWidth = Max(g.TextWidth(TopCaption), g.TextWidth(BottomCaption)) + (2 * TEXTFIELD_CAPTION_INTERNAL_PADDING)
		  
		  // Draw the right-aligned caption.
		  g.DrawingColor = style.TextColor
		  Var captionLeftX As Double = x + HPADDING + Max((CaptionWidth - g.TextWidth(Caption)), 0)
		  g.DrawText(Caption, captionLeftX, captionBaseline, CaptionWidth, True)
		  Var captionRightX As Double = x + HPADDING + CaptionWidth
		  
		  // Compute the width of the textfields if needed.
		  If mTextFieldWidth = 0 Then
		    mTextFieldWidth = width - XUIInspector.CONTROL_BORDER_PADDING - captionRightX - XUIInspector.CAPTION_CONTROL_PADDING - mMaxTextFieldCaptionWidth
		  End If
		  
		  // Compute the desired position and dimensions of the text fields.
		  Var textFieldH As Double = style.FontSize + (2 * TEXTFIELD_CONTENT_VPADDING)
		  Var textFieldX As Double = x + HPADDING + CaptionWidth + XUIInspector.CAPTION_CONTROL_PADDING + mMaxTextFieldCaptionWidth
		  Var topTextFieldY As Double = y + ((singleLineH/2) - (textFieldH/2))
		  Var bottomTextFieldY As Double = topTextFieldY + TextFieldH + TEXTFIELD_VPADDING
		  
		  // Draw the text field caption(s).
		  Var tfCaptionX As Double = TextFieldX - mMaxTextFieldCaptionWidth
		  DrawTextFieldCaption(TopCaption, captionBaseline, tfCaptionX, topTextFieldY, mMaxTextFieldCaptionWidth, textFieldH, g, style)
		  DrawTextFieldCaption(BottomCaption, captionBaseline + TextFieldH + TEXTFIELD_VPADDING, tfCaptionX, bottomTextFieldY, mMaxTextFieldCaptionWidth, textFieldH, g, style)
		  
		  // Draw the background for the text fields.
		  g.DrawingColor = style.ControlBackgroundColor
		  g.FillRectangle(textFieldX, topTextFieldY, mTextFieldWidth, textFieldH)
		  g.FillRectangle(textFieldX, bottomTextFieldY, mTextFieldWidth, textFieldH)
		  
		  // Render the text fields.
		  mTopTextField.Render(g, textFieldX, topTextFieldY, mTextFieldWidth, textFieldH, style, Owner.ItemWithFocus = Self And TopHasFocus)
		  mBottomTextField.Render(g, textFieldX, bottomTextFieldY, mTextFieldWidth, textFieldH, style, Owner.ItemWithFocus = Self And BottomHasFocus)
		  
		  // Update the item's bounds.
		  mBounds = New Rect(x, y, width, h)
		  
		  // Update the text field's bounds.
		  mTopTextFieldBounds = New Rect(textFieldX, topTextFieldY, mTextFieldWidth, textFieldH)
		  mBottomTextFieldBounds = New Rect(textFieldX, bottomTextFieldY, mTextFieldWidth, textFieldH)
		  
		  g.RestoreState
		  
		  Return y + h
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		An item with two text fields, one above the other.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 54686520626F74746F6D20746578746669656C6427732063617074696F6E2E
		Private BottomCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2074686520626F74746F6D2074657874206669656C64206861732074686520666F6375732E
		Private BottomHasFocus As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4F7074696F6E616C20706C616365686F6C64657220666F722074686520626F74746F6D2074657874206669656C642E
		#tag Getter
			Get
			  If mBottomTextField <> Nil Then
			    Return mBottomTextField.Placeholder
			  Else
			    Return ""
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mBottomTextField <> Nil Then
			    mBottomTextField.Placeholder = value
			  End If
			  
			End Set
		#tag EndSetter
		BottomPlaceholder As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063617074696F6E20746F20646973706C6179206E65787420746F207468652074657874206669656C642E
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

	#tag Property, Flags = &h21, Description = 54686520636F6E74656E7473206F662074686520626F74746F6D2074657874206669656C64207768656E206C617374206163746976617465642E
		Private mBottomContentsWhenActivated As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F74746F6D2074657874206669656C642E
		Private mBottomTextField As XUIInspectorTextFieldRenderer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F662074686520626F74746F6D2074657874206669656C642E
		Private mBottomTextFieldBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063617074696F6E20746F20646973706C6179206E65787420746F207468652074657874206669656C642E
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5573656420746F206964656E746966792074686973206974656D20696E206E6F74696669636174696F6E732E20596F752073686F756C6420656E7375726520697420697320756E697175652077697468696E2074686520696E73706563746F722E
		Private mID As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207769647468206F6620746865207769646573742074657874206669656C642063617074696F6E2E20436F6D707574656420696E206052656E646572602E
		Private mMaxTextFieldCaptionWidth As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686973206974656D2062656C6F6E677320746F2E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207769647468206F66207468652074657874206669656C642E
		Private mTextFieldWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6E74656E7473206F662074686520746F702074657874206669656C64207768656E206C617374206163746976617465642E
		Private mTopContentsWhenActivated As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F702074657874206669656C642E
		Private mTopTextField As XUIInspectorTextFieldRenderer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F662074686520746F702074657874206669656C642E
		Private mTopTextFieldBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F7020746578746669656C6427732063617074696F6E2E
		Private TopCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2074686520746F702074657874206669656C64206861732074686520666F6375732E
		Private TopHasFocus As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4F7074696F6E616C20706C616365686F6C64657220666F722074686520746F702074657874206669656C642E
		#tag Getter
			Get
			  If mTopTextField <> Nil Then
			    Return mTopTextField.Placeholder
			  Else
			    Return ""
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mTopTextField <> Nil Then
			    mTopTextField.Placeholder = value
			  End If
			  
			End Set
		#tag EndSetter
		TopPlaceholder As String
	#tag EndComputedProperty


	#tag Constant, Name = HPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206974656D277320636F6E74656E74206C65667420616E642072696768742E
	#tag EndConstant

	#tag Constant, Name = TEXTFIELD_CAPTION_INTERNAL_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061646420746865206C65667420616E64207269676874206F6620612074657874206669656C642063617074696F6E2066726F6D2069747320626F72646572732E
	#tag EndConstant

	#tag Constant, Name = TEXTFIELD_CONTENT_VPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520636F6E74656E7473206F66207468652074657874206669656C642066726F6D207468652074657874206669656C6420626F72646572732E
	#tag EndConstant

	#tag Constant, Name = TEXTFIELD_VPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420766572746963616C6C79206265747765656E207468652074776F20746578746669656C64732E
	#tag EndConstant

	#tag Constant, Name = VPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F20706164207468652074657874206669656C642061626F766520616E642062656C6F772E
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
			Name="TopPlaceholder"
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
		#tag ViewProperty
			Name="BottomPlaceholder"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
