#tag DesktopWindow
Begin DesktopWindow XUIColorPicker
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
   Height          =   400
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
   Width           =   320
   Begin DesktopButton ButtonSelect
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Select"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   166
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
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
      Left            =   74
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
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
      DefaultImage    =   2118187007
      DisabledImage   =   0
      Enabled         =   True
      HasBorder       =   False
      Height          =   28
      HoverImage      =   0
      Index           =   -2147483648
      IsPressed       =   True
      Left            =   270
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      PressedImage    =   815167487
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
      Height          =   301
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   45
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   320
      Begin DesktopCanvas SlidersColorCanvas
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   80
         Index           =   -2147483648
         InitialParent   =   "PanelMain"
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   45
         Transparent     =   True
         Visible         =   True
         Width           =   320
      End
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
         Top             =   137
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
         Left            =   240
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
         Top             =   137
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   67
      End
      Begin DesktopPagePanel PanelSliders
         AllowAutoDeactivate=   True
         Enabled         =   True
         Height          =   127
         Index           =   -2147483648
         InitialParent   =   "PanelMain"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         PanelCount      =   2
         Panels          =   ""
         Scope           =   2
         TabIndex        =   15
         TabPanelIndex   =   1
         TabStop         =   False
         Tooltip         =   ""
         Top             =   169
         Transparent     =   False
         Value           =   0
         Visible         =   True
         Width           =   320
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
            LockLeft        =   False
            LockRight       =   True
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
            LockLeft        =   False
            LockRight       =   True
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
            LockLeft        =   False
            LockRight       =   True
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
         Begin DesktopTextField SliderAlphaValue
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
            LockLeft        =   False
            LockRight       =   True
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
         Begin XUIRGBAComponentSlider SliderAlpha
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
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
            Scope           =   0
            TabIndex        =   4
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   267
            Transparent     =   True
            Visible         =   True
            Width           =   247
         End
         Begin XUIRGBAComponentSlider SliderBlue
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
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
            Scope           =   0
            TabIndex        =   5
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   239
            Transparent     =   True
            Visible         =   True
            Width           =   247
         End
         Begin XUIRGBAComponentSlider SliderGreen
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
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
            Scope           =   0
            TabIndex        =   6
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   211
            Transparent     =   True
            Visible         =   True
            Width           =   247
         End
         Begin XUIRGBAComponentSlider SliderRed
            AllowAutoDeactivate=   True
            AllowFocus      =   False
            AllowFocusRing  =   True
            AllowTabs       =   False
            Backdrop        =   0
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
            Scope           =   0
            TabIndex        =   7
            TabPanelIndex   =   1
            TabStop         =   True
            Tooltip         =   ""
            Top             =   183
            Transparent     =   True
            Visible         =   True
            Width           =   247
         End
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  // Start on the sliders panel.
		  PanelMain.SelectedPanelIndex = PANEL_MAIN_SLIDERS
		  PanelSliders.SelectedPanelIndex = PANEL_SLIDERS_RGB
		  
		  CurrentColor = mCurrentColor
		  
		  // Hook into the slider's dragging events.
		  AddHandler SliderRed.IsDraggingScrubber, AddressOf DraggingRedSliderScrubber
		  AddHandler SliderGreen.IsDraggingScrubber, AddressOf DraggingGreenSliderScrubber
		  AddHandler SliderBlue.IsDraggingScrubber, AddressOf DraggingBlueSliderScrubber
		  AddHandler SliderAlpha.IsDraggingScrubber, AddressOf DraggingAlphaSliderScrubber
		  
		  Update
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(startingColor As Color)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  CurrentColor = startingColor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C656761746520666F722068616E646C696E6720746865206472616767696E67206F662074686520616C70686120736C696465722073637275626265722E
		Private Sub DraggingAlphaSliderScrubber(sender As XUIRGBAComponentSlider)
		  /// Delegate for handling the dragging of the alpha slider scrubber.
		  
		  #Pragma Unused sender
		  
		  CurrentColor = _
		  Color.RGB(mCurrentColor.Red, mCurrentColor.Green, mCurrentColor.Blue, SliderAlpha.ComponentValue)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C656761746520666F722068616E646C696E6720746865206472616767696E67206F662074686520626C756520736C696465722073637275626265722E
		Private Sub DraggingBlueSliderScrubber(sender As XUIRGBAComponentSlider)
		  /// Delegate for handling the dragging of the blue slider scrubber.
		  
		  #Pragma Unused sender
		  
		  CurrentColor = _
		  Color.RGB(mCurrentColor.Red, mCurrentColor.Green, SliderBlue.ComponentValue, mCurrentColor.Alpha)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C656761746520666F722068616E646C696E6720746865206472616767696E67206F66207468652072656420736C696465722073637275626265722E
		Private Sub DraggingGreenSliderScrubber(sender As XUIRGBAComponentSlider)
		  /// Delegate for handling the dragging of the green slider scrubber.
		  
		  #Pragma Unused sender
		  
		  CurrentColor = _
		  Color.RGB(mCurrentColor.Red, SliderGreen.ComponentValue, mCurrentColor.Blue, mCurrentColor.Alpha)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C656761746520666F722068616E646C696E6720746865206472616767696E67206F66207468652072656420736C696465722073637275626265722E
		Private Sub DraggingRedSliderScrubber(sender As XUIRGBAComponentSlider)
		  /// Delegate for handling the dragging of the red slider scrubber.
		  
		  #Pragma Unused sender
		  
		  CurrentColor = _
		  Color.RGB(SliderRed.ComponentValue, mCurrentColor.Green, mCurrentColor.Blue, mCurrentColor.Alpha)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshRGBASlidersPanel()
		  /// Refreshes all the controls on the RGBA sliders panel to reflect `mCurrentColor`.
		  
		  /// RGB value.
		  SlidersRGBHexValue.Text = mCurrentColor.ToRGBString
		  
		  // Main colour canvas.
		  SlidersColorCanvas.Refresh
		  
		  // Component sliders.
		  SliderRed.CompleteColor = mCurrentColor
		  SliderGreen.CompleteColor = mCurrentColor
		  SliderBlue.CompleteColor = mCurrentColor
		  SliderAlpha.CompleteColor = mCurrentColor
		  
		  // Component values.
		  SliderRedValue.Text = mCurrentColor.Red.ToString
		  SliderGreenValue.Text = mCurrentColor.Green.ToString
		  SliderBlueValue.Text = mCurrentColor.Blue.ToString
		  SliderAlphaValue.Text = mCurrentColor.Alpha.ToString
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5570646174657320616C6C20636F6E74726F6C7320746F206D61746368207468652063757272656E7420636F6C6F75722E
		Private Sub Update()
		  /// Updates all controls to match the current colour.
		  
		  RefreshRGBASlidersPanel
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 5468652073656C656374656420636F6C6F757220696E20746865207069636B657220686173206368616E6765642E
		Event ColorChanged(newColor As Color)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E746C792073656C656374656420636F6C6F75722E
		#tag Getter
			Get
			  Return mCurrentColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCurrentColor = value
			  
			  SliderRed.ComponentValue = mCurrentColor.Red
			  SliderGreen.ComponentValue = mCurrentColor.Green
			  SliderBlue.ComponentValue = mCurrentColor.Blue
			  SliderAlpha.ComponentValue = mCurrentColor.Alpha
			  
			  Update
			  
			  RaiseEvent ColorChanged(mCurrentColor)
			End Set
		#tag EndSetter
		CurrentColor As Color
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E746C792073656C656374656420636F6C6F75722E
		Private mCurrentColor As Color
	#tag EndProperty


	#tag Constant, Name = PANEL_MAIN_SLIDERS, Type = Double, Dynamic = False, Default = \"0", Scope = Private, Description = 496E646578206F66207468652070616E656C20636F6E7461696E696E672074686520736C69646572732E
	#tag EndConstant

	#tag Constant, Name = PANEL_SLIDERS_RGB, Type = Double, Dynamic = False, Default = \"0", Scope = Private, Description = 496E646578206F66207468652070616E656C20636F6E7461696E696E67207468652052474220736C69646572732E
	#tag EndConstant


#tag EndWindowCode

#tag Events ButtonSelect
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
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SlidersColorCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  g.DrawingColor = mCurrentColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
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
#tag Events SliderAlphaValue
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
