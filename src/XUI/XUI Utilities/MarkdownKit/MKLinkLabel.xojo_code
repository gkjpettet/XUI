#tag Class
Protected Class MKLinkLabel
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor()
		  /// Default constructor.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E7374727563746F72207769746820706172616D65746572732E
		Sub Constructor(length As Integer, value As String, characters() As MarkdownKit.MKCharacter)
		  /// Constructor with parameters.
		  ///
		  /// - `length` is the length of the link label (excluding delimiters).
		  /// - `value` is the link label.
		  /// - `characters()` is an array of the label's characters. May be empty.
		  
		  Self.Characters = characters
		  Self.Value = value
		  Self.Length = length
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Holds information about a link label. Provided to assist with rendering into source code tokens.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 546865206C6162656C277320636861726163746572732E204D617920626520656D7074792E
		Characters() As MarkdownKit.MKCharacter
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C656E677468206F6620746865206C696E6B206C6162656C20286578636C7564696E672064656C696D6974657273292E
		Length As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C696E6B206C6162656C2076616C75652E
		Value As String
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
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
