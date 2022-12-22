#tag Class
Protected Class XUIInspectorItemPopupMenu
	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E657720706F707570206D656E7520636F6E7461696E696E6720606974656D73602077697468206073656C6563746564496E646578602073656C65637465642E2060616E63686F725860207370656369666965732077686572652074686520706F7075702073686F756C6420626520616E63686F72656420686F72697A6F6E74616C6C7920616E642060616E63686F7253696465602073706563696669657320776865746865722074686520616E63686F72206170706C69657320746F20746865206C656674206F722072696768742073696465206F662074686520706F707570206D656E752E2054686520696E73706563746F7220756C74696D6174656C7920646563696465732077686572652074686520706F70757020697320706C616365642062757420796F752063616E20696E64696361746520612070726566657272656420746F7020616E6420626F74746F6D2060596020636F6F7264696E6174652E
		Sub Constructor(owner As XUIInspectorItem, items() As String, selectedIndex As Integer, anchorX As Double, anchorSide As XUIInspectorItemPopupMenu.Anchors, preferredTopY As Double, preferredBottomY As Double)
		  /// Constructs a new popup menu containing `items` with `selectedIndex` selected.
		  /// `anchorX` specifies where the popup should be anchored horizontally and `anchorSide` specifies
		  /// whether the anchor applies to the left or right side of the popup menu.
		  /// The inspector ultimately decides where the popup is placed but you can indicate a preferred top 
		  /// and bottom `Y` coordinate.
		  
		  Self.Owner = owner
		  Self.Items = items.Clone
		  Self.SelectedIndex = SelectedIndex
		  Self.AnchorX = anchorX
		  Self.Anchor = anchorSide
		  Self.PreferredTopY = preferredTopY
		  Self.PreferredBottomY = preferredBottomY
		  Self.Bounds = New Rect(0, 0, 0, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320697320706F707570206D656E7520746F206067602E2050726573657276657320746865207374617465206F66206067602E
		Sub Render(g As Graphics, style As XUIInspectorStyle, yScrollOffset As Double)
		  /// Renders is popup menu to `g`.
		  /// Preserves the state of `g`.
		  ///
		  /// yScrollOffset will offset the drawing in the vertical direction.
		  
		  If Bounds = Nil Then Return
		  
		  g.SaveState
		  
		  // Background.
		  g.DrawingColor = style.ControlBackgroundColor
		  g.FillRectangle(Bounds.Left, Bounds.Top - yScrollOffset, Bounds.Width, Bounds.Height)
		  
		  // Border.
		  g.DrawingColor = style.ControlBorderColor
		  g.DrawRectangle(Bounds.Left, Bounds.Top - yScrollOffset, Bounds.Width, Bounds.Height)
		  
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  
		  // Compute the height of an item.
		  Var itemH As Double = If(g.TextHeight > INDICATOR_SIZE, g.TextHeight, INDICATOR_SIZE)
		  
		  // Items.
		  Var itemTextX As Double = Bounds.Left + HPADDING + INDICATOR_SIZE + INDICATOR_ITEM_PADDING
		  Var y As Double = Bounds.Top - yScrollOffset + ITEM_VPADDING
		  Var baseline As Double = g.FontAscent + (itemH - g.TextHeight) / 2
		  For i As Integer = 0 To Items.LastIndex
		    Var item As String = Items(i)
		    Var isSelected As Boolean = i = SelectedIndex
		    
		    // Indicator.
		    RenderIndicator(g, Bounds.Left + HPADDING, y, isSelected, style)
		    
		    // Item text.
		    g.DrawingColor = style.TextColor
		    g.DrawText(item, itemTextX, baseline + y)
		    
		    y = y + ITEM_VPADDING + itemH
		  Next i
		  
		  g.RestoreState
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E646572732074686520696E64696361746F722069636F6E20746F206067602E
		Private Sub RenderIndicator(g As Graphics, x As Double, y As Double, selected As Boolean, style As XUIInspectorStyle)
		  /// Renders the indicator icon to `g`.
		  /// Preserves the state of `g`
		  
		  g.SaveState
		  
		  If Not selected Then
		    // Background.
		    g.DrawingColor = style.ControlBackgroundColor
		    g.FillOval(x, y, INDICATOR_SIZE, INDICATOR_SIZE)
		    // Border.
		    g.DrawingColor = style.ControlBorderColor
		    g.DrawOval(x, y, INDICATOR_SIZE, INDICATOR_SIZE)
		  Else
		    // Outer ring.
		    g.DrawingColor = style.FocusColor
		    g.FillOval(x, y, INDICATOR_SIZE, INDICATOR_SIZE)
		    // Inner ring.
		    Var innerFactor As Double = 0.5 // How much smaller the inner circle is than the outer circle.
		    Var innerSize As Double = INDICATOR_SIZE * innerFactor
		    g.DrawingColor = style.TextColor
		    g.FillOval(x + innerSize * 0.5, y + innerSize * 0.5, innerSize, innerSize)
		    // Border.
		    g.DrawingColor = style.ControlBorderColor
		    g.DrawOval(x, y, INDICATOR_SIZE, INDICATOR_SIZE)
		  End If
		  
		  g.RestoreState
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652068656967687420726571756972656420746F2064726177207468697320706F707570206D656E752E20457870656E73697665206F7065726174696F6E2E
		Function RequiredHeight(g As Graphics, style As XUIInspectorStyle) As Double
		  /// Returns the height required to draw this popup menu.
		  /// Expensive operation.
		  
		  g.SaveState
		  
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  
		  Var itemH As Double = If(g.TextHeight > INDICATOR_SIZE, g.TextHeight, INDICATOR_SIZE)
		  
		  Var h As Double = itemH * Items.Count // Total height of all items.
		  
		  g.RestoreState
		  
		  h = h + (ITEM_VPADDING * (Items.Count + 1)) // Factor in padding between items.
		  
		  Return h
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520776964746820726571756972656420746F2064726177207468697320706F707570206D656E752E20457870656E73697665206F7065726174696F6E2E
		Function RequiredWidth(g As Graphics, style As XUIInspectorStyle) As Double
		  /// Returns the width required to draw this popup menu.
		  /// Expensive operation.
		  
		  g.SaveState
		  
		  g.FontName = style.FontName
		  g.FontSize = style.FontSize
		  
		  Var w As Double = g.TextWidth(Items.Longest) + (HPADDING * 2)
		  
		  g.RestoreState
		  
		  // Add in the width required for the indicator.
		  w = w + INDICATOR_SIZE + INDICATOR_ITEM_PADDING
		  
		  Return w
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Represents a popup menu in the inspector.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 57686963682073696465206F662074686520706F707570206D656E7520697320616E63686F7265642E
		Anchor As XUIInspectorItemPopupMenu.Anchors = XUIInspectorItemPopupMenu.Anchors.Left
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652064657369726564207820636F6F7264696E617465206F662074686520616E63686F7265642065646765206F662074686520706F707570206D656E752E2054686520696E73706563746F722077696C6C2064657465726D696E652069747320766572746963616C20706F736974696F6E2E
		AnchorX As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520626F756E6473206F66207468697320706F707570206D656E752E
		Bounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520626F756E6473206F662065616368206974656D20696E2074686520706F707570206D656E752E
		ItemBounds() As Rect
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206974656D7320696E2074686520706F707570206D656E752E
		Items() As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F207468697320706F707570206D656E752773206F776E696E67206974656D2E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207765616B207265666572656E636520746F207468697320706F707570206D656E752773206F776E696E67206974656D2E
		#tag Getter
			Get
			  If mOwner = Nil Or mOwner.Value = Nil Then
			    Return Nil
			  Else
			    Return XUIInspectorItem(mOwner.Value)
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
		Owner As XUIInspectorItem
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 496620746865726520697320696E73756666696369656E7420737061636520746F207573652060707265666572726564546F705960207468656E2074686520696E73706563746F722077696C6C2074727920746F20647261772074686520706F707570206D656E7520776974682069747320626F74746F6D20656467652061742060707265666572726564426F74746F6D59602E
		PreferredBottomY As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520707265666572726564207920636F6F7264696E617465206F662074686520746F70206F662074686520706F707570206D656E752E20496620746865726520697320656E6F756768742073706163652C2074686520696E73706563746F722077696C6C20647261772074686520746F70206F662074686520706F707570206D656E7520686572652E
		PreferredTopY As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520302D626173656420696E646578206F66207468652063757272656E746C792073656C6563746564206974656D2E
		SelectedIndex As Integer = -1
	#tag EndProperty


	#tag Constant, Name = HPADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Public, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746865206974656D73206C61746572616C6C792E
	#tag EndConstant

	#tag Constant, Name = INDICATOR_ITEM_PADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C73206265747765656E207468652072696768742065646765206F662074686520696E64696361746F7220616E6420746865206C6566742065646765206F6620616E206974656D2E
	#tag EndConstant

	#tag Constant, Name = INDICATOR_SIZE, Type = Double, Dynamic = False, Default = \"16", Scope = Public, Description = 5468652073697A65206F662074686520696E64696361746F722E
	#tag EndConstant

	#tag Constant, Name = ITEM_VPADDING, Type = Double, Dynamic = False, Default = \"5", Scope = Public, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F772065616368206974656D20696E2074686520706F707570206D656E752E
	#tag EndConstant


	#tag Enum, Name = Anchors, Type = Integer, Flags = &h0, Description = 57686963682073696465206F662074686520706F707570206D656E7520697320616E63686F7265642E
		Left
		Right
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
			Name="SelectedIndex"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AnchorX"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PreferredTopY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PreferredBottomY"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Anchor"
			Visible=false
			Group="Behavior"
			InitialValue="XUIInspectorItemPopupMenu.Anchors.Left"
			Type="XUIInspectorItemPopupMenu.Anchors"
			EditorType="Enum"
			#tag EnumValues
				"0 - Left"
				"1 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
