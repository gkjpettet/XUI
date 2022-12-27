#tag Module
Protected Module AppKit
	#tag Note, Name = About
		Exposes macOS-specific structures required internally by certain XUI classes.
		
	#tag EndNote


	#tag Structure, Name = CGPoint, Flags = &h0
		X As CGFloat
		Y As CGFloat
	#tag EndStructure

	#tag Structure, Name = CGRect, Flags = &h0
		Origin As CGPoint
		RectSize As CGSize
	#tag EndStructure

	#tag Structure, Name = CGSize, Flags = &h0
		Width As CGFloat
		Height As CGFloat
	#tag EndStructure


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
