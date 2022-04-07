#tag DesktopWindow
Begin DemoWindow WinSourceList
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
   Height          =   500
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "SourceList Demo"
   Type            =   0
   Visible         =   False
   Width           =   792
   Begin XUISourceList SourceList
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowMultipleSelection=   True
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   503
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   -1
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   -1
      Transparent     =   True
      Visible         =   True
      Width           =   240
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
      InitialValue    =   ""
      Italic          =   False
      Left            =   342
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   218
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
      Left            =   342
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   218
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
      Left            =   251
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Renderer:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   79
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
      Left            =   251
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
      Text            =   "Style:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   79
   End
   Begin DesktopButton ButtonFinder
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Finder"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   251
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   116
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin DesktopButton ButtonMailClient
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Mail Client"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   485
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
      Top             =   116
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin DesktopLabel LabelDummyData
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   251
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Clicking the buttons below will reset the source list with dummy data."
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   521
   End
   Begin DesktopListBox ListBoxEvents
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
      Height          =   270
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   251
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   180
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   521
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopLabel LabelDummyData1
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   251
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
      Text            =   "Event Log:"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   148
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   79
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
      Left            =   667
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   462
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
   Begin DesktopCheckBox CheckBoxHierarchical
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Hierarchical"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   672
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   116
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   100
   End
   Begin DesktopButton ButtonExplorer
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Explorer"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   368
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   116
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   105
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  ResetToExplorerData
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, Description = 5265736574732074686520636F6E74656E7473206F662074686520736F75726365206C69737420746F20636F6E7461696E206974656D7320796F7527642065787065637420746F2073656520696E207468652057696E646F7773204578706C6F7265722E
		Private Sub ResetToExplorerData()
		  /// Resets the contents of the source list to contain items you'd expect to see in the Windows Explorer.
		  
		  SourceList.RemoveAllSections
		  
		  // =======================
		  // QUICK ACCESS SECTION
		  // =======================
		  Var quickAccess As New XUISourceListItem("Quick Access", IconSourceListStar)
		  // Folder 1
		  Var folder1 As New XUISourceListItem("Folder 1", IconSourceListWindowsFolder)
		  folder1.HasWidget = True
		  folder1.WidgetIcon = IconSourceListWidgetPin
		  quickAccess.AddChild(folder1)
		  // Folder 2.
		  Var folder2 As New XUISourceListItem("Folder 2", IconSourceListWindowsFolder)
		  folder2.HasWidget = True
		  folder2.WidgetIcon = IconSourceListWidgetPin
		  quickAccess.AddChild(folder2)
		  // Videos.
		  quickAccess.AddChild(New XUISourceListItem("Videos", IconSourceListWindowsVideos))
		  quickAccess.Expanded = True
		  
		  SourceList.AddSection(quickAccess)
		  
		  // "This PC" section.
		  Var thisPC As New XUISourceListItem("This PC", IconSourceListWindowsPC)
		  thisPC.AddChild(New XUISourceListItem("Desktop", IconSourceListWindowsDesktop))
		  thisPC.AddChild(New XUISourceListItem("Local Disk", IconSourceListWindowsLocalDisk))
		  thisPC.AddChild(New XUISourceListItem("DVD Drive", IconSourceListDVD))
		  thisPC.Expanded = True
		  SourceList.AddSection(thisPC)
		  
		  // "Network" section.
		  Var network As New XUISourceListItem("Network", IconSourceListWindowsNetwork)
		  network.AddChild(New XUISourceListItem("HP Printer", IconSourceListWindowsPrinter))
		  network.Expanded = True
		  SourceList.AddSection(network)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265736574732074686520636F6E74656E7473206F662074686520736F75726365206C69737420746F20636F6E7461696E206974656D7320796F7527642065787065637420746F2073656520696E20746865206D61634F532046696E6465722E
		Private Sub ResetToFinderData()
		  /// Resets the contents of the source list to contain items you'd expect to see in the macOS Finder.
		  
		  SourceList.RemoveAllSections
		  
		  // Favourites section.
		  Var favourites As New XUISourceListItem("Favourites")
		  favourites.AddChild(New XUISourceListItem("garry", IconSourceListHome))
		  favourites.AddChild(New XUISourceListItem("Recents", IconSourceListRecent))
		  favourites.Expanded = True
		  SourceList.AddSection(favourites)
		  
		  // iCloud section.
		  Var iCloud As New XUISourceListItem("iCloud")
		  iCloud.AddChild(New XUISourceListItem("iCloud Drive", IconSourceListICloud))
		  iCloud.AddChild(New XUISourceListItem("Documents", IconSourceListDocuments))
		  iCloud.AddChild(New XUISourceListItem("Desktop", IconSourceListDesktop))
		  iCloud.AddChild(New XUISourceListItem("Shared", IconSourceListShared))
		  iCloud.Expanded = True
		  SourceList.AddSection(iCloud)
		  
		  // Locations section.
		  Var locations As New XUISourceListItem("Locations")
		  locations.AddChild(New XUISourceListItem("Synology", IconSourceListComputer))
		  locations.AddChild(New XUISourceListItem("Network", IconSourceListNetwork))
		  locations.Expanded = True
		  SourceList.AddSection(locations)
		  
		  // Tags section.
		  Var tags As New XUISourceListItem("Tags")
		  tags.AddChild(New XUISourceListItem("Red", IconSourceListTagRed))
		  tags.AddChild(New XUISourceListItem("Orange", IconSourceListTagOrange))
		  tags.AddChild(New XUISourceListItem("All Tags...", IconSourceListAllTags))
		  tags.Expanded = True
		  SourceList.AddSection(tags)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265736574732074686520636F6E74656E7473206F662074686520736F75726365206C69737420746F20636F6E7461696E206974656D7320796F7527642065787065637420746F2073656520696E20616E20656D61696C20636C69656E74277320736F75726365206C6973742E
		Private Sub ResetToMailSourceList()
		  /// Resets the contents of the source list to contain items you'd expect to see in an email client's source list.
		  
		  SourceList.RemoveAllSections
		  
		  // =======================
		  // FAVOURITES SECTION
		  // =======================
		  Var favourites As New XUISourceListItem("Favourites")
		  
		  // Inbox.
		  favourites.AddChild(New XUISourceListItem("Inbox", IconSourceListInbox))
		  
		  // VIPs.
		  Var vips As New XUISourceListItem("VIPs", IconSourceListVIPs, 0, Nil, True)
		  vips.AddChild(New XUISourceListItem("Peter Parker", IconSourceListVIPs))
		  vips.AddChild(New XUISourceListItem("Tony Stark", IconSourceListVIPs))
		  favourites.AddChild(vips, False)
		  vips.Expanded = True
		  
		  // Flagged.
		  Var flagged As New XUISourceListItem("Flagged", IconSourceListFlagged, 0, Nil, True)
		  flagged.AddChild(New XUISourceListItem("Orange", IconSourceListFlagOrange, 1))
		  flagged.AddChild(New XUISourceListItem("Red", IconSourceListFlagRed, 4))
		  flagged.AddChild(New XUISourceListItem("Purple", IconSourceListFlagPurple, 9))
		  favourites.AddChild(flagged, False)
		  flagged.Expanded = True
		  
		  // Drafts.
		  Var drafts As New XUISourceListItem("Drafts", IconSourceListDocuments, 1)
		  favourites.AddChild(drafts, False)
		  
		  // Sent.
		  favourites.AddChild(New XUISourceListItem("Sent", IconSourceListSent))
		  
		  // Expand the favourites section.
		  favourites.Expanded = True
		  
		  // The favourites section should have a widget.
		  favourites.HasWidget = True
		  
		  // Add the favourites section to the source list.
		  SourceList.AddSection(favourites)
		  
		  // =======================
		  // SMART MAILBOXES SECTION
		  // =======================
		  Var smart As New XUISourceListItem("Smart Mailboxes")
		  smart.AddChild(New XUISourceListItem("Today", IconSourceListSmart))
		  smart.Expanded = True
		  
		  // The smart mailboxes section should have a widget.
		  smart.HasWidget = True
		  
		  // Add the smart mailboxes section to the source list.
		  SourceList.AddSection(smart)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 536574732074686520736F75726365206C69737427732072656E646572657220746F207468652073656C65637465642072656E646572657220696E2074686520706F7075702E
		Private Sub SetRenderer()
		  /// Sets the source list's renderer to the selected renderer in the popup.
		  
		  Select Case PopupRenderer.SelectedRowValue
		  Case "macOS Monterey"
		    SourceList.Renderer = New XUISourceListRendererMonterey(SourceList)
		  Case "Windows 11"
		    SourceList.Renderer = New XUISourceListRendererWindows11(SourceList)
		  Else
		    Raise New UnsupportedOperationException("Unknown renderer in popup.")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5365747320746865207374796C65206F662074686520736F75726365206C69737420746F207468652073656C6563746564207374796C6520696E2074686520706F7075702E
		Private Sub SetStyle()
		  /// Sets the style of the source list to the selected style in the popup.
		  
		  SourceList.Style = PopupStyle.RowTagAt(PopupStyle.SelectedRowIndex)
		  
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events SourceList
	#tag Event , Description = 54686520757365722068617320636C69636B6564206F6E20616E206974656D2773207769646765742E
		Sub ClickedItemWidget(item As XUISourceListItem)
		  ListBoxEvents.AddRow("Clicked """ + item.Title + """ widget")
		End Sub
	#tag EndEvent
	#tag Event , Description = 54686520757365722068617320636F6C6C617073656420616E206974656D20627920636C69636B696E67206F6E2074686520646973636C6F73757265207769646765742E
		Sub CollapsedItem(item As XUISourceListItem)
		  ListBoxEvents.AddRow("Collapsed """ + item.Title + """")
		End Sub
	#tag EndEvent
	#tag Event , Description = 54686520757365722068617320657870616E64656420616E206974656D20627920636C69636B696E67206F6E2074686520646973636C6F73757265207769646765742E
		Sub ExpandedItem(item As XUISourceListItem)
		  ListBoxEvents.AddRow("Expanded """ + item.Title + """")
		End Sub
	#tag EndEvent
	#tag Event , Description = 416E206974656D20696E2074686520736F75726365206C697374207761732073656C65637465642E20496620636C69636B65642C205820616E6420592061726520746865206D6F75736520636F6F7264696E61746573206F662074686520636C69636B206C6F63616C20746F2074686520726F7720746865206974656D206973206F6E2E2054686573652077696C6C20626520602D3160206966207468652073656C656374696F6E207761732070726F6772616D617469632E
		Sub ItemSelected(item As XUISourceListItem, x As Integer, y As Integer)
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  ListBoxEvents.AddRow("Selected """ + item.Title + """")
		End Sub
	#tag EndEvent
	#tag Event , Description = 416E206974656D20696E2074686520736F75726365206C6973742077617320756E73656C65637465642E20496620636C69636B65642C205820616E6420592061726520746865206D6F75736520636F6F7264696E61746573206F662074686520636C69636B206C6F63616C20746F2074686520726F7720746865206974656D206973206F6E2E2054686573652077696C6C20626520602D3160206966207468652073656C656374696F6E207761732070726F6772616D617469632E
		Sub ItemUnselected(item As XUISourceListItem, x As Integer, y As Integer)
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  ListBoxEvents.AddRow("Unselected """ + item.Title + """")
		End Sub
	#tag EndEvent
	#tag Event , Description = 43616C6C6564207768656E20606974656D6020686173206265656E206D6F7665642066726F6D20606F6C64506172656E746020746F20606E6577506172656E74602E204F6363757273207768656E20746865726520686173206265656E206120647261672072656F72646572696E672E
		Sub MovedItem(item As XUISourceListItem, oldParent As XUISourceListItem, newParent As XUISourceListItem)
		  #Pragma Unused oldParent
		  
		  ListBoxEvents.AddRow("Moved """ + item.Title + """ to " + If(newParent = Nil, "Nil", """" + newParent.Title + """"))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupRenderer
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  SourceList.Renderer = Me.RowTagAt(Me.SelectedRowIndex)
		  
		  // Windows 11 source lists are always hierarchical.
		  If SourceList.Renderer IsA XUISourceListRendererWindows11 Then
		    CheckBoxHierarchical.Value = True
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.AddRow("macOS Monterey")
		  Me.RowTagAt(Me.LastAddedRowIndex) = New XUISourceListRendererMonterey(SourceList)
		  
		  Me.AddRow("Windows 11")
		  Me.RowTagAt(Me.LastAddedRowIndex) = New XUISourceListRendererWindows11(SourceList)
		  
		  // Default to the Windows 11 renderer.
		  Me.SelectedRowIndex = 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupStyle
	#tag Event
		Sub Opening()
		  Me.AddRow("macOS Monterey")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUISourceListStyle.Monterey
		  
		  Me.AddRow("Windows 11")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUISourceListStyle.Windows11
		  
		  // Default to the Windows 11 style.
		  Me.SelectedRowIndex = 1
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  SourceList.Style = Me.RowTagAt(Me.SelectedRowIndex)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonFinder
	#tag Event
		Sub Pressed()
		  ResetToFinderData
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonMailClient
	#tag Event
		Sub Pressed()
		  ResetToMailSourceList
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonClearEvents
	#tag Event
		Sub Pressed()
		  ListBoxEvents.RemoveAllRows
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxHierarchical
	#tag Event
		Sub ValueChanged()
		  SourceList.Hierarchical = Me.Value
		  SourceList.Refresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonExplorer
	#tag Event
		Sub Pressed()
		  ResetToExplorerData
		  
		End Sub
	#tag EndEvent
#tag EndEvents
