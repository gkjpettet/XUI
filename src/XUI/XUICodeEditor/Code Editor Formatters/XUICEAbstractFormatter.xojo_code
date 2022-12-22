#tag Class
Protected Class XUICEAbstractFormatter
	#tag Method, Flags = &h1, Description = 416476616E6365732074686520737065636966696564206E756D626572206F6620706F736974696F6E73206F7220746F2074686520656E64206F662074686520736F7572636520636F6465202877686963686576657220697320736F6F6E6572292E
		Protected Sub Advance(count As Integer = 1)
		  /// Advances the specified number of positions or to the end of the source code (whichever is sooner).
		  
		  For i As Integer = 1 To count
		    Call Consume
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 5472756520696620776527766520726561636865642074686520656E64206F66207468652063686172616374657273206F6E20746865206C696E652E
		Protected Function AtEnd() As Boolean
		  /// True if we've reached the end of the characters on the line.
		  
		  Return mCurrent > mLine.Characters.LastIndex And mLineNumber >= mFinalLineNumber
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 54727565206966207765206172652063757272656E746C7920706F696E74696E6720617420746865206C696E6520656E642E
		Protected Function AtLineEnd() As Boolean
		  /// True if we are currently pointing at the line end.
		  
		  Return mCurrent > mline.Characters.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  /// As this is an abstract class, the constructor is private to prevent instantiation.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 436F6E73756D657320616E642072657475726E73207468652063757272656E742063686172616374657220696E2074686520736F757263652E2052657475726E732022222069662061742074686520656E64206F662074686520736F75726365206F722026753041206966206174207468656E20656E64206F6620746865206C696E652E
		Protected Function Consume() As String
		  /// Consumes and returns the current character in the source. Returns "" if at the end of the source or &u0A
		  /// if at then end of the line.
		  
		  If mCurrent <= mLine.Characters.LastIndex Then
		    mCurrent = mCurrent + 1
		    Return mLine.Characters(mCurrent - 1)
		    
		  Else // Reached the end of this line.
		    If mLineNumber = mFinalLineNumber Then
		      // End of the source code.
		      Return ""
		    Else
		      // Move to the next line and return a newline character.
		      MoveToLine(mLineNumber + 1)
		      Return &u0A
		    End If
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E697469616C697365732074686520616273747261637420666F726D61747465722E
		Sub Initialise(lines() As XUICELine, startLine As Integer, clearStartline As Boolean = True)
		  /// Initialises the abstract formatter.
		  
		  // Cache commonly accessed properties.
		  mLines = lines
		  mLineManager = lines(0).LineManager
		  mFinalLineNumber = mLineManager.LineCount
		  mLinesLastIndex = mLines.LastIndex
		  
		  // Begin on the start line.
		  MoveToLine(startLine, clearStartline)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 437265617465732061206E65772067656E6572696320746F6B656E207374617274696E6720617420606D546F6B656E53746172744C6F63616C6020616E6420656E64696E6720617420606D43757272656E74602077697468206F7074696F6E616C206B65792D76616C756520646174612E2046616C6C6261636B2069732073657420746F206074797065602E
		Protected Function MakeGenericToken(type As String, paramArray keyValues() As Pair) As XUICELineToken
		  /// Creates a new generic token starting at `mTokenStartLocal` and ending at `mCurrent` with optional 
		  /// key-value data. Fallback is set to `type`.
		  ///
		  /// Optional key-values can be added to the token's data. Each item in `keyValues` is a `Pair` in 
		  /// the format:
		  ///
		  /// ```
		  ///  `Left`  = `String` key  
		  ///  `Right` = `Variant` value
		  /// ```
		  ///
		  /// We set `fallbackType` to the same value as `type`. This therefore assumes that `type` is a valid
		  /// generic theme type (i.e. one that is guaranteed to be present in a valid `XUICETheme`.
		  
		  Var t As New XUICELineToken(mline.Start + mTokenStartLocal, mTokenStartLocal, mCurrent - mTokenStartLocal, _
		  mLineNumber, type, type)
		  
		  For Each kv As Pair In keyValues
		    t.SetData(kv.Left, kv.Right)
		  Next kv
		  
		  Return t
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 437265617465732061206E657720746F6B656E207374617274696E6720617420606D546F6B656E53746172744C6F63616C6020616E6420656E64696E6720617420606D43757272656E74602077697468206F7074696F6E616C206B65792D76616C756520646174612E
		Protected Function MakeToken(type As String, fallbackType As String, paramArray keyValues() As Pair) As XUICELineToken
		  /// Creates a new token starting at `mTokenStartLocal` and ending at `mCurrent` with optional 
		  /// key-value data.
		  ///
		  /// Optional key-values can be added to the token's data. Each item in `keyValues` is a `Pair` in 
		  /// the format:
		  ///
		  /// ```
		  ///  `Left`  = `String` key  
		  ///  `Right` = `Variant` value
		  /// ```
		  ///
		  /// `fallbackType` is the style to use if the editor's theme doesn't define `type` as a style.
		  
		  Var t As New XUICELineToken(mline.Start + mTokenStartLocal, mTokenStartLocal, mCurrent - mTokenStartLocal, _
		  mLineNumber, type, fallbackType)
		  
		  For Each kv As Pair In keyValues
		    t.SetData(kv.Left, kv.Right)
		  Next kv
		  
		  Return t
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4D6F7665732074686520746F6B656E6973657220746F20746865207374617274206F66206C696E6520606C696E654E756D6265726020616E6420636C6561727320616E7920746F6B656E73206F6E2069742069662060636C6561724C696E656020697320547275652E20417373756D6573207468617420606C696E654E756D626572602069732076616C69642E
		Protected Sub MoveToLine(lineNumber As Integer, clearLine As Boolean = True)
		  /// Moves the tokeniser to the start of line `lineNumber` and clears any tokens on it if `clearLine` is True. 
		  /// Assumes that `lineNumber` is valid.
		  
		  mCurrent = 0
		  mTokenStartLocal = 0
		  
		  mLine = mLines(lineNumber - 1)
		  If clearLine Then mLine.Tokens.RemoveAll
		  mLineNumber = mLine.Number
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206368617261637465722060706C6163657360206265796F6E64207468652063757272656E742063686172616374657220776974686F757420636F6E73756D696E672069742E2052657475726E7320222220696620776527766520726561636865642074686520656E64206F662074686520736F7572636520636F6465206F7220267530412069662061742074686520656E64206F662061206C696E652E
		Protected Function Peek(places As Integer = 1) As String
		  /// Returns the character `places` beyond the current character without consuming it. 
		  /// Returns "" if we've reached the end of the source code or &u0A if at the end of a line.
		  ///
		  /// Assumes `places` > 0.
		  
		  Var charactersLastIndex As Integer = mLine.Characters.LastIndex
		  
		  If mCurrent + places - 1 <= charactersLastIndex Then
		    //  The requested character is on this line.
		    Return mLine.Characters(mCurrent + places - 1)
		    
		  ElseIf mCurrent + places - 1 = charactersLastIndex + 1 Then
		    // The character is at the end of this line.
		    Return &u0A
		    
		  Else
		    // The character is after the end of this line.
		    If mLineNumber = mFinalLineNumber Then
		      // End of the source code.
		      Return ""
		      
		    Else
		      // Adjust places to account for the characters remaining on the current line (and the line ending).
		      places = places - charactersLastIndex - mCurrent - 2
		      
		      For i As Integer = mLineNumber To mLinesLastIndex // Remember to use index not line number.
		        Var line As XUICELine = mLines(i)
		        
		        If line.IsBlank Then
		          If places = 1 Then
		            Return &u0A
		          Else
		            places = places - 1
		          End If
		          
		        ElseIf places <= line.Characters.Count Then
		          If places < 1 Or places > line.Characters.Count Then
		            Return ""
		          Else
		            Return line.Characters(places - 1)
		          End If
		          
		        ElseIf places = line.Characters.Count + 1 Then
		          Return &u0A
		          
		        Else
		          places = places - line.Characters.Count - 1
		        End If
		      Next i
		    End If
		  End If
		  
		  Return ""
		End Function
	#tag EndMethod


	#tag Note, Name = About
		An abstract base class for several code formatters. Implements low level methods that are common to 
		several tokenisers.
		
		It it not intended that this class be instantiated.
		
		If you write your own formatters, you do **not** have to subclass this class.
		
		
	#tag EndNote


	#tag Property, Flags = &h1, Description = 54686520302D626173656420696E64657820696E20606D4368617261637465727360206F6620746865206E6578742063686172616374657220746F206576616C756174652E
		Protected mCurrent As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 54686520312D6261736564206C696E65206E756D626572206F66207468652066696E616C206C696E6520746F20626520746F6B656E697365642E
		Protected mFinalLineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 41207265666572656E636520746F20746865206C696E65206F6620736F7572636520636F646520696E2074686520656469746F722063757272656E746C79206265696E6720746F6B656E697365642E
		Protected mLine As XUICELine
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 546865206C696E65206D616E616765722E
		Protected mLineManager As XUICELineManager
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 54686520312D6261736564206E756D626572206F6620746865206C696E652063757272656E746C79206265696E6720746F6B656E697365642E
		Protected mLineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 41207265666572656E636520746F20746865206C696E657320746F20746F6B656E6973652E
		Protected mLines() As XUICELine
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 4361636865732076616C7565206F6620606D4C696E65732E4C617374496E646578602E
		Protected mLinesLastIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 54686520302D626173656420706F736974696F6E206F6E20746865206C696E65206265696E6720746F6B656E697365642074686174207468652063757272656E7420746F6B656E207374617274732061742E
		Protected mTokenStartLocal As Integer = 0
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
	#tag EndViewBehavior
End Class
#tag EndClass
