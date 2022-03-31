#tag Class
Protected Class XUIColorSwatch
Inherits DesktopCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  // If the swatch is already active then do nothing.
		  If mIsActive Then Return False
		  
		  mIsActive = True
		  
		  Refresh
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  If Self.Window = Nil Then Return
		  
		  If Not mColorPickerVisible Then
		    Var cp As New XUIColorPicker(Self.Value)
		    AddHandler cp.ColorChanged, AddressOf PickerColorChanged
		    AddHandler cp.Closing, AddressOf PickerClosing
		    cp.CurrentColor = Self.Value
		    mColorPickerVisible = True
		    cp.ShowModal(Self.Window)
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  If Renderer <> Nil Then Renderer.Render(g)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub PickerClosing(picker As XUIColorPicker)
		  /// Delegate called when this swatch's color picker is closing.
		  
		  #Pragma Unused picker
		  
		  mColorPickerVisible = False
		  mIsActive = False
		  Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C656761746520746861742069732063616C6C6564207768656E207468697320737761746368277320636F6C6F72207069636B6572277320636F6C6F7572206973206368616E6765642E
		Private Sub PickerColorChanged(picker As XUIColorPicker, newColor As Color)
		  /// Delegate that is called when this swatch's color picker's colour is changed.
		  
		  #Pragma Unused picker
		  
		  Self.Value = newColor
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620746865207377617463682069732063757272656E746C79206163746976652028692E652E207072657373656420616E642074686520636F6C6F72207069636B65722069732076697369626C65292E2052656164206F6E6C792E
		#tag Getter
			Get
			  Return mIsActive
			  
			End Get
		#tag EndGetter
		IsActive As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520636F6C6F72207069636B65722069732076697369626C652E
		Private mColorPickerVisible As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865207377617463682069732063757272656E746C79206163746976652028692E652E207072657373656420616E642074686520636F6C6F72207069636B65722069732076697369626C65292E
		Private mIsActive As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320636F6C6F75722073776174636827732072656E64657265722E20526573706F6E7369626C6520666F722061637475616C792064726177696E672074686520636F6E74726F6C2E
		Private mRenderer As XUIColorSwatchRenderer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572206F6620746865207377617463682E
		Private mValue As Color
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468697320636F6C6F75722073776174636827732072656E64657265722E20526573706F6E7369626C6520666F722061637475616C792064726177696E672074686520636F6E74726F6C2E
		#tag Getter
			Get
			  Return mRenderer
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRenderer = value
			  
			  Refresh
			End Set
		#tag EndSetter
		Renderer As XUIColorSwatchRenderer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865207377617463682E
		#tag Getter
			Get
			  Return mValue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mValue = value
			  
			  Refresh
			End Set
		#tag EndSetter
		Value As Color
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
			Name="Value"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
