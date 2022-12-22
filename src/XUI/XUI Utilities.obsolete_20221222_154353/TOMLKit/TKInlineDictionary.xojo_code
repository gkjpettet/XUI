#tag Class
Protected Class TKInlineDictionary
Inherits Dictionary
	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652064656C656761746520666F7220736F7274696E6720616E2061727261792E
		Private Shared Function CaseDelegate(key1 As Variant, key2 As Variant) As Integer
		  /// Internal use delegate for sorting an array.
		  
		  If key1.Type <> key2.Type Then
		    Return key1.Type - key2.Type
		  End If
		  
		  If key1.Type <> Variant.TypeString Then
		    Return key1.Hash - key2.Hash
		  End If
		  
		  Return key1.StringValue.Compare(key2.StringValue, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E7374727563746F7220746861742074616B657320616E206F7074696F6E616C206172726179206F662060656E7472696573602E
		Sub Constructor(ParamArray entries() As Pair)
		  /// Constructor that takes an optional array of `entries`.
		  
		  Super.Constructor(AddressOf CaseDelegate)
		  
		  For Each p As Pair In entries
		    Value(p.Left) = p.Right
		  Next p
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a TOML inline dictionary.
		
	#tag EndNote


	#tag ViewBehavior
		#tag ViewProperty
			Name="BinCount"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="KeyCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
