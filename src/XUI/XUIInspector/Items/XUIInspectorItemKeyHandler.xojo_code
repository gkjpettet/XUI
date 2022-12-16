#tag Interface
Protected Interface XUIInspectorItemKeyHandler
	#tag Method, Flags = &h0, Description = 41206B657920636F6D6D616E6420686173206F636375727265642E
		Sub DoCommand(command As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207573657220697320617474656D7074696E6720746F20696E7365727420612073696E676C652063686172616374657220696E746F2074686973206974656D2E
		Sub InsertCharacter(char As String, range As TextRange)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E20612072616E676520666F72206D61634F5320746F20646973706C61792074686520636861726163746572207069636B65722E
		Function RectForRange(range As TextRange) As Xojo.Rect
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Items that handle key strokes should implement this interface.
		
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
End Interface
#tag EndInterface
