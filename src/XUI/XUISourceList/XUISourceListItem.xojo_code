#tag Class
Protected Class XUISourceListItem
	#tag Method, Flags = &h0, Description = 417070656E647320606974656D6020746F2074686520656E64206F662074686973206974656D2773206368696C6472656E2E2042792064656661756C7420746869732077696C6C206E6F7420696D6D6564696174656C792072656275696C642074686520736F75726365206C6973742E
		Sub AddChild(item As XUISourceListItem, shouldRebuild As Boolean = False)
		  /// Appends `item` to the end of this item's children.
		  /// By default this will not immediately rebuild the source list.
		  
		  If item = Nil Then
		    Raise New InvalidArgumentException("Cannot add a Nil item as a child.")
		  End If
		  
		  // Ensure that we are the item's parent.
		  item.SetParent(Self, False)
		  
		  // Our owner is our child's owner too.
		  item.Owner = Self.Owner
		  
		  mChildren.Add(item)
		  
		  If Owner <> Nil And shouldRebuild Then Owner.Rebuild
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320606974656D6020746F207468652073706563696669656420302D626173656420696E646578206F662074686973206974656D2773206368696C6472656E2E2042792064656661756C7420746869732077696C6C206E6F7420696D6D6564696174656C792072656275696C642074686520736F75726365206C6973742E
		Sub AddChildAt(index As Integer, item As XUISourceListItem, shouldRebuild As Boolean = False)
		  /// Adds `item` to the specified 0-based index of this item's children.
		  /// By default this will not immediately rebuild the source list.
		  
		  If item = Nil Then
		    Raise New InvalidArgumentException("Cannot add a Nil item as a child.")
		  End If
		  
		  // Ensure we are the item's parent.
		  item.SetParent(Self, False)
		  
		  // Our owner is our child's owner too.
		  item.Owner = Self.Owner
		  
		  // Try to add it.
		  #Pragma BreakOnExceptions False
		  Try
		    mChildren.AddAt(index, item)
		  Catch e As OutOfBoundsException
		    Raise New InvalidArgumentException("Unable to add child item. Invalid index.")
		  End Try
		  #Pragma BreakOnExceptions Default
		  
		  If Owner <> Nil And shouldRebuild Then Owner.Rebuild
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206368696C642061742074686520302D62617365642060696E646578602E2052657475726E73204E696C2069662074686520696E64657820697320696E76616C69642E
		Function ChildAtIndex(index As Integer) As XUISourceListItem
		  /// Returns the child at the 0-based `index`. Returns Nil if the index is invalid.
		  
		  If mChildren.Count = 0 Then Return Nil
		  
		  If index > mChildren.LastIndex Then Return Nil
		  
		  Return mChildren(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(title As String, icon As Picture = Nil, value As Integer = 0, data As Variant = Nil, canAcceptChildren As Boolean = False)
		  /// Default constructor.
		  ///
		  /// - `title` is the visible title of this item.
		  /// - `icon` is an optional icon.
		  /// - `value` is an optional value for this item. It and the sum of all of this 
		  ///    item's children will be used for the badge value.
		  /// - `data` is optional arbitrary data for use in your application.
		  /// - If `canAcceptChildren` is True then this item is permitted to contain children.
		  
		  Self.Title = title
		  Self.Icon = icon
		  Self.Value = value
		  Self.Data = data
		  Self.CanAcceptChildren = canAcceptChildren
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 476574732074686973206974656D277320706172656E742E204D6179206265204E696C2028666F72206578616D706C6520696620746865206974656D20697320612073656374696F6E292E
		Function GetParent() As XUISourceListItem
		  /// Gets this item's parent. May be Nil (for example if the item is a section).
		  
		  If mParent = Nil Or mParent.Value = Nil Then
		    Return Nil
		  Else
		    Return XUISourceListItem(mParent.Value)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520302D626173656420696E64657820696E2074686973206974656D206F6620606368696C646020696E2069747320746F70206C6576656C206368696C6472656E206F72202D312069662074686973206974656D20646F6573206E6F7420636F6E7461696E20606368696C64602E
		Function IndexOfChild(child As XUISourceListItem) As Integer
		  /// Returns the 0-based index in this item of `child` in its top level children or -1 if this item does not contain `child`.
		  
		  If child = Nil Then Return -1
		  
		  Var limit As Integer = mChildren.LastIndex
		  For i As Integer = 0 To limit
		    If mChildren(i) = child Then Return i
		  Next i
		  
		  Return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320606368696C64602066726F6D2074686973206974656D277320746F702D6C6576656C206368696C6472656E202869662070726573656E74292E2042792064656661756C7420746869732077696C6C207472696767657220612066756C6C2072656275696C64206F662074686520736F75726365206C6973742E
		Sub RemoveChild(child As XUISourceListItem, shouldRebuild As Boolean = True)
		  /// Removes `child` from this item's top-level children (if present).
		  /// By default this will trigger a full rebuild of the source list.
		  
		  If child = Nil Then
		    Raise New InvalidArgumentException("Cannot remove a Nil child.")
		  End If
		  
		  Var index As Integer = mChildren.IndexOf(child)
		  If index <> -1 Then mChildren.RemoveAt(index)
		  
		  If Owner <> Nil And shouldRebuild Then Owner.Rebuild
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686973206974656D277320706172656E74206974656D2E2042792064656661756C742073657474696E672074686520706172656E742077696C6C207472696767657220612066756C6C2072656275696C64206F662074686520736F75726365206C6973742E
		Sub SetParent(parent As XUISourceListItem, shouldRebuild As Boolean = True)
		  /// Sets this item's parent item. By default setting the parent will trigger a full 
		  /// rebuild of the source list.
		  
		  If parent = Nil Then
		    mParent = Nil
		  Else
		    mParent = New WeakRef(parent)
		  End If
		  
		  If Owner <> Nil And shouldRebuild Then Owner.Rebuild
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents an item in a `XUISourceList`.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 5468652073756D206F662074686973206974656D27732056616C756520616E6420616C6C206F6620697473206368696C6472656E27732056616C75652070726F706572746965732E
		#tag Getter
			Get
			  Var total As Integer = Value
			  For Each child As XUISourceListItem In mChildren
			    total = total + child.BadgeValue
			  Next child
			  
			  Return total
			  
			End Get
		#tag EndGetter
		BadgeValue As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686973206974656D2063616E20616363657074206368696C6420726F77732064726F70706564206F6E2069742E
		CanAcceptChildren As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206368696C6472656E2074686973206974656D206861732E
		#tag Getter
			Get
			  Return mChildren.Count
			End Get
		#tag EndGetter
		ChildCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4172626974726172792064617461206173736F63696174656420776974682074686973206974656D2E
		Data As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 486F77206465657020696E2074686520736F75726365206C6973742074686973206974656D2069732E2053656374696F6E7320686176652061206465707468206F66207A65726F2E
		#tag Getter
			Get
			  Var item As XUISourceListItem = GetParent
			  Var myDepth As Integer = 0
			  While item <> Nil
			    item = item.GetParent
			    myDepth = myDepth + 1
			  Wend
			  
			  Return myDepth
			  
			End Get
		#tag EndGetter
		Depth As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652068697420626F756E647320666F7220746865206974656D277320646973636C6F73757265207769646765742E204C6F63616C20746F2074686520736F75726365206C69737420636F6E74726F6C2E204D6179206265204E696C2E
		DisclosureBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973206974656D20697320616C6C6F77656420746F20626520657870616E6465642E2053657474696E67207468697320646F6573206E6F7420696D6D6564696174656C7920726566726573682074686520736F75726365206C6973742E
		Expandable As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973206974656D20697320657870616E6465642E2053657474696E6720746869732077696C6C206E6F74206175746F6D61746963616C6C7920726566726573682074686520736F75726365206C6973742E
		Expanded As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686973206974656D27732069636F6E206973206E6F74204E696C2E
		#tag Getter
			Get
			  Return Icon <> Nil
			End Get
		#tag EndGetter
		HasIcon As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4966205472756520616E642061207769646765742069636F6E20697320736574207468656E2061207769646765742077696C6C20626520647261776E2062657369646520746865206974656D2E
		HasWidget As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973206974656D27732069636F6E2E204D6179206F72206D6179206E6F742062652076697369626C6520646570656E64696E67206F6E207468652072656E646572657220757365642E
		Icon As Picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686973206974656D20697320612073656374696F6E202872656164206F6E6C79292E
		#tag Getter
			Get
			  // Section's don't have parents (they are children of the root).
			  
			  Return GetParent = Nil
			End Get
		#tag EndGetter
		IsSection As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 54686973206974656D2773206368696C6472656E2E204D617920626520656D7074792E
		Private mChildren() As XUISourceListItem
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F20746865206F776E696E6720736F75726365206C6973742E204D6179206265204E696C20696620746865206974656D2077617320637265617465642070726F6772616D6D61746963616C6C792E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5765616B207265666572656E636520746F2074686973206974656D277320706172656E742E2057696C6C206265204E696C2069662074686973206974656D20697320612073656374696F6E2E
		Private mParent As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F776E696E6720736F75726365206C6973742E204D6179206265204E696C20696620746865206974656D2077617320637265617465642070726F6772616D6D61746963616C6C792E
		#tag Getter
			Get
			  If Self.IsSection Then
			    If mOwner = Nil Or mOwner.Value = Nil Then
			      Return Nil
			    Else
			      Return XUISourceList(mOwner.Value)
			    End If
			  Else
			    Return Section.Owner
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
		Owner As XUISourceList
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686973206974656D27732073656374696F6E206F72204E696C20696620746865206974656D20697320612073656374696F6E2E
		#tag Getter
			Get
			  If IsSection Then Return Nil
			  
			  // Find this item's section.
			  Var tmp As XUISourceListItem = Self
			  While tmp.GetParent <> Nil
			    tmp = tmp.GetParent
			  Wend
			  
			  Return tmp
			  
			End Get
		#tag EndGetter
		Section As XUISourceListItem
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4966205472756520616E6420746865206974656D2068617320612063756D756C61746976652076616C7565203E2030207468656E20612062616467652077696C6C2062652073686F776E2E204F6E6C792073686F776E206F6E2073656374696F6E73206966207468652073656374696F6E20697320657870616E6465642E
		ShowBadge As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206974656D2773207469746C652E
		Title As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C20696E74656765722076616C7565206173736F63696174656420776974682074686973206974656D2E204E6F746520746861742060426164676556616C756560206973207468652073756D206F662074686973206974656D2773206056616C75656020706C757320746865206056616C756560206F6620616C6C206368696C6472656E2E
		Value As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652068697420626F756E647320666F7220746865206974656D2773207769646765742E204C6F63616C20746F2074686520736F75726365206C69737420636F6E74726F6C2E204D6179206265204E696C2E
		WidgetBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652069636F6E20746F2075736520666F722074686973206974656D2773207769646765742E20446570656E64696E67206F6E207468652072656E646572657220757365642C2074686973206D61792062652069676E6F7265642E204974206D757374206E6F74206265204E696C206966207468652072656E6465726572206578706563747320612050696374757265207768656E2048617357696467657420697320547275652E
		WidgetIcon As Picture
	#tag EndProperty


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
			Name="Title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsSection"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Depth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ChildCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasIcon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BadgeValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanAcceptChildren"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasWidget"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowBadge"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WidgetIcon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Expanded"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Expandable"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
