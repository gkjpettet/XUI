#tag Class
Protected Class BurntSushiTest
	#tag Method, Flags = &h0
		Sub Constructor(f As FolderItem)
		  If f.Name.EndsWith( ".toml" ) Then
		    TOMLFolderItem = f
		    JSONFolderItem = f.Parent.Child( f.Name.Replace( ".toml", ".json" ) )
		  ElseIf f.Name.EndsWith( ".json" ) Then
		    JSONFolderItem = f
		    TOMLFolderItem = f.Parent.Child( f.Name.Replace( ".json", ".toml" ) )
		  End If
		  
		  If TOMLFolderItem Is Nil Or Not TOMLFolderItem.Exists Then
		    Raise New InvalidArgumentException
		  End If
		  
		  If JSONFolderItem IsA Object And Not JSONFolderItem.Exists Then
		    JSONFolderItem = Nil
		    
		  ElseIf JSONFolderItem IsA Object Then
		    Var json As String = TextFileContents( JSONFolderItem )
		    ExpectedDictionary = ParseJSON( json )
		    ExpectedDictionary = FixDictionary( ExpectedDictionary )
		    
		  End If
		  
		  Name = TOMLFolderItem.Name.Left( TOMLFolderItem.Name.Length - 5 )
		  TOML = TextFileContents( TOMLFolderItem )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FixDictionary(fixIt As Variant) As Variant
		  Var dict As Dictionary
		  If fixIt IsA Dictionary Then
		    dict = fixIt
		    
		    If dict.KeyCount = 2 And dict.HasKey( "type" ) And dict.HasKey( "value" ) Then
		      Var type As String = dict.Value( "type" )
		      Var value As String = dict.Value( "value" )
		      
		      Var trueValue As Variant
		      Select Case type
		      Case "integer"
		        trueValue = value.ToInteger
		      Case "bool"
		        trueValue = value = "true"
		      Case "float"
		        trueValue = value.ToDouble
		      Case "string"
		        #If TargetWindows Then
		          value = value.ReplaceAll( EndOfLine.UNIX, EndOfLine.Windows )
		        #EndIf
		        trueValue = value
		      Case "datetime", "datetime-local"
		        trueValue = ParseDateTime( value )
		      Case "date-local"
		        Var parts() As String = value.Split( "-" )
		        trueValue = New TOMLKit.TKLocalDateTime( parts( 0 ).ToInteger, parts( 1 ).ToInteger, parts( 2 ).ToInteger )
		      Case "time-local"
		        trueValue = TOMLKit.TKLocalTime.FromString( value )
		      Case Else
		        Raise New RuntimeException
		      End Select
		      
		      Return trueValue
		    End If
		    
		    Var keys() As Variant = dict.Keys
		    Var values() As Variant = dict.Values
		    
		    For i As Integer = 0 To keys.LastIndex
		      Var value As Variant = values( i )
		      Var key As String = keys( i )
		      dict.Value( key ) = FixDictionary( value )
		    Next
		    
		  ElseIf fixIt.IsArray Then
		    Var arr() As Variant = fixIt
		    For i As Integer = 0 To arr.LastIndex
		      arr( i ) = FixDictionary( arr( i ) )
		    Next
		    fixIt = arr
		    
		  End If
		  
		  Return fixIt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseDateTime(s As String) As DateTime
		  Static rx As RegEx
		  If rx Is Nil Then
		    rx = New RegEx
		    rx.SearchPattern = "(?mi-Us)\A(\d{4})-(\d{2})-(\d{2})[T\x20](\d{2}):(\d{2}):(\d{2})(\.\d+)?(?|(Z)|([-+]\d{2}):(\d{2}))?\z"
		  End If
		  
		  Var dt As DateTime
		  
		  Var match As RegExMatch = rx.Search( s )
		  
		  Var year As Integer = match.SubExpressionString( 1 ).ToInteger
		  Var month As Integer = match.SubExpressionString( 2 ).ToInteger
		  Var day As Integer = match.SubExpressionString( 3 ).ToInteger
		  Var hour As Integer = match.SubExpressionString( 4 ).ToInteger
		  Var minute As Integer = match.SubExpressionString( 5 ).ToInteger
		  Var second As Integer = match.SubExpressionString( 6 ).ToInteger
		  
		  Var ns As Integer
		  If match.SubExpressionCount >= 8 And match.SubExpressionString( 7 ) <> "" Then
		    Var nsd As Double = match.SubExpressionString( 7 ).ToDouble
		    ns = nsd * 1000000000.0
		  End If
		  
		  Static gmt As New TimeZone( 0 )
		  Var tz As TimeZone
		  
		  Var hasTZ As Boolean
		  
		  If match.SubExpressionCount = 9 Then
		    hasTZ = True
		    
		    Var offsetTime As String = match.SubExpressionString( 8 )
		    If offsetTime = "Z" Then
		      tz = gmt
		      
		    ElseIf offsetTime <> "" Then
		      Var parts() As String = offsetTime.Split( ":" )
		      Var offsetSecs As Integer = ( parts( 0 ).ToInteger  * 60 * 60 ) + ( parts( 1 ).ToInteger * 60 )
		      tz = New TimeZone( offsetSecs )
		      
		    End If
		  End If
		  
		  If hasTZ Then
		    dt = New DateTime( year, month, day, hour, minute, second, ns, tz )
		  Else
		    dt = New TOMLKit.TKLocalDateTime( year, month, day, hour, minute, second, ns )
		  End If
		  
		  Return dt
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TextFileContents(f As FolderItem) As String
		  Var tis As TextInputStream = TextInputStream.Open( f )
		  Var result As String = tis.ReadAll( Encodings.UTF8 )
		  tis.Close
		  Return result.ReplaceLineEndings( EndOfLine )
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ExpectedDictionary As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		JSONFolderItem As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		TOML As String
	#tag EndProperty

	#tag Property, Flags = &h0
		TOMLFolderItem As FolderItem
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
			Name="TOML"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
