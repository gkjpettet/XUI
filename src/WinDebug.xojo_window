#tag DesktopWindow
Begin DesktopWindow WinDebug
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
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Untitled"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin XUIColorSwatch ColorSwatch1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   22
      Index           =   -2147483648
      IsActive        =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Value           =   &cFF930052
      Visible         =   True
      Width           =   48
   End
   Begin DesktopLabel Info
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   134
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Info"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   246
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin Timer InfoTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   500
      RunMode         =   2
      Scope           =   0
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.Center
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events ColorSwatch1
	#tag Event
		Sub Opening()
		  Me.Renderer = New XUIColorSwatchRendererMacOS(Me)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events InfoTimer
	#tag Event
		Sub Action()
		  Info.Text = ""
		  
		  Var display As DesktopDisplay = Self.Display
		  
		  If display = Nil Then Return
		  
		  Info.Text = "Display.AvailableWidth: " + display.AvailableWidth.ToString + EndOfLine + _
		  "Display.AvailableHeight: " + display.AvailableHeight.ToString + EndOfLine + _
		  "Display.ScaleFactor: " + display.ScaleFactor.ToString + EndOfLine + _
		  "Self.Width: " + Self.Width.ToString + EndOfLine + _
		  "Self.Height: " + Self.Height.ToString + EndOfLine + _
		  "Self.Top: " + Self.Top.ToString + ", Self.Left: " + Self.Left.ToString
		  
		End Sub
	#tag EndEvent
#tag EndEvents
