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
   Begin XUIColorSwatch Swatch1
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
      Value           =   &cFF7E7900
      Visible         =   True
      Width           =   48
   End
   Begin XUIColorSwatch Swatch2
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   54
      Transparent     =   True
      Value           =   &c0433FF00
      Visible         =   True
      Width           =   48
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

#tag Events Swatch1
	#tag Event
		Sub Opening()
		  Me.Renderer = New XUIColorSwatchRendererMacOS(Me)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Swatch2
	#tag Event
		Sub Opening()
		  Me.Renderer = New XUIColorSwatchRendererMacOS(Me)
		End Sub
	#tag EndEvent
#tag EndEvents
