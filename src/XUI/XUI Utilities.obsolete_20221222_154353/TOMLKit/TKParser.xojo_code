#tag Class
Private Class TKParser
	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function GetChunk(startIndex As Integer, endIndex As Integer) As String
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  If endIndex < startIndex Then
		    Return ""
		  End If
		  
		  Var Len As Integer = endIndex - startIndex + 1
		  Return TOMLMemoryBlock.StringValue( startIndex, Len, Encodings.UTF8 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 476574732074686520696E646578206F662074686520746172676574206279746520696E2074686520726F772E2057696C6C2073746F7020617420454F4C206F72206120636F6D6D656E742E
		Private Function IndexOfByte(p As Ptr, lastByteIndex As Integer, byteIndex As Integer, targetByte As Integer) As Integer
		  /// Gets the index of the target byte in the row.
		  /// Will stop at EOL or a comment.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Const kDefault As Integer = -1
		  
		  While byteIndex <= lastByteIndex
		    Var thisByte As Integer = p.Byte( byteIndex )
		    
		    Select Case thisByte
		    Case targetByte
		      Return byteIndex
		      
		    Case kByteEOL, kByteHash // EOL or comment will end the search
		      Return kDefault
		      
		    End Select
		    
		    byteIndex = byteIndex + 1
		  Wend
		  
		  Return kDefault
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E2057696C6C20726169736520616E20657863657074696F6E2069662069742773206E6F7420612076616C696420657363617065206368617261637465722E
		Private Function InterpretEscaped(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer) As String
		  /// Internal use.
		  /// Will raise an exception if it's not a valid escape character.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  If byteIndex > lastByteIndex Then
		    Var msg As String = "Unexpected end of data"
		    RaiseException msg
		  End If
		  
		  Var thisByte As Integer = p.Byte( byteIndex )
		  
		  Select Case thisByte
		  Case kByteLowB
		    byteIndex = byteIndex + 1
		    Return &u08
		    
		  Case kByteLowF
		    byteIndex = byteIndex + 1
		    Return &u0C
		    
		  Case kByteLowN
		    byteIndex = byteIndex + 1
		    Return &u0A
		    
		  Case kByteLowR
		    byteIndex = byteIndex + 1
		    Return &u0D
		    
		  Case kByteLowT
		    byteIndex = byteIndex + 1
		    Return &u09
		    
		  Case kByteBackslash
		    byteIndex = byteIndex + 1
		    Return "\"
		    
		  Case kByteQuoteDouble
		    byteIndex = byteIndex + 1
		    Return """"
		    
		  End Select
		  
		  //
		  // If we get here, must be \u or \U
		  //
		  
		  Var requiredBytes As Integer
		  Select Case thisByte
		  Case kByteLowU
		    requiredBytes = 4
		  Case kByteCapU
		    requiredBytes = 8
		  Case Else
		    RaiseIllegalCharacterException byteIndex
		  End Select
		  
		  byteIndex = byteIndex + 1
		  
		  If ( ( lastByteIndex - byteIndex ) + 1 ) < requiredBytes Then
		    RaiseUnexpectedEndOfDataException
		  End If
		  
		  //
		  // Let's interpret the bytes
		  //
		  Var code As Integer
		  For i As Integer = 1 To requiredBytes
		    thisByte = p.Byte( byteIndex )
		    Select Case thisByte
		    Case kByteZero To kByteNine
		      code = ( code * 16 ) + ( thisByte - kByteZero )
		      
		    Case kByteLowA To kByteLowF
		      code = ( code * 16 ) + 10 + ( thisByte - kByteLowA )
		      
		    Case kByteCapA To kByteCapF
		      code = ( code * 16 ) + 10 + ( thisByte - kByteCapA )
		      
		    End Select
		    
		    byteIndex = byteIndex + 1
		  Next
		  
		  Var ucode As UInt64 = code
		  If uCode >= &h10FFFF Or ( uCode >= &hD800 And uCode <= &hDFFF ) Then
		    RaiseException "Invalid Unicode sequence on row " + RowNumber.ToString
		  End If
		  
		  Return Encodings.UTF8.Chr( code )
		  
		  '\b         - backspace       (U+0008)
		  '\t         - tab             (U+0009)
		  '\n         - linefeed        (U+000A)
		  '\f         - form feed       (U+000C)
		  '\r         - carriage return (U+000D)
		  '\"         - quote           (U+0022)
		  '\\         - backslash       (U+005C)
		  '\uXXXX     - unicode         (U+XXXX)
		  '\UXXXXXXXX - unicode         (U+XXXXXXXX)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function IsDictionaryArray(arr() As Variant) As Boolean
		  /// Internal use.
		  
		  For Each item As Variant In arr
		    If item.Type <> Variant.TypeObject Or Not ( item IsA Dictionary ) Then
		      Return False
		    End If
		  Next
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function MaybeParseArray(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer, ByRef value As Variant) As Boolean
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  If p.Byte( byteIndex ) <> kByteSquareBracketOpen Then
		    Return False
		  End If
		  
		  Var arr() As Variant
		  
		  byteIndex = byteIndex + 1
		  
		  Var expectComma As Boolean
		  
		  While byteIndex <= lastByteIndex
		    Var thisByte As Integer = p.Byte( byteIndex )
		    Select Case thisByte
		    Case kByteComma
		      If Not expectComma Then
		        RaiseIllegalCharacterException byteIndex
		      End If
		      
		      expectComma = False
		      byteIndex = byteIndex + 1
		      
		    Case kByteSpace, kByteTab
		      byteIndex = byteIndex + 1
		      
		    Case kByteEOL
		      SkipToNextRow p, lastByteIndex, byteIndex
		      
		    Case kByteHash
		      Call MaybeParseComment( p, lastByteIndex, byteIndex )
		      
		    Case kByteSquareBracketClose
		      //
		      // We are done
		      //
		      byteIndex = byteIndex + 1
		      SkipWhitespace p, lastByteIndex, byteIndex
		      value = arr
		      InlineArrays.Add arr
		      Return True
		      
		    Case Else
		      If expectComma Then
		        RaiseIllegalCharacterException byteIndex
		      End If
		      
		      arr.Add ParseValue( p, lastByteIndex, byteIndex )
		      expectComma = True
		      
		    End Select
		  Wend
		  
		  //
		  // If we get here, we ran out of data
		  //
		  RaiseUnexpectedEndOfDataException
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function MaybeParseBoolean(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer, ByRef value As Variant) As Boolean
		  /// Internal use.
		  
		  #Pragma unused lastByteIndex
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  //
		  // Since the MemoryBlock is padded with an EOL, 
		  // these IF statements will short-circuit
		  // before going out of bounds
		  //
		  
		  If _
		    p.Byte( byteIndex ) =     kByteLowT And _
		    p.Byte( byteIndex + 1 ) = kByteLowR And _
		    p.Byte( byteIndex + 2 ) = kByteLowU And _
		    p.Byte( byteIndex + 3 ) = kByteLowE Then
		    value = True
		    byteIndex = byteIndex + 4
		    Return True
		    
		  ElseIf _
		    p.Byte( byteIndex ) =     kByteLowF And _
		    p.Byte( byteIndex + 1 ) = kByteLowA And _
		    p.Byte( byteIndex + 2 ) = kByteLowL And _
		    p.Byte( byteIndex + 3 ) = kByteLowS And _
		    p.Byte( byteIndex + 4 ) = kByteLowE Then
		    value = False
		    byteIndex = byteIndex + 5
		    Return True
		    
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function MaybeParseComment(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer) As Boolean
		  /// Internal use.
		  ///
		  /// Should skip whitespace before calling this.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  If p.Byte( byteIndex ) = kByteHash Then
		    //
		    // Validate the comment characters
		    //
		    Do
		      byteIndex = byteIndex + 1
		      Var thisByte As Integer = p.Byte( byteIndex )
		      Select Case thisByte
		      Case kByteEOL
		        Exit Do
		      Case 0 To 8, 11 To 31, 127
		        RaiseIllegalCharacterException byteIndex
		      End Select
		    Loop // The last EOL will stop this loop
		    
		    SkipToNextRow p, lastByteIndex, byteIndex
		    Return True
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function MaybeParseDateTime(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer, ByRef value As Variant) As Boolean
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var testIndex As Integer = byteIndex
		  
		  Var hasOtherChars As Boolean
		  Var hasSpace As Boolean
		  
		  While testIndex <= lastByteIndex
		    Var thisByte As Integer = p.Byte( testIndex )
		    
		    Select Case thisByte
		    Case kByteZero To kByteNine
		      //
		      // Numbers are ok
		      //
		    Case kByteHyphen, kBytePlus, kByteCapZ, kByteLowZ, kByteColon, kByteDot
		      hasOtherChars = True
		      
		    Case kByteSpace, kByteCapT, kByteLowT // T is instead of a space
		      If hasSpace Then
		        Exit While
		      End If
		      
		      hasSpace = True
		      hasOtherChars = True
		      
		    Case kByteSpace, kByteTab, kByteEOL, kByteHash, kByteComma
		      If Not hasOtherChars Then
		        //
		        // Can't be a date or time
		        //
		        Return False
		      End If
		      
		      Exit While
		      
		    Case Else
		      //
		      // Not a date or time
		      //
		      Return False
		      
		    End Select
		    
		    testIndex = testIndex + 1
		  Wend
		  
		  //
		  // If we get here, we have something that might be a date or time
		  //
		  
		  Const kMinTimeLen As Integer = 8 // HH:MM:SS
		  Const kMinDateLen As Integer = 10 // YYYY-MM-DD
		  
		  Var stringLen As Integer = testIndex - byteIndex
		  
		  If stringLen < kMinTimeLen Then
		    //
		    // Guess not
		    //
		    Return False
		  End If
		  
		  Var result As Variant
		  
		  //
		  // Get the string representation
		  //
		  Var dateString As String = TOMLMemoryBlock.StringValue( byteIndex, stringLen, Encodings.UTF8 ).Trim
		  
		  Var match As RegExMatch
		  
		  //
		  // LocalTime?
		  //
		  match = RxTimeString.Search( dateString )
		  If match IsA Object Then
		    result = TOMLKit.RegExMatchToLocalTime( match )
		    GoTo Success
		  End If
		  
		  //
		  // LocalDate?
		  //
		  match = RxLocalDateString.Search( dateString )
		  If match IsA Object Then
		    Var ldt As TKLocalDateTime = TKLocalDateTime.FromString( dateString )
		    result = ldt
		    GoTo Success
		  End If
		  
		  //
		  // DateTime?
		  //
		  match = RxDateTimeString.Search( dateString )
		  If match IsA Object Then
		    result = TOMLKit.RegExMatchToDateTime( match )
		    GoTo Success
		  End If
		  
		  If result Is Nil Then
		    Return False
		  End If
		  
		  
		  Success :
		  
		  value = result
		  byteIndex = testIndex
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function MaybeParseNumber(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer, ByRef value As Variant) As Boolean
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var thisByte As Integer = p.Byte( byteIndex )
		  
		  If thisByte = kByteZero Then
		    Var valueStartIndex As Integer = byteIndex + 2
		    Var keepGoing As Boolean
		    
		    Var nextByte As Integer = p.Byte( byteIndex + 1 )
		    
		    Select Case nextByte
		    Case kByteLowB
		      //
		      // Binary
		      //
		      byteIndex = byteIndex + 2
		      value = ParseBinary( p, lastByteIndex, byteIndex )
		      
		    Case kByteLowO
		      //
		      // Octal
		      //
		      byteIndex = byteIndex + 2
		      value = ParseOctal( p, lastByteIndex, byteIndex )
		      
		    Case kByteLowX
		      //
		      // Hex
		      //
		      byteIndex = byteIndex + 2
		      value = ParseHex( p, lastByteIndex, byteIndex )
		      
		    Case kByteDot, kByteLowE, kByteCapE
		      //
		      // It's a float or scientific notation
		      // let it get processed
		      //
		      keepGoing = True
		      
		    Case Else //  Just a zero
		      value = 0
		      byteIndex = byteIndex + 1
		      Return True
		      
		    End Select
		    
		    If Not keepGoing Then
		      MaybeRaiseInvalidUnderscoreException p, lastByteIndex, byteIndex - 1
		      
		      If byteIndex = valueStartIndex Then
		        RaiseIllegalCharacterException byteIndex
		      End If
		      
		      Return True
		    End If
		  End If
		  
		  Var testIndex As Integer = byteIndex
		  
		  Var Sign As Integer = 1
		  
		  Select Case p.Byte( testIndex )
		  Case kBytePlus
		    testIndex = testIndex + 1
		  Case kByteHyphen
		    testIndex = testIndex + 1
		    Sign = -1
		  End Select
		  
		  If p.Byte( testIndex ) = kByteLowI And p.Byte( testIndex + 1 ) = kByteLowN And p.Byte( testIndex + 2 ) = kByteLowF Then
		    Static inf As Double = Val( "inf" )
		    Static negInf As Double = Val( "-inf" )
		    
		    value = If( Sign = -1, negInf, inf )
		    byteIndex = testIndex + 3
		    Return True
		    
		  ElseIf p.Byte( testIndex ) = kByteLowN And p.Byte( testIndex + 1 ) = kByteLowA And p.Byte( testIndex + 2 ) = kByteLowN Then
		    Static nan As Double = Val( "nan" )
		    Static negNan As Double = Val( "-nan" )
		    
		    value = If( Sign = -1, negNan, nan )
		    byteIndex = testIndex + 3
		    Return True
		    
		  End If
		  
		  If p.Byte( testIndex ) = kByteZero Then
		    Var nextByte As Integer = p.Byte( testIndex + 1 )
		    Select Case nextByte
		    Case kByteDot, kByteLowE, kByteCapE
		      //
		      // That's fine
		      //
		    Case kByteZero To kByteNine
		      //
		      // That's a no-no
		      //
		      Return False
		    Case Else
		      //
		      // Just a zero
		      //
		      value = 0
		      byteIndex = testIndex + 1
		      Return True
		    End Select
		    
		  ElseIf p.Byte( testIndex ) < kByteOne Or p.Byte( testIndex ) > kByteNine Then
		    Return False
		    
		  End If
		  
		  //
		  // Look for integer
		  //
		  Do
		    Select Case p.Byte( testIndex )
		    Case kByteUnderscore
		      testIndex = testIndex + 1
		      MaybeRaiseInvalidUnderscoreException p, lastByteIndex, testIndex
		    Case kByteZero To kByteNine
		      testIndex = testIndex + 1
		    Case kByteDot, kByteLowE, kByteCapE
		      //
		      // Onto the next part
		      //
		      MaybeRaiseInvalidUnderscoreException p, lastByteIndex, testIndex - 1
		      Exit Do
		      
		    Case Else
		      Var stringLen As Integer = testIndex - byteIndex
		      If stringLen = 0 Then
		        Return False
		      End If
		      
		      MaybeRaiseInvalidUnderscoreException p, lastByteIndex, testIndex - 1
		      
		      Var stringValue As String = TOMLMemoryBlock.StringValue( byteIndex, stringLen )
		      value = stringValue.ReplaceAll( "_", "" ).ToInteger
		      byteIndex = testIndex
		      Return True
		      
		    End Select
		    
		  Loop
		  
		  //
		  // A dot?
		  //
		  If p.Byte( testIndex ) = kByteDot Then
		    testIndex = testIndex + 1
		    Var nextByte As Integer = p.Byte( testIndex )
		    
		    If nextByte < kByteZero Or nextByte > kByteNine Then
		      RaiseIllegalCharacterException testIndex
		    End If
		    
		    While byteIndex <= lastByteIndex
		      Var testByte As Integer = p.Byte( testIndex )
		      Select Case testByte
		      Case kByteZero To kByteNine
		        testIndex = testIndex + 1
		      Case kByteUnderscore
		        testIndex = testIndex + 1
		        MaybeRaiseInvalidUnderscoreException p, lastByteIndex, testIndex
		      Case Else
		        Exit While
		      End Select
		    Wend
		  End If
		  
		  MaybeRaiseInvalidUnderscoreException p, lastByteIndex, testIndex - 1
		  
		  //
		  // E?
		  //
		  If p.Byte( testIndex ) = kByteLowE Or p.Byte( testIndex ) = kByteCapE Then
		    testIndex = testIndex + 1
		    
		    thisByte = p.Byte( testIndex )
		    If thisByte = kBytePlus Or thisByte = kByteHyphen Then
		      testIndex = testIndex + 1
		      thisByte = p.Byte( testIndex )
		    End If
		    
		    Var allDone As Boolean
		    
		    If thisByte = kByteZero Then
		      Var nextByte As Integer = p.Byte( testIndex + 1 )
		      If nextByte = kByteZero Then
		        testIndex = testIndex + 2
		        allDone = True
		        
		      ElseIf nextByte > kByteZero And nextByte <= kByteNine Then
		        RaiseIllegalCharacterException testIndex
		      End If
		      
		    ElseIf thisByte < kByteZero Or thisByte > kByteNine Then
		      RaiseIllegalCharacterException testIndex
		      
		    End If
		    
		    If Not allDone Then
		      While byteIndex <= lastByteIndex
		        thisByte = p.Byte( testIndex )
		        Select Case thisByte
		        Case kByteZero To kByteNine
		          testIndex = testIndex + 1
		        Case kByteUnderscore
		          testIndex = testIndex + 1
		          MaybeRaiseInvalidUnderscoreException p, lastByteIndex, testIndex
		        Case Else
		          Exit While
		        End Select
		      Wend
		    End If
		  End If
		  
		  //
		  // Let's send it back
		  //
		  MaybeRaiseInvalidUnderscoreException p, lastByteIndex, testIndex - 1
		  
		  Var stringLen As Integer = testIndex - byteIndex
		  Var stringValue As String = TOMLMemoryBlock.StringValue( byteIndex, stringLen, Encodings.UTF8 )
		  stringValue = stringValue.ReplaceAllBytes( "_", "" )
		  byteIndex = testIndex
		  
		  value = stringValue.ToDouble
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function MaybeParseString(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer, ByRef value As Variant) As Boolean
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var thisByte As Integer = p.Byte( byteIndex )
		  
		  Select Case thisByte
		  Case kByteQuoteSingle
		    value = ParseLiteralString( p, lastByteIndex, byteIndex )
		    Return True
		    
		  Case kByteQuoteDouble
		    value = ParseBasicString( p, lastByteIndex, byteIndex )
		    Return True
		    
		  End Select
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function MaybeParseTable(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer, ByRef value As Variant) As Boolean
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  If p.Byte( byteIndex ) <> kByteCurlyBraceOpen Then
		    Return False
		  End If
		  
		  byteIndex = byteIndex + 1
		  Var d As Dictionary = New TKInlineDictionary
		  
		  //
		  // See if it's an empty dictionary
		  //
		  SkipWhitespace p, lastByteIndex, byteIndex
		  If p.Byte( byteIndex ) = kByteCurlyBraceClose Then
		    byteIndex = byteIndex + 1
		    value = d
		    Return True
		  End If
		  
		  Var expectingComma As Boolean
		  
		  While byteIndex <= lastByteIndex
		    If expectingComma Then
		      Var thisByte As Integer = p.Byte( byteIndex )
		      Select Case thisByte
		      Case kByteComma
		        expectingComma = False
		        byteIndex = byteIndex + 1
		        
		      Case kByteCurlyBraceClose
		        //
		        // We are done
		        //
		        byteIndex = byteIndex + 1
		        
		        value = d
		        Return True
		        
		      Case Else
		        RaiseIllegalCharacterException byteIndex
		        
		      End Select
		      
		    Else // Expecting key/value
		      ParseKeyAndValueIntoDictionary p, lastByteIndex, byteIndex, d, True
		      expectingComma = True
		      
		    End If
		    
		    SkipWhitespace p, lastByteIndex, byteIndex
		  Wend
		  
		  //
		  // If we get here, something went wrong
		  //
		  RaiseUnexpectedEndOfDataException
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub MaybeRaiseIllegalCharacterException(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer)
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  SkipWhitespace p, lastByteIndex, byteIndex
		  
		  If byteIndex > lastByteIndex Or MaybeParseComment( p, lastByteIndex, byteIndex ) Then
		    Return
		  End If
		  
		  Var thisByte As Integer = p.Byte( byteIndex )
		  
		  If thisByte = kByteEOL Then
		    SkipToNextRow p, lastByteIndex, byteIndex
		    Return
		  End If
		  
		  RaiseIllegalCharacterException byteIndex
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub MaybeRaiseInvalidUnderscoreException(p As Ptr, lastByteIndex As Integer, byteIndex As Integer)
		  /// Internal use.
		  
		  If byteIndex >= 0 And byteIndex <= lastByteIndex And p.Byte( byteIndex ) = kByteUnderscore Then
		    RaiseException "An underscore cannot be the first or last number character in row " + RowNumber.ToString
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MaybeRaiseUnexpectedCharException(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer, expectedByte As Integer)
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  MaybeRaiseUnexpectedEOLException p, lastByteIndex, byteIndex
		  
		  If p.Byte( byteIndex ) <> expectedByte Then
		    RaiseUnexpectedCharException p, lastByteIndex, byteIndex, expectedByte
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub MaybeRaiseUnexpectedEOLException(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer)
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  SkipWhitespace p, lastByteIndex, byteIndex
		  
		  If byteIndex > lastByteIndex Or p.Byte( byteIndex ) = kByteEOL Or p.Byte( byteIndex ) = kByteHash Then
		    RaiseException "Unexpected end of line in row " + RowNumber.ToString
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 506172736573206120544F4D4C20646F63756D656E7420737472696E6720696E746F2061206044696374696F6E617279602E
		Function Parse(toml As String) As Dictionary
		  /// Parses a TOML document string into a `Dictionary`.
		  
		  #If Not DebugBuild Then
		    #Pragma BoundsChecking False
		    #Pragma BackgroundTasks False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var dict As Dictionary = ParseJSON( "{}" )
		  BaseDictionary = dict
		  CurrentDictionary = dict
		  
		  If toml.Encoding Is Nil Then
		    toml = toml.DefineEncoding( Encodings.UTF8 )
		  ElseIf toml.Encoding <> Encodings.UTF8 Then
		    toml = toml.ConvertEncoding( Encodings.UTF8 )
		  End If
		  
		  If Not Encodings.UTF8.IsValidData( toml ) Then
		    RaiseException "Invalid UTF-8"
		  End If
		  
		  toml = toml.Trim.ReplaceLineEndings( Encodings.UTF8.Chr( kByteEOL ) )
		  Self.TOML = toml
		  
		  //
		  // We will ensure a trailing EOL
		  //
		  Var mb As New MemoryBlock( toml.Bytes + 1 )
		  mb.StringValue( 0, toml.Bytes ) = toml
		  mb.Byte( mb.Size - 1 ) = kByteEOL
		  
		  TOMLMemoryBlock = mb
		  
		  #If DebugBuild Then
		    Self.TOML = mb.StringValue( 0, mb.Size, Encodings.UTF8 )
		  #EndIf
		  
		  Var p As ptr = mb
		  Var lastByteIndex As Integer = mb.Size - 1
		  Var byteIndex As Integer = 0
		  
		  While byteIndex <= lastByteIndex
		    ParseNextRow p, lastByteIndex, byteIndex
		  Wend
		  
		  Return dict
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function ParseBasicString(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer) As String
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var isMultiline As Boolean = p.Byte( byteIndex + 1 ) = kByteQuoteDouble And p.Byte( byteIndex + 2 ) = kByteQuoteDouble
		  
		  If isMultiline Then
		    byteIndex = byteIndex + 3
		    If p.Byte( byteIndex ) = kByteEOL Then
		      //
		      // We trim this
		      //
		      SkipToNextRow p, lastByteIndex, byteIndex
		    End If
		  Else
		    byteIndex = byteIndex + 1
		  End If
		  
		  Var chunks() As String
		  Var chunkStartIndex As Integer = byteIndex
		  Var quoteCount As Integer
		  
		  While byteIndex <= lastByteIndex
		    Var thisByte As Integer = p.Byte( byteIndex )
		    Select Case thisByte
		    Case kByteQuoteDouble
		      quoteCount = quoteCount + 1
		      
		      Var chunkEndIndex As Integer
		      Var isDone As Boolean
		      
		      If Not isMultiline Then
		        chunkEndIndex = byteIndex - 1
		        isDone = True
		        byteIndex = byteIndex + 1
		      ElseIf quoteCount = 5 Or ( quoteCount >= 3 And p.Byte( byteIndex + 1 ) <> kByteQuoteDouble ) Then
		        chunkEndIndex = byteIndex - 3
		        isDone =  True
		        byteIndex = byteIndex + 1
		      End If
		      
		      If isDone Then
		        chunks.Add GetChunk( chunkStartIndex, chunkEndIndex )
		        Var result As String = String.FromArray( chunks, "" ).DefineEncoding( Encodings.UTF8 )
		        Return result
		      Else
		        byteIndex = byteIndex + 1
		      End If
		      
		    Case kByteEOL
		      If Not isMultiline Then
		        RaiseUnexpectedEndOfDataException
		      End If
		      
		      quoteCount = 0
		      #If TargetWindows Then
		        //
		        // Need the CR
		        //
		        chunks.Add GetChunk( chunkStartIndex, byteIndex - 1 )
		        chunkStartIndex = byteIndex
		        chunks.Add &u0D
		      #EndIf
		      SkipToNextRow p, lastByteIndex, byteIndex
		      
		    Case kByteBackslash
		      quoteCount = 0
		      chunks.Add GetChunk( chunkStartIndex, byteIndex - 1 )
		      byteIndex = byteIndex + 1
		      
		      //
		      // See if it's just whitespace till the end of the row
		      //
		      Var testIndex As Integer = byteIndex
		      Do
		        Var testByte As Integer = p.Byte( testIndex )
		        Select Case testByte
		        Case kByteSpace, kByteTab
		          testIndex = testIndex + 1
		          
		        Case kByteEOL
		          //
		          // We are trimming this
		          //
		          
		          byteIndex = testIndex
		          
		          While byteIndex <= lastByteIndex
		            SkipToNextRow p, lastByteIndex, byteIndex
		            SkipWhitespace p, lastByteIndex, byteIndex
		            
		            Select Case p.Byte( byteIndex )
		            Case kByteEOL, kByteSpace, kByteTab
		              // skip it
		            Case Else
		              Exit While
		            End Select
		            
		            byteIndex = byteIndex + 1
		          Wend
		          
		          chunkStartIndex = byteIndex
		          Continue While
		          
		        Case Else
		          //
		          // It's something else
		          //
		          If testIndex <> byteIndex Then
		            //
		            // This is an error
		            //
		            RaiseIllegalCharacterException byteIndex
		          End If
		          
		          Var value As String = InterpretEscaped( p, lastByteIndex, byteIndex ) // Will raise an exception
		          chunks.Add value
		          chunkStartIndex = byteIndex
		          
		          Continue While
		        End Select
		      Loop
		      
		    Case 0 To 8, 11 To 12, 14 To 31, 127
		      RaiseIllegalCharacterException byteIndex
		      
		    Case Else
		      quoteCount = 0
		      byteIndex = byteIndex + 1
		      
		    End Select
		  Wend
		  
		  //
		  // If we get here, something went wrong
		  //
		  RaiseUnexpectedEndOfDataException
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function ParseBinary(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer) As Integer
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  MaybeRaiseInvalidUnderscoreException p, lastByteIndex, byteIndex
		  
		  Var value As Integer
		  
		  While byteIndex <= lastByteIndex
		    Select Case p.Byte( byteIndex )
		    Case kByteOne
		      value = value * 2 + 1
		    Case kByteZero
		      value = value * 2
		    Case kByteUnderscore
		      MaybeRaiseInvalidUnderscoreException p, lastByteIndex, byteIndex + 1
		    Case Else
		      Exit While
		    End Select
		    
		    byteIndex = byteIndex + 1
		  Wend
		  
		  Return value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function ParseHex(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer) As Integer
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  MaybeRaiseInvalidUnderscoreException p, lastByteIndex, byteIndex
		  
		  Var value As Integer
		  
		  While byteIndex <= lastByteIndex
		    Var thisByte As Integer = p.Byte( byteIndex )
		    
		    Select Case thisByte
		    Case kByteZero To kByteNine
		      value = ( value * 16 ) + ( thisByte - kByteZero )
		    Case kByteLowA To kByteLowF
		      value = ( value * 16 ) + 10 + ( thisByte - kByteLowA )
		    Case kByteCapA To kByteCapF
		      value = ( value * 16 ) + 10 + ( thisByte - kByteCapA )
		    Case kByteUnderscore
		      MaybeRaiseInvalidUnderscoreException p, lastByteIndex, byteIndex + 1
		    Case Else
		      Exit While
		    End Select
		    
		    byteIndex = byteIndex + 1
		  Wend
		  
		  Return value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub ParseKeyAndValueIntoDictionary(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer, intoDict As Dictionary, allowInline As Boolean)
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var keys() As String = ParseKeys( p, lastByteIndex, byteIndex )
		  MaybeRaiseUnexpectedCharException p, lastByteIndex, byteIndex, kByteEquals
		  byteIndex = byteIndex + 1
		  
		  SkipWhitespace p, lastByteIndex, byteIndex
		  
		  Var value As Variant = ParseValue( p, lastByteIndex, byteIndex )
		  
		  //
		  // Create the keys as needed
		  //
		  Var lastKey As String = keys.Pop
		  
		  Var dict As Dictionary = intoDict
		  For i As Integer = 0 To keys.LastIndex
		    Var key As String = keys( i )
		    
		    Var thisDict As Variant = dict.Lookup( key, Nil )
		    If thisDict Is Nil Then
		      thisDict = ParseJSON( "{}" )
		      dict.Value( key ) = thisDict
		      dict = thisDict
		      DotDefinedDictionaries.Add dict
		      
		    ElseIf thisDict IsA Dictionary Then
		      If allowInline = False And thisDict IsA TKInlineDictionary Then
		        RaiseException "Cannot add to the inline table referenced by '" + key + "' on row " + RowNumber.ToString
		      End If
		      If SectionDefinedDictionaries.IndexOf( thisDict ) <> -1 Then
		        RaiseDuplicateKeyException key
		      End If
		      
		      dict = thisDict
		      
		    Else
		      RaiseException "They key '" + key + "' is not a table"
		      
		    End If
		  Next
		  
		  If dict.HasKey( lastKey ) Then
		    RaiseException "Duplicate key '" + lastKey + "' on row " + RowNumber.ToString
		  End If
		  
		  dict.Value( lastKey ) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function ParseKeys(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer) As String()
		  /// Internal use.
		  ///
		  /// Should be at the first non-whitespace position.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var keys() As String
		  
		  While byteIndex <= lastByteIndex
		    MaybeRaiseUnexpectedEOLException p, lastByteIndex, byteIndex
		    
		    Var keyStart As Integer = byteIndex
		    Var keyLength As Integer
		    Var expectingKey As Boolean = True
		    Var expectingEndOfKeys As Boolean
		    Var allowDot As Boolean
		    
		    Do
		      Var thisByte As Integer = p.Byte( byteIndex )
		      
		      //
		      // See if it's quoted
		      //
		      Select Case thisByte
		      Case kByteQuoteSingle, kByteQuoteDouble
		        If byteIndex <> keyStart Then
		          RaiseException "Invalid quoting on row " + RowNumber.ToString 
		        End If
		        
		        //
		        // Make sure it's not a multiline
		        //
		        If p.Byte( byteIndex + 1 ) = thisByte And p.Byte( byteIndex + 2 ) = thisByte Then
		          RaiseException "Multiline keys are not allowed on row  " + RowNumber.ToString
		        End If
		        
		        If thisByte = kByteQuoteSingle Then
		          keys.Add ParseLiteralString( p, lastByteIndex, byteIndex )
		        Else
		          keys.Add ParseBasicString( p, lastByteIndex, byteIndex )
		        End If
		        
		        SkipWhitespace p, lastByteIndex, byteIndex
		        expectingEndOfKeys = True
		        expectingKey = False
		        allowDot = True
		        
		        Continue Do
		      End Select
		      
		      Select Case thisByte
		      Case kByteDot
		        If Not allowDot Then
		          RaiseIllegalKeyException
		        End If
		        
		        If keyLength <> 0 Then
		          keys.Add TOMLMemoryBlock.StringValue( keyStart, keyLength, Encodings.UTF8 )
		          keyLength = 0
		        End If
		        
		        byteIndex = byteIndex + 1
		        
		        expectingKey = True
		        expectingEndOfKeys = False
		        allowDot = False
		        
		        Continue While
		        
		      Case kByteTab, kByteSpace
		        If expectingKey Or keyLength = 0 Then
		          RaiseIllegalKeyException
		        End If
		        
		        keys.Add TOMLMemoryBlock.StringValue( keyStart, keyLength, Encodings.UTF8 )
		        
		        SkipWhitespace p, lastByteIndex, byteIndex
		        keyLength = 0
		        keyStart = byteIndex
		        
		        expectingEndOfKeys = True
		        allowDot = True
		        
		      Case kByteHyphen, kByteUnderscore, kByteCapA To kByteCapZ, kByteLowA To kByteLowZ, kByteZero To kByteNine
		        If expectingEndOfKeys Then
		          RaiseIllegalKeyException
		        End If
		        
		        keyLength = keyLength + 1
		        byteIndex = byteIndex + 1
		        expectingKey = False
		        allowDot = True
		        
		        Continue Do
		        
		      Case Else
		        If expectingKey Then
		          RaiseIllegalKeyException
		        End If
		        
		        If keyLength <> 0 Then
		          keys.Add TOMLMemoryBlock.StringValue( keyStart, keyLength, Encodings.UTF8 )
		        End If
		        
		        Return keys
		        
		      End Select 
		      
		    Loop
		    
		  Wend
		  
		  Return keys
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function ParseLiteralString(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer) As String
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var isMultiline As Boolean = p.Byte( byteIndex + 1 ) = kByteQuoteSingle And p.Byte( byteIndex + 2 ) = kByteQuoteSingle
		  
		  If isMultiline Then
		    byteIndex = byteIndex + 3
		    If p.Byte( byteIndex ) = kByteEOL Then
		      //
		      // We trim this
		      //
		      SkipToNextRow p, lastByteIndex, byteIndex
		    End If
		  Else
		    byteIndex = byteIndex + 1
		  End If
		  
		  Var stringStartIndex As Integer = byteIndex
		  Var quoteCount As Integer
		  
		  While byteIndex <= lastByteIndex
		    Var thisByte As Integer = p.Byte( byteIndex )
		    Select Case thisByte
		    Case kByteEOL
		      If Not isMultiline Then
		        RaiseUnexpectedEndOfDataException
		      End If
		      
		      quoteCount = 0
		      SkipToNextRow p, lastByteIndex, byteIndex
		      
		    Case kByteQuoteSingle
		      quoteCount = quoteCount + 1
		      
		      Var isDone As Boolean
		      Var stringEndIndex As Integer
		      
		      If Not isMultiline Then
		        stringEndIndex = byteIndex - 1
		        isDone = True
		        byteIndex = byteIndex + 1
		      ElseIf quoteCount = 5 Or ( quoteCount >= 3 And p.Byte( byteIndex + 1 ) <> kByteQuoteSingle ) Then
		        stringEndIndex = byteIndex - 3
		        isDone = True
		        byteIndex = byteIndex + 1
		      End If
		      
		      If isDone Then
		        Var result As String
		        Var stringLength As Integer = stringEndIndex - stringStartIndex + 1
		        If stringLength <> 0 Then
		          result = TOMLMemoryBlock.StringValue( stringStartIndex, stringLength, Encodings.UTF8 )
		        End If
		        
		        Return result.ReplaceLineEndings( EndOfLine )
		      End If
		      
		    Case 0 To 8, 11 To 12, 14 To 31, 127
		      RaiseIllegalCharacterException byteIndex
		      
		    Case Else
		      quoteCount = 0
		      
		    End Select
		    
		    byteIndex = byteIndex + 1
		  Wend
		  
		  //
		  // If we get here, something went wrong
		  //
		  MaybeRaiseUnexpectedCharException p, lastByteIndex, byteIndex, kByteQuoteSingle
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub ParseNextRow(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer)
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  RowNumber = RowNumber + 1
		  
		  SkipWhitespace p, lastByteIndex, byteIndex
		  
		  If byteIndex > lastByteIndex Then
		    Return
		  End If
		  
		  Var thisByte As Integer = p.Byte( byteIndex )
		  
		  //
		  // Nothing?
		  //
		  If thisByte = kByteEOL Then
		    byteIndex = byteIndex + 1
		    RowStartByteIndex = byteIndex
		    Return
		  End If
		  
		  //
		  // Comment?
		  //
		  If MaybeParseComment( p, lastByteIndex, byteIndex ) Then
		    Return
		  End If
		  
		  //
		  // Expecting a key or keys now
		  //
		  Var keys() As String
		  
		  //
		  // Dictionary or array header?
		  //
		  Var isDictionaryHeader As Boolean
		  Var isArrayHeader As Boolean
		  
		  If thisByte = kByteSquareBracketOpen Then
		    byteIndex = byteIndex + 1
		    'MaybeRaiseUnexpectedEOLException p, lastByteIndex, byteIndex
		    
		    If p.Byte( byteIndex ) = kByteSquareBracketOpen Then // Array header
		      isArrayHeader = True
		      
		      byteIndex = byteIndex + 1
		      SkipWhitespace p, lastByteIndex, byteIndex
		      
		      keys = ParseKeys( p, lastByteIndex, byteIndex )
		      MaybeRaiseUnexpectedCharException p, lastByteIndex, byteIndex, kByteSquareBracketClose
		      byteIndex = byteIndex + 1
		      
		    Else // Dictionary header
		      MaybeRaiseUnexpectedEOLException p, lastByteIndex, byteIndex
		      isDictionaryHeader = True
		      
		      keys = ParseKeys( p, lastByteIndex, byteIndex )
		    End If
		    
		    If p.Byte( byteIndex ) <> kByteSquareBracketClose Then
		      RaiseUnexpectedCharException p, lastByteIndex, byteIndex, kByteSquareBracketClose
		    End If
		    
		    byteIndex = byteIndex + 1
		    MaybeRaiseIllegalCharacterException p, lastByteIndex, byteIndex
		    
		    //
		    // Check the keys
		    //
		    For Each key As String In keys
		      If key = "" Then
		        RaiseIllegalKeyException
		      End If
		    Next
		    
		    //
		    // Let's set the keys
		    //
		    CurrentDictionary = BaseDictionary
		    
		    Var lastKey As String
		    If isArrayHeader Then
		      lastKey = keys.Pop
		    End If
		    
		    Var keyValue As Variant
		    
		    For i As Integer = 0 To keys.LastIndex
		      Var key As String = keys( i )
		      
		      Var keyDict As Dictionary
		      If Not CurrentDictionary.HasKey( key ) Then
		        keyDict = ParseJSON( "{}" )
		        CurrentDictionary.Value( key ) = keyDict
		        keyValue = keyDict
		        
		      Else
		        keyValue = CurrentDictionary.Value( key )
		        If keyValue.IsArray And keyValue.ArrayElementType = Variant.TypeObject And IsDictionaryArray( keyValue ) Then
		          Var arr() As Variant = keyValue
		          keyDict = arr( arr.LastIndex )
		          
		        ElseIf keyValue IsA TKInlineDictionary Then
		          RaiseDuplicateKeyException key
		          
		        ElseIf keyValue IsA Dictionary Then
		          keyDict = keyValue
		          
		        Else
		          RaiseDuplicateKeyException key
		        End If
		        
		      End If
		      CurrentDictionary = keyDict
		    Next
		    
		    If isArrayHeader Then
		      Var arr() As Variant
		      If CurrentDictionary.HasKey( lastKey ) Then
		        Var value As Variant = CurrentDictionary.Value( lastKey )
		        If Not value.IsArray Then
		          RaiseDuplicateKeyException lastKey
		        ElseIf InlineArrays.IndexOf( value ) <> -1 Then
		          RaiseDuplicateKeyException lastKey
		        End If
		        arr = value
		      Else
		        CurrentDictionary.Value( lastKey ) = arr
		      End If
		      
		      Var newDict As Dictionary = ParseJSON( "{}" )
		      arr.Add newDict
		      CurrentDictionary = newDict
		      
		    Else // Dictionary header
		      If Not ( keyValue IsA Dictionary ) Or _
		        SectionDefinedDictionaries.IndexOf( CurrentDictionary ) <> -1 Or _
		        DotDefinedDictionaries.IndexOf( CurrentDictionary ) <> -1 _
		        Then
		        RaiseDuplicateKeyException keys( keys.LastIndex )
		      End If
		      SectionDefinedDictionaries.Add CurrentDictionary
		      
		    End If
		    
		  Else
		    //
		    // Has to be a straight key
		    //
		    ParseKeyAndValueIntoDictionary p, lastByteIndex, byteIndex, CurrentDictionary, False
		    MaybeRaiseIllegalCharacterException p, lastByteIndex, byteIndex
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function ParseOctal(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer) As Integer
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  MaybeRaiseInvalidUnderscoreException p, lastByteIndex, byteIndex
		  
		  Var value As Integer
		  
		  While byteIndex <= lastByteIndex
		    Var thisByte As Integer = p.Byte( byteIndex )
		    Select Case thisByte
		    Case kByteZero To kByteSeven
		      value = ( value * 8 ) + ( thisByte - kByteZero )
		    Case kByteUnderscore
		      MaybeRaiseInvalidUnderscoreException p, lastByteIndex, byteIndex + 1
		    Case Else
		      Exit While
		    End Select
		    
		    byteIndex = byteIndex + 1
		  Wend
		  
		  Return value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Function ParseValue(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer) As Variant
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var value As Variant
		  
		  Select Case True
		  Case MaybeParseArray( p, lastByteIndex, byteIndex, value )
		  Case MaybeParseTable( p, lastByteIndex, byteIndex, value )
		  Case MaybeParseDateTime( p, lastByteIndex, byteIndex, value )
		  Case MaybeParseNumber( p, lastByteIndex, byteIndex, value )
		  Case MaybeParseBoolean( p, lastByteIndex, byteIndex, value )
		  Case MaybeParseString( p, lastByteIndex, byteIndex, value )
		    
		  Case Else
		    RaiseException "Illegal value on row " + RowNumber.ToString
		  End Select
		  
		  Return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub RaiseDuplicateKeyException(key As String)
		  /// Internal use.
		  
		  Var msg As String = "Duplicate key '" + key + "' on row " + RowNumber.ToString
		  RaiseException msg
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub RaiseException(msg As String)
		  /// Internal use.
		  
		  Var e As New TKException
		  e.Message = msg
		  Raise e
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub RaiseIllegalCharacterException(byteIndex As Integer)
		  /// Internal use.
		  
		  Var col As Integer = byteIndex - RowStartByteIndex + 1
		  Var msg As String = "Illegal character on row " + RowNumber.ToString + ", column " + col.ToString
		  RaiseException msg
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub RaiseIllegalKeyException()
		  /// Internal use.
		  
		  Var msg As String = "An illegal key was found on row " + RowNumber.ToString
		  RaiseException msg
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub RaiseUnexpectedCharException(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer, expectedByte As Integer)
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  #Pragma unused lastByteIndex
		  
		  Var col As Integer = byteIndex - RowStartByteIndex + 1
		  Var msg As String = "Error on row " + RowNumber.ToString + ", column " + col.ToString + _
		  ": Expected '" + Encodings.UTF8.Chr( expectedByte ) + _
		  "' but found '" + Encodings.UTF8.Chr( p.Byte( byteIndex ) ) +"'"
		  RaiseException msg
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub RaiseUnexpectedEndOfDataException()
		  /// Internal use.
		  
		  Var msg As String = "Data has ended unexpectedly on row " + RowNumber.ToString
		  RaiseException msg
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub SkipToNextRow(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer)
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  While byteIndex <= lastByteIndex 
		    If p.Byte( byteIndex ) = kByteEOL Then
		      byteIndex = byteIndex + 1 // Go to start of next row
		      RowStartByteIndex = byteIndex
		      RowNumber = RowNumber + 1
		      Return
		    End If
		    
		    byteIndex = byteIndex + 1
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub SkipWhitespace(p As Ptr, lastByteIndex As Integer, ByRef byteIndex As Integer)
		  /// Internal use.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  While byteIndex <= lastByteIndex 
		    Var Val As Byte = p.Byte( byteIndex )
		    If Val = kByteSpace Or Val = kByteTab Then
		      byteIndex = byteIndex + 1
		    Else
		      Return
		    End If
		  Wend
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		An internal class used by the `TOMLKit` module to parse a string 
		into a dictionary
		
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private BaseDictionary As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private CurrentDictionary As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private DotDefinedDictionaries() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private InlineArrays() As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private RowNumber As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private RowStartByteIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private SectionDefinedDictionaries() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private TOML As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private TOMLMemoryBlock As MemoryBlock
	#tag EndProperty


	#tag Constant, Name = kErrorUnexpectedEOL, Type = String, Dynamic = False, Default = \"Unexpected EOL", Scope = Private, Description = 556E657870656374656420454F4C206572726F72206D6573736167652E
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
