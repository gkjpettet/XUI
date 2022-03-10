#tag Interface
Protected Interface XUISourceListRenderer
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUISourceList)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520736F75726365206C69737420746869732072656E6465726572206F70657261746573206F6E2E
		Function Owner() As XUISourceList
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4472617720746865206261636B67726F756E6420666F72207468652073706563696669656420726F772E2054686520726F77206D617920626520656D7074792E
		Sub RenderBackground(g As Graphics, row As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320606974656D6020746F207468652070617373656420677261706869637320636F6E746578742E2054686520636F6E746578742069732074686520656E7469726520726F7720746865206974656D206F636375706965732E
		Sub RenderItem(item As XUISourceListItem, g As Graphics, hoveringOverRow As Boolean, isSelected As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520686569676874206F66206120726F7720696E2074686520736F75726365206C6973742E
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
