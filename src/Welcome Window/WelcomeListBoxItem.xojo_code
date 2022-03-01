#tag Class
Protected Class WelcomeListBoxItem
	#tag Method, Flags = &h0
		Sub Constructor(productName As String, description As String, demoWindow As DesktopWindow)
		  Self.Name = productName
		  Self.Description = description
		  Self.DemoWindow = demoWindow
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 5468652077696E646F7720636F6E7461696E696E67207468652064656D6F206F66207468652070726F647563742E
		#tag Getter
			Get
			  If mDemoWindow = Nil Or mDemoWindow.Value = Nil Then
			    Return Nil
			  Else
			    Return DesktopWindow(mDemoWindow.Value)
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value = Nil Then
			    mDemoWindow = Nil
			  Else
			    mDemoWindow = New WeakRef(value)
			  End If
			End Set
		#tag EndSetter
		DemoWindow As DesktopWindow
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 41206465736372697074696F6E206F66207468652070726F647563742E
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F207468652077696E646F7720636F6E7461696E696E67207468652064656D6F206F66207468652070726F647563742E
		Private mDemoWindow As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F66207468652070726F647563742E
		Name As String
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
			Name="mDemoWindow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
