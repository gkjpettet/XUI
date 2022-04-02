#tag DesktopWindow
Begin DesktopWindow WinTextButton
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   True
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "TextButton Demo"
   Type            =   0
   Visible         =   False
   Width           =   600
   Begin DesktopCheckBox CheckBoxEnabled
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Enabled"
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
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   1
      Width           =   100
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Info"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   640
   End
   Begin DesktopCheckBox CheckBoxHasBackgroundColor
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Has Background Color"
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
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   120
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   171
   End
   Begin DesktopLabel LabelAbout
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
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
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Customise the button above with the options below."
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   54
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin DesktopLabel LabelButtonType
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   132
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Button Type:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin DesktopPopupMenu PopupButtonType
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialValue    =   "Push Button\nToggle Button"
      Italic          =   False
      Left            =   244
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   0
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   151
   End
   Begin DesktopLabel Label3
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
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Background Colour:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   152
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   132
   End
   Begin XUITextButton Button
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
      Left            =   250
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PressedColor    =   &cD0D0D0
      PressedTextColor=   &c313131
      Scope           =   0
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c6D6D6D
      Title           =   "Title"
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Type            =   ""
      Visible         =   True
      Width           =   100
   End
   Begin XUIColorSwatch TextColorLightSwatch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      IsActive        =   False
      Left            =   166
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   207
      Transparent     =   True
      Value           =   &c00000000
      Visible         =   True
      Width           =   40
   End
   Begin DesktopLabel Label4
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
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   19
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Text Color:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   207
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   132
   End
   Begin DesktopLabel LabelTextColorLight
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   166
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Light"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   230
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin XUIColorSwatch TextColorDarkSwatch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      IsActive        =   False
      Left            =   227
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   207
      Transparent     =   True
      Value           =   &c00000000
      Visible         =   True
      Width           =   40
   End
   Begin DesktopLabel LabelTextColorDark
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   227
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   22
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Dark"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   230
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin XUIColorSwatch BackgroundColorLightSwatch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      IsActive        =   False
      Left            =   164
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   23
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   152
      Transparent     =   True
      Value           =   &c00000000
      Visible         =   True
      Width           =   40
   End
   Begin DesktopLabel LabelTextColorLight1
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   164
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   24
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Light"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   175
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin XUIColorSwatch BackgroundColorDarkSwatch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      IsActive        =   False
      Left            =   225
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   25
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   152
      Transparent     =   True
      Value           =   &c00000000
      Visible         =   True
      Width           =   40
   End
   Begin DesktopLabel LabelTextColorDark1
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   225
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   26
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Dark"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   175
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin DesktopTextField ButtonTitle
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   "Button Title"
      Index           =   -2147483648
      Italic          =   False
      Left            =   480
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   27
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Title"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   87
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   100
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
      Italic          =   False
      Left            =   416
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   28
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Title:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   88
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   52
   End
   Begin XUIColorSwatch PressedTextColorLightSwatch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      IsActive        =   False
      Left            =   423
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   29
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   207
      Transparent     =   True
      Value           =   &c00000000
      Visible         =   True
      Width           =   40
   End
   Begin DesktopLabel LabelPressedTextColor
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   277
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   30
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Pressed Text Color:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   207
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   132
   End
   Begin DesktopLabel LabelPressedTextColorLight
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   423
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   31
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Light"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   230
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin XUIColorSwatch PressedTextColorDarkSwatch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      IsActive        =   False
      Left            =   484
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   32
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   207
      Transparent     =   True
      Value           =   &c00000000
      Visible         =   True
      Width           =   40
   End
   Begin DesktopLabel LabelPressedTextColorDark
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   484
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   33
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Dark"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   230
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin XUIColorSwatch PressedColorLightSwatch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      IsActive        =   False
      Left            =   166
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   34
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   262
      Transparent     =   True
      Value           =   &c00000000
      Visible         =   True
      Width           =   40
   End
   Begin DesktopLabel LabelPressedColor
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
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   35
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Pressed Color:"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   262
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   132
   End
   Begin DesktopLabel LabelPressedColorLight
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   166
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   36
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Light"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   285
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin XUIColorSwatch PressedColorDarkSwatch
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   20
      Index           =   -2147483648
      IsActive        =   False
      Left            =   227
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   37
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   262
      Transparent     =   True
      Value           =   &c00000000
      Visible         =   True
      Width           =   40
   End
   Begin DesktopLabel LabelPressedColorDark
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   227
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   38
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Dark"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   285
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  #Pragma Warning "TODO: Add font size and family controls"
		  
		  CheckBoxHasBackgroundColor.Value = Button.HasBackgroundColor
		  
		  BackgroundColorLightSwatch.Value = Button.BackgroundColor.Light
		  BackgroundColorDarkSwatch.Value = Button.BackgroundColor.Dark
		  
		  TextColorLightSwatch.Value = Button.TextColor.Light
		  TextColorDarkSwatch.Value = Button.TextColor.Dark
		  
		  PressedTextColorLightSwatch.Value = Button.PressedTextColor.Light
		  PressedTextColorDarkSwatch.Value = Button.PressedTextColor.Dark
		  
		  PressedColorLightSwatch.Value = Button.PressedColor.Light
		  PressedColorDarkSwatch.Value = Button.PressedColor.Dark
		  
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events CheckBoxEnabled
	#tag Event
		Sub ValueChanged()
		  Button.Enabled = Me.Value
		  Info.Text = If(Me.Value, "Enabled ", "Disabled ") + "the button."
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxHasBackgroundColor
	#tag Event
		Sub ValueChanged()
		  Button.HasBackgroundColor = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupButtonType
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  Select Case item.Text
		  Case "Push Button"
		    Button.Type = XUITextButton.Types.PushButton
		  Case "Toggle Button"
		    Button.Type = XUITextButton.Types.ToggleButton
		  End Select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button
	#tag Event , Description = 54686520627574746F6E20686173206265656E20707265737365642E
		Sub Pressed()
		  Info.Text = "Pressed the button"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextColorLightSwatch
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Button.TextColor = New ColorGroup(newColor, Button.TextColor.Dark)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextColorDarkSwatch
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Button.TextColor = New ColorGroup(Button.TextColor.Light, newColor)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BackgroundColorLightSwatch
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Button.BackgroundColor = New ColorGroup(newColor, Button.TextColor.Dark)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BackgroundColorDarkSwatch
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Button.BackgroundColor = New ColorGroup(Button.TextColor.Light, newColor)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonTitle
	#tag Event
		Sub TextChanged()
		  Button.Title = Me.Text
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PressedTextColorLightSwatch
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Button.PressedTextColor = New ColorGroup(newColor, Button.PressedTextColor.Dark)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PressedTextColorDarkSwatch
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Button.PressedTextColor = New ColorGroup(Button.PressedTextColor.Light, newColor)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PressedColorLightSwatch
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Button.PressedColor = New ColorGroup(newColor, Button.PressedColor.Dark)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PressedColorDarkSwatch
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Button.PressedColor = New ColorGroup(Button.PressedColor.Light, newColor)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
