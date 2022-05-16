#tag Class
Protected Class XUIColorPickerColorDotCanvas
Inherits DesktopCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  For i As Integer = 0 To mDots.LastIndex
		    Var dot As XUIColorPickerColorDot = mDots(i)
		    If dot.Bounds <> Nil And dot.Bounds.Contains(x, y) Then
		      SelectedIndex = i
		      mDidMouseDownOverColorDot = True
		      Return true
		    End If
		  Next i
		  
		  mDidMouseDownOverColorDot = False
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  If mDidMouseDownOverColorDot Then
		    RaiseEvent PressedColorDot(SelectedDot)
		    mDidMouseDownOverColorDot = False
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
		  
		  // Draw the dots.
		  For i As Integer = 0 To mDots.LastIndex
		    Var dot As XUIColorPickerColorDot = mDots(i)
		    
		    If dot.Bounds = Nil Then Continue
		    
		    g.DrawingColor = dot.Colour
		    
		    If i = mSelectedIndex Then
		      // Draw the dot.
		      g.FillOval(dot.Bounds.Left, dot.Bounds.Top, DotDiameter, DotDiameter)
		      
		      // Draw a selection dot in the centre.
		      g.ShadowBrush = mSelectedDotShadowBrush
		      g.DrawingColor = mSelectedDotCentreColor
		      Var selectionDotRadius As Double = SELECTION_DOT_DIAMETER / 2
		      g.FillOval(dot.Bounds.Center.X - selectionDotRadius, dot.Bounds.Center.Y - selectionDotRadius, _
		      SELECTION_DOT_DIAMETER, SELECTION_DOT_DIAMETER)
		      g.ShadowBrush = Nil
		    Else
		      g.FillOval(dot.Bounds.Left, dot.Bounds.Top, DotDiameter, DotDiameter)
		    End If
		  Next i
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ScaleFactorChanged()
		  mShouldRecomputeBounds = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddDot(dot As XUIColorPickerColorDot)
		  /// Adds a new color dot to the canvas.
		  
		  mDots.Add(dot)
		  
		  mShouldRecomputeBounds = True
		  
		  Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70757465732074686520626F756E6473206F662065616368206F662074686520636F6C6F757220646F74732E
		Private Sub ComputeBounds(g As Graphics)
		  /// Computes the bounds of each of the colour dots.
		  
		  // Compute total width of the dots including the gaps.
		  Var totalW As Double = (mDots.Count * DotDiameter) + (mDots.LastIndex * GapWidth)
		  
		  // Try to centre the dots.
		  Var x As Double = 0
		  If totalW < g.Width Then
		    x = Max((g.Width / 2) - (totalW / 2), 0)
		  End If
		  
		  Var y As Double = (g.Height / 2) - (DotDiameter / 2)
		  For i As Integer = 0 To mDots.LastIndex
		    Var dot As XUIColorPickerColorDot = mDots(i)
		    dot.Bounds = New Rect(x, y, DotDiameter, DotDiameter)
		    x = dot.Bounds.Right + GapWidth
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor()
		  /// Default constructor.
		  
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  mSelectedDotCentreColor = New ColorGroup(Color.White, Color.Black)
		  
		  mSelectedDotShadowBrush = New ShadowBrush
		  mSelectedDotShadowBrush.BlurAmount = 3
		  mSelectedDotShadowBrush.ShadowColor = Color.White
		  mSelectedDotShadowBrush.Offset = New Point(0, 0)
		  
		  mShouldRecomputeBounds = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616C6C2074686520646F74732066726F6D207468652063616E7661732E
		Sub RemoveAllDots()
		  /// Removes all the dots from the canvas.
		  
		  mDots.RemoveAll
		  
		  mSelectedIndex = -1
		  
		  Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652063757272656E746C792073656C656374656420636F6C6F757220646F742E20546869732073686F756C6420626520636F6E736964657265642072656164206F6E6C792E2052657475726E73204E696C206966206E6F7468696E672073656C65637465642E
		Function SelectedDot() As XUIColorPickerColorDot
		  /// Returns the currently selected colour dot. This should be considered read only. 
		  /// Returns Nil if nothing selected.
		  
		  If mDots.Count > 0 And mSelectedIndex >= 0 And mSelectedIndex <= mDots.LastIndex Then
		    Return mDots(mSelectedIndex)
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 5468652075736572206A7573742070726573736564206120636F6C6F7220646F742E
		Event PressedColorDot(dot As XUIColorPickerColorDot)
	#tag EndHook


	#tag Note, Name = About
		A canvas that contains a row of XUIColorPickerColorDots.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 546865206469616D65746572206F66206561636820636F6C6F757220646F742E
		#tag Getter
			Get
			  Return mDotDiameter
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Clamp above 0.
			  mDotDiameter = Max(value, 0)
			  
			  mShouldRecomputeBounds = True
			  
			  Refresh
			End Set
		#tag EndSetter
		DotDiameter As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520676170206265747765656E2074686520636F6C6F7220646F74732E
		#tag Getter
			Get
			  Return mGapWidth
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Clamp above 0.
			  mGapWidth = Max(value, 0)
			  
			  mShouldRecomputeBounds = True
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		GapWidth As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865207573657220636C69636B6564206F766572206120636F6C6F7220646F7420647572696E6720746865206C61737420604D6F757365446F776E60206576656E742E
		Private mDidMouseDownOverColorDot As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206469616D65746572206F66206561636820636F6C6F757220646F742E
		Private mDotDiameter As Integer = 16
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 417661696C61626C6520636F6C6F7220646F74732E204C656674203D20436F6C6F722C205269676874203D204E616D65
		Private mDots() As XUIColorPickerColorDot
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520676170206265747765656E2074686520636F6C6F7220646F74732E
		Private mGapWidth As Integer = 3
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F757220746F2075736520666F72207468652073656C656374696F6E206D61726B657220696E207468652063656E747265206F662073656C656374656420646F74732E
		Private mSelectedDotCentreColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4120707265636F6D707574656420736861646F7720627275736820666F72207468652073656C656374656420636F6C6F757220646F742E
		Private mSelectedDotShadowBrush As ShadowBrush
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E646578206F66207468652063757272656E746C792073656C656374656420646F742E
		Private mSelectedIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2074686520626F756E6473206F662074686520636F6C6F757220646F74732077696C6C206265207265636F6D707574656420647572696E6720746865206E65787420605061696E7460206576656E742E
		Private mShouldRecomputeBounds As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696E646578206F66207468652063757272656E746C792073656C656374656420636F6C6F757220646F742E
		#tag Getter
			Get
			  Return mSelectedIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mDots.Count = 0 Then mSelectedIndex = -1
			  
			  If value < 0 Then
			    mSelectedIndex = 0
			  ElseIf value > mDots.LastIndex Then
			    mSelectedIndex = mDots.LastIndex
			  Else
			    mSelectedIndex = value
			  End If
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		SelectedIndex As Integer
	#tag EndComputedProperty


	#tag Constant, Name = SELECTION_DOT_DIAMETER, Type = Double, Dynamic = False, Default = \"4", Scope = Private, Description = 546865206469616D65746572206F662074686520646F7420647261776E20696E207468652063656E747265206F66207468652073656C656374656420646F742E
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
			InitialValue="291"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="26"
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
			Name="DotDiameter"
			Visible=true
			Group="Behavior"
			InitialValue="16"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GapWidth"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedIndex"
			Visible=true
			Group="Behavior"
			InitialValue="0"
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
	#tag EndViewBehavior
End Class
#tag EndClass
