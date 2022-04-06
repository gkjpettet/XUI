#tag DesktopWindow
Begin DesktopWindow WinWelcome
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   0
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
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
   Resizeable      =   False
   Title           =   "XUI Welcome"
   Type            =   0
   Visible         =   True
   Width           =   700
   Begin XUITextButton ButtonUIControls
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   12
      HasBackgroundColor=   False
      Height          =   22
      Index           =   -2147483648
      IsPressed       =   True
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PressedColor    =   &cD0D0D0
      PressedTextColor=   &c313131
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c6D6D6D
      Title           =   "UI Controls"
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Type            =   1
      Visible         =   True
      Width           =   100
   End
   Begin XUITextButton ButtonUtilites
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   12
      HasBackgroundColor=   False
      Height          =   22
      Index           =   -2147483648
      IsPressed       =   False
      Left            =   122
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PressedColor    =   &cD0D0D0
      PressedTextColor=   &c313131
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c6D6D6D
      Title           =   "Utilities"
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Type            =   1
      Visible         =   True
      Width           =   100
   End
   Begin XUITextButton ButtonUExtensions
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   12
      HasBackgroundColor=   False
      Height          =   22
      Index           =   -2147483648
      IsPressed       =   False
      Left            =   224
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PressedColor    =   &cD0D0D0
      PressedTextColor=   &c313131
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c6D6D6D
      Title           =   "Extensions"
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Type            =   1
      Visible         =   True
      Width           =   100
   End
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   446
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   54
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   700
      Begin WelcomeListBox Products
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
         DefaultRowHeight=   56
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
         Height          =   426
         Index           =   -2147483648
         InitialParent   =   "Panel"
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
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   660
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  // Centre this window on its display.
		  Self.Center
		  
		  // Add our XUI products.
		  Products.AddProduct("XUITabBar", "A customisable tab bar control.", WinTabBar)
		  Products.AddProduct("XUITagCanvas", "An editable canvas that parses text into tags and supports autocompletion.", WinTagCanvas)
		  Products.AddProduct("XUICodeEditor", "Full featured code editor supporting themes, custom formatters and autocompletion.", WinCodeEditor)
		  Products.AddProduct("XUISourceList", "Powerful source list control. Similar to that seen in the macOS Finder or Window's Explorer.", WinSourceList)
		  Products.AddProduct("XUIImageButton", "A simple imaged-based button control.", WinImageButton)
		  Products.AddProduct("XUIColorSwatch & XUIColorPicker", "Easy to use colour swatches and a custom colour picker.", WinColors)
		  Products.AddProduct("XUITextButton", "A minimalist text button providing full colour customisation.", WinTextButton)
		  Products.AddProduct("XUIDotLabel", "Displays a colour-customisable dot with an optional caption.", WinDotLabel)
		  
		End Sub
	#tag EndEvent


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
