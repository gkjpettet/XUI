#tag Class
Protected Class GenerateTOMLTests
Inherits TOMLKitTestGroupBase
	#tag Method, Flags = &h0
		Sub ArrayInArrayTest()
		  Var d As New Dictionary
		  Var arr() As Variant
		  
		  For i As Integer = 0 To 1
		    Var subd As New Dictionary
		    subd.Value( "a" ) = 1
		    subd.Value( "i" ) = i
		    
		    Var subarr() As Variant
		    Var subd2 As New Dictionary( "x" : 1, "y" : 2, "z" : 3 )
		    subarr.Add subd2
		    subd.Value( "subarr" ) = subarr
		    arr.Add(subd)
		  Next
		  
		  d.Value( "arr" ) = arr
		  
		  Var toml As String = GenerateTOML(d)
		  Var expected As String = kExpectedArrayInArrayTOML.ReplaceLineEndings( EndOfLine )
		  Assert.AreSame(expected, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ArrayOfDictTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  Var arr() As Dictionary
		  
		  Var d1 As New Dictionary
		  d1.Value( "b" ) = 2
		  d1.Value( "c" ) = 3
		  arr.Add d1
		  
		  d1 = New Dictionary
		  arr.Add d1
		  
		  d1 = New Dictionary
		  d1.Value( "d" ) = True
		  arr.Add d1
		  
		  d = New Dictionary
		  d.Value( "a" ) = arr
		  
		  toml = GenerateTOML(d)
		  Var expected As String = kExpectedArrayOfDictTOML.ReplaceLineEndings( EndOfLine )
		  Assert.AreSame(expected, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BasicTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  d = New Dictionary
		  d.Value( "a" ) = "b"
		  toml = GenerateTOML(d)
		  Assert.AreEqual("a = ""b""" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = 2
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 2" + EndOfLine, toml)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsolidationTest()
		  Var d As New Dictionary
		  Var subd As New Dictionary
		  d.Value( "sub" ) = subd
		  
		  subd.Value( "a" ) = 1
		  subd.Value( "b" ) = 2
		  
		  Var toml As String = GenerateTOML(d)
		  Var expected As String = kExpectedConsolidatedDictTOML.ReplaceLineEndings( EndOfLine )
		  Assert.AreSame(expected, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DateTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  d = New Dictionary
		  d.Value( "a" ) = New Date( 2021, 4, 5, 1, 2, 3, -5.5 )
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 2021-04-05T01:02:03-05:30" + EndOfLine, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DateTimeTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  Var tz As New Timezone( -5.5 * 60.0 * 60.0 )
		  
		  d = New Dictionary
		  d.Value( "a" ) = New DateTime( 2021, 4, 5, 1, 2, 3, 123000000, tz )
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 2021-04-05T01:02:03.123-05:30" + EndOfLine, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoubleTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  d = New Dictionary
		  d.Value( "a" ) = 1.0
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 1.0" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = 1234567890.12
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 1_234_567_890.12" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = -1234567890.12
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = -1_234_567_890.12" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = 9.0e-10
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 9.0E-10" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = -9.0e-10
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = -9.0E-10" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = 9.123e12
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 9.123E12" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = -9.123e12
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = -9.123E12" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = Val( "inf" )
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = inf" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = Val( "-inf" )
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = -inf" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = Val( "nan" )
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = nan" + EndOfLine, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmbeddedDictionaryTest()
		  Var d As New Dictionary
		  Var d1 As New Dictionary
		  Var d2 As New Dictionary
		  
		  d1.Value( "c" ) = 1
		  d1.Value( "d" ) = 2
		  
		  d2.Value( "e" ) = False
		  
		  d1.Value( "b" ) = d2
		  
		  d.Value( "a" ) = d1
		  d.Value( "z" ) = True
		  
		  Var toml As String = GenerateTOML(d)
		  Var expected As String = kExpectedEmbeddedDictTOML.ReplaceLineEndings( EndOfLine )
		  Assert.AreSame(expected, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InlineArrayTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  If True Then
		    Var arr() As Boolean = Array( True, False )
		    d = New Dictionary
		    d.Value( "a" ) = arr
		    toml = GenerateTOML(d)
		    Assert.AreSame("a = [ true, false, ]" + EndOfLine, toml)
		  End If
		  
		  If True Then
		    Var arr() As Integer = Array( 1, 2 )
		    d = New Dictionary
		    d.Value( "a" ) = arr
		    toml = GenerateTOML(d)
		    Assert.AreSame("a = [ 1, 2, ]" + EndOfLine, toml)
		  End If
		  
		  If True Then
		    Var arr() As Integer = Array( 1111, 22222 )
		    d = New Dictionary
		    d.Value( "a" ) = arr
		    toml = GenerateTOML(d)
		    Assert.AreSame("a = [ 1_111, 22_222, ]" + EndOfLine, toml)
		  End If
		  
		  If True Then
		    Var arr() As String = Array( "abc", "def""ge" )
		    d = New Dictionary
		    d.Value( "a" ) = arr
		    toml = GenerateTOML(d)
		    Assert.AreSame("a = [ ""abc"", ""def\""ge"", ]" + EndOfLine, toml)
		  End If
		  
		  If True Then
		    Var arr() As Double = Array( 1.5, 6789.56 )
		    d = New Dictionary
		    d.Value( "a" ) = arr
		    toml = GenerateTOML(d)
		    Assert.AreSame("a = [ 1.5, 6_789.56, ]" + EndOfLine, toml)
		  End If
		  
		  If True Then
		    Var arr() As Variant = Array( 1.5, True )
		    d = New Dictionary
		    d.Value( "a" ) = arr
		    toml = GenerateTOML(d)
		    Assert.AreSame("a = [ 1.5, true, ]" + EndOfLine, toml)
		  End If
		  
		  If True Then
		    Var arr() As Variant = Array( 1.5, True, "string", 7 )
		    d = New Dictionary
		    d.Value( "a" ) = arr
		    toml = GenerateTOML(d)
		    Var expected As String = String.FromArray( Array( "a = [", "  1.5,", "  true,", "  ""string"",", "  7,", "]", "" ), EndOfLine )
		    Assert.AreSame(expected, toml)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InlineTableTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  If True Then
		    Var inline As New TOMLKit.TKInlineDictionary
		    inline.Value( "z" ) = 2
		    inline.Value( "y" ) = 1
		    
		    d = New Dictionary
		    d.Value( "a" ) = inline
		    
		    toml = GenerateTOML(d).Trim
		    If toml = "a = { z = 2, y = 1 }" Or toml = "a = { y = 1, z = 2 }" Then
		      Assert.Pass
		    Else
		      Assert.Fail(toml, "Did not properly encode")
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegerTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  d = New Dictionary
		  d.Value( "a" ) = 1
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 1" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = 1234567890
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 1_234_567_890" + EndOfLine, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeyTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  d = New Dictionary
		  d.Value( "a" + &uA + "b" ) = 1
		  toml = GenerateTOML(d)
		  Assert.AreSame("""a\nb"" = 1" + EndOfLine, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalDateTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  d = New Dictionary
		  d.Value( "a" ) = New TOMLKit.TKLocalDateTime( 2021, 4, 5 )
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 2021-04-05" + EndOfLine, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalDateTimeTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  d = New Dictionary
		  d.Value( "a" ) = New TOMLKit.TKLocalDateTime( 2021, 4, 5, 1, 2, 3 )
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 2021-04-05T01:02:03" + EndOfLine, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalTimeTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  d = New Dictionary
		  d.Value( "a" ) = New TOMLKit.TKLocalTime( 14, 2, 3 )
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = 14:02:03" + EndOfLine, toml)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringTest()
		  Var d As Dictionary
		  Var toml As String
		  
		  d = New Dictionary
		  d.Value( "a" ) = "a" + &u9 + "b"
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = ""a\tb""" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = "a" + &u8 + "b"
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = ""a\bb""" + EndOfLine, toml)
		  
		  d = New Dictionary
		  d.Value( "a" ) = "a" + &u7F + "b"
		  toml = GenerateTOML(d)
		  Assert.AreSame("a = ""a\u007Fb""" + EndOfLine, toml)
		End Sub
	#tag EndMethod


	#tag Constant, Name = kExpectedArrayInArrayTOML, Type = String, Dynamic = False, Default = \"[[ arr ]]\n  a \x3D 1\n  i \x3D 0\n  subarr \x3D [ { x \x3D 1\x2C y \x3D 2\x2C z \x3D 3 }\x2C ]\n\n[[ arr ]]\n  a \x3D 1\n  i \x3D 1\n  subarr \x3D [ { x \x3D 1\x2C y \x3D 2\x2C z \x3D 3 }\x2C ]\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kExpectedArrayOfDictTOML, Type = String, Dynamic = False, Default = \"[[ a ]]\n  b \x3D 2\n  c \x3D 3\n\n[[ a ]]\n\n[[ a ]]\n  d \x3D true\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kExpectedConsolidatedDictTOML, Type = String, Dynamic = False, Default = \"sub.a \x3D 1\nsub.b \x3D 2\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kExpectedEmbeddedDictTOML, Type = String, Dynamic = False, Default = \"z \x3D true\n\n[ a ]\n  b.e \x3D false\n  c \x3D 1\n  d \x3D 2\n", Scope = Private
	#tag EndConstant


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
