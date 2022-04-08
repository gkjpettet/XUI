#tag DesktopWindow
Begin DesktopWindow WinAbout
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
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1647693823
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "About XUI"
   Type            =   0
   Visible         =   True
   Width           =   534
   BeginDesktopSegmentedButton DesktopSegmentedButton SegmentedButton1
      Enabled         =   True
      Height          =   24
      Index           =   -2147483648
      Left            =   186
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      Segments        =   "About\n\nTrue\rEULA\n\nFalse"
      SelectionStyle  =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   356
      Visible         =   True
      Width           =   162
   End
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   344
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   534
      Begin DesktopLabel LabelXUI
         AllowAutoDeactivate=   True
         Bold            =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   24.0
         FontUnit        =   0
         Height          =   42
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   217
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "XUI"
         TextAlignment   =   2
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   160
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin DesktopCanvas CanvasIcon
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   128
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   203
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   20
         Transparent     =   True
         Visible         =   True
         Width           =   128
      End
      Begin DesktopLabel LabelVersion
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Info"
         TextAlignment   =   2
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   204
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   494
      End
      Begin DesktopLabel LabelInfo
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   108
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Info"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   236
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   494
      End
      Begin DesktopTextArea TextAreaEULA
         AllowAutoDeactivate=   True
         AllowFocusRing  =   False
         AllowSpellChecking=   False
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   344
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   0
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   0
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   534
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.Center
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileCloseWindow() As Boolean Handles FileCloseWindow.Action
			Self.Hide
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Constant, Name = PANEL_ABOUT, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_EULA, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SEGMENT_ABOUT, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SEGMENT_EULA, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events SegmentedButton1
	#tag Event
		Sub Pressed(segmentIndex as integer)
		  Select Case segmentIndex
		  Case SEGMENT_ABOUT
		    Panel.SelectedPanelIndex = PANEL_ABOUT
		    
		  Case SEGMENT_EULA
		    Panel.SelectedPanelIndex = PANEL_EULA
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown segment index.")
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CanvasIcon
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  g.DrawPicture(AboutIcon, 0, 0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LabelVersion
	#tag Event
		Sub Opening()
		  Me.Text = "Version " + App.SemanticVersion.ToString
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LabelInfo
	#tag Event
		Sub Opening()
		  Var now As DateTime = DateTime.Now
		  Var copyright As String = If(now.Year = 2022, "2022", "2022 - " + now.Year.ToString)
		  
		  Var s() As String
		  
		  s.Add("Copyright © " + copyright + " Dr Garry Pettet. All rights reserved.")
		  s.Add("")
		  s.Add("Use of the UI controls, utilities and other components of XUI is subject to the terms of the " + _
		  "End User License Agreement.")
		  
		  Me.Text = String.FromArray(s, EndOfLine)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextAreaEULA
	#tag Event
		Sub Opening()
		  TextAreaEULA.Text = ""
		  
		  // Load the two EULAs.
		  Var simpleFile As FolderItem = SpecialFolder.Resource("XUI Simple EULA.md")
		  Var fullFile As FolderItem = SpecialFolder.Resource("XUI EULA.md")
		  
		  Var simple, full As String
		  
		  Var tin As TextInputStream = TextInputStream.Open(simpleFile)
		  simple = tin.ReadAll
		  tin.Close
		  
		  tin = TextInputStream.Open(fullFile)
		  full = tin.ReadAll
		  tin.Close
		  
		  Var eula As String = simple + EndOfLine + EndOfLine + full
		  
		  TextAreaEULA.Text = eula.Trim
		  
		  Exception e
		    // Ignore.
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
