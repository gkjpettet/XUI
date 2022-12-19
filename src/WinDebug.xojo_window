#tag DesktopWindow
Begin DemoWindow WinDebug Implements XUINotificationListener
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   616
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1647693823
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Debug Window"
   Type            =   0
   Visible         =   False
   Width           =   822
   Begin XUIInspector Inspector
      AllowInertialScrolling=   True
      AutoDeactivate  =   True
      CaretVisible    =   False
      Enabled         =   True
      HasBottomBorder =   True
      HasLeftBorder   =   True
      HasRightBorder  =   True
      HasTopBorder    =   True
      Height          =   576
      Index           =   -2147483648
      InitialParent   =   ""
      LastClickWasContextual=   False
      LastMouseDownX  =   0
      LastMouseDownY  =   0
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollOffsetY   =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Visible         =   True
      Width           =   300
   End
   Begin DesktopListBox NotificationsListbox
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   ""
      DefaultRowHeight=   -1
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   544
      Index           =   -2147483648
      InitialValue    =   "ID	Data"
      Italic          =   False
      Left            =   332
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   470
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopLabel Label1
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   332
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Notifications"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin DesktopButton ButtonClearNotifications
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Clear"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   722
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  // Create a demo inspector.
		  
		  Const CAPTION_WIDTH = 120
		  
		  // We want this window to be notified of changes that occur in the inspector.
		  RegisterForNotifications
		  
		  // ===================
		  // FRAME SECTION
		  // ===================
		  Var frameSection As New XUIInspectorSection("Frame", True)
		  Inspector.AddSection(frameSection)
		  
		  // Type.
		  frameSection.AddItem(New XUIInspectorPopupItem("frame.type", "Type", CAPTION_WIDTH, Array("Document", "Movable Modal", "Modal Dialog")))
		  
		  // Title.
		  frameSection.AddItem(New XUIInspectorTextFieldItem("frame.title", "Title", CAPTION_WIDTH, "Enter a title"))
		  
		  // Resizeable.
		  frameSection.AddItem(New XUIInspectorSwitchItem("frame.resizeable", "Resizeable", CAPTION_WIDTH, True))
		  
		  // ===================
		  // MISC SECTION
		  // ===================
		  Var miscSection As New XUIInspectorSection("Misc", True)
		  Inspector.AddSection(miscSection)
		  
		  // Has background colour.
		  miscSection.AddItem(New XUIInspectorSwitchItem("misc.hasBackground", "Has Background", CAPTION_WIDTH, False))
		  
		  // Colour item.
		  miscSection.AddItem(New XUIInspectorColorItem("misc.backgroundColor", "Background Colour", CAPTION_WIDTH, Color.Red))
		  
		  // Position dual text field.
		  miscSection.AddItem(New XUIInspectorDualTextFieldItem("misc.position", "Position", CAPTION_WIDTH, "X", "Y", "X placeholder", "Y placeholder"))
		  
		  // Full screen checkbox.
		  miscSection.AddItem(New XUIInspectorCheckBoxItem("misc.fullScreen", "Full Screen", CAPTION_WIDTH, False))
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileCloseWindow() As Boolean Handles FileCloseWindow.Action
		  Self.Hide
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F7220646973706C6179696E672074686520636F6E74656E7473206F6620612064696374696F6E617279206173206120737472696E672E2055736564206F6E6C7920666F722064656D6F20707572706F73657320746F2073696D706C69667920646973706C6179696E6720746865206E6F74696669636174696F6E207061796C6F61642066726F6D206974656D7320746861742073656E6420612064696374696F6E6172792E
		Private Function DictionaryToString(d As Dictionary) As String
		  /// Convenience method for displaying the contents of a dictionary as a string.
		  /// Used only for demo purposes to simplify displaying the notification payload from items
		  /// that send a dictionary in the listbox on this window.
		  
		  If d = Nil Then Return ""
		  
		  Var s() As String
		  For Each entry As DictionaryEntry In d
		    Var value As String = entry.Value.StringValue
		    If value.Length = 0 Then value = """"""
		    s.Add(entry.Key.StringValue + " : " + value)
		  Next entry
		  
		  Return String.FromArray(s, ", ")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationReceived(n As XUINotification)
		  /// Part of the XUINotificationListener interface.
		  
		  Select Case n.Key
		  Case XUIInspector.NOTIFICATION_ITEM_CHANGED
		    // One of the items in the inspector has changed.
		    Var item As XUIInspectorItem = XUIInspectorItem(n.Sender)
		    Var data As String
		    If item IsA XUIInspectorDualTextFieldItem Then
		      data = DictionaryToString(n.Data)
		    Else
		      data = n.Data.StringValue
		    End If
		    NotificationsListbox.AddRow(item.ID, data)
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656769737465727320746869732077696E646F7720666F722064657369726564206E6F74696669636174696F6E732E
		Private Sub RegisterForNotifications()
		  /// Registers this window for desired notifications.
		  
		  Self.ListenForKey(XUIInspector.NOTIFICATION_ITEM_CHANGED)
		  
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events ButtonClearNotifications
	#tag Event
		Sub Pressed()
		  NotificationsListbox.RemoveAllRows
		  
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Windows Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
