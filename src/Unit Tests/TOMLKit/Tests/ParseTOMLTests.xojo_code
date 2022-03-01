#tag Class
Protected Class ParseTOMLTests
Inherits TOMLKitTestGroupBase
	#tag Method, Flags = &h0
		Sub ArrayHeaderTest()
		  Var toml As String
		  Var d As Dictionary
		  Var arr() As Variant
		  Var d1 As Dictionary
		  
		  toml = JoinString( "[[header]]", "a = 2", "b=3", "[[header]]", "c = 4" )
		  d = ParseTOML(toml)
		  Assert.AreEqual(1, d.KeyCount, "1 item at top level")
		  arr = d.Value( "header" )
		  Var arrCount As Integer = arr.Count
		  Assert.AreEqual(2, arrCount, "2 items in array")
		  
		  d1 = arr( 0 )
		  Assert.AreEqual(2, d1.KeyCount, "First sub count")
		  Assert.AreEqual(2, d1.Value( "a" ).IntegerValue)
		  
		  d1 = arr( 1 )
		  Assert.AreEqual(1, d1.KeyCount, "Second sub count")
		  Assert.AreEqual(4, d1.Value( "c" ).IntegerValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BadKeyTest()
		  Var toml As String
		  
		  #Pragma BreakOnExceptions False
		  Try
		    toml = "k"
		    Call ParseTOML(toml)
		    Assert.Fail toml
		    
		  Catch err As TOMLKit.TKException
		    Assert.Pass 
		  End Try
		  #Pragma BreakOnExceptions default
		  
		  #Pragma BreakOnExceptions False
		  Try
		    toml = "k1 k2"
		    Call ParseTOML(toml)
		    Assert.Fail(toml)
		    
		  Catch err As TOMLKit.TKException
		    Assert.Pass 
		  End Try
		  #Pragma BreakOnExceptions default
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BasicStringEscapedCharactersTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  toml = "a=""\r \n\f\\\u0020\U00000020"""
		  d = ParseTOML(toml)
		  Var actual As String = d.Value( "a" )
		  Var expected As String = &u0D + " " + &u0A + &u0C + "\  "
		  Assert.AreEqual(EncodeHex( expected, True ), EncodeHex( actual, True ))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BasicTest()
		  Var toml As String = JoinString( "key1 = 1", "key2 = ""word""", "key3='word2'" )
		  Var d As Dictionary = ParseTOML(toml)
		  
		  Assert.IsTrue d IsA Dictionary, "Not a Dictionary"
		  
		  If Assert.Failed Then
		    Return
		  End If
		  
		  Assert.AreEqual(3, d.KeyCount, "Count")
		  Assert.AreEqual(1, d.Lookup( "key1", 0 ).IntegerValue, "key1")
		  Assert.AreEqual("word", d.Lookup( "key2", "" ).StringValue, "key2")
		  Assert.AreEqual("word2", d.Lookup( "key3", "" ).StringValue, "key3")
		  
		  If d.KeyCount <> 0 Then
		    Assert.IsFalse(d.HasKey( "KEY1" ), "Case-insensitive")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BooleanTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  toml = JoinString( "a=true", "b=false" )
		  d = ParseTOML(toml)
		  
		  Assert.AreEqual(Variant.TypeBoolean, d.Value( "a" ).Type)
		  Assert.AreEqual(Variant.TypeBoolean, d.Value( "b" ).Type)
		  
		  Assert.IsTrue(d.Value( "a" ).BooleanValue)
		  Assert.IsFalse(d.Value( "b" ).BooleanValue)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CompoundKeyTest()
		  Var toml As String
		  var d as Dictionary
		  var d1 as Dictionary
		  
		  toml = "a.b = 22"
		  d = ParseTOML(toml)
		  Assert.AreEqual(1, d.KeyCount, "1 item at top level")
		  d1 = d.Value( "a" )
		  Assert.AreEqual(1, d1.KeyCount, "1 item at second level")
		  Assert.AreEqual(22, d1.Value( "b" ).IntegerValue)
		  
		  toml = "'a' . ""b"" = 44"
		  d = ParseTOML(toml)
		  Assert.AreEqual(1, d.KeyCount, "1 item at top level")
		  d1 = d.Value( "a" )
		  Assert.AreEqual(1, d1.KeyCount, "1 item at second level")
		  Assert.AreEqual(44, d1.Value( "b" ).IntegerValue)
		  
		  toml = "'a.b' . ""b.a"" = 88"
		  d = ParseTOML(toml)
		  Assert.AreEqual(1, d.KeyCount, "1 item at top level")
		  d1 = d.Value( "a.b" )
		  Assert.AreEqual(1, d1.KeyCount, "1 item at second level")
		  Assert.AreEqual(88, d1.Value( "b.a" ).IntegerValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DateTimeTest()
		  Var toml As String
		  Var d As Dictionary
		  Var dateString As String
		  Var dt As DateTime
		  Var currentTimeZone As TimeZone = TimeZone.Current
		  
		  dateString = "1987-01-06T03:46:24"
		  toml = "a=" + DateString
		  d = ParseTOML(toml)
		  dt = d.Value( "a" )
		  Assert.AreEqual(DateString.Replace( "T", " " ), dt.SQLDateTime)
		  Assert.AreEqual(0, dt.Nanosecond)
		  Assert.AreEqual(currentTimeZone.SecondsFromGMT, dt.Timezone.SecondsFromGMT)
		  
		  dateString = "2001-11-15 15:46:01.88698"
		  toml = "a=" + DateString
		  d = ParseTOML(toml)
		  dt = d.Value( "a" )
		  Assert.AreEqual(DateString.Replace( "T", " " ).Left( dt.SQLDateTime.Length ), dt.SQLDateTime)
		  Assert.AreEqual(886980000, dt.Nanosecond)
		  Assert.AreEqual(currentTimeZone.SecondsFromGMT, dt.Timezone.SecondsFromGMT)
		  
		  dateString = "2005-09-22T12:01:59.776Z"
		  toml = "a=" + DateString
		  d = ParseTOML(toml)
		  dt = d.Value( "a" )
		  Assert.AreEqual(DateString.Replace( "T", " " ).Left( dt.SQLDateTime.Length ), dt.SQLDateTime)
		  Assert.IsTrue(dt.Nanosecond > 775000000 And dt.Nanosecond < 1000000000)
		  Assert.AreEqual(0, dt.Timezone.SecondsFromGMT)
		  
		  dateString = "2011-11-02 18:23:03-07:00"
		  toml = "a=" + DateString
		  d = ParseTOML(toml)
		  dt = d.Value( "a" )
		  Assert.AreEqual(DateString.Replace( "T", " " ).Left( dt.SQLDateTime.Length ), dt.SQLDateTime)
		  Assert.AreEqual(-7 * 60 * 60 , dt.Timezone.SecondsFromGMT)
		  
		  dateString = "2011-11-02 18:23:03+07:00"
		  toml = "a=" + DateString
		  d = ParseTOML(toml)
		  dt = d.Value( "a" )
		  Assert.AreEqual(7 * 60 * 60 , dt.Timezone.SecondsFromGMT)
		  
		  dateString = "1979-05-27T07:32:00-08:00#First class dates"
		  toml = "a=" + DateString
		  d = ParseTOML(toml)
		  dt = d.Value( "a" )
		  Assert.AreEqual(DateString.Replace( "T", " " ).Left( dt.SQLDateTime.Length ), dt.SQLDateTime)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoubleTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  Var actual() As String = Array( _
		  "inf", _
		  "-inf", _
		  "+inf", _
		  "nan", _
		  "-nan", _
		  "+nan", _
		  "+1.2", _
		  "-3.4", _
		  "3.4e5", _
		  "5.66E3", _
		  "-0.45E-9", _
		  "3_141.5927", _
		  "3141.592_7", _
		  "3e1_4", _
		  "1e0", _
		  "1E+0", _
		  "0.0", _
		  "+0.0", _
		  "-0.0", _
		  "0e0", _
		  "0e00", _
		  "+0e0", _
		  "-0e0", _
		  "+0e-0", _
		  "+0e+0", _
		  "-0e-0" _
		  )
		  
		  For Each item As String In actual
		    toml = "key1 = " + item
		    d = ParseTOML(toml)
		    Var expected As Double = item.ReplaceAll( "_", "" ).ToDouble
		    If Abs( expected ) = 0.0 Then
		      expected = expected
		    End If
		    Var areEqual As Boolean = expected.Equals( d.Value( "key1" ).DoubleValue, 1 )
		    Assert.IsTrue(areEqual, item)
		    If Not areEqual Then
		      Call ParseTOML(toml) // A place to break
		    End If
		  Next item
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmptyKeyTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  toml = """""="""""
		  d = ParseTOML(toml)
		  Assert.IsTrue(d.HasKey( "" ))
		  Assert.AreEqual("", d.Value( "" ).StringValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EncodedNumberTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  Var raw As String
		  Var xstring As String
		  
		  raw = "11001100110"
		  xstring = "&b" + raw
		  toml = "key1=0b" + raw
		  d = ParseTOML(toml)
		  Assert.AreEqual xstring.ToInteger, d.Value( "key1" ).IntegerValue, toml
		  
		  raw = "123456701"
		  xstring = "&o" + raw
		  toml = "key1=0o" + raw
		  d = ParseTOML( toml )
		  Assert.AreEqual xstring.ToInteger, d.Value( "key1" ).IntegerValue, toml
		  
		  raw = "abcDEFe012450"
		  xstring = "&h" + raw
		  toml = "key1=0x" + raw
		  d = ParseTOML( toml )
		  Assert.AreEqual xstring.ToInteger, d.Value( "key1" ).IntegerValue, toml
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InlineArrayTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  toml = "a=[1,2,3,]"
		  d = ParseTOML(toml)
		  Var arr() As Variant = d.Value( "a" )
		  Var arrCount As Integer = arr.Count
		  Assert.AreEqual 3, arrCount
		  Assert.AreEqual 1, arr( 0 ).IntegerValue
		  Assert.AreEqual 3, arr( 2 ).IntegerValue
		  
		  toml = "a = [1, 2, 3, ['a', 'b']]"
		  d = ParseTOML(toml)
		  arr = d.Value( "a" )
		  Var arr1() As Variant = arr( 3 )
		  Assert.AreEqual "a", arr1( 0 ).StringValue
		  
		  toml = JoinString( "a = [", "1,", "2,", "[5,6]", "]" )
		  d = ParseTOML(toml)
		  arr = d.Value( "a" )
		  arr1 = arr( 2 )
		  Assert.AreEqual 5, arr1( 0 ).IntegerValue
		  
		  toml = JoinString( "a = [", "1, # comment", "2,", "[5,6]", "]" )
		  d = ParseTOML(toml)
		  arr = d.Value( "a" )
		  arr1 = arr( 2 )
		  Assert.AreEqual 5, arr1( 0 ).IntegerValue
		  
		  toml = JoinString( "a=1", "b=[4,5,6]", "c=10" )
		  d = ParseTOML(toml)
		  Assert.AreEqual 3, d.KeyCount
		  arr = d.Value( "b" )
		  arrCount = arr.Count
		  Assert.AreEqual 3, arrCount
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InlineTableTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  toml = "a={b=1, c=true}"
		  d = ParseTOML(toml)
		  Var d1 As Dictionary = d.Value( "a" )
		  Assert.AreEqual 2, d1.KeyCount
		  Assert.AreEqual 1, d1.Value( "b" ).IntegerValue
		  Assert.IsTrue d1.Value( "c" ).BooleanValue
		  
		  toml = JoinString( "a=1", "b={a=2, b=3}", "c=4" )
		  d = ParseTOML(toml)
		  Assert.AreEqual 3, d.KeyCount
		  Assert.AreEqual 1, d.Value( "a" ).IntegerValue
		  Assert.AreEqual 4, d.Value( "c" ).IntegerValue
		  d1 = d.Value( "b" )
		  Assert.AreEqual 2, d1.KeyCount
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegerTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  Var actual() As String = Array( _
		  "0", _
		  "+0", _
		  "-0" _
		  )
		  
		  For Each item As String In actual
		    toml = "key1 = " + item
		    d = ParseTOML(toml)
		    Var expected As Double = item.ReplaceAll( "_", "" ).ToDouble
		    If Abs( expected ) = 0.0 Then
		      expected = expected
		    End If
		    Var areEqual As Boolean = expected.Equals( d.Value( "key1" ).DoubleValue, 1 )
		    Assert.IsTrue areEqual, item
		    If Not areEqual Then
		      Call ParseTOML(toml) // A place to break
		    End If
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InvalidCommentTest()
		  Var toml As String
		  
		  toml = JoinString( "# a comment with a bad character " + &u01, "a=1" )
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Should have thrown exception"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LiteralStringTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  toml = "a='abc\'"
		  d = ParseTOML(toml)
		  Assert.AreEqual "abc\", d.Value( "a" ).StringValue
		  
		  toml = JoinString( "a='''", "abc\'''" )
		  d = ParseTOML(toml)
		  Assert.AreEqual "abc\", d.Value( "a" ).StringValue
		  
		  toml = "a='''a''b'''"
		  d = ParseTOML(toml)
		  Assert.AreEqual "a''b", d.Value( "a" ).StringValue
		  
		  toml = "a='''''b'''''"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalDateTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  toml = "a=1967-02-25 # comment"
		  d = ParseTOML(toml)
		  Var dt As DateTime = d.Value( "a" )
		  Assert.IsTrue dt IsA TOMLKit.TKLocalDateTime
		  Assert.AreEqual "1967-02-25", dt.SQLDate
		  Assert.AreEqual 0, dt.Hour
		  Assert.AreEqual 0, dt.Minute
		  Assert.AreEqual 0, dt.Second
		  Assert.AreEqual 0, dt.Nanosecond
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalDateTimeTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  toml = "a=1967-02-25 01:02:03.5"
		  d = ParseTOML(toml)
		  Var dt As DateTime = d.Value( "a" )
		  Assert.IsTrue dt IsA TOMLKit.TKLocalDateTime
		  Assert.AreEqual "1967-02-25", dt.SQLDate
		  Assert.AreEqual 1, dt.Hour
		  Assert.AreEqual 2, dt.Minute
		  Assert.AreEqual 3, dt.Second
		  Assert.AreEqual 500000000, dt.Nanosecond
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MultilineBasicStringTest()
		  Var toml As String 
		  Var d As Dictionary
		  
		  toml = JoinString( "key1 = """"""", "The quick """" \", "brown fox""""""" )
		  d = ParseTOML(toml)
		  Assert.AreSame "The quick """" brown fox", d.Value( "key1" ).StringValue, "Ignore EOL"
		  
		  toml = JoinString( "key1 = """"""", "The quick", "brown fox""""""" )
		  d = ParseTOML(toml)
		  Assert.AreSame "The quick" + EndOfLine + "brown fox", d.Value( "key1" ).StringValue, "Include EOL"
		  
		  Var expected As String = """""a"""""
		  toml = "key1 = """"""" + expected + """"""""
		  d = ParseTOML(toml)
		  Assert.AreSame expected, d.Value( "key1" ).StringValue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MultilineLiteralStringTest()
		  Var toml As String 
		  Var d As Dictionary
		  
		  toml = JoinString( "key1 = '''", "The quick '' \", "brown fox'''" )
		  d = ParseTOML(toml)
		  Assert.AreEqual "The quick '' \" + EndOfLine + "brown fox", d.Value( "key1" ).StringValue
		  
		  Var expected As String = "''a''"
		  toml = "key1 = '''" + expected + "'''"
		  d = ParseTOML(toml)
		  Assert.AreEqual expected, d.Value( "key1" ).StringValue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NestedInlineTableTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  Self.StopTestOnFail = True
		  
		  toml = "a = [ { b = {} } ]"
		  d = ParseTOML(toml)
		  Var value As Variant = d.Value( "a" )
		  Assert.IsTrue value.IsArray
		  Var arr() As Variant = value
		  Var arrCount As Integer = arr.Count
		  Assert.AreEqual 1, arrCount
		  d = arr( 0 )
		  Assert.AreEqual 1, d.KeyCount
		  d = d.Value( "b" )
		  Assert.AreEqual 0, d.KeyCount
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventAddToInlineTableTest()
		  Var toml As String
		  
		  toml = JoinString( "a = {b=2}", "a.c=3" )
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Call ParseTOML(toml)
		    Assert.Fail "Allowed addition to inline table"
		  Catch err As TOMLKit.TKException
		    Assert.Pass
		  End Try
		  #Pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventEmptyArrayKeyTest()
		  Var tests() As String = Array( "[[]]", "[[""""]]", "[['']]" )
		  
		  For Each toml As String In tests
		    #Pragma BreakOnExceptions False
		    Try
		      Call ParseTOML(toml)
		      Assert.Fail "Allowed empty table key", toml
		    Catch err As TOMLKit.TKException
		      Assert.Pass
		    End Try
		    #Pragma BreakOnExceptions default
		  Next toml
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventEmptyTableKeyTest()
		  Var tests() As String = Array( "[]", "[""""]", "['']" )
		  
		  For Each toml As String In tests
		    #Pragma BreakOnExceptions False
		    Try
		      Call ParseTOML(toml)
		      Assert.Fail "Allowed empty table key", toml
		    Catch err As TOMLKit.TKException
		      Assert.Pass
		    End Try
		    #Pragma BreakOnExceptions default
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QuotedKeyTest()
		  Var toml As String
		  Var d As Dictionary
		  
		  toml = "'key 1'=1"
		  d = ParseTOML(toml)
		  Assert.AreEqual 1, d.Value( "key 1" ).IntegerValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TableHeaderTest()
		  Var toml As String
		  Var d As Dictionary
		  Var d1 As Dictionary
		  
		  toml = JoinString( "[header]", "a = 2", "b=3" )
		  d = ParseTOML(toml)
		  Assert.AreEqual 1, d.KeyCount, "1 item at top level"
		  d1 = d.Value( "header" )
		  Assert.AreEqual 2, d1.KeyCount, "2 items at second level"
		  Assert.AreEqual 2, d1.Value( "a" ).IntegerValue
		  Assert.AreEqual 3, d1.Value( "b" ).IntegerValue
		End Sub
	#tag EndMethod


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
	#tag EndViewBehavior
End Class
#tag EndClass
