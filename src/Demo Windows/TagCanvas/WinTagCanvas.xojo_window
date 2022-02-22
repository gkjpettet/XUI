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
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "TagCanvas Demo"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin XUITagCanvas TagCanvas
      AllowInertialScrolling=   True
      AutoDeactivate  =   True
      CaretBlinkPeriod=   500
      Enabled         =   True
      Height          =   64
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      ParseOnComma    =   True
      ParseOnReturn   =   True
      ParseOnTab      =   True
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TagHorizontalPadding=   5
      TagVerticalPadding=   5
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
      Height          =   22
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Info"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   358
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
   End
   Begin Timer InfoTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   250
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
#tag EndWindowCode

#tag Events TagCanvas
	#tag Event
		Sub Opening()
		  Var style As New XUITagCanvasStyle
		  style.BackgroundColor = Color.White
		  style.TagBackgroundColor = Color.Gray
		  style.TagBorderColor = Color.Black
		  style.TagTextColor = Color.Black
		  style.CaretColor = Color.Black
		  
		  Me.Style = style
		  Me.Formatter = New XUIWindowsTagFormatter(Me)
		  Me.Parselet = New XUIDefaultTagParselet
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events InfoTimer
	#tag Event
		Sub Action()
		  Info.Text = "CaretXCoord: " + TagCanvas.CaretXCoordinate.ToString + _
		  " CanvasW: " + TagCanvas.Width.ToString + _
		  " ScrollPosX: " + TagCanvas.ScrollPosX.ToString
		End Sub
	#tag EndEvent
#tag EndEvents
