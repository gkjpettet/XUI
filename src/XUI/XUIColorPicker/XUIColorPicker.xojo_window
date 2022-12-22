#tag DesktopWindow
Begin DesktopWindow XUIColorPicker Implements XUINotificationListener
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   364
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "Choose A Color"
   Type            =   1
   Visible         =   True
   Width           =   321
   Begin DesktopButton ButtonOK
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "OK"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   167
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   324
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton ButtonCancel
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   75
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   324
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin XUIImageButton ButtonSliders
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BorderColor     =   &c00000000
      DefaultImage    =   1502371839
      DisabledImage   =   0
      Enabled         =   True
      HasBottomBorder =   False
      HasLeftBorder   =   False
      HasRightBorder  =   False
      HasTopBorder    =   False
      Height          =   28
      HoverImage      =   0
      Index           =   -2147483648
      IsPressed       =   True
      Left            =   271
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      PressedImage    =   1694777343
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   8
      Transparent     =   True
      Type            =   1
      Visible         =   True
      Width           =   40
   End
   Begin DesktopPagePanel PanelMain
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   179
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   131
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   321
      Begin DesktopTextField SlidersRGBHexValue
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
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "PanelMain"
         Italic          =   False
         Left            =   13
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   143
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   80
      End
      Begin DesktopPopupMenu Popup
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PanelMain"
         InitialValue    =   "CMY\nRGB\nHSV"
         Italic          =   False
         Left            =   241
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   1
         TabIndex        =   14
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   143
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   67
      End
      Begin DesktopPagePanel PanelSliders
         AllowAutoDeactivate=   True
         Enabled         =   True
         Height          =   125
         Index           =   -2147483648
         InitialParent   =   "PanelMain"
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
         TabIndex        =   15
         TabPanelIndex   =   1
         TabStop         =   False
         Tooltip         =   ""
         Top             =   171
         Transparent     =   False
         Value           =   0
         Visible         =   True
         Width           =   321
         Begin DesktopTextField SliderRedValue
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
            Hint            =   "R"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   272
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   3
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "255"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   180
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "###"
            Visible         =   True
            Width           =   35
         End
         Begin DesktopTextField SliderGreenValue
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
            Hint            =   "G"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   272
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   3
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   1
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "255"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   208
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "###"
            Visible         =   True
            Width           =   35
         End
         Begin DesktopTextField SliderBlueValue
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
            Hint            =   "B"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   272
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   3
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   2
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "255"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   236
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "###"
            Visible         =   True
            Width           =   35
         End
         Begin DesktopTextField SliderAlphaRGBValue
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
            Hint            =   "A"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   272
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   3
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   3
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "255"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   264
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "###"
            Visible         =   True
            Width           =   35
         End
         Begin XUIColorComponentSlider SliderAlphaRGB
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   "XUIColorComponentSlider.ColorModes.RGB"
            CompleteColor   =   &cFF930000
            ComponentType   =   "XUIColorComponentSlider.Types.Red"
            ComponentValue  =   255.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   4
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   267
            Transparent     =   True
            Visible         =   True
            Width           =   247
         End
         Begin XUIColorComponentSlider SliderBlue
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   "XUIColorComponentSlider.ColorModes.RGB"
            CompleteColor   =   &cFF930000
            ComponentType   =   1
            ComponentValue  =   125.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   5
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   239
            Transparent     =   True
            Visible         =   True
            Width           =   247
         End
         Begin XUIColorComponentSlider SliderGreen
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   "XUIColorComponentSlider.ColorModes.RGB"
            CompleteColor   =   &cFF930000
            ComponentType   =   2
            ComponentValue  =   50.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   6
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   211
            Transparent     =   True
            Visible         =   True
            Width           =   247
         End
         Begin XUIColorComponentSlider SliderRed
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   "XUIColorComponentSlider.ColorModes.RGB"
            CompleteColor   =   &cFF930000
            ComponentType   =   3
            ComponentValue  =   200.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   7
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   183
            Transparent     =   True
            Visible         =   True
            Width           =   247
         End
         Begin XUIColorComponentSlider SliderHue
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   2
            CompleteColor   =   &c00000000
            ComponentType   =   4
            ComponentValue  =   0.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   0
            TabPanelIndex   =   2
            TabStop         =   True
            Tooltip         =   ""
            Top             =   183
            Transparent     =   True
            Visible         =   True
            Width           =   237
         End
         Begin XUIColorComponentSlider SliderSaturation
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   2
            CompleteColor   =   &c00000000
            ComponentType   =   5
            ComponentValue  =   0.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   1
            TabPanelIndex   =   2
            TabStop         =   True
            Tooltip         =   ""
            Top             =   211
            Transparent     =   True
            Visible         =   True
            Width           =   237
         End
         Begin XUIColorComponentSlider SliderValue
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   2
            CompleteColor   =   &c00000000
            ComponentType   =   6
            ComponentValue  =   0.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   2
            TabPanelIndex   =   2
            TabStop         =   True
            Tooltip         =   ""
            Top             =   239
            Transparent     =   True
            Visible         =   True
            Width           =   237
         End
         Begin XUIColorComponentSlider SliderAlphaHSV
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   2
            CompleteColor   =   &c00000000
            ComponentType   =   0
            ComponentValue  =   0.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   3
            TabPanelIndex   =   2
            TabStop         =   True
            Tooltip         =   ""
            Top             =   267
            Transparent     =   True
            Visible         =   True
            Width           =   237
         End
         Begin DesktopTextField SliderHueValue
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
            Hint            =   "H"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   262
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   4
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   4
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "1"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   180
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "#.###"
            Visible         =   True
            Width           =   45
         End
         Begin DesktopTextField SliderSaturationValue
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
            Hint            =   "S"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   262
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   4
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   5
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "1"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   208
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "#.###"
            Visible         =   True
            Width           =   45
         End
         Begin DesktopTextField SliderValueValue
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
            Hint            =   "V"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   262
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   4
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   6
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "1"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   236
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "#.###"
            Visible         =   True
            Width           =   45
         End
         Begin DesktopTextField SliderAlphaHSVValue
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
            Hint            =   "A"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   262
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   3
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   7
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   "255"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   264
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "###"
            Visible         =   True
            Width           =   45
         End
         Begin XUIColorComponentSlider SliderCyan
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   1
            CompleteColor   =   &c00000000
            ComponentType   =   7
            ComponentValue  =   0.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   0
            TabPanelIndex   =   3
            TabStop         =   True
            Tooltip         =   ""
            Top             =   183
            Transparent     =   True
            Visible         =   True
            Width           =   237
         End
         Begin XUIColorComponentSlider SliderMagenta
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   1
            CompleteColor   =   &c00000000
            ComponentType   =   8
            ComponentValue  =   0.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   1
            TabPanelIndex   =   3
            TabStop         =   True
            Tooltip         =   ""
            Top             =   211
            Transparent     =   True
            Visible         =   True
            Width           =   237
         End
         Begin XUIColorComponentSlider SliderYellow
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   1
            CompleteColor   =   &c00000000
            ComponentType   =   9
            ComponentValue  =   0.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   2
            TabPanelIndex   =   3
            TabStop         =   True
            Tooltip         =   ""
            Top             =   239
            Transparent     =   True
            Visible         =   True
            Width           =   237
         End
         Begin XUIColorComponentSlider SliderAlphaCMY
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            ColorMode       =   1
            CompleteColor   =   &c00000000
            ComponentType   =   0
            ComponentValue  =   0.0
            Enabled         =   True
            Height          =   16
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Left            =   13
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   3
            TabPanelIndex   =   3
            TabStop         =   True
            Tooltip         =   ""
            Top             =   267
            Transparent     =   True
            Visible         =   True
            Width           =   237
         End
         Begin DesktopTextField SliderCyanValue
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
            Hint            =   "C"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   262
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   4
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   4
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "1"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   180
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "#.###"
            Visible         =   True
            Width           =   45
         End
         Begin DesktopTextField SliderMagentaValue
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
            Hint            =   "M"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   262
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   4
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   5
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "1"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   208
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "#.###"
            Visible         =   True
            Width           =   45
         End
         Begin DesktopTextField SliderYellowValue
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
            Hint            =   "Y"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   262
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   4
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   6
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "1"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   236
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "#.###"
            Visible         =   True
            Width           =   45
         End
         Begin DesktopTextField SliderAlphaCMYValue
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
            Hint            =   "A"
            Index           =   -2147483648
            InitialParent   =   "PanelSliders"
            Italic          =   False
            Left            =   262
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            MaximumCharactersAllowed=   3
            Password        =   False
            ReadOnly        =   False
            Scope           =   2
            TabIndex        =   7
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   "255"
            TextAlignment   =   0
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   264
            Transparent     =   False
            Underline       =   False
            ValidationMask  =   "###"
            Visible         =   True
            Width           =   45
         End
      End
      Begin XUIColorPickerColorDotCanvas ColorDots
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         DotDiameter     =   16
         Enabled         =   True
         GapWidth        =   6
         Height          =   26
         Index           =   -2147483648
         InitialParent   =   "PanelMain"
         Left            =   15
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedIndex   =   3
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   143
         Transparent     =   True
         Visible         =   True
         Width           =   291
      End
      Begin XUIColorPickerSwatchCanvas Swatches
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   129
         Index           =   -2147483648
         InitialParent   =   "PanelMain"
         Left            =   15
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedColor   =   &c00000000
         SelectedIndex   =   0
         SwatchHeight    =   25
         SwatchVerticalPadding=   5
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   181
         Transparent     =   True
         Visible         =   True
         Width           =   291
      End
   End
   Begin DesktopCanvas ColorCanvas
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   90
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   44
      Transparent     =   True
      Visible         =   True
      Width           =   321
   End
   Begin XUIImageButton ButtonSwatches
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BorderColor     =   &c00000000
      DefaultImage    =   1752608767
      DisabledImage   =   0
      Enabled         =   True
      HasBottomBorder =   False
      HasLeftBorder   =   False
      HasRightBorder  =   False
      HasTopBorder    =   False
      Height          =   28
      HoverImage      =   0
      Index           =   -2147483648
      IsPressed       =   False
      Left            =   225
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      PressedImage    =   1233405951
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   8
      Transparent     =   True
      Type            =   1
      Visible         =   True
      Width           =   40
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  RegisterForNotifications
		  
		  // Start on the sliders panel.
		  ButtonSliders.IsPressed = True
		  SwitchMainPanel(PANEL_MAIN_SLIDERS)
		  PanelSliders.SelectedPanelIndex = PANEL_SLIDERS_RGB
		  
		  CurrentColor = mCurrentColor
		  
		  // =============
		  // SLIDER EVENTS
		  // =============
		  // RGB sliders.
		  AddHandler SliderRed.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderRed.PressedSlider, AddressOf ColorComponentSliderPressed
		  AddHandler SliderGreen.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderGreen.PressedSlider, AddressOf ColorComponentSliderPressed
		  AddHandler SliderBlue.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderBlue.PressedSlider, AddressOf ColorComponentSliderPressed
		  AddHandler SliderAlphaRGB.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderAlphaRGB.PressedSlider, AddressOf ColorComponentSliderPressed
		  
		  // HSV sliders.
		  AddHandler SliderHue.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderHue.PressedSlider, AddressOf ColorComponentSliderPressed
		  AddHandler SliderSaturation.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderSaturation.PressedSlider, AddressOf ColorComponentSliderPressed
		  AddHandler SliderValue.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderValue.PressedSlider, AddressOf ColorComponentSliderPressed
		  AddHandler SliderAlphaHSV.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderAlphaHSV.PressedSlider, AddressOf ColorComponentSliderPressed
		  
		  // CMY sliders.
		  AddHandler SliderCyan.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderCyan.PressedSlider, AddressOf ColorComponentSliderPressed
		  AddHandler SliderMagenta.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderMagenta.PressedSlider, AddressOf ColorComponentSliderPressed
		  AddHandler SliderYellow.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderYellow.PressedSlider, AddressOf ColorComponentSliderPressed
		  AddHandler SliderAlphaCMY.IsDraggingScrubber, AddressOf DraggingColorComponentSliderScrubber
		  AddHandler SliderAlphaCMY.PressedSlider, AddressOf ColorComponentSliderPressed
		  
		  AppearanceChanged
		  
		  Update
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, Description = 48616E646C657320616E204F5320617070656172616E6365206368616E67652028652E672E206C6967687420746F206461726B206D6F646520737769746368292E
		Private Sub AppearanceChanged()
		  /// Handles an OS appearance change (e.g. light to dark mode switch).
		  
		  // Ensure we use the correct button images.
		  If Color.IsDarkMode Then
		    
		    ButtonSwatches.DefaultImage = XUIColorPickerIconSwatchesDark
		    ButtonSwatches.PressedImage = XUIColorPickerIconSwatchesSelectedDark
		    
		    ButtonSliders.DefaultImage = XUIColorPickerIconSlidersDark
		    ButtonSliders.PressedImage = XUIColorPickerIconSlidersSelectedDark
		    
		  Else
		    
		    ButtonSwatches.DefaultImage = XUIColorPickerIconSwatches
		    ButtonSwatches.PressedImage = XUIColorPickerIconSwatchesSelected
		    
		    ButtonSliders.DefaultImage = XUIColorPickerIconSliders
		    ButtonSliders.PressedImage = XUIColorPickerIconSlidersSelected
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C656761746520666F722068616E646C696E6720746865207072657373696E67206F662061205247424120736C696465722E
		Private Sub ColorComponentSliderPressed(slider As XUIColorComponentSlider, newColor As Color)
		  /// Delegate for handling the pressing of a colour component slider.
		  
		  #Pragma Unused slider
		  
		  CurrentColor = newColor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E2054616B6573206120436F6C6F722E
		Sub Constructor(startingColor As Color)
		  /// Default constructor. Takes a Color.
		  
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  CurrentColor = startingColor
		  mStartingColor = startingColor
		  
		  AppearanceChanged
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416464732074686520636F6C6F757220646F747320616E642074686569722070616C65747465732E
		Private Sub ConstructPalettes()
		  // Constructs the colour dots and their palettes.
		  
		  ColorDots.RemoveAllDots
		  
		  // =============
		  // GREY
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&c737C84, "Grey", _
		  &cF8F9FA, &cF1F3F5, &cE9ECEF, &cDEE2E6, &cCED4DA, &cADB5BD, &c868E96, &c495057, &c343A40, &c212529))
		  
		  // =============
		  // RED
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&cF53843, "Red", _
		  &cFFF5F5, &cFFE3E3, &cFFC9C9, &cFFA8A8, &cFF8787, &cFF6B6B, &cFA5252, &cF03E3E, &cE03131, &cC92A2A))
		  
		  // =============
		  // PINK
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&cDD2F6D, "Pink", _
		  &cFFF0F6, &cFFDEEB, &cFCC2D7, &cFAA2C1, &cF783AC, &cF06595, &cE64980, &cD6336C, &cC2255C, &cA61E4D))
		  
		  // =============
		  // GRAPE
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&cAF2BD2, "Grape", _
		  &cF8F0FC, &cF3D9FA, &cF3D9FA, &cE599F7, &cDA77F2, &cCC5DE8, &cBE4BDB, &cAE3EC9, &c9C36B5, &c9C36B5))
		  
		  // =============
		  // VIOLET
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&c6431EE, "Violet", _
		  &cF3F0FF, &cE5DBFF, &cD0BFFF, &cB197FC, &c9775FA, &c845EF7, &c7950F2, &c7048E8, &c6741D9, &c5F3DC4))
		  
		  // =============
		  // INDIGO
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&c3B53F1, "Indigo", _
		  &cEDF2FF, &cDBE4FF, &cBAC8FF, &c91A7FF, &c748FFC, &c5C7CFA, &c4C6EF5, &c4263EB, &c3B5BDB, &c364FC7))
		  
		  // =============
		  // BLUE
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&c1F74DF, "Blue", _
		  &cE7F5FF, &cD0EBFF, &cA5D8FF, &c74C0FC, &c4DABF7, &c339AF0, &c228BE6, &c1C7ED6, &c1971C2, &c1864AB))
		  
		  // =============
		  // CYAN
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&c1C9AB1, "Cyan", _
		  &cE3FAFC, &cC5F6FA, &c99E9F2, &c66D9E8, &c3BC9DB, &c22B8CF, &c15AABF, &c1098AD, &c0C8599, &c0B7285))
		  
		  // =============
		  // TEAL
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&c1BAD74, "Teal", _
		  &cE6FCF5, &cC3FAE8, &c96F2D7, &c63E6BE, &c38D9A9, &c20C997, &c12B886, &c0CA678, &c099268, &c087F5B))
		  
		  // =============
		  // GREEN
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&c38B745, "Green", _
		  &cEBFBEE, &cD3F9D8, &cB2F2BB, &c8CE99A, &c69DB7C, &c51CF66, &c40C057, &c37B24D, &c2F9E44, &c2B8A3E))
		  
		  // =============
		  // LIME
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&c72C218, "Lime", _
		  &cF4FCE3, &cE9FAC8, &cD8F5A2, &cC0EB75, &cA9E34B, &c94D82D, &c82C91E, &c74B816, &c66A80F, &c5C940D))
		  
		  // =============
		  // YELLOW
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&cF8A109, "Yellow", _
		  &cFFF9DB, &cFFF3BF, &cFFEC99, &cFFE066, &cFFD43B, &cFCC419, &cFAB005, &cF59F00, &cF08C00, &cE67700))
		  
		  // =============
		  // ORANGE
		  // =============
		  ColorDots.AddDot(New XUIColorPickerColorDot(&cF96713, "Orange", _
		  &CFFF4E6, &cFFE8CC, &cFFD8A8, &cFFC078, &cFFA94D, &cFF922B, &cFD7E14, &cF76707, &cE8590C, &cD9480F))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C656761746520666F722068616E646C696E6720746865206472616767696E67206F66206120636F6C6F757220636F6D706F6E656E7420736C696465722073637275626265722E
		Private Sub DraggingColorComponentSliderScrubber(slider As XUIColorComponentSlider)
		  /// Delegate for handling the dragging of a colour component slider scrubber.
		  
		  Select Case slider.ColorMode
		  Case XUIColorComponentSlider.ColorModes.RGB
		    Select Case slider.ComponentType
		    Case XUIColorComponentSlider.ComponentTypes.Red
		      CurrentColor = _
		      Color.RGB(slider.ComponentValue, mCurrentColor.Green, mCurrentColor.Blue, mCurrentColor.Alpha)
		      
		    Case XUIColorComponentSlider.ComponentTypes.Blue
		      CurrentColor = _
		      Color.RGB(mCurrentColor.Red, mCurrentColor.Green, slider.ComponentValue, mCurrentColor.Alpha)
		      
		    Case XUIColorComponentSlider.ComponentTypes.Green
		      CurrentColor = _
		      Color.RGB(mCurrentColor.Red, slider.ComponentValue, mCurrentColor.Blue, mCurrentColor.Alpha)
		      
		    Case XUIColorComponentSlider.ComponentTypes.Alpha
		      CurrentColor = _
		      Color.RGB(mCurrentColor.Red, mCurrentColor.Green, mCurrentColor.Blue, slider.ComponentValue)
		    End Select
		    
		  Case XUIColorComponentSlider.ColorModes.HSV
		    Select Case slider.ComponentType
		    Case XUIColorComponentSlider.ComponentTypes.Hue
		      CurrentColor = _
		      Color.HSV(slider.ComponentValue, mCurrentColor.Saturation, mCurrentColor.Value, mCurrentColor.Alpha)
		      
		    Case XUIColorComponentSlider.ComponentTypes.Saturation
		      CurrentColor = _
		      Color.HSV(mCurrentColor.Hue, slider.ComponentValue, mCurrentColor.Value, mCurrentColor.Alpha)
		      
		    Case XUIColorComponentSlider.ComponentTypes.Value
		      CurrentColor = _
		      Color.HSV(mCurrentColor.Hue, mCurrentColor.Saturation, slider.ComponentValue, mCurrentColor.Alpha)
		      
		    Case XUIColorComponentSlider.ComponentTypes.Alpha
		      CurrentColor = _
		      Color.HSV(mCurrentColor.Hue, mCurrentColor.Saturation, mCurrentColor.Value, slider.ComponentValue)
		    End Select
		    
		  Case XUIColorComponentSlider.ColorModes.CMY
		    Select Case slider.ComponentType
		    Case XUIColorComponentSlider.ComponentTypes.Cyan
		      CurrentColor = _
		      Color.CMY(slider.ComponentValue, mCurrentColor.Magenta, mCurrentColor.Yellow, mCurrentColor.Alpha)
		      
		    Case XUIColorComponentSlider.ComponentTypes.Magenta
		      CurrentColor = _
		      Color.CMY(mCurrentColor.Cyan, slider.ComponentValue, mCurrentColor.Yellow, mCurrentColor.Alpha)
		      
		    Case XUIColorComponentSlider.ComponentTypes.Yellow
		      CurrentColor = _
		      Color.CMY(mCurrentColor.Cyan, mCurrentColor.Magenta, slider.ComponentValue, mCurrentColor.Alpha)
		      
		    Case XUIColorComponentSlider.ComponentTypes.Alpha
		      CurrentColor = _
		      Color.CMY(mCurrentColor.Cyan, mCurrentColor.Magenta, mCurrentColor.Yellow, slider.ComponentValue)
		    End Select
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41206E6F74696669636174696F6E20686173206265656E2072656365697665642066726F6D20746865204E6F74696669636174696F6E2043656E7465722E
		Sub NotificationReceived(n As XUINotification)
		  /// A notification has been received from the Notification Center.
		  ///
		  /// Part of the XUINotificationListener interface.
		  
		  Select Case n.Key
		  Case App.NOTIFICATION_APPEARANCE_CHANGED
		    // A light/dark mode switch has occurred. 
		    AppearanceChanged
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656672657368657320616C6C2074686520636F6E74726F6C73206F6E2074686520434D5920736C69646572732070616E656C20746F207265666C65637420606D43757272656E74436F6C6F72602E
		Private Sub RefreshCMYSlidersPanel()
		  /// Refreshes all the controls on the CMY sliders panel to reflect `mCurrentColor`.
		  
		  /// RGB value.
		  SlidersRGBHexValue.Text = mCurrentColor.ToRGBString
		  
		  // Main colour canvas.
		  ColorCanvas.Refresh
		  
		  // Component sliders.
		  SliderCyan.CompleteColor = mCurrentColor
		  SliderMagenta.CompleteColor = mCurrentColor
		  SliderYellow.CompleteColor = mCurrentColor
		  SliderAlphaCMY.CompleteColor = mCurrentColor
		  
		  // Component values.
		  SliderCyanValue.Text = mCurrentColor.Cyan.ToString(Locale.Current, "#.###")
		  SliderMagentaValue.Text = mCurrentColor.Magenta.ToString(Locale.Current, "#.###")
		  SliderYellowValue.Text = mCurrentColor.Yellow.ToString(Locale.Current, "#.###")
		  SliderAlphaCMYValue.Text = mCurrentColor.Alpha.ToString
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656672657368657320616C6C2074686520636F6E74726F6C73206F6E207468652048535620736C69646572732070616E656C20746F207265666C65637420606D43757272656E74436F6C6F72602E
		Private Sub RefreshHSVSlidersPanel()
		  /// Refreshes all the controls on the HSV sliders panel to reflect `mCurrentColor`.
		  
		  /// RGB value.
		  SlidersRGBHexValue.Text = mCurrentColor.ToRGBString
		  
		  // Main colour canvas.
		  ColorCanvas.Refresh
		  
		  // Component sliders.
		  SliderHue.CompleteColor = mCurrentColor
		  SliderSaturation.CompleteColor = mCurrentColor
		  SliderValue.CompleteColor = mCurrentColor
		  SliderAlphaHSV.CompleteColor = mCurrentColor
		  
		  // Component values.
		  SliderHueValue.Text = mCurrentColor.Hue.ToString(Locale.Current, "#.###")
		  SliderSaturationValue.Text = mCurrentColor.Saturation.ToString(Locale.Current, "#.###")
		  SliderValueValue.Text = mCurrentColor.Value.ToString(Locale.Current, "#.###")
		  SliderAlphaHSVValue.Text = mCurrentColor.Alpha.ToString
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshRGBASlidersPanel()
		  /// Refreshes all the controls on the RGBA sliders panel to reflect `mCurrentColor`.
		  
		  /// RGB value.
		  SlidersRGBHexValue.Text = mCurrentColor.ToRGBString
		  
		  // Main colour canvas.
		  ColorCanvas.Refresh
		  
		  // Component sliders.
		  SliderRed.CompleteColor = mCurrentColor
		  SliderGreen.CompleteColor = mCurrentColor
		  SliderBlue.CompleteColor = mCurrentColor
		  SliderAlphaRGB.CompleteColor = mCurrentColor
		  
		  // Component values.
		  SliderRedValue.Text = mCurrentColor.Red.ToString
		  SliderGreenValue.Text = mCurrentColor.Green.ToString
		  SliderBlueValue.Text = mCurrentColor.Blue.ToString
		  SliderAlphaRGBValue.Text = mCurrentColor.Alpha.ToString
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265676973746572732074686520656469746F7220666F722064657369726564206E6F74696669636174696F6E732E
		Private Sub RegisterForNotifications()
		  /// Registers the color picker for desired notifications.
		  
		  If App IsA XUIApp Then
		    Self.ListenForKey(App.NOTIFICATION_APPEARANCE_CHANGED)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 537769746368657320746F2074686520737065636966696564206D61696E2070616E656C2E
		Private Sub SwitchMainPanel(panelIndex As Integer)
		  /// Switches to the specified main panel.
		  
		  Select Case panelIndex
		  Case PANEL_MAIN_SLIDERS
		    PanelMain.SelectedPanelIndex = PANEL_MAIN_SLIDERS
		    Self.Height = HEIGHT_SLIDERS
		    
		  Case PANEL_MAIN_SWATCHES
		    PanelMain.SelectedPanelIndex = PANEL_MAIN_SWATCHES
		    Self.Height = HEIGHT_SWATCHES
		    ColorDots.SelectedIndex = 4
		    Swatches.RemoveAllColors
		    For Each c As Color In ColorDots.SelectedDot.Palette
		      Swatches.AddColor(c, False)
		    Next c
		    Swatches.SelectedIndex = 3
		    CurrentColor = Swatches.SelectedColor
		    
		  Else
		    Raise New InvalidArgumentException("Unknown panel index (" + panelIndex.ToString + ").")
		  End Select
		  
		  Me.Refresh(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320616C6C20636F6E74726F6C7320746F206D61746368207468652063757272656E7420636F6C6F75722E
		Private Sub Update()
		  /// Updates all controls to match the current colour.
		  
		  RefreshRGBASlidersPanel
		  RefreshHSVSlidersPanel
		  RefreshCMYSlidersPanel
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 5468652073656C656374656420636F6C6F757220696E20746865207069636B657220686173206368616E6765642E
		Event ColorChanged(newColor As Color)
	#tag EndHook


	#tag Note, Name = About
		A beautiful colour picker tool.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E746C792073656C656374656420636F6C6F75722E
		#tag Getter
			Get
			  Return mCurrentColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCurrentColor = value
			  
			  // RGB sliders.
			  SliderRed.ComponentValue = mCurrentColor.Red
			  SliderGreen.ComponentValue = mCurrentColor.Green
			  SliderBlue.ComponentValue = mCurrentColor.Blue
			  SliderAlphaRGB.ComponentValue = mCurrentColor.Alpha
			  
			  // HSV sliders.
			  SliderHue.ComponentValue = mCurrentColor.Hue
			  SliderSaturation.ComponentValue = mCurrentColor.Saturation
			  SliderValue.ComponentValue = mCurrentColor.Value
			  SliderAlphaHSV.ComponentValue = mCurrentColor.Alpha
			  
			  // CMY sliders.
			  SliderCyan.ComponentValue = mCurrentColor.Cyan
			  SliderMagenta.ComponentValue = mCurrentColor.Magenta
			  SliderYellow.ComponentValue = mCurrentColor.Yellow
			  SliderAlphaCMY.ComponentValue = mCurrentColor.Alpha
			  
			  Update
			  
			  'RaiseEvent ColorChanged(mCurrentColor)
			End Set
		#tag EndSetter
		CurrentColor As Color
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E746C792073656C656374656420636F6C6F75722E
		Private mCurrentColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207374617274696E6720636F6C6F72207768656E20746865207069636B6572206669727374206F70656E732E
		Private mStartingColor As Color
	#tag EndProperty


	#tag Constant, Name = HEIGHT_SLIDERS, Type = Double, Dynamic = False, Default = \"364", Scope = Private, Description = 5468652068656967687420746865207069636B65722077696E646F772073686F756C64206265207768656E20646973706C6179696E672074686520736C69646572732070616E656C2E
	#tag EndConstant

	#tag Constant, Name = HEIGHT_SWATCHES, Type = Double, Dynamic = False, Default = \"530", Scope = Private, Description = 5468652068656967687420746865207069636B65722077696E646F772073686F756C64206265207768656E20646973706C6179696E67207468652073776174636865732070616E656C2E
	#tag EndConstant

	#tag Constant, Name = PANEL_MAIN_SLIDERS, Type = Double, Dynamic = False, Default = \"0", Scope = Private, Description = 496E646578206F66207468652070616E656C20636F6E7461696E696E672074686520736C69646572732E
	#tag EndConstant

	#tag Constant, Name = PANEL_MAIN_SWATCHES, Type = Double, Dynamic = False, Default = \"1", Scope = Private, Description = 496E646578206F66207468652070616E656C20636F6E7461696E696E6720746865206D61696E2073776174636865732E
	#tag EndConstant

	#tag Constant, Name = PANEL_SLIDERS_CMY, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 496E646578206F66207468652070616E656C20636F6E7461696E696E67207468652052474220736C69646572732E
	#tag EndConstant

	#tag Constant, Name = PANEL_SLIDERS_HSV, Type = Double, Dynamic = False, Default = \"1", Scope = Private, Description = 496E646578206F66207468652070616E656C20636F6E7461696E696E67207468652052474220736C69646572732E
	#tag EndConstant

	#tag Constant, Name = PANEL_SLIDERS_RGB, Type = Double, Dynamic = False, Default = \"0", Scope = Private, Description = 496E646578206F66207468652070616E656C20636F6E7461696E696E67207468652052474220736C69646572732E
	#tag EndConstant


#tag EndWindowCode

#tag Events ButtonOK
	#tag Event
		Sub Pressed()
		  RaiseEvent ColorChanged(CurrentColor)
		  
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonCancel
	#tag Event
		Sub Pressed()
		  // The user wants to cancel changing the colour. Revert back to the starting colour.
		  RaiseEvent ColorChanged(mStartingColor)
		  
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonSliders
	#tag Event , Description = 54686520627574746F6E20686173206265656E20707265737365642E
		Sub Pressed()
		  ButtonSwatches.IsPressed = False
		  SwitchMainPanel(PANEL_MAIN_SLIDERS)
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SlidersRGBHexValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  // If the user pressed Return then update the colour controls if we have a valid hex string.
		  If Key = Chr(13) Then
		    If Me.Text.IsRGBA Then
		      CurrentColor = XUIColors.FromRGBAString(Me.Text)
		      Update
		    End If
		    Return True
		  End If
		  
		  Select Case key
		  Case String.ChrByte(28), String.ChrByte(29), String.ChrByte(30), String.ChrByte(31), String.ChrByte(8)
		    // Permit the arrow keys and backspace delete.
		    Return False
		  End Select
		  
		  If Not Key.IsHexDigit Then Return True
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Popup
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  
		  Select Case Me.SelectedRowValue
		  Case "RGB"
		    PanelSliders.SelectedPanelIndex = PANEL_SLIDERS_RGB
		    
		  Case "HSV"
		    PanelSliders.SelectedPanelIndex = PANEL_SLIDERS_HSV
		    
		  Case "CMY"
		    PanelSliders.SelectedPanelIndex = PANEL_SLIDERS_CMY
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown color mode in panel popup")
		  End Select
		  
		  Update
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SliderRedValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.RGB(Integer.FromString(Me.Text), mCurrentColor.Green, mCurrentColor.Blue, mCurrentColor.Alpha)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderGreenValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.RGB(mCurrentColor.Red, Integer.FromString(Me.Text), mCurrentColor.Blue, mCurrentColor.Alpha)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderBlueValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.RGB(mCurrentColor.Red, mCurrentColor.Green, Integer.FromString(Me.Text), mCurrentColor.Alpha)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderAlphaRGBValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.RGB(mCurrentColor.Red, mCurrentColor.Green, mCurrentColor.Blue, Integer.FromString(Me.Text))
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderHueValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.HSV(Double.FromString(Me.Text), mCurrentColor.Saturation, mCurrentColor.Value, mCurrentColor.Alpha)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderSaturationValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.HSV(mCurrentColor.Hue, Double.FromString(Me.Text), mCurrentColor.Value, mCurrentColor.Alpha)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderValueValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.HSV(mCurrentColor.Hue, mCurrentColor.Saturation, Double.FromString(Me.Text), mCurrentColor.Alpha)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderAlphaHSVValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.HSV(mCurrentColor.Hue, mCurrentColor.Saturation, mCurrentColor.Value, Integer.FromString(Me.Text))
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderCyanValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.CMY(Double.FromString(Me.Text), mCurrentColor.Magenta, mCurrentColor.Yellow, mCurrentColor.Alpha)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderMagentaValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.CMY(mCurrentColor.Cyan, Double.FromString(Me.Text), mCurrentColor.Yellow, mCurrentColor.Alpha)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderYellowValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.CMY(mCurrentColor.Cyan, mCurrentColor.Magenta, Double.FromString(Me.Text), mCurrentColor.Alpha)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events SliderAlphaCMYValue
	#tag Event
		Function KeyDown(key As String) As Boolean
		  If Key = Chr(13) Then
		    CurrentColor = _
		    Color.CMY(mCurrentColor.Cyan, mCurrentColor.Magenta, mCurrentColor.Yellow, Integer.FromString(Me.Text))
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ColorDots
	#tag Event , Description = 5468652075736572206A7573742070726573736564206120636F6C6F7220646F742E
		Sub PressedColorDot(dot As XUIColorPickerColorDot)
		  Swatches.RemoveAllColors
		  
		  For Each c As Color In dot.Palette
		    Swatches.AddColor(c, False)
		  Next c
		  
		  // Select the centre dot.
		  Swatches.SelectedIndex = (dot.Palette.Count / 2)
		  
		  CurrentColor = Swatches.SelectedColor
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  ConstructPalettes
		  
		  Me.SelectedIndex = 0
		  
		  Swatches.RemoveAllColors
		  Swatches.AddColors(Me.SelectedDot.Palette)
		  Swatches.SelectedIndex = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Swatches
	#tag Event , Description = 546865207573657220636C69636B6564206120636F6C6F7572207377617463682E
		Sub PressedSwatch(selectedColor As Color)
		  CurrentColor = selectedColor
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ColorCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  g.DrawingColor = mCurrentColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonSwatches
	#tag Event , Description = 54686520627574746F6E20686173206265656E20707265737365642E
		Sub Pressed()
		  ButtonSliders.IsPressed = False
		  SwitchMainPanel(PANEL_MAIN_SWATCHES)
		  
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
	#tag ViewProperty
		Name="CurrentColor"
		Visible=false
		Group="Behavior"
		InitialValue="&c000000"
		Type="Color"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
