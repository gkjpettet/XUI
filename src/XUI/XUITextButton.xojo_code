#tag Class
Protected Class XUITextButton
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
		  
		  // Background?
		  If HasBackgroundColor Then
		    g.DrawingColor = BackgroundColor
		    g.FillRectangle(0, 0, g.Width, g.Height)
		  End If
		  
		  // Selected lozenge?
		  If mIsPressed Then
		    g.DrawingColor = PressedColor
		    g.FillRoundRectangle(0, 0, g.Width, g.Height, 5, 5)
		  End If
		  
		  // Title.
		  g.DrawingColor = If(mIsPressed, PressedTextColor, TextColor)
		  g.FontName = FontName
		  g.FontSize = FontSize
		  Var baseline As Double = (g.FontAscent + (g.Height - g.TextHeight)/2)
		  g.DrawText(Title, (g.Width / 2) - (g.TextWidth(Title) / 2), baseline)
		End Sub
	#tag EndEvent

	#tag Event
		Sub ScaleFactorChanged()
		  Refresh
		  
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0, Description = 54686520627574746F6E20686173206265656E20707265737365642E
		Event Pressed()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865206261636B67726F756E642028696620656E61626C6564292E
		#tag Getter
			Get
			  Return mBackgroundColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mBackgroundColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		BackgroundColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520666F6E742066616D696C7920746F207573652E
		#tag Getter
			Get
			  Return mFontName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFontName = value
			  
			  Refresh
			End Set
		#tag EndSetter
		FontName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520666F6E742073697A6520746F207573652E
		#tag Getter
			Get
			  Return mFontSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFontSize = value
			  
			  Refresh
			End Set
		#tag EndSetter
		FontSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686520627574746F6E206861732061206261636B67726F756E6420636F6C6F75722E
		#tag Getter
			Get
			  Return mHasBackgroundColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasBackgroundColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		HasBackgroundColor As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686520627574746F6E2069732063757272656E746C792070726573736564206F7220746F67676C65642E
		#tag Getter
			Get
			  Return mIsPressed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mIsPressed = value
			  
			  Refresh
			End Set
		#tag EndSetter
		IsPressed As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572206F6620746865206261636B67726F756E642028696620656E61626C6564292E
		Private mBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520666F6E742066616D696C7920746F207573652E
		Private mFontName As String = "System"
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520666F6E742073697A6520746F207573652E
		Private mFontSize As Integer = 12
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520627574746F6E206861732061206261636B67726F756E6420636F6C6F75722E
		Private mHasBackgroundColor As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520627574746F6E2069732063757272656E746C792070726573736564206F7220746F67676C65642E
		Private mIsPressed As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206D6F757365206973206F7665722074686520627574746F6E2E
		Private mMouseOverButton As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572206F66207468652073656C656374696F6E206C6F7A656E6765207768656E2074686520627574746F6E20697320707265737365642E
		Private mPressedColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572206F66207468652074657874207768656E2074686520627574746F6E20697320707265737365642E
		Private mPressedTextColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207465787420636F6C6F75722E
		Private mTextColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520627574746F6E2773207469746C652E
		Private mTitle As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652074797065206F6620627574746F6E202870757368206F7220746F67676C65292E
		Private mType As XUITextButton.Types = XUITextButton.Types.PushButton
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572206F66207468652073656C656374696F6E206C6F7A656E6765207768656E2074686520627574746F6E20697320707265737365642E
		#tag Getter
			Get
			  Return mPressedColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mPressedColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		PressedColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572206F66207468652074657874207768656E2074686520627574746F6E20697320707265737365642E
		#tag Getter
			Get
			  Return mPressedTextColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mPressedTextColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		PressedTextColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207465787420636F6C6F75722E
		#tag Getter
			Get
			  Return mTextColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mTextColor = value
			  
			  Refresh
			End Set
		#tag EndSetter
		TextColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520627574746F6E2773207469746C652E
		#tag Getter
			Get
			  Return mTitle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mTitle = value
			  
			  Refresh
			End Set
		#tag EndSetter
		Title As String
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
		Type As XUITextButton.Types
	#tag EndComputedProperty


	#tag Enum, Name = Types, Flags = &h0
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
			InitialValue="22"
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
			Name="Title"
			Visible=true
			Group="Behavior"
			InitialValue="Button"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="XUITextButton.Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - PushButton"
				"1 - ToggleButton"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsPressed"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c6D6D6D"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackgroundColor"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Behavior"
			InitialValue="&cFFFFFF"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PressedTextColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c313131"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PressedColor"
			Visible=true
			Group="Behavior"
			InitialValue="&cD0D0D0"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Behavior"
			InitialValue="System"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Behavior"
			InitialValue="12"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
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
	#tag EndViewBehavior
End Class
#tag EndClass
