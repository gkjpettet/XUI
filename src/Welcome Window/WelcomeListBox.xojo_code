#tag Class
Protected Class WelcomeListBox
Inherits DesktopListBox
	#tag Event
		Sub DoublePressed()
		  Var row As Integer = Me.RowFromXY(mLastClickX, mLastClickY)
		  
		  If row < 0 Or row >= Me.RowCount Then Return
		  
		  Var product As WelcomeListBoxItem = Me.RowTagAt(row)
		  If product.DemoWindow <> Nil Then
		    product.DemoWindow.Center
		    product.DemoWindow.Show
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  mLastClickX = x
		  mLastClickY = y
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Me.DefaultRowHeight = 56
		  Me.AllowFocusRing = False
		End Sub
	#tag EndEvent

	#tag Event
		Function PaintCellText(g as Graphics, row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  #Pragma Unused column
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  Const FUDGE = 4
		  
		  // Get the product for this row.
		  Var product As WelcomeListBoxItem = Self.RowTagAt(row)
		  
		  g.FontSize = PRODUCT_NAME_FONT_SIZE
		  Var nameH As Double = g.TextHeight
		  Var nameW As Double = g.TextWidth(product.Name)
		  
		  g.FontSize = PRODUCT_DESCRIPTION_FONT_SIZE
		  Var descriptionH As Double = g.TextHeight
		  Var descriptionW As Double = g.TextWidth(product.Description)
		  
		  Var nameY As Double = (g.Height / 2) - (nameH / 2) + FUDGE
		  Var descriptionY As Double = (g.Height / 2) + descriptionH
		  
		  // Product name.
		  g.FontSize = PRODUCT_NAME_FONT_SIZE
		  If Self.SelectedRowIndex = row Then
		    g.DrawingColor = mProductNameSelectedColor
		  Else
		    g.DrawingColor = mProductNameColor
		  End If
		  g.DrawText(product.Name, (g.Width / 2) - (nameW / 2), nameY)
		  
		  // Description.
		  g.FontSize = PRODUCT_DESCRIPTION_FONT_SIZE
		  If Self.SelectedRowIndex = row Then
		    g.DrawingColor = mProductDescriptionSelectedColor
		  Else
		    g.DrawingColor = mProductDescriptionColor
		  End If
		  g.DrawText(product.Description, (g.Width / 2) - (descriptionW / 2), descriptionY)
		  
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 4164647320612070726F647563742064656D6F20746F20746865206C697374626F782E
		Sub AddProduct(productName As String, description As String, demo As DemoWindow)
		  /// Adds a product demo to the listbox.
		  ///
		  /// The product name is column 0. The product item is stored as a row tag.
		  
		  Var product As New WelcomeListBoxItem(productName, description, demo)
		  
		  Self.AddRow(product.Name)
		  Self.RowTagAt(Self.LastAddedRowIndex) = product
		  
		  // Sort the listbox alphabetically by column 0 (the product name).
		  Self.SortingColumn = 0
		  Self.ColumnSortDirectionAt(0) = DesktopListBox.SortDirections.Ascending
		  Self.Sort
		  
		  Self.SelectedRowIndex = -1
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 546865205820636F6F7264696E6174652066726F6D20746865206C617374204D6F757365446F776E206576656E742E
		Private mLastClickX As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205920636F6F7264696E6174652066726F6D20746865206C617374204D6F757365446F776E206576656E742E
		Private mLastClickY As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Static cg As New ColorGroup(Color.FromString("&h00797979"), Color.FromString("&h00797979"))
			  
			  Return cg
			  
			End Get
		#tag EndGetter
		Private mProductDescriptionColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Static cg As New ColorGroup(Color.White, Color.White)
			  
			  Return cg
			  
			End Get
		#tag EndGetter
		Private mProductDescriptionSelectedColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Static cg As New ColorGroup(Color.Black, Color.White)
			  
			  Return cg
			  
			End Get
		#tag EndGetter
		Private mProductNameColor As ColorGroup
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Static cg As New ColorGroup(Color.White, Color.White)
			  
			  Return cg
			  
			End Get
		#tag EndGetter
		Private mProductNameSelectedColor As ColorGroup
	#tag EndComputedProperty


	#tag Constant, Name = PRODUCT_DESCRIPTION_FONT_SIZE, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PRODUCT_NAME_FONT_SIZE, Type = Double, Dynamic = False, Default = \"15", Scope = Private
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
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
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
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="40"
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
			InitialValue="False"
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
			InitialValue=""
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
			InitialValue="True"
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
