#tag Module
Protected Module XUIColorExtensions
	#tag Method, Flags = &h0, Description = 52657475726E7320606360206173206120736978206469676974205247422068657820737472696E6720696E2074686520666F726D6174205252474742422E
		Function ToRGBString(Extends c As Color) As String
		  /// Returns `c` as a six digit RGB hex string in the format RRGGBB.
		  
		  Return c.Red.ToHex(2).Uppercase + c.Green.ToHex(2).Uppercase + c.Blue.ToHex(2).Uppercase
		  
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
