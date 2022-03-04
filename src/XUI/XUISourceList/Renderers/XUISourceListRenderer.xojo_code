#tag Interface
Protected Interface XUISourceListRenderer
	#tag Method, Flags = &h0, Description = 52656E646572732074686520736F75726365206C697374206261636B67726F756E6420666F72207468697320656D70747920726F772E
		Sub RenderBackground(g As Graphics, style As XUISourceListStyle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E646572732074686520706173736564206974656D20617320612073656374696F6E20746F207468652073706563696669656420677261706869637320636F6E746578742E
		Sub RenderItem(item As XUISourceListItem, g As Graphics, style As XUISourceListStyle, selected As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732074686520686569676874206F66206120726F7720696E2074686520736F75726365206C6973742E
		Function RowHeight() As Integer
		  
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
End Interface
#tag EndInterface
