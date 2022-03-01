#tag Class
Protected Class ParseBadTOMLTests
Inherits TOMLKitTestGroupBase
	#tag Method, Flags = &h0
		Sub AddToExistingTableTest()
		  Var toml As String
		  
		  toml = JoinString( "[a.b]", "c=2", "[a]", "b.d=3", "c=5" )
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Added to existing table"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DuplicateTableArrayTest()
		  Var toml As String
		  
		  toml = JoinString( "[[a]]", "[a]" )
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Duplicate table array"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExtendInlineArrayTest()
		  Var toml As String
		  
		  toml = JoinString( "a=[{}]", "[[a]]", "b=1" )
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Extended inline array"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExtendInlineTableTest()
		  Var toml As String
		  
		  toml = JoinString( "a = {}", "a.b = 3" )
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Inline tables cannot be extended with key"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		  toml = JoinString( "a = {}", "[a.b]" )
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Inline tables cannot be extended with section"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MultilineKeyTest()
		  Var toml As String
		  
		  Const kQuote As String = """"
		  Const kThreeQuotes As String = kQuote + kQuote + kQuote
		  
		  toml = JoinString( kThreeQuotes + "a", "b" + kThreeQuotes + "=1" )
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Long string are not allowed"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MultilineStringTest()
		  Var toml As String
		  
		  toml = JoinString( "a =""hi", "ho""" )
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Bad multiline"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RedefineTableTest()
		  Var toml As String
		  
		  toml = JoinString( "[a]", "b=2", "[a]", "c=3" )
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Cannot redefine a table"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpaceInArrayHeaderTest()
		  Var toml As String
		  
		  toml = "[ [header]]"
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Space between left brackets"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		  toml = "[[header] ]"
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Space between right brackets"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnderscoreTest()
		  Var numbers() As String = Array( _
		  "-.12345", _
		  "1__2", _
		  "1._1", _
		  "01", _
		  "_1", _
		  "_01", _
		  "1_", _
		  "-_1", _
		  "+_1", _
		  "1.", _
		  "1.1_", _
		  "1e", _
		  "1_e1", _
		  "1e_1", _
		  "1.1_e1",_
		  "1.1e+_1", _
		  "1.1e-_1", _
		  "1.1e1_", _
		  "0x_1", _
		  "0x1_", _
		  "0x1__1", _
		  "0x1G", _
		  "0b_1", _
		  "0b1_", _
		  "0b1__1", _
		  "0b2", _
		  "0o_1", _
		  "0o1_", _
		  "0o1__1", _
		  "0o9", _
		  "0x", _
		  "0o", _
		  "0b" _
		  )
		  
		  For Each num As String In numbers
		    Var toml As String = "a=" + num
		    #Pragma BreakOnExceptions False
		    Try
		      Call ParseTOML(toml)
		      Assert.Fail num
		    Catch err As TOMLKit.TKException
		      Assert.Pass
		    End Try
		    #Pragma BreakOnExceptions default
		  Next
		  
		End Sub
	#tag EndMethod


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
