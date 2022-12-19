#tag Class
Protected Class XUIInspectorTextFieldItem
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

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E6577206974656D207769746820616E206564697461626C652074657874206669656C642E205468652074657874206669656C642063616E20686176652061206F7074696F6E616C20706C616365686F6C64657220746578742E
		Sub Constructor(id As String, caption As String, captionWidth As Integer, placeHolder As String = "")
		  /// Constructs a new item with an editable text field.
		  /// The text field can have a optional placeholder text.
		  
		  mID = id
		  Self.Caption = caption
		  Self.CaptionWidth = captionWidth
		  
		  mTextField = New XUIInspectorTextFieldRenderer(Nil)
		  
		  Self.Placeholder = placeHolder
		  
		  mLastNewlineEvent = System.Microseconds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41206B657920636F6D6D616E6420686173206F636375727265642E
		Sub DoCommand(command As String)
		  /// A key command has occurred.
		  ///
		  /// Part of the `XUIInspectorItemKeyHandler` interface.
		  
		  Select Case command
		    // =========================================
		    // MOVING THE CARET
		    // =========================================
		  Case XUIInspector.CmdMoveLeft, XUIInspector.CmdMoveBackward
		    mTextField.MoveCaretLeft
		    
		  Case XUIInspector.CmdMoveRight, XUIInspector.CmdMoveForward
		    mTextField.MoveCaretRight
		    
		  Case XUIInspector.CmdMoveToBeginningOfLine, XUIInspector.CmdMoveToLeftEndOfLine
		    mTextField.MoveToBeginningOfLine
		    
		  Case XUIInspector.CmdMoveToEndOfLine, XUIInspector.CmdMoveToRightEndOfLine
		    mTextField.MoveToEndOfLine
		    
		  Case XUIInspector.CmdMoveWordLeft
		    mTextField.MoveCaretToPreviousWordStart
		    
		  Case XUIInspector.CmdMoveWordRight
		    mTextField.MoveCaretToNextWordEnd
		    
		  Case XUIInspector.CmdMoveUp
		    mTextField.MoveToBeginningOfLine
		    
		  Case XUIInspector.CmdMoveDown
		    mTextField.MoveToEndOfLine
		    
		    // =========================================
		    // DELETING
		    // =========================================
		  Case XUIInspector.CmdDeleteBackward
		    // Remove the character before the caret.
		    mTextField.DeleteBackward
		    
		  Case XUIInspector.CmdDeleteForward
		    // Remove the character after the caret.
		    mTextField.DeleteForward
		    
		    // =========================================
		    // SELECTING TEXT
		    // =========================================
		  Case XUIInspector.CmdMoveLeftAndModifySelection
		    mTextField.MoveLeftAndModifySelection
		    
		  Case XUIInspector.CmdMoveRightAndModifySelection
		    mTextField.MoveRightAndModifySelection
		    
		  Case XUIInspector.CmdMoveToLeftEndOfLineAndModifySelection
		    mTextField.MoveToLeftEndOfLineAndModifySelection
		    
		  Case XUIInspector.CmdMoveToRightEndOfLineAndModifySelection
		    mTextField.MoveToRightEndOfLineAndModifySelection
		    
		  Case XUIInspector.CmdMoveWordLeftAndModifySelection
		    mTextField.MoveWordLeftAndModifySelection
		    
		  Case XUIInspector.CmdMoveUpAndModifySelection
		    mTextField.MoveUpAndModifySelection
		    
		  Case XUIInspector.CmdMoveDownAndModifySelection
		    mTextField.MoveDownAndModifySelection
		    
		    // =========================================
		    // OTHER
		    // =========================================
		  Case XUIInspector.CmdInsertNewline
		    HandleNewline
		    
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C652074686520696E73657274696F6E206F662061206E65776C696E652028692E65207468652072657475726E206B6579292E
		Private Sub HandleNewline()
		  /// Handle the insertion of a newline (i.e the return key).
		  
		  // Select all the text.
		  mTextField.SelectAll
		  
		  // Cache the current contents of the text field.
		  mContentsWhenActivated = mTextField.Contents
		  
		  // There is a bug on windows that causes the newline insertion event to fire twice. Catch that.
		  If System.Microseconds - mLastNewlineEvent < NEWLINE_EVENT_DELAY Then
		    Return
		  Else
		    // Cache when we handled this event.
		    mLastNewlineEvent = System.Microseconds
		  End If
		  
		  XUINotificationCenter.Send(Self, XUIInspector.NOTIFICATION_ITEM_CHANGED, mTextField.Contents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520686569676874206F662074686973206974656D20676976656E207468652064657369726564207374796C652E
		Function Height(style As XUIInspectorStyle) As Double
		  /// The height of this item given the desired style.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  Return style.FontSize + (2 * TEXTFIELD_CONTENT_VPADDING) + (2 * VPADDING)
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
		  
		  mTextField.InsertCharacter(char, range)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686973206974656D206A757374206C6F73742074686520666F6375732E
		Sub LostFocus()
		  /// This item just lost the focus.
		  ///
		  /// Part of the `XUIInspectorItem` interface.
		  
		  HasFocus = False
		  mTextField.ClearSelection
		  Owner.MouseCursor = System.Cursors.StandardPointer
		  
		  // Has the contents changed?
		  If Not mContentsWhenActivated.CompareCase(mTextField.Contents) Then
		    mContentsWhenActivated = mTextField.Contents
		    XUINotificationCenter.Send(Self, XUIInspector.NOTIFICATION_ITEM_CHANGED, mTextField.Contents)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MouseDown(x As Integer, y As Integer, clickType As XUI.ClickTypes) As XUIInspectorMouseDownData
		  /// Tells the item that a mouse down event has occurred within its bounds.
		  /// x, y are the absolute coordinates relative to the inspector (adjusted for scrolling).
		  /// Returns a MouseDownData instance instructing the inspector how to handle the event
		  /// or Nil if the click didn't occur in this item.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  #Pragma Unused clickType
		  
		  If mBounds <> Nil And Not mBounds.Contains(x, y) Then
		    // Didn't click in this item.
		    Return Nil
		  Else
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
		  If mTextFieldBounds <> Nil And mTextFieldBounds.Contains(x, y) Then
		    Owner.MouseCursor = System.Cursors.IBeam
		  Else
		    Owner.MouseCursor = System.Cursors.StandardPointer
		  End If
		  
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
		  
		  If mBounds <> Nil And Not mBounds.Contains(x, y) Then
		    // Didn't click in this item.
		    Return Nil
		  End If
		  
		  If mTextFieldBounds <> Nil And mTextFieldBounds.Contains(x, y) Then
		    // Clicked the text field.
		    HasFocus = True
		    mTextField.ClearSelection
		    If clickType = XUi.ClickTypes.DoubleClick Then
		      mTextField.DoubleClick(x - mTextFieldBounds.Left, y - mTextFieldBounds.Top)
		    ElseIf clickType = XUI.ClickTypes.SingleClick Then
		      mTextField.UpdateCaretPosition(x - mTextFieldBounds.Left, y - mTextFieldBounds.Top)
		    Else
		      // A triple click or right click occurred. At present we don't do anything with these 
		      // but we will signal to the inspector that the click occurred in this item by
		      // falling through to return a MouseDownData instance.
		    End If
		  End If
		  
		  Return New XUIInspectorMouseUpData(True)
		  
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
		  
		  mTextField.Owner = Self.Owner
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
		  
		  Return New Rect(mTextFieldBounds.Left + mTextField.CaretXCoordinate, mTextFieldBounds.Top, 20, 20)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Render(g As Graphics, x As Double, y As Double, width As Double, style As XUIInspectorStyle) As Double
		  /// The item should render itself to the passed graphics context at the specified location.
		  /// Returns the position of the item's bottom edge.
		  ///
		  /// Part of the XUIInspectorItem interface.
		  ///
		  /// ```nohighlight
		  /// |--------------------------|
		  /// | CAPTION   [ TEXT FIELD ] |
		  /// |--------------------------|
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
		  
		  // Compute the width of the textfield if needed.
		  If mTextFieldWidth = 0 Then
		    mTextFieldWidth = width - XUIInspector.CONTROL_BORDER_PADDING - captionRightX - XUIInspector.CAPTION_CONTROL_PADDING
		  End If
		  
		  // Compute the desired position and dimensions of the text field.
		  Var textFieldH As Double = style.FontSize + (2 * TEXTFIELD_CONTENT_VPADDING)
		  Var textFieldX As Double = x + HPADDING + CaptionWidth + XUIInspector.CAPTION_CONTROL_PADDING
		  Var textFieldY As Double = y + ((h/2) - (textFieldH/2))
		  
		  // Draw the background for the text field.
		  g.DrawingColor = style.ControlBackgroundColor
		  g.FillRectangle(textFieldX, textFieldY, mTextFieldWidth, textFieldH)
		  
		  // Render the text field.
		  mTextField.Render(g, textFieldX, textFieldY, mTextFieldWidth, textFieldH, style, Owner.ItemWithFocus = Self)
		  
		  // Update the item's bounds.
		  mBounds = New Rect(x, y, width, h)
		  
		  // Update the text field's bounds.
		  mTextFieldBounds = New Rect(textFieldX, textFieldY, mTextFieldWidth, textFieldH)
		  
		  g.RestoreState
		  
		  Return y + h
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		An item containing an editable text field beside a caption.
		
	#tag EndNote


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

	#tag Property, Flags = &h21, Description = 49662054727565207468656E207468652074657874206669656C64206861732074686520666F6375732E
		Private HasFocus As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F662074686973206974656D2E
		Private mBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063617074696F6E20746F20646973706C6179206E65787420746F207468652074657874206669656C642E
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6E74656E7473206F66207468652074657874206669656C64207768656E206C617374206163746976617465642E
		Private mContentsWhenActivated As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5573656420746F206964656E746966792074686973206974656D20696E206E6F74696669636174696F6E732E20596F752073686F756C6420656E7375726520697420697320756E697175652077697468696E2074686520696E73706563746F722E
		Private mID As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5768656E20746865206C617374206E65776C696E6520696E73657274696F6E206576656E74207761732068616E646C65642E
		Private mLastNewlineEvent As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520696E73706563746F722074686973206974656D2062656C6F6E677320746F2E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4F7074696F6E616C20706C616365686F6C64657220666F72207468652074657874206669656C642E
		Private mPlaceholder As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686973206974656D27732074657874206669656C642E
		Private mTextField As XUIInspectorTextFieldRenderer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F66207468652074657874206669656C642E
		Private mTextFieldBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207769647468206F66207468652074657874206669656C642E
		Private mTextFieldWidth As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4F7074696F6E616C20706C616365686F6C64657220666F72207468652074657874206669656C642E
		#tag Getter
			Get
			  Return mPlaceholder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mPlaceholder = value
			  
			  If mTextField <> Nil Then
			    mTextField.Placeholder = value
			  End If
			  
			End Set
		#tag EndSetter
		Placeholder As String
	#tag EndComputedProperty


	#tag Constant, Name = HPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206974656D277320636F6E74656E74206C65667420616E642072696768742E
	#tag EndConstant

	#tag Constant, Name = NEWLINE_EVENT_DELAY, Type = Double, Dynamic = False, Default = \"50000", Scope = Private, Description = 546865206E756D626572206F66206D6963726F7365636F6E647320746F2077616974206265747765656E20616363657074696E672074776F20636F6E7365637574697665206E65776C696E6520696E73657274696F6E206576656E74732E
	#tag EndConstant

	#tag Constant, Name = TEXTFIELD_CONTENT_VPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520636F6E74656E7473206F66207468652074657874206669656C642066726F6D207468652074657874206669656C6420626F72646572732E
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
			Name="Placeholder"
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
