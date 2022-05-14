#tag Class
Protected Class XUINotification
	#tag Method, Flags = &h0, Description = 5468652064656661756C7420636F6E7374727563746F722E
		Sub Constructor(sender As Variant, key As String, data As Variant = Nil)
		  /// The default constructor.
		  ///
		  /// `sender` is the object that sent this notification.  
		  /// `key` is the string key.   
		  /// `data` is optional arbitrary data.
		  
		  Self.Sender = sender
		  Self.Key = key
		  Self.Data = data
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents an in-app notification (i.e. a notification that can be passed between objects _within_ your app.
		
		Comprises a string key and optional arbitrary data. The sending of notifications is done through 
		the `NotificationCenter`.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206461746120636172726965642062792074686973206E6F74696669636174696F6E2E
		Data As Variant
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4120737472696E67206B6579206964656E74696679696E672074686973206E6F74696669636174696F6E2E
		Key As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206F626A65637420746861742073656E742074686973206E6F74696669636174696F6E2E
		Sender As Variant
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
			Name="Key"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
