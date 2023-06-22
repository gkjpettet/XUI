#tag Interface
Protected Interface XUIUndoableAction
	#tag Method, Flags = &h0, Description = 446573637269626573207468697320756E646F61626C6520616374696F6E2E
		Function Description() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468697320616374696F6E277320756E697175652049442E
		Function ID() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468697320616374696F6E277320756E697175652049442E
		Sub ID(Assigns value As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265646F207468697320616374696F6E2E
		Sub Redo()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 556E646F207468697320616374696F6E2E
		Sub Undo()
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents an undoable / redoable action that can be handled by `XUIUndoManager`.
		
	#tag EndNote


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
End Interface
#tag EndInterface
