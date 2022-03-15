#tag DesktopWindow
Begin DesktopContainer XUISourceList
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   500
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   280
   Begin DesktopListBox SourceList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DefaultRowHeight=   -1
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   500
      Index           =   -2147483648
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   280
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Timer DragTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   250
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  SourceList.AllowFocusRing = False
		  SourceList.HasHeader = False
		  
		  RaiseEvent Opening
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 417070656E64732074686520706173736564206974656D20617320612073656374696F6E20696E2074686520736F75726365206C6973742E2052656275696C64732074686520736F75726365206C6973742E
		Sub AddSection(section As XUISourceListItem)
		  /// Appends the passed item as a section in the source list.
		  /// Rebuilds the source list.
		  
		  // Sanity checks.
		  If section = Nil Then 
		    Raise New InvalidArgumentException("Cannot add a Nil section to the source list.")
		  End If
		  
		  If section.Title = "" Then
		    Raise New InvalidArgumentException("Cannot add a section with no title.")
		  End If
		  
		  If mSections.IndexOf(section) <> -1 Then
		    Raise New InvalidArgumentException("Cannot add the same section twice.")
		  End If
		  
		  // Sections don't have a parent.
		  section.SetParent(Nil, False)
		  
		  // Mark this source list as the owner.
		  section.Owner = Self
		  
		  // Sections can always accept children.
		  section.CanAcceptChildren = True
		  
		  // Add the section.
		  mSections.Add(section)
		  
		  Rebuild
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C206D6574686F6420666F7220706879736963616C6C7920616464696E6720616E206974656D20746F2074686520736F75726365206C6973742E
		Private Sub AddToSourceList(item As XUISourceListItem)
		  /// Internal method for physically adding an item to the source list.
		  
		  // Silently fail if `item` is Nil.
		  If item = Nil Then Return
		  
		  SourceList.AddRow("")
		  
		  If item.Expanded Then ExpandRow(SourceList.LastAddedRowIndex)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C206D6574686F64732E2041637475616C6C7920657870616E64732060726F776020696E20746865206C697374626F782E2043616C6C6564206279206052656275696C6428296020616E642060416464546F536F757263654C6973742829602E
		Private Sub ExpandRow(row As Integer)
		  /// Internal methods. Actually expands `row` in the listbox. Called by `Rebuild()` and `AddToSourceList()`.
		  
		  // Get the item at the requested row.
		  Var item As XUISourceListItem = ItemAtRowIndex(row)
		  
		  // Silently fail if there is no item at the requested row.
		  If item = Nil Then Return
		  
		  // Mark this row as expanded but don't rebuild.
		  item.SetExpanded(False)
		  
		  // Display this item's children.
		  Var childrenLastIndex As Integer = item.ChildCount - 1
		  For i As Integer = 0 To childrenLastIndex
		    AddToSourceList(item.ChildAtIndex(i))
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54686520757365722068617320636C69636B656420606974656D6020696E2074686520736F75726365206C697374207768696C737420686F6C64696E6720646F776E20746865207368696674206B65792E
		Private Sub HandleContiguousRowClick(item As XUISourceListItem, x As Integer, y As Integer)
		  /// The user has clicked `item` in the source list whilst holding down the shift key.
		  
		  // =================================
		  // NOTHING CURRENTLY SELECTED
		  // =================================
		  If mSelectedItems.Count = 0 Then
		    mSelectedItems.Add(item)
		    RaiseEvent ItemSelected(item, x, y)
		    Refresh
		    Return
		  End If
		  
		  // We don't allow the selection of items in different sections so we can
		  // assume that all items currently in `mSelectedItems` are within the same section.
		  Var section As XUISourceListItem = mSelectedItems(0).Section
		  
		  Var lowestRow, highestRow As Integer = RowForItem(mSelectedItems(0))
		  For Each selectedItem As XUISourceListItem In mSelectedItems
		    Var row As Integer = RowForItem(selectedItem)
		    lowestRow = Min(lowestRow, row)
		    highestRow = Max(highestRow, row)
		  Next selectedItem
		  
		  Var itemRow As Integer = RowForItem(item)
		  lowestRow = Min(lowestRow, itemRow)
		  highestRow = Max(highestRow, itemRow)
		  
		  If lowestRow = -1 Or highestRow = -1 Then
		    // This shouldn't happen...
		    Raise New UnsupportedOperationException("Internal error. Unable to determine item's row.")
		  End If
		  
		  If lowestRow = highestRow Then
		    // Edge case: The user has shift-clicked the only item that is selected.
		    Return
		  End If
		  
		  For i As Integer = lowestRow To highestRow
		    // Add the item at this row to the selected items array, if not already present.
		    Var itemToAdd As XUISourceListItem = ItemAtRowIndex(i)
		    If itemToAdd = Nil Then
		      // This shouldn't happen...
		      Raise New UnsupportedOperationException("Internal error. Unable to add item.")
		    End If
		    
		    // Don't select sections.
		    If itemToAdd.IsSection Then Continue
		    
		    // All selected items must be in the same section.
		    If itemToAdd.Section <> section Then Continue
		    
		    If mSelectedItems.IndexOf(itemToAdd) = -1 Then mSelectedItems.Add(itemToAdd)
		    RaiseEvent ItemSelected(itemToAdd, -1, -1)
		  Next i
		  
		  Refresh
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54686520757365722068617320636C69636B656420606974656D6020696E2074686520736F75726365206C697374207768696C737420686F6C64696E6720646F776E20436D6420286D61634F5329206F72204354524C202857696E646F7773202F204C696E7578292E
		Private Sub HandleDiscontiguousRowClick(item As XUISourceListItem, x As Integer, y As Integer)
		  /// The user has clicked `item` in the source list whilst holding down Cmd (macOS) or CTRL (Windows / Linux).
		  
		  // Add this item to the selected items array if not present. Remove if it is present.
		  Var index As Integer = mSelectedItems.IndexOf(item)
		  If index = -1 Then
		    // Add this item.
		    mSelectedItems.Add(item)
		    RaiseEvent ItemSelected(item, x, y)
		  Else
		    // Remove this item.
		    mSelectedItems.RemoveAt(index)
		    RaiseEvent ItemUnselected(item, x, y)
		  End If
		  
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 546865207573657220686173206A7573742072656C656173656420746865206D6F757365206166746572206472616767696E672E2060786020616E642060796020617265206C6F63616C20746F2074686520736F75726365206C6973742E
		Private Sub HandleDragRow(x As Integer, y As Integer)
		  /// The user has just released the mouse after dragging. `x` and `y` are local to the source list.
		  
		  #Pragma Warning "TODO: Handle row dragging"
		  
		  // Mark that we're no longer dragging.
		  mIsDraggingRow = False
		  
		  // Get the row the mouse was released over.
		  Var row As Integer = SourceList.RowFromXY(x, y)
		  
		  // If we've released the mouse NOT over a row then there's nothing else to do.
		  If row = -1 Or row > SourceList.RowCount - 1 Then Return
		  
		  // Get the item the mouse released over.
		  Var drop As XUISourceListItem = ItemAtRowIndex(row)
		  
		  // If the item released over cannot accept children then we add the selected items as siblings.
		  If Not drop.CanAcceptChildren Then
		    Var dropParent As XUISourceListItem = drop.GetParent
		    For Each child As XUISourceListItem In mSelectedItems
		      // Prevent circular reference.
		      If child = drop Then Continue
		      // Remove this child from its current parent.
		      Var childParent As XUISourceListItem = child.GetParent
		      If childParent <> Nil Then childParent.RemoveChild(child)
		      dropParent.AddChild(child, False)
		    Next child
		    Refresh
		    Return
		  End If
		  
		  // The item released over can accept children. We need to know if we've dropped our selection over the 
		  // middle of the row or the lower edge. If it's the lower edge we add them as siblings but if it's over the
		  // middle we add them as children.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662074686520757365722069732063757272656E746C79206472616767696E67206F76657220746865206974656D2061742060726F77602E
		Private Function IsDraggingOverRow(row As Integer) As Boolean
		  /// Returns True if the user is currently dragging over the item at `row`.
		  
		  If Not mIsDraggingRow Then Return False
		  If mLastMouseDragRow = -1 Then Return False
		  If row < 0 Or row > SourceList.RowCount Then Return False
		  
		  // Compute the local Y coordinate of the mouse in the row being dragged over.
		  Var localY As Integer = mLastMouseDragY Mod SourceList.RowHeight
		  
		  // Determine if the mouse is over the middle of the row being dragged over.
		  If (localY >= SourceList.RowHeight * (DROP_OVER_THRESHOLD/2) And _
		    localY <= SourceList.RowHeight * (1-(DROP_OVER_THRESHOLD/2))) And _
		    row = mLastMouseDragRow Then
		    Return True
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206974656D2061742074686520302D626173656420726F772060696E646578602E204F6E6C792076697369626C6520726F77732061726520636F756E7465642E20526F7720603060206973207468652066697273742076697369626C6520726F772E204D61792072657475726E204E696C2E
		Private Function ItemAtRowIndex(index As Integer) As XUISourceListItem
		  /// Returns the item at the 0-based row `index`. Only visible rows are counted. 
		  /// Row `0` is the first visible row. May return Nil.
		  
		  If index < 0 Then Return Nil
		  If index > SourceList.LastRowIndex Then Return Nil
		  
		  Var current As Integer = -1
		  Var result As XUISourceListItem
		  For Each section As XUISourceListItem In mSections
		    current = current + 1
		    
		    If current = index Then Return section
		    
		    If section.Expanded Then
		      
		      If section.ChildCount > 0 Then
		        Var childLimit As Integer = section.ChildCount - 1
		        For i As Integer = 0 To childLimit
		          ItemAtRowIndex_(section.ChildAtIndex(i), current, index, result)
		          If current = index Then Return result
		        Next i
		      End If
		      
		    End If
		    
		  Next section
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C20726563757273697665206D6574686F642E
		Private Sub ItemAtRowIndex_(parent As XUISourceListItem, ByRef current As Integer, target As Integer, ByRef result As XUISourceListItem)
		  /// Internal recursive method.
		  
		  If parent = Nil Then
		    result = Nil
		    Return
		  End If
		  
		  // Don't forget to include the parent in the count.
		  current = current + 1
		  
		  // Is the parent the item we're looking for at the specified row?
		  If current = target Then
		    result = parent
		    Return
		  End If
		  
		  // If the parent isn't expanded or is empty then we're done.
		  If Not parent.Expanded Or parent.ChildCount = 0 Then
		    result = Nil
		    Return
		  End If
		  
		  // Check the parent's children.
		  Var childLimit As Integer = parent.ChildCount - 1
		  For i As Integer = 0 To childLimit
		    ItemAtRowIndex_(parent.ChildAtIndex(i), current, target, result)
		    If current = target Then Return
		  Next i
		  
		  result = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F76657320606974656D6020746F2062652061206368696C64206F6620606E6577506172656E74602E2042792064656661756C7420617070656E64732069742061732061206368696C6420627574206F7074696F6E616C6C7920796F752063616E2073746970756C6174652074686520696E64657820696E20606E6577506172656E746020746F206D6F766520697420746F2E20446F6573206E6F742072656275696C642074686520747265652E
		Private Sub MoveItem(item As XUISourceListItem, newParent As XUISourceListItem, index As Integer = -1)
		  /// Moves `item` to be a child of `newParent`. By default appends it as a child but optionally you can stipulate the
		  /// index in `newParent` to move it to. Does not rebuild the tree.
		  
		  If item = Nil Then Return
		  If newParent = Nil Then Return
		  If Not newParent.CanAcceptChildren Then Return
		  If item = newParent Then Return
		  If index < -1 Or index > newParent.ChildCount Then Return
		  
		  // Remove item from its current parent.
		  Var oldParent As XUISourceListItem = item.GetParent
		  If oldParent <> Nil Then oldParent.RemoveChild(item, False)
		  
		  // Do the move.
		  If index = -1 Then
		    newParent.AddChild(item, False)
		  Else
		    newParent.AddChildAt(index, item, False)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656275696C64732074686520736F75726365206C6973742E
		Sub Rebuild()
		  /// Rebuilds the source list.
		  
		  SourceList.RemoveAllRows
		  
		  For Each section As XUISourceListItem In mSections
		    
		    SourceList.AddRow("")
		    
		    If section.Expanded Then ExpandRow(SourceList.LastAddedRowIndex)
		    
		  Next section
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520302D626173656420726F77207468617420606974656D602061707065617273206F6E2E204F6E6C792076697369626C65206974656D732061726520696E636C756465642E20526F7720603060206973207468652066697273742076697369626C6520726F772E2052657475726E7320602D3160206966206E6F7420666F756E642E
		Private Function RowForItem(item As XUISourceListItem) As Integer
		  /// Returns the 0-based row that `item` appears on. Only visible items are included.
		  /// Row `0` is the first visible row. Returns `-1` if not found.
		  
		  Var limit As Integer = SourceList.RowCount - 1
		  For i As Integer = 0 To limit
		    If ItemAtRowIndex(i) = item Then Return i
		  Next i
		  
		  Return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652073656374696F6E20617420302D62617365642060696E646578602E2052616973657320616E2060496E76616C6964417267756D656E74457863657074696F6E6020696620696E64657820697320696E76616C69642E2054686520696E646578206973207468652073656369746F6E20696E6465782C206E6F742074686520726F7720696E6465782E
		Function SectionAtIndex(index As Integer) As XUISourceListItem
		  /// Returns the section at 0-based `index`. Raises an `InvalidArgumentException` if index is invalid.
		  /// The index is the seciton index, not the row index.
		  
		  If index < 0 Or index > mSections.LastIndex Then
		    Raise New InvalidArgumentException("Cannot retrieve section. Invalid index.")
		  End If
		  
		  Return mSections(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206669727374206D61746368696E672073656374696F6E2077686F7365207469746C65206973206073656374696F6E5469746C65602E2052657475726E73204E696C206966206E6F7420666F756E642E
		Function SectionWithName(sectionTitle As String, caseSensitive As Boolean = False) As XUISourceListItem
		  /// Returns the first matching section whose title is `sectionTitle`. Returns Nil if not found.
		  
		  Var limit As Integer = mSections.LastIndex
		  For i As Integer = 0 To limit
		    If caseSensitive Then
		      If mSections(i).Title.Compare(sectionTitle, ComparisonOptions.CaseSensitive) = 0 Then
		        Return mSections(i)
		      End If
		    Else
		      If mSections(i).Title = sectionTitle Then Return mSections(i)
		    End If
		  Next i
		  
		  Return Nil
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 54686520757365722068617320636C69636B6564206F6E20616E206974656D2773207769646765742E
		Event ClickedItemWidget(item As XUISourceListItem)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520757365722068617320636F6C6C617073656420616E206974656D20627920636C69636B696E67206F6E2074686520646973636C6F73757265207769646765742E
		Event CollapsedItem(item As XUISourceListItem)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520757365722068617320657870616E64656420616E206974656D20627920636C69636B696E67206F6E2074686520646973636C6F73757265207769646765742E
		Event ExpandedItem(item As XUISourceListItem)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 416E206974656D20696E2074686520736F75726365206C697374207761732073656C65637465642E20496620636C69636B65642C205820616E6420592061726520746865206D6F75736520636F6F7264696E61746573206F662074686520636C69636B206C6F63616C20746F2074686520726F7720746865206974656D206973206F6E2E2054686573652077696C6C20626520602D3160206966207468652073656C656374696F6E207761732070726F6772616D617469632E
		Event ItemSelected(item As XUISourceListItem, x As Integer, y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 416E206974656D20696E2074686520736F75726365206C6973742077617320756E73656C65637465642E20496620636C69636B65642C205820616E6420592061726520746865206D6F75736520636F6F7264696E61746573206F662074686520636C69636B206C6F63616C20746F2074686520726F7720746865206974656D206973206F6E2E2054686573652077696C6C20626520602D3160206966207468652073656C656374696F6E207761732070726F6772616D617469632E
		Event ItemUnselected(item As XUISourceListItem, x As Integer, y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865206D6F75736520686173206D6F7665642077697468696E2074686520736F75726365206C6973742E205820616E64205920617265206C6F63616C20746F2074686520736F75726365206C69737420636F6E74726F6C2E
		Event MouseDidMove(x As Integer, y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return SourceList.RowSelectionType = DesktopListBox.RowSelectionTypes.Multiple
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    SourceList.RowSelectionType = DesktopListBox.RowSelectionTypes.Multiple
			  Else
			    SourceList.RowSelectionType = DesktopListBox.RowSelectionTypes.Single
			  End If
			  
			  mSelectedItems.RemoveAll
			  
			End Set
		#tag EndSetter
		AllowMultipleSelection As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 49662046616C7365207468656E206F6E6C792073656374696F6E732064726177207468656972206368696C6472656E2E204974656D7320646F206E6F742E205468697320616C6C6F777320666F7220737562746C652076697375616C20646966666572656E636573206C696B65207365656E206265747765656E20746865206D61634F532046696E64657220616E64204D61696C20617070732E
		Hierarchical As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686520757365206973206163746976656C79206472616767696E67206120726F772E
		mIsDraggingRow As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520726F7720756E64657220746865206D6F75736520647572696E6720746865206C617374204D6F757365446F776E206576656E742E204D6179206265202D312E
		mLastMouseDownRow As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205820636F6F7264696E61746520696E20746865206C617374204D6F757365446F776E206576656E742E
		Private mLastMouseDownX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205920636F6F7264696E61746520696E20746865206C617374204D6F757365446F776E206576656E742E
		Private mLastMouseDownY As Integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652076616C7565206F6620606D4C6173744D6F757365446F776E526F776020647572696E6720746865206C61737420604D6F7573654472616760206576656E742E
		mLastMouseDragRow As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F63616C20582076616C75652064657465726D696E656420696E20604472616754696D65722E416374696F6E602E
		mLastMouseDragX As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F63616C20582076616C75652064657465726D696E656420696E20604472616754696D65722E416374696F6E602E
		mLastMouseDragY As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520726F7720756E64657220746865206D6F75736520637572736F722E205570646174656420696E2074686520604D6F7573654D6F766560206576656E742E2057696C6C20626520602D3160206966207468657265206973206E6F2076616C696420726F7720756E64657220746865206D6F7573652E
		Private mMouseMoveRow As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652072656E646572657220746F2075736520746F20647261772074686520726F777320696E2074686520736F75726365206C6973742E
		Private mRenderer As XUISourceListRenderer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320736F75726365206C69737427732073656374696F6E732E
		Private mSections() As XUISourceListItem
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E746C792073656C6563746564206974656D732E204D617920626520656D7074792E
		Private mSelectedItems() As XUISourceListItem
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572207374796C6520746F2075736520666F722074686520736F75726365206C6973742E
		Private mStyle As XUISourceListStyle
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652072656E646572657220746F2075736520746F20647261772074686520726F777320696E2074686520736F75726365206C6973742E
		#tag Getter
			Get
			  Return mRenderer
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRenderer = value
			  
			  If value = Nil Then Return
			  
			  SourceList.DefaultRowHeight = mRenderer.RowHeight
			  
			End Set
		#tag EndSetter
		Renderer As XUISourceListRenderer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6C6F7572207374796C6520746F2075736520666F722074686520736F75726365206C6973742E
		#tag Getter
			Get
			  If mStyle = Nil Then mStyle = New XUISourceListStyle
			  
			  Return mStyle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mStyle = value
			  Refresh
			End Set
		#tag EndSetter
		Style As XUISourceListStyle
	#tag EndComputedProperty


	#tag Constant, Name = DROP_OVER_THRESHOLD, Type = Double, Dynamic = False, Default = \"0.5", Scope = Private, Description = 546869732070657263656E74616765206F662074686520726F772064726F70706564206F6E207468617420697320636F6E73696465726564207468652061637475616C20726F772E2041626F766520616E642062656C6F7720746869732061726520636F6E736964657265642074686520726F772061626F766520616E642074686520726F772062656C6F772E20302E35203D203530252E
	#tag EndConstant


#tag EndWindowCode

#tag Events SourceList
	#tag Event
		Function PaintCellBackground(g As Graphics, row As Integer, column As Integer) As Boolean
		  #Pragma Unused column
		  
		  WinSourceList.Info.Text = "mIsDraggingRow:" + If(mIsDraggingRow, "true", "false") + EndOfLine + _
		  "mLastMouseDownRow:" + mLastMouseDownRow.ToString + EndOfLine + _
		  "mLastMouseDragRow:" + mLastMouseDragRow.ToString + EndOfLine + _
		  "mLastMouseDragX:" + mLastMouseDragX.ToString + " , mLastMouseDragY:" + mLastMouseDragY.ToString + EndOfLine
		  If IsDraggingOverRow(row) Then
		    WinSourceList.Info.Text = WinSourceList.Info.Text + "dragging over row:" + row.ToString
		  End If
		  
		  If Renderer = Nil Then Return True
		  
		  // Render the background.
		  Renderer.RenderBackground(g, row)
		  
		  // If the row does not exist then we're done.
		  If row < 0 Or row > Me.LastRowIndex Or (row = 0 And Me.RowCount = 0) Then
		    Return True
		  End If
		  
		  Var item As XUISourceListItem = ItemAtRowIndex(row)
		  If item = Nil Then
		    // Shouldn't happen...
		    #Pragma Warning "TODO: Remove this break when tested"
		    Break
		  Else
		    Renderer.RenderItem(item, g, mMouseMoveRow = row, mSelectedItems.IndexOf(item) <> -1, IsDraggingOverRow(row))
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseMove(x As Integer, y As Integer)
		  // Compute and store the row under the mouse.
		  
		  mMouseMoveRow = Me.RowFromXY(x, y)
		  
		  SourceList.Refresh
		  
		  RaiseEvent MouseDidMove(x, y)
		End Sub
	#tag EndEvent
	#tag Event
		Function CellPressed(row As Integer, column As Integer, x As Integer, y As Integer) As Boolean
		  #Pragma Unused column
		  
		  // Get the item clicked.
		  Var item As XUISourceListItem = ItemAtRowIndex(row)
		  If item = Nil Then
		    mSelectedItems.RemoveAll
		    Return True
		  End If
		  
		  // Multiple selection?
		  If AllowMultipleSelection And Not item.IsSection Then
		    If Keyboard.AsyncShiftKey Then
		      HandleContiguousRowClick(item, x, y)
		      Return True
		    Else
		      #If TargetMacOS
		        If Keyboard.AsyncCommandKey Then
		          HandleDiscontiguousRowClick(item, x, y)
		          Return True
		        End If
		      #Else
		        If Keyboard.AsyncControlKey Then
		          HandleDiscontiguousRowClick(item, x, y)
		          Return True
		        End If
		      #EndIf
		    End If
		  End If
		  
		  // Did we click the disclosure widget?
		  If item.Expandable And item.DisclosureBounds <> Nil And item.DisclosureBounds.Contains(x, y) Then
		    If item.Expanded Then
		      item.SetCollapsed(True)
		      RaiseEvent CollapsedItem(item)
		      Return True
		    Else
		      item.SetExpanded(True)
		      RaiseEvent ExpandedItem(item)
		      Return True
		    End If
		  End If
		  
		  // Did we click the widget?
		  If item.HasWidget And item.WidgetBounds <> Nil And item.WidgetBounds.Contains(x, y) Then
		    RaiseEvent ClickedItemWidget(item)
		    Return True
		  End If
		  
		  // Forbid section selection.
		  If item.IsSection Then Return True
		  
		  // If there multiple items selected and we click on one of them, do nothing.
		  // This will permit us to drag multiple items.
		  If AllowMultipleSelection And mSelectedItems.Count > 1 And mSelectedItems.IndexOf(item) <> -1 Then
		    Return False
		  End If
		  
		  // Clicked an item. Ensure this is the only one selected.
		  mSelectedItems.RemoveAll
		  mSelectedItems.Add(item)
		  RaiseEvent ItemSelected(item, x, y)
		  Refresh
		  
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  // Stop the drag timer.
		  mLastMouseDragX = -1
		  mLastMouseDragy = -1
		  DragTimer.Enabled = False
		  
		  mMouseMoveRow = -1
		  Me.Refresh
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.AllowExpandableRows = False
		  Me.AllowFocusRing = False
		  Me.AllowRowDragging = True
		  Me.AllowRowReordering = True
		  
		  DragTimer.Enabled = False
		End Sub
	#tag EndEvent
	#tag Event
		Function DragReorderRows(newPosition as Integer, parentRow as Integer) As Boolean
		  /// A row dragging operation has just completed.
		  
		  #Pragma Unused parentRow
		  
		  #Pragma Warning "TODO: Do we need to account for x coordinate (i.e. indent level)"
		  
		  // Stop the drag timer.
		  mLastMouseDragX = -1
		  mLastMouseDragy = -1
		  DragTimer.Enabled = False
		  
		  // We must have let go of the mouse button at this point so we can't be dragging a row any longer.
		  mIsDraggingRow = False
		  
		  // If there are no selected items then there's nothing to do.
		  If mSelectedItems.Count = 0 Then Return False
		  
		  // Compute the x, y position of the drop, local to the source list.
		  Var x As Integer = System.MouseX - Me.Left - Self.Left - Me.Window.Left
		  Var y As Integer = System.MouseY - Me.Top - Self.Top - Me.Window.Top
		  
		  // Do the computation ourselves of where the drop is.
		  Var dropRow As Integer = Me.RowFromXY(x, y)
		  
		  // Compute the local Y coordinate of the drop (i.e. where in the row did we drop?).
		  Var localY As Integer = y Mod Me.RowHeight
		  
		  // Did we drop the selection onto a row (i.e not above or below)?
		  Var droppedOnRow As Boolean = _
		  (localY >= Me.RowHeight * (DROP_OVER_THRESHOLD/2) And localY <= Me.RowHeight * (1-(DROP_OVER_THRESHOLD/2)))
		  
		  // Adjust `newPosition` based on whether we've directly dropped on a row or if we're down whilst dragging.
		  // Why do we need to adjust if moving down? I don't know. I think it's a long standing Xojo bug ¯\_(ツ)_/¯
		  Var movingDown As Boolean = y > mLastMouseDownY
		  If droppedOnRow Then
		    newPosition = dropRow
		  ElseIf movingDown Then
		    newPosition = newPosition + 1
		  End If
		  
		  // ==============================================
		  // DROPPED OVER A ROW THAT CAN ACCEPT CHILDREN
		  // ==============================================
		  Var dropItem As XUISourceListItem = ItemAtRowIndex(dropRow)
		  If dropItem = Nil Then Return False
		  
		  // Append the selection as children of it.
		  If dropItem = Nil Then Return False
		  If droppedOnRow And dropItem.CanAcceptChildren Then
		    // Make sure that the section where we're dropping the selected items is the same as the selected item's 
		    // section since we don't allow dragging items from one section to another.
		    If dropItem.IsSection And mSelectedItems(0).Section <> dropItem Then Return False
		    If dropItem.Section <> mSelectedItems(0).Section Then Return False
		    
		    // Move the selected items to their new destination.
		    For Each selectedItem As XUISourceListItem In mSelectedItems
		      MoveItem(selectedItem, dropItem, 0) 
		    Next selectedItem
		    
		    // Make sure the dropItem is expanded to show the moved items.
		    If Not dropItem.Expanded Then dropItem.SetExpanded(True)
		    Return True
		  End If
		  
		  // ==============================================
		  // NOT DROPPED OVER A VALID PARENT
		  // ==============================================
		  // Get the item at newPosition. 
		  dropItem = ItemAtRowIndex(newPosition)
		  If dropItem = Nil Then Return False
		  
		  If dropItem.IsSection Then
		    // dropItem is a section. Ensure that the section that we're dropping the selected items is dropItem since 
		    // we don't allow dragging items from one section to another.
		    If mSelectedItems(0).Section <> dropItem Then Return False
		    
		    // Add the selected items as the first children of it.
		    Var indexToMoveTo As Integer = 0
		    For Each selectedItem As XUISourceListItem In mSelectedItems
		      MoveItem(selectedItem, dropItem, indexToMoveTo)
		      indexToMoveTo = indexToMoveTo + 1 
		    Next selectedItem
		  Else
		    // Make sure that the section where we're dropping the selected items is the same as the selected item's 
		    // section since we don't allow dragging items from one section to another.
		    If dropItem.Section <> mSelectedItems(0).Section Then Return False
		    
		    // Add the selection as children of dropItem's *parent* beginning at the index of this item.
		    Var target As XUISourceListItem = dropItem.GetParent
		    If target = Nil Then Return False
		    // Get the index of the dropItem in it's parent as this is where we will add the selection to.
		    Var index As Integer = target.IndexOfChild(dropItem)
		    If index = -1 Then Return False
		    For Each selectedItem As XUISourceListItem In mSelectedItems
		      MoveItem(selectedItem, target, index)
		      index = index + 1 
		    Next selectedItem
		  End If
		  
		  Rebuild
		  
		  Return True
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(x As Integer, y As Integer)
		  #Pragma Warning "TODO: Doesn't fire because MouseDown can't return True!"
		  
		  mLastMouseDragX = x
		  mLastMouseDragY = y
		  
		  // Determine if the mouse has moved and we are actually dragging.
		  If Abs(mLastMouseDownX - X) < 4 And Abs(mLastMouseDownY - Y) < 4 Then Return
		  
		  If mLastMouseDownRow <> -1 Then
		    mIsDraggingRow = True
		  Else
		    mIsDraggingRow = False
		    mLastMouseDragRow = -1
		  End If
		  
		  // Get the row currently underneath the mouse cursor.
		  Var rowUnderCursor As Integer = Me.RowFromXY(x, y)
		  
		  // If the row under the mouse cursor has changed since the last MouseDrag then refresh the source list.
		  If mIsDraggingRow And rowUnderCursor <> mLastMouseDragRow Then
		    mLastMouseDragRow = rowUnderCursor
		    Refresh
		  Else
		    mLastMouseDragRow = rowUnderCursor
		  End If
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  mLastMouseDownX = x
		  mLastMouseDownY = y
		  mLastMouseDownRow = SourceList.RowFromXY(x, y)
		  
		  // Start the drag timer.
		  DragTimer.Enabled = True
		  
		  Return False
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events DragTimer
	#tag Event
		Sub Action()
		  // Begins firing when MouseDown occurs and stops at the start of the following events:
		  // - DragReorderRows
		  // - MouseExit
		  // Simply updates the local X, Y coordinates of the mouse in the source list.
		  // The above events reset mLastMouseDragX and mLastMouseDragY to -1.
		  
		  // Compute the local x, y coordinates.
		  Var x As Integer = System.MouseX - SourceList.Left - Self.Left - SourceList.Window.Left
		  Var y As Integer = System.MouseY - SourceList.Top - Self.Top - SourceList.Window.Top
		  mLastMouseDragX = x
		  mLastMouseDragY = y
		  
		  // Determine if the mouse has moved and we are actually dragging.
		  If Abs(mLastMouseDownX - x) < 4 And Abs(mLastMouseDownY - x) < 4 Then Return
		  
		  // Was the last mouse click over a valid row?
		  If mLastMouseDownRow <> -1 Then
		    mIsDraggingRow = True
		  Else
		    mIsDraggingRow = False
		    mLastMouseDragRow = -1
		    Self.Enabled = False
		    Return
		  End If
		  
		  // Get the row currently underneath the mouse cursor.
		  Var rowUnderCursor As Integer = SourceList.RowFromXY(x, y)
		  
		  // If the row under the mouse cursor has changed since the last mouse drag then refresh the source list.
		  If mIsDraggingRow And rowUnderCursor <> mLastMouseDragRow Then
		    mLastMouseDragRow = rowUnderCursor
		    Refresh
		  Else
		    mLastMouseDragRow = rowUnderCursor
		  End If
		  
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Super"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
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
		InitialValue="True"
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
		Name="Hierarchical"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowMultipleSelection"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
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
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="mIsDraggingRow"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="mLastMouseDownRow"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="mLastMouseDragRow"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="mLastMouseDragX"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="mLastMouseDragY"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
