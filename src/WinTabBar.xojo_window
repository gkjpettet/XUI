#tag DesktopWindow
Begin DesktopWindow WinTabBar
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   636
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   583317503
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "TabBar Testing"
   Type            =   0
   Visible         =   True
   Width           =   1000
   Begin XUITabBar TabBar
      AllowAutoDeactivate=   True
      AllowDragReordering=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Count           =   0
      Enabled         =   True
      HasAnchoredFirstTab=   False
      HasLeftBorder   =   False
      HasRightBorder  =   False
      Height          =   28
      Index           =   -2147483648
      IsHoveringOverTab=   False
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MinimumTabWidth =   200.0
      Scope           =   0
      SelectedTabIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1000
   End
   Begin DesktopListBox MessagesListbox
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DefaultRowHeight=   -1
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   283
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   333
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   960
      _ScrollWidth    =   -1
   End
   Begin DesktopCanvas Canvas1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   261
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   28
      Transparent     =   True
      Visible         =   True
      Width           =   1000
   End
   Begin DesktopPopupMenu PopupTheme
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   772
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   301
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   208
   End
   Begin DesktopLabel LabelTheme
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   660
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Theme:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   301
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub MenuBarSelected()
		  If TabBar.Count > 0 Then
		    FileCloseTab.Enabled = True
		  Else
		    FileCloseTab.Enabled = False
		  End If
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileCloseTab() As Boolean Handles FileCloseTab.Action
			// Close the currently selected tab.
			If TabBar.SelectedTabIndex <> - 1 Then
			TabBar.RemoveTabAt(TabBar.SelectedTabIndex)
			End If
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21, Description = 4563686F7320606D6573736167656020746F20746865206D65737361676573206C697374626F782E
		Private Sub Echo(message As String)
		  /// Echos `message` to the messages listbox.
		  
		  MessagesListbox.AddRow(message)
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events TabBar
	#tag Event
		Sub Opening()
		  Var style As New XUITabBarStyle
		  style.TabBorderColor = Color.FromString("&h00C8C8C8")
		  
		  style.ActiveTabBackgroundColor = Color.White
		  style.ActiveTabBorderColor = Color.Purple
		  style.ActiveTabHasThickTopBorder = True
		  style.ActiveTabTextColor = Color.FromString("&h002B2C2C")
		  
		  style.InactiveTabBackgroundColor = Color.FromString("&h00ECECEC")
		  style.InactiveTabTextColor = Color.FromString("&h002B2C2C")
		  
		  style.DisabledTabBackgroundColor = Color.Gray
		  style.DisabledTabTextColor = Color.FromString("&h002B2C2C")
		  
		  style.HoverTabBackgroundColor = Color.FromString("&h00ECECEC")
		  style.HoverTabTextColor = Color.FromString("&h002B2C2C")
		  
		  style.TabCloseColor = Color.FromString("&h006D7070")
		  style.HoverTabCloseColor = Color.FromString("&h002B2C2C")
		  
		  Me.Style = style
		  
		  Me.AppendTab("Tab 1")
		  Me.AppendTab("Tab 2")
		  Me.AppendTab("Tab 3")
		  Me.AppendTab("Tab 4")
		  Me.AppendTab("Tab 5")
		  Me.AppendTab("Tab 6")
		  
		  Me.SelectTabAtIndex(1)
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 412074616220776173206A75737420616464656420746F2074686520746162206261722061742060696E646578602E
		Sub DidAddTab(tab As XUITabBarItem, index As Integer)
		  Echo("Added tab with caption `" + tab.Caption + "` at index " + index.ToString)
		End Sub
	#tag EndEvent
	#tag Event , Description = 546865207573657220636F6E7465787574616C20636C69636B65642028726967687420636C69636B65642920696E736964652074686520746162206261722061742074686520706173736564206C6F63616C20636F6F7264696E617465732E
		Sub DidContextualClick(x As Integer, y As Integer)
		  Echo("Contextual clicked at " + x.ToString + ", " + y.ToString)
		End Sub
	#tag EndEvent
	#tag Event , Description = 412074616220686173206A757374206265656E2072656D6F7665642066726F6D2074686520746162206261722E
		Sub DidRemoveTab(tab As XUITabBarItem)
		  Echo("Removed tab with caption `" + tab.Caption + "`")
		End Sub
	#tag EndEvent
	#tag Event , Description = 54686520746162206174207468652073706563696669656420696E64657820776173206A7573742073656C65637465642E
		Sub DidSelectTab(tab As XUITabBarItem, index As Integer)
		  Echo("Selected tab with caption `" + tab.Caption + "` at index " + index.ToString)
		End Sub
	#tag EndEvent
	#tag Event , Description = 5468652075736572206A75737420626567616E206472616767696E67206074616260202877686963682068617320612063757272656E7420696E646578206F662060696E64657860292E
		Sub DidStartDragging(tab As XUITabBarItem, index As Integer)
		  Echo("Began dragging tab with caption `" + tab.Caption + "` at index " + index.ToString)
		End Sub
	#tag EndEvent
	#tag Event , Description = 5468652075736572206A7573742066696E6973686564206472616767696E67206074616260202877686963682068617320612063757272656E7420696E646578206F662060696E64657860292E
		Sub DidFinishDragging(tab As XUITabBarItem, index As Integer)
		  Echo("Finished dragging tab with caption `" + tab.Caption + "` at index " + index.ToString)
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
