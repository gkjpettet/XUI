#tag DesktopWindow
Begin DesktopWindow WinCodeEditor
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
   Height          =   680
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1717981183
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "XUICodeEditor Demo"
   Type            =   0
   Visible         =   True
   Width           =   1260
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
      Left            =   859
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MouseDragX      =   0
      MouseDragY      =   0
      MouseMoveX      =   0
      MouseMoveY      =   0
      Scope           =   0
      SelectedTabIndex=   0
      TabCount        =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   401
   End
   Begin DesktopLabel Info
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   998
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Info"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   656
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   251
   End
   Begin Timer InfoTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   500
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   623
      Index           =   -2147483648
      Left            =   859
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   28
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   401
      Begin DesktopPopupMenu PopupFormatters
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   ""
         Italic          =   False
         Left            =   972
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   38
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   138
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   867
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Formatter:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   38
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   93
      End
   End
   Begin XUICodeEditor Editor
      AllowAutocomplete=   True
      AllowAutoCompleteInComments=   True
      AllowInertialScrolling=   True
      AutocompleteCombo=   "XUICodeEditor.AutocompleteCombos.Tab"
      AutocompletePopupFontName=   ""
      AutocompletePopupFontSize=   0
      AutoDeactivate  =   True
      BackgroundColor =   &c00000000
      BlinkCaret      =   True
      BorderColor     =   &c00000000
      CaretColour     =   &c00000000
      CaretColumn     =   0
      CaretLineNumber =   0
      CaretPosition   =   0
      CaretType       =   2
      CaretXCoordinate=   0
      Contents        =   ""
      ContentType     =   "XUICodeEditor.ContentTypes.SourceCode"
      CurrentLineHighlightColor=   &c00000000
      CurrentLineNumberColor=   &c00000000
      CurrentUndoID   =   0
      DisplayLineNumbers=   False
      DrawBlockLines  =   True
      Enabled         =   True
      FirstVisibleLine=   0
      FontName        =   ""
      FontSize        =   0
      HasBottomBorder =   False
      HasFocus        =   False
      HasHorizontalScrollbar=   True
      HasLeftBorder   =   False
      HasRightBorder  =   True
      HasTopBorder    =   False
      HasVerticalScrollbar=   True
      Height          =   680
      HighlightCurrentLine=   True
      HighlightDelimitersAroundCaret=   True
      Index           =   -2147483648
      InitialParent   =   ""
      LastFullyVisibleLineNumber=   0
      Left            =   0
      LineNumberColor =   &c00000000
      LineNumberFontSize=   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LongestLineChanged=   False
      MinimumAutocompletionLength=   2
      NeedsFullRedraw =   False
      ReadOnly        =   False
      Scope           =   0
      ScrollPosX      =   0
      SelectionColour =   &c00000000
      SpacesPerTab    =   4
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextSelected    =   False
      TokeniseMode    =   "XUICodeEditor.TokeniseModes.All"
      Tooltip         =   ""
      Top             =   0
      VerticalLinePadding=   0
      Visible         =   True
      Width           =   860
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub MenuBarSelected()
		  // Edit > Undo
		  If UndoManager.CanUndo Then
		    EditUndo.Enabled = True
		    EditUndo.Text = "Undo " + UndoManager.NextUndo.Description
		  Else
		    EditUndo.Enabled = False
		    EditUndo.Text = "Undo"
		  End If
		  
		  // Edit > Redo
		  If UndoManager.CanRedo Then
		    EditRedo.Enabled = True
		    EditRedo.Text = "Redo " + UndoManager.NextRedo.Description
		  Else
		    EditRedo.Enabled = False
		    EditRedo.Text = "Redo"
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.Center
		  
		  // Create an undo manager.
		  UndoManager = New XUIUndoManager
		  
		  // We have to assign the code editor's undo manager here because the window's Opening event fires 
		  // after the editor's Opening event.
		  Editor.UndoManager = Self.UndoManager
		  
		  // Increase the default font a little.
		  Editor.FontSize = 14
		  
		  // Enable autocompletion.
		  Editor.AllowAutocomplete = True
		  
		  // Initialise a basic autocompletion engine.
		  InitialiseAutocomplete
		  
		  ConstructTabBar
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditCopy() As Boolean Handles EditCopy.Action
			// Copies the contents of the current selection in the editor to the clipboard.
			
			Var c As New Clipboard
			If Editor.TextSelected Then
			c.Text = Editor.CurrentSelection.ToString
			Else
			c.Text = ""
			End If
			c.Close
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCut() As Boolean Handles EditCut.Action
			// Cuts the contents of the current selection in the editor and puts it on the clipboard.
			
			Var c As New Clipboard
			If Editor.TextSelected Then
			c.Text = Editor.CurrentSelection.ToString
			Else
			c.Text = ""
			End If
			c.Close
			
			Editor.DeleteSelection(True, True, True, "Cut Text")
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
			// Pastes the contents of the clipboard into the editor.
			
			// Get the clipboard text (replacing any line endings with UNIX ones).
			Var c As New Clipboard
			Var t As String = c.Text.ReplaceLineEndings(&u0A)
			c.Close
			
			// Insert the text.
			If t.CharacterCount > 0 Then
			If Editor.TextSelected Then
			Editor.ReplaceCurrentSelection(t)
			Else
			Editor.Insert(t, Editor.CaretPosition, True)
			End If
			End If
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditRedo() As Boolean Handles EditRedo.Action
			If UndoManager.CanRedo Then
			UndoManager.Redo
			End If
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditSelectAll() As Boolean Handles EditSelectAll.Action
			// Select everything in the editor.
			
			Self.Editor.SelectAll
			
			Return True
			
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditUndo() As Boolean Handles EditUndo.Action
			If UndoManager.CanUndo Then
			UndoManager.Undo
			End If
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21, Description = 436F6E737472756374732074686520746162206261722E
		Private Sub ConstructTabBar()
		  /// Constructs the tab bar.
		  
		  TabBar.Renderer = New XUITabBarRendererSafari(TabBar)
		  TabBar.Style = XUITabBarStyle.Safari
		  
		  TabBar.AppendTab("Syntax", Nil, Nil, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InitialiseAutocomplete()
		  AutocompleteEngine = New CodeEngineDemoAutocompleteEngine(False)
		  
		  AutocompleteEngine.AddOption("String")
		  AutocompleteEngine.AddOption("Strict")
		  AutocompleteEngine.AddOption("Structure")
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 4F75722064656D6F206175746F636F6D706C65746520656E67696E652E
		Private AutocompleteEngine As CodeEngineDemoAutocompleteEngine
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520756E646F206D616E6167657220666F72207468652064656D6F20656469746F722E
		UndoManager As XUIUndoManager
	#tag EndProperty


#tag EndWindowCode

#tag Events InfoTimer
	#tag Event
		Sub Action()
		  Info.Text = "Ln " + Editor.CaretLineNumber.ToString + ", Col " + _
		  Editor.CaretColumn.ToString
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupFormatters
	#tag Event
		Sub Opening()
		  Me.AddRow("Markdown")
		  Me.RowTagAt(Me.LastAddedRowIndex) = New XUICEMarkdownFormatter
		  Me.AddRow("Plain Text")
		  Me.RowTagAt(Me.LastAddedRowIndex) = New XUICETextFormatter
		  Me.AddRow("Wren")
		  Me.RowTagAt(Me.LastAddedRowIndex) = New XUICEWrenFormatter
		  
		  Me.SelectedRowIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  Editor.Formatter = Me.RowTagAt(Me.SelectedRowIndex)
		  
		  If UndoManager <> Nil Then UndoManager.RemoveAll
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event , Description = 54686520656469746F722069732061626F757420746F20626520646973706C617965642E
		Sub Opening()
		  Me.Theme = XUICETheme.FromFile(SpecialFolder.Resource("Nova.toml"))
		  
		  Me.HighlightDelimitersAroundCaret = True
		  
		  Editor.ContentType = XUICodeEditor.ContentTypes.SourceCode
		  
		  Editor.AutocompleteCombo = XUICodeEditor.AutocompleteCombos.CtrlSpace
		  
		  Me.HighlightCurrentLine = True
		  
		  Me.BorderColor = New ColorGroup(&cD7D9D9, &c2A2A2A)
		End Sub
	#tag EndEvent
	#tag Event , Description = 54686520636F646520656469746F722069732061736B696E6720666F72206175746F636F6D706C6574696F6E206F7074696F6E7320666F72207468652073706563696669656420607072656669786020617420606361726574436F6C756D6E60206F6E206C696E65206E756D626572206063617265744C696E65602E20596F752073686F756C642072657475726E204E696C20696620746865726520617265206E6F6E652E
		Function AutocompleteDataForPrefix(prefix As String, caretLine As Integer, caretColumn As Integer) As XUICEAutocompleteData
		  #Pragma Unused caretLine
		  #Pragma Unused caretColumn
		  
		  Return AutocompleteEngine.DataForPrefix(prefix)
		  
		End Function
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
