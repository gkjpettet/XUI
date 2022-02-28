#tag Class
Protected Class XUITagCanvasAutocompletePopup
Inherits DesktopTextInputCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  /// Determine the index of the suggestion clicked.
		  
		  #Pragma Unused x
		  
		  SelectedIndex = Floor((y + ScrollPosY + Owner.Renderer.AutocompleteVerticalPadding) / _
		  (Owner.Renderer.AutocompleteOptionHeight + Owner.Renderer.AutocompleteOptionVerticalPadding))
		  
		  Owner.AcceptCurrentAutocompleteOption
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  /// The mouse has wheeled.
		  ///
		  /// `x` is the X coord relative to the control that has received the event.
		  /// `y` is the Y coord relative to the control that has received the event.
		  /// `deltaX` is the number of horizontal scroll lines moved.
		  /// `deltaY` is the number of vertical scroll lines moved.
		  ///
		  /// Returns True to prevent propagating the event further.
		  ///
		  /// `deltaX` is positive when the user scrolls right and negative when scrolling left. 
		  /// `deltaY` is positive when the user scrolls down and negative when scrolling up.
		  
		  #Pragma Unused X
		  #Pragma Unused Y
		  #Pragma Unused deltaX
		  
		  ScrollPosY = ScrollPosY + (deltaY)
		  
		  // Prevent the event propagating further.
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Xojo.Rect)
		  #Pragma Unused areas
		  
		  If Owner.AutocompleteData = Nil Then Return
		  If mBuffer = Nil Then mBuffer = Owner.Renderer.ImageForAutocompletePopup(Self.Width, SelectedIndex)
		  
		  g.DrawPicture(mBuffer, 0, -ScrollPosY)
		  
		  // Border.
		  If Owner.Style.HasAutocompletePopupBorder Then
		    g.DrawingColor = Owner.Style.AutocompletePopupBorderColor
		    If Owner.Renderer.AutocompletePopupBorderRadius = 0 Then
		      g.DrawRectangle(0, 0, g.Width, g.Height)
		    Else
		      g.DrawRoundRectangle(0, 0, g.Width, g.Height, _
		      Owner.Renderer.AutocompletePopupBorderRadius, Owner.Renderer.AutocompletePopupBorderRadius)
		    End If
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITagCanvas)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  mOwner = New WeakRef(owner)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5363726F6C6C732074686520706F70757020746F2077686F6C6C7920646973706C6179207468652073656C656374656420696E646578206966206974206973206E6F7420616C72656164792E20526566726573686573207468652063616E7661732E
		Private Sub ScrollToSelectedIndex()
		  /// Scrolls the popup to wholly display the selected index if it is not already.
		  /// Refreshes the canvas.
		  ///
		  /// Assumes `SelectedIndex` is valid.
		  
		  If SelectedIndex = -1 Then
		    ScrollPosY = 0
		    Return
		  End If
		  
		  Var lineH As Integer = Owner.Renderer.AutocompleteOptionHeight
		  If (SelectedIndex * lineH) < ScrollPosY Or (SelectedIndex * lineH) > Self.Height Then
		    ScrollPosY = SelectedIndex * lineH
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526573697A657320616E6420726564726177732074686973206175746F636F6D706C65746520706F707570207573696E6720746865206175746F636F6D706C65746520646174612066726F6D20697473206F776E65722E
		Sub Update(maxWidth As Integer, maxHeight As Integer)
		  /// Resizes and redraws this autocomplete popup using the autocomplete data from its owner.
		  ///
		  /// `maxwidth` is the maximum permissable width of the popup.
		  /// `maxHeight` is the maximum permissable height of the popup.
		  
		  mBuffer = Owner.Renderer.ImageForAutocompletePopup(maxWidth, SelectedIndex)
		  
		  Self.Width = Min(mBuffer.Graphics.Width, maxWidth)
		  Self.Height = Min(mBuffer.Graphics.Height, maxHeight)
		  
		  Refresh
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207461672063616E7661732074686174206F776E73207468697320706F7075702E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207665746963616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720646F776E2E204261636B732074686520605363726F6C6C506F73596020636F6D70757465642070726F70657274792E
		Private mScrollPosY As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 302D626173656420696E646578206F66207468652063757272656E746C792073656C6563746564206F7074696F6E20696E2074686520706F7075702E
		Private mSelectedIndex As Integer = -1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207461672063616E7661732074686174206F776E73207468697320706F7075702E
		#tag Getter
			Get
			  If mOwner = Nil Or mOwner.Value = Nil Then
			    Return Nil
			  Else
			    Return XUITagCanvas(mOwner.Value)
			  End If
			  
			End Get
		#tag EndGetter
		Owner As XUITagCanvas
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520766572746963616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720646F776E2E205265667265736865732074686520706F7075702E
		#tag Getter
			Get
			  Return mScrollPosY
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Update how much the canvas is vertically scrolled.
			  
			  // Compute the maximum allowed Y scroll position.
			  Var maxScrollPosY As Integer
			  If mBuffer = Nil Then
			    maxScrollPosY = 0
			    
			  Else
			    maxScrollPosY = Max(mBuffer.Graphics.Height - Self.Height, 0)
			  End If
			  
			  // Set the value of ScrollPosY, not exceeding the maximum value.
			  mScrollPosY = MathsKit.Clamp(value, 0, maxScrollPosY)
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		ScrollPosY As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 302D626173656420696E646578206F66207468652063757272656E746C792073656C6563746564206F7074696F6E20696E2074686520706F7075702E
		#tag Getter
			Get
			  Return mSelectedIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Owner.AutocompleteData = Nil Or Owner.AutocompleteData.Options.Count = 0 Then
			    value = -1
			  Else
			    value = MathsKit.Clamp(value, 0, Owner.AutocompleteData.Options.LastIndex)
			  End If
			  
			  mSelectedIndex = value
			  
			  // Scroll if the selected option is not wholly visible.
			  ScrollToSelectedIndex
			  
			End Set
		#tag EndSetter
		SelectedIndex As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
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
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollPosY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
