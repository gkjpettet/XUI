#tag Class
Protected Class TKInlineDictionary
Inherits Dictionary
	#tag Method, Flags = &h21
		Private Shared Function CaseDelegate(key1 As Variant, key2 As Variant) As Integer
		  If key1.Type <> key2.Type Then
		    Return key1.Type - key2.Type
		  End If
		  
		  If key1.Type <> Variant.TypeString Then
		    Return key1.Hash - key2.Hash
		  End If
		  
		  Return key1.StringValue.Compare(key2.StringValue, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParamArray entries() As Pair)
		  Super.Constructor(AddressOf CaseDelegate)
		  
		  For Each p As Pair In entries
		    Value(p.Left) = p.Right
		  Next p
		  
		End Sub
	#tag EndMethod


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
