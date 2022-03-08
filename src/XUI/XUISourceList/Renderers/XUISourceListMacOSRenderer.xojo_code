#tag Class
Protected Class XUISourceListMacOSRenderer
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

	#tag Method, Flags = &h0, Description = 4472617720746865206261636B67726F756E64206F66207468652073706563696669656420656D70747920726F772E
		Sub RenderBackground(g As Graphics, row As Integer)
		  /// Draw the background of the specified empty row. 
		  ///
		  /// Part of the XUISourceListRenderer interface.
		  
		  g.DrawingColor = Owner.Style.BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E6465727320606974656D6020746F207468652070617373656420677261706869637320636F6E746578742E2054686520636F6E746578742069732074686520656E7469726520726F7720746865206974656D206F636375706965732E
		Sub RenderItem(item As XUISourceListItem, g As Graphics)
		  /// Renders `item` to the passed graphics context. The context is the entire row the item occupies.
		  ///
		  /// Part of the `XUISourceListRenderer` interface.
		  
		  #Pragma Warning "TODO"
		  
		  // Render sections differently.
		  If item.IsSection Then
		    RenderSection(item, g)
		    Return
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656E6465727320606974656D6020617320612073656374696F6E20746F207468652070617373656420677261706869637320636F6E746578742E
		Private Sub RenderSection(item As XUISourceListItem, g As Graphics)
		  /// Renders `item` as a section to the passed graphics context.
		  ///
		  /// Assumes `g` is the graphics context provided by the `PaintCellBackground` event.
		  
		  #Pragma Warning "TODO"
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F2074686520736F75726365206C697374207468617420746869732072656E6465726572206F70657261746573206F6E2E
		Private mOwner As WeakRef
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
			Name="mOwner"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
