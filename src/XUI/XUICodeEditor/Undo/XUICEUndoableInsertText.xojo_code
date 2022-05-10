#tag Class
Protected Class XUICEUndoableInsertText
Implements XUIUndoableAction
	#tag Method, Flags = &h0
		Sub Constructor(editor As XUICodeEditor, id As Integer, description As String, caretPos As Integer, s As String)
		  mEditor = editor
		  mID = id
		  mDescription = description
		  mCaretPos = caretPos
		  mText = s
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41206465736372697074696F6E206F66207468697320616374696F6E2E
		Function Description() As String
		  /// A description of this action.
		  ///
		  /// Part of the UKUndoableAction interface.
		  
		  Return mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ID() As Integer
		  /// Part of the UKUndoableAction interface.
		  
		  Return mID
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ID(Assigns value As Integer)
		  /// Part of the UKUndoableAction interface.
		  
		  mID = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265646F2074686520696E73657274696F6E206F6620746865207465787420696E2074686520656469746F722E
		Sub Redo()
		  /// Redo the insertion of the text in the editor.
		  ///
		  /// Part of the `XUIUndoableAction` interface.
		  
		  mEditor.Insert(mText, mCaretPos, False, True, True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 556E646F2074686520696E73657274696F6E206F6620746865207465787420746861742077617320696E73657274656420617420606D4361726574506F73602E
		Sub Undo()
		  /// Undo the insertion of the text that was inserted at `mCaretPos`.
		  ///
		  /// Part of the UKUndoableAction interface.
		  
		  // Select the inserted text.
		  mEditor.CurrentSelection = _
		  New XUICETextSelection(mCaretPos, mCaretPos, mCaretPos + mText.CharacterCount, mEditor)
		  
		  // Delete the selection (disallowing undo).
		  mEditor.LineManager.DeleteSelection(False, True, True)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 546865206F726967696E616C20636172657420706F736974696F6E2077686572652074686520746578742077617320696E7365727465642061742E
		Private mCaretPos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEditor As XUICodeEditor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207465787420696E73657274656420617420606D4361726574506F73602E
		Private mText As String
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
