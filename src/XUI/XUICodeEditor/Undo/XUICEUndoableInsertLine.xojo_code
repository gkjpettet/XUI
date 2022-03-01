#tag Class
Protected Class XUICEUndoableInsertLine
Implements  XUIUndoableAction
	#tag Method, Flags = &h0
		Sub Constructor(editor As XUICodeEditor, id As Integer, description As String, lineNumber As Integer, caretPos As Integer, contents As String)
		  mEditor = editor
		  mID = id
		  mDescription = description
		  mLineNumber = lineNumber
		  mCaretPos = caretPos
		  mContents = contents
		  
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

	#tag Method, Flags = &h0, Description = 5265646F2074686520696E73657274696F6E206F662061206C696E652061742074686520737065636966696564206C696E65206E756D6265722E
		Sub Redo()
		  /// Redo the insertion of a line at the specified line number.
		  /// 
		  /// Part of the [UndoEngine.UndoableAction] interface.
		  
		  mEditor.CaretPosition = mCaretPos
		  mEditor.HandleReturnKey(False, False)
		  If mContents <> "" Then
		    mEditor.Insert(mContents, mEditor.CaretPosition, False, True, True)
		  Else
		    mEditor.Refresh
		    mEditor.ContentsDidChange
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 556E646F2074686520696E73657274696F6E206F662061206E6577206C696E652061742074686520737065636966696564206C696E65206E756D6265722E
		Sub Undo()
		  /// Undo the insertion of a line at the specified line number.
		  ///
		  /// Part of the [UndoEngine.UndoableAction] interface.
		  
		  Var lineToDelete As XUICELine = mEditor.LineManager.LineAt(mLineNumber)
		  
		  // -1 to account for the newline character
		  mEditor.LineManager.DeleteLineAt(mLineNumber, -lineToDelete.Length - 1)
		  
		  mEditor.CaretPosition = mCaretPos
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 54686520636172657420706F736974696F6E207468617420746865206E6577206C696E6520696E73657274696F6E206F636375727265642061742E
		Private mCaretPos As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6E74656E7473206F6620746865206E65776C7920696E736572746564206C696E652E
		Private mContents As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41206465736372697074696F6E206F66207468697320616374696F6E2E
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520656469746F7220776865726520746865206E6577206C696E6520696E73657274696F6E206F636375727265642E
		Private mEditor As XUICodeEditor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520312D6261736564206C696E65206E756D626572207468617420746865206E6577206C696E652077617320696E7365727465642061742E
		Private mLineNumber As Integer = 1
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
