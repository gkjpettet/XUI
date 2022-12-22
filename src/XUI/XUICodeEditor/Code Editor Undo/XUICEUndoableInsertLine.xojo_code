#tag Class
Protected Class XUICEUndoableInsertLine
Implements XUIUndoableAction
	#tag Method, Flags = &h0
		Sub Constructor(editor As XUICodeEditor, id As Integer, description As String, lineNumber As Integer, caretPos As Integer, contents As String)
		  /// Default constructor.
		  ///
		  /// - `editor` is the `XUICodeEditor` to perform this action on.
		  /// - `id` is the unique ID for this action.
		  /// - `description` is a human-radable description of this action for displaying 
		  /// in menubars and contextual menus.
		  /// - `lineNumber` is the 1-based line number that the new line was inserted at.
		  /// - `caretPos` is the caret position that the new line insertion occurred at.
		  /// - `contents` is the contents of the newly inserted line.
		  
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
		  /// A description of this undoable action.
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

	#tag Method, Flags = &h0, Description = 5265646F2074686520696E73657274696F6E206F662061206C696E652061742074686520737065636966696564206C696E65206E756D6265722E
		Sub Redo()
		  /// Redo the insertion of a line at the specified line number.
		  /// 
		  /// Part of the `XUIUndoableAction` interface.
		  
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
		  /// Part of the `XUIUndoableAction` interface.
		  
		  Var lineToDelete As XUICELine = mEditor.LineManager.LineAt(mLineNumber)
		  
		  If lineToDelete = Nil Then
		    // This shouldn't happen.
		    #If DebugBuild
		      System.Log(System.LogLevelWarning, "Failed to undo insertion of a line as the line to delete (" + _
		      mLineNumber.ToString + ") cannot be found.")
		    #EndIf
		    Return
		  End If
		  
		  // -1 to account for the newline character
		  mEditor.LineManager.DeleteLineAt(mLineNumber, -lineToDelete.Length - 1)
		  
		  mEditor.CaretPosition = mCaretPos
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Stores the data required to undo / redo the insertion of a line within 
		the `XUICodeEditor`.
		
	#tag EndNote


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

	#tag Property, Flags = &h21, Description = 496E7465726E616C206361636865206F66207468697320616374696F6E27732049442E
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
