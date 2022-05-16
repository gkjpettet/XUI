#tag Class
Protected Class XUICESelectedColumns
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(selectionBeginsBeforeLine As Boolean, start As Integer, selectionEndsAfterLine As Boolean, finish As Integer = -1)
		  /// Default constructor.
		  ///
		  /// - `selectionBeginsBeforeLine` is `True` if the text selection begins above the line.
		  /// - `start` is the 0-based column that is selected on the line.
		  /// - `selectionEndsAfterLine` is `True` if the selection ends after this line.
		  /// - `finish` is the last (0-based) column that is selected on the line. 
		  ///   Will be `-1` if the selection ends beyond the line.
		  
		  Self.SelectionBeginsBeforeLine = selectionBeginsBeforeLine
		  Self.Start = start
		  Self.SelectionEndsAfterLine = selectionEndsAfterLine
		  Self.Finish = finish
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents the start and end columns contained by a text selection within the code editor.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 546865206C6173742028302D62617365642920636F6C756D6E20746861742069732073656C6563746564206F6E20746865206C696E652E2057696C6C20626520602D3160206966207468652073656C656374696F6E20656E6473206265796F6E6420746865206C696E652E
		Finish As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652073656C656374696F6E20656E76656C6F70696E672074686973206C696E6520626567696E73206265666F72652074686973206C696E652E
		SelectionBeginsBeforeLine As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468652073656C656374696F6E20656E76656C6F70696E672074686973206C696E6520656E64732061667465722074686973206C696E652E
		SelectionEndsAfterLine As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652066697273742028302D62617365642920636F6C756D6E20746861742069732073656C6563746564206F6E20746865206C696E652E
		Start As Integer = 0
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
			Name="SelectionBeginsBeforeLine"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Finish"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionEndsAfterLine"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Start"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
