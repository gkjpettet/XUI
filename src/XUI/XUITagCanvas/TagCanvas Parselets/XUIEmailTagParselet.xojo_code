#tag Class
Protected Class XUIEmailTagParselet
Implements XUITagParselet
	#tag Method, Flags = &h0, Description = 5061727365732060736020696E746F2061207461672E2049662061207461672063616E6E6F7420626520666F726D6564207468656E204E696C2069732072657475726E65642E
		Function Parse(s As String) As XUITag
		  /// If `s` looks like an email address then returns a tag with a title of `s` and no arbitrary data.
		  ///
		  /// Part of the `XUITagParselet` interface.
		  
		  Var rx As New RegEx
		  rx.SearchPattern = "^([a-zA-Z0-9_\-.\+]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,10})$"
		  
		  Var match As RegExMatch = rx.Search(s)
		  
		  Return If(match <> Nil, New XUITag(s, Nil), Nil)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		If the string passed to this parselet looks like an email address then it will return a tag whose
		title is the email address. If the parselet does not think the string passed is an email address
		then no tag is returned.
		
		The following regular expression is used to determine if the string is an email address or not:
		
		```
		^([a-zA-Z0-9_\-.\+]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,10})$
		```
		
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
