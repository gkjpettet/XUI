#tag Interface
Protected Interface XUITabBarRenderer
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITabBar2)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F6620746865206C656674206D656E7520627574746F6E2028696620737570706F7274656420627920746869732072656E6465726572292E
		Function LeftMenuButtonWidth() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207461622062617220746869732072656E6465726572206F70657261746573206F6E2E
		Function Owner() As XUITabBar2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E64657273207468652074616220626172206261636B67726F756E642E
		Sub RenderBackground(g As Graphics)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F6620746865207269676874206D656E7520627574746F6E2028696620737570706F7274656420627920746869732072656E6465726572292E
		Function RightMenuButtonWidth() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620746869732072656E646572657220737570706F7274732074686520636F6E63657074206F662061206C656674206D656E7520627574746F6E2E
		Function SupportsLeftMenuButton() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620746869732072656E646572657220737570706F7274732074686520636F6E63657074206F662061207269676874206D656E7520627574746F6E2E
		Function SupportsRightMenuButton() As Boolean
		  
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
