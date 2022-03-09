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
      Scope           =   0
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

	#tag Method, Flags = &h21, Description = 457870616E64732060726F776020696E20746865206C697374626F782E
		Private Sub ExpandRow(row As Integer)
		  /// Expands `row` in the listbox.
		  
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
		    current = current + 1
		    ItemAtRowIndex_(parent.ChildAtIndex(i), current, target, result)
		    If current = target Then Return
		  Next i
		  
		  result = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656275696C64732074686520736F75726365206C6973742E
		Sub Rebuild()
		  /// Rebuilds the source list.
		  
		  #Pragma Warning "TODO"
		  
		  SourceList.RemoveAllRows
		  
		  For Each section As XUISourceListItem In mSections
		    
		    SourceList.AddRow("")
		    
		    If section.Expanded Then ExpandRow(SourceList.LastAddedRowIndex)
		    
		  Next section
		End Sub
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


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Property, Flags = &h21, Description = 5468652072656E646572657220746F2075736520746F20647261772074686520726F777320696E2074686520736F75726365206C6973742E
		Private mRenderer As XUISourceListRenderer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320736F75726365206C69737427732073656374696F6E732E
		Private mSections() As XUISourceListItem
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


#tag EndWindowCode

#tag Events SourceList
	#tag Event
		Function PaintCellBackground(g As Graphics, row As Integer, column As Integer) As Boolean
		  If Renderer = Nil Then Return True
		  
		  // If the row does not exist, just render the background.
		  If row < 0 Or row > Me.LastRowIndex Or (row = 0 And Me.RowCount = 0) Then
		    Renderer.RenderBackground(g, row)
		    Return True
		  End If
		  
		  Var item As XUISourceListItem = ItemAtRowIndex(row)
		  If item = Nil Then
		    // Shouldn't happen...
		    Break
		  Else
		    Renderer.RenderItem(item, g)
		  End If
		  
		  Return True
		End Function
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
		Name="InitialParent"
		Visible=false
		Group="Position"
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
		Name="TabPanelIndex"
		Visible=false
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
		Name="Composited"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
