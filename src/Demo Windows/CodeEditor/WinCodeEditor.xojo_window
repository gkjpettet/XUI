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
      Left            =   766
      LeftMenuButtonIcon=   0
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MouseDragX      =   0
      MouseDragY      =   0
      MouseMoveX      =   0
      MouseMoveY      =   0
      RightMenuButtonIcon=   0
      Scope           =   2
      ScrollPosX      =   0
      SelectedTabIndex=   0
      TabCount        =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   494
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
      Left            =   778
      LockBottom      =   True
      LockedInPosition=   True
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
      Width           =   472
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
      Left            =   766
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   28
      Transparent     =   False
      Value           =   3
      Visible         =   True
      Width           =   494
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
         Left            =   879
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   138
      End
      Begin DesktopLabel LabelFormatter
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
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Formatter:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   43
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   81
      End
      Begin DesktopCheckBox CheckBoxBlinkCaret
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Blink Caret"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   780
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   100
      End
      Begin DesktopPopupMenu PopupCaretType
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
         Left            =   892
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   133
      End
      Begin DesktopCheckBox CheckBoxHighlightCurrentLine
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Highlight Current Line"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   780
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   75
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   167
      End
      Begin DesktopLabel LabelFont
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Font:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   107
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   73
      End
      Begin DesktopPopupMenu PopupFont
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
         Left            =   861
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   107
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   181
      End
      Begin DesktopLabel LabelFontSize
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Font Size:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   139
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   103
      End
      Begin DesktopTextField TextFieldFontSize
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   891
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   2
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "12"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   137
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "##"
         Visible         =   True
         Width           =   40
      End
      Begin DesktopLabel LabelLineNumberFontSize
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
         Left            =   953
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "LineNumber Font Size:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   137
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   153
      End
      Begin DesktopTextField TextFieldLineNumberFontSize
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1118
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   2
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "12"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   137
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "##"
         Visible         =   True
         Width           =   40
      End
      Begin DesktopLabel LabelSpacesPerTab
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Spaces Per Tab:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   171
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   103
      End
      Begin DesktopTextField TextFieldSpacesPerTab
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   891
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "4"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   "The number of space characters to use when inserting a tab."
         Top             =   171
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "#"
         Visible         =   True
         Width           =   40
      End
      Begin DesktopCheckBox CheckBoxAllowInertialScrolling
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Inertial Scrolling"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   780
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "If enabled then inertia will be added to scrolling the canvas on Windows & Linux. It's always enabled on macOS."
         Top             =   205
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   135
      End
      Begin DesktopCheckBox CheckBoxHighlightDelimiters
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Highlight Delimiters Around Caret"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   780
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "If True then delimiters (such as `{` and `}`) will be highlighted around the caret. Only supported by some formatters."
         Top             =   237
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   235
      End
      Begin DesktopCheckBox CheckBoxDrawBlockLines
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Draw Block Lines"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1023
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   13
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "If True then block lines will be drawn. Only supported by some formatters."
         Top             =   237
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   135
      End
      Begin DesktopLabel LabelBorderColor
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
         Left            =   1064
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   14
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Border:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   269
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   62
      End
      Begin DesktopCheckBox CheckBoxTopBorder
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Top Border"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   780
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   16
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "If enabled then inertia will be added to scrolling the canvas on Windows & Linux. It's always enabled on macOS."
         Top             =   269
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   111
      End
      Begin DesktopCheckBox CheckBoxBottomBorder
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Bottom Border"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   780
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   17
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "If enabled then inertia will be added to scrolling the canvas on Windows & Linux. It's always enabled on macOS."
         Top             =   301
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   123
      End
      Begin DesktopCheckBox CheckBoxLeftBorder
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Left Border"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   915
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   18
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "If enabled then inertia will be added to scrolling the canvas on Windows & Linux. It's always enabled on macOS."
         Top             =   269
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   111
      End
      Begin DesktopCheckBox CheckBoxRightBorder
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Right Border"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   915
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   19
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   "If enabled then inertia will be added to scrolling the canvas on Windows & Linux. It's always enabled on macOS."
         Top             =   301
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         VisualState     =   0
         Width           =   111
      End
      Begin DesktopListBox ListBoxFormatterTokenTypes
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
         DefaultRowHeight=   22
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
         Height          =   178
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   ""
         Italic          =   False
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   119
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   454
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin DesktopLabel LabelTokenTypes
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "SmallSystem"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   32
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Below are the token types used by this formatter. This is helpful information when creating your own editor themes."
         TextAlignment   =   0
         TextColor       =   &c5E5E5E00
         Tooltip         =   ""
         Top             =   75
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   454
      End
      Begin XUIDotLabel DotLabelSupportsDelimiterHighlighting
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   False
         Backdrop        =   0
         Caption         =   "Delimiter Support"
         CaptionColor    =   &c000000
         CondenseCaption =   True
         DotBorderColor  =   &c000000
         DotColor        =   &c00FF00
         DotDiameter     =   16.0
         DotHasBorder    =   True
         DotPadding      =   5
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   12
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   309
         Transparent     =   True
         Visible         =   True
         Width           =   355
      End
      Begin DesktopLabel LabelExampleThemes
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
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Example Themes:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   43
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   123
      End
      Begin DesktopLabel LabelPopupBackground
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Popup Background:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   43
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   128
      End
      Begin DesktopPopupMenu PopupExampleThemes
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
         Left            =   921
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   162
      End
      Begin DesktopLabel LabelThemeName
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
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Name:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   75
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   84
      End
      Begin DesktopLabel LabelThemeDescription
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
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Description:"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   107
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   84
      End
      Begin DesktopTextField TextFieldThemeName
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
         Hint            =   "Theme Name"
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   882
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   75
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   133
      End
      Begin DesktopLabel LabelThemeAuthor
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
         Left            =   1027
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Author:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   75
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   68
      End
      Begin DesktopTextField TextFieldThemeAuthor
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
         Hint            =   "Theme Author"
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1107
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   75
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   133
      End
      Begin DesktopTextArea TextAreaThemeDescription
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
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
         Height          =   60
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   786
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   139
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   454
      End
      Begin DesktopLabel LabelThemeVersion
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
         Left            =   1001
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Version:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   107
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   68
      End
      Begin DesktopTextField TextFieldThemeVersionMajor
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
         Hint            =   "Major"
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1081
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   3
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   107
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "###"
         Visible         =   True
         Width           =   45
      End
      Begin DesktopTextField TextFieldThemeVersionMinor
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
         Hint            =   "Minor"
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1138
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   3
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   107
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "###"
         Visible         =   True
         Width           =   45
      End
      Begin DesktopTextField TextFieldThemeVersionPatch
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
         Hint            =   "Patch"
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1195
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   3
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   107
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "###"
         Visible         =   True
         Width           =   45
      End
      Begin DesktopBevelButton BevelButtonDeleteToken
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   True
         AllowTabStop    =   False
         BackgroundColor =   &c00000000
         BevelStyle      =   0
         Bold            =   False
         ButtonStyle     =   0
         Caption         =   ""
         CaptionAlignment=   3
         CaptionDelta    =   0
         CaptionPosition =   1
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         HasBackgroundColor=   False
         Height          =   22
         Icon            =   1964765183
         IconAlignment   =   1
         IconDeltaX      =   0
         IconDeltaY      =   0
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   820
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MenuStyle       =   0
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   12
         TabPanelIndex   =   3
         TabStop         =   True
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   620
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   30
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopBevelButton BevelButtonAddToken
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   True
         AllowTabStop    =   False
         BackgroundColor =   &c00000000
         BevelStyle      =   0
         Bold            =   False
         ButtonStyle     =   0
         Caption         =   ""
         CaptionAlignment=   3
         CaptionDelta    =   0
         CaptionPosition =   1
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         HasBackgroundColor=   False
         Height          =   22
         Icon            =   1603276799
         IconAlignment   =   1
         IconDeltaX      =   0
         IconDeltaY      =   0
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   786
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MenuStyle       =   0
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   13
         TabPanelIndex   =   3
         TabStop         =   True
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   620
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   30
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin CodeDemoWindowTokenStyleListBox ListBoxThemeTokens
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   7
         ColumnWidths    =   "*, 25, 25, 25, 70, 45, 70"
         DefaultRowHeight=   28
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
         Height          =   397
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   "Token	B	I	U	Color	Back?	Back"
         Italic          =   False
         Left            =   786
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   14
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   211
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   454
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin DesktopButton ButtonExportTheme
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Export..."
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1160
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   15
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   620
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin DesktopLabel LabelCaretColor
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
         Left            =   1037
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   21
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Caret:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   43
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   89
      End
      Begin DesktopLabel LabelCurrentLineNumberColor
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
         Left            =   987
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   22
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Current Line Number:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   397
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   139
      End
      Begin DesktopLabel LabelUnmatchedBlockLinesColor
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
         Left            =   995
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   24
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Unmatched Blocks:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   365
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   134
      End
      Begin DesktopLabel LabelBlockLinesColor
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   25
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Block Lines:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   365
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   93
      End
      Begin XUIColorSwatch SwatchBackgroundColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   881
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   26
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   333
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchBackgroundColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   935
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   27
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   333
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchUnmatchedBlockLineColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1138
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   28
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   365
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchUnmatchedBlockLineColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   29
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   365
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchBlockLinesColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   881
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   30
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   365
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchBlockLinesColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   935
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   31
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   365
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin DesktopLabel LabelSelectionColor
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
         Left            =   995
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   38
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Selection:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   333
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   130
      End
      Begin XUIColorSwatch SwatchSelectionColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1137
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   39
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   333
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchSelectionColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1191
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   40
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   333
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchCaretColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1138
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   41
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchCaretColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   42
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin DesktopLabel LabelLineNumberColor
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   43
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Line Numbers:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   395
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   93
      End
      Begin XUIColorSwatch SwatchLineNumberColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   881
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   44
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   395
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchLineNumberColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   935
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   45
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   395
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchCurrentLineNumberColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1138
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   46
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   395
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchCurrentLineNumberColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   47
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   395
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchBorderColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1138
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   48
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   269
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchBorderColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   49
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   269
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin DesktopLabel LabelBackground
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   50
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Background:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   333
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   93
      End
      Begin DesktopLabel LabelCurrentLineColour
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
         Left            =   1033
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   51
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Current Line:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   75
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   93
      End
      Begin XUIColorSwatch SwatchCurrentLineColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1138
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   52
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   75
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchCurrentLineColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   53
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   75
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin DesktopGroupBox GroupBoxScrollbars
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   114
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   780
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   54
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   462
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   210
         Begin XUIColorSwatch SwatchScrollbarBackgroundDark
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxScrollbars"
            Left            =   932
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   473
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin XUIColorSwatch SwatchScrollbarBackgroundLight
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxScrollbars"
            Left            =   878
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   1
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   473
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin XUIColorSwatch SwatchScrollbarBorderColorLight
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxScrollbars"
            Left            =   878
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   3
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   507
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin DesktopLabel LabelScrollbarBorder
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "GroupBoxScrollbars"
            Italic          =   False
            Left            =   773
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   4
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Border:"
            TextAlignment   =   3
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   507
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   93
         End
         Begin XUIColorSwatch SwatchScrollbarBorderColorDark
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxScrollbars"
            Left            =   932
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   5
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   507
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin XUIColorSwatch SwatchScrollbarThumbColorLight
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxScrollbars"
            Left            =   878
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   6
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   541
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin XUIColorSwatch SwatchScrollbarThumbColorDark
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxScrollbars"
            Left            =   932
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   8
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   541
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin DesktopLabel LabelScrollbarBackground
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "GroupBoxScrollbars"
            Italic          =   False
            Left            =   773
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   2
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Background:"
            TextAlignment   =   3
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   473
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   93
         End
         Begin DesktopLabel LabelScrollbarThumb
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "GroupBoxScrollbars"
            Italic          =   False
            Left            =   773
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   7
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Thumb:"
            TextAlignment   =   3
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   541
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   93
         End
      End
      Begin DesktopLabel LabelScrollbars
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
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   55
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Scrollbars (Windows && Linux):"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   437
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   196
      End
      Begin DesktopGroupBox GroupBoxDelimiters
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   ""
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   114
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1013
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   56
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   462
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   227
         Begin XUIColorSwatch SwatchDelimitersBorderColorDark
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Left            =   1156
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   0
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   473
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin XUIColorSwatch SwatchDelimitersBorderColorLight
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Left            =   1102
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   1
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   473
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin XUIColorSwatch SwatchDelimitersFillColorLight
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Left            =   1102
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   2
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   507
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin DesktopLabel LabelDelimitersFillColor
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Italic          =   False
            Left            =   1018
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   3
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Fill:"
            TextAlignment   =   3
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   507
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   72
         End
         Begin XUIColorSwatch SwatchDelimitersFillColorDark
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Left            =   1156
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   4
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   507
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin XUIColorSwatch SwatchDelimitersUnderlineColorLight
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Left            =   1102
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   5
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   541
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin XUIColorSwatch SwatchDelimitersUnderlineColorDark
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
            Enabled         =   True
            Height          =   22
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Left            =   1156
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   2
            TabIndex        =   6
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   541
            Transparent     =   True
            Value           =   &c00000000
            Visible         =   True
            Width           =   48
         End
         Begin DesktopLabel LabelDelimitersBorderColor
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Italic          =   False
            Left            =   1018
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   7
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Border:"
            TextAlignment   =   3
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   473
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   72
         End
         Begin DesktopLabel LabelDelimitersUnderlineColor
            AllowAutoDeactivate=   True
            Bold            =   False
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Italic          =   False
            Left            =   1018
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Multiline       =   False
            Scope           =   2
            Selectable      =   False
            TabIndex        =   8
            TabPanelIndex   =   1
            TabStop         =   True
            Text            =   "Underline:"
            TextAlignment   =   3
            TextColor       =   &c000000
            Tooltip         =   ""
            Top             =   541
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   72
         End
         Begin DesktopCheckBox CheckBoxDelimitersHaveBorder
            AllowAutoDeactivate=   True
            Bold            =   False
            Caption         =   ""
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Italic          =   False
            Left            =   1211
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   9
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   473
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            VisualState     =   0
            Width           =   22
         End
         Begin DesktopCheckBox CheckBoxDelimitersHaveFillColor
            AllowAutoDeactivate=   True
            Bold            =   False
            Caption         =   ""
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Italic          =   False
            Left            =   1211
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   10
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   507
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            VisualState     =   0
            Width           =   22
         End
         Begin DesktopCheckBox CheckBoxDelimitersHaveUnderline
            AllowAutoDeactivate=   True
            Bold            =   False
            Caption         =   ""
            Enabled         =   True
            FontName        =   "System"
            FontSize        =   0.0
            FontUnit        =   0
            Height          =   20
            Index           =   -2147483648
            InitialParent   =   "GroupBoxDelimiters"
            Italic          =   False
            Left            =   1211
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   2
            TabIndex        =   11
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   541
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            VisualState     =   0
            Width           =   22
         End
      End
      Begin DesktopLabel LabelDelimiters
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
         Left            =   1013
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   57
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Delimiters:"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   437
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
      Begin DesktopLabel LabelPopupBorder
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
         Left            =   1027
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Popup Border:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   43
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   99
      End
      Begin XUIColorSwatch SwatchAutoCompletePopupBackgroundLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   916
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchAutoCompletePopupBackgroundDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   970
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchAutoCompletePopupBorderLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1138
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchAutoCompletePopupBorderDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   43
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin DesktopLabel LabelAutocompleteOption
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Option:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   77
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   128
      End
      Begin XUIColorSwatch SwatchAutoCompleteOptionColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   916
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   77
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchAutoCompleteOptionColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   970
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   8
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   77
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin DesktopLabel LabelSelectedAutocompleteOptionColor
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
         Left            =   1027
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   9
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Selected Option:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   77
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   99
      End
      Begin XUIColorSwatch SwatchAutoCompleteSelectedOptionColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1138
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   10
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   77
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchAutoCompleteSelectedOptionColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   1192
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   11
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   77
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin DesktopLabel LabelSelectedAutocompleteBackgroundColor
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   12
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Selected Option:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   111
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   128
      End
      Begin XUIColorSwatch SwatchSelectedAutocompleteOptionBackgroundColorLight
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   916
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   13
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   111
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin XUIColorSwatch SwatchSelectedAutocompleteOptionBackgroundColorDark
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   970
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   14
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   111
         Transparent     =   True
         Value           =   &c00000000
         Visible         =   True
         Width           =   48
      End
      Begin DesktopLabel LabelAutocompleteHPadding
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
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   15
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "H Padding:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   "The number of pixels to pad to the left and right of autocomplete options in the autocomplete popup."
         Top             =   143
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   85
      End
      Begin DesktopTextField TextFieldAutocompleteHPadding
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   883
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   2
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   16
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   "The number of pixels to pad to the left and right of autocomplete options in the autocomplete popup."
         Top             =   143
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "##"
         Visible         =   True
         Width           =   35
      End
      Begin DesktopLabel LabelAutocompleteVPadding
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
         Left            =   929
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   17
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "V Padding:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   "The number of pixels to pad above the first and below the last autocomplete options in the autocomplete popup."
         Top             =   143
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   85
      End
      Begin DesktopTextField TextFieldAutocompleteVPadding
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1026
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   2
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   18
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   "The number of pixels to pad above the first and below the last autocomplete options in the autocomplete popup."
         Top             =   143
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "##"
         Visible         =   True
         Width           =   35
      End
      Begin DesktopLabel LabelAutocompleteOptionVPadding
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
         Left            =   1076
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   19
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Option V Padding:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   "The number of pixels to pad above and below autocomplete options in the autocomplete popup."
         Top             =   143
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   117
      End
      Begin DesktopTextField TextFieldAutocompleteOptionVPadding
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1205
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   2
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   20
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   "The number of pixels to pad above and below autocomplete options in the autocomplete popup."
         Top             =   143
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "##"
         Visible         =   True
         Width           =   35
      End
      Begin DesktopCheckBox CheckBoxAllowAutocomplete
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Autocomplete"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   21
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   175
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         VisualState     =   0
         Width           =   118
      End
      Begin DesktopCheckBox CheckBoxAllowAutocompleteInComments
         AllowAutoDeactivate=   True
         Bold            =   False
         Caption         =   "Autocomplete In Comments"
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   916
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   22
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   175
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         VisualState     =   0
         Width           =   202
      End
      Begin DesktopLabel LabelMinAutocompleteLength
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   23
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Minimum Autocomplete Length:"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   207
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   202
      End
      Begin DesktopTextField TextFieldMinAutocompleteLength
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   976
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   2
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   24
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   207
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "##"
         Visible         =   True
         Width           =   35
      End
      Begin DesktopPopupMenu PopupAutocompleteFont
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
         Left            =   839
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   25
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   241
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   181
      End
      Begin DesktopLabel LabelAutocompleteFont
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   26
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Font:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   241
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   51
      End
      Begin DesktopTextField TextFieldAutocompleteFontSize
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1108
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   2
         Password        =   False
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   27
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "12"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   239
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   "##"
         Visible         =   True
         Width           =   40
      End
      Begin DesktopLabel LabelAutocompleteFontSize
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
         Left            =   1027
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   28
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Font Size:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   241
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   69
      End
      Begin DesktopLabel LabelAutocompleteCombo
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
         Left            =   776
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   29
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Autocomplete Combo:"
         TextAlignment   =   3
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   273
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   142
      End
      Begin DesktopPopupMenu PopupAutocompleteCombo
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
         Left            =   930
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         SelectedRowIndex=   0
         TabIndex        =   30
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   273
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   126
      End
      Begin DesktopLabel LabelAutocompleteExplanation
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   40
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   786
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   31
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "You can use your own autocomplete engine with the editor. For the demo however, the following words will be autocompleted if enabled."
         TextAlignment   =   2
         TextColor       =   &c5E5E5E00
         Tooltip         =   ""
         Top             =   318
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   454
      End
      Begin DesktopListBox ListBoxAutocompleteOptions
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
         DefaultRowHeight=   22
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
         Height          =   238
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   ""
         Italic          =   False
         Left            =   786
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   32
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   370
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   454
         _ScrollWidth    =   -1
      End
      Begin DesktopBevelButton BevelButtonDeleteAutocompleteOption
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   True
         AllowTabStop    =   False
         BackgroundColor =   &c00000000
         BevelStyle      =   0
         Bold            =   False
         ButtonStyle     =   0
         Caption         =   ""
         CaptionAlignment=   3
         CaptionDelta    =   0
         CaptionPosition =   1
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         HasBackgroundColor=   False
         Height          =   22
         Icon            =   1964765183
         IconAlignment   =   1
         IconDeltaX      =   0
         IconDeltaY      =   0
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   820
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MenuStyle       =   0
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   33
         TabPanelIndex   =   4
         TabStop         =   True
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   620
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   30
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopBevelButton BevelButtonAddAutocompleteOption
         Active          =   False
         AllowAutoDeactivate=   True
         AllowFocus      =   True
         AllowTabStop    =   False
         BackgroundColor =   &c00000000
         BevelStyle      =   0
         Bold            =   False
         ButtonStyle     =   0
         Caption         =   ""
         CaptionAlignment=   3
         CaptionDelta    =   0
         CaptionPosition =   1
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         HasBackgroundColor=   False
         Height          =   22
         Icon            =   1603276799
         IconAlignment   =   1
         IconDeltaX      =   0
         IconDeltaY      =   0
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   786
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MenuStyle       =   0
         PanelIndex      =   0
         Scope           =   2
         TabIndex        =   34
         TabPanelIndex   =   4
         TabStop         =   True
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   620
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   30
         _mIndex         =   0
         _mInitialParent =   ""
         _mName          =   ""
         _mPanelIndex    =   0
      End
      Begin DesktopButton ButtonClearAutocompleteOptions
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
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   1160
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   35
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   620
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
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
      HasLeftBorder   =   False
      HasRightBorder  =   True
      HasTopBorder    =   False
      Height          =   681
      HighlightCurrentLine=   True
      HighlightDelimitersAroundCaret=   True
      Index           =   -2147483648
      InitialParent   =   ""
      LastFullyVisibleLineNumber=   0
      Left            =   0
      LineNumberColor =   &c00000000
      LineNumberFontSize=   0
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LongestLineChanged=   False
      MinimumAutocompletionLength=   2
      NeedsFullRedraw =   False
      ReadOnly        =   False
      Scope           =   2
      ScrollPosX      =   0
      SelectionColour =   &c00000000
      SpacesPerTab    =   4
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextSelected    =   False
      Tooltip         =   ""
      Top             =   0
      VerticalLinePadding=   0
      Visible         =   True
      Width           =   766
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
		  
		  UpdateAllControls
		  
		  // Start on the "General" setting panel.
		  Panel.SelectedPanelIndex = PANEL_GENERAL
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


	#tag Method, Flags = &h21, Description = 4164647320746865206D6F6E6F737061636520666F6E7473206F6E20746869732073797374656D20746F2060706F707570602E
		Private Sub AddFontsToPopup(popup As DesktopPopupMenu)
		  /// Adds the monospace fonts on this system to `popup`.
		  
		  popup.RemoveAllRows
		  
		  Var monospaceFonts() As String = XUIFonts.AllMonospace
		  For Each font As String In monospaceFonts
		    popup.AddRow(font)
		  Next font
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E737472756374732074686520746162206261722E
		Private Sub ConstructTabBar()
		  /// Constructs the tab bar.
		  
		  TabBar.Renderer = New XUITabBarRendererSafari(TabBar)
		  TabBar.Style = XUITabBarStyle.Safari
		  
		  TabBar.AppendTab("General", Nil, Nil, False)
		  TabBar.AppendTab("Formatter", Nil, Nil, False)
		  TabBar.AppendTab("Theme", Nil, Nil, False)
		  TabBar.AppendTab("Autocomplete", Nil, Nil, False)
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

	#tag Method, Flags = &h21, Description = 52656275696C647320746865206175746F636F6D706C657465206F7074696F6E73206C697374626F782E
		Private Sub RebuildAutocompleteListbox()
		  /// Rebuilds the autocomplete options listbox.
		  
		  ListBoxAutocompleteOptions.RemoveAllRows
		  If Self.AutocompleteEngine <> Nil Then
		    Var options() As XUICEAutocompleteOption = Self.AutocompleteEngine.Options
		    For Each option As XUICEAutocompleteOption In options
		      ListBoxAutocompleteOptions.AddRow(option.Value)
		      ListBoxAutocompleteOptions.CellTypeAt(ListBoxAutocompleteOptions.LastAddedRowIndex, 0) = _
		      DesktopListBox.CellTypes.TextField
		    Next option
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320616C6C20636F6E74726F6C7320746F206D61746368207468652073657474696E677320696E2074686520656469746F722E
		Private Sub UpdateAllControls()
		  /// Updates all controls to match the settings in the editor.
		  
		  UpdateGeneralTabControls
		  UpdateFormatterTabControls
		  UpdateThemeTabControls
		  UpdateAutocompleteTabControls
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320616C6C2074686520636F6E74726F6C73206F6E2074686520224175746F636F6D706C65746522207461622E
		Private Sub UpdateAutocompleteTabControls()
		  /// Updates all the controls on the "Autocomplete" tab.
		  
		  // Sanity check.
		  If Editor.Theme = Nil Then Return
		  
		  SwatchAutoCompletePopupBackgroundLight.Value = Editor.Theme.AutocompletePopupBackgroundColor.Light
		  SwatchAutoCompletePopupBackgroundDark.Value = Editor.Theme.AutocompletePopupBackgroundColor.Dark
		  
		  SwatchAutoCompletePopupBorderLight.Value = Editor.Theme.AutocompletePopupBorderColor.Light
		  SwatchAutoCompletePopupBorderDark.Value = Editor.Theme.AutocompletePopupBorderColor.Dark
		  
		  SwatchAutoCompleteOptionColorLight.Value = Editor.Theme.AutocompleteOptionColor.Light
		  SwatchAutoCompleteOptionColorDark.Value = Editor.Theme.AutocompleteOptionColor.Dark
		  
		  SwatchAutoCompleteSelectedOptionColorLight.Value = Editor.Theme.SelectedAutocompleteOptionColor.Light
		  SwatchAutoCompleteSelectedOptionColorDark.Value = Editor.Theme.SelectedAutocompleteOptionColor.Dark
		  
		  SwatchSelectedAutocompleteOptionBackgroundColorLight.Value = _
		  Editor.Theme.SelectedAutocompleteOptionBackgroundColor.Light
		  
		  SwatchSelectedAutocompleteOptionBackgroundColorDark.Value = _
		  Editor.Theme.SelectedAutocompleteOptionBackgroundColor.Dark
		  
		  TextFieldAutocompleteHPadding.Text = Editor.Theme.AutocompleteHorizontalPadding.ToString
		  TextFieldAutocompleteVPadding.Text = Editor.Theme.AutocompleteVerticalPadding.ToString
		  TextFieldAutocompleteOptionVPadding.Text = Editor.Theme.AutocompleteOptionVerticalPadding.ToString
		  
		  CheckBoxAllowAutocomplete.Value = Editor.AllowAutocomplete
		  CheckBoxAllowAutocompleteInComments.Value = Editor.AllowAutoCompleteInComments
		  
		  TextFieldMinAutocompleteLength.Text = Editor.MinimumAutocompletionLength.ToString
		  
		  If PopupAutocompleteFont.RowCount = 0 Then AddFontsToPopup(PopupAutocompleteFont)
		  #Pragma BreakOnExceptions False
		  Try
		    PopupAutocompleteFont.SelectRowWithValue(Editor.AutocompletePopupFontName)
		  Catch
		  End Try
		  #Pragma BreakOnExceptions Default
		  TextFieldAutocompleteFontSize.Text = Editor.AutocompletePopupFontSize.ToString
		  
		  #Pragma BreakOnExceptions False
		  Try
		    PopupAutocompleteCombo.SelectRowWithTag(Editor.AutocompleteCombo)
		  Catch
		  End Try
		  #Pragma BreakOnExceptions Default
		  
		  RebuildAutocompleteListbox
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320616C6C2074686520636F6E74726F6C73206F6E207468652022466F726D617474657222207461622E
		Private Sub UpdateFormatterTabControls()
		  /// Updates all the controls on the "Formatter" tab.
		  
		  // Delimiter support checkbox.
		  If Editor.Formatter.SupportsDelimiterHighlighting Then
		    DotLabelSupportsDelimiterHighlighting.Caption = "Supports highlighting delimiters"
		    DotLabelSupportsDelimiterHighlighting.DotColor = GREEN_DOT_COLOR
		    DotLabelSupportsDelimiterHighlighting.DotBorderColor = GREEN_DOT_BORDER_COLOR
		  Else
		    DotLabelSupportsDelimiterHighlighting.Caption = "Does not support highlighting delimiters"
		    DotLabelSupportsDelimiterHighlighting.DotColor = RED_DOT_COLOR
		    DotLabelSupportsDelimiterHighlighting.DotBorderColor = RED_DOT_BORDER_COLOR
		  End If
		  
		  UpdateFormatterTokensListBox
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320604C697374426F78466F726D6174746572546F6B656E54797065736020776974682074686520746F6B656E2074797065732075736564206279207468652063757272656E746C792073656C656374656420666F726D61747465722E
		Private Sub UpdateFormatterTokensListBox()
		  /// Updates `ListBoxFormatterTokenTypes` with the token types used by the currently selected formatter.
		  
		  ListBoxFormatterTokenTypes.RemoveAllRows
		  
		  Var tokenTypes() As String = Editor.Formatter.TokenTypes
		  
		  // Sort alphabetically.
		  tokenTypes.Sort
		  
		  For Each token As String In tokenTypes
		    ListBoxFormatterTokenTypes.AddRow(token)
		  Next token
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320616C6C2074686520636F6E74726F6C73206F6E20746865202247656E6572616C22207461622E
		Private Sub UpdateGeneralTabControls()
		  /// Updates all the controls on the "General" tab.
		  
		  // Caret.
		  CheckBoxBlinkCaret.Value = Editor.BlinkCaret
		  PopupCaretType.SelectRowWithTag(editor.CaretType)
		  CheckBoxHighlightCurrentLine.Value = Editor.HighlightCurrentLine
		  
		  // Font family and sizes.
		  If PopupFont.RowCount = 0 Then AddFontsToPopup(PopupFont)
		  #Pragma BreakOnExceptions False
		  Try
		    PopupFont.SelectRowWithValue(Editor.FontName)
		  Catch
		  End Try
		  #Pragma BreakOnExceptions Default
		  TextFieldFontSize.Text = Editor.FontSize.ToString
		  TextFieldLineNumberFontSize.Text = Editor.LineNumberFontSize.ToString
		  
		  TextFieldSpacesPerTab.Text = Editor.SpacesPerTab.ToString
		  
		  #If TargetMacOS
		    // Inertial scrolling is always enabled on macOS so we'll disable the toggle.
		    CheckBoxAllowInertialScrolling.Value = True
		    CheckBoxAllowInertialScrolling.Enabled = False
		  #Else
		    CheckBoxAllowInertialScrolling.Enabled = True
		    CheckBoxAllowInertialScrolling.Value = Editor.AllowInertialScrolling
		  #EndIf
		  
		  CheckBoxHighlightDelimiters.Value = Editor.HighlightDelimitersAroundCaret
		  CheckBoxDrawBlockLines.Value = Editor.DrawBlockLines
		  
		  SwatchBorderColorLight.Value = Editor.BorderColor.Light
		  SwatchBorderColorDark.Value = Editor.BorderColor.Dark
		  CheckBoxTopBorder.Value = Editor.HasTopBorder
		  CheckBoxBottomBorder.Value = Editor.HasBottomBorder
		  CheckBoxLeftBorder.Value = Editor.HasLeftBorder
		  CheckBoxRightBorder.Value = Editor.HasRightBorder
		  
		  // Themeable general properties. These all require a theme to have been assigned to the editor.
		  If Editor.Theme <> Nil Then
		    // Caret colour.
		    SwatchCaretColorLight.Value = Editor.Theme.CaretColor.Light
		    SwatchCaretColorDark.Value = Editor.Theme.CaretColor.Dark
		    
		    // Current line highlight colour.
		    SwatchCurrentLineColorLight.Value = Editor.Theme.CurrentLineHighlightColor.Light
		    SwatchCurrentLineColorDark.Value = Editor.Theme.CurrentLineHighlightColor.Dark
		    
		    // Background.
		    SwatchBackgroundColorLight.Value = Editor.Theme.BackgroundColor.Light
		    SwatchBackgroundColorDark.Value = Editor.Theme.BackgroundColor.Dark
		    
		    // Selection colour.
		    SwatchSelectionColorLight.Value = Editor.Theme.SelectionColor.Light
		    SwatchSelectionColorDark.Value = Editor.Theme.SelectionColor.Dark
		    
		    // Block line colour.
		    SwatchBlockLinesColorLight.Value = Editor.Theme.BlockLineColor.Light
		    SwatchBlockLinesColorDark.Value = Editor.Theme.BlockLineColor.Dark
		    
		    // Unmatched block line colour.
		    SwatchUnmatchedBlockLineColorLight.Value = Editor.Theme.UnmatchedBlockLineColor.Light
		    SwatchUnmatchedBlockLineColorDark.Value = Editor.Theme.UnmatchedBlockLineColor.Dark
		    
		    // Line number colours.
		    SwatchLineNumberColorLight.Value = Editor.Theme.LineNumberColor.Light
		    SwatchLineNumberColorDark.Value = Editor.Theme.LineNumberColor.Dark
		    
		    // Current line number colour.
		    SwatchCurrentLineNumberColorLight.Value = Editor.Theme.CurrentLineNumberColor.Light
		    SwatchCurrentLineNumberColorDark.Value = Editor.Theme.CurrentLineNumberColor.Dark
		    
		    // Scrollbar background colour.
		    SwatchScrollbarBackgroundLight.Value = Editor.Theme.ScrollbarBackgroundColor.Light
		    SwatchScrollbarBackgroundDark.Value = Editor.Theme.ScrollbarBackgroundColor.Dark
		    
		    // Scrollbar border colour.
		    SwatchScrollbarBorderColorLight.Value = Editor.Theme.ScrollbarBorderColor.Light
		    SwatchScrollbarBorderColorDark.Value = Editor.Theme.ScrollbarBorderColor.Dark
		    
		    // Scrollbar thumb colour.
		    SwatchScrollbarThumbColorLight.Value = Editor.Theme.ScrollbarThumbColor.Light
		    SwatchScrollbarThumbColorDark.Value = Editor.Theme.ScrollbarThumbColor.Dark
		    
		    // Delimiters border colour.
		    SwatchDelimitersBorderColorLight.Value = Editor.Theme.DelimitersBorderColor.Light
		    SwatchDelimitersBorderColorDark.Value = Editor.Theme.DelimitersBorderColor.Dark
		    CheckBoxDelimitersHaveBorder.Value = Editor.Theme.DelimitersHaveBorder
		    
		    // Delimiters fill colour.
		    SwatchDelimitersFillColorLight.Value = Editor.Theme.DelimitersFillColor.Light
		    SwatchDelimitersFillColorDark.Value = Editor.Theme.DelimitersFillColor.Dark
		    CheckBoxDelimitersHaveFillColor.Value = Editor.Theme.DelimitersHaveFillColor
		    
		    // Delimiters underline colour.
		    SwatchDelimitersUnderlineColorLight.Value = Editor.Theme.DelimitersUnderlineColor.Light
		    SwatchDelimitersUnderlineColorDark.Value = Editor.Theme.DelimitersUnderlineColor.Dark
		    CheckBoxDelimitersHaveUnderline.Value = Editor.Theme.DelimitersHaveUnderline
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320616C6C2074686520636F6E74726F6C73206F6E207468652022466F726D617474657222207461622E
		Private Sub UpdateThemeTabControls()
		  /// Updates all the controls on the "Theme" tab.
		  
		  // Sanity check.
		  If Editor.Theme = Nil Then Return
		  
		  TextFieldThemeName.Text = Editor.Theme.Name
		  TextFieldThemeAuthor.Text = Editor.Theme.Author
		  TextFieldThemeVersionMajor.Text = Editor.Theme.Version.Major.ToString
		  TextFieldThemeVersionMinor.Text = Editor.Theme.Version.Minor.ToString
		  TextFieldThemeVersionPatch.Text = Editor.Theme.Version.Patch.ToString
		  TextAreaThemeDescription.Text = Editor.Theme.Description
		  
		  ListBoxThemeTokens.Update(Editor.Theme)
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 4F75722064656D6F206175746F636F6D706C65746520656E67696E652E
		Private AutocompleteEngine As CodeEngineDemoAutocompleteEngine
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 54686520436F6C6F7247726F757020746F2075736520666F722063617074696F6E20746578742E
		#tag Getter
			Get
			  Static cg As New ColorGroup(Color.Black, &cd6d6d6)
			  
			  Return cg
			  
			End Get
		#tag EndGetter
		Private mCaptionColor As ColorGroup
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 53657420746F2054727565207768656E207765206164642061206E6577206175746F636F6D706C657465206F7074696F6E206D616E75616C6C792076696120746865206C697374626F782E
		Private mJustInsertedNewAutocompleteOption As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520756E646F206D616E6167657220666F72207468652064656D6F20656469746F722E
		UndoManager As XUIUndoManager
	#tag EndProperty


	#tag Constant, Name = GREEN_DOT_BORDER_COLOR, Type = Color, Dynamic = False, Default = \"&c008F00", Scope = Private
	#tag EndConstant

	#tag Constant, Name = GREEN_DOT_COLOR, Type = Color, Dynamic = False, Default = \"&c00F900", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_AUTOCOMPLETE, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_FORMATTER, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_GENERAL, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_THEME, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RED_DOT_BORDER_COLOR, Type = Color, Dynamic = False, Default = \"&cFF2600", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RED_DOT_COLOR, Type = Color, Dynamic = False, Default = \"&cFF7E79", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TabBar
	#tag Event , Description = 54686520746162206174207468652073706563696669656420696E64657820776173206A7573742073656C65637465642E
		Sub DidSelectTab(tab As XUITabBarItem, index As Integer)
		  #Pragma Unused index
		  
		  Select Case tab.Caption
		  Case "General"
		    Panel.SelectedPanelIndex = PANEL_GENERAL
		    
		  Case "Formatter"
		    Panel.SelectedPanelIndex = PANEL_FORMATTER
		    
		  Case "Theme"
		    Panel.SelectedPanelIndex = PANEL_THEME
		    
		  Case "Autocomplete"
		    Panel.SelectedPanelIndex = PANEL_AUTOCOMPLETE
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown panel")
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events InfoTimer
	#tag Event
		Sub Action()
		  Info.Text = "SLOC: " + Editor.LineManager.CodeLineCount.ToString + ", " + _
		  "Ln " + Editor.CaretLineNumber.ToString + ", Col " + _
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
		  
		  UpdateFormatterTabControls
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxBlinkCaret
	#tag Event
		Sub ValueChanged()
		  Editor.BlinkCaret = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupCaretType
	#tag Event
		Sub Opening()
		  Me.AddRow("Block")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUICodeEditor.CaretTypes.Block
		  Me.AddRow("Underscore")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUICodeEditor.CaretTypes.Underscore
		  Me.AddRow("Vertical Bar")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUICodeEditor.CaretTypes.VerticalBar
		  
		  Me.SelectRowWithTag(Editor.CaretType)
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  Editor.CaretType = item.Tag
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxHighlightCurrentLine
	#tag Event
		Sub ValueChanged()
		  Editor.HighlightCurrentLine = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupFont
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  Editor.FontName = item.Text
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldFontSize
	#tag Event
		Function KeyDown(key As String) As Boolean
		  Const MIN_PERMITTED_FONT_SIZE = 6
		  
		  If Key = Chr(13) Then
		    Var i As Integer = Integer.FromString(Me.Text)
		    If i >= MIN_PERMITTED_FONT_SIZE Then
		      Editor.FontSize = i
		      Return True
		    End If
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldLineNumberFontSize
	#tag Event
		Function KeyDown(key As String) As Boolean
		  Const MIN_PERMITTED_FONT_SIZE = 6
		  
		  If Key = Chr(13) Then
		    Var i As Integer = Integer.FromString(Me.Text)
		    If i >= MIN_PERMITTED_FONT_SIZE Then
		      Editor.LineNumberFontSize = i
		      Return True
		    End If
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldSpacesPerTab
	#tag Event
		Function KeyDown(key As String) As Boolean
		  Const MIN_PERMITTED_SPACES = 1
		  
		  If Key = Chr(13) Then
		    Var i As Integer = Integer.FromString(Me.Text)
		    If i >= MIN_PERMITTED_SPACES Then
		      Editor.SpacesPerTab = i
		      Return True
		    End If
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxAllowInertialScrolling
	#tag Event
		Sub ValueChanged()
		  Editor.AllowInertialScrolling = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxHighlightDelimiters
	#tag Event
		Sub ValueChanged()
		  Editor.HighlightDelimitersAroundCaret = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxDrawBlockLines
	#tag Event
		Sub ValueChanged()
		  Editor.DrawBlockLines = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxTopBorder
	#tag Event
		Sub ValueChanged()
		  Editor.HasTopBorder = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxBottomBorder
	#tag Event
		Sub ValueChanged()
		  Editor.HasBottomBorder = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxLeftBorder
	#tag Event
		Sub ValueChanged()
		  Editor.HasLeftBorder = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxRightBorder
	#tag Event
		Sub ValueChanged()
		  Editor.HasRightBorder = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DotLabelSupportsDelimiterHighlighting
	#tag Event
		Sub Opening()
		  Me.CaptionColor = mCaptionColor
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupExampleThemes
	#tag Event
		Sub Opening()
		  // Add our example themes.
		  
		  // Nova.
		  Me.AddRow("Nova")
		  Me.RowTagAt(Me.LastAddedRowIndex) = SpecialFolder.Resource("Nova.toml")
		  
		  // Start using the Nova theme.
		  Me.SelectRowWithValue("Nova")
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  // Update the editor's theme to the one selected.
		  Editor.Theme = XUICETheme.FromFile(item.Tag)
		  
		  // Update the panels that have properties affected by the loaded theme.
		  UpdateGeneralTabControls
		  UpdateThemeTabControls
		  UpdateAutocompleteTabControls
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BevelButtonDeleteToken
	#tag Event
		Sub Pressed()
		  #Pragma Warning "TODO"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BevelButtonAddToken
	#tag Event
		Sub Pressed()
		  #Pragma Warning "TODO"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListBoxThemeTokens
	#tag Event , Description = 4F6E65206F6620746865207468656D652773207374796C657320686173206368616E6765642E
		Sub DidChangeStyle()
		  Editor.Refresh(True)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonExportTheme
	#tag Event
		Sub Pressed()
		  /// Exports the current editor's theme as a TOML theme file.
		  
		  Var f As FolderItem = FolderItem.ShowSaveFileDialog(TOMLFileType.TOML, TextFieldThemeName.Text + ".toml")
		  
		  If f = Nil Then Return
		  
		  Editor.Theme.Name = TextFieldThemeName.Text
		  Editor.Theme.Author = TextFieldThemeAuthor.Text
		  Editor.Theme.Version = _
		  New XUISemanticVersion(Integer.FromString(TextFieldThemeVersionMajor.Text), _
		  Integer.FromString(TextFieldThemeVersionMinor.Text), Integer.FromString(TextFieldThemeVersionPatch.Text))
		  Editor.Theme.Description = TextAreaThemeDescription.Text
		  
		  Var tout As TextOutputStream
		  Try
		    tout = TextOutputStream.Create(f)
		    tout.Write(Editor.Theme.ToTOML)
		    tout.Close
		  Catch e As IOException
		    MessageBox("Unable to save the current theme to a TOML file.")
		  End Try
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchBackgroundColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.BackgroundColor = New ColorGroup(newColor, Editor.Theme.BackgroundColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchBackgroundColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.BackgroundColor = New ColorGroup(Editor.Theme.BackgroundColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchUnmatchedBlockLineColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.UnmatchedBlockLineColor = New ColorGroup(newColor, Editor.Theme.UnmatchedBlockLineColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchUnmatchedBlockLineColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.UnmatchedBlockLineColor = New ColorGroup(Editor.Theme.UnmatchedBlockLineColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchBlockLinesColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.BlockLineColor = New ColorGroup(newColor, Editor.Theme.BlockLineColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchBlockLinesColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.BlockLineColor = New ColorGroup(Editor.Theme.BlockLineColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchSelectionColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.SelectionColor = New ColorGroup(newColor, Editor.Theme.SelectionColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchSelectionColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.SelectionColor = New ColorGroup(Editor.Theme.SelectionColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchCaretColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.CaretColor = New ColorGroup(newColor, Editor.Theme.CaretColor.Dark)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchCaretColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.CaretColor = New ColorGroup(Editor.Theme.CaretColor.Light, newColor)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchLineNumberColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.LineNumberColor = New ColorGroup(newColor, Editor.Theme.LineNumberColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchLineNumberColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.LineNumberColor = New ColorGroup(Editor.Theme.LineNumberColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchCurrentLineNumberColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.CurrentLineNumberColor = New ColorGroup(newColor, Editor.Theme.CurrentLineNumberColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchCurrentLineNumberColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.CurrentLineNumberColor = New ColorGroup(Editor.Theme.CurrentLineNumberColor.Light, newColor)
		  
		  Editor.ForceRedraw
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchBorderColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Editor.BorderColor = New ColorGroup(newColor, Editor.BorderColor.Dark)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchBorderColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  Editor.BorderColor = New ColorGroup(Editor.BorderColor.Light, newColor)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchCurrentLineColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.CurrentLineHighlightColor = New ColorGroup(newColor, Editor.Theme.CurrentLineHighlightColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchCurrentLineColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.CurrentLineHighlightColor = New ColorGroup(Editor.Theme.CurrentLineHighlightColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchScrollbarBackgroundDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.ScrollbarBackgroundColor = New ColorGroup(Editor.Theme.ScrollbarBackgroundColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchScrollbarBackgroundLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.ScrollbarBackgroundColor = New ColorGroup(newColor, Editor.Theme.ScrollbarBackgroundColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchScrollbarBorderColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.ScrollbarBorderColor = New ColorGroup(newColor, Editor.Theme.ScrollbarBorderColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchScrollbarBorderColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.ScrollbarBorderColor = New ColorGroup(Editor.Theme.ScrollbarBorderColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchScrollbarThumbColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.ScrollbarThumbColor = New ColorGroup(newColor, Editor.Theme.ScrollbarThumbColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchScrollbarThumbColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.ScrollbarThumbColor = New ColorGroup(Editor.Theme.ScrollbarThumbColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchDelimitersBorderColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.DelimitersBorderColor = New ColorGroup(Editor.Theme.DelimitersBorderColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchDelimitersBorderColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.DelimitersBorderColor = New ColorGroup(newColor, Editor.Theme.DelimitersBorderColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchDelimitersFillColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.DelimitersFillColor = New ColorGroup(newColor, Editor.Theme.DelimitersFillColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchDelimitersFillColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.DelimitersFillColor = New ColorGroup(Editor.Theme.DelimitersFillColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchDelimitersUnderlineColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.DelimitersUnderlineColor = New ColorGroup(newColor, Editor.Theme.DelimitersUnderlineColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchDelimitersUnderlineColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.DelimitersUnderlineColor = New ColorGroup(Editor.Theme.DelimitersUnderlineColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxDelimitersHaveBorder
	#tag Event
		Sub ValueChanged()
		  If Editor.Theme <> Nil Then Editor.Theme.DelimitersHaveBorder = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxDelimitersHaveFillColor
	#tag Event
		Sub ValueChanged()
		  If Editor.Theme <> Nil Then Editor.Theme.DelimitersHaveFillColor = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxDelimitersHaveUnderline
	#tag Event
		Sub ValueChanged()
		  If Editor.Theme <> Nil Then Editor.Theme.DelimitersHaveUnderline = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchAutoCompletePopupBackgroundLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.AutocompletePopupBackgroundColor = New ColorGroup(newColor, Editor.Theme.AutocompletePopupBackgroundColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchAutoCompletePopupBackgroundDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.AutocompletePopupBackgroundColor = New ColorGroup(Editor.Theme.AutocompletePopupBackgroundColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchAutoCompletePopupBorderLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.AutocompletePopupBorderColor = New ColorGroup(newColor, Editor.Theme.AutocompletePopupBorderColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchAutoCompletePopupBorderDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.AutocompletePopupBorderColor = New ColorGroup(Editor.Theme.AutocompletePopupBorderColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchAutoCompleteOptionColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.AutocompleteOptionColor = New ColorGroup(newColor, Editor.Theme.AutocompleteOptionColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchAutoCompleteOptionColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.AutocompleteOptionColor = New ColorGroup(Editor.Theme.AutocompleteOptionColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchAutoCompleteSelectedOptionColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.SelectedAutocompleteOptionColor = New ColorGroup(newColor, Editor.Theme.SelectedAutocompleteOptionColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchAutoCompleteSelectedOptionColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.SelectedAutocompleteOptionColor = New ColorGroup(Editor.Theme.SelectedAutocompleteOptionColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchSelectedAutocompleteOptionBackgroundColorLight
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.SelectedAutocompleteOptionBackgroundColor = _
		  New ColorGroup(newColor, Editor.Theme.SelectedAutocompleteOptionBackgroundColor.Dark)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SwatchSelectedAutocompleteOptionBackgroundColorDark
	#tag Event , Description = 54686520737761746368277320636F6C6F757220686173206368616E6765642E
		Sub ColorChanged(newColor As Color)
		  If Editor.Theme = Nil Then Return
		  
		  Editor.Theme.SelectedAutocompleteOptionBackgroundColor = _
		  New ColorGroup(Editor.Theme.SelectedAutocompleteOptionBackgroundColor.Light, newColor)
		  
		  Editor.ForceRedraw
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldAutocompleteHPadding
	#tag Event
		Sub TextChanged()
		  If Editor.Theme = Nil Then Return
		  
		  If Me.Text = "" Then
		    Editor.Theme.AutocompleteHorizontalPadding = 0
		  Else
		    Editor.Theme.AutocompleteHorizontalPadding = Integer.FromString(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldAutocompleteVPadding
	#tag Event
		Sub TextChanged()
		  If Editor.Theme = Nil Then Return
		  
		  If Me.Text = "" Then
		    Editor.Theme.AutocompleteVerticalPadding = 0
		  Else
		    Editor.Theme.AutocompleteVerticalPadding = Integer.FromString(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldAutocompleteOptionVPadding
	#tag Event
		Sub TextChanged()
		  If Editor.Theme = Nil Then Return
		  
		  If Me.Text = "" Then
		    Editor.Theme.AutocompleteOptionVerticalPadding = 0
		  Else
		    Editor.Theme.AutocompleteOptionVerticalPadding = Integer.FromString(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxAllowAutocomplete
	#tag Event
		Sub ValueChanged()
		  Editor.AllowAutocomplete = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CheckBoxAllowAutocompleteInComments
	#tag Event
		Sub ValueChanged()
		  Editor.AllowAutoCompleteInComments = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldMinAutocompleteLength
	#tag Event
		Sub TextChanged()
		  If Me.Text = "" Then
		    Editor.MinimumAutocompletionLength = 0
		  Else
		    Editor.MinimumAutocompletionLength = Integer.FromString(Me.Text)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupAutocompleteFont
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  Editor.AutocompletePopupFontName = item.Text
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TextFieldAutocompleteFontSize
	#tag Event
		Function KeyDown(key As String) As Boolean
		  Const MIN_PERMITTED_FONT_SIZE = 6
		  
		  If Key = Chr(13) Then
		    Var i As Integer = Integer.FromString(Me.Text)
		    If i >= MIN_PERMITTED_FONT_SIZE Then
		      Editor.AutocompletePopupFontSize = i
		      Return True
		    End If
		  End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events PopupAutocompleteCombo
	#tag Event
		Sub Opening()
		  Me.AddRow("Ctrl+Space")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUICodeEditor.AutocompleteCombos.CtrlSpace
		  Me.AddRow("Tab")
		  Me.RowTagAt(Me.LastAddedRowIndex) = XUICodeEditor.AutocompleteCombos.Tab
		  
		  // Default to Ctrl+Space for autocomplete.
		  Me.SelectedRowIndex = 0
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  Editor.AutocompleteCombo = item.Tag
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ListBoxAutocompleteOptions
	#tag Event
		Sub SelectionChanged()
		  BevelButtonDeleteAutocompleteOption.Enabled = Me.SelectedRowIndex <> -1
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  #Pragma Unused column
		  
		  If mJustInsertedNewAutocompleteOption Then
		    mJustInsertedNewAutocompleteOption = False
		    // We have just edited a newly inserted option. We need to add it to the autocomplete engine.
		    Self.AutocompleteEngine.AddOption(Me.CellTextAt(row, 0))
		    RebuildAutocompleteListbox
		    Return
		  Else
		    // Since we have no way of knowing what the previous value of this cell was, we'll rebuild the
		    // autocomplete engine from the contents of the listbox.
		    Self.AutocompleteEngine.Reset
		    For i As Integer = 0 To ListBoxAutocompleteOptions.RowCount - 1
		      Self.AutocompleteEngine.AddOption(ListBoxAutocompleteOptions.CellTextAt(i, 0))
		    Next i
		  End If
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BevelButtonDeleteAutocompleteOption
	#tag Event
		Sub Pressed()
		  If ListBoxAutocompleteOptions.SelectedRowIndex = -1 Then Return
		  
		  Self.AutocompleteEngine.RemoveOption(ListBoxAutocompleteOptions.SelectedRowValue)
		  
		  RebuildAutocompleteListbox
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BevelButtonAddAutocompleteOption
	#tag Event
		Sub Pressed()
		  // Make sure we add a unique value.
		  Var value As String = "NewOption"
		  
		  Var i As Integer
		  While Self.AutocompleteEngine.HasOptionWithValue(value)
		    value = value + i.ToString
		  Wend
		  
		  mJustInsertedNewAutocompleteOption = True
		  ListBoxAutocompleteOptions.AddRow(value)
		  ListBoxAutocompleteOptions.EditCellAt(ListBoxAutocompleteOptions.LastAddedRowIndex, 0)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonClearAutocompleteOptions
	#tag Event
		Sub Pressed()
		  Self.AutocompleteEngine.Reset
		  RebuildAutocompleteListbox
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event , Description = 54686520656469746F722069732061626F757420746F20626520646973706C617965642E
		Sub Opening()
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
