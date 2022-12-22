#tag Class
Protected Class MKListItemBlock
Inherits MKAbstractList
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(parent As MKBlock, blockStart As Integer = 0)
		  /// Default constructor.
		  ///
		  /// - `parent` is the parent of this block.
		  /// - `blockStart` is the 0-based position in the original Markdown source 
		  ///   that this block begins at.
		  
		  Super.Constructor(MKBlockTypes.ListItem, parent, blockStart)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a list block item within a Markdown document.
		
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
