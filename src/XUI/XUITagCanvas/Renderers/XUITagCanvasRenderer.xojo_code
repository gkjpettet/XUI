#tag Interface
Protected Interface XUITagCanvasRenderer
	#tag Method, Flags = &h0, Description = 54686520737567676573746564206E756D626572206F6620706978656C7320746F2070616420746F20746865206C65667420616E64207269676874206F66206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		Function AutocompleteHorizontalPadding() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520686569676874206F6620616E206175746F636F6D706C657465206F7074696F6E20696E20746865206175746F636F6D706C65746520706F7075702E
		Function AutocompleteOptionHeight() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520737567676573746564206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F77206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		Function AutocompleteOptionVerticalPadding() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520626F7264657220726164697573206F6620746865206175746F636F6D706C65746520706F7075702E
		Function AutocompletePopupBorderRadius() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F76652074686520666972737420616E642062656C6F7720746865206C61737420206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		Function AutocompleteVerticalPadding() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E20696D616765206F6620616C6C206175746F636F6D706C657465206F7074696F6E7320666F722072656E646572696E6720746F20746865206175746F636F6D706C65746520706F7075702E
		Function ImageForAutocompletePopup(maxWidth As Integer, selectedIndex As Integer) As Picture
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Owner() As XUITagCanvas
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320607461676020746F206067602061742060782C2079602E2052657475726E7320746865207820636F6F7264696E6174652061742074686520666172207269676874206F66207468652072656E6465726564207461672E
		Function Render(tag As XUITag, g As Graphics, x As Integer, y As Integer, hasDingus As Boolean) As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520686569676874206F662061207461672E
		Function TagHeight(g As Graphics) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520737567676573746564206E756D626572206F6620706978656C7320746F20706164206569746865722073696465206F66207461677320696E20746865207461672063616E7661732E
		Function TagHorizontalPadding() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520737567676573746564206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F77207461677320696E20746865207461672063616E7661732E
		Function TagVerticalPadding() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70757465732074686520746F74616C207769647468206F6620607461676020696620647261776E20746F207468652073706563696669656420677261706869637320636F6E74657874206067602E
		Function TagWidth(tag As XUITag, g As Graphics) As Double
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Responsible for rendering tag data into a visible tag.
		
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
