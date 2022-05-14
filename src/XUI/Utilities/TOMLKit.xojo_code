#tag Module
Protected Module TOMLKit
	#tag Method, Flags = &h0, Description = 436F6E766572747320612064696374696F6E61727920746F206120544F4D4C20646F63756D656E742E
		Function GenerateTOML(dict As Dictionary) As String
		  /// Converts a dictionary to a TOML document.
		  
		  Var generator As New TKGenerator
		  Var result As String = generator.Generate( dict )
		  Return result.TrimLeft
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 506172736573206120544F4D4C20646F63756D656E7420696E746F20612064696374696F6E61727920616E642072657475726E732069742E
		Function ParseTOML(toml As String) As Dictionary
		  /// Parses a TOML document into a dictionary and returns it.
		  
		  #If Not DebugBuild Then
		    #Pragma BoundsChecking False
		    #Pragma BreakOnExceptions False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var parser As New TKParser
		  Var dict As Dictionary = parser.Parse( toml )
		  
		  Return dict
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76657274732061206052656745784D617463686020696E7374616E636520746F206120604461746554696D656020696E7374616E63652E
		Private Function RegExMatchToDateTime(match As RegExMatch) As DateTime
		  /// Converts a `RegExMatch` instance to a `DateTime` instance.
		  
		  Var year As Integer = match.SubExpressionString( 1 ).ToInteger
		  Var month As Integer = match.SubExpressionString( 2 ).ToInteger
		  Var day As Integer = match.SubExpressionString( 3 ).ToInteger
		  Var hour As Integer = match.SubExpressionString( 4 ).ToInteger
		  Var minute As Integer = match.SubExpressionString( 5 ).ToInteger
		  Var second As Integer = match.SubExpressionString( 6 ).ToInteger
		  
		  Var ns As Integer
		  If match.SubExpressionCount >= 8 And match.SubExpressionString( 7 ) <> "" Then
		    Var nsd As Double = match.SubExpressionString( 7 ).ToDouble
		    ns = nsd * kBillion
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
		  
		  Var dt As DateTime
		  If hasTZ Then
		    dt = New DateTime( year, month, day, hour, minute, second, ns, tz )
		  Else
		    dt = New TKLocalDateTime( year, month, day, hour, minute, second, ns )
		  End If
		  
		  Return dt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76657274732061206052656745784D617463686020696E7374616E636520746F20612060544B4C6F63616C54696D656020696E7374616E63652E
		Private Function RegExMatchToLocalTime(match As RegExMatch) As TKLocalTime
		  /// Converts a `RegExMatch` instance to a `TKLocalTime` instance.
		  
		  Var hour As Integer = match.SubExpressionString( 1 ).ToInteger
		  Var minute As Integer = match.SubExpressionString( 2 ).ToInteger
		  Var second As Integer = match.SubExpressionString( 3 ).ToInteger
		  Var ns As Integer
		  If match.SubExpressionCount = 5 Then
		    Var nsd As Double = match.SubExpressionString( 4 ).ToDouble
		    ns = nsd * kBillion
		  End If
		  
		  Var lt As New TKLocalTime( hour, minute, second, ns )
		  Return lt
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A module for reading and writing [TOML] data.
		
		[TOML]: https://toml.io
		
	#tag EndNote

	#tag Note, Name = Acknowledgements
		Ported from `M_TOML`, written by Kem Tekinay which can be found at:
		
		[https://github.com/ktekinay/Xojo-TOML][1]
		
		I have renamed and rewritten small parts to better fit with my preferred coding style but all 
		credit is due to Kem.
		
		[1]: https://github.com/ktekinay/Xojo-TOML
	#tag EndNote


	#tag ComputedProperty, Flags = &h21, Description = 54686520726567657820666F722070617273696E672061204461746554696D652E
		#tag Getter
			Get
			  Static rxDateTimeString As RegEx
			  
			  If rxDateTimeString Is Nil Then
			    rxDateTimeString = New RegEx
			    rxDateTimeString.SearchPattern = "(?mi-Us)^(\d{4})-(\d{2})-(\d{2})[T\x20](\d{2}):(\d{2}):(\d{2})(\.\d{1,})?(Z|[-+]\d{2}:\d{2})?$"
			  End If
			  
			  Return rxDateTimeString
			  
			End Get
		#tag EndGetter
		Private RxDateTimeString As RegEx
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21, Description = 54686520726567657820666F722070617273696E672061206C6F63616C20646174652E
		#tag Getter
			Get
			  Static rxLocalDateString As RegEx
			  
			  If rxLocalDateString Is Nil Then
			    rxLocalDateString = New RegEx
			    rxLocalDateString.SearchPattern = "^\d{4}-\d{2}-\d{2}$"
			  End If
			  
			  Return rxLocalDateString
			  
			End Get
		#tag EndGetter
		Private RxLocalDateString As RegEx
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21, Description = 54686520726567657820666F722070617273696E672074696D652E
		#tag Getter
			Get
			  Static rxTimeString As RegEx
			  
			  If rxTimeString Is Nil Then
			    rxTimeString = New RegEx
			    rxTimeString.SearchPattern = "^(\d{2}):(\d{2}):(\d{2})(\.\d{1,})?$"
			  End If
			  
			  Return rxTimeString
			  
			End Get
		#tag EndGetter
		Private RxTimeString As RegEx
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 5468652063757272656E742076657273696F6E2E
		#tag Getter
			Get
			  Static v As New XUISemanticVersion(VERSION_MAJOR, VERSION_MINOR, VERSION_PATCH)
			  Return v
			  
			End Get
		#tag EndGetter
		Protected Version As XUISemanticVersion
	#tag EndComputedProperty


	#tag Constant, Name = kBillion, Type = Double, Dynamic = False, Default = \"1000000000", Scope = Private, Description = 412062696C6C696F6E2E
	#tag EndConstant

	#tag Constant, Name = kByteBackslash, Type = Double, Dynamic = False, Default = \"92", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520605C60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteBackspace, Type = Double, Dynamic = False, Default = \"8", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F6620746865206261636B7370616365206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteCapA, Type = Double, Dynamic = False, Default = \"65", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520604160206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteCapE, Type = Double, Dynamic = False, Default = \"69", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520604560206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteCapF, Type = Double, Dynamic = False, Default = \"70", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520604660206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteCapT, Type = Double, Dynamic = False, Default = \"84", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520605460206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteCapU, Type = Double, Dynamic = False, Default = \"85", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520605560206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteCapZ, Type = Double, Dynamic = False, Default = \"90", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520605A60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteColon, Type = Double, Dynamic = False, Default = \"58", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520603A60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteComma, Type = Double, Dynamic = False, Default = \"44", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520602C60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteCurlyBraceClose, Type = Double, Dynamic = False, Default = \"125", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520607D60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteCurlyBraceOpen, Type = Double, Dynamic = False, Default = \"123", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520607B60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteDot, Type = Double, Dynamic = False, Default = \"46", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520602E60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteEOL, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520454F4C206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteEquals, Type = Double, Dynamic = False, Default = \"61", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520603D60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteFormFeed, Type = Double, Dynamic = False, Default = \"12", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520666F726D2066656564206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteHash, Type = Double, Dynamic = False, Default = \"35", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520602360206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteHyphen, Type = Double, Dynamic = False, Default = \"45", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520602D60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLineFeed, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F6620746865206C696E652066656564206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowA, Type = Double, Dynamic = False, Default = \"97", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520606160206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowB, Type = Double, Dynamic = False, Default = \"98", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520606260206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowE, Type = Double, Dynamic = False, Default = \"101", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520606560206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowF, Type = Double, Dynamic = False, Default = \"102", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520606660206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowI, Type = Double, Dynamic = False, Default = \"105", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520606960206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowL, Type = Double, Dynamic = False, Default = \"108", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520606C60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowN, Type = Double, Dynamic = False, Default = \"110", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520606E60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowO, Type = Double, Dynamic = False, Default = \"111", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520606F60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowR, Type = Double, Dynamic = False, Default = \"114", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520607260206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowS, Type = Double, Dynamic = False, Default = \"115", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520607360206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowT, Type = Double, Dynamic = False, Default = \"116", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520607460206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowU, Type = Double, Dynamic = False, Default = \"117", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520607560206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowX, Type = Double, Dynamic = False, Default = \"120", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520607860206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteLowZ, Type = Double, Dynamic = False, Default = \"122", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520607A60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteNine, Type = Double, Dynamic = False, Default = \"57", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520603960206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteOne, Type = Double, Dynamic = False, Default = \"49", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520603160206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kBytePlus, Type = Double, Dynamic = False, Default = \"43", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520602B60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteQuoteDouble, Type = Double, Dynamic = False, Default = \"34", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520602260206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteQuoteSingle, Type = Double, Dynamic = False, Default = \"39", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520602760206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteReturn, Type = Double, Dynamic = False, Default = \"13", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F66207468652063617272696167652072657475726E206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteSeven, Type = Double, Dynamic = False, Default = \"55", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520603760206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteSpace, Type = Double, Dynamic = False, Default = \"32", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520602060206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteSquareBracketClose, Type = Double, Dynamic = False, Default = \"93", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520605D60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteSquareBracketOpen, Type = Double, Dynamic = False, Default = \"91", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520605B60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteTab, Type = Double, Dynamic = False, Default = \"9", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520686F72697A6F6E74616C20746162206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteUnderscore, Type = Double, Dynamic = False, Default = \"95", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520605F60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kByteZero, Type = Double, Dynamic = False, Default = \"48", Scope = Private, Description = 54686520646563696D616C2041534349492076616C7565206F662074686520603060206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kMillion, Type = Double, Dynamic = False, Default = \"1000000", Scope = Private, Description = 41206D696C6C696F6E2E
	#tag EndConstant

	#tag Constant, Name = VERSION_MAJOR, Type = Double, Dynamic = False, Default = \"1", Scope = Private, Description = 546865206D616A6F722076657273696F6E2E
	#tag EndConstant

	#tag Constant, Name = VERSION_MINOR, Type = Double, Dynamic = False, Default = \"0", Scope = Private, Description = 546865206D696E6F722076657273696F6E2E
	#tag EndConstant

	#tag Constant, Name = VERSION_PATCH, Type = Double, Dynamic = False, Default = \"0", Scope = Private, Description = 5468652070617463682076657273696F6E2E
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
End Module
#tag EndModule
