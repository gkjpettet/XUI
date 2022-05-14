#tag Class
Protected Class XUIApp
Inherits DesktopApplication
Implements XUINotificationListener
	#tag Event
		Sub AppearanceChanged()
		  // Notify listeners that the appearance has changed.
		  XUINotificationCenter.Send(Self, NOTIFICATION_APPEARANCE_CHANGED)
		  
		  RaiseEvent AppearanceChanged
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  mSemanticVersion = New XUISemanticVersion(MajorVersion, MinorVersion, BugVersion)
		  
		  RaiseEvent Opening
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub NotificationReceived(n As XUINotification)
		  /// Part of the XUINotificationListener interface.
		  
		  RaiseEvent NotificationReceived(n)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 43616C6C6564207768656E20612075736572207377697463686573206265747765656E206C6967687420616E64206461726B206D6F6465206F72207768656E2074686520616363656E7420636F6C6F72206368616E6765732E
		Event AppearanceChanged()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520617070206861732072656365697665642061206E6F74696669636174696F6E2E
		Event NotificationReceived(n As XUINotification)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520617070206973206F70656E696E672E200A54686520604F70656E696E6760206576656E7420697320746865206669727374206576656E742063616C6C6564207768656E20796F757220617070207374617274732E0A546865206041637469766174656460206576656E742069732063616C6C65642061667465722074686520604F70656E696E6760206576656E742E
		Event Opening()
	#tag EndHook


	#tag Note, Name = About
		This is a drop in replacement for the standard `DesktopApplication` object in your project. For maximum
		utility you should change the subclass of your `App` object in the Xojo navigator to `XUIApp`. The class adds 
		a number of convenience features such as in-app notifications when the OS appearance changes.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F72206053656D616E74696356657273696F6E602E
		Private mSemanticVersion As XUISemanticVersion
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206170706C69636174696F6E27732076657273696F6E2E
		#tag Getter
			Get
			  Return mSemanticVersion
			End Get
		#tag EndGetter
		SemanticVersion As XUISemanticVersion
	#tag EndComputedProperty


	#tag Constant, Name = NOTIFICATION_APPEARANCE_CHANGED, Type = String, Dynamic = False, Default = \"App.AppearanceChanged", Scope = Public, Description = 546865204F5320686173207377697463686564206265747765656E206C6967687420616E64206461726B206D6F6465206F722074686520616363656E7420636F6C6F757220686173206368616E6765642E
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
