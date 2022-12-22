#tag Interface
Protected Interface MKRenderer
	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E204154582068656164696E672E
		Function VisitATXHeading(atx As MarkdownKit.MKATXHeadingBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E67206120626C6F636B206E6F64652E
		Function VisitBlock(b As MarkdownKit.MKBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E67206120626C6F636B2071756F74652E
		Function VisitBlockQuote(bq As MarkdownKit.MKBlockQuote) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E67206120636F6465207370616E2E
		Function VisitCodeSpan(cs As MarkdownKit.MKCodeSpan) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720746865206D61696E204D61726B646F776E20646F63756D656E742E
		Function VisitDocument(doc As MarkdownKit.MKDocument) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E20656D706861736973206E6F64652E
		Function VisitEmphasis(e As MarkdownKit.MKEmphasis) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720612066656E63656420636F646520626C6F636B2E
		Function VisitFencedCode(fc As MarkdownKit.MKFencedCodeBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E2048544D4C20626C6F636B2E
		Function VisitHTMLBlock(html As MarkdownKit.MKHTMLBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E20696E64656E74656420636F64652066656E63652E
		Function VisitIndentedCode(ic As MarkdownKit.MKIndentedCodeBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720736F6D6520696E6C696E652048544D4C2E
		Function VisitInlineHTML(html As MarkdownKit.MKInlineHTML) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E20696E6C696E6520696D6167652E
		Function VisitInlineImage(image As MarkdownKit.MKInlineImage) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720616E20696E6C696E65206C696E6B2E
		Function VisitInlineLink(link As MarkdownKit.MKInlineLink) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720736F6D6520696E6C696E6520746578742E
		Function VisitInlineText(it As MarkdownKit.MKInlineText) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061206C6973742E
		Function VisitList(list As MarkdownKit.MKListBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061206C697374206974656D2E
		Function VisitListItem(item As MarkdownKit.MKListItemBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E6720612070617261677261706820626C6F636B2E
		Function VisitParagraph(p As MarkdownKit.MKParagraphBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061207365746578742068656164696E672E
		Function VisitSetextHeading(stx As MarkdownKit.MKSetextHeadingBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E67206120736F667420627265616B2E
		Function VisitSoftBreak(sb As MarkdownKit.MKSoftBreak) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061207374726F6E6720656D706861736973206E6F64652E
		Function VisitStrongEmphasis(se As MarkdownKit.MKStrongEmphasis) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061207465787420626C6F636B2E
		Function VisitTextBlock(tb As MarkdownKit.MKTextBlock) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072656E6465726572206973207669736974696E672061207468656D6174696320627265616B2E
		Function VisitThematicBreak(tb As MarkdownKit.MKThematicBreak) As Variant
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Classes that wish to transform the abstract syntax tree (AST) created by `MKParser` should 
		implement this interface.
		
	#tag EndNote


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
End Interface
#tag EndInterface
