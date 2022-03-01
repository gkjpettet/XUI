#tag Class
Protected Class XUICETheme
	#tag Method, Flags = &h0, Description = 41646473206120746F6B656E207374796C6520746F2074686973207468656D652E
		Sub AddTokenStyle(styleName As String, style As XUICETokenStyle)
		  /// Adds a token style to this theme.
		  ///
		  /// Assumes [styleName] is not empty and [style] is not Nil.
		  
		  Self.Styles.Value(styleName) = style
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4173736572747320746861742060646020697320612076616C696420746F6B656E2064696374696F6E6172792E2052616973657320616E2060496E76616C6964417267756D656E74457863657074696F6E602069662069742773206E6F742E
		Private Shared Sub AssertIsTokenDictionary(d As Dictionary)
		  /// Asserts that `d` is a valid token dictionary.
		  /// Raises an `InvalidArgumentException` if it's not.
		  
		  // The following keys are permitted within a token dictionary:
		  // backgroundColor (Color), bold (Boolean), color (Color), hasBackgroundColor (Color), 
		  // italic (Boolean) and underline (Boolean).
		  // They are all optional but at least one must be specified.
		  
		  Var definedProperties As Integer = 0
		  For Each entry As DictionaryEntry In d
		    Select Case entry.Key
		    Case "backgroundColor"
		      Try
		        Call Color.FromString(entry.Value)
		      Catch e As RuntimeException
		        Raise New InvalidArgumentException("`backgroundColor` must be a Xojo Color literal in the form `&hAARRGGBB`.")
		      End Try
		      definedProperties = definedProperties + 1
		      
		    Case "bold"
		      If entry.Value.Type <> Variant.TypeBoolean Then
		        Raise New InvalidArgumentException("`bold` must be a boolean value.")
		      End If
		      definedProperties = definedProperties + 1
		      
		    Case "color"
		      #Pragma BreakOnExceptions False
		      Try
		        Call Color.FromString(entry.Value)
		      Catch e As RuntimeException
		        Raise New InvalidArgumentException("`color` must be a Xojo Color literal in the form `&hAARRGGBB`.")
		      End Try
		      #Pragma BreakOnExceptions Default
		      definedProperties = definedProperties + 1
		      
		    Case "hasBackgroundColor"
		      If entry.Value.Type <> Variant.TypeBoolean Then
		        Raise New InvalidArgumentException("`hasBackgroundColor` must be a boolean value.")
		      End If
		      definedProperties = definedProperties + 1
		      
		    Case "italic"
		      If entry.Value.Type <> Variant.TypeBoolean Then
		        Raise New InvalidArgumentException("`italic` must be a boolean value.")
		      End If
		      definedProperties = definedProperties + 1
		      
		    Case "underline"
		      If entry.Value.Type <> Variant.TypeBoolean Then
		        Raise New InvalidArgumentException("`underline` must be a boolean value.")
		      End If
		      definedProperties = definedProperties + 1
		      
		    Else
		      Raise New InvalidArgumentException("Unknown key/value in token dictionary (" + entry.Key + ").")
		    End Select
		  Next entry
		  
		  If definedProperties = 0 Then
		    Raise New InvalidArgumentException("At least one token style key/value must be specified.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4173736572747320746861742060646020636F6E7461696E732060706174686020616E6420746865207465726D696E616C206B6579206F66206070617468602069732074686520636F7272656374206074797065602E2052616973657320616E2060496E76616C6964417267756D656E74457863657074696F6E60206966206E6F742E
		Private Shared Sub AssertPathType(d As Dictionary, path As String, type As String)
		  /// Asserts that `d` contains `path` and the terminal key of `path` is the correct `type`.
		  /// Raises an `InvalidArgumentException` if not.
		  
		  If d = Nil Then Raise New InvalidArgumentException("The passed dictionary is Nil.")
		  
		  // Split the path into the absolute path and the terminal key.
		  Var components() As String = path.Split(".")
		  Var key As String = components.Pop
		  
		  Var currentPath As String
		  Var tmpDict As Dictionary = d
		  For Each component As String In components
		    currentPath = currentPath + component
		    If tmpDict.HasKey(component) Then
		      tmpDict = tmpDict.Value(component)
		    Else
		      Raise New InvalidArgumentException("`" + currentPath + "' does not exist.")
		    End If
		    If tmpDict IsA Dictionary = False Then
		      Raise New InvalidArgumentException("`" + currentPath + "' is not a dictionary.")
		    End If
		    currentPath = currentPath + "."
		  Next component
		  currentPath = currentPath.TrimRight(".")
		  
		  If Not tmpDict.HasKey(key) Then
		    Raise New InvalidArgumentException("`" + currentPath + "." + key + "' does not exist.")
		  End If
		  
		  Var value As Variant = tmpDict.Value(key)
		  Select Case type
		  Case TYPE_ARRAY
		    If Not value.IsArray Then
		      Raise New InvalidArgumentException("`" + path + "` is not an array.")
		    Else
		      Return
		    End If
		    
		  Case TYPE_BOOLEAN
		    If value.Type <> Variant.TypeBoolean Then
		      Raise New InvalidArgumentException("`" + path + "` is not a boolean.")
		    Else
		      Return
		    End If
		    
		  Case TYPE_COLOR
		    #Pragma BreakOnExceptions False
		    Try
		      Call Color.FromString(value)
		      Return
		    Catch e As RuntimeException
		      Raise New InvalidArgumentException("`" + path + "` is not a color literal.")
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		  Case TYPE_DATETIME
		    If value.Type <> Variant.TypeDateTime Then
		      Raise New InvalidArgumentException("`" + path + "` is not a DateTime.")
		    Else
		      Return
		    End If
		    
		  Case TYPE_DICTIONARY
		    If value IsA Dictionary = False Then
		      Raise New InvalidArgumentException("`" + path + "` is not a dictionary.")
		    Else
		      Return
		    End If
		    
		  Case TYPE_DOUBLE
		    If value.Type <> Variant.TypeDouble Then
		      Raise New InvalidArgumentException("`" + path + "` is not a double.")
		    Else
		      Return
		    End If
		    
		  Case TYPE_INTEGER
		    Select Case value.Type
		    Case Variant.TypeInt32, Variant.TypeInt64
		      Return
		    Else
		      Raise New InvalidArgumentException("`" + path + "` is not an integer.")
		    End Select
		    
		  Case TYPE_NIL
		    If value Is Nil = False Then
		      Raise New InvalidArgumentException("`" + path + "` is not Nil.")
		    Else
		      Return
		    End If
		    
		  Case TYPE_STRING
		    If value.Type <> Variant.TypeString Then
		      Raise New InvalidArgumentException("`" + path + "` is not a string literal.")
		    Else
		      Return
		    End If
		    
		  Else
		    Raise New InvalidArgumentException("Unknown value type `" + type + "`.")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4173736572747320746861742060646020636F6E7461696E73207468652072657175697265642070726F7065727469657320666F7220612076616C6964207468656D652E2052616973657320616E2060496E76616C6964417267756D656E74457863657074696F6E60206966206E6F742E
		Private Shared Sub AssertValidThemeDictionary(d As Dictionary)
		  /// Asserts that `d` contains the required properties for a valid theme. 
		  /// Raises an `InvalidArgumentException` if not.
		  
		  // ======================
		  // META DICTIONARY
		  // ======================
		  // Required.
		  AssertPathType(d, "meta", TYPE_DICTIONARY)
		  AssertPathType(d, "meta.name", TYPE_STRING)
		  AssertPathType(d, "meta.version", TYPE_STRING)
		  AssertPathType(d, "meta.author", TYPE_STRING)
		  Var meta As Dictionary = d.Value("meta")
		  
		  // Optional.
		  If meta.HasKey("description") Then AssertPathType(d, "meta.description", TYPE_STRING)
		  
		  // ======================
		  // EDITOR DICTIONARY
		  // ======================
		  // Required properties.
		  AssertPathType(d, "editor", TYPE_DICTIONARY)
		  AssertPathType(d, "editor.backgroundColor", TYPE_COLOR)
		  AssertPathType(d, "editor.caretColor", TYPE_COLOR)
		  AssertPathType(d, "editor.currentLineNumberColor", TYPE_COLOR)
		  AssertPathType(d, "editor.lineNumberColor", TYPE_COLOR)
		  AssertPathType(d, "editor.selectionColor", TYPE_COLOR)
		  Var editor As Dictionary = d.Value("editor")
		  
		  // Optional.
		  If editor.HasKey("blockLineColor") Then AssertPathType(d, "editor.blockLineColor", TYPE_COLOR)
		  If editor.HasKey("currentLineHighlightColor") Then
		    AssertPathType(d, "editor.currentLineHighlightColor", TYPE_COLOR)
		  End If
		  If editor.HasKey("unmatchedBlockLineColor") Then
		    AssertPathType(d, "editor.unmatchedBlockLineColor", TYPE_COLOR)
		  End If
		  
		  // ======================
		  // DELIMITERS DICTIONARY
		  // ======================
		  // The delimiters dictionary is optional.
		  If d.HasKey("delimiters") Then
		    AssertPathType(d, "delimiters", TYPE_DICTIONARY)
		    Var delim As Dictionary = d.Value("delimiters")
		    If delim.HasKey("hasBorderColor") Then AssertPathType(d, "delimiters.hasBorderColor", TYPE_BOOLEAN)
		    If delim.HasKey("borderColor") Then AssertPathType(d, "delimiters.borderColor", TYPE_COLOR)
		    If delim.HasKey("hasFillColor") Then AssertPathType(d, "delimiters.hasFillColor", TYPE_BOOLEAN)
		    If delim.HasKey("fillColor") Then AssertPathType(d, "delimiters.fillColor", TYPE_COLOR)
		    If delim.HasKey("hasUnderlineColor") Then AssertPathType(d, "delimiters.hasUnderlineColor", TYPE_BOOLEAN)
		    If delim.HasKey("underlineColor") Then AssertPathType(d, "delimiters.underlineColor", TYPE_COLOR)
		  End If
		  
		  // ======================
		  // TOKENS DICTIONARY
		  // ======================
		  // Required properties.
		  AssertPathType(d, "tokens", TYPE_DICTIONARY)
		  AssertPathType(d, "tokens.default", TYPE_DICTIONARY)
		  
		  Var tokens As Dictionary = d.Value("tokens")
		  AssertIsTokenDictionary(tokens.Value("default"))
		  AssertPathType(d, "tokens.default.color", TYPE_COLOR)
		  
		  // All other top-level values in `tokens` must be dictionaries.
		  For Each entry As DictionaryEntry In tokens
		    AssertIsTokenDictionary(entry.Value)
		  Next entry
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Styles = New Dictionary("default" : New XUICETokenStyle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732061207468656D6520636F6E73747275637465642066726F6D20612076616C696461746564207468656D652064696374696F6E617279206064602E
		Private Shared Function CreateTheme(d As Dictionary) As XUICETheme
		  /// Returns a theme constructed from a validated theme dictionary `d`.
		  ///
		  /// Assumes that `d` has already been validated using `AssertValidThemeDictionary`.
		  
		  Var theme As New XUICETheme
		  
		  // =================
		  // META
		  // =================
		  Var meta As Dictionary = d.Value("meta")
		  
		  // Required meta values.
		  theme.Name = meta.Value("name")
		  theme.Version = meta.Value("version")
		  theme.Author = meta.Value("author")
		  
		  // Optional meta values.
		  theme.Description = meta.Lookup("description", "")
		  
		  // =================
		  // EDITOR PROPERTIES
		  // =================
		  Var editor As Dictionary = d.Value("editor")
		  
		  // Required editor properties.
		  theme.BackgroundColor = editor.Value("backgroundColor")
		  theme.CaretColor = editor.Value("caretColor")
		  theme.CurrentLineNumberColor = editor.Value("currentLineNumberColor")
		  theme.LineNumberColor = editor.Value("lineNumberColor")
		  theme.SelectionColor = editor.Value("selectionColor")
		  
		  // Optional editor properties.
		  theme.BlockLineColor = editor.Lookup("blockLineColor", DEFAULT_BLOCK_LINE_COLOR)
		  theme.CurrentLineHighlightColor = _
		  editor.Lookup("currentLineHighlightColor", DEFAULT_CURRENT_LINE_HIGHLIGHT_COLOR)
		  theme.UnmatchedBlockLineColor = _
		  editor.Lookup("unmatchedBlockLineColor", DEFAULT_UNMATCHED_BLOCK_LINE_COLOR)
		  
		  // =================
		  // DELIMITERS
		  // =================
		  // The delimiters dictionary is optional.
		  If d.HasKey("delimiters") Then
		    Var delim As Dictionary = d.Value("delimiters")
		    If delim.HasKey("hasBorderColor") Then theme.DelimitersHaveBorder = delim.Value("hasBorderColor")
		    If delim.HasKey("borderColor") Then theme.DelimitersBorderColor = delim.Value("borderColor")
		    If delim.HasKey("hasFillColor") Then theme.DelimitersHaveFillColor = delim.Value("hasFillColor")
		    If delim.HasKey("fillColor") Then theme.DelimitersFillColor = delim.Value("fillColor")
		    If delim.HasKey("hasUnderlineColor") Then theme.DelimitersHaveUnderline = delim.Value("hasUnderlineColor")
		    If delim.HasKey("underlineColor") Then theme.DelimitersUnderlineColor = delim.Value("underlineColor")
		  End If
		  
		  // =================
		  // TOKENS
		  // =================
		  Var tokens As Dictionary = d.Value("tokens")
		  For Each entry As DictionaryEntry In tokens
		    Var tokenDict As Dictionary = entry.Value
		    theme.AddTokenStyle(entry.Key, New XUICETokenStyle(tokenDict))
		  Next entry
		  
		  Return theme
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4C6F6164732061207468656D652066726F6D206120544F4D4C207468656D652066696C652E
		Shared Function FromFile(f As FolderItem) As XUICETheme
		  /// Loads a theme from a TOML theme file.
		  
		  // Sanity checks.
		  If f = Nil Then Raise New NilObjectException("The theme file is Nil.")
		  If Not f.Exists Then
		    Raise New InvalidArgumentException("The theme file (" + f.NativePath + ") does not exist.")
		  End If
		  If f.IsFolder Then
		    Raise New InvalidArgumentException(f.NativePath + " is a folder not a theme file.")
		  End If
		  If Not f.IsReadable Then
		    Raise New InvalidArgumentException("The theme file (" + f.NativePath + ") is not readable.")
		  End If
		  
		  // Get the file contents.
		  Var toml As String
		  Try
		    Var tin As TextInputStream = TextInputStream.Open(f)
		    toml = tin.ReadAll
		    tin.Close
		  Catch e As IOException
		    Raise New IOException("Unable to open the theme file for reading.")
		  End Try
		  
		  // Parse the TOML into a dictionary
		  Var themeDict As Dictionary
		  Try
		    themeDict = ParseTOML(toml)
		  Catch e As TOMLKit.TKException
		    Raise New InvalidArgumentException("The theme file is invalid. " + e.Message)
		  End Try
		  
		  // Validate the theme dictionary.
		  Try
		    AssertValidThemeDictionary(themeDict)
		  Catch e As InvalidArgumentException
		    Raise New InvalidArgumentException("The theme file is invalid. " + e.Message)
		  End Try
		  
		  Return CreateTheme(themeDict)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207374796C6520746F2075736520666F72207468652070617373656420746F6B656E20747970652E
		Function StyleForToken(token As XUICELineToken) As XUICETokenStyle
		  /// Returns the style to use for the passed token type.
		  ///
		  /// If the requested token type style is not found then the default style is returned.
		  
		  Return Styles.Lookup(token.Type, DefaultStyle)
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686973207468656D65277320617574686F722E
		Author As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F722074686520656469746F722773206261636B67726F756E642E
		BackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220626C6F636B206C696E65732E
		BlockLineColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520656469746F7227732063617265742E
		CaretColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520746F20686967686C69676874207468652063757272656E74206C696E6520696E2074686520656469746F722028696620656E61626C6564292E
		CurrentLineHighlightColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865206C696E65206E756D626572206F66207468652063757272656E74206C696E652E
		CurrentLineNumberColor As Color
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652064656661756C7420746F6B656E207374796C652E
		#tag Getter
			Get
			  Return Styles.Value("default")
			End Get
		#tag EndGetter
		DefaultStyle As XUICETokenStyle
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 49662064726177696E672063757272656E742064656C696D697465727320616E64206044656C696D697465727348617665426F72646572436F6C6F7260203D205472756560207468656E20746869732069732074686520636F6C6F7572206F6620746865697220626F726465722E
		DelimitersBorderColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662064726177696E672063757272656E742064656C696D697465727320616E64206044656C696D69746572734861766546696C6C436F6C6F72203D205472756560207468656E20746869732069732074686520636F6C6F7572207468656972206261636B67726F756E642077696C6C2062652E
		DelimitersFillColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E207768656E207468652063757272656E742064656C696D69746572732061726520647261776E20746865792073686F756C642068617665206120626F72646572206F6620636F6C6F72206044656C696D6974657273426F72646572436F6C6F72602E
		DelimitersHaveBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E207768656E2064726177696E67207468652063757272656E742064656C696D69746572732C20746865792073686F756C6420686176652061206261636B67726F756E642066696C6C20636F6C6F72206F66206044656C696D697465727346696C6C436F6C6F72602E
		DelimitersHaveFillColor As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E207768656E207468652063757272656E742064656C696D69746572732061726520647261776E20746865792073686F756C6420626520756E6465726C696E65642077697468206044656C696D6974657273556E6465726C696E65436F6C6F72602E
		DelimitersHaveUnderline As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662064726177696E672063757272656E742064656C696D697465727320616E64206044656C696D697465727348617665556E6465726C696E6560203D205472756560207468656E20746869732069732074686520636F6C6F7572206F662074686520756E6465726C696E652E
		DelimitersUnderlineColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41206465736372697074696F6E206F662074686973207468656D652E
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865206C696E65206E756D626572732E
		LineNumberColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973207468656D652773206E616D652E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220746865206261636B67726F756E64206F662073656C656374656420746578742E
		SelectionColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973207468656D652773207374796C65732E204B6579203D205374796C65206E616D652C2056616C7565203D204D4345546F6B656E5374796C652E
		Styles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220626C6F636B206C696E657320746861742061726520756E6D6174636865642E
		UnmatchedBlockLineColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973207468656D6527732076657273696F6E2E
		Version As String
	#tag EndProperty


	#tag Constant, Name = DEFAULT_BLOCK_LINE_COLOR, Type = Color, Dynamic = False, Default = \"&cD6D6D6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DEFAULT_CURRENT_LINE_HIGHLIGHT_COLOR, Type = Color, Dynamic = False, Default = \"&cFFFFFF", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DEFAULT_UNMATCHED_BLOCK_LINE_COLOR, Type = Color, Dynamic = False, Default = \"&cFF2600", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_ARRAY, Type = String, Dynamic = False, Default = \"array", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_BOOLEAN, Type = String, Dynamic = False, Default = \"boolean", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_COLOR, Type = String, Dynamic = False, Default = \"color", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_DATETIME, Type = String, Dynamic = False, Default = \"datetime", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_DICTIONARY, Type = String, Dynamic = False, Default = \"dictionary", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_DOUBLE, Type = String, Dynamic = False, Default = \"double", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_INTEGER, Type = String, Dynamic = False, Default = \"integer", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_NIL, Type = String, Dynamic = False, Default = \"nil", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_STRING, Type = String, Dynamic = False, Default = \"string", Scope = Private
	#tag EndConstant


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
			Name="BackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentLineHighlightColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentLineNumberColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineNumberColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelimitersBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelimitersFillColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelimitersHaveBorder"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelimitersHaveFillColor"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelimitersHaveUnderline"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelimitersUnderlineColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BlockLineColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UnmatchedBlockLineColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Author"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
