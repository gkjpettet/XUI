#tag Class
Protected Class XUICETheme
	#tag Method, Flags = &h0, Description = 41646473206120746F6B656E207374796C6520746F2074686973207468656D652E
		Sub AddTokenStyle(styleName As String, style As XUICETokenStyle)
		  /// Adds a token style to this theme.
		  ///
		  /// Assumes `styleName` is not empty and `style` is not Nil.
		  
		  Styles.Value(styleName) = style
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4173736572747320746861742060646020697320612076616C696420746F6B656E2064696374696F6E6172792E2052616973657320616E2060496E76616C6964417267756D656E74457863657074696F6E602069662069742773206E6F742E
		Private Shared Sub AssertIsTokenDictionary(d As Dictionary)
		  /// Asserts that `d` is a valid token dictionary.
		  /// Raises an `InvalidArgumentException` if it's not.
		  
		  // The following keys are permitted within a token dictionary:
		  // backgroundColor (ColorGroup string), bold (Boolean), color (ColorGroup string), hasBackgroundColor (Boolean), 
		  // italic (Boolean) and underline (Boolean).
		  // They are all optional but at least one must be specified.
		  
		  Var definedProperties As Integer = 0
		  For Each entry As DictionaryEntry In d
		    Select Case entry.Key
		    Case "backgroundColor"
		      Try
		        Call XUIColorGroups.FromString(entry.Value)
		      Catch e As RuntimeException
		        Raise New InvalidArgumentException("`backgroundColor` must be a Xojo hexademical ColorGroup literal " + _
		        "in the form `&hAARRGGBB` or `&hAARRGGBB, &hAARRGGBB`.")
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
		        Call XUIColorGroups.FromString(entry.Value)
		      Catch e As RuntimeException
		        Raise New InvalidArgumentException("`color` must be a Xojo hexademical ColorGroup literal " + _
		        "in the form `&hAARRGGBB` or `&hAARRGGBB, &hAARRGGBB`.")
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
		    
		  Case TYPE_COLORGROUP
		    #Pragma BreakOnExceptions False
		    Try
		      Call XUIColorGroups.FromString(value)
		      Return
		    Catch e As RuntimeException
		      Raise New InvalidArgumentException("`" + path + "` is not a ColorGroup string.")
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
		  AssertPathType(d, "editor.backgroundColor", TYPE_COLORGROUP)
		  AssertPathType(d, "editor.caretColor", TYPE_COLORGROUP)
		  AssertPathType(d, "editor.currentLineNumberColor", TYPE_COLORGROUP)
		  AssertPathType(d, "editor.lineNumberColor", TYPE_COLORGROUP)
		  AssertPathType(d, "editor.selectionColor", TYPE_COLORGROUP)
		  Var editor As Dictionary = d.Value("editor")
		  
		  // Optional.
		  If editor.HasKey("blockLineColor") Then AssertPathType(d, "editor.blockLineColor", TYPE_COLORGROUP)
		  If editor.HasKey("currentLineHighlightColor") Then
		    AssertPathType(d, "editor.currentLineHighlightColor", TYPE_COLORGROUP)
		  End If
		  If editor.HasKey("unmatchedBlockLineColor") Then
		    AssertPathType(d, "editor.unmatchedBlockLineColor", TYPE_COLORGROUP)
		  End If
		  If editor.HasKey("debugLineColor") Then
		    AssertPathType(d, "editor.debugLineColor", TYPE_COLORGROUP)
		  End If
		  
		  // ======================
		  // SCROLLBARS DICTIONARY
		  // ======================
		  // Required properties.
		  AssertPathType(d, "scrollbars", TYPE_DICTIONARY)
		  AssertPathType(d, "scrollbars.backgroundColor", TYPE_COLORGROUP)
		  AssertPathType(d, "scrollbars.borderColor", TYPE_COLORGROUP)
		  AssertPathType(d, "scrollbars.thumbColor", TYPE_COLORGROUP)
		  
		  // ======================
		  // DELIMITERS DICTIONARY
		  // ======================
		  // The delimiters dictionary is optional.
		  If d.HasKey("delimiters") Then
		    AssertPathType(d, "delimiters", TYPE_DICTIONARY)
		    Var delim As Dictionary = d.Value("delimiters")
		    If delim.HasKey("hasBorderColor") Then AssertPathType(d, "delimiters.hasBorderColor", TYPE_BOOLEAN)
		    If delim.HasKey("borderColor") Then AssertPathType(d, "delimiters.borderColor", TYPE_COLORGROUP)
		    If delim.HasKey("hasFillColor") Then AssertPathType(d, "delimiters.hasFillColor", TYPE_BOOLEAN)
		    If delim.HasKey("fillColor") Then AssertPathType(d, "delimiters.fillColor", TYPE_COLORGROUP)
		    If delim.HasKey("hasUnderlineColor") Then AssertPathType(d, "delimiters.hasUnderlineColor", TYPE_BOOLEAN)
		    If delim.HasKey("underlineColor") Then AssertPathType(d, "delimiters.underlineColor", TYPE_COLORGROUP)
		  End If
		  
		  // =======================
		  // AUTOCOMPLETE DICTIONARY
		  // =======================
		  // Required properties.
		  AssertPathType(d, "autocomplete", TYPE_DICTIONARY)
		  Var autocomplete As Dictionary = d.Value("autocomplete")
		  
		  // Required popup styling.
		  AssertPathType(d, "autocomplete.hasPopupBorder", TYPE_BOOLEAN)
		  AssertPathType(d, "autocomplete.popupBackgroundColor", TYPE_COLORGROUP)
		  AssertPathType(d, "autocomplete.popupBorderColor", TYPE_COLORGROUP)
		  AssertPathType(d, "autocomplete.optionColor", TYPE_COLORGROUP)
		  AssertPathType(d, "autocomplete.selectedOptionBackgroundColor", TYPE_COLORGROUP)
		  AssertPathType(d, "autocomplete.selectedOptionColor", TYPE_COLORGROUP)
		  
		  // Required prefix styling.
		  AssertPathType(d, "autocomplete.prefix", TYPE_DICTIONARY)
		  AssertIsTokenDictionary(autocomplete.Value("prefix"))
		  AssertPathType(d, "autocomplete.prefix.color", TYPE_COLORGROUP)
		  
		  // Optional.
		  If autocomplete.HasKey("horizontalPadding") Then
		    AssertPathType(d, "autocomplete.horizontalPadding", TYPE_INTEGER)
		  End If
		  If autocomplete.HasKey("optionVerticalPadding") Then 
		    AssertPathType(d, "autocomplete.optionVerticalPadding", TYPE_INTEGER)
		  End If
		  If autocomplete.HasKey("popupBorderRadius") Then
		    AssertPathType(d, "autocomplete.popupBorderRadius", TYPE_INTEGER)
		  End If
		  If autocomplete.HasKey("verticalPadding") Then
		    AssertPathType(d, "autocomplete.verticalPadding", TYPE_INTEGER)
		  End If
		  
		  // ======================
		  // TOKENS DICTIONARY
		  // ======================
		  // Required properties.
		  AssertPathType(d, "tokens", TYPE_DICTIONARY)
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_COMMENT, TYPE_DICTIONARY)
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_DEFAULT, TYPE_DICTIONARY)
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_ERROR, TYPE_DICTIONARY)
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_IDENTIFIER, TYPE_DICTIONARY)
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_KEYWORD, TYPE_DICTIONARY)
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_NUMBER, TYPE_DICTIONARY)
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_OPERATOR, TYPE_DICTIONARY)
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_STRING, TYPE_DICTIONARY)
		  
		  Var tokens As Dictionary = d.Value("tokens")
		  AssertIsTokenDictionary(tokens.Value(XUICELineToken.TYPE_COMMENT))
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_COMMENT + ".color", TYPE_COLORGROUP)
		  
		  AssertIsTokenDictionary(tokens.Value(XUICELineToken.TYPE_DEFAULT))
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_DEFAULT + ".color", TYPE_COLORGROUP)
		  
		  AssertIsTokenDictionary(tokens.Value(XUICELineToken.TYPE_ERROR))
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_ERROR + ".color", TYPE_COLORGROUP)
		  
		  AssertIsTokenDictionary(tokens.Value(XUICELineToken.TYPE_IDENTIFIER))
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_IDENTIFIER + ".color", TYPE_COLORGROUP)
		  
		  AssertIsTokenDictionary(tokens.Value(XUICELineToken.TYPE_KEYWORD))
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_KEYWORD + ".color", TYPE_COLORGROUP)
		  
		  AssertIsTokenDictionary(tokens.Value(XUICELineToken.TYPE_NUMBER))
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_NUMBER + ".color", TYPE_COLORGROUP)
		  
		  AssertIsTokenDictionary(tokens.Value(XUICELineToken.TYPE_OPERATOR))
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_OPERATOR + ".color", TYPE_COLORGROUP)
		  
		  AssertIsTokenDictionary(tokens.Value(XUICELineToken.TYPE_STRING))
		  AssertPathType(d, "tokens." + XUICELineToken.TYPE_STRING + ".color", TYPE_COLORGROUP)
		  
		  // All other top-level values in `tokens` must be dictionaries.
		  For Each entry As DictionaryEntry In tokens
		    AssertIsTokenDictionary(entry.Value)
		  Next entry
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor()
		  /// Default constructor.
		  
		  Styles = _
		  New Dictionary("default" : New XUICETokenStyle, "autocompletePrefix" : New XUICETokenStyle)
		  
		  // Initialise all ColorGroups to prevent Nil object exceptions in themes that don't stipulate them.
		  Me.AutocompleteOptionColor = New ColorGroup(Color.Black, Color.Black)
		  Me.AutocompletePopupBackgroundColor = New ColorGroup(Color.Black, Color.Black)
		  Me.AutocompletePopupBorderColor = New ColorGroup(Color.Black, Color.Black)
		  Me.BackgroundColor = New ColorGroup(Color.Black, Color.Black)
		  Me.BlockLineColor = New ColorGroup(Color.Black, Color.Black)
		  Me.CaretColor = New ColorGroup(Color.Black, Color.Black)
		  Me.CurrentLineHighlightColor = New ColorGroup(Color.Black, Color.Black)
		  Me.CurrentLineNumberColor = New ColorGroup(Color.Black, Color.Black)
		  Me.DelimitersBorderColor = New ColorGroup(Color.Black, Color.Black)
		  Me.DelimitersFillColor = New ColorGroup(Color.Black, Color.Black)
		  Me.DelimitersUnderlineColor = New ColorGroup(Color.Black, Color.Black)
		  Me.LineNumberColor = New ColorGroup(Color.Black, Color.Black)
		  Me.SelectedAutocompleteOptionBackgroundColor = New ColorGroup(Color.Black, Color.Black)
		  Me.SelectedAutocompleteOptionColor = New ColorGroup(Color.Black, Color.Black)
		  Me.SelectionColor = New ColorGroup(Color.Black, Color.Black)
		  Me.ScrollbarBackgroundColor = New ColorGroup(Color.Black, Color.Black)
		  Me.ScrollbarBorderColor = New ColorGroup(Color.Black, Color.Black)
		  Me.ScrollbarThumbColor = New ColorGroup(Color.Black, Color.Black)
		  Me.UnmatchedBlockLineColor = New ColorGroup(Color.Black, Color.Black)
		  Me.DebugLineColor = New ColorGroup(Color.Black, Color.Black)
		  
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
		  theme.Version = New XUISemanticVersion(meta.Value("version").StringValue)
		  theme.Author = meta.Value("author")
		  
		  // Optional meta values.
		  theme.Description = meta.Lookup("description", "")
		  
		  // =================
		  // EDITOR PROPERTIES
		  // =================
		  Var editor As Dictionary = d.Value("editor")
		  
		  // Required editor properties.
		  theme.BackgroundColor = XUIColorGroups.FromString(editor.Value("backgroundColor"))
		  theme.CaretColor = XUIColorGroups.FromString(editor.Value("caretColor"))
		  theme.CurrentLineNumberColor = XUIColorGroups.FromString(editor.Value("currentLineNumberColor"))
		  theme.LineNumberColor = XUIColorGroups.FromString(editor.Value("lineNumberColor"))
		  theme.SelectionColor = XUIColorGroups.FromString(editor.Value("selectionColor"))
		  
		  // Optional editor properties.
		  theme.BlockLineColor = XUIColorGroups.FromString(editor.Lookup("blockLineColor", _
		  New ColorGroup(DEFAULT_BLOCK_LINE_COLOR_LIGHT, DEFAULT_BLOCK_LINE_COLOR_LIGHT)))
		  theme.CurrentLineHighlightColor = _
		  XUIColorGroups.FromString(editor.Lookup("currentLineHighlightColor", _
		  New ColorGroup(DEFAULT_CURRENT_LINE_HIGHLIGHT_COLOR_LIGHT, DEFAULT_CURRENT_LINE_HIGHLIGHT_COLOR_DARK)))
		  theme.UnmatchedBlockLineColor = _
		  XUIColorGroups.FromString(editor.Lookup("unmatchedBlockLineColor", _
		  New ColorGroup(DEFAULT_UNMATCHED_BLOCK_LINE_COLOR_LIGHT, DEFAULT_UNMATCHED_BLOCK_LINE_COLOR_DARK)))
		  theme.DebugLineColor = _
		  XUIColorGroups.FromString(editor.Lookup("debugLineColor", _
		  New ColorGroup(DEFAULT_DEBUG_LINE_COLOR_LIGHT, DEFAULT_DEBUG_LINE_COLOR_DARK)))
		  
		  // =================
		  // SCROLLBARS
		  // =================
		  Var scrollbars As Dictionary = d.Value("scrollbars")
		  theme.ScrollbarBackgroundColor = XUIColorGroups.FromString(scrollbars.Value("backgroundColor"))
		  theme.ScrollbarBorderColor = XUIColorGroups.FromString(scrollbars.Value("borderColor"))
		  theme.ScrollbarThumbColor = XUIColorGroups.FromString(scrollbars.Value("thumbColor"))
		  
		  // =================
		  // DELIMITERS
		  // =================
		  // The delimiters dictionary is optional.
		  If d.HasKey("delimiters") Then
		    Var delim As Dictionary = d.Value("delimiters")
		    If delim.HasKey("hasBorderColor") Then theme.DelimitersHaveBorder = delim.Value("hasBorderColor")
		    If delim.HasKey("borderColor") Then
		      theme.DelimitersBorderColor = XUIColorGroups.FromString(delim.Value("borderColor"))
		    End If
		    If delim.HasKey("hasFillColor") Then theme.DelimitersHaveFillColor = delim.Value("hasFillColor")
		    If delim.HasKey("fillColor") Then
		      theme.DelimitersFillColor = XUIColorGroups.FromString(delim.Value("fillColor"))
		    End If
		    If delim.HasKey("hasUnderlineColor") Then theme.DelimitersHaveUnderline = delim.Value("hasUnderlineColor")
		    If delim.HasKey("underlineColor") Then
		      theme.DelimitersUnderlineColor = XUIColorGroups.FromString(delim.Value("underlineColor"))
		    End If
		  End If
		  
		  // =================
		  // AUTOCOMPLETE
		  // =================
		  // Required autocomplete properties.
		  Var autocomplete As Dictionary = d.Value("autocomplete")
		  theme.HasAutocompletePopupBorder = autocomplete.Value("hasPopupBorder")
		  theme.AutocompletePopupBackgroundColor = _
		  XUIColorGroups.FromString(autocomplete.Value("popupBackgroundColor"))
		  theme.AutocompletePopupBorderColor = _
		  XUIColorGroups.FromString(autocomplete.Value("popupBorderColor"))
		  theme.AutocompleteOptionColor = _
		  XUIColorGroups.FromString(autocomplete.Value("optionColor"))
		  theme.SelectedAutocompleteOptionBackgroundColor = _
		  XUIColorGroups.FromString(autocomplete.Value("selectedOptionBackgroundColor"))
		  theme.SelectedAutocompleteOptionColor = _
		  XUIColorGroups.FromString(autocomplete.Value("selectedOptionColor"))
		  
		  // Prefix styles
		  Var autocompletePrefix As Dictionary = autocomplete.Value("prefix")
		  theme.AddTokenStyle("autocompletePrefix", New XUICETokenStyle(autocompletePrefix))
		  
		  // Optional autocomplete properties.
		  If autocomplete.HasKey("horizontalPadding") Then
		    theme.AutocompleteHorizontalPadding = autocomplete.Value("horizontalPadding")
		  End If
		  If autocomplete.HasKey("optionVerticalPadding") Then 
		    theme.AutocompleteOptionVerticalPadding = autocomplete.Value("optionVerticalPadding")
		  End If
		  If autocomplete.HasKey("popupBorderRadius") Then
		    theme.AutocompletePopupBorderRadius = autocomplete.Value("popupBorderRadius")
		  End If
		  If autocomplete.HasKey("verticalPadding") Then
		    theme.AutocompleteVerticalPadding = autocomplete.Value("verticalPadding")
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

	#tag Method, Flags = &h0, Description = 52656D6F76657320746865207374796C6520607374796C654E616D65602066726F6D2074686973207468656D65206966206974206578697374732E2052657475726E732054727565206966207375636365737366756C206F722046616C7365206966207468657265206973206E6F74207374796C6520776974682074686174206E616D652E
		Function RemoveTokenStyle(styleName As String) As Boolean
		  /// Removes the style `styleName` from this theme if it exists. Returns True if successful or False if 
		  /// there is not style with that name.
		  
		  // Forbid removing the essential "default" and "autocompletePrefix" styles.
		  If styleName <> "default" And styleName <> "autocompletePrefix" And Styles.HasKey(styleName) Then
		    Styles.Remove(styleName)
		    Return True
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207374796C6520776974682074686520737065636966696564206E616D65206F72204E696C20696620697420646F65736E27742065786973742E
		Function StyleForName(styleName As String) As XUICETokenStyle
		  /// Returns the style with the specified name or Nil if it doesn't exist.
		  
		  Return Styles.Lookup(styleName, Nil)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865207374796C6520746F2075736520666F72207468652070617373656420746F6B656E20747970652E
		Function StyleForToken(token As XUICELineToken) As XUICETokenStyle
		  /// Returns the style to use for the passed token type.
		  ///
		  /// If the requested primary style is not found then we try the fallback style. If that's not found 
		  /// we return the default style.
		  
		  If Styles.HasKey(token.Type) Then
		    Return Styles.Value(token.Type)
		  Else
		    Return Styles.Lookup(token.FallbackType, DefaultStyle)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StyleNames() As String()
		  /// Returns an array of all the styles defined in this theme.
		  
		  Var names() As String
		  For Each entry As DictionaryEntry In Styles
		    names.Add(entry.Key)
		  Next entry
		  
		  Return names
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E76657274732074686973207468656D6520746F20544F4D4C20746861742063616E206265207772697474656E20746F206469736B2E
		Function ToTOML() As String
		  /// Converts this theme to TOML that can be written to disk.
		  
		  Var s() As String
		  
		  // =========================
		  // META
		  // =========================
		  s.Add("[meta]")
		  s.Add("name = " + GenerateJSON(Self.Name))
		  s.Add("version = " + Self.Version.ToJSON)
		  s.Add("author = " + GenerateJSON(Self.Author))
		  s.Add("description = " + GenerateJSON(Self.Description))
		  
		  s.Add("")
		  
		  // =========================
		  // EDITOR
		  // =========================
		  s.Add("[editor]")
		  
		  // backgroundColor
		  s.Add("backgroundColor = " + Self.BackgroundColor.ToTOML)
		  
		  // blockLineColor
		  s.Add("blockLineColor = " + Self.BlockLineColor.ToTOML)
		  
		  // caretColor
		  s.Add("caretColor = " + Self.CaretColor.ToTOML)
		  
		  // currentLineHighlightColor
		  s.Add("currentLineHighlightColor = " + Self.CurrentLineHighlightColor.ToTOML)
		  
		  // currentLineNumberColor
		  s.Add("currentLineNumberColor = " + Self.CurrentLineNumberColor.ToTOML)
		  
		  // lineNumberColor
		  s.Add("lineNumberColor = " + Self.LineNumberColor.ToTOML)
		  
		  // selectionColor
		  s.Add("selectionColor = " + Self.SelectionColor.ToTOML)
		  
		  // unmatchedBlockLineColor
		  s.Add("unmatchedBlockLineColor = " + Self.UnmatchedBlockLineColor.ToTOML)
		  
		  // debugLineColor
		  s.Add("debugLineColor = " + Self.DebugLineColor.ToTOML)
		  
		  s.Add("")
		  
		  // =========================
		  // SCROLLBARS
		  // =========================
		  s.Add("[scrollbars]")
		  
		  // backgroundColor
		  s.Add("backgroundColor = " + Self.ScrollbarBackgroundColor.ToTOML)
		  
		  // borderColor
		  s.Add("borderColor = " + Self.ScrollbarBorderColor.ToTOML)
		  
		  // thumbColor
		  s.Add("thumbColor = " + Self.ScrollbarThumbColor.ToTOML)
		  
		  s.Add("")
		  
		  // =========================
		  // DELIMITERS
		  // =========================
		  s.Add("[delimiters]")
		  
		  // hasBorderColor
		  s.Add("hasBorderColor = " + GenerateJSON(Self.DelimitersHaveBorder))
		  
		  // borderColor
		  s.Add("borderColor = " + Self.DelimitersBorderColor.ToTOML)
		  
		  // hasFillColor
		  s.Add("hasFillColor = " + GenerateJSON(Self.DelimitersHaveFillColor))
		  
		  // fillColor
		  s.Add("fillColor = " + Self.DelimitersFillColor.ToTOML)
		  
		  // hasUnderlineColor
		  s.Add("hasUnderlineColor = " + GenerateJSON(Self.DelimitersHaveUnderline))
		  
		  // underlineColor
		  s.Add("underlineColor = " + Self.DelimitersUnderlineColor.ToTOML)
		  
		  s.Add("")
		  
		  // =========================
		  // AUTOCOMPLETE
		  // =========================
		  s.Add("[autocomplete]")
		  
		  // hasPopupBorder
		  s.Add("hasPopupBorder = " + GenerateJSON(Self.HasAutocompletePopupBorder))
		  
		  // popupBackgroundColor
		  s.Add("popupBackgroundColor = " + Self.AutocompletePopupBackgroundColor.ToTOML)
		  
		  // popupBorderColor
		  s.Add("popupBorderColor = " + Self.AutocompletePopupBorderColor.ToTOML)
		  
		  // optionColor
		  s.Add("optionColor = " + Self.AutocompleteOptionColor.ToTOML)
		  
		  // selectedOptionBackgroundColor
		  s.Add("selectedOptionBackgroundColor = " + Self.SelectedAutocompleteOptionBackgroundColor.ToTOML)
		  
		  // selectedOptionColor
		  s.Add("selectedOptionColor = " + Self.SelectedAutocompleteOptionColor.ToTOML)
		  
		  // horizontalPadding
		  s.Add("horizontalPadding = " + Self.AutocompleteHorizontalPadding.ToString)
		  
		  // optionVerticalPadding
		  s.Add("optionVerticalPadding = " + Self.AutocompleteOptionVerticalPadding.ToString)
		  
		  // popupBorderRadius
		  s.Add("popupBorderRadius = " + Self.AutocompletePopupBorderRadius.ToString)
		  
		  // verticalPadding
		  s.Add("verticalPadding = " + Self.AutocompleteVerticalPadding.ToString)
		  
		  s.Add("")
		  
		  // =========================
		  // AUTOCOMPLETE PREFIX STYLE
		  // =========================
		  s.Add("[autocomplete.prefix]")
		  s.Add(AutocompletePrefixStyle.ToTOML)
		  
		  s.Add("")
		  s.Add("###################")
		  s.Add("# TOKENS")
		  s.Add("###################")
		  
		  // =========================
		  // TOKEN STYLES
		  // =========================
		  For Each entry As DictionaryEntry In Styles
		    Var name As String = entry.Key
		    Var style As XUICETokenStyle = entry.Value
		    If name <> "autocompletePrefix" Then // Already added this above.
		      s.Add("[tokens." + name + "]")
		      s.Add(style.ToToml)
		      s.Add("")
		    End If
		  Next entry
		  
		  If s(s.LastIndex) = "" Then Call s.Pop
		  
		  Return String.FromArray(s, &u0A)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		One of the the most powerful features offered by the `XUICodeEditor` is the ability to
		customise its appearance. This is done through themes that are represented by 
		the `XUICETheme` class.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686973207468656D65277320617574686F722E
		Author As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F2070616420746F20746865206C65667420616E64207269676874206F66206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		AutocompleteHorizontalPadding As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66207468652074657874206F6620756E73656C6563746564206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		AutocompleteOptionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F766520616E642062656C6F77206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		AutocompleteOptionVerticalPadding As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220746865206261636B67726F756E64206F6620746865206175746F636F6D706C65746520706F7075702E
		AutocompletePopupBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620746865206175746F636F6D706C65746520706F70757020686173206120626F72646572207468656E20746869732069732069747320636F6C6F75722E
		AutocompletePopupBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520626F7264657220726164697573206F6620746865206175746F636F6D706C65746520706F7075702E
		AutocompletePopupBorderRadius As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207374796C6520746F2075736520666F7220746865206175746F636F6D706C6574696F6E207072656669782E
		#tag Getter
			Get
			  Return Styles.Value("autocompletePrefix")
			End Get
		#tag EndGetter
		AutocompletePrefixStyle As XUICETokenStyle
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620706978656C7320746F207061642061626F76652074686520666972737420616E642062656C6F7720746865206C617374206175746F636F6D706C657465206F7074696F6E7320696E20746865206175746F636F6D706C65746520706F7075702E
		AutocompleteVerticalPadding As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F722074686520656469746F722773206261636B67726F756E642E
		BackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220626C6F636B206C696E65732E
		BlockLineColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520656469746F7227732063617265742E
		CaretColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520746F20686967686C69676874207468652063757272656E74206C696E6520696E2074686520656469746F722028696620656E61626C6564292E
		CurrentLineHighlightColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865206C696E65206E756D626572206F66207468652063757272656E74206C696E652E
		CurrentLineNumberColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520746F20686967686C696768742061206C696E652074686174206973206265696E672064656275676765642E
		DebugLineColor As ColorGroup
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
		DelimitersBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662064726177696E672063757272656E742064656C696D697465727320616E64206044656C696D69746572734861766546696C6C436F6C6F72203D205472756560207468656E20746869732069732074686520636F6C6F7572207468656972206261636B67726F756E642077696C6C2062652E
		DelimitersFillColor As ColorGroup
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
		DelimitersUnderlineColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41206465736372697074696F6E206F662074686973207468656D652E
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5472756520696620746865206175746F636F6D706C65746520706F70757020686173206120626F726465722E
		HasAutocompletePopupBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865206C696E65206E756D626572732E
		LineNumberColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973207468656D652773206E616D652E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865206261636B67726F756E64206F6620746865207363726F6C6C62617220747261636B2E204F6E6C792072656C6576616E74206F6E2057696E646F777320616E64204C696E75782E
		ScrollbarBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F662074686520626F72646572206F6620746865207363726F6C6C62617220747261636B2E204F6E6C792072656C6576616E74206F6E2057696E646F777320616E64204C696E75782E
		ScrollbarBorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F6620746865207468756D62206F6620746865207363726F6C6C62617220747261636B2E204F6E6C792072656C6576616E74206F6E2057696E646F777320616E64204C696E75782E
		ScrollbarThumbColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206261636B67726F756E6420636F6C6F757220666F72207468652063757272656E746C792073656C6563746564206F7074696F6E20696E20746865206175746F636F6D706C65746520706F7075702E
		SelectedAutocompleteOptionBackgroundColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F7572206F66207468652074657874206F66207468652063757272656E746C792073656C6563746564206F7074696F6E20696E20746865206175746F636F6D706C65746520706F7075702E
		SelectedAutocompleteOptionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220746865206261636B67726F756E64206F662073656C656374656420746578742E
		SelectionColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686973207468656D652773207374796C65732E204B6579203D205374796C65206E616D652C2056616C7565203D204D4345546F6B656E5374796C652E
		Private Styles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6C6F757220746F2075736520666F7220626C6F636B206C696E657320746861742061726520756E6D6174636865642E
		UnmatchedBlockLineColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973207468656D6527732076657273696F6E2E
		Version As XUISemanticVersion
	#tag EndProperty


	#tag Constant, Name = DEFAULT_BLOCK_LINE_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&cD6D6D6", Scope = Private, Description = 546865206C69676874206D6F64652064656661756C7420636F6C6F757220666F7220626C6F636B206C696E6573206966206E6F6E652069732070726F766964656420627920746865207468656D652E
	#tag EndConstant

	#tag Constant, Name = DEFAULT_CURRENT_LINE_HIGHLIGHT_COLOR_DARK, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Private, Description = 546865206461726B206D6F64652064656661756C7420636F6C6F757220666F72207468652063757272656E74206C696E6520686967686C69676874206966206E6F6E652069732070726F766964656420627920746865207468656D652E
	#tag EndConstant

	#tag Constant, Name = DEFAULT_CURRENT_LINE_HIGHLIGHT_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&cFFFFFF", Scope = Private, Description = 546865206C69676874206D6F64652064656661756C7420636F6C6F757220666F72207468652063757272656E74206C696E6520686967686C69676874206966206E6F6E652069732070726F766964656420627920746865207468656D652E
	#tag EndConstant

	#tag Constant, Name = DEFAULT_DEBUG_LINE_COLOR_DARK, Type = Color, Dynamic = False, Default = \"&c919191", Scope = Private, Description = 546865206461726B206D6F64652064656661756C7420636F6C6F757220666F72207468652063757272656E74206C696E6520686967686C69676874206966206E6F6E652069732070726F766964656420627920746865207468656D652E
	#tag EndConstant

	#tag Constant, Name = DEFAULT_DEBUG_LINE_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&cC0C0C0", Scope = Private, Description = 546865206461726B206D6F64652064656661756C7420636F6C6F757220666F72207468652063757272656E74206C696E6520686967686C69676874206966206E6F6E652069732070726F766964656420627920746865207468656D652E
	#tag EndConstant

	#tag Constant, Name = DEFAULT_UNMATCHED_BLOCK_LINE_COLOR_DARK, Type = Color, Dynamic = False, Default = \"&cFF2600", Scope = Private, Description = 546865206461726B206D6F64652064656661756C7420636F6C6F757220666F7220756E6D61746368656420626C6F636B206C696E6573206966206E6F6E652069732070726F766964656420627920746865207468656D652E
	#tag EndConstant

	#tag Constant, Name = DEFAULT_UNMATCHED_BLOCK_LINE_COLOR_LIGHT, Type = Color, Dynamic = False, Default = \"&cFF2600", Scope = Private, Description = 546865206C69676874206D6F64652064656661756C7420636F6C6F757220666F7220756E6D61746368656420626C6F636B206C696E6573206966206E6F6E652069732070726F766964656420627920746865207468656D652E
	#tag EndConstant

	#tag Constant, Name = TYPE_ARRAY, Type = String, Dynamic = False, Default = \"array", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
	#tag EndConstant

	#tag Constant, Name = TYPE_BOOLEAN, Type = String, Dynamic = False, Default = \"boolean", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
	#tag EndConstant

	#tag Constant, Name = TYPE_COLOR, Type = String, Dynamic = False, Default = \"color", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
	#tag EndConstant

	#tag Constant, Name = TYPE_COLORGROUP, Type = String, Dynamic = False, Default = \"colorGroup", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
	#tag EndConstant

	#tag Constant, Name = TYPE_DATETIME, Type = String, Dynamic = False, Default = \"datetime", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
	#tag EndConstant

	#tag Constant, Name = TYPE_DICTIONARY, Type = String, Dynamic = False, Default = \"dictionary", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
	#tag EndConstant

	#tag Constant, Name = TYPE_DOUBLE, Type = String, Dynamic = False, Default = \"double", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
	#tag EndConstant

	#tag Constant, Name = TYPE_INTEGER, Type = String, Dynamic = False, Default = \"integer", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
	#tag EndConstant

	#tag Constant, Name = TYPE_NIL, Type = String, Dynamic = False, Default = \"nil", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
	#tag EndConstant

	#tag Constant, Name = TYPE_STRING, Type = String, Dynamic = False, Default = \"string", Scope = Private, Description = 496E7465726E616C6C792075736564207768656E20617373657274696E672069662061207468656D652069732076616C69642E
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
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentLineHighlightColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentLineNumberColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineNumberColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelimitersBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelimitersFillColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
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
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BlockLineColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UnmatchedBlockLineColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="ColorGroup"
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
			Name="ScrollbarBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollbarBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollbarThumbColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompleteVerticalPadding"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompleteHorizontalPadding"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompleteOptionVerticalPadding"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasAutocompletePopupBorder"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompletePopupBorderColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompletePopupBorderRadius"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompletePopupBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedAutocompleteOptionBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedAutocompleteOptionColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutocompleteOptionColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugLineColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
