#tag DesktopWindow
Begin DesktopWindow Window1
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
   Title           =   "Untitled"
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
      Height          =   500
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
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
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   239
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
      Left            =   251
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
      Left            =   251
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
      Top             =   59
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   218
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  ResetToFileBrowserData
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub ResetToFileBrowserData()
		  /// Resets the contents of the source list to contain items you'd expect to see in a file browser.
		  
		  SourceList.RemoveAllSections
		  
		  // Favourites section.
		  Var favourites As New XUISourceListItem("Favourites")
		  favourites.AddChild(New XUISourceListItem("garry", IconSourceListHome), False)
		  favourites.AddChild(New XUISourceListItem("Recents", IconSourceListRecent), False)
		  favourites.Expanded = True
		  SourceList.AddSection(favourites)
		  
		  // iCloud section.
		  Var iCloud As New XUISourceListItem("iCloud")
		  iCloud.AddChild(New XUISourceListItem("iCloud Drive", IconSourceListICloud), False)
		  iCloud.AddChild(New XUISourceListItem("Documents", IconSourceListDocuments), False)
		  iCloud.AddChild(New XUISourceListItem("Desktop", IconSourceListDesktop), False)
		  iCloud.AddChild(New XUISourceListItem("Shared", IconSourceListShared), False)
		  iCloud.Expanded = True
		  SourceList.AddSection(iCloud)
		  
		  // Locations section.
		  Var locations As New XUISourceListItem("Locations")
		  locations.AddChild(New XUISourceListItem("Synology", IconSourceListComputer), False)
		  locations.AddChild(New XUISourceListItem("Network", IconSourceListNetwork), False)
		  locations.Expanded = True
		  SourceList.AddSection(locations)
		  
		  // Tags section.
		  Var tags As New XUISourceListItem("Tags")
		  tags.AddChild(New XUISourceListItem("Red", IconSourceListTagRed), False)
		  tags.AddChild(New XUISourceListItem("Orange", IconSourceListTagOrange), False)
		  tags.AddChild(New XUISourceListItem("All Tags...", IconSourceListAllTags), False)
		  tags.Expanded = True
		  SourceList.AddSection(tags)
		  
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
#tag EndEvents
#tag Events PopupRenderer
	#tag Event
		Sub Opening()
		  Me.AddRow("macOS Monterey")
		  Me.RowTagAt(Me.LastAddedRowIndex) = New XUISourceListRendererMonterey(SourceList)
		  
		  Me.AddRow("Windows 11")
		  Me.RowTagAt(Me.LastAddedRowIndex) = New XUISourceListRendererWindows11(SourceList)
		  
		  // Default to the Mac renderer.
		  Me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  SourceList.Renderer = Me.RowTagAt(Me.SelectedRowIndex)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupStyle
	#tag Event
		Sub Opening()
		  Me.AddRow("macOS Monterey")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUISourceListStyle.Monterey
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  SourceList.Style = Me.RowTagAt(Me.SelectedRowIndex)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
