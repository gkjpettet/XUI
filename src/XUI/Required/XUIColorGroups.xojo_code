#tag Module
Protected Module XUIColorGroups
	#tag Method, Flags = &h1, Description = 52657475726E732061206E657720436F6C6F7247726F75702066726F6D206073602E2052616973657320616E2060496E76616C6964417267756D656E74457863657074696F6E602069662060736020697320696E636F72726563746C7920666F726D61747465642E
		Protected Function FromString(s As String) As ColorGroup
		  /// Returns a new ColorGroup from `s`. Raises an `InvalidArgumentException` if `s` is incorrectly formatted.
		  ///
		  /// `s` may be in one of two formats:
		  ///   &hAARRGGBB  (single colour)
		  ///   &hAARRGGBB, &hAARRGGBB (light colour, dark colour).
		  /// Optional spaces are permitted after the comma and flanking `s`.
		  
		  // Flanking whitespace is permitted.
		  s = s.Trim
		  
		  // Get the colours.
		  Var colours() As String = s.Split(",")
		  
		  // Trim the individual colours.
		  For i As Integer = 0 To colours.LastIndex
		    colours(i) = colours(i).Trim
		  Next i
		  
		  // A maximum of two colours are permitted.
		  If colours.Count > 2 Then
		    Raise New InvalidArgumentException("Invalid ColorGroup string format `" + s + "`.")
		  End If
		  
		  // Get the light colour.
		  Var light As Color
		  Try
		    light = Color.FromString(colours(0))
		  Catch e
		    Raise New InvalidArgumentException(colours(0) + " is not a valid Xojo hexadecimal Color literal.")
		  End Try
		  
		  If colours.Count = 1 Then Return New ColorGroup(light)
		  
		  // Get the dark colour.
		  Var dark As Color
		  Try
		    dark = Color.FromString(colours(1))
		  Catch e
		    Raise New InvalidArgumentException(colours(1) + " is not a valid Xojo hexadecimal Color literal.")
		  End Try
		  
		  Return New ColorGroup(light, dark)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		This module contains helper methods for dealing with ColorGroups.
		
	#tag EndNote


End Module
#tag EndModule
