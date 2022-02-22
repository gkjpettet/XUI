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
      AutoDeactivate  =   True
      CaretBlinkPeriod=   500
      Enabled         =   True
      Height          =   103
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LineHeight      =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
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
End
#tag EndDesktopWindow

#tag WindowCode
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
		  
		  Me.Style = style
		  Me.TagRenderer = New XUIWindowsTagRenderer(Me)
		  Me.Parselet = New XUIDefaultTagParselet
		End Sub
	#tag EndEvent
#tag EndEvents
