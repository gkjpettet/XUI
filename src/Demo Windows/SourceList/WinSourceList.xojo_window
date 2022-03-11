#tag DesktopWindow
Begin DesktopWindow WinSourceList
   Backdrop        =   0
   BackgroundColor =   &cFFD47900
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
   Width           =   834
   Begin XUISourceList FinderSourceList
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   502
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
      Width           =   230
   End
   Begin XUISourceList MailSourceList
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   502
      Hierarchical    =   True
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   604
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   230
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  InitialiseFinderSourceList
		  InitialiseMailSourceList
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, Description = 496E697469616C69736573206F75722046696E6465722D7374796C6520736F75726365206C6973742E
		Private Sub InitialiseFinderSourceList()
		  /// Initialises our Finder-style source list.
		  
		  FinderSourceList.Renderer = New XUISourceListMacOSRenderer(FinderSourceList)
		  FinderSourceList.Style = XUISourceListStyle.MacOS
		  
		  // Favourites section.
		  Var favourites As New XUISourceListItem("Favourites")
		  favourites.AddChild(New XUISourceListItem("garry", IconSourceListHome), False)
		  favourites.AddChild(New XUISourceListItem("Recents", IconSourceListRecent), False)
		  favourites.SetExpanded(False)
		  FinderSourceList.AddSection(favourites)
		  
		  // iCloud section.
		  Var iCloud As New XUISourceListItem("iCloud")
		  iCloud.AddChild(New XUISourceListItem("iCloud Drive", IconSourceListICloud), False)
		  iCloud.AddChild(New XUISourceListItem("Documents", IconSourceListDocuments), False)
		  iCloud.AddChild(New XUISourceListItem("Desktop", IconSourceListDesktop), False)
		  iCloud.AddChild(New XUISourceListItem("Shared", IconSourceListShared), False)
		  iCloud.SetExpanded(False)
		  FinderSourceList.AddSection(iCloud)
		  
		  // Locations section.
		  Var locations As New XUISourceListItem("Locations")
		  locations.AddChild(New XUISourceListItem("Synology", IconSourceListComputer), False)
		  locations.AddChild(New XUISourceListItem("Network", IconSourceListNetwork), False)
		  locations.SetExpanded(False)
		  FinderSourceList.AddSection(locations)
		  
		  // Tags section.
		  Var tags As New XUISourceListItem("Tags")
		  tags.AddChild(New XUISourceListItem("Red", IconSourceListTagRed), False)
		  tags.AddChild(New XUISourceListItem("Orange", IconSourceListTagOrange), False)
		  tags.AddChild(New XUISourceListItem("All Tags...", IconSourceListAllTags), False)
		  tags.SetExpanded(False)
		  FinderSourceList.AddSection(tags)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E697469616C69736573206F7572204D61696C2E6170702D7374796C6520736F75726365206C6973742E
		Private Sub InitialiseMailSourceList()
		  /// Initialises our Mail.app-style source list.
		  
		  MailSourceList.Renderer = New XUISourceListMacOSRenderer(MailSourceList)
		  MailSourceList.Style = XUISourceListStyle.MacOS
		  
		  // =======================
		  // FAVOURITES SECTION
		  // =======================
		  Var favourites As New XUISourceListItem("Favourites")
		  
		  // Inbox.
		  favourites.AddChild(New XUISourceListItem("Inbox", IconSourceListInbox), False)
		  
		  // VIPs.
		  Var vips As New XUISourceListItem("VIPs", IconSourceListVIPs)
		  vips.AddChild(New XUISourceListItem("Peter Parker", IconSourceListVIPs), False)
		  vips.AddChild(New XUISourceListItem("Tony Stark", IconSourceListVIPs), False)
		  favourites.AddChild(vips, False)
		  vips.SetExpanded(False)
		  
		  // Flagged.
		  Var flagged As New XUISourceListItem("Flagged", IconSourceListFlagged)
		  flagged.AddChild(New XUISourceListItem("Orange", IconSourceListFlagOrange, 1), False)
		  flagged.AddChild(New XUISourceListItem("Red", IconSourceListFlagRed, 4), False)
		  flagged.AddChild(New XUISourceListItem("Purple", IconSourceListFlagPurple, 9), False)
		  favourites.AddChild(flagged, False)
		  flagged.SetExpanded(False)
		  
		  // Drafts.
		  Var drafts As New XUISourceListItem("Drafts", IconSourceListDocuments, 1)
		  favourites.AddChild(drafts, False)
		  
		  // Sent.
		  favourites.AddChild(New XUISourceListItem("Sent", IconSourceListSent), False)
		  
		  // Expand the favourites section.
		  favourites.SetExpanded(False)
		  
		  // Add the favourites section to the source list.
		  MailSourceList.AddSection(favourites)
		  
		  // =======================
		  // SMART MAILBOXES SECTION
		  // =======================
		  Var smart As New XUISourceListItem("Smart Mailboxes")
		  smart.AddChild(New XUISourceListItem("Today", IconSourceListSmart), False)
		  smart.SetExpanded(False)
		  MailSourceList.AddSection(smart)
		  
		End Sub
	#tag EndMethod


#tag EndWindowCode

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
