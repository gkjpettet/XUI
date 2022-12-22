#tag Interface
Protected Interface XUIInspectorItemWithMultipleTabFocusControls
	#tag Method, Flags = &h0, Description = 52657475726E732054727565206966207072657373696E672074686520746162206B65792073686F756C64206D6F76652074686520666F63757320746F20616E6F7468657220636F6E74726F6C2077697468696E2074686973206974656D2E
		Function CanAcceptAnotherTabFocus() As Boolean
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Items implementing this interface contain more than one control that can accept the focus via the tab key.
		
	#tag EndNote


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
	#tag EndViewBehavior
End Interface
#tag EndInterface
