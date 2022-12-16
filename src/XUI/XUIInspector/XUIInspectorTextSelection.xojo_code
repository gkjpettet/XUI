#tag Class
Protected Class XUIInspectorTextSelection
	#tag Method, Flags = &h0, Description = 52657475726E732061206465657020636C6F6E65206F662074686973206F626A6563742E
		Function Clone() As XUIInspectorTextSelection
		  /// Returns a deep clone of this object.
		  
		  Return New XUIInspectorTextSelection(Anchor, StartLocation, EndLocation)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(anchor As Integer, startPos As Integer, endPos As Integer)
		  /// Default constructor.
		  ///
		  /// - `anchor` is the 0-based location of the anchor.
		  /// - `startPos` is the 0-based start position of this selection.
		  /// - `endPos` is the 0-based end position of this selection.
		  ///
		  /// The anchor marks the position that the selection began. Typically this 
		  /// will be the caret position when the selection begins but it's not 
		  /// necessarily the same as the start position.
		  /// The anchor is typically set to `-1` when it is not required.
		  
		  Self.Anchor = anchor
		  Self.StartLocation = startPos
		  Self.EndLocation = endPos
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 547275652069662060636F6C756D6E602069732077697468696E20746869732073656C656374696F6E2E
		Function ContainsColumn(column As Integer) As Boolean
		  /// True if `column` is within this selection.
		  
		  Return column >= StartLocation And column <= EndLocation
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732054727565206966206076616C7565602069732077697468696E207468652070617373656420626F756E64732E
		Private Function InRange(value As Integer, lower As Integer, upper As Integer) As Boolean
		  /// Returns True if `value` is within the passed bounds.
		  
		  Return value >= lower And value <= upper
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Represents a selection of text within the inspector.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 302D626173656420706F736974696F6E206F6620746869732073656C656374696F6E277320616E63686F7220286F726967696E616C206361726574207374617274696E6720706F736974696F6E292E
		Anchor As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 302D626173656420656E6420706F736974696F6E206F66207468697320746578742073656C656374696F6E2E
		EndLocation As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C656E677468206F6620746869732073656C656374696F6E2E
		#tag Getter
			Get
			  Return EndLocation - StartLocation
			  
			End Get
		#tag EndGetter
		Length As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 302D626173656420737461727420706F736974696F6E206F6620746869732073656C656374696F6E2E
		StartLocation As Integer = 0
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
			Name="Anchor"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EndLocation"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartLocation"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
