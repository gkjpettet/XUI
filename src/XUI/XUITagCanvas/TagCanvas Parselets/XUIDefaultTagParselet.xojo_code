#tag Class
Protected Class XUIDefaultTagParselet
Implements XUITagParselet
	#tag Method, Flags = &h0, Description = 5061727365732060736020696E746F2061207461672E2049662061207461672063616E6E6F7420626520666F726D6564207468656E204E696C2069732072657475726E65642E
		Function Parse(s As String) As XUITag
		  /// Returns a tag with a title of `s` and no arbitrary data.
		  ///
		  /// Part of the `XUITagParselet` interface.
		  
		  If s = "" Then Return Nil
		  
		  Return New XUITag(s, Nil)
		End Function
	#tag EndMethod


	#tag Note, Name = About
		This parselet creates a tag from any string passed to it. This is the simplest parselet possible.
		
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
