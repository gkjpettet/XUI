#tag Class
Protected Class XUISourceListMacOSRenderer
Implements XUISourceListRenderer
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUISourceList)
		  If owner = Nil Then
		    mOwner = Nil
		  Else
		    mOwner = New WeakRef(owner)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44726177732061206261646765206174206078602C20607960206F662077696474682060776020616E6420686569676874206068602E
		Private Sub DrawBadge(g As Graphics, badgeValue As Integer, x As Double, y As Double, w As Double, h As Double)
		  /// Draws a badge at `x`, `y` of width `w` and height `h`.
		  ///
		  /// Assumes the font name and size have been previously set.
		  
		  // Rounded rect.
		  g.DrawingColor = Owner.Style.BadgeColor
		  g.FillRoundRectangle(x, y, w, h, 14, 14)
		  
		  // Value.
		  g.DrawingColor = Owner.Style.BadgeValueColor
		  Var baseline As Double = y + (g.FontAscent + (h - g.TextHeight)/2) - 1 // -1 is a fudge
		  g.DrawText(badgeValue.ToString, x + (w / 2) - (g.TextWidth(badgeValue.ToString) / 2), baseline)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520696E64656E7420776964746820746F207573652E20446570656E6473206F6E2077686574686572206F72206E6F742074686520736F75726365206C6973742069732068696572617263686963616C2E
		Private Function IndentWidth() As Integer
		  /// Returns the indent width to use. Depends on whether or not the source list is hierarchical.
		  
		  If Owner.Hierarchical Then
		    Return INDENT_WIDTH_HIERARCHICAL
		  Else
		    Return INDENT_WIDTH_NON_HIERARCHICAL
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520736F75726365206C697374207468617420746869732072656E6465726572206F70657261746573206F6E2E
		Function Owner() As XUISourceList
		  /// The source list that this renderer operates on.
		  ///
		  /// Part of the XUISourceListRenderer interface.
		  
		  If mOwner = Nil Or mOwner.Value = Nil Then
		    Return Nil
		  Else
		    Return XUISourceList(mOwner.Value)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4472617720746865206261636B67726F756E6420666F72207468652073706563696669656420726F772E2054686520726F77206D617920626520656D7074792E
		Sub RenderBackground(g As Graphics, row As Integer)
		  /// Draw the background for the specified row. The row may be empty.
		  ///
		  /// Part of the XUISourceListRenderer interface.
		  
		  #Pragma Unused row
		  
		  g.DrawingColor = Owner.Style.BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320606974656D6020746F207468652070617373656420677261706869637320636F6E746578742E2054686520636F6E746578742069732074686520656E7469726520726F7720746865206974656D206F636375706965732E
		Sub RenderItem(item As XUISourceListItem, g As Graphics, hoveringOverRow As Boolean, isSelected As Boolean)
		  /// Renders `item` to the passed graphics context. The context is the entire row the item occupies.
		  ///
		  /// Part of the `XUISourceListRenderer` interface.
		  
		  // Render sections differently.
		  If item.IsSection Then
		    RenderSection(item, g, hoveringOverRow)
		    Return
		  End If
		  
		  // Grab a reference to the owner's style for brevity.
		  Var style As XUISourceListStyle = Owner.Style
		  
		  // =================
		  // SELECTED ROW?
		  // =================
		  If isSelected Then
		    g.DrawingColor = style.SelectedColor
		    g.FillRoundRectangle(CONTENT_HORIZ_PADDING, CONTENT_VERT_PADDING, _
		    g.Width - (2 * CONTENT_HORIZ_PADDING), g.Height - (2 * CONTENT_VERT_PADDING), 10, 10)
		  End If
		  
		  // Since item's can be indented, compute the left X coordinate that its content starts at.
		  Var disclosureX As Double = (Max(item.Depth - 1, 0) * IndentWidth) + CONTENT_HORIZ_PADDING + _
		  DISCLOSURE_LEFT_PADDING
		  
		  // =================
		  // DISCLOSURE WIDGET
		  // =================
		  Var iconX As Double
		  If Owner.Hierarchical Then
		    If item.Expandable And item.ChildCount > 0 Then
		      g.DrawingColor = style.DisclosureWidgetColor
		      g.PenSize = 1
		      If item.Expanded Then
		        // Draw down-facing arrow.
		        Var rightX As Double = disclosureX + 10 // 10 is the widget width.
		        Var bottomX As Double = disclosureX + 5 // 5 is half the widget's height.
		        Var topY As Double = (g.Height / 2) - 2.5 // -2.5 is half the widget's height.
		        Var bottomY As Double = topY + 5 // 5 is the widget's height.
		        g.DrawLine(disclosureX, topY, bottomX, bottomY)
		        g.DrawLine(bottomX, bottomY, rightX, topY)
		        // Set the bounds for the disclosure widget. +1 is a fudge.
		        item.DisclosureBounds = New Rect(disclosureX, topY, rightX - disclosureX + 1, bottomY - topY + 1)
		      Else
		        // Draw rightward-facing arrow.
		        Var topY As Double = (g.Height / 2) - 5 // -5 is half the widget's height.
		        Var rightX As Double = disclosureX + 6 // 6 is widget width.
		        Var rightY As Double = topY + 5 // 5 is half the height of the widget.
		        Var bottomY As Double = topY + 10 // 10 is the widget height.
		        g.DrawLine(disclosureX, topY, rightX, rightY)
		        g.DrawLine(rightX, rightY, disclosureX, bottomY)
		        // Set the bounds for the disclosure widget. +1 is a fudge.
		        item.DisclosureBounds = New Rect(disclosureX, topY, rightX - disclosureX + 1, bottomY - topY + 1)
		      End If
		    End If
		    iconX = disclosureX + DISCLOSURE_MAX_WIDTH + ICON_LEFT_PADDING
		  Else
		    item.DisclosureBounds = Nil
		    iconX = (item.Depth * IndentWidth) + CONTENT_HORIZ_PADDING
		  End If
		  
		  // =================
		  // ICON
		  // =================
		  Var titleX As Double = iconX
		  // We assume the user has chosen an appropriate sized icon. We'll just centre it.
		  If item.HasIcon Then
		    g.DrawPicture(item.Icon, iconX, (g.Height / 2) - (item.Icon.Height / 2))
		    titleX = titleX + item.Icon.Width + TITLE_LEFT_PADDING
		  End If
		  
		  // =================
		  // TITLE
		  // =================
		  g.FontName = "System"
		  g.FontSize = 13
		  g.Bold = False
		  Var titleBaseline As Double = (g.FontAscent + (g.Height - g.TextHeight)/2)
		  g.DrawingColor = style.ItemColor
		  g.DrawText(item.Title, titleX, titleBaseline)
		  
		  // =================
		  // BADGE VALUE
		  // =================
		  Var badgeValue As Integer = item.BadgeValue // Cached as it's expensive.
		  If badgeValue > 0 And Not item.Expanded Then
		    Var badgeW As Double = Max(g.TextWidth(badgeValue.ToString) + (2 * BADGE_HORIZ_PADDING), BADGE_MIN_WIDTH)
		    Var badgeH As Double = g.TextHeight + (2 * BADGE_VERT_PADDING)
		    Var badgeY As Double = (g.Height / 2) - (badgeH / 2)
		    Var badgeX As Double = g.Width - CONTENT_HORIZ_PADDING - badgeW - BADGE_HORIZ_PADDING
		    DrawBadge(g, badgeValue, badgeX, badgeY, badgeW, badgeH)
		  End If
		  
		  // =================
		  // WIDGET
		  // =================
		  #Pragma Warning "TODO"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E6465727320606974656D6020617320612073656374696F6E20746F207468652070617373656420677261706869637320636F6E746578742E
		Private Sub RenderSection(section As XUISourceListItem, g As Graphics, hoveringOverRow As Boolean)
		  /// Renders `section` as a section to the passed graphics context.
		  ///
		  /// Assumes `g` is the graphics context provided by the `PaintCellBackground` event.
		  ///
		  /// When hovered over:
		  /// TITLE BADGE WIDGET DISCLOSURE
		  ///
		  /// When not hovered over:
		  /// TITLE BADGE
		  
		  // Grab a reference to the owner's style for brevity.
		  Var style As XUISourceListStyle = Owner.Style
		  
		  // ============
		  // TITLE
		  // ============
		  g.FontSize = 11
		  g.FontName = "System"
		  g.Bold = True
		  
		  // +3 shifts the title downwards as section titles are not vertically centred in the row.
		  Var titleBaseline As Double = (g.FontAscent + (g.Height - g.TextHeight)/2) + 3
		  g.DrawingColor = style.SectionColor
		  g.DrawText(section.Title, CONTENT_HORIZ_PADDING + SECTION_LEFT_PADDING, titleBaseline)
		  
		  // =================
		  // DISCLOSURE WIDGET
		  // =================
		  // If present, the disclosure widget is the right-most icon.
		  If hoveringOverRow And section.Expandable And section.ChildCount > 0 Then
		    g.DrawingColor = style.SectionDisclosureWidgetColor
		    g.PenSize = 1
		    If section.Expanded Then
		      // Draw down-facing arrow.
		      Var leftX As Double = g.Width - CONTENT_HORIZ_PADDING - DOWN_DISCLOSURE_WIDTH
		      Var rightX As Double = leftX + DOWN_DISCLOSURE_WIDTH
		      Var bottomX As Double = leftX + DOWN_DISCLOSURE_HEIGHT
		      Var topY As Double = g.Height - DOWN_DISCLOSURE_OFFSET_FROM_BOTTOM - DOWN_DISCLOSURE_HEIGHT
		      Var bottomY As Double = g.Height - DOWN_DISCLOSURE_OFFSET_FROM_BOTTOM
		      g.DrawLine(leftX, topY, bottomX, bottomY)
		      g.DrawLine(bottomX, bottomY, rightX, topY)
		      // Set the bounds for the disclosure widget.
		      section.DisclosureBounds = New Rect(leftX, topY, rightX - leftX, bottomY - topY)
		    Else
		      // Draw rightward-facing arrow.
		      Var leftX As Double = g.Width - CONTENT_HORIZ_PADDING - RIGHT_DISCLOSURE_WIDTH
		      Var topY As Double = g.Height - DISCLOSURE_OFFSET_FROM_BOTTOM - RIGHT_DISCLOSURE_HEIGHT
		      Var rightX As Double = leftX + RIGHT_DISCLOSURE_WIDTH
		      Var rightY As Double = topY + RIGHT_DISCLOSURE_HALF_HEIGHT
		      Var bottomY As Double = topY + RIGHT_DISCLOSURE_HEIGHT
		      g.DrawLine(leftX, topY, rightX, rightY)
		      g.DrawLine(rightX, rightY, leftX, bottomY)
		      // Set the bounds for the disclosure widget.
		      section.DisclosureBounds = New Rect(leftX, topY, rightX - leftX, bottomY - topY)
		    End If
		  End If
		  
		  // =================
		  // WIDGET
		  // =================
		  // Only drawn if the section hovered over. If present, it is second from the right (the disclosure
		  // widget may come after it).
		  If hoveringOverRow And section.HasWidget Then
		    // Compute the location of the widget.
		    Var leftX As Double
		    If section.DisclosureBounds <> Nil Then
		      // There is a disclosure widget after it. We'll use the width of the down disclosure widget because
		      // it's the widest one.
		      leftX = g.Width - CONTENT_HORIZ_PADDING - DOWN_DISCLOSURE_WIDTH - SECTION_WIDGET_DIAMETER - _
		      DISCLOSURE_LEFT_PADDING
		    Else
		      // This widget is the right-most icon.
		      leftX = g.Width - CONTENT_HORIZ_PADDING - SECTION_WIDGET_DIAMETER - DISCLOSURE_LEFT_PADDING
		    End If
		    Var topY As Double = (g.Height / 2) - SECTION_WIDGET_RADIUS + 2 // +2 is a fudge
		    // The widget is a circle with a plus in it. This renderer ignores any WidgetIcon assigned to this section.
		    g.PenSize = 2
		    g.DrawingColor = style.WidgetColor
		    // Draw the circle.
		    g.DrawOval(leftX, topY, SECTION_WIDGET_DIAMETER, SECTION_WIDGET_DIAMETER)
		    // Draw the plus sign.
		    //         x2,y1
		    //           |
		    //  x1, y2  ---   x3, y2
		    //           |
		    //         x2, y3
		    Var x1 As Double = leftX + 3
		    Var x2 As Double = leftX + SECTION_WIDGET_RADIUS - 1
		    Var x3 As Double = x1 + SECTION_WIDGET_PLUS_WIDTH
		    Var y1 As Double = topY + 3
		    Var y2 As Double = topY + SECTION_WIDGET_RADIUS - 1
		    Var y3 As Double = topY + SECTION_WIDGET_PLUS_HEIGHT
		    g.DrawLine(x2, y1, x2, y3)
		    g.DrawLine(x1, y2, x3, y2)
		    // Set the bounds for the widget.
		    section.WidgetBounds = New Rect(x1, y1, SECTION_WIDGET_DIAMETER, SECTION_WIDGET_DIAMETER)
		  End If
		  
		  // =================
		  // BADGE VALUE
		  // =================
		  Var badgeValue As Integer = section.BadgeValue // Cached as it's expensive.
		  If Not section.Expanded And section.ShowBadge And badgeValue > 0 Then
		    Var badgeW As Double = Max(g.TextWidth(badgeValue.ToString) + (2 * BADGE_HORIZ_PADDING), BADGE_MIN_WIDTH)
		    Var badgeH As Double = g.TextHeight + (2 * BADGE_VERT_PADDING)
		    Var badgeY As Double = g.Height - SECTION_BADGE_OFFSET_FROM_BOTTOM - badgeH
		    Var badgeX As Double // Varies depending on the presence of other widgets.
		    If hoveringOverRow Then
		      // There should be a disclosure widget +/- a widget.
		      If section.WidgetBounds <> Nil Then
		        // We draw the badge immediately to the left of the widget.
		        badgeX = section.WidgetBounds.Left - SECTION_WIDGET_LEFT_PADDING - badgeW
		      ElseIf section.DisclosureBounds <> Nil Then
		        // Draw the badge immediately to the left of the disclosure widget.
		        badgeX = section.DisclosureBounds.Left - SECTION_WIDGET_LEFT_PADDING - badgeW
		      Else
		        // No other widgets. 
		        badgeX = g.Width - CONTENT_HORIZ_PADDING - badgeW
		      End If
		    Else
		      // There are no other widgets to the right of the title, only the badge.
		      badgeX = g.Width - CONTENT_HORIZ_PADDING - badgeW
		    End If
		    DrawBadge(g, badgeValue, badgeX, badgeY, badgeW, badgeH)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520686569676874206F66206120726F7720696E2074686520736F75726365206C6973742E
		Function RowHeight() As Integer
		  /// The height of a row in the source list.
		  
		  Return 30
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520736F75726365206C697374207468617420746869732072656E6465726572206F70657261746573206F6E2E
		Private mOwner As WeakRef
	#tag EndProperty


	#tag Constant, Name = BADGE_HORIZ_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865207468652062616467652076616C756520696E7465726E616C6C79206C65667420616E642072696768742066726F6D2074686520737572726F756E64696E6720726F756E64656420726563742E
	#tag EndConstant

	#tag Constant, Name = BADGE_MIN_WIDTH, Type = Double, Dynamic = False, Default = \"20", Scope = Private, Description = 546865206D696D696D756D207769647468206F6620612062616467652E
	#tag EndConstant

	#tag Constant, Name = BADGE_VERT_PADDING, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865207468652062616467652076616C756520696E7465726E616C6C792061626F766520616E642062656C6F772066726F6D2074686520737572726F756E64696E6720726F756E64656420726563742E
	#tag EndConstant

	#tag Constant, Name = CONTENT_HORIZ_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520636F6E74656E74206F66206120726F772066726F6D20697473206C65667420616E642072696768742065646765732E20
	#tag EndConstant

	#tag Constant, Name = CONTENT_VERT_PADDING, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520636F6E74656E74206F66206120726F772061626F766520616E642062656C6F772E
	#tag EndConstant

	#tag Constant, Name = DISCLOSURE_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206C6566742065646765206F662074686520646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = DISCLOSURE_MAX_WIDTH, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206D6178696D756D2077696474682074686520646973636C6F73757265207769646765742069732E
	#tag EndConstant

	#tag Constant, Name = DISCLOSURE_OFFSET_FROM_BOTTOM, Type = Double, Dynamic = False, Default = \"8", Scope = Private, Description = 546865206E756D626572206F6620706978656C732074686520626F74746F6D206F662074686520646973636C6F7375726520776964676574206973206F66667365742066726F6D2074686520626F74746F6D2065646765206F662074686520726F772E
	#tag EndConstant

	#tag Constant, Name = DOWN_DISCLOSURE_HEIGHT, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 5468652068656967687420696E20706978656C73206F662074686520646F776E776172647320666163696E6720646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = DOWN_DISCLOSURE_OFFSET_FROM_BOTTOM, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C732074686520626F74746F6D206F662074686520646F776E20646973636C6F7375726520776964676574206973206F66667365742066726F6D2074686520626F74746F6D2065646765206F662074686520726F772E
	#tag EndConstant

	#tag Constant, Name = DOWN_DISCLOSURE_WIDTH, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 54686520776964746820696E20706978656C73206F662074686520646F776E776172647320666163696E6720646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = ICON_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206C6566742073696465206F6620616E206974656D27732069636F6E2066726F6D206120646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = INDENT_WIDTH_HIERARCHICAL, Type = Double, Dynamic = False, Default = \"14", Scope = Private, Description = 546865206E756D626572206F6620706978656C73206F6620696E64656E746174696F6E2065616368206C6576656C206F66206465707468206164647320746F207468652058206F66667365742E
	#tag EndConstant

	#tag Constant, Name = INDENT_WIDTH_NON_HIERARCHICAL, Type = Double, Dynamic = False, Default = \"8", Scope = Private, Description = 546865206E756D626572206F6620706978656C73206F6620696E64656E746174696F6E2065616368206C6576656C206F66206465707468206164647320746F207468652058206F66667365742E
	#tag EndConstant

	#tag Constant, Name = RIGHT_DISCLOSURE_HALF_HEIGHT, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 5468652068616C662068656967687420696E20706978656C73206F6620746865207269676874776172647320666163696E6720646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = RIGHT_DISCLOSURE_HEIGHT, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 5468652068656967687420696E20706978656C73206F6620746865207269676874776172647320666163696E6720646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = RIGHT_DISCLOSURE_WIDTH, Type = Double, Dynamic = False, Default = \"6", Scope = Private, Description = 54686520776964746820696E20706978656C73206F6620746865207269676874776172647320666163696E6720646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = SECTION_BADGE_OFFSET_FROM_BOTTOM, Type = Double, Dynamic = False, Default = \"4", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F206F66667365742074686520626F74746F6D206261646765732066726F6D2074686520626F74746F6D2065646765206F662073656374696F6E20726F77732E
	#tag EndConstant

	#tag Constant, Name = SECTION_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"3", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206C656674206F66207468652073656374696F6E207469746C6520696E2066726F6D2074686520636F6E74656E7420617265612E
	#tag EndConstant

	#tag Constant, Name = SECTION_WIDGET_DIAMETER, Type = Double, Dynamic = False, Default = \"13", Scope = Private, Description = 546865206469616D65746572206F66207468652073656374696F6E2077696467657420636972636C652E
	#tag EndConstant

	#tag Constant, Name = SECTION_WIDGET_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206C6566742065646765206F66207468652062616467652E
	#tag EndConstant

	#tag Constant, Name = SECTION_WIDGET_OFFSET_FROM_BOTTOM, Type = Double, Dynamic = False, Default = \"8", Scope = Private, Description = 546865206E756D626572206F6620706978656C732074686520626F74746F6D206F66207468652073656374696F6E20776964676574206973206F66667365742066726F6D2074686520626F74746F6D2065646765206F662074686520726F772E
	#tag EndConstant

	#tag Constant, Name = SECTION_WIDGET_PLUS_HEIGHT, Type = Double, Dynamic = False, Default = \"8", Scope = Private, Description = 54686520686569676874206F662074686520706C75732069636F6E20696E207468652073656374696F6E207769646765742E
	#tag EndConstant

	#tag Constant, Name = SECTION_WIDGET_PLUS_WIDTH, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865207769647468206F662074686520706C75732069636F6E20696E207468652073656374696F6E207769646765742E
	#tag EndConstant

	#tag Constant, Name = SECTION_WIDGET_RADIUS, Type = Double, Dynamic = False, Default = \"6.5", Scope = Private, Description = 54686520726169647573206F66207468652073656374696F6E2077696467657420636972636C652E
	#tag EndConstant

	#tag Constant, Name = TITLE_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206C6566742073696465206F6620616E206974656D2773207469746C652066726F6D206974732069636F6E2E
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
	#tag EndViewBehavior
End Class
#tag EndClass
