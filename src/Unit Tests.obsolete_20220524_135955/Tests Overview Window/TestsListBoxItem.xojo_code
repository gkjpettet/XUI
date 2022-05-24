#tag Class
Protected Class TestsListBoxItem
	#tag Method, Flags = &h0
		Sub Constructor(testName As String, testWindow As DesktopWindow)
		  Self.Name = testName
		  Self.TestWindow = testWindow
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F207468652077696E646F7720636F6E7461696E696E672074686520746573742073756974652E
		Private mDemoWindow As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520746573742E
		Name As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652077696E646F7720636F6E7461696E696E672074686520746573742073756974652E
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
		TestWindow As DesktopWindow
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
End Class
#tag EndClass
