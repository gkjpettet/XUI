#tag Class
Protected Class MKIndentedCodeBlock
Inherits MKBlock
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(parent As MKBlock, blockStartOffset As Integer = 0)
		  /// Default constructor.
		  ///
		  /// - `parent` is the parent of this block.
		  /// - `blockStartOffset` is the 0-based position in the original Markdown source 
		  ///   that this block begins at.
		  
		  Super.Constructor(MKBlockTypes.IndentedCode, parent, blockStartOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C6F736573207468697320626C6F636B20616E64206D616B657320616E792066696E616C206368616E6765732074686174206D61792062652072657175697265642E
		Sub Finalise(line As XUITextLine)
		  /// Closes this block and makes any final changes that may be required.
		  
		  // Calling the overridden superclass method.
		  Super.Finalise(line)
		  
		  // Blank lines preceding or following an indented code block are not included in it.
		  If FirstChild <> Nil And MKTextBlock(FirstChild).IsBlank Then Children.RemoveAt(0)
		  If LastChild <> Nil And MKTextBlock(LastChild).IsBlank Then Call Children.Pop
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents an indented code block within a Markdown document.
		
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
End Class
#tag EndClass
