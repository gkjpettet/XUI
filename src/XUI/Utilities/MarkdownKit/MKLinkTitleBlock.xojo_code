#tag Class
Protected Class MKLinkTitleBlock
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(absPos As Integer, localPos As Integer, length As Integer, lineNumber As Integer)
		  /// Default constructor.
		  ///
		  /// - `absPos` is the 0-based position in the original source code of this link title.
		  /// - `localPos` is the 0-based position on the line this block begins at.
		  /// - length` is the length of this title line.
		  /// - `lineNumber` is the 1-based line number this block begins on.
		  
		  Self.AbsoluteStart = absPos
		  Self.LocalStart = localPos
		  Self.Length = length
		  Self.LineNumber = lineNumber
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Link titles can span multiple lines. This class represents the value of a link title that occurs
		on a single line. It specifies the absolute and local start positions of the line and the contents.
		Multiple contiguous instances of this class may consitute a link title.
		
		This class is only used by source code token renderers.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520302D6261736564206162736F6C75746520706F736974696F6E20696E20746865206F726967696E616C20736F7572636520636F6465206F662074686973207469746C65206C696E652E
		AbsoluteStart As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C656E677468206F662074686973207469746C65206C696E652E
		Length As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C696E65206E756D626572207468697320626C6F636B206F662074657874206F6363757273206F6E2E
		LineNumber As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520302D6261736564206C6F63616C20706F736974696F6E206F6E20746865206C696E65206F662074686973207469746C65206C696E652E
		LocalStart As Integer = -1
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
			Name="AbsoluteStart"
			Visible=false
			Group="Behavior"
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
			Name="LineNumber"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LocalStart"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
