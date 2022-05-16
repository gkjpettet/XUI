#tag Class
Protected Class XUICECaretData
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(character As String, style As XUICETokenStyle)
		  /// Default constructor.
		  ///
		  /// - `character` is the character _behind_ the caret.
		  /// - `style` is the style of the character behind the caret.
		  
		  Self.Character = character
		  Self.Style = style
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Contains data computed during the drawing of the current caret line that is 
		required when during the caret *if* the caret is of the block type.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5468652063686172616374657220626568696E64207468652063617265742E
		Character As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207374796C65206F66207468652063686172616374657220626568696E64207468652063617265742E
		Style As XUICETokenStyle
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
			Name="Character"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
