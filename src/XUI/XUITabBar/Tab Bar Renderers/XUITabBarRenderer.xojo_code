#tag Interface
Protected Interface XUITabBarRenderer
	#tag Method, Flags = &h0, Description = 5468652063757272656E74207769647468206F66207468652062756666657220696E20706F696E74732E
		Function BufferWidth() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 606F776E657260206973207468652060585549546162426172602074686174206F776E7320746869732072656E64657265722E
		Sub Constructor(owner As XUITabBar)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F6620746865206C656674206D656E7520627574746F6E2028696620737570706F7274656420627920746869732072656E6465726572292E
		Function LeftMenuButtonWidth() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E616D65206F6620746869732072656E64657265722E
		Function Name() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207461622062617220746869732072656E6465726572206F70657261746573206F6E2E
		Function Owner() As XUITabBar
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696D61676520746F20626520647261776E20746F207468652074616220626172277320677261706869637320636F6E7465787420696E2069747320605061696E7460206576656E742E
		Sub Render(ownerGraphics As Graphics, scrollPosX As Integer, needsFullRedraw As Boolean = True)
		  
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

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206865696768742074686520746162206261722077696C6C2062652072656E64657265642061742E
		Function TabBarHeight() As Integer
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Tab bars look different on different operating systems and even between different 
		applications on the same operating system. To handle this, `XUITabBar` outsources 
		its appearance to a _Renderer_. Renderers are classes that implement this interface.
		They expose methods to `XUITabBar` to alter its appearance.
		Several example renderers are included with XUI.
		
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
