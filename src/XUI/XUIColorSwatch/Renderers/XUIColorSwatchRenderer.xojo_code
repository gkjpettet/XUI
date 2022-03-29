#tag Interface
Protected Interface XUIColorSwatchRenderer
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUIColorSwatch)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732072656E64657265722773206F776E696E6720436F6C6F725377617463682E
		Function Owner() As XUIColorSwatch
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207265636F6D6D656E646564206865696768742028696E20706978656C73292074686520636F6C6F7572207377617463682073686F756C642062652E
		Function RecommendedHeight() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207265636F6D6D656E6465642077696474682028696E20706978656C73292074686520636F6C6F7572207377617463682073686F756C642062652E
		Function RecommendedWidth() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E64657273207468652073776174636820746F207468652070617373656420677261706869637320636F6E746578742E
		Sub Render(g As Graphics)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
