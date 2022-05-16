#tag Class
Protected Class XUICETextSelection
	#tag Method, Flags = &h0, Description = 52657475726E732061206465657020636C6F6E65206F662074686973206F626A6563742E
		Function Clone() As XUICETextSelection
		  /// Returns a deep clone of this object.
		  
		  Return New XUICETextSelection(Anchor, StartLocation, EndLocation, Owner)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(anchor As Integer, startPos As Integer, endPos As Integer, editor As XUICodeEditor)
		  /// Default constructor.
		  ///
		  /// - `anchor` is the 0-based location of the anchor.
		  /// - `startPos` is the 0-based start position of this selection.
		  /// - `endPos` is the 0-based end position of this selection.
		  /// - `editor` is the editor that owns this selection.
		  ///
		  /// The anchor marks the position that the selection began. Typically this 
		  /// will be the caret position when the selection begins but it's not 
		  /// necessarily the same as the start position.
		  /// The anchor is typically set to `-1` when it is not required.
		  
		  Self.Anchor = anchor
		  Self.StartLocation = startPos
		  Self.EndLocation = endPos
		  mOwnerRef = New WeakRef(editor)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 547275652069662060636F6C756D6E602069732077697468696E20746869732073656C656374696F6E2E
		Function ContainsColumn(column As Integer) As Boolean
		  /// True if `column` is within this selection.
		  
		  Return column >= StartLocation And column <= EndLocation
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73205472756520696620746869732073656C656374696F6E20656E746972656C7920636F6E7461696E73205B6C696E655D2E
		Function ContainsLine(line As XUICELine) As Boolean
		  /// Returns True if this selection entirely contains `line`.
		  ///
		  /// A line is considered to be contained by a selection if both its start and end 
		  /// locations are within this selection.
		  
		  If line = Nil Then Return False
		  Return line.Start >= StartLocation And line.Finish <= EndLocation
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732054727565206966206076616C7565602069732077697468696E207468652070617373656420626F756E64732E
		Private Function InRange(value As Integer, lower As Integer, upper As Integer) As Boolean
		  /// Returns True if `value` is within the passed bounds.
		  
		  Return value >= lower And value <= upper
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73205472756520696620616E79206F6620746869732073656C656374696F6E20696E7465727365637473205B6C696E655D2E
		Function IntersectsLine(line As XUICELine) As Boolean
		  /// Returns True if any of this selection intersects `line`.
		  ///
		  /// A line is intersected by a selection if any character of the line is within it.
		  
		  Return InRange(StartLocation, line.Start, line.Finish) Or _
		  InRange(EndLocation, line.Start, line.Finish)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4966205B6C696E655D2069732077686F6C6C79206F7220706172746C7920636F6E7461696E65642077697468696E20746869732073656C656374696F6E207468656E2072657475726E732074686520636F6C756D6E732073656C6563746564206F72204E696C2E
		Function SelectedColumnsInLine(line As XUICELine) As XUICESelectedColumns
		  /// If `line` is wholly or partly contained within this selection then 
		  /// returns the columns selected or Nil.
		  ///
		  /// Returns an object representing the start and end columns contained by this selection or Nil if 
		  /// this selection does not intersect `line`. 
		  /// If this selection extends beyond the length of this line then the returned 
		  /// `TextSelection` will have its `EndLocation` set to `-1`.
		  /// If this selection begins before this line then the returned `TextSelection` will have 
		  /// its `Anchor` set to `-1`. Otherwise it's set to `0`.
		  
		  Var selectionBeginsBeforeLine As Boolean = If(Self.StartLocation < line.Start, True, False)
		  
		  // Does this selection wholly contain the passed line?
		  If ContainsLine(line) Then
		    If Self.EndLocation > line.Finish Then
		      Return New XUICESelectedColumns(selectionBeginsBeforeLine, 0, True)
		    Else
		      Return New XUICESelectedColumns(selectionBeginsBeforeLine, 0, False, line.Length)
		    End If
		  End If
		  
		  // Perhaps the selection doesn't intersect this line at all?
		  If Not IntersectsLine(line) Then Return Nil
		  
		  // The selection intersects this line.
		  // Find the first position on this line that is in the selection.
		  Var iMax As Integer = line.Start + line.Length
		  Var startPos As Integer = -1
		  For i As Integer = line.Start To iMax
		    If InRange(i, Self.StartLocation, Self.EndLocation) Then
		      startPos = i
		      Exit
		    End If
		  Next i
		  
		  // Edge case 1: The selection begins after the last character of this line, at the line ending.
		  If startPos = -1 Then Return Nil
		  
		  // Edge case 2: The selection ends right at the start of this line.
		  If startPos = Self.EndLocation Then Return Nil
		  
		  // Edge case 3: The selection continues beyond the end of this line.
		  If Self.EndLocation > line.Finish Then
		    Return New XUICESelectedColumns(selectionBeginsBeforeLine, startPos - line.Start, True)
		  End If
		  
		  // Find the last position within this line that is still in the selection.
		  // We'll count backwards from the end of the line because I'm guessing that 
		  // it is more common for a selection to run to the end of a line than not.
		  Var endPos As Integer = -1
		  Var iMin As Integer = startPos + 1
		  For i As Integer = iMax DownTo iMin
		    If InRange(i, Self.StartLocation, Self.EndLocation) Then
		      endPos = i
		      Exit
		    End If
		  Next i
		  
		  // Convert the absolute start and end positions to line columns.
		  Return New XUICESelectedColumns(selectionBeginsBeforeLine, _
		  startPos - line.Start, False, endPos - line.Start)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520746578742073656C656374656420627920746869732073656C656374696F6E20696E20746865206F776E696E6720656469746F722E
		Function ToString() As String
		  /// Returns the text selected by this selection in the owning editor.
		  
		  If Owner = Nil Or Owner.LineManager = Nil Then Return ""
		  
		  Var lm As XUICELineManager = Owner.LineManager
		  
		  // Get the start and end line indices.
		  Var startLineIndex As Integer = lm.LineForCaretPos(StartLocation).Number - 1
		  Var endLineIndex As Integer = lm.LineForCaretPos(EndLocation).Number - 1
		  
		  // Get the contents from each line within the selection.
		  Var s() As String
		  For i As Integer = startLineIndex To endLineIndex
		    s.Add(lm.Lines(i).CharactersInSelection(Self))
		  Next i
		  
		  Return String.FromArray(s, &u0A)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Represents a selection of text within the code editor.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 302D626173656420706F736974696F6E206F6620746869732073656C656374696F6E277320616E63686F7220286F726967696E616C206361726574207374617274696E6720706F736974696F6E292E
		Anchor As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 302D626173656420656E6420706F736974696F6E206F66207468697320746578742073656C656374696F6E2E
		EndLocation As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C656E677468206F6620746869732073656C656374696F6E2E
		#tag Getter
			Get
			  Return EndLocation - StartLocation
			  
			End Get
		#tag EndGetter
		Length As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F20746865204D4345456469746F722074686174206F776E73207468697320746578742073656C656374696F6E2E
		Private mOwnerRef As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865204D4345456469746F722074686174206F776E73207468697320746578742073656C656374696F6E2E
		#tag Getter
			Get
			  If mOwnerRef.Value <> Nil Then
			    Return XUICodeEditor(mOwnerRef.Value)
			  Else
			    // This should never happen as a text selection must always be owned.
			    Return Nil
			  End If
			  
			End Get
		#tag EndGetter
		Owner As XUICodeEditor
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 302D626173656420737461727420706F736974696F6E206F6620746869732073656C656374696F6E2E
		StartLocation As Integer = 0
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
			Name="Anchor"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EndLocation"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartLocation"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
