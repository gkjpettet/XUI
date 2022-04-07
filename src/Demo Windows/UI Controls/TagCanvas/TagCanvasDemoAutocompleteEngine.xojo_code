#tag Class
Protected Class TagCanvasDemoAutocompleteEngine
	#tag Method, Flags = &h0, Description = 4164647320616E206F7074696F6E20776974682074686520737065636966696564206063617074696F6E6020616E642074616720646174612E
		Sub AddOption(value As String, tagData As XUITagData)
		  /// Adds an option with the specified `value` and tag data.
		  /// 
		  /// Raises an `InvalidArgumentException` if the engine already contains a matching value.
		  
		  If tagData = Nil Then 
		    Raise New InvalidArgumentException("Cannot add option to the autocomplete engine as `tagData` is Nil.")
		  End If
		  
		  // Disallow adding a value if the engine already knows about it.
		  For Each option As XUITagAutocompleteOption In mOptions
		    If IsCaseSensitive Then
		      If value.Compare(option.Value, ComparisonOptions.CaseSensitive) = 0 Then 
		        Raise New InvalidArgumentException("Cannot add '" + value + "' " + _
		        "to the autocomplete engine as it already exists in it.")
		      End If
		    Else
		      If value = option.Value Then
		        Raise New InvalidArgumentException("Cannot add '" + value + "' " + _
		        "to the autocomplete engine as it already exists in it.")
		      End If
		    End If
		  Next option
		  
		  mOptions.Add(New XUITagAutocompleteOption(value, tagData))
		  
		  // Our basic autocomplete engine requires the options array to be sorted alphabetically in order to 
		  // determine the longest common prefix. This is really inefficient. We should probably use a binary tree 
		  // or something else but this will do for demonstration purposes.
		  mOptions.Sort(AddressOf OptionsSortDelegate)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496620606361736553656E73697469766560207468656E2074686520656E67696E652073686F756C6420726573706563742063617365207768656E206F66666572696E672073756767657374696F6E732E
		Sub Constructor(caseSensitive As Boolean)
		  /// If `caseSensitive` then the engine should respect case when offering suggestions.
		  
		  Self.IsCaseSensitive = caseSensitive
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206175746F636F6D706C657465206461746120666F722074686520676976656E207072656669782E
		Function DataForPrefix(prefix As String) As XUITagAutocompleteData
		  /// Returns autocomplete data for the given prefix.
		  
		  Var data As New XUITagAutocompleteData
		  data.Prefix = prefix
		  
		  For Each option As XUITagAutocompleteOption In mOptions
		    If option.Value.Length >= prefix.Length Then
		      If Self.IsCaseSensitive Then
		        If option.Value.Left(prefix.Length).IsExactly(prefix) Then
		          data.Options.Add(option)
		        End If
		      Else
		        If option.Value.Left(prefix.Length) = prefix Then
		          data.Options.Add(option)
		        End If
		      End If
		    End If
		  Next option
		  
		  // Compute the longest common prefix.
		  // See: https://www.educative.io/edpresso/how-to-find-the-longest-common-prefix-in-an-array-of-strings
		  If data.Options.Count = 0 Then
		    data.LongestCommonPrefix = ""
		  ElseIf data.Options.Count = 1 Then
		    data.LongestCommonPrefix = data.Options(0).Value
		  Else
		    Var first() As String = data.Options(0).Value.Split("")
		    Var last() As String = data.Options(data.Options.LastIndex).Value.Split("")
		    Var iMax As Integer = first.LastIndex
		    For i As Integer = 0 To iMax
		      If first(i) = last(i) Then
		        data.LongestCommonPrefix = data.LongestCommonPrefix + first(i)
		      Else
		        Exit
		      End If
		    Next i
		  End If
		  
		  // We've computed the longest prefix but we need to remove the triggering
		  // prefix string from its beginning.
		  data.LongestCommonPrefix = data.LongestCommonPrefix.Replace(prefix, "")
		  
		  Return data
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620616C6C206175746F636F6D706C657465206F7074696F6E73206B6E6F776E20746F2074686520656E67696E652C20736F7274656420616C7068616265746963616C6C792E
		Function Options() As XUITagAutocompleteOption()
		  /// Returns an array of all autocomplete options known to the engine, sorted alphabetically.
		  ///
		  /// We return a new array with cloned objects so they can be modified
		  /// without fear of messing up the engine.
		  
		  Var opts() As XUITagAutocompleteOption
		  
		  For Each option As XUITagAutocompleteOption In mOptions
		    opts.Add(option.Clone)
		  Next option
		  
		  Return opts
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C6567617465206D6574686F6420666F7220736F7274696E6720616E206172726179206F66206175746F636F6D706C657465206F7074696F6E7320696E20617363656E64696E6720616C7068616265746963616C206F726465722E
		Private Function OptionsSortDelegate(option1 As XUITagAutocompleteOption, option2 As XUITagAutocompleteOption) As Integer
		  /// Delegate method for sorting an array of autocomplete options in ascending alphabetical order.
		  ///
		  /// - Returns:
		  ///   option1 > option2: +1
		  ///   option1 = option2: 0
		  ///   option1 < option2: -1
		  
		  Return option1.Value.Compare(option2.Value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616E792073756767657374696F6E7320696E2074686520656E67696E652074686174206D617463682074686520676976656E207072656669782E20436173652073656E7369746976652E
		Sub RemoveAllWithPrefix(prefix As String)
		  /// Removes any suggestions in the engine that match the given prefix. Case sensitive.
		  /// 
		  /// All suggestions with this exact prefix will be removed.
		  
		  Var iMax As Integer = mOptions.LastIndex
		  Var removed() As String
		  For i As Integer = iMax DownTo 0
		    If mOptions(i).Value.BeginsWith(prefix, ComparisonOptions.CaseSensitive) Then
		      Removed.Add(mOptions(i).Value)
		      mOptions.RemoveAt(i)
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 49662074686520656E67696E6520636F6E7461696E7320746865206578616374207061737365642076616C75652069742069732072656D6F7665642E20436173652073656E7369746976652E
		Sub RemoveOption(value As String)
		  /// If the engine contains the exact passed value it is removed. Case sensitive.
		  
		  Var iMax As Integer = mOptions.LastIndex
		  For i As Integer = 0 To iMax
		    If mOptions(i).Value.Compare(value, ComparisonOptions.CaseSensitive) = 0 Then
		      mOptions.RemoveAt(i)
		      Exit
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265736574732074686520656E67696E652062792072656D6F76696E6720616C6C2073756767657374696F6E732E
		Sub Reset()
		  /// Resets the engine by removing all suggestions.
		  
		  mOptions.RemoveAll
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5472756520696620746865206175746F636F6D706C65746520656E67696E652073686F756C6420726573706563742063617365207768656E2070726F766964696E672073756767657374696F6E732E
		IsCaseSensitive As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 416E206172726179206F66206B6E6F776E206175746F636F6D706C657465206F7074696F6E732E
		Private mOptions() As XUITagAutocompleteOption
	#tag EndProperty


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
		#tag ViewProperty
			Name="IsCaseSensitive"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
