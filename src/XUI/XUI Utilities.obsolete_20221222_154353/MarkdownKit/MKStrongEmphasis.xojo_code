#tag Class
Protected Class MKStrongEmphasis
Inherits MKAbstractEmphasis
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(parent As MKBlock, absoluteStart As Integer)
		  /// Default constructor.
		  ///
		  /// `parent` is the parent of this block.
		  /// `absoluteStart` is the 0-based position in the original source code of the start of this block.
		  
		  Super.Constructor(MKBlockTypes.StrongEmphasis, parent, absoluteStart)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a run of strong emphasis within a Markdown document.
		
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
