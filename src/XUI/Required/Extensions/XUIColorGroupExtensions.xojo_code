#tag Module
Protected Module XUIColorGroupExtensions
	#tag Method, Flags = &h0, Description = 49662060636760206861732061206461726B20636F6C6F757220646566696E65642069742069732072657475726E6564206F746865727769736520746865206C6967687420636F6C6F75722069732072657475726E65642E
		Function Dark(Extends cg As ColorGroup) As Color
		  /// If `cg` has a dark colour defined it is returned otherwise the light colour is returned.
		  
		  Var colours() As Color = cg.Values
		  
		  If colours.Count = 1 Then
		    // Only has a light colour defined.
		    Return colours(0)
		  Else
		    Return colours(1)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061206E657720436F6C6F7247726F75702066726F6D206073602E2052616973657320616E2060496E76616C6964417267756D656E74457863657074696F6E602069662060736020697320696E636F72726563746C7920666F726D61747465642E
		Protected Function FromString(s As String) As ColorGroup
		  /// Returns a new ColorGroup from `s`. Raises an `InvalidArgumentException` if `s` is incorrectly formatted.
		  ///
		  /// `s` may be in one of two formats:
		  ///
		  /// `"&hAARRGGBB"` for a single colour.  
		  /// `"&hAARRGGBB, &hAARRGGBB"` for light colour, dark colour.
		  ///
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

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206C6967687420636F6C6F757220636F6D706F6E656E74206F6620606367602E
		Function Light(Extends cg As ColorGroup) As Color
		  /// Returns the light colour component of `cg`.
		  
		  Var colours() As Color = cg.Values
		  
		  Return colours(0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320636F6C6F722067726F757020696E2074686520666F726D61743A206026684141525247474242203A20266841415252474742426020576865726520746865206C6566742076616C756520697320746865206C696768742076616C756520616E64207468652072696768742076616C756520697320746865206461726B2076616C75652E
		Function ToString(Extends cg As ColorGroup) As String
		  /// Returns a string representation of this color group in the format:
		  /// `&hAARRGGBB : &hAARRGGBB`
		  /// Where the left value is the light value and the right value is the dark value.
		  
		  Return cg.Light.ToString + " : " + cg.Dark.ToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E7665727473206063676020746F206120544F4D4C2076616C75652E
		Function ToTOML(Extends cg As ColorGroup) As String
		  /// Converts `cg` to a TOML value.
		  ///
		  /// The resultant string will be in the format:
		  ///
		  /// `"&hAARRGGBB, &hAARRGGBB"` representing light colour, dark colour.
		  ///
		  /// This is the case even if only a single colour is specified (the light colour will be duplicated).
		  
		  Return """" + cg.Light.ToString + ", " + cg.Dark.ToString  + """"
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		This module contains helper methods for dealing with `ColorGroup`s.
		
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
End Module
#tag EndModule
