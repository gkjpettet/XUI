#tag Class
Protected Class XUIInspectorMouseUpData
	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E6577204D6F75736555704461746120696E7374616E63652073706563696679696E67207768657468657220612076697375616C206368616E676520686173206F6363757265642E
		Sub Constructor(visualChange As Boolean)
		  /// Constructs a new MouseUpData instance specifying whether a visual change has occured.
		  
		  Self.VisualChange = visualChange
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E6577204D6F75736555704461746120696E7374616E63652073706563696679696E67207768657468657220612076697375616C206368616E676520686173206F63637572656420616E642077697468206120706F707570206D656E752E
		Sub Constructor(visualChange As Boolean, popupMenu As XUIInspectorItemPopupMenu)
		  /// Constructs a new MouseUpData instance specifying whether a visual change has occured and with a popup menu.
		  
		  Self.VisualChange = visualChange
		  Self.PopupMenu = popupMenu
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents data passed between an inspector item and the inspector after a `MouseUp` event.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520706F707570206D656E752063726561746564206173206120726573756C74206F6620746865206D6F757365207570206576656E742E2057696C6C206265204E696C206966206E6F20706F7075702077617320637265617465642E
		PopupMenu As XUIInspectorItemPopupMenu
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E20612076697375616C206368616E6765206F6363757272656420696E207468652073656374696F6E206F72206974656D20636C69636B65642E
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
