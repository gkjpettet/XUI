#tag Class
Protected Class XUICEUndoableInsertLineBreak
Implements  XUIUndoableAction
	#tag Method, Flags = &h0
		Sub Constructor(editor As XUICodeEditor, id As Integer, description As String, caretPos As Integer)
		  mEditor = editor
		  mID = id
		  mDescription = description
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

	#tag Method, Flags = &h0, Description = 5265646F20746865206372656174696F6E206F662061206C696E6520627265616B2E
		Sub Redo()
		  /// Redo the creation of a line break.
		  ///
		  /// Part of the [UndoEngine.UndoableAction] interface.
		  
		  mEditor.CaretPosition = mCaretPos
		  mEditor.HandleReturnKey(False, True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 556E646F20746865206372656174696F6E206F662061206C696E6520627265616B2E
		Sub Undo()
		  /// Undo the creation of a line break.
		  ///
		  /// Part of the [UndoEngine.UndoableAction] interface.
		  
		  // Position the caret at the start of the line after the line break.
		  mEditor.CaretPosition = mCaretPos + 1
		  
		  // Simulate a backwards delete.
		  mEditor.DeleteBackward(False, True)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 54686520636172657420706F736974696F6E20776865726520746865206C696E6520627265616B206F636375727265642E
		Private mCaretPos As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41206465736372697074696F6E206F66207468697320616374696F6E2E
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520656469746F7220776865726520746865206C696E6520627265616B206F636375727265642E
		Private mEditor As XUICodeEditor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As Integer = 0
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
