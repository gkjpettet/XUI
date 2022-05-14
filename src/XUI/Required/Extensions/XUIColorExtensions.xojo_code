#tag Module
Protected Module XUIColorExtensions
	#tag Method, Flags = &h0, Description = 52657475726E732074686520636F6D706C656D656E7461727920286F70706F736974652920636F6C6F7220746F206063602E
		Function Complementary(Extends c As Color) As Color
		  /// Returns the complementary (opposite) color to `c`.
		  
		  Return Color.RGB(255 - c.Red, 255 - c.Green, 255 - c.Blue)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320606360206173206120736978206469676974205247422068657820737472696E6720696E2074686520666F726D61742060525247474242602E
		Function ToRGBString(Extends c As Color) As String
		  /// Returns `c` as a six digit RGB hex string in the format `RRGGBB`.
		  
		  Return c.Red.ToHex(2).Uppercase + c.Green.ToHex(2).Uppercase + c.Blue.ToHex(2).Uppercase
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A module containing extension methods for the native Xojo `Color` type.
		
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
End Module
#tag EndModule
