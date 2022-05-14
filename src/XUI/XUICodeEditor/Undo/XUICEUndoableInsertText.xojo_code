#tag Class
Protected Class XUICEUndoableInsertText
Implements XUIUndoableAction
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(editor As XUICodeEditor, id As Integer, description As String, caretPos As Integer, s As String)
		  /// Default constructor.
		  ///
		  /// - `editor` is the `XUICodeEditor` to perform this action on.
		  /// - `id` is the unique ID for this action.
		  /// - `description` is a human-radable description of this action for displaying 
		  /// in menubars and contextual menus.
		  /// - `caretPos` is the original caret position where the text was inserted at.
		  /// - `s` is the text inserted.
		  
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
		  /// Part of the `XUIUndoableAction` interface.
		  
		  Return mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468697320616374696F6E277320756E697175652049442E
		Function ID() As Integer
		  /// This action's unique ID.
		  ///
		  /// Part of the `XUIUndoableAction` interface.
		  
		  Return mID
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468697320616374696F6E277320756E697175652049442E
		Sub ID(Assigns value As Integer)
		  /// This action's unique ID.
		  ///
		  /// Part of the `XUIUndoableAction` interface.
		  
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
		  /// Part of the `XUIUndoableAction` interface.
		  
		  // Select the inserted text.
		  mEditor.CurrentSelection = _
		  New XUICETextSelection(mCaretPos, mCaretPos, mCaretPos + mText.CharacterCount, mEditor)
		  
		  // Delete the selection (disallowing undo).
		  mEditor.LineManager.DeleteSelection(False, True, True)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Stores the data required to undo / redo the insertion of a text within 
		the `XUICodeEditor`.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 546865206F726967696E616C20636172657420706F736974696F6E2077686572652074686520746578742077617320696E7365727465642061742E
		Private mCaretPos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41206465736372697074696F6E206F66207468697320616374696F6E2E
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520656469746F7220776865726520746865207465787420696E73657274696F6E206F636375727265642E
		Private mEditor As XUICodeEditor
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C206361636865206F66207468697320616374696F6E27732049442E
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
