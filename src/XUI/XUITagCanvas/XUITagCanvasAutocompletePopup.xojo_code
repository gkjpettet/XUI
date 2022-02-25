#tag Class
Protected Class XUITagCanvasAutocompletePopup
Inherits DesktopTextInputCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As Xojo.Rect)
		  #Pragma Unused areas
		  
		  #Pragma Warning "TODO"
		  
		  If Owner.AutocompleteData = Nil Then Return
		  
		  g.DrawingColor = Color.Red
		  g.FillRectangle(0, 0, Self.Width, Self.Height)
		  g.DrawingColor = Color.Blue
		  g.DrawRectangle(0, 0, Self.Width, Self.Height)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITagCanvas)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  mOwner = New WeakRef(owner)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526573697A657320616E6420726564726177732074686973206175746F636F6D706C65746520706F707570207573696E6720746865206175746F636F6D706C65746520646174612066726F6D20697473206F776E65722E
		Sub Update(maxHeight As Integer)
		  /// Resizes and redraws this autocomplete popup using the autocomplete data from its owner.
		  ///
		  /// `maxHeight` is the maximum permissable height of the popup.
		  
		  #Pragma Warning "TODO"
		  
		  Const LINE_HEIGHT = 22
		  
		  Self.Width = 120
		  Self.Height = Min(LINE_HEIGHT * Owner.AutocompleteData.Options.Count, maxHeight)
		  
		  Refresh
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 546865207461672063616E7661732074686174206F776E73207468697320706F7075702E
		Private mOwner As WeakRef
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

	#tag Property, Flags = &h0, Description = 302D626173656420696E646578206F66207468652063757272656E746C792073656C6563746564206F7074696F6E20696E2074686520706F7075702E
		SelectedIndex As Integer = -1
	#tag EndProperty


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
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
