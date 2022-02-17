#tag Class
Protected Class XUITabBarItem
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITabBar, caption As String, icon As Picture = Nil, tag As Variant = Nil, closable As Boolean = True, enabled As Boolean = True)
		  If owner = Nil Then
		    Raise New InvalidArgumentException("Tab bar items must have a non-Nil owner.")
		  End If
		  
		  Self.Owner = owner
		  Self.Caption = caption
		  Self.Icon = icon
		  Self.Tag = tag
		  Self.Closable = closable
		  Self.Enabled = enabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 447261777320746869732074616220746F20606760207374617274696E672061742060786020776974682061207769647468206F6620607461726765745769647468602E
		Function Draw(g As Graphics, x As Integer, active As Boolean, targetWidth As Double) As Integer
		  /// Draws this tab to `g` starting at `x` with a width of `targetWidth`.
		  
		  #Pragma Warning "TODO"
		  
		  Var style As XUITabBarStyle = Owner.Style
		  
		  g.SaveState
		  
		  Var midY As Double = g.Height / 2
		  Var startX As Integer = x
		  
		  // Background colour.
		  SetGraphicsBackgroundColor(g, active)
		  g.FillRectangle(x, 0, targetWidth, g.Height)
		  
		  // ==================================================
		  // Borders.
		  // ==================================================
		  If active Then
		    g.DrawingColor = style.ActiveTabBorderColor
		    If style.ActiveTabHasBottomBorder Then
		      // Active bottom border.
		      If style.ActiveTabHasThickBottomBorder Then
		        g.FillRectangle(x, g.Height - 2, targetWidth, 2)
		      Else
		        g.DrawLine(x, g.Height - 1, x + targetWidth, g.Height - 1)
		      End If
		    End If
		    If style.ActiveTabHasTopBorder Then
		      // Active top border.
		      If style.ActiveTabHasThickTopBorder Then
		        g.FillRectangle(0, 0, targetWidth, 2)
		      Else
		        g.DrawLine(x, 0, x + targetWidth, 0)
		      End If
		    End If
		  Else
		    g.DrawingColor = style.TabBorderColor
		    
		    // Top border.
		    g.DrawLine(x, 0, x + targetWidth, 0)
		    
		    // Bottom border.
		    g.DrawLine(x, g.Height - 1, x + targetWidth, g.Height - 1)
		  End If
		  
		  g.DrawingColor = style.TabBorderColor
		  
		  // Left border?
		  If x > 0 Or Owner.HasLeftBorder Then
		    g.DrawLine(x, 0, x, g.Height)
		  End If
		  
		  // Right border.
		  If x < g.Width Or Owner.HasRightBorder Then
		    g.DrawLine(x + targetWidth, 0, x + targetWidth, g.Height)
		  End If
		  
		  x = x + style.HorizontallPadding
		  
		  // ==================================================
		  // Close icon.
		  // ==================================================
		  If Enabled And Closable Then
		    SetGraphicsCloseIconColor(g, active)
		    g.FillRectangle(x, midY - (CLOSE_HEIGHT/2), CLOSE_WIDTH, CLOSE_HEIGHT)
		    x = x + CLOSE_WIDTH + CLOSE_PADDING
		  End If
		  
		  // Compute the width of the icon and caption area.
		  SetGraphicsFontProperties(g, active)
		  Var iconCaptionW As Double
		  If Icon <> Nil Then
		    iconCaptionW = Icon.Graphics.Width + ICON_PADDING + g.TextWidth(Caption)
		  Else
		    iconCaptionW = g.TextWidth(Caption)
		  End If
		  
		  // Compute where the icon or caption area should be drawn at.
		  x = startX + (targetWidth / 2) - (iconCaptionW / 2)
		  
		  // ==================================================
		  // Icon.
		  // ==================================================
		  If Icon <> Nil Then
		    g.DrawPicture(Icon, x, midY - (Icon.Graphics.Height/2))
		    x = x + Icon.Graphics.Width + ICON_PADDING
		  End If
		  
		  // ==================================================
		  // Caption.
		  // ==================================================
		  Var baseline As Double = g.FontAscent + (g.Height - g.TextHeight)/2
		  g.DrawText(Caption, x, baseline)
		  
		  x = startX + targetWidth
		  
		  g.RestoreState
		  
		  Return x
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5365747320746865206261636B67726F756E642064726177696E6720636F6C6F7572206F662060676020746F2074686F736520726571756972656420666F722074686973207461622E
		Private Sub SetGraphicsBackgroundColor(g As Graphics, active As Boolean)
		  /// Sets the background drawing colour of `g` to those required for this tab.
		  
		  Var style As XUITabBarStyle = Owner.Style
		  
		  If active Then
		    g.DrawingColor = style.ActiveTabBackgroundColor
		    
		  ElseIf Self.Enabled = False Then
		    // Disabled tab.
		    g.DrawingColor = style.DisabledTabBackgroundColor
		  Else
		    // Inactive tab.
		    g.DrawingColor = style.InactiveTabBackgroundColor
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 53657473207468652064726177696E6720636F6C6F7572206F662060676020746F2074686F736520726571756972656420666F72207468697320746162277320636C6F73652069636F6E2E
		Private Sub SetGraphicsCloseIconColor(g As Graphics, active As Boolean)
		  /// Sets the drawing colour of `g` to those required for this tab's close icon.
		  
		  Var style As XUITabBarStyle = Owner.Style
		  
		  If active Then
		    g.DrawingColor = style.ActiveTabCloseColor
		  Else
		    // Inactive tab.
		    g.DrawingColor = style.InactiveTabCloseColor
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 536574732074686520666F6E742070726F70657274696573206F662060676020746F2074686F736520726571756972656420666F722074686973207461622E
		Private Sub SetGraphicsFontProperties(g As Graphics, active As Boolean)
		  /// Sets the font properties of `g` to those required for this tab.
		  
		  Var style As XUITabBarStyle = Owner.Style
		  
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  
		  If active Then
		    g.Bold = style.ActiveTabTextBold
		    g.Italic = style.ActiveTabTextItalic
		    g.DrawingColor = style.ActiveTabTextColor
		    
		  ElseIf Self.Enabled = False Then
		    // Disabled tab.
		    g.Bold = style.DisabledTabTextBold
		    g.Italic = style.DisabledTabTextItalic
		    g.DrawingColor = style.DisabledTabTextColor
		  Else
		    // Inactive tab.
		    g.Bold = style.InactiveTabTextBold
		    g.Italic = style.InactiveTabTextItalic
		    g.DrawingColor = style.InactiveTabTextColor
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206D696E696D756D207769647468206F662074686973207461622E
		Function Width(g As Graphics, active As Boolean) As Double
		  /// Returns the minimum width of this tab.
		  ///
		  /// Note that the tab bar will expand tabs to fill the available space.
		  
		  Var style As XUITabBarStyle = Owner.Style
		  
		  g.SaveState
		  
		  SetGraphicsFontProperties(g, active)
		  
		  Var w As Double = g.TextWidth(Caption)
		  
		  If Closable Then w = w + CLOSE_WIDTH + CLOSE_PADDING
		  
		  If Icon <> Nil Then w = w + Icon.Graphics.Width + ICON_PADDING
		  
		  w = w + (style.HorizontallPadding * 2)
		  
		  g.RestoreState
		  
		  Return Max(Owner.MinimumTabWidth, w)
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468652074616227732063617074696F6E202876697369626C652074657874292E
		Caption As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686973207461622063616E20626520636C6F73656420627920746865207573657220627920636C69636B696E67206F6E2074686520636C6F73652069636F6E2E
		Closable As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5472756520696620746869732074616220697320656E61626C65642E
		Enabled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2069636F6E2E
		Icon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520746162206261722074686174206F776E732074686973207461622E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520746162206261722074686174206F776E732074686973207461622E
		#tag Getter
			Get
			  If mOwner = Nil Or mOwner.Value = Nil Then
			    Return Nil
			  Else
			    Return XUITabBar(mOwner.Value)
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value = Nil Then
			    mOwner = Nil
			  Else
			    mOwner = New WeakRef(value)
			  End If
			End Set
		#tag EndSetter
		Owner As XUITabBar
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206172626974726172792064617461206173736F63696174656420776974682074686973207461622E
		Tag As Variant
	#tag EndProperty


	#tag Constant, Name = CLOSE_HEIGHT, Type = Double, Dynamic = False, Default = \"12", Scope = Public, Description = 54686520686569676874206F662074686520636C6F73652069636F6E2E
	#tag EndConstant

	#tag Constant, Name = CLOSE_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Public, Description = 546865206D696E696D756D206E756D626572206F6620706978656C73206265747765656E207468652072696768742065646765206F662074686520636C6F73652069636F6E20616E6420746865206C6566742065646765206F66207468652069636F6E2F63617074696F6E2E
	#tag EndConstant

	#tag Constant, Name = CLOSE_WIDTH, Type = Double, Dynamic = False, Default = \"12", Scope = Public, Description = 546865207769647468206F662074686520636C6F73652069636F6E2E
	#tag EndConstant

	#tag Constant, Name = ICON_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Public, Description = 546865206E756D626572206F6620706978656C73206265747765656E207468652072696768742073696465206F66207468652069636F6E20616E64207468652063617074696F6E2E
	#tag EndConstant


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Closable"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
