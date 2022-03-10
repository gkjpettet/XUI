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
		  
		  g.DrawingColor = Owner.Style.BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320606974656D6020746F207468652070617373656420677261706869637320636F6E746578742E2054686520636F6E746578742069732074686520656E7469726520726F7720746865206974656D206F636375706965732E
		Sub RenderItem(item As XUISourceListItem, g As Graphics, hoveringOverRow As Boolean, isSelected As Boolean)
		  /// Renders `item` to the passed graphics context. The context is the entire row the item occupies.
		  ///
		  /// Part of the `XUISourceListRenderer` interface.
		  
		  #Pragma Warning "TODO"
		  
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
		  Var disclosureX As Double = (Max(item.Depth - 1, 0) * INDENT_WIDTH) + CONTENT_HORIZ_PADDING + _
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
		        // Set the bounds for the disclosure widget.
		        item.DisclosureBounds = New Rect(disclosureX, topY, rightX - disclosureX, bottomY - topY)
		      Else
		        // Draw rightward-facing arrow.
		        Var topY As Double = (g.Height / 2) - 5 // -5 is half the widget's height.
		        Var rightX As Double = disclosureX + 6 // 6 is widget width.
		        Var rightY As Double = topY + 5 // 5 is half the height of the widget.
		        Var bottomY As Double = topY + 10 // 10 is the widget height.
		        g.DrawLine(disclosureX, topY, rightX, rightY)
		        g.DrawLine(rightX, rightY, disclosureX, bottomY)
		        // Set the bounds for the disclosure widget.
		        item.DisclosureBounds = New Rect(disclosureX, topY, rightX - disclosureX, bottomY - topY)
		      End If
		    End If
		    iconX = disclosureX + DISCLOSURE_MAX_WIDTH + ICON_LEFT_PADDING
		  Else
		    item.DisclosureBounds = Nil
		    iconX = (item.Depth * INDENT_WIDTH) + CONTENT_HORIZ_PADDING
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
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E6465727320606974656D6020617320612073656374696F6E20746F207468652070617373656420677261706869637320636F6E746578742E
		Private Sub RenderSection(section As XUISourceListItem, g As Graphics, hoveringOverRow As Boolean)
		  /// Renders `section` as a section to the passed graphics context.
		  ///
		  /// Assumes `g` is the graphics context provided by the `PaintCellBackground` event.
		  
		  #Pragma Warning "TODO"
		  
		  // Grab a reference to the owner's style for brevity.
		  Var style As XUISourceListStyle = Owner.Style
		  
		  // ============
		  // TITLE
		  // ============
		  g.FontSize = 11
		  g.FontName = "System"
		  g.Bold = True
		  
		  // +4 shifts the title downwards as section titles are not vertically centred in the row.
		  Var titleBaseline As Double = (g.FontAscent + (g.Height - g.TextHeight)/2) + 4
		  g.DrawingColor = style.SectionColor
		  g.DrawText(section.Title, CONTENT_HORIZ_PADDING + SECTION_LEFT_PADDING, titleBaseline)
		  
		  // =================
		  // DISCLOSURE WIDGET
		  // =================
		  If hoveringOverRow And section.Expandable And section.ChildCount > 0 Then
		    g.DrawingColor = style.SectionDisclosureWidgetColor
		    g.PenSize = 1
		    Const DISCLOSURE_OFFSET_FROM_BOTTOM = 8
		    If section.Expanded Then
		      // Draw down-facing arrow.
		      Var leftX As Double = g.Width - CONTENT_HORIZ_PADDING - 10 // 10 is the widget width.
		      Var rightX As Double = leftX + 10 // 10 is the widget width.
		      Var bottomX As Double = leftX + 5 // 5 is half the widget's height.
		      Var topY As Double = g.Height - DISCLOSURE_OFFSET_FROM_BOTTOM - 5 // -5 is widget height.
		      Var bottomY As Double = g.Height - DISCLOSURE_OFFSET_FROM_BOTTOM
		      g.DrawLine(leftX, topY, bottomX, bottomY)
		      g.DrawLine(bottomX, bottomY, rightX, topY)
		      // Set the bounds for the disclosure widget.
		      section.DisclosureBounds = New Rect(leftX, topY, rightX - leftX, bottomY - topY)
		    Else
		      // Draw rightward-facing arrow.
		      Var leftX As Double = g.Width - CONTENT_HORIZ_PADDING - 6 // 6 is widget width.
		      Var topY As Double = g.Height - DISCLOSURE_OFFSET_FROM_BOTTOM - 10 // -10 is the widget height.
		      Var rightX As Double = leftX + 6 // 6 is widget width.
		      Var rightY As Double = topY + 5 // 5 is half the height of the widget.
		      Var bottomY As Double = topY + 10 // 10 is the widget height.
		      g.DrawLine(leftX, topY, rightX, rightY)
		      g.DrawLine(rightX, rightY, leftX, bottomY)
		      // Set the bounds for the disclosure widget.
		      section.DisclosureBounds = New Rect(leftX, topY, rightX - leftX, bottomY - topY)
		    End If
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


	#tag Constant, Name = CONTENT_HORIZ_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520636F6E74656E74206F66206120726F772066726F6D20697473206C65667420616E642072696768742065646765732E20
	#tag EndConstant

	#tag Constant, Name = CONTENT_VERT_PADDING, Type = Double, Dynamic = False, Default = \"2", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F207061642074686520636F6E74656E74206F66206120726F772061626F766520616E642062656C6F772E
	#tag EndConstant

	#tag Constant, Name = DISCLOSURE_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"3", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206C6566742065646765206F662074686520646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = DISCLOSURE_MAX_WIDTH, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206D6178696D756D2077696474682074686520646973636C6F73757265207769646765742069732E
	#tag EndConstant

	#tag Constant, Name = ICON_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206C6566742073696465206F6620616E206974656D27732069636F6E2066726F6D206120646973636C6F73757265207769646765742E
	#tag EndConstant

	#tag Constant, Name = INDENT_WIDTH, Type = Double, Dynamic = False, Default = \"8", Scope = Private, Description = 546865206E756D626572206F6620706978656C73206F6620696E64656E746174696F6E2065616368206C6576656C206F66206465707468206164647320746F207468652058206F66667365742E
	#tag EndConstant

	#tag Constant, Name = SECTION_LEFT_PADDING, Type = Double, Dynamic = False, Default = \"3", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206C656674206F66207468652073656374696F6E207469746C6520696E2066726F6D2074686520636F6E74656E7420617265612E
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