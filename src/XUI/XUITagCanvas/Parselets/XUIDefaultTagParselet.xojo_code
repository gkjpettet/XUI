#tag Class
Protected Class XUIDefaultTagParselet
Implements XUITagParselet
	#tag Method, Flags = &h0, Description = 52657475726E7320746167206461746120776974682061207469746C65206F662060736020616E64206E6F2061726269747261727920646174612E
		Function Parse(s As String) As XUITagData
		  /// Returns tag data with a title of `s` and no arbitrary data.
		  ///
		  /// Part of the XUITagParselet interface.
		  
		  If s = "" Then Return Nil
		  
		  Return New XUITagData(s, Nil)
		End Function
	#tag EndMethod


End Class
#tag EndClass
