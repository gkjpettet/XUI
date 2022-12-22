#tag Class
Protected Class MKInlineText
Inherits MKBlock
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(parent As MKBlock)
		  /// Default constructor.
		  ///
		  /// - `parent` is the parent of this block.
		  
		  Super.Constructor(MKBlockTypes.InlineText, parent, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C6F736573207468697320626C6F636B20616E64206D616B657320616E792066696E616C206368616E6765732074686174206D61792062652072657175697265642E
		Sub Finalise(line As XUITextLine = Nil)
		  /// Closes this block and makes any final changes that may be required.
		  
		  // Calling the overridden superclass method.
		  Super.Finalise(line)
		  
		  Var iLimit As Integer = EndPosition - Parent.Start
		  For i As Integer = ParentStart To iLimit
		    Var c As MKCharacter = Parent.Characters(i)
		    If Not c.IsLineEnding Then Characters.Add(c)
		  Next i
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents inline text within a Markdown document.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 302D6261736564206C6F63616C20706F736974696F6E206F6620746865207374617274206F66207468697320626C6F636B206F6E20697473206C696E652E
		LocalStart As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F63616C20302D626173656420696E64657820696E2060506172656E742E43686172616374657273602074686174207468697320696E6C696E652074657874207370616E20626567696E732061742E
		ParentStart As Integer = 0
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
			Name="ParentStart"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LocalStart"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
