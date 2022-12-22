#tag Class
Protected Class XUICodeEditorAutocompletePopup
Inherits DesktopTextInputCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  /// Determine the index of the suggestion clicked.
		  
		  #Pragma Unused x
		  
		  SelectedIndex = Floor((y + ScrollPosY + Owner.Theme.AutocompleteVerticalPadding) / _
		  (AutocompleteOptionHeight + Owner.Theme.AutocompleteOptionVerticalPadding))
		  
		  Owner.AcceptCurrentAutocompleteOption
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  /// The mouse has wheeled.
		  ///
		  /// `x` is the X coord relative to the control that has received the event.
		  /// `y` is the Y coord relative to the control that has received the event.
		  /// `deltaX` is the number of horizontal scroll lines moved.
		  /// `deltaY` is the number of vertical scroll lines moved.
		  ///
		  /// Returns True to prevent propagating the event further.
		  ///
		  /// `deltaX` is positive when the user scrolls right and negative when scrolling left. 
		  /// `deltaY` is positive when the user scrolls down and negative when scrolling up.
		  
		  #Pragma Unused X
		  #Pragma Unused Y
		  #Pragma Unused deltaX
		  
		  ScrollPosY = ScrollPosY + (deltaY)
		  
		  // Prevent the event propagating further.
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Xojo.Rect)
		  #Pragma Unused areas
		  
		  If Owner.AutocompleteData = Nil Then Return
		  If mBuffer = Nil Then RebuildBuffer(Self.Width, SelectedIndex)
		  
		  g.DrawPicture(mBuffer, 0, -ScrollPosY)
		  
		  // Border.
		  If Owner.Theme.HasAutocompletePopupBorder Then
		    g.DrawingColor = Owner.Theme.AutocompletePopupBorderColor
		    If Owner.Theme.AutocompletePopupBorderRadius = 0 Then
		      g.DrawRectangle(0, 0, g.Width, g.Height)
		    Else
		      g.DrawRoundRectangle(0, 0, g.Width, g.Height, _
		      Owner.Theme.AutocompletePopupBorderRadius, Owner.Theme.AutocompletePopupBorderRadius)
		    End If
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 52657475726E732074686520686569676874206F6620616E206175746F636F6D706C657465206F7074696F6E20696E2074686520706F707570206261736564206F6E20746865206F776E657227732063757272656E74207468656D652E
		Function AutocompleteOptionHeight() As Integer
		  /// Returns the height of an autocomplete option in the popup based on the owner's current theme.
		  
		  Var tmp As Picture
		  If Owner.Window = Nil Then
		    tmp = New Picture(10, 10)
		  Else
		    tmp = Owner.Window.BitmapForCaching(10, 10)
		  End If
		  
		  tmp.Graphics.FontName = Owner.AutocompletePopupFontName
		  tmp.Graphics.FontSize = Owner.AutocompletePopupFontSize
		  
		  Var h As Double = tmp.Graphics.TextHeight + (2 * Owner.Theme.AutocompleteOptionVerticalPadding)
		  
		  Return h
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 437265617465732061206E6577206175746F636F6D706C65746520706F7075702063616E7661732C20776974682061207765616B207265666572656E636520746F20606F776E6572602E
		Sub Constructor(owner As XUICodeEditor)
		  /// Creates a new autocomplete popup canvas, with a weak reference to `owner`.
		  
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  mOwner = New WeakRef(owner)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 437265617465732074686520627566666572207468617420726570726573656E74732074686520706F7075702E2041737369676E73207468652062756666657220746F20606D427566666572602E
		Private Sub RebuildBuffer(maxWidth As Integer, selectedIndex As Integer)
		  /// Creates the buffer that represents the popup. Assigns the buffer to `mBuffer`.
		  
		  // For bevity grab a reference to the theme to use.
		  Var theme As XUICETheme = Owner.Theme
		  
		  // We need a temporary graphics context to get the width of the longest option.
		  Var tmpPic As Picture
		  If Owner.Window = Nil Then
		    tmpPic = New Picture(10, 10)
		  Else
		    tmpPic = Owner.Window.BitmapForCaching(1, 1)
		  End If
		  tmpPic.Graphics.FontName = Owner.AutocompletePopupFontName
		  tmpPic.Graphics.FontSize = Owner.AutocompletePopupFontSize
		  
		  // Compute the required width of the buffer.
		  Var longestOptionW As Double = tmpPic.Graphics.TextWidth(Owner.AutocompleteData.LongestOptionValue)
		  Var bufferW As Double = Min(longestOptionW + (2 * theme.AutocompleteHorizontalPadding) + _
		  (2 * SELECTED_OPTION_H_PADDING), maxWidth)
		  
		  Var lineH As Double = AutocompleteOptionHeight
		  
		  // Compute the required height of the buffer.
		  Var bufferH As Integer = (lineH * Owner.AutocompleteData.Options.Count) + _
		  (Owner.AutocompleteData.Options.Count * theme.AutocompleteOptionVerticalPadding) + _
		  (2 * theme.AutocompleteVerticalPadding)
		  
		  // Create a new HiDPI aware buffer picture.
		  mBuffer = Owner.Window.BitmapForCaching(bufferW, bufferH)
		  
		  // Grab a reference to the buffer's graphics context.
		  Var g As Graphics = mBuffer.Graphics
		  
		  // Set the correct font family and size.
		  g.FontName = Owner.AutocompletePopupFontName
		  g.FontSize = Owner.AutocompletePopupFontSize
		  
		  // Background.
		  g.DrawingColor = theme.AutocompletePopupBackgroundColor
		  g.FillRoundRectangle(0, 0, g.Width, g.Height, _
		  theme.AutocompletePopupBorderRadius, theme.AutocompletePopupBorderRadius)
		  
		  // If there's only one option, make sure it's selected.
		  If Owner.AutocompleteData.Options.Count = 1 Then selectedIndex = 0
		  If selectedIndex = -1 Then selectedIndex = 0
		  
		  // Draw the options.
		  Var textH As Double = g.TextHeight
		  Var x As Double = theme.AutocompleteHorizontalPadding
		  Var optionBaseline As Double = g.FontAscent + ((lineH - textH) / 2)
		  Var y As Double = theme.AutocompleteVerticalPadding + theme.AutocompleteOptionVerticalPadding
		  Var iMax As Integer = Owner.AutocompleteData.Options.LastIndex
		  For i As Integer = 0 To iMax
		    Var option As XUICEAutocompleteOption = Owner.AutocompleteData.Options(i)
		    If i = selectedIndex Then
		      // Draw the selection background.
		      g.DrawingColor = theme.SelectedAutocompleteOptionBackgroundColor
		      g.FillRoundRectangle(SELECTED_OPTION_H_PADDING, y, _
		      g.Width - (2 * SELECTED_OPTION_H_PADDING), lineH, _
		      SELECTED_OPTION_BORDER_RADIUS, SELECTED_OPTION_BORDER_RADIUS)
		    End If
		    
		    // Draw the option value.
		    If i = SelectedIndex Then
		      g.DrawingColor = theme.SelectedAutocompleteOptionColor
		    Else
		      g.DrawingColor = theme.AutocompleteOptionColor
		    End If
		    g.DrawText(option.Value, x + SELECTED_OPTION_H_PADDING, y + optionBaseline)
		    
		    y = y + lineH + theme.AutocompleteOptionVerticalPadding
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5363726F6C6C732074686520706F70757020746F2077686F6C6C7920646973706C6179207468652073656C656374656420696E646578206966206974206973206E6F7420616C72656164792E20526566726573686573207468652063616E7661732E
		Private Sub ScrollToSelectedIndex()
		  /// Scrolls the popup to wholly display the selected index if it is not already.
		  /// Refreshes the canvas.
		  ///
		  /// Assumes `SelectedIndex` is valid.
		  
		  If SelectedIndex = -1 Then
		    ScrollPosY = 0
		    Return
		  End If
		  
		  Var lineH As Integer = AutocompleteOptionHeight
		  If (SelectedIndex * lineH) < ScrollPosY Or (SelectedIndex * lineH) > Self.Height Then
		    ScrollPosY = SelectedIndex * lineH
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526573697A657320616E6420726564726177732074686973206175746F636F6D706C65746520706F707570207573696E6720746865206175746F636F6D706C65746520646174612066726F6D20697473206F776E65722E
		Sub Update(maxWidth As Integer, maxHeight As Integer)
		  /// Resizes and redraws this autocomplete popup using the autocomplete data from its owner.
		  ///
		  /// `maxwidth` is the maximum permissable width of the popup.
		  /// `maxHeight` is the maximum permissable height of the popup.
		  
		  RebuildBuffer(maxWidth, SelectedIndex)
		  
		  Self.Width = Min(mBuffer.Graphics.Width, maxWidth)
		  Self.Height = Min(mBuffer.Graphics.Height, maxHeight)
		  
		  Refresh
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		The customisable autocomplete popup that appears in the code editor when autocomplete 
		options are available.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 5468652070696374757265207468617420726570726573656E74732074686520706F7075702E20447261776E20696E2074686520605061696E74282960206576656E742E
		Private mBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F646520656469746F722074686174206F776E73207468697320706F7075702E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520766572746963616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720646F776E2E204261636B732074686520605363726F6C6C506F73596020636F6D70757465642070726F70657274792E
		Private mScrollPosY As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 302D626173656420696E646578206F66207468652063757272656E746C792073656C6563746564206F7074696F6E20696E2074686520706F7075702E
		Private mSelectedIndex As Integer = -1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F646520656469746F722074686174206F776E73207468697320706F7075702E
		#tag Getter
			Get
			  If mOwner = Nil Or mOwner.Value = Nil Then
			    Return Nil
			  Else
			    Return XUICodeEditor(mOwner.Value)
			  End If
			  
			End Get
		#tag EndGetter
		Owner As XUICodeEditor
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520766572746963616C207363726F6C6C206F66667365742E203020697320626173656C696E652E20506F73697469766520696E64696361746573207363726F6C6C696E6720646F776E2E205265667265736865732074686520706F7075702E
		#tag Getter
			Get
			  Return mScrollPosY
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  /// Update how much the canvas is vertically scrolled.
			  
			  // Compute the maximum allowed Y scroll position.
			  Var maxScrollPosY As Integer
			  If mBuffer = Nil Then
			    maxScrollPosY = 0
			    
			  Else
			    maxScrollPosY = Max(mBuffer.Graphics.Height - Self.Height, 0)
			  End If
			  
			  // Set the value of ScrollPosY, not exceeding the maximum value.
			  mScrollPosY = XUIMaths.Clamp(value, 0, maxScrollPosY)
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		ScrollPosY As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 302D626173656420696E646578206F66207468652063757272656E746C792073656C6563746564206F7074696F6E20696E2074686520706F7075702E
		#tag Getter
			Get
			  Return mSelectedIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Owner.AutocompleteData = Nil Or Owner.AutocompleteData.Options.Count = 0 Then
			    value = -1
			  Else
			    value = XUIMaths.Clamp(value, 0, Owner.AutocompleteData.Options.LastIndex)
			  End If
			  
			  mSelectedIndex = value
			  
			  // Scroll if the selected option is not wholly visible.
			  ScrollToSelectedIndex
			  
			End Set
		#tag EndSetter
		SelectedIndex As Integer
	#tag EndComputedProperty


	#tag Constant, Name = SELECTED_OPTION_BORDER_RADIUS, Type = Double, Dynamic = False, Default = \"7", Scope = Private, Description = 54686520626F726465722072616469757320666F7220746865206261636B67726F756E64206F66207468652063757272656E746C792073656C6563746564206175746F636F6D706C657465206F7074696F6E20696E2074686520706F7075702E
	#tag EndConstant

	#tag Constant, Name = SELECTED_OPTION_H_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746F20746865206C65667420616E64207269676874206F6620612073656C6563746564206175746F636F6D706C657465206F7074696F6E20696E2074686520706F7075702E20
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollPosY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
