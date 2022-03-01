#tag Class
Protected Class XUICEUndoableReplaceLineContents
Implements  XUIUndoableAction
	#tag Method, Flags = &h0
		Sub Constructor(editor As XUICodeEditor, id As Integer, description As String, lineNumber As Integer, originalContents As String, newContents As String, caretPos As Integer)
		  mEditor = editor
		  mID = id
		  mDescription = description
		  mLineNumber = lineNumber
		  mOriginalContents = originalContents
		  mNewContents = newContents
		  mCaretPos = caretPos
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41206465736372697074696F6E206F66207468697320756E646F61626C6520616374696F6E2E
		Function Description() As String
		  Return mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ID() As Integer
		  Return mID
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ID(Assigns value As Integer)
		  mID = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265646F20746865207265706C6163656D656E74206F662074686520636F6E74656E7473206F662074686520737065636966696564206C696E652E
		Sub Redo()
		  /// Redo the replacement of the contents of the specified line.
		  ///
		  /// Assumes that there are no new lines in [mNewContents].
		  /// Part of the [UndoEngine.UndoableAction] interface.
		  
		  // Get the line to modify.
		  Var line As XUICELine = mEditor.LineManager.LineAt(mlineNumber)
		  
		  // Change the contents back.
		  line.SetContents(mNewContents)
		  
		  // Adjust the offsets of subsequent lines.
		  Var offset As Integer = mNewContents.CharacterCount - mOriginalContents.CharacterCount
		  If offset <> 0 Then
		    mEditor.LineManager.AdjustLineOffsets(mLineNumber + 1, offset, 0)
		  End If
		  
		  // Set the editor's caret position.
		  mEditor.CaretPosition = mCaretPos
		  
		  // Scroll to the new caret position
		  mEditor.ScrollToCaretPos(True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 556E646F20746865207265706C6163656D656E74206F662074686520636F6E74656E7473206F662074686973206C696E652E
		Sub Undo()
		  /// Undo the replacement of the contents of this line.
		  ///
		  /// Assumes that there are no new lines in [mOriginalContents].
		  /// Part of the [UndoEngine.UndoableAction] interface.
		  
		  // Get the line to modify.
		  Var line As XUICELine = mEditor.LineManager.LineAt(mlineNumber)
		  
		  // Set the contents back to its original value.
		  line.SetContents(mOriginalContents)
		  
		  // Adjust the offsets of subsequent lines.
		  Var offset As Integer = mOriginalContents.CharacterCount - mNewContents.CharacterCount
		  If offset <> 0 Then
		    mEditor.LineManager.AdjustLineOffsets(mLineNumber + 1, offset, 0)
		  End If
		  
		  // Set the editor's caret position.
		  mEditor.CaretPosition = mCaretPos
		  
		  // Scroll to the new caret position
		  mEditor.ScrollToCaretPos(True)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 54686520636172657420706F736974696F6E20776865726520746865207265706C6163656D656E74206F636375727265642E
		Private mCaretPos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41206465736372697074696F6E206F66207468697320616374696F6E2E
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520656469746F7220776865726520746865206C696E6520636F6E74656E7473207265706C6163656D656E74206F636375727265642E
		Private mEditor As XUICodeEditor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520312D6261736564206E756D626572206F6620746865206C696E65207468617420776173206D6F6469666965642E
		Private mLineNumber As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E657720636F6E74656E7473206F6620746865206C696E652E
		Private mNewContents As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206F726967696E616C20636F6E74656E7473206F6620746865206C696E652E
		Private mOriginalContents As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
