#tag Class
Protected Class XUIImageButton
Inherits DesktopCanvas
	#tag Event
		Sub FocusLost()
		  mMouseOverButton = False
		  
		  If Type = Types.PushButton Then mIsPressed = False
		  
		  Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  mMouseOverButton = True
		  
		  If Type = Types.PushButton Then
		    mIsPressed = True
		  Else
		    mIsPressed = Not mIsPressed
		  End If
		  
		  Refresh
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  mMouseOverButton = False
		  
		  If Type = Types.PushButton Then mIsPressed = False
		  
		  Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(x As Integer, y As Integer)
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  mMouseOverButton = True
		  
		  Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  If Type = Types.PushButton Then mIsPressed = False
		  
		  If mMouseOverButton Then RaiseEvent Pressed
		  
		  Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  Var p As Picture = GetCorrectPicture
		  
		  If p <> Nil Then
		    g.DrawPicture(p, (Me.Width / 2) - (p.Width / 2), (Me.Height / 2) - (p.Height / 2))
		  End If
		  
		  // Border?
		  If HasBorder And mBorderColor <> Nil Then
		    g.DrawingColor = mBorderColor
		    g.DrawRectangle(0, 0, g.Width, g.Height)
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ScaleFactorChanged()
		  Refresh
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, Description = 52657475726E732074686520636F7272656374207069637475726520746F2075736520666F722074686520627574746F6E27732063757272656E742073746174652E
		Private Function GetCorrectPicture() As Picture
		  /// Returns the correct picture to use for the button's current state.
		  
		  Select Case Me.Type
		  Case Types.ToggleButton
		    If Not Me.Enabled Then
		      // Disabled.
		      If mDisabledImage = Nil Then
		        Return mDefaultImage
		      Else
		        Return mDisabledImage
		      End If
		      
		    ElseIf mMouseOverButton Then
		      // Hovering.
		      If mHoverImage = Nil Then
		        If mIsPressed And mPressedImage <> Nil Then
		          Return mPressedImage
		        Else
		          Return mDefaultImage
		        End If
		      Else
		        Return mHoverImage
		      End If
		      
		    ElseIf mIsPressed Then
		      // Pressed.
		      If mPressedImage = Nil Then
		        Return mDefaultImage
		      Else
		        Return mPressedImage
		      End If
		      
		    Else
		      Return mDefaultImage
		    End If
		    
		  Case Types.PushButton
		    If Not Me.Enabled Then
		      // Disabled.
		      If mDisabledImage = Nil Then
		        Return mDefaultImage
		      Else
		        Return mDisabledImage
		      End If
		      
		    ElseIf mIsPressed Then
		      // Pressed.
		      If mPressedImage = Nil Then
		        Return mDefaultImage
		      Else
		        Return mPressedImage
		      End If
		      
		    ElseIf mMouseOverButton Then
		      // Hovering.
		      If mHoverImage = Nil Then
		        Return mDefaultImage
		      Else
		        Return mHoverImage
		      End If
		      
		    Else
		      Return mDefaultImage
		    End If
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown button type.")
		  End Select
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 54686520627574746F6E20686173206265656E20707265737365642E
		Event Pressed()
	#tag EndHook


	#tag Note, Name = About
		A simple canvas-based button. You must ensure that the images selected for this button are the same size
		as the button as no scaling of the image is performed.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 49662074686520627574746F6E20686173206120626F726465722C20746869732069732069747320636F6C6F75722E
		#tag Getter
			Get
			  Return mBorderColor
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mBorderColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		BorderColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696D61676520746F2075736520666F722074686520627574746F6E207768656E20696E206974732064656661756C742073746174652E
		#tag Getter
			Get
			  Return mDefaultImage
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDefaultImage = value
			  
			  Refresh
			End Set
		#tag EndSetter
		DefaultImage As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696D61676520746F2075736520666F722074686520627574746F6E207768656E2064697361626C65642E204966206E6F74207370656369666965642C207468652064656661756C7420696D61676520697320757365642E
		#tag Getter
			Get
			  Return mDisabledImage
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDisabledImage = value
			  
			  Refresh
			End Set
		#tag EndSetter
		DisabledImage As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E206120626F7264657220697320647261776E2061726F756E642074686520627574746F6E2E
		#tag Getter
			Get
			  Return mHasBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasBorder = value
			  
			  Refresh
			End Set
		#tag EndSetter
		HasBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696D61676520746F2075736520666F722074686520627574746F6E207768656E20746865206D6F75736520697320686F766572696E67206F7665722069742E204966206E6F74207370656369666965642C207468652064656661756C7420696D61676520697320757365642E
		#tag Getter
			Get
			  Return mHoverImage
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHoverImage = value
			  
			  Refresh
			End Set
		#tag EndSetter
		HoverImage As Picture
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 49662074686520627574746F6E20686173206120626F726465722C20746869732069732069747320636F6C6F75722E
		Private mBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696D61676520746F2075736520666F722074686520627574746F6E207768656E20696E206974732064656661756C742073746174652E
		Private mDefaultImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696D61676520746F2075736520666F722074686520627574746F6E207768656E2064697361626C65642E204966206E6F74207370656369666965642C207468652064656661756C7420696D61676520697320757365642E
		Private mDisabledImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E206120626F7264657220697320647261776E2061726F756E642074686520627574746F6E2E
		Private mHasBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696D61676520746F2075736520666F722074686520627574746F6E207768656E20746865206D6F75736520697320686F766572696E67206F7665722069742E204966206E6F74207370656369666965642C207468652064656661756C7420696D61676520697320757365642E
		Private mHoverImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520627574746F6E2069732063757272656E746C79206265696E6720707265737365642E
		Private mIsPressed As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206D6F757365206973206F7665722074686520627574746F6E2E
		Private mMouseOverButton As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696D61676520746F2075736520666F722074686520627574746F6E207768656E20696E2069747320707265737365642073746174652E204966206E6F74207370656369666965642C207468652064656661756C7420696D61676520697320757365642E
		Private mPressedImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652074797065206F6620627574746F6E202870757368206F7220746F67676C65292E
		Private mType As XUIImageButton.Types = XUIImageButton.Types.PushButton
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696D61676520746F2075736520666F722074686520627574746F6E207768656E20696E2069747320707265737365642073746174652E204966206E6F74207370656369666965642C207468652064656661756C7420696D61676520697320757365642E
		#tag Getter
			Get
			  Return mPressedImage
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mPressedImage = value
			  
			  Refresh
			End Set
		#tag EndSetter
		PressedImage As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652074797065206F6620627574746F6E202870757368206F7220746F67676C65292E
		#tag Getter
			Get
			  Return mType
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mType = value
			  
			  mIsPressed = False
			  
			  Refresh
			End Set
		#tag EndSetter
		Type As XUIImageButton.Types
	#tag EndComputedProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		PushButton
		ToggleButton
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
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
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
			Name="HasBorder"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderColor"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultImage"
			Visible=true
			Group="Images"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisabledImage"
			Visible=true
			Group="Images"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverImage"
			Visible=true
			Group="Images"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PressedImage"
			Visible=true
			Group="Images"
			InitialValue=""
			Type="Picture"
			EditorType=""
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
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="XUIImageButton.Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - PushButton"
				"1 - ToggleButton"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
