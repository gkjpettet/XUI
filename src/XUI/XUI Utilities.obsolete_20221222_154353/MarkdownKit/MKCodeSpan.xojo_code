#tag Class
Protected Class MKCodeSpan
Inherits MKBlock
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(parent As MKBlock, absoluteStartPos As Integer, localStartPos As Integer, lineNumber As Integer, backtickStringLength As Integer, parentClosingBacktickStringStart As Integer, openingBacktickChar As MarkdownKit.MKCharacter, firstClosingBacktickChar As MarkdownKit.MKCharacter)
		  /// Default constructor.
		  ///
		  /// - `parent` is this block's parent.
		  /// - `absoluteStartPos` is the 0-based position in the original source code that this block begins at.
		  /// - `localStartPos` is the 0-based index in `parent.Characters` that the opening backtick 
		  ///   character of this code span begins.
		  /// - `lineNumber` is the 1-based line number of the line this block occurs on.
		  /// - `backtickStringLength` is the length of the flanking backtick delimiters around this code span. 
		  /// - `parentClosingBacktickStringLength` is the 0-based index in this code span's parent paragraph's
		  ///   `Characters` array of the first character of the closing backtick string.
		  /// - openingBacktickChar` is the opening backtick character.
		  
		  Super.Constructor(MKBlockTypes.CodeSpan, parent, absoluteStartPos)
		  
		  Self.LineNumber = lineNumber
		  Self.LocalStart = localStartPos
		  Self.BacktickStringLength = backtickStringLength
		  Self.EndPosition = firstClosingBacktickChar.AbsolutePosition + backtickStringLength - 1
		  Self.ParentClosingBacktickStringStart = parentClosingBacktickStringStart
		  Self.OpeningBacktickChar = openingBacktickChar
		  Self.FirstClosingBacktickChar = firstClosingBacktickChar
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C6F736573207468697320626C6F636B20616E64206D616B657320616E792066696E616C206368616E6765732074686174206D61792062652072657175697265642E
		Sub Finalise(line As XUITextLine = Nil)
		  /// Closes this block and makes any final changes that may be required.
		  
		  // Calling the overridden superclass method.
		  Super.Finalise(line)
		  
		  Var seenNonSpace As Boolean = False
		  Var iStart As Integer = LocalStart + BacktickStringLength
		  Var iLimit As Integer = ParentClosingBacktickStringStart - 1
		  Var textBlockStart As Integer
		  Var contentsBuffer() As String
		  Var c As MKCharacter
		  
		  For i As Integer = iStart To iLimit
		    If contentsBuffer.Count = 0 Then textBlockStart = i
		    c = Parent.Characters(i)
		    
		    If c.IsLineEnding Then
		      Var s As String = String.FromArray(contentsBuffer, "")
		      If s <> "" Then
		        Children.Add(New MKTextBlock(Self, Parent.Characters(textBlockStart).AbsolutePosition, _
		        Parent.Characters(textBlockStart).LocalPosition, _
		        s, 0, c.Line))
		      End If
		      contentsBuffer.RemoveAll
		      // Add in a soft break
		      Children.Add(New MKSoftBreak(Self, i + 1))
		      
		    ElseIf c.Value = &u0020 Then
		      contentsBuffer.Add(c.Value)
		      
		    Else
		      seenNonSpace = True
		      contentsBuffer.Add(c.Value)
		    End If
		  Next i
		  
		  If contentsBuffer.Count > 0 Then
		    Var s As String = String.FromArray(contentsBuffer, "")
		    Children.Add(New MKTextBlock(Self, Parent.Characters(textBlockStart).AbsolutePosition, _
		    Parent.Characters(textBlockStart).LocalPosition, _
		    s, 0, c.Line))
		  End If
		  
		  If FirstChild <> Nil And FirstChild IsA MKSoftBreak Then Children.RemoveAt(0)
		  If LastChild <> Nil And LastChild IsA MKSoftBreak Then Children.RemoveAt(Children.LastIndex)
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a codespan within a Markdown document.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 546865206C656E677468206F662074686520666C616E6B696E67206261636B7469636B2064656C696D69746572732061726F756E64207468697320636F6465207370616E2E
		BacktickStringLength As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865202866697273742920636C6F73696E67206261636B7469636B206368617261637465722E
		FirstClosingBacktickChar As MarkdownKit.MKCharacter
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 302D626173656420696E64657820696E2060506172656E742E4368617261637465727360207468617420746865206F70656E696E67206261636B7469636B20636861726163746572206F66207468697320636F6465207370616E20626567696E732E
		LocalStart As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206F70656E696E67206261636B7469636B206368617261637465722E
		OpeningBacktickChar As MarkdownKit.MKCharacter
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 302D626173656420696E64657820696E207468697320636F6465207370616E277320706172656E7420706172616772617068277320604368617261637465727360206172726179206F662074686520666972737420636861726163746572206F662074686520636C6F73696E67206261636B7469636B20737472696E672E
		ParentClosingBacktickStringStart As Integer = 0
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
			Name="BacktickStringLength"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParentClosingBacktickStringStart"
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
