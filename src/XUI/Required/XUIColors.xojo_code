#tag Module
Protected Module XUIColors
	#tag Method, Flags = &h1, Description = 52657475726E73206120586F6A6F20436F6C6F7220637265617465642066726F6D20616E20524742412068657820737472696E67206073602E2052616973657320616E2060496E76616C6964417267756D656E74457863657074696F6E6020696620607360206973206E6F742076616C69642E
		Protected Function FromRGBAString(s As String) As Color
		  /// Returns a Xojo Color created from an RGBA hex string `s`.
		  /// Raises an `InvalidArgumentException` if `s` is not valid.
		  ///
		  /// Valid string formats are: `"RGB"`, `"RGBA"`, `"RRGGBB"` and `"RRGGBBAA"`
		  
		  // Correct number of characters?
		  Select Case s.CharacterCount
		  Case Is < 3, 5, 7, Is > 8
		    Raise New InvalidArgumentException("Cannot create a Color from `" + s + "`. It is not a valid hex RGBA string.")
		  End Select
		  
		  // Assert that we only have hex digits in the string.
		  Var chars() As String = s.CharacterArray
		  For Each char As String In chars
		    If Not char.IsHexDigit Then
		      Raise New InvalidArgumentException("`" + char + "` is not a hexadecimal digit.")
		    End If
		  Next char
		  
		  #Pragma BreakOnExceptions False
		  Var red, green, blue, alpha As Integer
		  Try
		    Select Case s.CharacterCount
		    Case 3 // RGB
		      red = Integer.FromHex(s.Left(1) + s.Left(1))
		      green = Integer.FromHex(s.Middle(1, 1) + s.Middle(1, 1))
		      blue = Integer.FromHex(s.Middle(2, 1) + s.Middle(2, 1))
		      alpha = 0
		      
		    Case 4 // RGBA
		      red = Integer.FromHex(s.Left(1) + s.Left(1))
		      green = Integer.FromHex(s.Middle(1, 1) + s.Middle(1, 1))
		      blue = Integer.FromHex(s.Middle(2, 1) + s.Middle(2, 1))
		      alpha = Integer.FromHex(s.Middle(3, 1) + s.Middle(3, 1))
		      
		    Case 6 // RRRGGBB
		      red = Integer.FromHex(s.Middle(0, 1) + s.Middle(1, 1))
		      green = Integer.FromHex(s.Middle(2, 1) + s.Middle(3, 1))
		      blue = Integer.FromHex(s.Middle(4, 1) + s.Middle(5, 1))
		      alpha = 0
		      
		    Case 8 // RRGGBBAA
		      red = Integer.FromHex(s.Middle(0, 1) + s.Middle(1, 1))
		      green = Integer.FromHex(s.Middle(2, 1) + s.Middle(3, 1))
		      blue = Integer.FromHex(s.Middle(4, 1) + s.Middle(5, 1))
		      alpha = Integer.FromHex(s.Middle(6, 1) + s.Middle(7, 1))
		    End Select
		  Catch e
		    Raise New InvalidArgumentException("Cannot create a Color from `" + s + "`. It is not a valid hex RGBA string.")
		  End Try
		  
		  Try
		    Return Color.RGB(red, green, blue, alpha)
		  Catch e
		    Raise New InvalidArgumentException("Cannot create a Color from `" + s + "`. It is not a valid hex RGBA string.")
		  End Try
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		This module contains helper methods for dealing with the Xojo `Color` class.
		
	#tag EndNote


End Module
#tag EndModule
