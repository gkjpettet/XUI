#tag Class
Protected Class XUICELocation
	#tag Method, Flags = &h0
		Sub Constructor(line As XUICELine, caretPos As Integer, column As Integer, overLine As Boolean)
		  /// Default constructor.
		  ///
		  /// - The `line` containing this location.
		  /// - `caretPos` is the 0-based caret position at this location.
		  /// - `overLine` is `True` if the location is actually over a line (and not past 
		  ///   its left or right edge).
		  
		  Self.Line = line
		  Self.CaretPos = caretPos
		  Self.Column = column
		  Self.ActuallyOverLine = overLine
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F662074686973206C6F636174696F6E2028606C696E652C20636F6C60292E
		Function ToString() As String
		  /// Returns a string representation of this location (`line, col`).
		  
		  Return Self.Line.Number.ToString + ", " + Self.Column.ToString
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Represents a location within the code editor.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5472756520696620746865206C6F636174696F6E2069732061637475616C6C79206F76657220746865206C696E6520286E6F74206265666F7265206F72206166746572206974292E
		ActuallyOverLine As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 302D626173656420636172657420706F736974696F6E2E
		CaretPos As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 302D626173656420636F6C756D6E2E
		Column As Integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C696E65207265666572656E6365642062792074686973206C6F636174696F6E2E
		Line As XUICELine
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
			Name="Column"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActuallyOverLine"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretPos"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
