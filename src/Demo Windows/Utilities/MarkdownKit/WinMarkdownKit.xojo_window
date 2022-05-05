#tag DesktopWindow
Begin DemoWindow WinMarkdownKit
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
   Height          =   634
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1647693823
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "MarkdownKit"
   Type            =   0
   Visible         =   False
   Width           =   1260
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   554
      Index           =   -2147483648
      Left            =   650
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   0
      SelectedPanelIndex=   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   28
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   610
      Begin NoQuotesTextArea HTMLOutput
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
         Height          =   554
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   649
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   27
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         ValidationMask  =   ""
         Visible         =   True
         Width           =   612
      End
      Begin DesktopHTMLViewer Preview
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   554
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   649
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Renderer        =   0
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   27
         Visible         =   True
         Width           =   612
      End
   End
   Begin DesktopButton ButtonParse
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Parse"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   1160
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   594
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton ButtonClear
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
      Italic          =   False
      Left            =   1068
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   594
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin NoQuotesTextArea Source
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
      Height          =   637
      HideSelection   =   True
      Index           =   -2147483648
      InitialParent   =   ""
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
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   -1
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   0
      ValidationMask  =   ""
      Visible         =   True
      Width           =   650
   End
   Begin XUITabBar TabBar
      AllowAutoDeactivate=   True
      AllowDragReordering=   False
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      AvailableTabSpace=   0.0
      Backdrop        =   0
      DraggingTabLeftEdgeXOffset=   0
      Enabled         =   True
      HasLeftBorder   =   False
      HasLeftMenuButton=   False
      HasRightBorder  =   False
      HasRightMenuButton=   False
      Height          =   28
      Index           =   -2147483648
      IsDraggingTab   =   False
      Left            =   650
      LeftMenuButtonIcon=   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   610
   End
   Begin DesktopCheckBox CheckBoxLiveParsing
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Live Parsing"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   956
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   594
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   100
   End
   Begin DesktopLabel LabelInfo
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   662
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   594
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   282
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  TabBar.Style = XUITabBarStyle.Safari
		  TabBar.Renderer = New XUITabBarRendererSafari(TabBar)
		  
		  TabBar.AppendTab("HTML", Nil, PANEL_HTML, False)
		  TabBar.AppendTab("Preview", Nil, PANEL_PREVIEW, False)
		  TabBar.SelectTabAtIndex(1)
		  
		  Source.Text = EXAMPLE
		  
		  Parse
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileCloseWindow() As Boolean Handles FileCloseWindow.Action
			Self.Hide
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21, Description = 5061727365732074686520636F6E74656E7473206F662060536F757263656020746F2048544D4C2E
		Private Sub Parse()
		  /// Parses the contents of `Source` to HTML.
		  
		  Var watch As New XUIStopWatch(True)
		  Var html As String = MarkdownKit.ToHTML(Source.Text)
		  watch.Stop
		  
		  HTMLOutput.Text = html
		  Preview.LoadPage(html, Nil)
		  
		  LabelInfo.Text = "Parsed in " + watch.ElapsedMilliseconds.ToString + " ms"
		End Sub
	#tag EndMethod


	#tag Constant, Name = EXAMPLE, Type = String, Dynamic = False, Default = \"## About MarkdownKit\n\nMarkdownKit is a 100% [CommonMark] compliant Markdown parser for Xojo written in pure Xojo code. I needed a fast and robust parser that not only would reliably generate the correct output but would also run on iOS. After looking around I realised that there was no other solution available for Xojo and so I decided to write one myself. MarkdownKit is a labour love\x2C taking months of hard work and contains over 8500 lines of code.\n\nMarkdownKit takes Markdown as input and generates a Markdown `MKDocument` which is essentially an _abstract syntax tree_ (AST). From the AST\x2C it is then able to render the input as HTML.\n\n## A word about API 2.0\n\nXojo 2019 Release 2 introduced the new Xojo framework\x2C known as _API 2.0_. API 2.0 is an attempt by Xojo to unify code between their platforms and make method naming more consistent as well as move everything to 0-based offsets. `MarkdownKit` is fully API 2.0 compliant. \n\n## Dependencies\n\nMarkdownKit is 100% Xojo code and is self contained in its own module. It does not depend on any third party plugins but it does require two other components included with XUI:\n\n1. `XUIStrings`\n2. `XUITextLine`\n\n`XUIStrings ` is a module that provides a bunch of `String` manipulation methods.\n\n## Quick Start\n\nTo use MarkdownKit in your own projects just follow these steps:\n\n1. Open the XUI project file in the IDE.\n2. Copy the `MarkdownKit` module from the navigator and paste it into your own project.\n3. for complete ease just copy the entire contents of the `Required` folder from the navigator to your own project. Technically you only need to additionally copythe `XUIStringExtensios` module and `XUITextLine` classes to your project.\n4. Convert Markdown source to HTML with the `MarkdownKit.ToHTML()` method:\n\n```xojo\nVar html As String \x3D MarkdownKit.ToHTML(\"Some **bold** text\")\n```\n\n## Improvements Over Previous Versions\n\nThis is a complete rewrite. The main advantage it offers is that it tracks the exact source code positions of every block and inline component of the AST during parsing. This means that the AST contains all the information you need to implement a source code highlighter for Markdown (the whole reason I did the rewrite in the first place).\n\n## Advanced Use\n\nI imagine that most people will only ever need to use the simple `MarkdownKit.ToHTML()` method. However\x2C if you want access to the abstract syntax tree created by `MarkdownKit` during parsing then you can\x2C like so:\n\n```xojo\nVar ast As MarkdownKit.MKDocument \x3D MarkdownKit.ToDocument(\"Some **bold** text\")\n\n// You can now visit the AST to render it using a class that implements `MKRenderer`:\nVar htmlRenderer As New MKHTMLRenderer // Or your own class.\nCall htmlRenderer.VisitDocument(ast)\n```\n\nWhy might you want access to the AST\? Well\x2C maybe you want to do something as simple as render every soft line break in a document as a hard line break. Perhaps you want to output the Markdown source as something other than HTML.\n\n`MarkdownKit` provides a class interface called `MKRenderer` which must be implemented by any custom renderer you write. I use the AST in a custom Markdown code editor I\'m writing to colour the components of the source code. The built-in `MarkdownKit.MKHTMLRenderer` is an example of a renderer which implements this interface. Take a look at its well-documented methods to learn how to write your own renderer.\n\n[CommonMark]: https://spec.commonmark.org/0.29/", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PANEL_HTML, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_PREVIEW, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ButtonParse
	#tag Event
		Sub Pressed()
		  Parse
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonClear
	#tag Event
		Sub Pressed()
		  Source.Text = ""
		  HTMLOutput.Text = ""
		  Preview.LoadPage("", Nil)
		  LabelInfo.Text = ""
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Source
	#tag Event
		Sub TextChanged()
		  If CheckBoxLiveParsing.Value Then Parse
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TabBar
	#tag Event , Description = 54686520746162206174207468652073706563696669656420696E64657820776173206A7573742073656C65637465642E
		Sub DidSelectTab(tab As XUITabBarItem, index As Integer)
		  #Pragma Unused index
		  
		  Panel.SelectedPanelIndex = tab.Tag
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
