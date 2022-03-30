#tag Class
Protected Class XUIRGBAComponentSlider
Inherits DesktopCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  // Draw the slider.
		  g.DrawingColor = Color.Red
		  g.DrawRoundRectangle(0, 0, g.Width, g.Height, g.Height, g.Height)
		  
		  // Draw the scrubber.
		  g.DrawingColor = ScrubberColor
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		  ScrubberColor = New ColorGroup(Color.White, Color.White)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6D706C65746520636F6C6F75722074686174207468697320636F6D706F6E656E7420726570726573656E74732070617274206F662E
		#tag Getter
			Get
			  Return mCompleteColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCompleteColor = value
			  Refresh
			End Set
		#tag EndSetter
		CompleteColor As Color
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ComponentType As XUIRGBAComponentSlider.ComponentTypes = XUIRGBAComponentSlider.ComponentTypes.Red
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652076616C7565206F66207468697320636F6D706F6E656E742E
		#tag Getter
			Get
			  Return mComponentValue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mComponentValue = value
			  Refresh
			  
			End Set
		#tag EndSetter
		ComponentValue As Byte
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 54686520636F6D706C65746520636F6C6F75722074686174207468697320636F6D706F6E656E7420726570726573656E74732070617274206F662E
		Private mCompleteColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652076616C7565206F66207468697320636F6D706F6E656E742E
		Private mComponentValue As Byte = 255
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ScrubberColor As ColorGroup
	#tag EndProperty


	#tag Enum, Name = ComponentTypes, Type = Integer, Flags = &h0
		Alpha
		  Blue
		  Green
		Red
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
			InitialValue="200"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="16"
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
			Name="ComponentType"
			Visible=true
			Group="Behavior"
			InitialValue="XUIColorComponentSlider.Types.Red"
			Type="XUIRGBAComponentSlider.ComponentTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Alpha"
				"1 - Blue"
				"2 - Green"
				"3 - Red"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CompleteColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ComponentValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Byte"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
