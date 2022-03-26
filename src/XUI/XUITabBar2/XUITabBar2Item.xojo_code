#tag Class
Protected Class XUITabBar2Item
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITabBar2, caption As String, icon As Picture = Nil, tag As Variant = Nil, closable As Boolean = True, enabled As Boolean = True)
		  If owner = Nil Then
		    Raise New InvalidArgumentException("Tab bar items must have a non-Nil owner.")
		  End If
		  
		  Self.Owner = owner
		  Self.Caption = caption
		  Self.Icon = icon
		  Self.Tag = tag
		  Self.Closable = closable
		  Self.Enabled = enabled
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468697320746162277320626F756E64732E205468657920617265206C6F63616C20746F207468652072656E64657265722773206275666665722E
		Bounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652074616227732063617074696F6E202876697369626C652074657874292E
		Caption As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686973207461622063616E20626520636C6F73656420627920746865207573657220627920636C69636B696E67206F6E2074686520636C6F73652069636F6E2E
		Closable As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320746162277320636C6F73652069636F6E20626F756E64732E205468657920617265206C6F63616C20746F207468652072656E64657265722773206275666665722E204D6179206265204E696C2E
		CloseIconBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5472756520696620746869732074616220697320656E61626C65642E
		Enabled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2069636F6E2E
		Icon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520746162206261722074686174206F776E732074686973207461622E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520746162206261722074686174206F776E732074686973207461622E
		#tag Getter
			Get
			  If mOwner = Nil Or mOwner.Value = Nil Then
			    Return Nil
			  Else
			    Return XUITabBar2(mOwner.Value)
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
		Owner As XUITabBar2
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206172626974726172792064617461206173736F63696174656420776974682074686973207461622E
		Tag As Variant
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
			Name="Caption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Closable"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
