#tag Class
Protected Class XUITagCanvasLine
	#tag Method, Flags = &h0, Description = 417070656E64732060736020746F2074686520656E64206F662074686973206C696E652E
		Sub Append(s As String)
		  /// Appends `s` to the end of this line.
		  
		  If s.CharacterCount > 1 Then
		    Raise New InvalidArgumentException("Expected `s` to be a single character.")
		  End If
		  
		  UnparsedText = UnparsedText + s
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITagCanvas, lineNumber As Integer)
		  mOwner = New WeakRef(owner)
		  Self.Number = lineNumber
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652077696474682066726F6D20746865206C6566742065646765206F662074686973206C696E6520746F2074686520656E64206F6620746865206C696E65277320636F6E74656E74732E
		Function ContentsWidth(g As Graphics) As Double
		  /// Returns the width from the left edge of this line to the end of the line's contents.
		  ///
		  /// `g` is the context the line would be drawn to if it were being drawn.
		  
		  Var w As Double
		  
		  // Compute the width of any leading tags.
		  For Each tag As XUITag In Tags
		    w = w + Owner.Renderer.TagWidth(tag, g) + Owner.Renderer.TagHorizontalPadding
		    'w = w + tag.Width + Owner.TagRenderer.TagHorizontalPadding
		  Next tag
		  
		  // If there's no unparsed text then we're done.
		  If UnparsedText.Length = 0 Then Return w
		  
		  // Add on the width of the unparsed text.
		  g.SaveState
		  g.FontSize = Owner.Style.FontSize
		  g.FontName = Owner.Style.FontName
		  w = w + g.TextWidth(UnparsedText)
		  g.RestoreState
		  
		  Return w
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 44726177732074686973206C696E6520746F206067602E
		Sub Draw(g As Graphics, x As Double, topLeftY As Double, lineH As Double)
		  /// Draws this line to `g`.
		  ///
		  /// `x` is the X coord of the top left corner of the line.
		  /// `topLeftY` is the Y coord of the top left corner of the line.
		  /// `lineH` is the height of the line.
		  ///
		  /// Anti-aliasing needs to be disabled whenever we draw on Windows _except_ for 
		  /// text (which looks rubbish if anti-aliasing is off).
		  
		  // Compute the y coordinate of the start of the text.
		  g.FontName = Owner.Style.FontName
		  g.FontSize = Owner.Style.FontSize
		  Var textStartY As Double = topLeftY + (g.FontAscent + (lineH - g.TextHeight) / 2)
		  
		  // ==============================
		  // TAGS
		  // ==============================
		  #If TargetWindows
		    g.AntiAliased = False
		  #EndIf
		  For Each tag As XUITag In Tags
		    x = x + Owner.Renderer.RenderTag(tag, g, x, topLeftY, Owner.TagsHaveWidget)
		  Next tag
		  #If TargetWindows
		    g.AntiAliased = True
		  #EndIf
		  
		  // ==============================
		  // UNPARSED TEXT
		  // ==============================
		  If UnparsedText <> "" Then
		    g.FontName = Owner.Style.FontName
		    g.FontSize = Owner.Style.FontSize
		    g.DrawingColor = Owner.Style.FontColor
		    g.DrawText(UnparsedText, x, textStartY)
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F20746865206F776E696E67207461672063616E7661732E
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973206C696E65277320312D6261736564206E756D6265722E
		Number As Integer = 1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F776E696E67207461672063616E7661732E
		#tag Getter
			Get
			  If mOwner = Nil Or mOwner.Value = Nil Then
			    Return Nil
			  Else
			    Return XUITagCanvas(mOwner.Value)
			  End If
			End Get
		#tag EndGetter
		Owner As XUITagCanvas
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652074616773206F6E2074686973206C696E652E2053686F756C6420626520636F6E736964657265642072656164206F6E6C792E
		Tags() As XUITag
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 436F6E746967756F75732074657874206F6E2074686973206C696E65207468617420686173206E6F7420796574206265656E2070617273656420696E746F2061207461672E
		UnparsedText As String
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
			Name="UnparsedText"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Number"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
