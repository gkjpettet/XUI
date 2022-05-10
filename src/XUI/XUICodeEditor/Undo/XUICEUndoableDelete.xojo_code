#tag Class
Protected Class XUICEUndoableDelete
Implements XUIUndoableAction
	#tag Method, Flags = &h0
		Sub Constructor(editor As XUICodeEditor, id As Integer, description As String, deletedText As String, selection As XUICETextSelection)
		  mEditor = editor
		  mID = id
		  mDescription = description
		  mDeletedText = deletedText
		  mSelection = selection
		  
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

	#tag Method, Flags = &h0, Description = 5265646F207468652064656C6574696F6E206F6620612073656C656374696F6E20696E2074686520656469746F722063616E7661732E
		Sub Redo()
		  /// Redo the deletion of a selection in the editor canvas.
		  ///
		  /// Part of the `XUIUndoableAction` interface.
		  
		  mEditor.CurrentSelection = mSelection.Clone
		  mEditor.LineManager.DeleteSelection(False, True, True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 556E646F207468652064656C6574696F6E206F6620612073656C656374696F6E20696E2074686520656469746F722063616E7661732E
		Sub Undo()
		  /// Undo the deletion of a selection in the editor canvas.
		  ///
		  /// Part of the `XUIUndoableAction` interface.
		  
		  mEditor.LineManager.InsertText(mSelection.StartLocation, mDeletedText, False, True, True)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 54686520746578742074686174207761732064656C657465642066726F6D2074686520656469746F7220627920746865206F726967696E616C2064656C6574696F6E20616374696F6E2E
		Private mDeletedText As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41206465736372697074696F6E206F66207468697320616374696F6E2E
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520656469746F72207768657265207468652064656C6574696F6E206F636375727265642E
		Private mEditor As XUICodeEditor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206F726967696E616C2073656C656374696F6E20636F6E7461696E696E672074686520746578742074686174207761732064656C657465642E
		Private mSelection As XUICETextSelection
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
