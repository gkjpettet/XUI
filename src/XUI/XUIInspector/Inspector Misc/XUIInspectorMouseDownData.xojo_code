#tag Class
Protected Class XUIInspectorMouseDownData
	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E657720604D6F757365446F776E446174616020696E7374616E6365207769746820616E206F7074696F6E616C20706F707570206D656E752E
		Sub Constructor(popupMenu As XUIInspectorItemPopupMenu = Nil)
		  /// Constructs a new `MouseDownData` instance with an optional popup menu.
		  
		  Self.PopupMenu = popupMenu
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents data passed between an inspector item and the inspector after a `MouseDown` event.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520706F707570206D656E752063726561746564206173206120726573756C74206F6620746865206D6F75736520646F776E206576656E742E2057696C6C206265204E696C206966206E6F20706F7075702077617320637265617465642E
		PopupMenu As XUIInspectorItemPopupMenu
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
	#tag EndViewBehavior
End Class
#tag EndClass
