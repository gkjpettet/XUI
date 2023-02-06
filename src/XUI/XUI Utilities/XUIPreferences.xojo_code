#tag Class
Protected Class XUIPreferences
	#tag Method, Flags = &h0
		Sub Constructor(shouldAutoSave As Boolean = False)
		  mPreferences = ParseJSON("{}") // Case-sensitive dictionary.
		  Self.AutoSave = shouldAutoSave
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520707265666572656E63657320617320544F4D4C2E
		Function Dump() As String
		  /// Returns the preferences as TOML.
		  
		  If mPreferences <> Nil Then
		    Return GenerateTOML(mPreferences)
		  Else
		    Return ""
		  End If
		  
		  Exception e As RuntimeException
		    Raise New InvalidArgumentException("One or more of the values cannot be converted to TOML.")
		    
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652076616C7565206F662074686520707265666572656E6365206E616D6564205B6E616D655D2E
		Function Get(name As String) As Variant
		  /// Returns the value of the preference named [name].
		  ///
		  /// Raises a KeyNotFoundException if there is no preference named [name].
		  /// Allows the look up of preferences using this syntax:
		  ///
		  /// ```xojo
		  ///  Var top As Integer = Preferences.Get("MainWindowTop")
		  /// ```
		  
		  If mPreferences.HasKey(name) Then
		    Return mPreferences.Value(name)
		  Else
		    Raise New KeyNotFoundException("There is no key named `" + name + "`.")
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732054727565206966207468657265206973206120707265666572656E63652077697468206E616D65205B6B65795D206F722046616C7365206966206E6F742E
		Function HasKey(key As String) As Boolean
		  /// Returns True if there is a preference with name [key] or False if not.
		  
		  Return mPreferences.HasKey(key)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4C6F6164732061204A534F4E20707265666572656E6365732066696C652E
		Sub Load(prefsFile As FolderItem)
		  /// Loads a TOML preferences file.
		  ///
		  /// Raises the following exceptions:
		  /// - NilObjectException if the passed preferences file is Nil.
		  /// - IOException if we can't create or read the preferences file.
		  /// - TKException if the passed preference file contains invalid TOML.
		  ///
		  /// If [prefsFile] doesn't exist then a new empty file is created.
		  
		  If prefsFile = Nil Then
		    Raise New NilObjectException("Cannot load a Nil preferences file.")
		  Else
		    mPreferencesFile = prefsFile
		  End If
		  
		  // If the preferences file doesn't exist then create an empty text file.
		  If Not mPreferencesFile.Exists Then
		    Var tout As TextOutputStream 
		    Try
		      tout = TextOutputStream.Create(mPreferencesFile)
		      tout.Encoding = Encodings.UTF8
		      tout.Close
		    Catch e As IOException
		      Raise New IOException("Unable to create a new preferences file.")
		    End Try
		  End If
		  
		  // Open the file for reading.
		  Var tin As TextInputStream
		  Var data As String
		  Try
		    tin = TextInputStream.Open(mPreferencesFile)
		    tin.Encoding = Encodings.UTF8
		    
		    // Get the TOML contents of the file.
		    data = tin.ReadAll
		    
		    tin.Close
		  Catch e As IOException
		    Raise New IOException("Unable to open the preferences file for reading.")
		  End Try
		  
		  // Attempt to parse the contents of the file into a Dictionary.
		  mPreferences = ParseTOML(data)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652076616C7565206F662074686520707265666572656E6365206E616D6564205B6E616D655D206F722072657475726E73207468652064656661756C742076616C7565207370656369666965642E
		Function Lookup(name As String, default As Variant) As Variant
		  /// Returns the value of the preference named [name] or returns the default value specified.
		  ///
		  /// [default] is the value to return if there is no preference with the specified name.
		  ///
		  
		  Return mPreferences.Lookup(name, default)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416C6C6F7773207468652072657472696576616C206F66206120707265666572656E6365206E616D6564205B6E616D655D207573696E672074686520646F74206F70657261746F722E
		Function Operator_Lookup(name As String) As Variant
		  /// Allows the retrieval of a preference named [name] using the dot operator.
		  ///
		  /// Raises a KeyNotFoundException if there is no preference named [name].
		  ///
		  /// Allows the look up of a preference using this syntax:
		  ///
		  /// ```xojo
		  /// Var top As Integer = Preferences.MainWindowTop
		  /// ```
		  
		  Return Get(name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416C6C6F7773207468652073657474696E67206F66206120707265666572656E636527732076616C7565207573696E67207468652061737369676E6D656E74206F70657261746F722E
		Sub Operator_Lookup(name As String, Assigns value As Variant)
		  /// Allows the setting of a preference's value using the assignment operator.
		  ///
		  /// [name] is the name of the preference whose value should be set. Will be created if required.
		  ///
		  /// Sets a preference using this syntax:
		  ///
		  /// ```xojo
		  /// Preferences.MainWindowTop = 345
		  /// ```
		  
		  Set(name) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53617665732074686520707265666572656E63657320746F206469736B20617320544F4D4C2E2052657475726E73205472756520696620746865207361766520776173207375636365737366756C206F722046616C7365206966206E6F742E
		Function Save() As Boolean
		  /// Saves the preferences to disk as TOML. Returns True if the save was successful or False if not.
		  
		  // If we don't have a preferences file then we can't save obviously.
		  If mPreferencesFile = Nil Then Return False
		  
		  // Convert the preferences Dictionary to TOML.
		  Var data As String = GenerateTOML(mPreferences)
		  
		  // Create an output stream to write to.
		  Var tout As TextOutputStream = TextOutputStream.Create(mPreferencesFile)
		  tout.Encoding = Encodings.UTF8
		  
		  // Write the TOML.
		  tout.Write(data)
		  
		  // Close the stream.
		  tout.Close
		  
		  // Success.
		  Return True
		  
		  Exception err As InvalidArgumentException
		    // Unable to convert one of the values in the preferences Dictionary to a TOML value
		    Return False
		    
		  Exception err As IOException
		    // Unable to write the preferences to disk.
		    Return False
		    
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41737369676E73205B76616C75655D20746F2074686520737065636966696564205B6B65795D2E20496620746865206B657920646F6573206E6F7420657869737420697420697320637265617465642E
		Sub Set(key As String, Assigns value As Variant)
		  /// Assigns [value] to the specified [key]. If the key does not exist it is created.
		  ///
		  /// Sets a preference using the syntax:
		  ///
		  /// ```xojo
		  /// Preferences.Set("MainWindowTop") = 345
		  /// ```
		  ///
		  /// If [AutoSave] is True then the preferences file on disk will also be updated immediately.
		  
		  If mPreferences = Nil Then mPreferences = New Dictionary
		  
		  mPreferences.Value(key) = value
		  
		  If AutoSave Then Call Save
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Used to save and load preferences to/from disk. Data is saved in TOML format.
		The lookup operator has been overridden to allow preferences to be looked up with the "dot" operator.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 49662054727565207468656E20616E79206368616E676573206D61646520746F2074686520707265666572656E6365732077696C6C206265206175746F6D61746963616C6C79207772697474656E20746F206469736B2E
		AutoSave As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206261636B696E672064696374696F6E6172792073746F72696E672074686520707265666572656E6365732E
		Private mPreferences As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652066696C6520746861742074686520707265666572656E6365732077696C6C206265207772697474656E20746F2028617320544F4D4C292E
		Private mPreferencesFile As FolderItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoSave"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
