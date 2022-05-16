#tag Class
Protected Class XUICEDelimiter
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(openingDelimiter As XUICELineToken, closingDelimiter As XUICELineToken)
		  /// Default constructor.
		  ///
		  /// - `openingDelimiter` is the opening delimiter token in this matched pair of delimiters.
		  /// - `closingDelimiter` is the closing delimiter token in this matched pair of delimiters.
		  
		  Self.Opener = openingDelimiter
		  Self.Closer = closingDelimiter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620606F746865726020697320636F6E73696465726564206571756976616C656E7420746F20746869732064656C696D697465722E
		Function EquivalentTo(other As XUICEDelimiter) As Boolean
		  /// True if `other` is considered equivalent to this delimiter.
		  
		  If other = Nil Then Return False
		  
		  Return Self.Opener = other.Opener And Self.Closer = other.Closer
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Represents a pair of opening and closing delimiter tokens.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520636C6F73696E672064656C696D6974657220746F6B656E20696E2074686973206D6174636865642070616972206F662064656C696D69746572732E
		Closer As XUICELineToken
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206F70656E696E672064656C696D6974657220746F6B656E20696E2074686973206D6174636865642070616972206F662064656C696D69746572732E
		Opener As XUICELineToken
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0, Description = 54686520737570706F72746564207479706573206F662064656C696D697465722E
		LCurly
		  LParen
		  LSquare
		  RCurly
		  RParen
		  RSquare
		None
	#tag EndEnum


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
