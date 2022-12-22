#tag Class
Protected Class MKListBlock
Inherits MKAbstractList
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(parent As MKBlock, blockStart As Integer = 0)
		  /// Default constructor.
		  ///
		  /// - `parent` is the parent of this block.
		  /// - `blockStart` is the 0-based position in the original Markdown source 
		  ///   that this block begins at.
		  
		  Super.Constructor(MKBlockTypes.List, parent, blockStart)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C6F736573207468697320626C6F636B20616E64206D616B657320616E792066696E616C206368616E6765732074686174206D61792062652072657175697265642E
		Sub Finalise(line As XUITextLine = Nil)
		  /// Closes this block and makes any final changes that may be required.
		  
		  Super.Finalise(line)
		  
		  // Determine tight/loose status of the list.
		  Self.ListData.IsTight = True // Tight by default.
		  
		  Var item As MKBlock = Self.FirstChild
		  Var subItem As MKBlock
		  
		  While item <> Nil
		    // Check for a non-final non-empty ListItem ending with blank line.
		    If item.IsLastLineBlank And item.NextSibling <> Nil Then
		      Self.ListData.IsTight = False
		      Exit
		    End If
		    
		    // Recurse into the children of the ListItem, to see if there are spaces between them.
		    subitem = item.FirstChild
		    While subItem <> Nil
		      If subItem.EndsWithBlankLine And (item.NextSibling <> Nil Or subitem.NextSibling <> Nil) Then
		        Self.ListData.IsTight = False
		        Exit
		      End If
		      subItem = subitem.NextSibling
		    Wend
		    
		    If Not Self.ListData.IsTight Then Exit
		    
		    item = item.NextSibling
		  Wend
		  
		  For i As Integer = 0 To Self.Children.LastIndex
		    Self.Children(i).IsChildOfTightList = Self.ListData.IsTight
		  Next i
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a list block within a Markdown document.
		
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
