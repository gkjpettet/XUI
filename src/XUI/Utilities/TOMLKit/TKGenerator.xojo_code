#tag Class
Private Class TKGenerator
	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E
		Private Sub AddKeyAndValue(key As String, value As Variant, toArr() As String = Nil)
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  If toArr = Nil Then
		    toArr = OutputArr
		  End If
		  
		  Var valueString As String = ConvertToString( value )
		  
		  toArr.Add(key)
		  toArr.Add(kEqualsWithSpaces)
		  toArr.Add(valueString)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652064656661756C7420636F6E7374727563746F722E
		Sub Constructor()
		  /// The default constructor.
		  
		  If USLocale Is Nil Then
		    USLocale = New Locale( "en-US" )
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66206064602E
		Private Function ConvertToString(d As Dictionary) As String
		  /// Returns a string representation of `d`.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var result() As String
		  
		  result.Add(kCurlyBraceOpen)
		  
		  Var keys() As Variant = d.Keys
		  Var values() As Variant = d.Values
		  
		  If keys.Count <> 0 Then
		    result.Add(kSpace)
		    For i As Integer = 0 To keys.LastIndex
		      Var key As String = keys( i )
		      Var value As Variant = values( i )
		      
		      AddKeyAndValue(key, value, result)
		      If i <> keys.LastIndex Then
		        result.Add(kCommaAndSpace)
		      End If
		    Next
		    result.Add(kSpace)
		  End If
		  
		  result.Add(kCurlyBraceClose)
		  Return String.FromArray( result, "" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F6620606172722829602E
		Private Function ConvertToString(arr() As Variant) As String
		  /// Returns a string representation of `arr()`.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var result() As String
		  
		  Const kAddEOLThreshold As Integer = 2
		  
		  Var addEOLBetweenElements As Boolean
		  
		  result.Add kSquareBracketOpen
		  CurrentLevel = CurrentLevel + 1
		  Var indent As String = IndentForCurrentLevel
		  
		  If arr.Count > kAddEOLThreshold Then
		    addEOLBetweenElements = True
		    result.Add(EndOfLine)
		  Else
		    result.Add(kSpace)
		  End If
		  
		  For Each o As Variant In arr
		    If addEOLBetweenElements Then
		      result.Add(indent)
		    End If
		    
		    result.Add ConvertToString( o )
		    
		    If addEOLBetweenElements Then
		      result.Add(kComma)
		      result.Add(EndOfLine)
		    Else
		      result.Add(kCommaAndSpace)
		    End If
		  Next
		  
		  CurrentLevel = CurrentLevel - 1
		  If addEOLBetweenElements Then
		    result.Add(IndentForCurrentLevel)
		  End If
		  result.Add(kSquareBracketClose)
		  
		  Return String.FromArray( result, "" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66206076616C7565602E
		Private Function ConvertToString(value As Variant) As String
		  /// Returns a string representation of `value`.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  If value IsA Dictionary Then
		    Var d As Dictionary = value
		    Return ConvertToString( d )
		  End If
		  
		  If value.IsArray Then
		    Var arr() As Variant = value
		    Return ConvertToString( arr )
		  End If
		  
		  Return value.StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20456E636F64657320616E2061727261792E
		Private Function EncodeArray(value As Variant) As Variant()
		  /// Internal use. Encodes an array.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var result() As Variant
		  
		  Select Case value.ArrayElementType
		  Case Variant.TypeObject
		    Var a As Auto = value
		    Var arr() As Object = a
		    For Each item As Variant In arr
		      result.Add(EncodeValue( item ))
		    Next
		    
		  Case Variant.TypeString
		    Var arr() As String = value
		    For Each item As String In arr
		      result.Add(EncodeValue( item ))
		    Next
		    
		  Case Variant.TypeText
		    Var arr() As Text = value
		    For Each item As Text In arr
		      result.Add(EncodeValue( item ))
		    Next
		    
		  Case Variant.TypeDouble
		    Var arr() As Double = value
		    For Each item As Double In arr
		      result.Add(EncodeValue( item ))
		    Next
		    
		  Case Variant.TypeSingle
		    Var arr() As Single = value
		    For Each item As Single In arr
		      result.Add(EncodeValue( item ))
		    Next
		    
		  Case Variant.TypeBoolean
		    Var arr() As Boolean = value
		    For Each item As Boolean In arr
		      result.Add(EncodeValue( item ))
		    Next
		    
		  Case Variant.TypeDateTime
		    Var arr() As DateTime = value
		    For Each item As DateTime In arr
		      result.Add(EncodeValue( item ))
		    Next
		    
		  Case Variant.TypeInt64
		    Var arr() As Int64 = value
		    For Each item As Integer In arr
		      result.Add(EncodeValue( item ))
		    Next
		    
		  Case Variant.TypeInt32
		    Var arr() As Int32 = value
		    For Each item As Integer In arr
		      result.Add(EncodeValue( item ))
		    Next
		    
		  Case Else
		    Raise New InvalidArgumentException( "Invalid type in array" )
		    
		  End Select
		  
		  Return result()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20456E636F646573206120604461746554696D65602E
		Private Function EncodeDateTime(dt As DateTime) As String
		  /// Internal use. Encodes a `DateTime`.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  //
		  // Special case
		  //
		  If dt IsA TKLocalDateTime And dt.Hour = 0 And dt.Minute = 0 And dt.Second = 0 And dt.Nanosecond = 0 Then
		    Return dt.SQLDate
		  End If
		  
		  Var dateString As String = dt.SQLDateTime.Replace( kSpace, "T" )
		  
		  If dt.Nanosecond <> 0 Then
		    Var ns As Integer = dt.Nanosecond
		    Var dµs As Double = ns / 1000.0
		    Var truncatedµs As Integer = dµs
		    dµs = truncatedµs / kMillion
		    dateString = dateString + dµs.ToString( USLocale, ".0#####" )
		  End If
		  
		  If Not ( dt IsA TKLocalDateTime ) Then
		    Var tz As Timezone = dt.Timezone
		    
		    If tz.SecondsFromGMT = 0 Then
		      dateString = dateString + "Z"
		      
		    Else
		      Var secsFromGMT As Integer = tz.SecondsFromGMT
		      
		      If tz.SecondsFromGMT > 0 Then
		        dateString = dateString + "+"
		      Else
		        secsFromGMT = -secsFromGMT
		        dateString = dateString + "-"
		      End If
		      
		      Var minsFromGMT As Integer = secsFromGMT \ 60
		      Var hoursFromGMT As Integer = minsFromGMT \ 60
		      minsFromGMT = minsFromGMT Mod 60
		      
		      dateString = dateString + hoursFromGMT.ToString( "00" ) + ":" + minsFromGMT.ToString( "00" )
		      
		    End If
		  End If
		  
		  Return dateString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20456E636F6465732061206044696374696F6E617279602E
		Private Function EncodeDictionary(sourceDict As Dictionary) As Dictionary
		  /// Internal use. Encodes a `Dictionary`.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  //
		  // Copy and consolidate values in this Dictionary
		  //
		  Var copy As Dictionary // Don't know yet what it will be
		  
		  Var keys() As Variant = sourceDict.Keys
		  Var values() As Variant = sourceDict.Values
		  
		  //
		  // Consolidate and copy each value first
		  //
		  Var keysLastIndex As Integer = keys.LastIndex
		  For i As Integer = 0 To keysLastIndex
		    Var key As String = keys( i ).StringValue
		    key = ToBasicString( key, True )
		    keys( i ) = key
		    
		    Var value As Variant = values( i )
		    
		    value = EncodeValue( value )
		    
		    If value IsA Dictionary Then
		      Var subDict As Dictionary = value
		      If subDict.KeyCount = 0 Then
		        value = New TKInlineDictionary
		      ElseIf subdict.KeyCount <= 2 And Not ( subDict IsA TKInlineDictionary ) Then
		        //
		        // We can consolidate this
		        //
		        Var subKeys() As Variant = subdict.Keys
		        Var subValues() As Variant = subdict.Values
		        For subIndex As Integer = 0 To subKeys.LastIndex
		          Var subKey As String = subKeys( subIndex )
		          Var subValue As Variant = subValues( subIndex )
		          
		          If subIndex = 0 Then
		            keys( i ) = key + kDot + subKey
		            value = subValue
		          Else
		            keys.Add key + kDot + subKey
		            values.Add(subValue)
		          End If
		        Next
		      End If
		    End If
		    
		    values( i ) = value
		  Next
		  
		  //
		  // Determine what kind we need
		  //
		  If sourceDict IsA TKInlineDictionary Or values.Count = 0 Then
		    copy = New TKInlineDictionary
		  Else
		    copy = ParseJSON( "{}" )
		  End If
		  
		  For i As Integer = 0 To keys.LastIndex
		    copy.Value( keys( i ) ) = values( i )
		  Next
		  
		  Return copy
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20456E636F64657320612060446F75626C65602E
		Private Function EncodeDouble(value As Double) As String
		  /// Internal use. Encodes a `Double`.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var result As String
		  
		  Var d As Double = value
		  Var ad As Double = Abs( d )
		  
		  If d.IsNotANumber Then
		    Const kNan As String = "nan"
		    Const kNegNan As String = "-nan"
		    
		    Static nan As Double = Val( kNan )
		    Static negNan As Double = -nan
		    
		    result = If( d = negNan, kNegNan, kNan )
		    
		  ElseIf d.IsInfinite Then
		    Const kInf As String = "inf"
		    Const kNegInf As String = "-inf"
		    
		    result = If( d <> ad, kNegInf, kInf )
		    
		  ElseIf ad > 1.0e12 Or ad < 1.0e-2 Then
		    result = d.ToString( USLocale, "0.0#######E0" )
		    
		  Else
		    result = d.ToString( USLocale, "#,##0.0##############" )
		    result = result.ReplaceAll( USLocale.GroupingSeparator, "_" )
		  End If
		  
		  result = result.ReplaceAll( ",", "_" )
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20456E636F64657320616E2060496E7465676572602E
		Private Function EncodeInteger(value As Integer) As String
		  /// Internal use. Encodes an `Integer`.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var result As String = value.ToString( USLocale, "#,##0" )
		  Static groupingSep As String = USLocale.GroupingSeparator
		  result = result.ReplaceAllBytes( groupingSep, kUnderscore )
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20456E636F6465732061206056617269616E74602076616C75652E
		Private Function EncodeValue(source As Variant) As Variant
		  /// Internal use. Encodes a `Variant` value.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var value As Variant = source
		  
		  If value.IsArray Then
		    value = EncodeArray( value )
		    
		  Else
		    Select Case value.Type
		    Case Variant.TypeString
		      value = ToBasicString( value.StringValue )
		      
		    Case Variant.TypeText
		      Var t As Text = value.TextValue
		      Var s As String = t
		      value = ToBasicString( s )
		      
		    Case Variant.TypeInt32, Variant.TypeInt64
		      value = EncodeInteger( value.IntegerValue )
		      
		    Case Variant.TypeDouble, Variant.TypeSingle
		      value = EncodeDouble( value.DoubleValue )
		      
		    Case Variant.TypeBoolean
		      value = If( value.BooleanValue, kTrue, kFalse )
		      
		    Case Variant.TypeDateTime
		      value = EncodeDateTime( value )
		      
		    Case Variant.TypeObject
		      If value IsA Dictionary Then
		        value = EncodeDictionary( value )
		      End If
		      
		    Case Else
		      Raise New InvalidArgumentException( "Unrecognized value" )
		    End Select
		    
		  End If
		  
		  Return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 47656E65726174657320544F4D4C2066726F6D2060736F7572636544696374602E
		Function Generate(sourceDict As Dictionary) As String
		  /// Generates TOML from `sourceDict`.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var tomlDict As Dictionary = EncodeDictionary( sourceDict )
		  
		  OutputArr.RemoveAll
		  KeyStack.RemoveAll
		  CurrentLevel = 0
		  ProcessTOMLDictionary tomlDict
		  
		  Var result As String = String.FromArray( OutputArr, "" ).Trim
		  result = result.DefineEncoding( Encodings.UTF8 ) + EndOfLine
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520696E64656E7420666F72207468652063757272656E74206C6576656C2E
		Private Function IndentForCurrentLevel() As String
		  /// Returns the indent for the current level.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  For level As Integer = indents.Count To CurrentLevel
		    indents.Add indents( level - 1 ) + kIndent
		  Next
		  
		  Return indents( CurrentLevel )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E2052657475726E732054727565206966206076616C7565602069732061206044696374696F6E617279602061727261792E
		Private Function IsDictionaryArray(value As Variant) As Boolean
		  /// Internal use. Returns True if `value` is a `Dictionary` array.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  If Not value.IsArray Then
		    Return False
		  End If
		  
		  If value.ArrayElementType <> Variant.TypeObject Then
		    Return False
		  End If
		  
		  Var a As Auto = value
		  Var arr() As Object = a
		  
		  If arr.Count = 0 Then
		    Return False
		  End If
		  
		  For Each item As Object In arr
		    If Not ( item IsA Dictionary ) Then
		      Return False
		    End If
		  Next
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E2050726F636573736573206120544F4D4C2064696374696F6E6172792E
		Private Sub ProcessTOMLDictionary(tomlDict As Dictionary)
		  /// Internal use. Processes a TOML dictionary.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var indent As String = IndentForCurrentLevel
		  
		  Var keys() As Variant = tomlDict.Keys
		  Var values() As Variant = tomlDict.Values
		  
		  Var arrayKeys() As String
		  Var arrayValues() As Variant
		  
		  Var sectionKeys() As String
		  Var sectionValues() As Variant
		  
		  Var thisLevelKeys() As String
		  Var thisLevelValues() As Variant
		  
		  //
		  // Parse through the keys
		  //
		  For i As Integer = 0 To keys.LastIndex
		    Var key As String = keys( i )
		    Var value As Variant = values( i )
		    
		    If Not IsInArray And value.IsArray And IsDictionaryArray( value ) Then
		      arrayKeys.Add(key)
		      arrayValues.Add(value)
		    ElseIf value IsA Dictionary And Not ( value IsA TKInlineDictionary ) Then
		      sectionKeys.Add(key)
		      sectionValues.Add(value)
		    Else
		      thisLevelKeys.Add(key)
		      thisLevelValues.Add(value)
		    End If
		  Next
		  
		  //
		  // Sort each array
		  //
		  
		  SortKeyArray(thisLevelKeys, thisLevelValues)
		  SortKeyArray(sectionKeys, sectionValues)
		  SortKeyArray(arrayKeys, arrayValues)
		  
		  //
		  // Output this level
		  //
		  For i As Integer = 0 To thisLevelKeys.LastIndex
		    Var key As String = thisLevelKeys( i )
		    Var value As Variant = thisLevelValues( i )
		    OutputArr.Add(indent)
		    AddKeyAndValue(key, value)
		    OutputArr.Add(EndOfLine)
		  Next
		  
		  //
		  // Output sections
		  //
		  
		  For i As Integer = 0 To sectionKeys.LastIndex
		    Var key As String = sectionKeys( i )
		    Var value As Variant = sectionValues( i )
		    
		    OutputArr.Add(EndOfLine)
		    OutputArr.Add(indent)
		    OutputArr.Add(kSquareBracketOpenAndSpace)
		    For Each k As String In KeyStack
		      OutputArr.Add(k)
		      OutputArr.Add(kDot)
		    Next
		    OutputArr.Add(key)
		    OutputArr.Add(kSquareBracketCloseWithSpace)
		    OutputArr.Add(EndOfLine)
		    
		    CurrentLevel = CurrentLevel + 1
		    KeyStack.Add(key)
		    ProcessTOMLDictionary(value)
		    KeyStack.RemoveAt(KeyStack.LastIndex)
		    CurrentLevel = CurrentLevel - 1
		  Next
		  
		  //
		  // Output arrays
		  //
		  IsInArray = True
		  For i As Integer = 0 To arrayKeys.LastIndex
		    Var key As String = arrayKeys( i )
		    Var arr() As Variant = arrayValues( i )
		    
		    For Each value As Variant In arr
		      OutputArr.Add(EndOfLine)
		      OutputArr.Add(indent)
		      OutputArr.Add(kSquareBracketOpenDoubleAndSpace)
		      For Each k As String In KeyStack
		        OutputArr.Add(k)
		        OutputArr.Add(kDot)
		      Next
		      OutputArr.Add(key)
		      OutputArr.Add(kSquareBracketCloseDoubleWithSpace)
		      OutputArr.Add(EndOfLine)
		      
		      CurrentLevel = CurrentLevel + 1
		      KeyStack.Add(key)
		      ProcessTOMLDictionary(value)
		      KeyStack.RemoveAt(KeyStack.LastIndex)
		      CurrentLevel = CurrentLevel - 1
		    Next
		  Next
		  IsInArray = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C2064656C6567617465206D6574686F6420666F7220736F7274696E6720616E2061727261792E
		Private Shared Sub SortKeyArray(keyArr() As String, valueArr() As Variant)
		  /// Internal delegate method for sorting an array.
		  
		  If keyArr.Count < 2 Then
		    Return
		  End If
		  
		  Var sorter() As String
		  sorter.ResizeTo(keyArr.LastIndex)
		  
		  For i As Integer = 0 To keyArr.LastIndex
		    Var key As String = keyArr( i )
		    sorter( i ) = EncodeHex( key )
		  Next
		  
		  sorter.SortWith(keyArr, valueArr)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E2052657475726E7320606D626C6E60206173206120737472696E672E
		Private Function ToBasicString(mbIn As MemoryBlock, isKey As Boolean = False) As String
		  /// Internal use. Returns `mbln` as a string.
		  
		  #If Not DebugBuild Then
		    #Pragma BackgroundTasks False
		    #Pragma BoundsChecking False
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		  #EndIf
		  
		  Var pIn As ptr = mbIn
		  Var lastByteIndex As Integer = mbIn.Size - 1
		  
		  Var outSize As Integer = mbIn.Size * 6 * 2
		  
		  If StringEncoderMB Is Nil Then
		    StringEncoderMB = New MemoryBlock( Max( outSize, 1024 ) )
		  ElseIf StringEncoderMB.Size < outSize Then
		    StringEncoderMB.Size = outSize
		  End If
		  
		  Var pOut As ptr = StringEncoderMB
		  pOut.Byte( 0 ) = kByteQuoteDouble
		  
		  Var outByteIndex As Integer = 0
		  
		  For byteIndex As Integer = 0 To lastByteIndex
		    Var thisByte As Integer = pIn.Byte( byteIndex )
		    
		    Select Case thisByte
		    Case kByteBackslash
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      
		    Case kByteBackspace
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteLowB
		      
		    Case kByteFormFeed
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteLowF
		      
		    Case kByteLineFeed
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteLowN
		      
		    Case kByteReturn
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteLowR
		      
		    Case kByteTab
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteLowT
		      
		    Case kByteQuoteDouble
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteQuoteDouble
		      
		    Case Is < 8, 11, 14 To 31
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteLowU
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteZero
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteZero
		      outByteIndex = outByteIndex + 1
		      If thisByte >= 16 Then
		        pOut.Byte( outByteIndex ) = kByteOne
		      Else
		        pOut.Byte( outByteIndex ) = kByteZero
		      End If
		      outByteIndex = outByteIndex + 1
		      Var thisByteMod As Integer = thisByte Mod 16
		      If thisByteMod < 10 Then
		        pOut.Byte( outByteIndex ) = thisByteMod + kByteZero
		      Else
		        pOut.Byte( outByteIndex ) = thisByteMod - 10 + kByteCapA
		      End If
		      
		    Case 127
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteBackslash
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteLowU
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteZero
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteZero
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteSeven
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = kByteCapF
		      
		    Case kByteCapA To kByteCapZ, kByteLowA To kByteLowZ, kByteZero To kByteNine, kByteHyphen, kByteUnderscore // Valid key
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = thisByte
		      
		    Case Else
		      isKey = False
		      outByteIndex = outByteIndex + 1
		      pOut.Byte( outByteIndex ) = thisByte
		      
		    End Select
		  Next byteIndex
		  
		  Var startByte As Integer
		  If isKey Then
		    startByte = 1
		  Else
		    startByte = 0
		    outByteIndex = outByteIndex + 1
		    pOut.Byte( outByteIndex ) = kByteQuoteDouble
		  End If
		  
		  Var stringLength As Integer = outByteIndex + 1 - startByte
		  If stringLength = 0 Then
		    Return kQuote + kQuote
		  Else
		    Var result As String = StringEncoderMB.StringValue( startByte, outByteIndex + 1 - startByte, Encodings.UTF8 )
		    Return result
		  End If
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Internal class used by `TOMLKit` to generate TOML from a `Dictionary`.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 5468652063757272656E74206C6576656C2E
		Private CurrentLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53746F7265732074686520696E64656E7420666F72207468652063757272656E74206C6576656C2E
		Private Shared Indents(0) As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 54727565206966207468652067656E657261746F722069732063757272656E746C792077697468696E20616E2061727261792E
		#tag Getter
			Get
			  Return mIsInArrayCount > 0
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    mIsInArrayCount = mIsInArrayCount + 1
			  ElseIf mIsInArrayCount > 0 Then
			    mIsInArrayCount = mIsInArrayCount - 1
			  End If
			  
			End Set
		#tag EndSetter
		Private IsInArray As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 546865206B657920737461636B2E
		Private KeyStack() As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C207573652E
		Private mIsInArrayCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 486F6C64732074686520737472696E67206265696E67206275696C742E
		Private OutputArr() As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4120604D656D6F7279426C6F636B60207573656420746F20656E636F646520737472696E67732E
		Private StringEncoderMB As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865205553206C6F63616C652E
		Private Shared USLocale As Locale
	#tag EndProperty


	#tag Constant, Name = kComma, Type = String, Dynamic = False, Default = \"\x2C", Scope = Private, Description = 54686520602C60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kCommaAndSpace, Type = String, Dynamic = False, Default = \"\x2C ", Scope = Private, Description = 54686520602C20602063686172616374657220636F6D62696E6174696F6E2E
	#tag EndConstant

	#tag Constant, Name = kCurlyBraceClose, Type = String, Dynamic = False, Default = \"}", Scope = Private, Description = 54686520607D60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kCurlyBraceOpen, Type = String, Dynamic = False, Default = \"{", Scope = Private, Description = 54686520607B60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kDot, Type = String, Dynamic = False, Default = \".", Scope = Private, Description = 54686520602E60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kEqualsWithSpaces, Type = String, Dynamic = False, Default = \" \x3D ", Scope = Private, Description = 5468652060203D20602063686172616374657220636F6D62696E6174696F6E2E
	#tag EndConstant

	#tag Constant, Name = kFalse, Type = String, Dynamic = False, Default = \"false", Scope = Private, Description = 546865206066616C73656020737472696E672E
	#tag EndConstant

	#tag Constant, Name = kIndent, Type = String, Dynamic = False, Default = \"  ", Scope = Private, Description = 54686520696E64656E74206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kQuote, Type = String, Dynamic = False, Default = \"\"", Scope = Private, Description = 54686520602260206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kSpace, Type = String, Dynamic = False, Default = \" ", Scope = Private, Description = 546865207370616365206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kSquareBracketClose, Type = String, Dynamic = False, Default = \"]", Scope = Private, Description = 54686520605D60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kSquareBracketCloseDoubleWithSpace, Type = String, Dynamic = False, Default = \" ]]", Scope = Private, Description = 54686520605D5D20602063686172616374657220636F6D62696E6174696F6E2E
	#tag EndConstant

	#tag Constant, Name = kSquareBracketCloseWithSpace, Type = String, Dynamic = False, Default = \" ]", Scope = Private, Description = 54686520605D20602063686172616374657220636F6D62696E6174696F6E2E
	#tag EndConstant

	#tag Constant, Name = kSquareBracketOpen, Type = String, Dynamic = False, Default = \"[", Scope = Private, Description = 54686520605B60206368617261637465722E
	#tag EndConstant

	#tag Constant, Name = kSquareBracketOpenAndSpace, Type = String, Dynamic = False, Default = \"[ ", Scope = Private, Description = 54686520605B20602063686172616374657220636F6D62696E6174696F6E2E
	#tag EndConstant

	#tag Constant, Name = kSquareBracketOpenDoubleAndSpace, Type = String, Dynamic = False, Default = \"[[ ", Scope = Private, Description = 54686520605B5B20602063686172616374657220636F6D62696E6174696F6E2E
	#tag EndConstant

	#tag Constant, Name = kTrue, Type = String, Dynamic = False, Default = \"true", Scope = Private, Description = 5468652060747275656020737472696E672E
	#tag EndConstant

	#tag Constant, Name = kUnderscore, Type = String, Dynamic = False, Default = \"_", Scope = Private, Description = 54686520605F60206368617261637465722E
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
