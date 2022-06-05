#tag Class
Protected Class XUICEMarkdownFormatter
Implements MarkdownKit.MKRenderer,XUICEFormatter
	#tag Method, Flags = &h0, Description = 54727565206966207468697320666F726D617474657220616C6C6F777320776869746573706163652061742074686520626567696E6E696E67206F662061206C696E652E2049662046616C73652C2074686520656469746F722077696C6C207374726970206974207768656E2070617374696E6720616E642070726576656E742069742066726F6D206265696E672074797065642E
		Function AllowsLeadingWhitespace() As Boolean
		  /// True if this formatter allows whitespace at the beginning of a line. 
		  /// If False, the editor will strip it when pasting and prevent it from being typed.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4164647320746F6B656E7320666F7220616E79207265666572656E6365206C696E6B20646566696E6974696F6E7320696E2074686520646F63756D656E742E
		Private Sub HandleReferenceLinkDefinitions(doc As MarkdownKit.MKDocument)
		  /// Adds tokens for any reference link definitions in the document.
		  
		  Var line As XUICELine
		  
		  If doc.References.KeyCount > 0 Then
		    For Each entry As DictionaryEntry In doc.References
		      Var lrd As MarkdownKit.MKLinkReferenceDefinition = MarkdownKit.MKLinkReferenceDefinition(entry.Value)
		      // ----------
		      // LINK LABEL
		      // ----------
		      // `[`
		      line = XUICELine(lrd.LinkLabelOpener.Line)
		      line.Tokens.Add(New XUICELineToken(lrd.LinkLabelOpener.AbsolutePosition, lrd.LinkLabelOpener.LocalPosition, _
		      1, line.Number, TOKEN_LINK_LABEL_DELIMITER))
		      
		      // Link label text.
		      line = XUICELine(lrd.LinkLabelStartChar.Line)
		      line.Tokens.Add(New XUICELineToken(lrd.LinkLabelStartChar.AbsolutePosition, _
		      lrd.LinkLabelStartChar.LocalPosition, lrd.LinkLabelLength - 2, line.Number, "referenceLinkLabel"))
		      
		      // `]`
		      line = XUICELine(lrd.LinkLabelCloser.Line)
		      line.Tokens.Add(New XUICELineToken(lrd.LinkLabelCloser.AbsolutePosition, lrd.LinkLabelCloser.LocalPosition, _
		      1, line.Number, TOKEN_LINK_LABEL_DELIMITER))
		      
		      // Link label colon.
		      line = XUICELine(lrd.Colon.Line)
		      line.Tokens.Add(New XUICELineToken(lrd.Colon.AbsolutePosition, lrd.Colon.LocalPosition, 1, _
		      line.Number, "referenceLinkColon"))
		      
		      // ----------------
		      // LINK DESTINATION
		      // ----------------
		      // Destination.
		      If lrd.HasDestination Then
		        Var destStart As MarkdownKit.MKCharacter = lrd.LinkDestination.StartCharacter
		        line = XUICELine(destStart.Line)
		        line.Tokens.Add(New XUICELineToken(destStart.AbsolutePosition, destStart.LocalPosition, _
		        lrd.LinkDestination.Length, line.Number, TOKEN_LINK_DESTINATION))
		      End If
		      
		      // ----------
		      // LINK TITLE
		      // ----------
		      If lrd.HasTitle Then
		        // Opening delimiter.
		        Var titleOpener As MarkdownKit.MKCharacter = lrd.LinkTitle.OpeningDelimiter
		        line = XUICELine(titleOpener.Line)
		        line.Tokens.Add(New XUICELineToken(titleOpener.AbsolutePosition, titleOpener.LocalPosition, 1, _
		        line.Number, "referenceLinkTitleDelimiter"))
		        
		        // Title.
		        For Each vb As MarkdownKit.MKLinkTitleBlock In lrd.LinkTitle.ValueBlocks
		          line = mLines(vb.LineNumber - 1)
		          line.Tokens.Add(New XUICELineToken(vb.AbsoluteStart, vb.LocalStart, vb.Length, _
		          line.Number, "referenceLinkTitle"))
		        Next vb
		        
		        // Closing delimiter.
		        Var titleCloser As MarkdownKit.MKCharacter = lrd.LinkTitle.ClosingDelimiter
		        line = XUICELine(titleCloser.Line)
		        line.Tokens.Add(New XUICELineToken(titleCloser.AbsolutePosition, titleCloser.LocalPosition, 1, _
		        line.Number, "referenceLinkTitleDelimiter"))
		      End If
		    Next entry
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320656E74697265206C696E65206973206120636F6D6D656E742E
		Function IsCommentLine(line As XUICELine) As Boolean
		  /// True if this entire line is a comment.
		  ///
		  /// There are no comment lines in the plain text formatter.
		  
		  #Pragma Unused line
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E616D65206F66207468697320666F726D61747465722E
		Function Name() As String
		  /// The name of this formatter.
		  
		  Return "Markdown"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446F6573206E6F7468696E6720696E204D61726B646F776E20646F63756D656E74732E
		Function NearestDelimitersForCaretPos(caretPos As Integer) As XUICEDelimiter
		  /// Does nothing in Markdown documents.
		  ///
		  /// Part of the `XUICEFormatter` interface. Used to return the nearest delimiters at the 
		  /// given `caretPos`. May be Nil.
		  
		  #Pragma Unused caretPos
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C656420706572696F646963616C6C792062792074686520656469746F722E20416E206F70706F7274756E69747920746F2070617273652074686520746F6B656E69736564206C696E65732E2057696C6C20616C776179732062652063616C6C656420616674657220746865206C696E65732068617665206265656E20746F6B656E697365642E
		Sub Parse(lines() As XUICELine)
		  /// Called periodically by the editor. An opportunity to parse the tokenised lines. 
		  /// Will always be called after the lines have been tokenised.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  #Pragma Unused lines
		  
		  // We do nothing here as parsing is done within `TokeniseAll()`.
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsDelimiterHighlighting() As Boolean
		  /// True if this formatter supports highlighting the delimiters around the caret.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320666F726D617474657220686967686C696768747320756E6D61746368656420626C6F636B732E
		Function SupportsUnmatchedBlockHighlighting() As Boolean
		  /// True if this formatter highlights unmatched blocks.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 547275652069662060746F6B656E6020697320636F6E7369646572656420746F206265206120636F6D6D656E742E
		Function TokenIsComment(token As XUICELineToken) As Boolean
		  /// True if `token` is considered to be a comment.
		  
		  #Pragma Unused token
		  
		  // As this is a Markdown formatter, there is no such thing as a comment.
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E69736573206120706F7274696F6E206F6620606C696E6573602E
		Sub Tokenise(lines() As XUICELine, firstVisibleLineNumber As Integer, lastVisibleLineNumber As Integer)
		  /// Tokenises a portion of `lines`.
		  ///
		  /// Note that we tokenise all lines, even though this method is passed the visible line numbers.
		  ///
		  /// Part of the `XUIFormatter` interface.
		  
		  #Pragma Unused firstVisibleLineNumber
		  #Pragma Unused lastVisibleLineNumber
		  
		  TokeniseAll(lines)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E6973657320616E206172726179206F66206C696E65732E
		Sub TokeniseAll(lines() As XUICELine)
		  /// Tokenises an array of lines.
		  ///
		  /// Part of the `XUICEFormatter` interface.
		  
		  // Parse the entire contents to an AST.
		  If mParser = Nil Then mParser = New MarkdownKit.MKParser
		  mDoc = mParser.ParseLines(lines)
		  
		  mLines = lines
		  
		  // Remove all tokens from every line.
		  For Each line As XUICELine In mLines
		    line.Tokens.RemoveAll
		  Next line
		  
		  // Walk the AST.
		  Call VisitDocument(mDoc)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620616C6C20746F6B656E2074797065732075736564206279207468697320666F726D61747465722E
		Function TokenTypes() As String()
		  /// Returns an array of all token types used by this formatter.
		  
		  Return Array( _
		  TOKEN_ATX_DELIMITER_LEVEL1, _
		  TOKEN_ATX_DELIMITER_LEVEL2, _
		  TOKEN_ATX_DELIMITER_LEVEL3, _
		  TOKEN_ATX_DELIMITER_LEVEL4, _
		  TOKEN_ATX_DELIMITER_LEVEL5, _
		  TOKEN_ATX_DELIMITER_LEVEL6, _
		  TOKEN_ATX_LEVEL1, _
		  TOKEN_ATX_LEVEL2, _
		  TOKEN_ATX_LEVEL3, _
		  TOKEN_ATX_LEVEL4, _
		  TOKEN_ATX_LEVEL5, _
		  TOKEN_ATX_LEVEL6, _
		  TOKEN_BLOCKQUOTE_DELIMITER, _
		  TOKEN_CODESPAN, _
		  TOKEN_CODE_LINE, _
		  TOKEN_CODESPAN_DELIMITER, _
		  TOKEN_DEFAULT, _
		  TOKEN_EMPHASIS, _
		  TOKEN_EMPHASIS_DELIMITER, _
		  TOKEN_FENCE_DELIMITER, _
		  TOKEN_INFO_STRING, _
		  TOKEN_INLINE_HTML, _
		  TOKEN_INLINE_LINK_LABEL, _
		  TOKEN_LINK_DESTINATION, _
		  TOKEN_LINK_DESTINATION_DELIMITER, _
		  TOKEN_LINK_LABEL_DELIMITER, _
		  TOKEN_LINK_TITLE, _
		  TOKEN_LINK_TITLE_DELIMITER, _
		  TOKEN_LIST_MARKER, _
		  TOKEN_SETEXTUNDERLINE_LEVEL1, _
		  TOKEN_SETEXT_LEVEL1, _
		  TOKEN_SETEXTUNDERLINE_LEVEL2, _
		  TOKEN_SETEXT_LEVEL2, _
		  TOKEN_STRONG, _
		  TOKEN_STRONG_AND_EMPHASIS, _
		  TOKEN_STRONG_DELIMITER, _
		  TOKEN_THEMATIC_BREAK _
		  )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E204154582068656164696E672E
		Function VisitATXHeading(atx As MarkdownKit.MKATXHeadingBlock) As Variant
		  /// The renderer is visiting an ATX heading.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  IsWithinATXHeading = True
		  ATXHeadingLevel = atx.Level
		  
		  Var line As XUICELine = mLines(atx.LineNumber - 1)
		  
		  // Opening sequence.
		  Var type As String
		  Select Case ATXHeadingLevel
		  Case 1
		    type = TOKEN_ATX_DELIMITER_LEVEL1
		  Case 2
		    type = TOKEN_ATX_DELIMITER_LEVEL2
		  Case 3
		    type = TOKEN_ATX_DELIMITER_LEVEL3
		  Case 4
		    type = TOKEN_ATX_DELIMITER_LEVEL4
		  Case 5
		    type = TOKEN_ATX_DELIMITER_LEVEL5
		  Case 6
		    type = TOKEN_ATX_DELIMITER_LEVEL6
		  End Select
		  
		  line.Tokens.Add(New XUICELineToken(atx.OpeningSequenceAbsoluteStart, atx.OpeningSequenceLocalStart, _
		  atx.Level, atx.LineNumber, type))
		  
		  For Each child As MarkdownKit.MKBlock In atx.Children
		    Call child.Accept(Self)
		  Next child
		  
		  IsWithinATXHeading = False
		  
		  // Closing sequence.
		  If atx.HasClosingSequence Then
		    line.Tokens.Add(New XUICELineToken(atx.ClosingSequenceAbsoluteStart, atx.ClosingSequenceLocalStart, _
		    atx.ClosingSequenceCount, atx.LineNumber, type))
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E67206120626C6F636B2E
		Function VisitBlock(b As MarkdownKit.MKBlock) As Variant
		  /// The renderer is visiting a block.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  // Nothing to do.
		  
		  #Pragma Unused b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E67206120626C6F636B2071756F74652E
		Function VisitBlockQuote(bq As MarkdownKit.MKBlockQuote) As Variant
		  /// The renderer is visiting a block quote.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  // Add the block quote opening delimiters.
		  For Each delimiter As MarkdownKit.MKCharacter In bq.OpeningDelimiters
		    Var line As XUICELine = mLines(delimiter.Line.Number - 1)
		    line.Tokens.Add(New XUICELineToken(delimiter.AbsolutePosition, delimiter.LocalPosition, 1, _
		    delimiter.Line.Number, TOKEN_BLOCKQUOTE_DELIMITER))
		  Next delimiter
		  
		  For Each child As MarkdownKit.MKBlock In bq.Children
		    Call child.Accept(Self)
		  Next child
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E67206120636F6465207370616E2E
		Function VisitCodeSpan(cs As MarkdownKit.MKCodeSpan) As Variant
		  /// The renderer is visiting a code span.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  // Opening delimiter.
		  Var line As XUICELine = mLines(cs.OpeningBacktickChar.Line.Number - 1)
		  line.Tokens.Add(New XUICELineToken(cs.OpeningBacktickChar.AbsolutePosition, cs.OpeningBacktickChar.LocalPosition, _
		  cs.BacktickStringLength, _
		  cs.OpeningBacktickChar.Line.Number, TOKEN_CODESPAN_DELIMITER))
		  
		  IsWithinCodeSpan = True
		  
		  For Each child As MarkdownKit.MKBlock In cs.Children
		    Call child.Accept(Self)
		  Next child
		  
		  IsWithinCodeSpan = False
		  
		  // Closing delimiter.
		  line = mLines(cs.FirstClosingBacktickChar.Line.Number - 1)
		  line.Tokens.Add(New XUICELineToken(cs.FirstClosingBacktickChar.AbsolutePosition, _
		  cs.FirstClosingBacktickChar.LocalPosition, _
		  cs.BacktickStringLength, cs.FirstClosingBacktickChar.Line.Number, TOKEN_CODESPAN_DELIMITER))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061204D61726B646F776E20646F63756D656E742E
		Function VisitDocument(doc As MarkdownKit.MKDocument) As Variant
		  /// The renderer is visiting a Markdown document.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  
		  InEmphasis = False
		  InStrongEmphasis = False
		  IsWithinCodeSpan = False
		  IsWithinATXHeading = False
		  ATXHeadingLevel = 1
		  IsWithinSetextHeading = False
		  SetextHeadingLevel = 1
		  
		  For Each child As MarkdownKit.MKBlock In doc.Children
		    Call child.Accept(Self)
		  Next child
		  
		  HandleReferenceLinkDefinitions(doc)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E20656D706861736973206E6F64652E
		Function VisitEmphasis(e As MarkdownKit.MKEmphasis) As Variant
		  /// The renderer is visiting an emphasis node.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  Var wasInEmphasis As Boolean = InEmphasis
		  
		  InEmphasis = True
		  
		  // Opening delimiter.
		  Var line As XUICELine = mLines(e.OpeningDelimiterLineNumber - 1)
		  line.Tokens.Add(New XUICELineToken( _
		  e.OpeningDelimiterAbsoluteStart, e.OpeningDelimiterLocalStart, 1, e.OpeningDelimiterLineNumber, _
		  TOKEN_EMPHASIS_DELIMITER))
		  
		  For Each child As MarkdownKit.MKBlock In e.Children
		    Call child.Accept(Self)
		  Next child
		  
		  // Closing delimiter.
		  line = mLines(e.ClosingDelimiterLineNumber - 1)
		  line.Tokens.Add(New XUICELineToken( _
		  e.ClosingDelimiterAbsoluteStart, e.ClosingDelimiterLocalStart, 1, e.ClosingDelimiterLineNumber, _
		  TOKEN_EMPHASIS_DELIMITER))
		  
		  InEmphasis = wasInEmphasis
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720736F6D652066656E63656420636F64652E
		Function VisitFencedCode(fc As MarkdownKit.MKFencedCodeBlock) As Variant
		  /// The renderer is visiting some fenced code.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  // Opening delimiter.
		  Var line As XUICELine = mLines(fc.LineNumber - 1)
		  line.Tokens.Add(New XUICELineToken(fc.Start, fc.OpeningFenceLocalStart, fc.FenceLength, _
		  fc.LineNumber, TOKEN_FENCE_DELIMITER))
		  
		  // Info string?
		  If fc.HasInfoString Then
		    line.Tokens.Add(New XUICELineToken(fc.InfoStringStart, fc.InfoStringLocalStart, _
		    fc.InfoStringLength, fc.LineNumber, TOKEN_INFO_STRING))
		  End If
		  
		  // Contents.
		  For Each child As MarkdownKit.MKBlock In fc.Children
		    Var codeLine As MarkdownKit.MKTextBlock = MarkdownKit.MKTextBlock(child)
		    XUICELine(codeLine.Line).Tokens.Add(New XUICELineToken(codeLine.Start, codeLine.LocalStart, _
		    codeLine.Contents.CharacterCount, codeLine.Line.Number, TOKEN_CODE_LINE))
		  Next child
		  
		  // Closing delimiter.
		  If fc.ClosingFenceLineNumber <> -1 Then
		    line = mLines(fc.ClosingFenceLineNumber - 1)
		    line.Tokens.Add(New XUICELineToken(fc.ClosingFenceStart, fc.ClosingFenceLocalStart, _
		    fc.FenceLength, fc.ClosingFenceLineNumber, TOKEN_FENCE_DELIMITER))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E2048544D4C20626C6F636B2E
		Function VisitHTMLBlock(html As MarkdownKit.MKHTMLBlock) As Variant
		  /// The renderer is visiting an HTML block.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  For Each child As MarkdownKit.MKBlock In html.Children
		    Call child.Accept(Self)
		  Next child
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720736F6D6520696E64656E74656420636F64652E
		Function VisitIndentedCode(ic As MarkdownKit.MKIndentedCodeBlock) As Variant
		  /// The renderer is visiting some indented code.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  For Each child As MarkdownKit.MKBlock In ic.Children
		    Var codeLine As MarkdownKit.MKTextBlock = MarkdownKit.MKTextBlock(child)
		    XUICELine(codeLine.Line).Tokens.Add(New XUICELineToken(codeLine.Start, codeLine.LocalStart, _
		    codeLine.Contents.CharacterCount, codeLine.Line.Number, TOKEN_CODE_LINE))
		  Next child
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720736F6D6520696E6C696E652048544D4C2E20636F64652E
		Function VisitInlineHTML(html As MarkdownKit.MKInlineHTML) As Variant
		  /// The renderer is visiting some inline HTML. code.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  For Each child As MarkdownKit.MKBlock In html.Children
		    Var tb As MarkdownKit.MKTextBlock = MarkdownKit.MKTextBlock(child)
		    Var line As XUICELine = mLines(tb.Line.Number - 1)
		    line.Tokens.Add(New XUICELineToken(tb.Start, tb.LocalStart, tb.Contents.CharacterCount, _
		    tb.Line.Number, TOKEN_INLINE_HTML))
		  Next child
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E20696E6C696E6520696D6167652E
		Function VisitInlineImage(image As MarkdownKit.MKInlineImage) As Variant
		  /// The renderer is visiting an inline image.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  ///
		  /// Link types:  
		  /// ```nohighlight
		  /// Shortcut: `![foo]`
		  /// Collapsed: `![foo][]`
		  /// Full: `![foo](foo.com)`
		  /// ```
		  
		  Var line As XUICELine
		  
		  // ===============
		  // LINK LABEL
		  // ===============
		  // `![`
		  line = XUICELine(image.OpenerCharacter.Line)
		  line.Tokens.Add(New XUICELineToken(image.OpenerCharacter.AbsolutePosition, image.OpenerCharacter.LocalPosition, _
		  2, image.OpenerCharacter.Line.Number, TOKEN_LINK_LABEL_DELIMITER))
		  
		  // Link label text.
		  line = mLines(image.LineNumber - 1)
		  line.Tokens.Add(New XUICELineToken(image.Characters(0).AbsolutePosition, image.Characters(0).LocalPosition, _
		  image.Characters.Count, image.LineNumber, TOKEN_INLINE_LINK_LABEL))
		  
		  // `]`
		  line = XUICELine(image.CloserCharacter.Line)
		  line.Tokens.Add(New XUICELineToken(image.CloserCharacter.AbsolutePosition, image.CloserCharacter.LocalPosition, _
		  1, image.CloserCharacter.Line.Number, TOKEN_LINK_LABEL_DELIMITER))
		  
		  // ===============
		  // DESTINATION
		  // ===============
		  If image.LinkType = MarkdownKit.MKLinkTypes.ShortcutReference Then
		    // Nothing else to do.
		    Return Nil
		    
		  ElseIf image.LinkType = MarkdownKit.MKLinkTypes.CollapsedReference Then
		    // `[]` follows immediately the closing `]` of the link label.
		    line = XUICELine(image.CloserCharacter.Line)
		    line.Tokens.Add(New XUICELineToken(image.CloserCharacter.AbsolutePosition + 1, image.CloserCharacter.LocalPosition + 1, _
		    2, image.CloserCharacter.Line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		    
		  ElseIf image.LinkType = MarkdownKit.MKLinkTypes.Standard Then
		    // `(`
		    Var destOpener As MarkdownKit.MKCharacter = image.Destination.StartCharacter
		    line = XUICELine(destOpener.Line)
		    line.Tokens.Add(New XUICELineToken(destOpener.AbsolutePosition, destOpener.LocalPosition, 1, _
		    destOpener.Line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		    
		    // Destination.
		    If image.HasDestination Then
		      // +1 since `StartCharacter` is the destination opening delimiter `(`.
		      line = mLines(image.LineNumber - 1)
		      Var destStart As MarkdownKit.MKCharacter = image.Destination.StartCharacter
		      line.Tokens.Add(New XUICELineToken(destStart.AbsolutePosition + 1, destStart.LocalPosition + 1, _
		      image.Destination.Length, image.LineNumber, TOKEN_LINK_DESTINATION))
		    End If
		    
		    If Not image.HasTitle Then
		      // `)`
		      Var destCloser As MarkdownKit.MKCharacter = image.Destination.EndCharacter
		      line = XUICELine(destCloser.Line)
		      line.Tokens.Add(New XUICELineToken(destCloser.AbsolutePosition, destCloser.LocalPosition, 1, _
		      destCloser.Line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		    End If
		    
		  ElseIf image.LinkType = MarkdownKit.MKLinkTypes.FullReference Then
		    // [linkLabel][referenceLinkDestination]
		    // '['
		    Var destOpener As MarkdownKit.MKCharacter = image.FullReferenceDestinationOpener
		    line = XUICELine(destOpener.Line)
		    line.Tokens.Add(New XUICELineToken(destOpener.AbsolutePosition, destOpener.LocalPosition, 1, _
		    line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		    
		    // Reference link name.
		    line.Tokens.Add(New XUICELineToken(destOpener.AbsolutePosition, destOpener.LocalPosition + 1, _
		    image.FullReferenceLabelLength, line.Number, TOKEN_LINK_DESTINATION))
		    
		    // `]`
		    Var destCloser As MarkdownKit.MKCharacter = image.FullReferenceDestinationCloser
		    line = XUICELine(destCloser.Line)
		    line.Tokens.Add(New XUICELineToken(destCloser.AbsolutePosition, destCloser.LocalPosition, 1, _
		    line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		  End If
		  
		  // ===============
		  // TITLE
		  // ===============
		  If image.LinkType = MarkdownKit.MKLinkTypes.Standard And image.HasTitle Then
		    // Opening delimiter.
		    Var titleOpener As MarkdownKit.MKCharacter = image.Title.OpeningDelimiter
		    line = XUICELine(titleOpener.Line)
		    line.Tokens.Add(New XUICELineToken(titleOpener.AbsolutePosition, titleOpener.LocalPosition, 1, _
		    titleOpener.Line.Number, TOKEN_LINK_TITLE_DELIMITER))
		    
		    // Title.
		    For Each vb As MarkdownKit.MKLinkTitleBlock In image.Title.ValueBlocks
		      line = mLines(vb.LineNumber - 1)
		      line.Tokens.Add(New XUICELineToken(vb.AbsoluteStart, vb.LocalStart, vb.Length, _
		      vb.LineNumber, TOKEN_LINK_TITLE))
		    Next vb
		    
		    // Closing delimiter.
		    Var titleCloser As MarkdownKit.MKCharacter = image.Title.ClosingDelimiter
		    line = XUICELine(titleCloser.Line)
		    line.Tokens.Add(New XUICELineToken(titleCloser.AbsolutePosition, titleCloser.LocalPosition, 1, _
		    titleCloser.Line.Number, TOKEN_LINK_TITLE_DELIMITER))
		    
		    // `)`
		    Var linkCloser As MarkdownKit.MKCharacter = image.Destination.EndCharacter
		    line = XUICELine(linkCloser.Line)
		    line.Tokens.Add(New XUICELineToken(linkCloser.AbsolutePosition, linkCloser.LocalPosition, 1, _
		    linkCloser.Line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E20696E6C696E65206C696E6B2E
		Function VisitInlineLink(link As MarkdownKit.MKInlineLink) As Variant
		  /// The renderer is visiting an inline link.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  ///
		  /// Link types:  
		  ///
		  /// ```nohighlight
		  /// Shortcut: `[foo]`
		  /// Collapsed: `[foo][]`
		  /// Full: `[foo](foo.com)`
		  /// ```
		  
		  Var line As XUICELine
		  
		  // ===============
		  // LINK LABEL
		  // ===============
		  // `[`
		  line = XUICELine(link.OpenerCharacter.Line)
		  line.Tokens.Add(New XUICELineToken(link.OpenerCharacter.AbsolutePosition, link.OpenerCharacter.LocalPosition, _
		  1, link.OpenerCharacter.Line.Number, TOKEN_LINK_LABEL_DELIMITER))
		  
		  // Link label text.
		  For Each char As MarkdownKit.MKCharacter In link.Label.Characters
		    If Not char.IsLineEnding Then
		      XUICELine(char.Line).Tokens.Add(New XUICELineToken(char.AbsolutePosition, char.LocalPosition, 1, char.Line.Number, TOKEN_INLINE_LINK_LABEL))
		    End If
		  Next char
		  
		  // `]`
		  line = XUICELine(link.CloserCharacter.Line)
		  line.Tokens.Add(New XUICELineToken(link.CloserCharacter.AbsolutePosition, link.CloserCharacter.LocalPosition, _
		  1, link.CloserCharacter.Line.Number, TOKEN_LINK_LABEL_DELIMITER))
		  
		  // ===============
		  // DESTINATION
		  // ===============
		  If link.LinkType = MarkdownKit.MKLinkTypes.ShortcutReference Then
		    // Nothing else to do.
		    Return Nil
		    
		  ElseIf link.LinkType = MarkdownKit.MKLinkTypes.CollapsedReference Then
		    // `[]` follows immediately the closing `]` of the link label.
		    line = XUICELine(link.CloserCharacter.Line)
		    line.Tokens.Add(New XUICELineToken(link.CloserCharacter.AbsolutePosition + 1, link.CloserCharacter.LocalPosition + 1, _
		    2, link.CloserCharacter.Line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		    
		  ElseIf link.LinkType = MarkdownKit.MKLinkTypes.Standard Then
		    // `(`
		    Var destOpener As MarkdownKit.MKCharacter = link.Destination.StartCharacter
		    line = XUICELine(destOpener.Line)
		    line.Tokens.Add(New XUICELineToken(destOpener.AbsolutePosition, destOpener.LocalPosition, 1, _
		    destOpener.Line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		    
		    // Destination.
		    If link.HasDestination Then
		      // +1 since `StartCharacter` is the destination opening delimiter `(`.
		      line = mLines(link.LineNumber - 1)
		      Var destStart As MarkdownKit.MKCharacter = link.Destination.StartCharacter
		      line.Tokens.Add(New XUICELineToken(destStart.AbsolutePosition + 1, destStart.LocalPosition + 1, _
		      link.Destination.Length, link.LineNumber, TOKEN_LINK_DESTINATION))
		    End If
		    
		    If Not link.HasTitle Then
		      // `)`
		      Var destCloser As MarkdownKit.MKCharacter = link.Destination.EndCharacter
		      line = XUICELine(destCloser.Line)
		      line.Tokens.Add(New XUICELineToken(destCloser.AbsolutePosition, destCloser.LocalPosition, 1, _
		      destCloser.Line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		    End If
		    
		  ElseIf link.LinkType = MarkdownKit.MKLinkTypes.FullReference Then
		    // [linkLabel][referenceLinkDestination]
		    // '['
		    Var destOpener As MarkdownKit.MKCharacter = link.FullReferenceDestinationOpener
		    line = XUICELine(destOpener.Line)
		    line.Tokens.Add(New XUICELineToken(destOpener.AbsolutePosition, destOpener.LocalPosition, 1, _
		    line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		    
		    // Reference link name.
		    line.Tokens.Add(New XUICELineToken(destOpener.AbsolutePosition, destOpener.LocalPosition + 1, _
		    link.FullReferenceLabelLength, line.Number, TOKEN_LINK_DESTINATION))
		    
		    // `]`
		    Var destCloser As MarkdownKit.MKCharacter = link.FullReferenceDestinationCloser
		    line = XUICELine(destCloser.Line)
		    line.Tokens.Add(New XUICELineToken(destCloser.AbsolutePosition, destCloser.LocalPosition, 1, _
		    line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		  End If
		  
		  // ===============
		  // TITLE
		  // ===============
		  If link.LinkType = MarkdownKit.MKLinkTypes.Standard And link.HasTitle Then
		    // Opening delimiter.
		    Var titleOpener As MarkdownKit.MKCharacter = link.Title.OpeningDelimiter
		    line = XUICELine(titleOpener.Line)
		    line.Tokens.Add(New XUICELineToken(titleOpener.AbsolutePosition, titleOpener.LocalPosition, 1, _
		    titleOpener.Line.Number, TOKEN_LINK_TITLE_DELIMITER))
		    
		    // Title.
		    For Each vb As MarkdownKit.MKLinkTitleBlock In link.Title.ValueBlocks
		      line = mLines(vb.LineNumber - 1)
		      line.Tokens.Add(New XUICELineToken(vb.AbsoluteStart, vb.LocalStart, vb.Length, _
		      vb.LineNumber, TOKEN_LINK_TITLE))
		    Next vb
		    
		    // Closing delimiter.
		    Var titleCloser As MarkdownKit.MKCharacter = link.Title.ClosingDelimiter
		    line = XUICELine(titleCloser.Line)
		    line.Tokens.Add(New XUICELineToken(titleCloser.AbsolutePosition, titleCloser.LocalPosition, 1, _
		    titleCloser.Line.Number, TOKEN_LINK_TITLE_DELIMITER))
		    
		    // `)`
		    Var linkCloser As MarkdownKit.MKCharacter = link.Destination.EndCharacter
		    line = XUICELine(linkCloser.Line)
		    line.Tokens.Add(New XUICELineToken(linkCloser.AbsolutePosition, linkCloser.LocalPosition, 1, _
		    linkCloser.Line.Number, TOKEN_LINK_DESTINATION_DELIMITER))
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720736F6D6520696E6C696E6520746578742E
		Function VisitInlineText(it As MarkdownKit.MKInlineText) As Variant
		  /// The renderer is visiting some inline text.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  Var type As String
		  
		  If IsWithinATXHeading Then
		    Select Case ATXHeadingLevel
		    Case 1
		      type = TOKEN_ATX_LEVEL1
		    Case 2
		      type = TOKEN_ATX_LEVEL2
		    Case 3
		      type = TOKEN_ATX_LEVEL3
		    Case 4
		      type = TOKEN_ATX_LEVEL4
		    Case 5
		      type = TOKEN_ATX_LEVEL5
		    Case 6
		      type = TOKEN_ATX_LEVEL6
		    End Select
		    
		  ElseIf IsWithinCodeSpan Then
		    type = TOKEN_CODESPAN
		    
		  ElseIf InEmphasis And InStrongEmphasis Then
		    type = TOKEN_STRONG_AND_EMPHASIS
		    
		  ElseIf InEmphasis Then
		    type = TOKEN_EMPHASIS
		    
		  ElseIf InStrongEmphasis Then
		    type = TOKEN_STRONG
		    
		  ElseIf IsWithinSetextHeading Then
		    Select Case SetextHeadingLevel
		    Case 1
		      type = TOKEN_SETEXT_LEVEL1
		    Case 2
		      type = TOKEN_SETEXT_LEVEL2
		    End Select
		    
		  Else
		    type = TOKEN_DEFAULT
		    
		  End If
		  
		  Var line As XUICELine = mlines(it.LineNumber - 1)
		  line.Tokens.Add(New XUICELineToken(it.Start, it.LocalStart, it.Characters.Count, it.LineNumber, type))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061206C6973742E
		Function VisitList(list As MarkdownKit.MKListBlock) As Variant
		  /// The renderer is visiting a list.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  For Each child As MarkdownKit.MKBlock In list.Children
		    Call child.Accept(Self)
		  Next child
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061206C697374206974656D2E
		Function VisitListItem(item As MarkdownKit.MKListItemBlock) As Variant
		  /// The renderer is visiting a list item.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  // List marker.
		  Var line As XUICELine = mLines(item.LineNumber - 1)
		  line.Tokens.Add(New XUICELineToken(item.ListData.ListMarkerAbsolutionPosition, _
		  item.ListData.ListMarkerLocalPosition, item.ListData.Length, _
		  item.LineNumber, TOKEN_LIST_MARKER))
		  
		  // Children.
		  For Each child As MarkdownKit.MKBlock In item.Children
		    Call child.Accept(Self)
		  Next child
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720612070617261677261706820626C6F636B2E
		Function VisitParagraph(p As MarkdownKit.MKParagraphBlock) As Variant
		  /// The renderer is visiting a paragraph block.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  For Each child As MarkdownKit.MKBlock In p.Children
		    Call child.Accept(Self)
		  Next child
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061207365746578742068656164696E672E
		Function VisitSetextHeading(stx As MarkdownKit.MKSetextHeadingBlock) As Variant
		  /// The renderer is visiting a setext heading.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  IsWithinSetextHeading = True
		  SetextHeadingLevel = stx.Level
		  
		  Var type As String
		  Select Case SetextHeadingLevel
		  Case 1
		    type = TOKEN_SETEXTUNDERLINE_LEVEL1
		  Case 2
		    type = TOKEN_SETEXTUNDERLINE_LEVEL2
		  End Select
		  
		  For Each child As MarkdownKit.MKBlock In stx.Children
		    Call child.Accept(Self)
		  Next child
		  
		  IsWithinSetextHeading = False
		  
		  mLines(stx.UnderlineLineNumber - 1).Tokens.Add( _
		  New XUICELineToken(stx.UnderlineStart, stx.UnderlineLocalStart, stx.UnderlineLength, stx.UnderlineLineNumber, type))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E67206120736F667420627265616B2E
		Function VisitSoftBreak(sb As MarkdownKit.MKSoftBreak) As Variant
		  /// The renderer is visiting a soft break.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  // Nothing to do.
		  
		  #Pragma Unused sb
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061207374726F6E6720656D706861736973206E6F64652E
		Function VisitStrongEmphasis(se As MarkdownKit.MKStrongEmphasis) As Variant
		  /// The renderer is visiting a strong emphasis node.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  Var wasInStrongEmphasis As Boolean = InStrongEmphasis
		  
		  InStrongEmphasis = True
		  
		  // Opening delimiter.
		  Var line As XUICELine = mLines(se.OpeningDelimiterLineNumber - 1)
		  line.Tokens.Add(New XUICELineToken( _
		  se.OpeningDelimiterAbsoluteStart, se.OpeningDelimiterLocalStart, 2, se.OpeningDelimiterLineNumber, _
		  TOKEN_STRONG_DELIMITER))
		  
		  For Each child As MarkdownKit.MKBlock In se.Children
		    Call child.Accept(Self)
		  Next child
		  
		  // Closing delimiter.
		  line = mLines(se.ClosingDelimiterLineNumber - 1)
		  line.Tokens.Add(New XUICELineToken( _
		  se.ClosingDelimiterAbsoluteStart, se.ClosingDelimiterLocalStart, 2, se.ClosingDelimiterLineNumber, _
		  TOKEN_STRONG_DELIMITER))
		  
		  InStrongEmphasis = wasInStrongEmphasis
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061207465787420626C6F636B2E
		Function VisitTextBlock(tb As MarkdownKit.MKTextBlock) As Variant
		  /// The renderer is visiting a text block.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  If tb.IsBlank Then Return Nil
		  
		  Var type As String
		  If IsWithinCodeSpan Then
		    type = TOKEN_CODESPAN
		  Else
		    type = TOKEN_DEFAULT
		  End If
		  
		  Var line As XUICELine = mLines(tb.Line.Number - 1)
		  line.Tokens.Add(New XUICELineToken(tb.Start, tb.LocalStart, tb.Contents.CharacterCount, tb.Line.Number, type))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061207468656D6174696320627265616B2E
		Function VisitThematicBreak(tb As MarkdownKit.MKThematicBreak) As Variant
		  /// The renderer is visiting a thematic break.
		  ///
		  /// Part of the `MarkdownKit.MKRenderer` interface.
		  
		  mLines(tb.LineNumber - 1).Tokens.Add( _
		  New XUICELineToken(tb.Start, tb.LocalStart, tb.Length, tb.LineNumber, TOKEN_THEMATIC_BREAK))
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A [CommonMark][1]-compliant Markdown formatter for the `XUICodeEditor`.
		
		[1]: https://spec.commonmark.org/0.29/
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 4966207468652072656E64657265722069732063757272656E746C792077697468696E20616E204154582068656164696E672C207468697320697320697473206C6576656C2E
		Private ATXHeadingLevel As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652072656E64657265722069732063757272656E746C792077697468696E20656D7068617369732E
		Private InEmphasis As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652072656E64657265722069732063757272656E746C792077697468696E207374726F6E6720656D7068617369732E
		Private InStrongEmphasis As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652072656E64657265722069732063757272656E746C792077697468696E20616E204154582068656164696E672E
		Private IsWithinATXHeading As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652072656E64657265722069732063757272656E746C792077697468696E206120636F6465207370616E2E
		Private IsWithinCodeSpan As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652072656E64657265722069732063757272656E746C792077697468696E2061207365746578742068656164696E672E
		Private IsWithinSetextHeading As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C61737420706172736564204D61726B646F776E20646F63756D656E742028415354292E
		Private mDoc As MarkdownKit.MKDocument
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206C696E657320746F20746F6B656E6973652E
		Private mLines() As XUICELine
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C204D61726B646F776E207061727365722E
		Private mParser As MarkdownKit.MKParser
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4966207468652072656E64657265722069732063757272656E746C792077697468696E2061207365746578742068656164696E672C207468697320697320697473206C6576656C2E
		Private SetextHeadingLevel As Integer = 1
	#tag EndProperty


	#tag Constant, Name = TOKEN_ATX_DELIMITER_LEVEL1, Type = String, Dynamic = False, Default = \"atxDelimiterLevel1", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2031204154582068656164696E672064656C696D69746572732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_DELIMITER_LEVEL2, Type = String, Dynamic = False, Default = \"atxDelimiterLevel2", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2032204154582068656164696E672064656C696D69746572732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_DELIMITER_LEVEL3, Type = String, Dynamic = False, Default = \"atxDelimiterLevel3", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2033204154582068656164696E672064656C696D69746572732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_DELIMITER_LEVEL4, Type = String, Dynamic = False, Default = \"atxDelimiterLevel4", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2034204154582068656164696E672064656C696D69746572732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_DELIMITER_LEVEL5, Type = String, Dynamic = False, Default = \"atxDelimiterLevel5", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2035204154582068656164696E672064656C696D69746572732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_DELIMITER_LEVEL6, Type = String, Dynamic = False, Default = \"atxDelimiterLevel6", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2036204154582068656164696E672064656C696D69746572732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_LEVEL1, Type = String, Dynamic = False, Default = \"atxLevel1", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2031204154582068656164696E6720746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_LEVEL2, Type = String, Dynamic = False, Default = \"atxLevel2", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2032204154582068656164696E6720746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_LEVEL3, Type = String, Dynamic = False, Default = \"atxLevel3", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2033204154582068656164696E6720746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_LEVEL4, Type = String, Dynamic = False, Default = \"atxLevel4", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2034204154582068656164696E6720746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_LEVEL5, Type = String, Dynamic = False, Default = \"atxLevel5", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2035204154582068656164696E6720746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_ATX_LEVEL6, Type = String, Dynamic = False, Default = \"atxLevel6", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2036204154582068656164696E6720746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_BLOCKQUOTE_DELIMITER, Type = String, Dynamic = False, Default = \"blockQuoteDelimiter", Scope = Public, Description = 5573656420666F7220626C6F636B2071756F74652064656C696D69746572732028603E60292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_CODESPAN, Type = String, Dynamic = False, Default = \"codespan", Scope = Public, Description = 5573656420666F7220746578742077697468696E206120636F6465207370616E2E
	#tag EndConstant

	#tag Constant, Name = TOKEN_CODESPAN_DELIMITER, Type = String, Dynamic = False, Default = \"codespanDelimiter", Scope = Public, Description = 5573656420666F7220636F64657370616E2064656C696D6974657273202860602060206060292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_CODE_LINE, Type = String, Dynamic = False, Default = \"codeLine", Scope = Public, Description = 5573656420666F7220636F6465206C696E657320696E20696E64656E74656420616E642066656E63656420636F646520626C6F636B732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_DEFAULT, Type = String, Dynamic = False, Default = \"default", Scope = Public, Description = 5573656420666F722064656661756C7420746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_EMPHASIS, Type = String, Dynamic = False, Default = \"emphasis", Scope = Public, Description = 5573656420666F7220656D70686173697320696E6C696E6520746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_EMPHASIS_DELIMITER, Type = String, Dynamic = False, Default = \"emphasisDelimiter", Scope = Public, Description = 5573656420666F7220656D7068617369732064656C696D69746572732028652E673A20602A6020616E6420605F60292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_FENCE_DELIMITER, Type = String, Dynamic = False, Default = \"fenceDelimiter", Scope = Public, Description = 5573656420666F72207468652064656C696D69746572732061726F756E6420636F64652066656E636573202860602060606020606020616E6420607E7E7E60292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_INFO_STRING, Type = String, Dynamic = False, Default = \"infoString", Scope = Public, Description = 5573656420666F7220696E666F20737472696E677320696E20636F64652066656E6365732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_INLINE_HTML, Type = String, Dynamic = False, Default = \"inlineHTML", Scope = Public, Description = 5573656420666F7220696E6C696E652048544D4C2028652E673A20603C613E60292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_INLINE_LINK_LABEL, Type = String, Dynamic = False, Default = \"inlineLinkLabel", Scope = Public, Description = 5573656420666F72207468652074657874206F6620696E6C696E65206C696E6B20616E6420696D616765206C6162656C732E20466F72206578616D706C653A2060215B6C696E6B4C6162656C5D2864657374696E6174696F6E29602E
	#tag EndConstant

	#tag Constant, Name = TOKEN_LINK_DESTINATION, Type = String, Dynamic = False, Default = \"linkDestination", Scope = Public, Description = 5573656420666F7220696E6C696E6520616E64207265666572656E6365206C696E6B2064657374696E6174696F6E732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_LINK_DESTINATION_DELIMITER, Type = String, Dynamic = False, Default = \"linkDestinationDelimiter", Scope = Public, Description = 5573656420666F72207468652064656C696D69746572732061726F756E64207468652064657374696E6174696F6E20696E20696E6C696E65206C696E6B7320616E6420696D616765732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_LINK_LABEL_DELIMITER, Type = String, Dynamic = False, Default = \"linkLabelDelimiter", Scope = Public, Description = 5573656420666F72207468652064656C696D69746572732061726F756E6420696E6C696E6520616E64207265666572656E636520646566696E6974696F6E206C696E6B206C6162656C732028605B6020616E6420605D60292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_LINK_TITLE, Type = String, Dynamic = False, Default = \"linkTitle", Scope = Public, Description = 5573656420666F7220696E6C696E65206C696E6B20616E6420696D616765207469746C65732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_LINK_TITLE_DELIMITER, Type = String, Dynamic = False, Default = \"linkTitleDelimiter", Scope = Public, Description = 5573656420666F72207468652064656C696D69746572732061726F756E64206C696E6B207469746C657320696E20696E6C696E65206C696E6B7320616E6420696D616765732028605B6020616E6420605D60292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_LIST_MARKER, Type = String, Dynamic = False, Default = \"listMarker", Scope = Public, Description = 5573656420666F72206C697374206D61726B6572732028652E673A20602D602C2060312E602C20602B602C20657463292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_SETEXTUNDERLINE_LEVEL1, Type = String, Dynamic = False, Default = \"setextUnderlineLevel1", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F722074686520756E6465726C696E696E67206F66206C6576656C2031207365746578742068656164696E67732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_SETEXTUNDERLINE_LEVEL2, Type = String, Dynamic = False, Default = \"setextUnderlineLevel2", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F722074686520756E6465726C696E696E67206F66206C6576656C2032207365746578742068656164696E67732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_SETEXT_LEVEL1, Type = String, Dynamic = False, Default = \"setextLevel1", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2031207365746578742068656164696E67732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_SETEXT_LEVEL2, Type = String, Dynamic = False, Default = \"setextLevel2", Scope = Public, Description = 54686520746F6B656E2074797065207573656420666F72206C6576656C2032207365746578742068656164696E67732E
	#tag EndConstant

	#tag Constant, Name = TOKEN_STRONG, Type = String, Dynamic = False, Default = \"strong", Scope = Public, Description = 5573656420666F72207374726F6E6720656D70686173697320696E6C696E6520746578742E
	#tag EndConstant

	#tag Constant, Name = TOKEN_STRONG_AND_EMPHASIS, Type = String, Dynamic = False, Default = \"strongAndEmphasis", Scope = Public, Description = 5573656420666F7220636F6D62696E6564207374726F6E6720656D70686173697320616E6420656D70686173697320696E6C696E6520746578742028652E673A20602A2A2A68656C6C6F2A2A2A60292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_STRONG_DELIMITER, Type = String, Dynamic = False, Default = \"strongDelimiter", Scope = Public, Description = 5573656420666F72207374726F6E6720656D7068617369732064656C696D69746572732028652E673A20602A2A6020616E6420605F5F60292E
	#tag EndConstant

	#tag Constant, Name = TOKEN_THEMATIC_BREAK, Type = String, Dynamic = False, Default = \"thematicBreak", Scope = Public, Description = 5573656420666F72207468656D6174696320627265616B732E
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
