#tag Class
Protected Class LongTOMLTests
Inherits TOMLKitTestGroupBase
	#tag Method, Flags = &h21
		Private Function AreSameArrays(arr1() As Variant, arr2() As Variant) As Boolean
		  If arr1.Count <> arr2.Count Then
		    Return False
		  End If
		  
		  For i As Integer = 0 To arr1.LastIndex
		    Var val1 As Variant = arr1( i )
		    Var val2 As Variant = arr2( i )
		    If Not AreSameValues( val1, val2 ) Then
		      Return False
		    End If
		  Next
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AreSameDictionaries(d1 As Dictionary, d2 As Dictionary) As Boolean
		  If d1.KeyCount <> d2.KeyCount Then
		    System.DebugLog "Key counts don't match!"
		    Return False
		  End If
		  
		  Var keys1() As String = StringKeys( d1 )
		  Var keys2() As String = StringKeys( d2 )
		  Var values1() As Variant = d1.Values
		  Var values2() As Variant = d2.Values
		  
		  Var keysHex1() As String
		  Var keysHex2() As String
		  For i As Integer = 0 To keys1.LastIndex
		    keysHex1.Add EncodeHex( keys1( i ) )
		    keysHex2.Add EncodeHex( keys2( i ) )
		  Next
		  
		  keysHex1.SortWith keys1, values1
		  keysHex2.SortWith keys2, values2
		  
		  For i As Integer = 0 To keys1.LastIndex
		    Var k1 As String = keys1( i )
		    Var k2 As String = keys2( i )
		    
		    If k1.Compare(k2, ComparisonOptions.CaseSensitive) <> 0 Then
		      System.DebugLog "Keys " + k1 + " != " + k2
		      Return False
		    End If
		    
		    Var val1 As Variant = values1( i )
		    Var val2 As Variant = values2( i )
		    If Not AreSameValues( val1, val2 ) Then
		      System.DebugLog "Key " + k1 + " does not have the same values"
		      Return False
		    End If
		  Next
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AreSameValues(v1 As Variant, v2 As Variant) As Boolean
		  v1 = ToBestType( v1 )
		  v2 = ToBestType( v2 )
		  
		  Var v1Type As Integer = v1.Type
		  Var v2Type As Integer = v2.Type
		  
		  If v1Type <> v2Type Then
		    System.DebugLog v1Type.ToString + ", " + v2Type.ToString
		    Return False
		  End If
		  
		  Var result As Boolean
		  
		  If v1.Type = Variant.TypeObject And v1 IsA Dictionary Then
		    result = AreSameDictionaries( v1, v2 )
		    
		  ElseIf v1.IsArray And v2.IsArray Then
		    result = AreSameArrays( v1, v2 )
		    
		  ElseIf v1.Type = Variant.TypeDouble Then
		    If v1.DoubleValue.IsNotANumber And v2.DoubleValue.IsNotANumber Then
		      result = True
		    ElseIf v1.DoubleValue.IsInfinite And v2.DoubleValue.IsInfinite Then
		      result = True
		      
		    Else
		      result = v1.DoubleValue.Equals( v2.DoubleValue, 1 )
		      If result = False Then
		        System.DebugLog v1.DoubleValue.ToString + " != " + v2.DoubleValue.ToString
		      End If
		      
		    End If
		    
		  Else
		    result = v1.StringValue.Compare(v2.StringValue, ComparisonOptions.CaseSensitive) = 0
		    If result = False Then
		      System.DebugLog v1.StringValue + " != " + v2.StringValue
		    End If
		  End If
		  
		  #If DebugBuild Then
		    If result = False Then
		      result = result // A place to break
		    End If
		  #EndIf
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BigTOMLTest()
		  Self.StartTestTimer( "Parse TOML" )
		  Var fromTOML As Dictionary = ParseTOML(kBigTOML)
		  Self.LogTestTimer( "Parse TOML" )
		  
		  Var fromJSON As Dictionary = ParseJSON( kBigJSON )
		  Var result As Boolean = AreSameDictionaries( fromTOML, fromJSON )
		  Assert.IsTrue result
		  
		  Self.StartTestTimer( "Generate TOML" )
		  StartProfiling
		  Var generated As String = GenerateTOML(fromJSON)
		  StopProfiling
		  Self.LogTestTimer( "Generate TOML" )
		  
		  fromTOML = ParseTOML(generated)
		  result = AreSameDictionaries( fromTOML, fromJSON )
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BurntSushiFolderToArray(folder As FolderItem, intoArr() As BurntSushiTest)
		  Var enclosedFolders() As FolderItem
		  
		  For Each item As FolderItem In folder.Children( False )
		    If item.IsFolder Then
		      enclosedFolders.Add item
		    ElseIf item.Name.EndsWith( ".toml" ) Then
		      intoArr.Add New BurntSushiTest( item )
		    End If
		  Next
		  
		  For Each subfolder As FolderItem In enclosedFolders
		    BurntSushiFolderToArray subfolder, intoArr
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BurntSushInvalidUnitTestsTest()
		  //
		  // Processes files from https://github.com/BurntSushi/toml-test
		  //
		  
		  Var invalidTests() As BurntSushiTest = GetBurntSushiTests( "invalid" )
		  
		  For Each test As BurntSushiTest In invalidTests
		    Var name As String = test.Name
		    #Pragma unused name
		    Var path As String = test.TOMLFolderItem.NativePath
		    path = path.Replace( BurntSushiFolder.NativePath, "" )
		    
		    #Pragma BreakOnExceptions False
		    Try
		      Call ParseTOML(test.TOML)
		      Assert.Fail name + " in " + path.ReplaceAll( test.TOMLFolderItem.Name, "" )
		      
		    Catch err As TOMLKit.TKException
		      Assert.Pass
		      
		    Catch err As RuntimeException
		      Assert.Pass 
		      
		    End Try
		    #Pragma BreakOnExceptions default
		  Next test
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BurntSushValidGenerateTest()
		  //
		  // Processes files from https://github.com/BurntSushi/toml-test
		  //
		  
		  Var validTests() As BurntSushiTest = GetBurntSushiTests( "valid" )
		  
		  For Each test As BurntSushiTest In validTests
		    Var name As String = test.Name
		    Var path As String = test.TOMLFolderItem.NativePath
		    path = path.Replace( BurntSushiFolder.NativePath, "" )
		    
		    Try
		      Var expected As Dictionary = test.ExpectedDictionary
		      Var generated As String = GenerateTOML(expected)
		      Var parsed As Dictionary = ParseTOML(generated)
		      Var areSame As Boolean = AreSameDictionaries( parsed, expected )
		      Assert.IsTrue areSame, name + " in " + path + " (generate)"
		      If Not areSame Then
		        System.DebugLog "... (generated) " + path
		        Call AreSameDictionaries( parsed, expected )
		        Call GenerateTOML(parsed)
		      End If
		      
		    Catch err As TOMLKit.TKException
		      Assert.Fail name + " in " + path, err.Message
		      
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BurntSushValidParseTest()
		  //
		  // Processes files from https://github.com/BurntSushi/toml-test
		  //
		  
		  Var validTests() As BurntSushiTest = GetBurntSushiTests( "valid" )
		  
		  For Each test As BurntSushiTest In validTests
		    Var name As String = test.Name
		    Var path As String = test.TOMLFolderItem.NativePath
		    path = path.Replace( BurntSushiFolder.NativePath, "" )
		    
		    Try
		      Var actual As Dictionary = ParseTOML(test.TOML)
		      Var areSame As Boolean = AreSameDictionaries( actual, test.ExpectedDictionary )
		      Assert.IsTrue areSame, name + " in " + path
		      If Not areSame Then
		        System.DebugLog "... " + path
		        #If TargetWindows Then
		          Assert.Message "SOME TESTS FAIL BECAUSE OF EOL NORMALIZATION, and that's not an actual failure of the parser"
		        #EndIf
		      End If
		      
		    Catch err As TOMLKit.TKException
		      Assert.Fail name + " in " + path, err.Message
		      
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetBurntSushiTests(folderName As String) As BurntSushiTest()
		  Self.StopTestOnFail = True
		  
		  Var parentFolder As FolderItem = BurntSushiFolder
		  Assert.IsTrue parentFolder.Exists
		  
		  Var tests() As BurntSushiTest
		  
		  Var validFolder As FolderItem = parentFolder.Child( folderName )
		  Assert.IsTrue validFolder.Exists
		  BurntSushiFolderToArray validFolder, tests
		  
		  Self.StopTestOnFail = False
		  
		  Return tests
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StringKeys(d As Dictionary) As String()
		  Var stringKeys() As String 
		  Var keys() As Variant = d.Keys
		  For Each k As Variant In keys
		    stringKeys.Add k
		  Next
		  Return stringKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToBestType(v As Variant) As Variant
		  Select Case v.Type
		  Case Variant.TypeInt32, Variant.TypeInt64
		    Var i As Integer = v
		    v = i
		    
		  Case Variant.TypeSingle
		    Var d As Double = v
		    v = d
		    
		  Case Variant.TypeText
		    Var s As String = v.TextValue
		    v = s
		    
		  End Select
		  
		  Return v
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return SpecialFolder.Resource( "BurntSushiTests" )
			End Get
		#tag EndGetter
		Private BurntSushiFolder As FolderItem
	#tag EndComputedProperty


	#tag EndConstant

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
	#tag EndViewBehavior
End Class
#tag EndClass