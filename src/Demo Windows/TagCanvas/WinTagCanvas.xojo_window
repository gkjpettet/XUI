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
#tag EndEvents
