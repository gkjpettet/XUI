#tag Class
Protected Class MKParagraphBlock
Inherits MKBlock
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(parent As MKBlock, blockStart As Integer)
		  /// Default constructor.
		  ///
		  /// - `parent` is the parent of this block.
		  /// - `blockStart` is the 0-based position in the original Markdown source 
		  ///   that this block begins at.
		  
		  Super.Constructor(MKBlockTypes.Paragraph, parent, blockStart)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C6F736573207468697320626C6F636B20616E64206D616B657320616E792066696E616C206368616E6765732074686174206D61792062652072657175697265642E
		Sub Finalise(line As XUITextLine)
		  /// Closes this block and makes any final changes that may be required.
		  
		  // Calling the overridden superclass method.
		  Super.Finalise(line)
		  
		  ParseLinkReferenceDefinitions
		  
		  // If this paragraph consists only of whitespace, empty out its character array.
		  Var seenNonWhitespace As Boolean = False
		  For Each char As MKCharacter In Characters
		    If Not char.IsMarkdownWhitespace(True) Then
		      seenNonWhitespace = True
		      Exit
		    End If
		  Next char
		  If Not seenNonWhitespace Then Characters.RemoveAll
		  
		  // Removing a single trailing line ending if present.
		  If Characters.Count > 0 And Characters(Characters.LastIndex).IsLineEnding Then Call Characters.Pop
		  
		  // Final spaces are stripped before inline parsing.
		  For i As Integer = Characters.LastIndex DownTo 0
		    Select Case Characters(i).Value
		    Case " "
		      Characters.RemoveAt(i)
		    Else
		      Exit
		    End Select
		  Next i
		  
		  // Remove this paragraph from its parent if it's empty.
		  If Characters.Count = 0 And Parent <> Nil Then
		    Var parentIndex As Integer = Parent.Children.IndexOf(Self)
		    If parentIndex <> -1 Then Parent.Children.RemoveAt(parentIndex)
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a paragraph list block within a Markdown document.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 416C6C206F66207468697320626C6F636B2773206368617261637465727320617320616E206172726179206F66204D4B43686172616374657220696E7374616E6365732E
		Private mAllCharacters() As MKCharacter
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
