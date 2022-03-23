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
   Height          =   616
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "TagCanvas Demo"
   Type            =   0
   Visible         =   True
   Width           =   762
   Begin DesktopPopupMenu PopupDemo
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
      Left            =   104
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   182
   End
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   532
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   3
      Panels          =   ""
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   762
      Begin XUITagCanvas CountryCodes
         AllowAutocomplete=   True
         AutoDeactivate  =   True
         CaretBlinkPeriod=   500
         Enabled         =   True
         HasBorder       =   True
         HasFocus        =   False
         Height          =   175
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   20
         LineHeight      =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MinimumAutocompletionLength=   2
         Multiline       =   True
         ParseOnComma    =   True
         ParseOnReturn   =   True
         ParseOnTab      =   True
         ParseTriggers   =   ""
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         TagsHaveWidget  =   True
         Tooltip         =   ""
         Top             =   104
         Visible         =   True
         Width           =   722
      End
      Begin DesktopLabel LabelAboutCountryCodes
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   50
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "In this example, typing a country's name will create a tag whose value is the country's two digit ISO 3166-1 code. Anything other than a country name will be rejected."
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   291
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   722
      End
      Begin DesktopLabel InfoCountryCodes
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
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Country Codes Info"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   576
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   722
      End
   End
   Begin DesktopLabel LabelDemo
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Demo:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   72
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
      Left            =   560
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   182
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
      Left            =   476
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
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
      Width           =   72
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
      Left            =   560
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   182
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
      Left            =   476
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   6
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
      Width           =   72
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  InitialiseCountryCodesAutocompleteEngine
		  
		  InfoCountryCodes.Text = ""
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, Description = 496E697469616C697365732061206261736963206175746F636F6D706C6574696F6E20656E67696E65207769746820636F756E74727920636F6465732E
		Private Sub InitialiseCountryCodesAutocompleteEngine()
		  /// Initialises a basic autocompletion engine with country codes.
		  ///
		  /// Typing the country's name in the tag field will create a tag whose title is their country code.
		  
		  Self.CountryCodesAutocompleteEngine = New TagCanvasDemoAutocompleteEngine(False)
		  
		  For Each entry As DictionaryEntry In CountryCodesParselet.CountryNameCodeDict
		    CountryCodesAutocompleteEngine.AddOption(entry.Key, New XUITagData(entry.Key))
		  Next entry
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 41206261736963206175746F636F6D706C6574696F6E20656E67696E6520666F7220636F756E74727920636F6465732E
		Private CountryCodesAutocompleteEngine As TagCanvasDemoAutocompleteEngine
	#tag EndProperty


	#tag Constant, Name = PANEL_COUNTRY_CODES, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_EMAIL, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_SUPER_HEROES, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events PopupDemo
	#tag Event
		Sub Opening()
		  Me.AddRow("Email Addresses")
		  Me.RowTagAt(Me.LastAddedRowIndex) = PANEL_EMAIL
		  Me.AddRow("Country Codes")
		  Me.RowTagAt(Me.LastAddedRowIndex) = PANEL_COUNTRY_CODES
		  Me.AddRow("Super Heroes")
		  Me.RowTagAt(Me.LastAddedRowIndex) = PANEL_SUPER_HEROES
		  
		  // Start on the country codes demo.
		  Me.SelectedRowIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  Panel.SelectedPanelIndex = Me.RowTagAt(Me.SelectedRowIndex)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CountryCodes
	#tag Event
		Sub Opening()
		  // Assign our custom country codes parselet.
		  Me.Parselet = New CountryCodesParselet
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 412074616720686173206265656E20636C69636B65642E
		Sub ClickedTag(tag As XUITag, isContextualClick As Boolean)
		  If IsContextualClick Then
		    InfoCountryCodes.Text = "Right clicked tag """ + tag.Title + """"
		  Else
		    InfoCountryCodes.Text = "Left clicked tag """ + tag.Title + """"
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 412074616720686173206265656E2072656D6F7665642066726F6D20746865207461672063616E7661732E204966206076696144696E677573602069732054727565207468656E2074686520746167207761732072656D6F7665642062656361757365207468652064696E6775732077617320636C69636B65642E
		Sub RemovedTag(tag As XUITag, viaWidget As Boolean)
		  InfoCountryCodes.Text = "Removed tag """ + tag.Title + """" + If(viaWidget, " via the widget", "")
		End Sub
	#tag EndEvent
	#tag Event , Description = 546865207461672063616E7661732069732061736B696E6720666F72206175746F636F6D706C6574696F6E206F7074696F6E7320666F7220746865207370656369666965642060707265666978602E20596F752073686F756C642072657475726E204E696C20696620746865726520617265206E6F6E652E
		Function AutocompleteDataForPrefix(prefix As String) As XUITagAutocompleteData
		  Return CountryCodesAutocompleteEngine.DataForPrefix(prefix)
		  
		End Function
	#tag EndEvent
	#tag Event , Description = 416464656420607461676020746F20746865207461672063616E7661732E
		Sub AddedTag(tag As XUITag)
		  InfoCountryCodes.Text = "Added tag """ + tag.Title + """"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupRenderer
	#tag Event
		Sub Opening()
		  Me.AddRow("Monterey")
		  Me.AddRow("Windows 11")
		  
		  #If TargetWindows Then
		    // Default to the windows 11 style renderer (you don't have to, it just looks more "native").
		    Me.SelectedRowIndex = 1
		  #Else
		    // Default to the Monterey style renderer on macOS and Linux. Again, you can use any renderer on any platform.
		    Me.SelectedRowIndex = 0
		  #EndIf
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  Select Case Me.SelectedRowValue
		  Case "Monterey"
		    CountryCodes.Renderer = New XUITagCanvasRendererMonterey(CountryCodes)
		  Case "Windows 11"
		    CountryCodes.Renderer = New XUITagCanvasRendererWindows11(CountryCodes)
		  Else
		    Raise New UnsupportedOperationException("Unknown renderer name.")
		  End Select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupStyle
	#tag Event
		Sub Opening()
		  Me.AddRow("Monterey")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUITagCanvasStyle.Monterey
		  Me.AddRow("Windows 11")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUITagCanvasStyle.Windows
		  
		  #If TargetWindows Then
		    // Default to the Windows 11 style on Windows. You can use any style you fancy though.
		    Me.SelectedRowIndex = 1
		  #Else
		    // Default to the Monterey style on macOS and Linux.
		    Me.SelectedRowIndex = 0
		  #EndIf
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  CountryCodes.Style = Me.RowTagAt(Me.SelectedRowIndex)
		  
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
