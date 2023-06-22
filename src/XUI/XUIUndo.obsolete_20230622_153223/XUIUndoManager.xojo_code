#tag Class
Protected Class XUIUndoManager
	#tag Method, Flags = &h21, Description = 416464732060616374696F6E6020746F2074686520737461636B206F66207265646F61626C6520616374696F6E732E
		Private Sub AddActionToRedoStack(action As XUIUndoableAction)
		  /// Adds `action` to the stack of redoable actions.
		  
		  If action = Nil Then Return
		  mRedoStack.Add(action)
		  mUndoStackIndex = mUndoStackIndex - 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416464732060616374696F6E6020746F2074686520737461636B206F6620756E646F61626C6520616374696F6E732E
		Private Sub AddActionToUndoStack(action As XUIUndoableAction)
		  /// Adds `action` to the stack of undoable actions.
		  
		  If action = Nil Then Return
		  mUndoStack.Add(action)
		  mUndoStackIndex = mUndoStackIndex + 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061207265666572656E636520746F20746865206E657874207265646F61626C6520616374696F6E2E
		Function NextRedo() As XUIUndoableAction
		  /// Returns a reference to the next redoable action.
		  
		  If mRedoStack.Count = 0 Then
		    Return Nil
		  Else
		    Return mRedoStack(mRedoStack.LastIndex)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061207265666572656E636520746F20746865206E65787420756E646F61626C6520616374696F6E2E
		Function NextUndo() As XUIUndoableAction
		  /// Returns a reference to the next undoable action.
		  
		  If mUndoStack.Count = 0 Then
		    Return Nil
		  Else
		    Return mUndoStack(mUndoStack.LastIndex)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50757368657320616E20756E646F61626C652060616374696F6E60206F6E20746F2074686520556E646F4D616E61676572277320737461636B2E
		Sub Push(action As XUIUndoableAction)
		  /// Pushes an undoable `action` on to the UndoManager's stack.
		  
		  // Sanity check.
		  If action = Nil Then Return
		  
		  // Add this undo action.
		  AddActionToUndoStack(action)
		  
		  // Clear the redo stack.
		  mRedoStack.RemoveAll
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265646F7320746865206C61737420616374696F6E2E
		Sub Redo()
		  /// Redos the last action.
		  
		  If Not CanRedo Then Return
		  Var id As Integer = mRedoStack(mRedoStack.LastIndex).ID
		  Redo(ID)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265646F732074686520616374696F6E2077697468207468652073706563696669656420606964602E
		Sub Redo(id As Integer)
		  /// Redos the action with the specified `id`.
		  
		  If Not CanRedo Then Return
		  
		  Var match As Boolean = False
		  Do
		    match = False
		    mIsUndoing = True
		    
		    If id = mRedoStack(mRedoStack.LastIndex).ID Then
		      Var action As XUIUndoableAction = mRedoStack.Pop
		      AddActionToUndoStack(action)
		      
		      action.Redo
		      match = True
		    End If
		    
		    mIsUndoing = False
		  Loop Until id = 0 Or Not CanRedo Or Not match
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265736574732074686520556E646F4D616E616765722C2072656D6F76696E6720616C6C20756E646F61626C6520616374696F6E732E
		Sub RemoveAll()
		  /// Resets the UndoManager, removing all undoable actions.
		  
		  mUndoStack.RemoveAll
		  mRedoStack.RemoveAll
		  mUndoStackIndex = 0
		  mIsUndoing = False
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 556E646F7320746865206C61737420616374696F6E2E
		Sub Undo()
		  /// Undos the last action.
		  
		  If Not CanUndo Then Return
		  Var id As Integer = mUndoStack(mUndoStack.LastIndex).ID
		  Undo(ID)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 556E646F732074686520616374696F6E20776974682074686520737065636966696564205B69645D2E
		Sub Undo(ID as integer)
		  /// Undos the action with the specified `id`.
		  
		  If Not CanUndo Then Return
		  
		  Var match As Boolean = False
		  Do
		    match = False
		    mIsUndoing = True
		    
		    If id = mUndoStack(mUndoStack.LastIndex).ID Then
		      Var action as XUIUndoableAction = mUndoStack.Pop
		      AddActionToRedoStack(action)
		      
		      action.Undo
		      match = True
		    End If
		    
		    mIsUndoing = False
		  Loop Until id = 0 Or Not CanUndo Or Not match
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		`XUIUndoManager` forms the basis of a generic, application-wide, undo / redo manager. It is used
		extensively throughout XUI and can be seen in action in the `XUICodeEditor` demo.
		
		It essentially manages a stack of `XUIUndoableAction` instances.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686572652061726520617661696C61626C65207265646F20616374696F6E732E
		#tag Getter
			Get
			  Return mRedoStack.Count > 0
			  
			End Get
		#tag EndGetter
		CanRedo As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686572652061726520617661696C61626C6520756E646F20616374696F6E732E
		#tag Getter
			Get
			  Return mUndoStack.Count > 0
			  
			End Get
		#tag EndGetter
		CanUndo As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686520556E646F4D616E616765722069732063757272656E746C7920756E646F696E672E
		#tag Getter
			Get
			  Return mIsUndoing
			  
			End Get
		#tag EndGetter
		IsUndoing As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520604973556E646F696E676020636F6D70757465642070726F70657274792E
		Private mIsUndoing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520737461636B206F66207265646F20616374696F6E732E
		Private mRedoStack() As XUIUndoableAction
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520737461636B206F6620756E646F20616374696F6E732E
		Private mUndoStack() As XUIUndoableAction
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4120706F696E74657220746F2074686520746F70206F662074686520756E646F20737461636B2E
		Private mUndoStackIndex As Integer
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
			Name="CanRedo"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanUndo"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsUndoing"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
