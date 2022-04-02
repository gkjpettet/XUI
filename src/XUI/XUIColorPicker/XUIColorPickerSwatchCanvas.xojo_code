#tag Class
Protected Class XUIColorPickerSwatchCanvas
Inherits DesktopCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  For i As Integer = 0 To mPalette.LastIndex
		    Var bounds As Rect = mPalette(i).Right
		    If bounds <> Nil And bounds.Contains(x, y) Then
		      SelectedIndex = i
		      mDidMouseDownOverSwatch = True
		      Return true
		    End If
		  Next i
		  
		  mDidMouseDownOverSwatch = False
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  If mDidMouseDownOverSwatch Then
		    RaiseEvent PressedSwatch(SelectedColor)
		    mDidMouseDownOverSwatch = False
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  If mShouldRecomputeBounds Then
		    ComputeBounds(g)
		    mShouldRecomputeBounds = False
		  End If
		  
		  For i As Integer = 0 To mPalette.LastIndex
		    Var bounds As Rect = mPalette(i).Right
		    If bounds = Nil Then Continue
		    
		    Var swatchColor As Color = mPalette(i).Left
		    g.DrawingColor = swatchColor
		    
		    // Content.
		    g.FillRoundRectangle(bounds.Left, bounds.Top, bounds.Width, bounds.Height, 5, 5)
		    
		    // Border.
		    g.DrawingColor = mSwatchBorderColor
		    g.DrawRoundRectangle(bounds.Left, bounds.Top, bounds.Width, bounds.Height, 5, 5)
		    
		    // Selected?
		    If i = mSelectedIndex Then
		      g.DrawingColor = swatchColor.Complementary
		      g.FillOval(bounds.Center.X - 3, bounds.Center.Y - 3, SELECTION_DOT_DIAMETER, SELECTION_DOT_DIAMETER)
		    End If
		  Next i
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 416464732061206E657720636F6C6F757220746F207468652063616E7661732E
		Sub AddColor(c As Color, shouldRefresh As Boolean = True)
		  /// Adds a new colour to the canvas. By default the canvas is refreshed.
		  
		  mPalette.Add(c : Nil)
		  
		  mShouldRecomputeBounds = True
		  
		  If shouldRefresh Then Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41646473206D756C7469706C6520636F6C6F75727320746F207468652063616E7661732E205468652063616E766173206973206E6F74206175746F6D61746963616C6C79207265667265736865642E
		Sub AddColors(colours() As Color)
		  /// Adds multiple colours to the canvas. The canvas is automatically refreshed.
		  
		  For Each c As Color In colours
		    AddColor(c, False)
		  Next c
		  
		  Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70757465732074686520626F756E6473206F662065616368206F662074686520636F6C6F7572207377617463686573
		Private Sub ComputeBounds(g As Graphics)
		  /// Computes the bounds of each of the colour swatches
		  
		  Var x, y As Double = 0
		  For i As Integer = 0 To mPalette.LastIndex
		    Var p As Pair = mPalette(i)
		    mPalette(i) = p.Left : New Rect(x, y, g.Width, SwatchHeight)
		    y = Rect(mPalette(i).Right).Bottom + SwatchVerticalPadding
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  mSwatchBorderColor = New ColorGroup(Color.Black, Color.Gray)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616C6C20636F6C6F7572732066726F6D207468652063616E7661732E
		Sub RemoveAllColors()
		  /// Removes all colours from the canvas.
		  
		  mPalette.RemoveAll
		  
		  Refresh
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 546865207573657220636C69636B6564206120636F6C6F7572207377617463682E
		Event PressedSwatch(selectedColor As Color)
	#tag EndHook


	#tag Property, Flags = &h21, Description = 5472756520696620746865207573657220636C69636B6564206120636F6C6F75722073776174636820647572696E6720746865206C61737420604D6F757365446F776E60206576656E742E
		Private mDidMouseDownOverSwatch As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F75727320746F20647261772061732073776174636865732E204C656674203D20436F6C6F722C205269676874203D20426F756E64732E
		Private mPalette() As Pair
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E746C792073656C65637465642073776174636820696E6465782E
		Private mSelectedIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2074686520626F756E6473206F662074686520737761746368657320696E207468652070616C657474652077696C6C206265207265636F6D707574656420647572696E6720746865206E65787420605061696E7460206576656E742E
		Private mShouldRecomputeBounds As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F722074686520626F72646572206F66207468652073776174636865732E
		Private mSwatchBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520686569676874206F662061207377617463682E
		Private mSwatchHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520616D6F756E74206F662070616464696E67206265747765656E2073776174636865732E
		Private mSwatchVerticalPadding As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E746C792073656C656374656420636F6C6F75722E
		#tag Getter
			Get
			  // In case of an error, we just return black.
			  
			  If mPalette.Count = 0 Then
			    Return Color.Black
			  End If
			  
			  If mSelectedIndex < 0 Or mSelectedIndex > mPalette.LastIndex Then
			    Return Color.Black
			  Else
			    Return mPalette(mSelectedIndex).Left
			  End If
			  
			End Get
		#tag EndGetter
		SelectedColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696E646578206F66207468652063757272656E746C792073656C6563746564207377617463682E
		#tag Getter
			Get
			  Return mSelectedIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mPalette.Count = 0 Then
			    mSelectedIndex = -1
			    Return
			  End If
			  
			  If value < 0 Then
			    mSelectedIndex = 0
			  ElseIf value > mPalette.LastIndex Then
			    mSelectedIndex = mPalette.LastIndex
			  Else
			    mSelectedIndex = value
			  End If
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		SelectedIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520686569676874206F662061207377617463682E
		#tag Getter
			Get
			  Return mSwatchHeight
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Minimum height of 2.
			  mSwatchHeight = Max(value, 2)
			  
			  mShouldRecomputeBounds = True
			  
			  Refresh
			End Set
		#tag EndSetter
		SwatchHeight As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520616D6F756E74206F662070616464696E67206265747765656E2073776174636865732E
		#tag Getter
			Get
			  Return mSwatchVerticalPadding
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mSwatchVerticalPadding = value
			  
			  mShouldRecomputeBounds = True
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		SwatchVerticalPadding As Integer
	#tag EndComputedProperty


	#tag Constant, Name = SELECTION_DOT_DIAMETER, Type = Double, Dynamic = False, Default = \"6", Scope = Private, Description = 546865206469616D65746572206F662074686520646F7420647261776E20696E207468652063656E747265206F66207468652073656C6563746564207377617463682E
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
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
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
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SwatchHeight"
			Visible=true
			Group="Behavior"
			InitialValue="25"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SwatchVerticalPadding"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
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
			Name="SelectedIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
