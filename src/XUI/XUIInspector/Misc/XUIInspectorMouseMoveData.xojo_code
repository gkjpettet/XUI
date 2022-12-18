#tag Class
Protected Class XUIInspectorMouseMoveData
	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E657720604D6F7573654D6F7665446174616020696E7374616E6365206F776E656420627920606F776E65726020616E642073706563696679696E6720696620612076697375616C206368616E6765206F63637572726564206F72206E6F742E
		Sub Constructor(owner As XUIInspectorItem, visualChange As Boolean)
		  /// Constructs a new `MouseMoveData` instance owned by `owner` and specifying if a visual change occurred or not.
		  
		  Self.Owner = owner
		  Self.VisualChange = visualChange
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents data passed between an inspector item and the inspector after a `MouseMove` event.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F20746865206974656D2061666665637465642062792074686973206D6F757365206D6F76652E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207765616B207265666572656E636520746F20746865206974656D2061666665637465642062792074686973206D6F757365206D6F76652E
		#tag Getter
			Get
			  If mOwner = Nil Or mOwner.Value = Nil Then
			    Return Nil
			  Else
			    Return XUIInspectorItem(mOwner.Value)
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value = Nil Then
			    mOwner = Nil
			  Else
			    mOwner = New WeakRef(value)
			  End If
			  
			End Set
		#tag EndSetter
		Owner As XUIInspectorItem
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E20612076697375616C206368616E6765206F6363757272656420696E207468652073656374696F6E206F72206974656D20746865206D6F757365206D6F766564206F7665722E
		VisualChange As Boolean = False
	#tag EndProperty


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
			Name="VisualChange"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
