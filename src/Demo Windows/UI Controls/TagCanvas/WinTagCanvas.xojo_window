#tag DesktopWindow
Begin DemoWindow WinTagCanvas
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
   MenuBar         =   1647693823
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "TagCanvas Demo"
   Type            =   0
   Visible         =   False
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
      Scope           =   2
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
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Value           =   1
      Visible         =   True
      Width           =   762
      Begin XUITagCanvas CountryCodesTagCanvas
         AllowAutocomplete=   True
         AutoDeactivate  =   True
         CaretBlinkPeriod=   500
         Enabled         =   True
         HasBorder       =   True
         HasFocus        =   False
         Height          =   120
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
         Scope           =   2
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
         Height          =   100
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
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "In this example, typing a country's name will create a tag whose value is the country's two digit ISO 3166-1 code. Anything other than a country name will be rejected.\n\nPressing Return, Tab or the comma key will trigger parsing."
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   236
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
         Scope           =   2
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
      Begin XUITagCanvas EmailTagCanvas
         AllowAutocomplete=   True
         AutoDeactivate  =   True
         CaretBlinkPeriod=   250
         Enabled         =   True
         HasBorder       =   True
         HasFocus        =   False
         Height          =   120
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
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         TagsHaveWidget  =   True
         Tooltip         =   ""
         Top             =   104
         Visible         =   True
         Width           =   722
      End
      Begin DesktopLabel LabelAboutEmailTagCanvas
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   100
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "In this example only valid email addresses are accepted and converted into tags. Anything other than an email address will be rejected.\n\nPressing Return, Tab or the comma key will trigger parsing."
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   236
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   722
      End
      Begin DesktopLabel InfoEmail
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
         LockRight       =   False
         LockTop         =   False
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Email Info"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   576
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   722
      End
      Begin XUITagCanvas SuperHeroTagCanvas
         AllowAutocomplete=   True
         AutoDeactivate  =   True
         CaretBlinkPeriod=   250
         Enabled         =   True
         HasBorder       =   True
         HasFocus        =   False
         Height          =   120
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
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         TagsHaveWidget  =   True
         Tooltip         =   ""
         Top             =   104
         Visible         =   True
         Width           =   722
      End
      Begin DesktopLabel AboutSuperHeroesDemo
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   80
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "In this demo, type the alter ego of a super hero and the parslet will convert it to their super hero name. You can see a list of known alter egos in the listbox below.\n\nPressing Return, Tab or the comma key will trigger parsing."
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   236
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   722
      End
      Begin DesktopListBox HeroesListBox
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   2
         ColumnWidths    =   ""
         DefaultRowHeight=   -1
         DropIndicatorVisible=   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   236
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   "Alter Ego	Super Hero Name"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   328
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   722
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin DesktopLabel InfoSuperHeroes
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
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Super Heroes Info"
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
      Scope           =   2
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
      Scope           =   2
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
      Scope           =   2
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
      Scope           =   2
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
      Scope           =   2
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
		  InitialiseSuperHeroesAutocompleteEngine
		  InitialiseSuperHeroesListBox
		  
		  InfoCountryCodes.Text = ""
		  InfoEmail.Text = ""
		  InfoSuperHeroes.Text = ""
		  
		  CountryCodesAutocompleteEngine.AddOption("France 12", New XUITagData("France 12"))
		  CountryCodesAutocompleteEngine.AddOption("France 34", New XUITagData("France 34"))
		  CountryCodesAutocompleteEngine.AddOption("France 56", New XUITagData("France 56"))
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileCloseWindow() As Boolean Handles FileCloseWindow.Action
		  Self.Hide
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler


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

	#tag Method, Flags = &h21, Description = 496E697469616C697365732061206261736963206175746F636F6D706C6574696F6E20656E67696E652077697468207375706572206865726F206E616D65732E
		Private Sub InitialiseSuperHeroesAutocompleteEngine()
		  /// Initialises a basic autocompletion engine with super hero names.
		  ///
		  /// Typing the character's alter ego in the tag field will create a tag whose title is their 
		  /// superhero name.
		  
		  Self.SuperHeroAutocompleteEngine = New TagCanvasDemoAutocompleteEngine(False)
		  
		  SuperHeroAutocompleteEngine.AddOption("Bruce Banner", New XUITagData("Hulk"))
		  SuperHeroAutocompleteEngine.AddOption("Bruce Wayne", New XUITagData("Batman"))
		  SuperHeroAutocompleteEngine.AddOption("Bucky Barnes", New XUITagData("Winter Soldier"))
		  SuperHeroAutocompleteEngine.AddOption("Carol Danvers", New XUITagData("Captain Marvel"))
		  SuperHeroAutocompleteEngine.AddOption("Clark Kent", New XUITagData("Superman"))
		  SuperHeroAutocompleteEngine.AddOption("Clint Barton", New XUITagData("Hawkeye"))
		  SuperHeroAutocompleteEngine.AddOption("Diana Prince", New XUITagData("Wonder Woman"))
		  SuperHeroAutocompleteEngine.AddOption("Flint Marko", New XUITagData("Sandman"))
		  SuperHeroAutocompleteEngine.AddOption("James Howlett", New XUITagData("Wolverine"))
		  SuperHeroAutocompleteEngine.AddOption("James Rhodes", New XUITagData("War Machine"))
		  SuperHeroAutocompleteEngine.AddOption("Max Dillon", New XUITagData("Electro"))
		  SuperHeroAutocompleteEngine.AddOption("Nadia Pym", New XUITagData("Wasp"))
		  SuperHeroAutocompleteEngine.AddOption("Natasha Romanoff", New XUITagData("Black Widow"))
		  SuperHeroAutocompleteEngine.AddOption("Norman Osborn", New XUITagData("Green Goblin"))
		  SuperHeroAutocompleteEngine.AddOption("Otto  Octavius", New XUITagData("Dr Octopus"))
		  SuperHeroAutocompleteEngine.AddOption("Peter Parker", New XUITagData("Spider-Man"))
		  SuperHeroAutocompleteEngine.AddOption("Peter Quill", New XUITagData("Star-Lord"))
		  SuperHeroAutocompleteEngine.AddOption("Scott Lang", New XUITagData("Ant-Man"))
		  SuperHeroAutocompleteEngine.AddOption("Stephen Strange", New XUITagData("Dr Strange"))
		  SuperHeroAutocompleteEngine.AddOption("Steve Rogers", New XUITagData("Captain America"))
		  SuperHeroAutocompleteEngine.AddOption("Tony Stark", New XUITagData("Iron Man"))
		  SuperHeroAutocompleteEngine.AddOption("Wade Wilson", New XUITagData("Deadpool"))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E697469616C6973657320746865204C697374426F7820636F6E7461696E696E6720746865207375706572206865726F206E616D657320616E6420616C7465722065676F732E
		Private Sub InitialiseSuperHeroesListBox()
		  /// Initialises the ListBox containing the super hero names and alter egos.
		  
		  If Self.SuperHeroAutocompleteEngine = Nil Then Return
		  
		  HeroesListBox.RemoveAllRows
		  For Each option As XUITagAutocompleteOption In Self.SuperHeroAutocompleteEngine.Options
		    
		    HeroesListBox.AddRow(option.Value, option.TagData.Title)
		    
		  Next option
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SwitchToPanel(index As Integer)
		  /// Switches to the specified panel and adjusts the height of the window.
		  
		  Select Case index
		  Case PANEL_COUNTRY_CODES
		    Self.Height = HEIGHT_COUNTRY_CODES
		    
		  Case PANEL_EMAIL
		    Self.Height = HEIGHT_EMAIL
		    
		  Case PANEL_SUPER_HEROES
		    Self.Height = HEIGHT_SUPER_HEROES
		    
		  Else
		    Raise New InvalidArgumentException("Unknown panel index.")
		  End Select
		  
		  Panel.SelectedPanelIndex = index
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 41206261736963206175746F636F6D706C6574696F6E20656E67696E6520666F7220636F756E74727920636F6465732E
		Private CountryCodesAutocompleteEngine As TagCanvasDemoAutocompleteEngine
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41206261736963206175746F636F6D706C6574696F6E20656E67696E6520666F722073757065726865726F206E616D65732E
		SuperHeroAutocompleteEngine As TagCanvasDemoAutocompleteEngine
	#tag EndProperty


	#tag Constant, Name = HEIGHT_COUNTRY_CODES, Type = Double, Dynamic = False, Default = \"380", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HEIGHT_EMAIL, Type = Double, Dynamic = False, Default = \"380", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HEIGHT_SUPER_HEROES, Type = Double, Dynamic = False, Default = \"616", Scope = Private
	#tag EndConstant

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
		  Me.SelectRowWithTag(PANEL_COUNTRY_CODES)
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  SwitchToPanel(Me.RowTagAt(Me.SelectedRowIndex))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CountryCodesTagCanvas
	#tag Event , Description = 54686520636F6E74726F6C206973206F70656E696E672E
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
#tag Events EmailTagCanvas
	#tag Event , Description = 416464656420607461676020746F20746865207461672063616E7661732E
		Sub AddedTag(tag As XUITag)
		  InfoEmail.Text = "Added tag """ + tag.Title + """"
		End Sub
	#tag EndEvent
	#tag Event , Description = 412074616720686173206265656E20636C69636B65642E
		Sub ClickedTag(tag As XUITag, isContextualClick As Boolean)
		  If IsContextualClick Then
		    InfoEmail.Text = "Right clicked tag """ + tag.Title + """"
		  Else
		    InfoEmail.Text = "Left clicked tag """ + tag.Title + """"
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 54686520636F6E74726F6C206973206F70656E696E672E
		Sub Opening()
		  // Assign our custom country codes parselet.
		  Me.Parselet = New XUIEmailTagParselet
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 412074616720686173206265656E2072656D6F7665642066726F6D20746865207461672063616E7661732E204966206076696144696E677573602069732054727565207468656E2074686520746167207761732072656D6F7665642062656361757365207468652064696E6775732077617320636C69636B65642E
		Sub RemovedTag(tag As XUITag, viaWidget As Boolean)
		  InfoEmail.Text = "Removed tag """ + tag.Title + """" + If(viaWidget, " via the widget", "")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SuperHeroTagCanvas
	#tag Event , Description = 416464656420607461676020746F20746865207461672063616E7661732E
		Sub AddedTag(tag As XUITag)
		  InfoSuperHeroes.Text = "Added tag """ + tag.Title + """"
		End Sub
	#tag EndEvent
	#tag Event , Description = 546865207461672063616E7661732069732061736B696E6720666F72206175746F636F6D706C6574696F6E206F7074696F6E7320666F7220746865207370656369666965642060707265666978602E20596F752073686F756C642072657475726E204E696C20696620746865726520617265206E6F6E652E
		Function AutocompleteDataForPrefix(prefix As String) As XUITagAutocompleteData
		  Return SuperHeroAutocompleteEngine.DataForPrefix(prefix)
		  
		End Function
	#tag EndEvent
	#tag Event , Description = 412074616720686173206265656E20636C69636B65642E
		Sub ClickedTag(tag As XUITag, isContextualClick As Boolean)
		  If IsContextualClick Then
		    InfoSuperHeroes.Text = "Right clicked tag """ + tag.Title + """"
		  Else
		    InfoSuperHeroes.Text = "Left clicked tag """ + tag.Title + """"
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 54686520636F6E74726F6C206973206F70656E696E672E
		Sub Opening()
		  // Assign a basic parselet that will accept any input.
		  Me.Parselet = New XUIDefaultTagParselet
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 412074616720686173206265656E2072656D6F7665642066726F6D20746865207461672063616E7661732E204966206076696144696E677573602069732054727565207468656E2074686520746167207761732072656D6F7665642062656361757365207468652064696E6775732077617320636C69636B65642E
		Sub RemovedTag(tag As XUITag, viaWidget As Boolean)
		  InfoSuperHeroes.Text = "Removed tag """ + tag.Title + """" + If(viaWidget, " via the widget", "")
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
		    CountryCodesTagCanvas.Renderer = New XUITagCanvasRendererMonterey(CountryCodesTagCanvas)
		    EmailTagCanvas.Renderer = New XUITagCanvasRendererMonterey(EmailTagCanvas)
		    SuperHeroTagCanvas.Renderer = New XUITagCanvasRendererMonterey(SuperHeroTagCanvas)
		  Case "Windows 11"
		    CountryCodesTagCanvas.Renderer = New XUITagCanvasRendererWindows11(CountryCodesTagCanvas)
		    EmailTagCanvas.Renderer = New XUITagCanvasRendererWindows11(EmailTagCanvas)
		    SuperHeroTagCanvas.Renderer = New XUITagCanvasRendererWindows11(SuperHeroTagCanvas)
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
		  
		  CountryCodesTagCanvas.Style = Me.RowTagAt(Me.SelectedRowIndex)
		  EmailTagCanvas.Style = Me.RowTagAt(Me.SelectedRowIndex)
		  SuperHeroTagCanvas.Style = Me.RowTagAt(Me.SelectedRowIndex)
		  
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
