#tag Class
Protected Class XUISourceListItem
	#tag Method, Flags = &h0
		Sub Constructor(parent As XUISourceListItem, title As String, icon As Picture = Nil, data As Variant = Nil)
		  Self.Parent = parent
		  Self.Title = title
		  Self.Icon = icon
		  Self.Data = data
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 547275652069662074686973206974656D2063616E20626520636F6C6C61707365642028692E652E20697473206368696C6472656E2062652068696464656E292E
		Collapsible As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4172626974726172792064617461206173736F63696174656420776974682074686973206974656D2E
		Data As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 486F77206465657020696E2074686520736F75726365206C6973742074686973206974656D2069732E2053656374696F6E7320686176652061206465707468206F66207A65726F2E
		#tag Getter
			Get
			  Var item As XUISourceListItem = Parent
			  Var myDepth As Integer = 0
			  While item <> Nil
			    item = item.Parent
			    myDepth = myDepth + 1
			  Wend
			  
			  Return myDepth
			  
			End Get
		#tag EndGetter
		Depth As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686973206974656D27732069636F6E2E204D6179206F72206D6179206E6F742062652076697369626C6520646570656E64696E67206F6E207468652072656E646572657220757365642E
		Icon As Picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686973206974656D20697320612073656374696F6E202872656164206F6E6C79292E
		#tag Getter
			Get
			  // Section's don't have parents (they are children of the root).
			  
			  Return Parent = Nil
			End Get
		#tag EndGetter
		IsSection As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mChildren() As XUISourceListItem
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F20746865206F776E696E6720736F75726365206C6973742E204D6179206265204E696C20696620746865206974656D2077617320637265617465642070726F6772616D6D61746963616C6C792E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5765616B207265666572656E636520746F2074686973206974656D277320706172656E742E2057696C6C206265204E696C2069662074686973206974656D20697320612073656374696F6E2E
		Private mParent As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F776E696E6720736F75726365206C6973742E204D6179206265204E696C20696620746865206974656D2077617320637265617465642070726F6772616D6D61746963616C6C792E
		#tag Getter
			Get
			  If mOwner = Nil Or mOwner.Value = Nil Then
			    Return Nil
			  Else
			    Return XUISourceList(mOwner.Value)
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
		Owner As XUISourceList
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206974656D277320706172656E74206F72204E696C206966206974277320612073656374696F6E2E
		#tag Getter
			Get
			  If mParent = Nil Or mParent.Value = Nil Then
			    Return Nil
			  Else
			    Return XUISourceListItem(mParent.Value)
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value = Nil Then
			    mParent = Nil
			  Else
			    mParent = New WeakRef(value)
			  End If
			  
			End Set
		#tag EndSetter
		Parent As XUISourceListItem
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865206974656D2773207469746C652E
		Title As String
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
			Name="Title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsSection"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Collapsible"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Depth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
