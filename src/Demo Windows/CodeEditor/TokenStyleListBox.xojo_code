#tag Class
Protected Class TokenStyleListBox
Inherits DesktopListBox
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  // Get the style.
		  Var style As XUICETokenStyle = Dictionary(Me.RowTagAt(row)).Value("style")
		  
		  Select Case column
		  Case COL_BOLD
		    style.Bold = Me.CellCheckBoxValueAt(row, column)
		    
		  Case COL_ITALIC
		    style.Italic = Me.CellCheckBoxValueAt(row, column)
		    
		  Case COL_UNDERLINE
		    style.Underline = Me.CellCheckBoxValueAt(row, column)
		    
		  Case COL_HAS_BACKGROUND
		    style.HasBackgroundColour = Me.CellCheckBoxValueAt(row, column)
		  End Select
		  
		  RaiseEvent DidChangeStyle
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function CellPressed(row As Integer, column As Integer, x As Integer, y As Integer) As Boolean
		  // We will let Xojo handle the clicking of all cells except the colour cells.
		  If column <> COL_COLOR And column <> COL_BACKGROUND_COLOR Then Return False
		  
		  // Get a reference to the token style we're modifying.
		  Var tag As Dictionary = RowTagAt(row)
		  Var style As XUICETokenStyle = tag.Value("style")
		  
		  Var lightBounds, darkBounds As Rect
		  If column = COL_COLOR Then
		    lightBounds = tag.Lookup("colorLightBounds", Nil)
		    darkBounds = tag.Lookup("colorDarkBounds", Nil)
		    If lightBounds <> Nil And lightBounds.Contains(x, y) Then
		      ShowColorPicker(style, ColorTargets.ColorLight)
		    ElseIf darkBounds <> Nil And darkBounds.Contains(x, y) Then
		      ShowColorPicker(style, ColorTargets.ColorDark)
		    End If
		  Else
		    lightBounds = tag.Lookup("backgroundColorLightBounds", Nil)
		    darkBounds = tag.Lookup("backgroundColorDarkBounds", Nil)
		    If lightBounds <> Nil And lightBounds.Contains(x, y) Then
		      ShowColorPicker(style, ColorTargets.BackgroundColorLight)
		    ElseIf darkBounds <> Nil And darkBounds.Contains(x, y) Then
		      ShowColorPicker(style, ColorTargets.BackgroundColorDark)
		    End If
		  End If
		  
		End Function
	#tag EndEvent

	#tag Event
		Function PaintCellText(g as Graphics, row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  // We will let Xojo handle the drawing of all cells except the colour cells.
		  If column <> COL_COLOR And column <> COL_BACKGROUND_COLOR Then Return False
		  
		  Const swatchPadding As Double = 3
		  Var swatchH As Double = g.Height - (2 * swatchPadding)
		  Var swatchW As Double = Min(swatchH, (g.Width / 2) - (2 * swatchPadding))
		  
		  // Get the style for this row.
		  Var style As XUICETokenStyle = Dictionary(Me.RowTagAt(row)).Value("style")
		  
		  // Get the correct light and dark colours.
		  Var light, dark As Color
		  If column = COL_COLOR Then
		    light = style.Colour.Light
		    dark = style.Colour.Dark
		  Else
		    light = style.BackgroundColour.Light
		    dark = style.BackgroundColour.Dark
		  End If
		  
		  // Light mode colour.
		  g.DrawingColor = light
		  g.FillRoundRectangle(swatchPadding, swatchPadding, swatchW, swatchH, 5, 5)
		  g.DrawingColor = Color.Black
		  g.DrawRoundRectangle(swatchPadding, swatchPadding, swatchW, swatchH, 5, 5)
		  Var key As String = If(column = COL_COLOR, "colorLightBounds", "backgroundColorLightBounds")
		  Dictionary(Me.RowTagAt(row)).Value(key) = New Rect(swatchPadding, swatchPadding, swatchW, swatchH)
		  
		  // Dark mode colour.
		  g.DrawingColor = dark
		  g.FillRoundRectangle(g.Width - swatchPadding - swatchW, swatchPadding, swatchW, swatchH, 5, 5)
		  g.DrawingColor = Color.Black
		  g.DrawRoundRectangle(g.Width - swatchPadding - swatchW, swatchPadding, swatchW, swatchH, 5, 5)
		  key = If(column = COL_COLOR, "colorDarkBounds", "backgroundColorDarkBounds")
		  Dictionary(Me.RowTagAt(row)).Value(key) = _
		  New Rect(g.Width - swatchPadding - swatchW, swatchPadding, swatchW, swatchH)
		  
		  Return True
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 41646473206120746F6B656E207374796C6520746F20746865206C697374626F782E
		Sub AddTokenStyle(tokenName As String, style As XUICETokenStyle)
		  /// Adds a token style to the listbox.
		  
		  // Add the token's name to the row.
		  Me.AddRow(tokenName)
		  
		  Var lastAdded As Integer = Me.LastAddedRowIndex
		  
		  // Set the row tag to a dictionary containing the style.
		  Me.RowTagAt(Me.LastAddedRowIndex) = New Dictionary("style" : style)
		  
		  // Set the bold, italic, underline and has background columns to checkboxes.
		  Me.CellTypeAt(lastAdded, COL_BOLD) = DesktopListBox.CellTypes.CheckBox
		  Me.CellCheckBoxValueAt(lastAdded, COL_BOLD) = style.Bold
		  
		  Me.CellTypeAt(lastAdded, COL_ITALIC) = DesktopListBox.CellTypes.CheckBox
		  Me.CellCheckBoxValueAt(lastAdded, COL_ITALIC) = style.Italic
		  
		  Me.CellTypeAt(lastAdded, COL_UNDERLINE) = DesktopListBox.CellTypes.CheckBox
		  Me.CellCheckBoxValueAt(lastAdded, COL_UNDERLINE) = style.Underline
		  
		  Me.CellTypeAt(lastAdded, COL_HAS_BACKGROUND) = DesktopListBox.CellTypes.CheckBox
		  Me.CellCheckBoxValueAt(lastAdded, COL_HAS_BACKGROUND) = style.HasBackgroundColour
		  
		  // Assign a blank value to the color and background color columns so Xojo calls the 
		  // `PaintCellText` event for them.
		  Me.CellTextAt(lastAdded, COL_COLOR) = ""
		  Me.CellTextAt(lastAdded, COL_BACKGROUND_COLOR) = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C656761746520746861742069732063616C6C6564207768656E207468697320737761746368277320636F6C6F72207069636B6572277320636F6C6F7572206973206368616E6765642E
		Private Sub PickerColorChanged(picker As XUIColorPicker, newColor As Color)
		  /// Delegate that is called when our color picker's colour is changed.
		  
		  #Pragma Unused picker
		  
		  Select Case mCurrentColorTarget
		  Case ColorTargets.BackgroundColorDark
		    mCurrentStyle.BackgroundColour = New ColorGroup(mCurrentStyle.BackgroundColour.Light, newColor)
		    
		  Case ColorTargets.BackgroundColorLight
		    mCurrentStyle.BackgroundColour = New ColorGroup(newColor, mCurrentStyle.BackgroundColour.Dark)
		    
		  Case ColorTargets.ColorDark
		    mCurrentStyle.Colour = New ColorGroup(mCurrentStyle.Colour.Light, newColor)
		    
		  Case ColorTargets.ColorLight
		    mCurrentStyle.Colour = New ColorGroup(newColor, mCurrentStyle.Colour.Dark)
		  End Select
		  
		  RaiseEvent DidChangeStyle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowColorPicker(style As XUICETokenStyle, target As ColorTargets)
		  /// Shows the colour picker for the passed style and the colour within that style we're manipulating.
		  
		  If Self.Window = Nil Then Return
		  
		  mCurrentColorTarget = target
		  mCurrentStyle = style
		  
		  // Get the initial colour.
		  Var initial As Color
		  Select Case target
		  Case ColorTargets.BackgroundColorDark
		    initial = style.BackgroundColour.Dark
		    
		  Case ColorTargets.BackgroundColorLight
		    initial = style.BackgroundColour.Light
		    
		  Case ColorTargets.ColorDark
		    initial = style.Colour.Dark
		    
		  Case ColorTargets.ColorLight
		    initial = style.Colour.Light
		  End Select
		  
		  Var cp As New XUIColorPicker(initial)
		  AddHandler cp.ColorChanged, AddressOf PickerColorChanged
		  cp.ShowModal(Self.Window)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5570646174657320746865206C697374626F78207769746820746865206461746120696E20607468656D65602E
		Sub Update(theme As XUICETheme)
		  /// Updates the listbox with the data in `theme`.
		  
		  Me.RemoveAllRows
		  
		  // Keep a reference to this theme.
		  mTheme = theme
		  
		  Var styleNames() As String = mTheme.StyleNames
		  
		  For Each name As String In styleNames
		    
		    AddTokenStyle(name, mTheme.StyleForName(name))
		    
		  Next name
		  
		  // Sort alphabetically by token name.
		  Me.SortingColumn = COL_NAME
		  Me.Sort
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 4F6E65206F6620746865207468656D652773207374796C657320686173206368616E6765642E
		Event DidChangeStyle()
	#tag EndHook


	#tag Property, Flags = &h21, Description = 5468652063757272656E7420636F6C6F7572207765206172652074617267657474696E6720776974682074686520636F6C6F7572207069636B65722E
		Private mCurrentColorTarget As ColorTargets
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E74207374796C65206265696E67206D616E6970756C617465642062792074686520636F6C6F7572207069636B65722E
		Private mCurrentStyle As XUICETokenStyle
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865207468656D652E
		Private mTheme As XUICETheme
	#tag EndProperty


	#tag Constant, Name = COL_BACKGROUND_COLOR, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = COL_BOLD, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = COL_COLOR, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = COL_HAS_BACKGROUND, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = COL_ITALIC, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = COL_NAME, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = COL_UNDERLINE, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ColorTargets, Type = Integer, Flags = &h0
		ColorLight
		  ColorDark
		  BackgroundColorLight
		BackgroundColorDark
	#tag EndEnum


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
			InitialValue=""
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="450"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="357"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="7"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue="*, 25, 25, 25, 70, 45, 70"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="28"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLineStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="GridLineStyles"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Horizontal"
				"2 - Vertical"
				"3 - Both"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
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
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue="Token	B	I	U	Color	Back?	Back"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollOffset"
			Visible=false
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=false
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
