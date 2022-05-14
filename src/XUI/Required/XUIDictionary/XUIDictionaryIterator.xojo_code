#tag Class
Protected Class XUIDictionaryIterator
Implements Iterator
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E2052657175697265732061207265666572656E636520746F20746865206044696374696F6E617279602069742077696C6C206F7065726174652075706F6E2E
		Sub Constructor(owner As XUIDictionary)
		  /// Default constructor. Requires a reference to the `Dictionary` it will operate upon.
		  
		  mOwner = owner
		  mKeys = mOwner.Keys
		  mKeysLastIndex = mKeys.LastIndex
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  /// Part of the Iterator interface.
		  
		  Return mCurrent <= mKeysLastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  /// Part of the Iterator interface.
		  
		  mCurrent = mCurrent + 1
		  
		  Var entry As New DictionaryEntry
		  entry.Key = mKeys(mCurrent - 1)
		  entry.Value = mOwner.Value(entry.Key)
		  
		  Return entry
		End Function
	#tag EndMethod


	#tag Note, Name = About
		This class is used internally by `XUIDictionary` to provide `For...Each` loop iteration.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 506F696E74657220746F20746865206E65787420656E74727920746F2072657472696576652E
		Private mCurrent As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206F776E696E672064696374696F6E6172792773206B6579732E
		Private mKeys() As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436163686564206C61737420696E646578206F6620604B6579732829602E
		Private mKeysLastIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652064696374696F6E61727920746861742074686973206974657261746F72206973206F7065726174696E672075706F6E2E
		Private mOwner As Dictionary
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
