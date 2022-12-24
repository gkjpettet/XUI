#tag DesktopWindow
Begin DemoWindow WinTabBar
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
   MenuBar         =   1647693823
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "TabBar Demo"
   Type            =   0
   Visible         =   False
   Width           =   1000
   Begin XUITabBar TabBar
      AllowAutoDeactivate=   True
      AllowDragReordering=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AvailableTabSpace=   0.0
      Backdrop        =   0
      DraggingTabLeftEdgeXOffset=   0
      Enabled         =   True
      FirstTabIsFixed =   False
      HasLeftBorder   =   False
      HasLeftMenuButton=   False
      HasRightBorder  =   False
      HasRightMenuButton=   False
      Height          =   28
      Index           =   -2147483648
      IsDraggingTab   =   False
      Left            =   0
      LeftMenuButtonIcon=   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MouseDragX      =   0
      MouseDragY      =   0
      MouseMoveX      =   0
      MouseMoveY      =   0
      RightMenuButtonIcon=   0
      Scope           =   0
      ScrollPosX      =   0
      SelectedTabIndex=   0
      TabCount        =   0
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
      Height          =   284
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
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
      Top             =   300
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   960
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopPopupMenu PopupRenderer
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
      Left            =   132
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   70
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   219
   End
   Begin DesktopLabel LabelRenderer
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Renderer:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   70
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin DesktopGroupBox GroupBoxAddTag
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   186
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   102
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   331
      Begin DesktopLabel LabelTagCaption
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBoxAddTag"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Caption:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   117
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   67
      End
      Begin DesktopTextField TabCaption
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   22
         Hint            =   "Tab Caption"
         Index           =   -2147483648
         InitialParent   =   "GroupBoxAddTag"
         Italic          =   False
         Left            =   122
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "New Tab"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   117
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   213
      End
      Begin DesktopCheckBox CheckBoxTabClosable
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Closable"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBoxAddTag"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   149
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   1
         Width           =   100
      End
      Begin DesktopCheckBox CheckBoxTabEnabled
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Enabled"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBoxAddTag"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   181
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   1
         Width           =   100
      End
      Begin DesktopCanvas TabIcon
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   32
         Index           =   -2147483648
         InitialParent   =   "GroupBoxAddTag"
         Left            =   119
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   208
         Transparent     =   True
         Visible         =   True
         Width           =   32
      End
      Begin DesktopLabel LabelTabIcon
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBoxAddTag"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Icon:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   213
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   67
      End
      Begin DesktopButton ButtonSelectIcon
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Select..."
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBoxAddTag"
         Italic          =   False
         Left            =   163
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   213
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopButton ButtonClearIcon
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Clear"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBoxAddTag"
         Italic          =   False
         Left            =   255
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   213
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopButton ButtonAddTab
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Add Tab"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "GroupBoxAddTag"
         Italic          =   False
         Left            =   27
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   252
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin DesktopButton ButtonResetTabs
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Reset Tabs"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   880
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   70
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin DesktopButton ButtonClearEvents
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Clear Events"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   873
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   596
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   107
   End
   Begin DesktopCheckBox CheckBoxEnableLeftMenuButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Enable Left Menu Button"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   363
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   130
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   185
   End
   Begin DesktopLabel LabelEnableLeftMenuButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   363
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Left menu button message"
      TextAlignment   =   0
      TextColor       =   &c5E5E5E00
      Tooltip         =   ""
      Top             =   149
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   329
   End
   Begin DesktopCheckBox CheckBoxEnableRightMenuButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Enable Right Menu Button"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   363
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   181
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   185
   End
   Begin DesktopLabel LabelEnableRightMenuButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   363
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Right menu button message"
      TextAlignment   =   0
      TextColor       =   &c5E5E5E00
      Tooltip         =   ""
      Top             =   200
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   329
   End
   Begin DesktopCheckBox CheckBoxAllowDragReordering
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Allow Drag Reordering"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   363
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   232
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   1
      Width           =   185
   End
   Begin DesktopPopupMenu PopupStyle
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   475
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   70
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   219
   End
   Begin DesktopLabel LabelStyle
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   391
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Style:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   70
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   72
   End
   Begin DesktopCheckBox CheckBoxFirstTabIsFixed
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "First Tab Is Fixed"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   560
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   130
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   185
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub MenuBarSelected()
		  If TabBar.TabCount > 1 Then
		    FileCloseWindow.Text = "Close Tab"
		  Else
		    FileCloseWindow.Text = "Close Window"
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  ResetTabs
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileCloseWindow() As Boolean Handles FileCloseWindow.Action
		  If TabBar.TabCount > 1 And TabBar.SelectedTabIndex <> - 1 Then
		    // Remove the currently selected tab.
		    TabBar.RemoveTabAt(TabBar.SelectedTabIndex)
		  Else
		    // "Close" the demo window.
		    ResetTabs
		    Self.Hide
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

	#tag Method, Flags = &h21, Description = 52657365747320746865207461622062617220746162732E
		Private Sub ResetTabs()
		  /// Resets the tab bar tabs.
		  
		  TabBar.RemoveAll
		  
		  TabBar.AppendTab("Apple", FavIconApple)
		  TabBar.AppendTab("Stack Overflow", FavIconStackOverflow)
		  TabBar.AppendTab("Xojo", FavIconXojo)
		  TabBar.AppendTab("hckr news", FavIconHckrNews)
		  TabBar.AppendTab("Daring Fireball", FavIconDaringFireball)
		  
		  TabBar.SelectTabAtIndex(1)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 5468652069636F6E20746F2061646420746F20746865206E65787420746162207468617420697320637265617465642E
		Private mIcon As Picture
	#tag EndProperty


#tag EndWindowCode

#tag Events TabBar
	#tag Event , Description = 412074616220776173206A75737420616464656420746F2074686520746162206261722061742060696E646578602E
		Sub DidAddTab(tab As XUITabBarItem, index As Integer)
		  Echo("Added tab with caption `" + tab.Caption + "` at index " + index.ToString)
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
	#tag Event , Description = 546865207573657220636F6E7465787574616C20636C69636B65642028726967687420636C69636B656429206F766572206120746162206174207468652070617373656420636F6F7264696E617465732E2054686520636F6F7264696E6174657320617265206C6F63616C20746F2074686520746F70206C65667420636F726E6572206F662074686520746162206261722E
		Sub DidContextualClickTab(tab As XUITabBarItem, x As Integer, y As Integer)
		  Echo("Contextual clicked tab """ + tab.Caption + """ at " + x.ToString + ", " + y.ToString)
		End Sub
	#tag EndEvent
	#tag Event , Description = 5468652075736572206A7573742066696E6973686564206472616767696E67206074616260202877686963682068617320612063757272656E7420696E646578206F662060696E64657860292E
		Sub DidFinishDragging(tab As XUITabBarItem, index As Integer)
		  Echo("Finished dragging tab with caption `" + tab.Caption + "` at index " + index.ToString)
		End Sub
	#tag EndEvent
	#tag Event , Description = 5468652075736572206A75737420626567616E206472616767696E67206074616260202877686963682068617320612063757272656E7420696E646578206F662060696E64657860292E
		Sub DidStartDragging(tab As XUITabBarItem, index As Integer)
		  Echo("Began dragging tab with caption `" + tab.Caption + "` at index " + index.ToString)
		End Sub
	#tag EndEvent
	#tag Event , Description = 546865207573657220686173206A757374206A757374207072657373656420746865206C656674206D656E7520627574746F6E2E
		Sub PressedLeftMenuButton()
		  Echo("Pressed the left menu button")
		End Sub
	#tag EndEvent
	#tag Event , Description = 546865207573657220686173206A757374206A757374207072657373656420746865207269676874206D656E7520627574746F6E2E
		Sub PressedRightMenuButton()
		  Echo("Pressed the right menu button")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupRenderer
	#tag Event
		Sub Opening()
		  Me.AddRow("Edge")
		  Me.RowTagAt(Me.LastAddedRowIndex) = New XUITabBarRendererEdge(TabBar)
		  Me.AddRow("Safari")
		  Me.RowTagAt(Me.LastAddedRowIndex) = New XUITabBarRendererSafari(TabBar)
		  
		  // Start with the Safari renderer.
		  Me.SelectedRowIndex = 1
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  /// Set the style of the tab bar to the style stored as this row's tag.
		  
		  #Pragma Unused item
		  
		  Var renderer As XUITabBarRenderer = Me.RowTagAt(Me.SelectedRowIndex)
		  
		  TabBar.Renderer = renderer
		  
		  // Does the selected renderer support left/right menus?
		  If Not renderer.SupportsLeftMenuButton Then
		    CheckBoxEnableLeftMenuButton.Enabled = False
		    CheckBoxEnableLeftMenuButton.Value = False
		    LabelEnableLeftMenuButton.Text = "The " + renderer.Name + " renderer does not support left menus"
		  Else
		    CheckBoxEnableLeftMenuButton.Enabled = True
		    LabelEnableLeftMenuButton.Text = ""
		  End If
		  
		  If Not renderer.SupportsRightMenuButton Then
		    CheckBoxEnableRightMenuButton.Enabled = False
		    CheckBoxEnableRightMenuButton.Value = False
		    LabelEnableRightMenuButton.Text = "The " + renderer.Name + " renderer does not support right menus"
		  Else
		    CheckBoxEnableRightMenuButton.Enabled = True
		    LabelEnableRightMenuButton.Text = ""
		  End If
		  
		  // Adjust the height of the tab bar to suit the renderer.
		  TabBar.Height = renderer.TabBarHeight
		  
		  Echo("Switched to the " + renderer.Name + " renderer.")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TabIcon
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  // Draw the icon (if there is one).
		  If mIcon <> Nil Then
		    Var p As Picture = mIcon.ResizeToFit(32, 32, XUIPictureScaleModes.ToFit, True)
		    g.DrawPicture(p, (g.Width / 2) - (p.Width / 2), (g.Height / 2) - (p.Height / 2))
		  End If
		  
		  // Border.
		  g.DrawingColor = Color.Black
		  g.DrawRectangle(0, 0, g.Width, g.Height)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonSelectIcon
	#tag Event
		Sub Pressed()
		  // Show the open file dialog. 
		  // I'm being lazy here - you should choose 16 x 16 pixel icons.
		  Var f As FolderItem = FolderItem.ShowOpenFileDialog(ImageFileTypes.All)
		  
		  If f = Nil Then
		    mIcon = Nil
		    Return
		  End If
		  
		  mIcon = Picture.Open(f)
		  
		  // Update the icon control.
		  TabIcon.Refresh
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonClearIcon
	#tag Event
		Sub Pressed()
		  mIcon = Nil
		  
		  TabIcon.Refresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonAddTab
	#tag Event
		Sub Pressed()
		  TabBar.AppendTab(TabCaption.Text, mIcon, Nil, CheckBoxTabClosable.Value, CheckBoxTabEnabled.Value)
		  
		  // Clear out the icon.
		  mIcon = Nil
		  TabIcon.Refresh
		  
		  // Reset the tab caption.
		  TabCaption.Text = "New Tab"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonResetTabs
	#tag Event
		Sub Pressed()
		  ResetTabs
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonClearEvents
	#tag Event
		Sub Pressed()
		  MessagesListbox.RemoveAllRows
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxEnableLeftMenuButton
	#tag Event
		Sub ValueChanged()
		  TabBar.HasLeftMenuButton = Me.Value
		  
		  Echo(If(Me.Value, "Enabled", "Disabled") + " the left menu button.")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxEnableRightMenuButton
	#tag Event
		Sub ValueChanged()
		  TabBar.HasRightMenuButton = Me.Value
		  
		  Echo(If(Me.Value, "Enabled", "Disabled") + " the right menu button.")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxAllowDragReordering
	#tag Event
		Sub ValueChanged()
		  TabBar.AllowDragReordering = Me.Value
		  
		  Echo(If(Me.Value, "Enabled", "Disabled") + " drag reordering.")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupStyle
	#tag Event
		Sub Opening()
		  Me.AddRow("Edge")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUITabBarStyle.Edge
		  Me.AddRow("Safari")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUITabBarStyle.Safari
		  
		  // Start with Safari's style.
		  Me.SelectedRowIndex = 1
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  /// Set the style of the tab bar to the style stored as this row's tag.
		  
		  #Pragma Unused item
		  
		  Var style As XUITabBarStyle = Me.RowTagAt(Me.SelectedRowIndex)
		  
		  TabBar.Style = style
		  
		  Echo("Switched to the " + style.Name + " style.")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxFirstTabIsFixed
	#tag Event
		Sub ValueChanged()
		  TabBar.FirstTabIsFixed = Me.Value
		  
		  Echo(If(Me.Value, "Enabled", "Disabled") + " fixed first tab.")
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
