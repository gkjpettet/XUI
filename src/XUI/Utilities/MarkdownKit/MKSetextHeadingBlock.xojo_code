#tag Class
Protected Class MKSetextHeadingBlock
Inherits MKBlock
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(parent As MKBlock, blockStart As Integer = 0)
		  /// Default constructor.
		  ///
		  /// - `parent` is the parent of this block.
		  /// - `blockStart` is the 0-based position in the original Markdown source 
		  ///   that this block begins at.
		  
		  Super.Constructor(MKBlockTypes.SetextHeading, parent, blockStart)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C6F736573207468697320626C6F636B20616E64206D616B657320616E792066696E616C206368616E6765732074686174206D61792062652072657175697265642E
		Sub Finalise(line As XUITextLine)
		  /// Closes this block and makes any final changes that may be required.
		  
		  // Calling the overridden superclass method.
		  Super.Finalise(line)
		  
		  ParseLinkReferenceDefinitions
		  
		  // Edge case: The setext heading only contained a link reference definition.
		  If Characters.Count = 1 And Characters(0).IsLineEnding Then Characters.RemoveAll
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a setext heading within a Markdown document.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5468697320415458206865616465722773206C6576656C2E
		Level As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4966207468697320626C6F636B20697320612053657465787420686561646572207468656E207468697320697320746865206C656E6774682028696E206368617261637465727329206F66207468652053657465787420756E6465726C696E652E
		UnderlineLength As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620746865206C696E65207468617420746865207365746578742068656164696E6720756E6465726C696E65206973206F6E2E
		UnderlineLineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520302D6261736564206C6F63616C20706F736974696F6E206F6E20746865206C696E65207468617420746865207365746578742068656164696E6720756E6465726C696E6520626567696E732061742E
		UnderlineLocalStart As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 302D626173656420706F736974696F6E20696E20746865206F726967696E616C20736F7572636520636F6465206F662074686520666972737420636861726163746572206F6620612053657465787420756E6465726C696E6520286966207468697320626C6F636B20697320612053657465787420686561646572292E
		UnderlineStart As Integer = 0
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
			Name="Level"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UnderlineLength"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UnderlineStart"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UnderlineLineNumber"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UnderlineLocalStart"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
