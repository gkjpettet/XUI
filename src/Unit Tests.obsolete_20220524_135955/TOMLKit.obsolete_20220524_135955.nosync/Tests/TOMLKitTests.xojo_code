#tag Class
Protected Class TOMLKitTests
Inherits TOMLKitTestGroupBase
	#tag Method, Flags = &h0
		Sub InlineDictionaryTest()
		  Var d As TOMLKit.TKInlineDictionary
		  
		  d = New TOMLKit.TKInlineDictionary
		  d.Value( "a" ) = 1
		  d.Value( "a" ) = 2
		  Assert.AreEqual 2, d.Value( "a" ).IntegerValue
		  
		  d = New TOMLKit.TKInlineDictionary
		  d.Value( "a" ) = 1
		  d.Value( "A" ) = 2
		  d.Value( "b" ) = 3
		  d.Value( "b1" ) = 4
		  Assert.AreEqual 1, d.Value( "a" ).IntegerValue
		  Assert.AreEqual 2, d.Value( "A" ).IntegerValue
		  Assert.AreEqual 3, d.Value( "b" ).IntegerValue
		  Assert.AreEqual 4, d.Value( "b1" ).IntegerValue
		  
		  d = New TOMLKit.TKInlineDictionary( "a" : 1, "A" : 2 )
		  Assert.AreEqual 1, d.Value( "a" ).IntegerValue
		  Assert.AreEqual 2, d.Value( "A" ).IntegerValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalDateTimeTest()
		  Var now As DateTime = DateTime.Now
		  Var ldt As TOMLKit.TKLocalDateTime = now
		  
		  Assert.IsTrue ldt <> now
		  Assert.AreEqual now.SQLDateTime, ldt.SQLDateTime
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalTimeTest()
		  Var lt As TOMLKit.TKLocalTime
		  
		  lt = New TOMLKit.TKLocalTime( 1, 2, 3 )
		  Assert.AreEqual "01:02:03", lt.ToString
		  
		  Var d As New Dictionary
		  d.Value( "a" ) = lt
		  Var json As String = GenerateJSON( d )
		  Assert.AreEqual "{""a"":""01:02:03""}", json
		  
		  lt = New TOMLKit.TKLocalTime( 1, 2, 3, 4 )
		  Assert.AreEqual "01:02:03", lt.ToString
		  
		  lt = New TOMLKit.TKLocalTime( 1, 2, 3, 4000000 )
		  Assert.AreEqual "01:02:03.004", lt.ToString
		  
		  lt = New TOMLKit.TKLocalTime( 1, 2, 3, 4000000 )
		  Assert.AreEqual "01:02:03.004", lt.ToString
		  
		  Var s As String = "23:24:25.67"
		  lt = TOMLKit.TKLocalTime.FromString( s )
		  Assert.AreEqual s, lt.ToString
		  
		  lt = TOMLKit.TKLocalTime.Now
		  Var now As DateTime = DateTime.Now
		  Assert.AreEqual now.Hour, lt.Hour
		  Assert.AreEqual now.Minute, lt.Minute
		  Assert.AreEqual now.Second, lt.Second
		  Assert.IsTrue Abs( now.Nanosecond - lt.Nanosecond ) < 1000000
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
