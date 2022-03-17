#tag Class
Protected Class XUISourceListRendererWindows11
Implements XUISourceListRenderer
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUISourceList)
		  If owner = Nil Then
		    mOwner = Nil
		  Else
		    mOwner = New WeakRef(owner)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520736F75726365206C697374207468617420746869732072656E6465726572206F70657261746573206F6E2E
		Function Owner() As XUISourceList
		  /// The source list that this renderer operates on.
		  ///
		  /// Part of the XUISourceListRenderer interface.
		  
		  If mOwner = Nil Or mOwner.Value = Nil Then
		    Return Nil
		  Else
		    Return XUISourceList(mOwner.Value)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4472617720746865206261636B67726F756E6420666F72207468652073706563696669656420726F772E2054686520726F77206D617920626520656D7074792E
		Sub RenderBackground(g As Graphics, row As Integer)
		  /// Draw the background for the specified row. The row may be empty.
		  ///
		  /// Part of the XUISourceListRenderer interface.
		  
		  #Pragma Warning "TODO"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320606974656D6020746F207468652070617373656420677261706869637320636F6E746578742E2054686520636F6E746578742069732074686520656E7469726520726F7720746865206974656D206F636375706965732E
		Sub RenderItem(item As XUISourceListItem, g As Graphics, hoveringOverRow As Boolean, isSelected As Boolean, draggingOverRow As Boolean)
		  /// Renders `item` to the passed graphics context. The context is the entire row the item occupies.
		  ///
		  /// Part of the `XUISourceListRenderer` interface.
		  
		  #Pragma Warning "TODO"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520686569676874206F66206120726F7720696E2074686520736F75726365206C6973742E
		Function RowHeight() As Integer
		  /// The height of a row in the source list.
		  
		  Return 30
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520736F75726365206C697374207468617420746869732072656E6465726572206F70657261746573206F6E2E
		Private mOwner As WeakRef
	#tag EndProperty


End Class
#tag EndClass
