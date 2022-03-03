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
   Height          =   760
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
   Visible         =   False
   Width           =   1290
   Begin XUICodeEditor Editor
      AllowInertialScrolling=   True
      AutoDeactivate  =   True
      BackgroundColor =   &c00000000
      BlinkCaret      =   True
      CaretColour     =   &c00000000
      ContentType     =   "XUICodeEditor.ContentTypes.SourceCode"
      CurrentLineHighlightColor=   &c00000000
      CurrentLineNumberColor=   &c00000000
      Enabled         =   True
      HasHorizontalScrollbar=   True
      HasVerticalScrollbar=   True
      Height          =   715
      HighlightDelimitersAroundCaret=   True
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LineNumberColor =   &c00000000
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      SelectionColour =   &c00000000
      SpacesPerTab    =   4
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TokeniseMode    =   "XUICodeEditor.TokeniseModes.All"
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   1290
   End
   Begin DesktopPopupMenu PopupFormatters
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   1134
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   727
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   136
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
      Left            =   871
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
      Top             =   727
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
		  // Create an undo manager.
		  UndoManager = New XUIUndoManager
		  
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


	#tag Property, Flags = &h0, Description = 54686520756E646F206D616E6167657220666F72207468652064656D6F20656469746F722E
		UndoManager As XUIUndoManager
	#tag EndProperty


#tag EndWindowCode

#tag Events Editor
	#tag Event , Description = 54686520656469746F722069732061626F757420746F20626520646973706C617965642E
		Sub Opening()
		  Me.Theme = XUICETheme.FromFile(SpecialFolder.Resource("XUICodeEditor Theme.toml"))
		  
		  'Me.Theme = XUICETheme.FromFile(New FolderItem("/Users/garry/Repos/Merlin/themes/Hawk Light.xool"))
		  
		  Me.Formatter = New XUICETextFormatter
		  
		  Me.HighlightDelimitersAroundCaret = True
		  
		  Me.UndoManager = Self.UndoManager
		  Me.FontName = "SF Mono"
		  Me.FontSize = 15
		  Me.LineNumberFontSize = 12
		  
		  Editor.ContentType = XUICodeEditor.ContentTypes.SourceCode
		  
		  Editor.AutocompleteCombo = XUICodeEditor.AutocompleteCombos.CtrlSpace
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
#tag Events InfoTimer
	#tag Event
		Sub Action()
		  Info.Text = "Ln " + Editor.CaretLineNumber.ToString + ", Col " + _
		  Editor.CaretColumn.ToString
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
