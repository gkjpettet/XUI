#tag DesktopWindow
Begin DesktopWindow WinTagCanvas
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
   MenuBar         =   819644415
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "TagCanvas Demo"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin XUITagCanvas TagCanvas
      AllowAutocomplete=   True
      AutoDeactivate  =   True
      CaretBlinkPeriod=   500
      Enabled         =   True
      Height          =   126
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LineHeight      =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MinimumAutocompletionLength=   0
      Multiline       =   True
      ParseOnComma    =   True
      ParseOnReturn   =   True
      ParseOnTab      =   True
      ParseTriggers   =   ""
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Visible         =   True
      Width           =   560
   End
   Begin DesktopLabel Info
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
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  InitialiseAutocomplete
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
			// Pastes the contents of the clipboard into the tag canvas.
			
			// Get the clipboard text (replacing any line endings with UNIX ones).
			Var c As New Clipboard
			Var s As String = c.Text.ReplaceLineEndings(&u0A)
			c.Close
			
			// Insert the text.
			If s.CharacterCount > 0 Then TagCanvas.InsertString(s)
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub InitialiseAutocomplete()
		  // Initialises our basic demo autocompletion engine.
		  
		  Self.AutocompleteEngine = New TagCanvasDemoAutocompleteEngine(False)
		  
		  AutocompleteEngine.AddOption("Bruce Banner", New XUITagData("Hulk"))
		  AutocompleteEngine.AddOption("Bucky Barnes", New XUITagData("Winter Soldier"))
		  AutocompleteEngine.AddOption("Carol Danvers", New XUITagData("Captain Marvel"))
		  AutocompleteEngine.AddOption("Clint Barton", New XUITagData("Hawkeye"))
		  AutocompleteEngine.AddOption("James Rhodes", New XUITagData("War Machine"))
		  AutocompleteEngine.AddOption("Nadia Pym", New XUITagData("Wasp"))
		  AutocompleteEngine.AddOption("Natasha Romanoff", New XUITagData("Black Widow"))
		  AutocompleteEngine.AddOption("Peter Parker", New XUITagData("Spider-Man"))
		  AutocompleteEngine.AddOption("Peter Quill", New XUITagData("Star-Lord"))
		  AutocompleteEngine.AddOption("Scott Lang", New XUITagData("Ant-Man"))
		  AutocompleteEngine.AddOption("Stephen Strange", New XUITagData("Dr Strange"))
		  AutocompleteEngine.AddOption("Steve Rogers", New XUITagData("Captain America"))
		  AutocompleteEngine.AddOption("Tony Stark", New XUITagData("Iron Man"))
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 41206261736963206175746F636F6D706C6574696F6E20656E67696E6520666F7220746865207461672063616E7661732E
		AutocompleteEngine As TagCanvasDemoAutocompleteEngine
	#tag EndProperty


#tag EndWindowCode

#tag Events TagCanvas
	#tag Event
		Sub Opening()
		  Var style As New XUITagCanvasStyle
		  style.BackgroundColor = Color.White
		  style.TagBackgroundColor = Color.FromString("&h00F2F2F2")
		  style.TagBorderColor = Color.Black
		  style.TagTextColor = Color.Black
		  style.CaretColor = Color.Black
		  
		  #If TargetWindows
		    style.FontSize = 14
		  #Else
		    style.FontSize = 0
		  #EndIf
		  
		  Me.Style = style
		  Me.TagRenderer = New XUIWindowsTagRenderer(Me)
		  Me.Parselet = New XUIDefaultTagParselet
		End Sub
	#tag EndEvent
	#tag Event , Description = 412074616720686173206265656E20636C69636B65642E
		Sub ClickedTag(tag As XUITag, isContextualClick As Boolean)
		  If isContextualClick Then
		    Info.Text = "Right clicked tag """ + tag.Title + """"
		  Else
		    Info.Text = "Left clicked tag """ + tag.Title + """"
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 412074616720686173206265656E2072656D6F7665642066726F6D20746865207461672063616E7661732E204966206076696144696E677573602069732054727565207468656E2074686520746167207761732072656D6F7665642062656361757365207468652064696E6775732077617320636C69636B65642E
		Sub RemovedTag(tag As XUITag, viaDingus As Boolean)
		  Info.Text = "Removed tag """ + tag.Title + """" + If(viaDingus, " via the dingus", "")
		End Sub
	#tag EndEvent
	#tag Event , Description = 546865207461672063616E7661732069732061736B696E6720666F72206175746F636F6D706C6574696F6E206F7074696F6E7320666F7220746865207370656369666965642060707265666978602E20596F752073686F756C642072657475726E204E696C20696620746865726520617265206E6F6E652E
		Function AutocompleteDataForPrefix(prefix As String) As XUITagAutocompleteData
		  Var data As XUITagAutocompleteData = AutocompleteEngine.DataForPrefix(prefix)
		  
		  Return data
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
