#tag Class
Protected Class XUITabBarRendererSafari
Implements XUITabBarRenderer
	#tag Method, Flags = &h0
		Sub Constructor(owner As XUITabBar2)
		  /// Part of the XUITabBarRenderer interface.
		  
		  If owner = Nil Then
		    mOwner = Nil
		  Else
		    mOwner = New WeakRef(owner)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468206F6620746865206C656674206D656E7520627574746F6E2028696620737570706F7274656420627920746869732072656E6465726572292E
		Function LeftMenuButtonWidth() As Double
		  /// The width Of the left menu button (If supported by this renderer).
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207461622062617220746869732072656E6465726572206F70657261746573206F6E2E
		Function Owner() As XUITabBar2
		  /// The tab bar this renderer operates on.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  If mOwner = Nil Or mOwner.Value = Nil Then
		    Return Nil
		  Else
		    Return XUITabBar2(mOwner.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656E64657273207468652074616220626172206261636B67726F756E642E
		Sub RenderBackground(g As Graphics)
		  /// Renders the tab bar background.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  g.DrawingColor = Owner.Style.BackgroundColor
		  g.FillRectangle(0, 0, g.Width, g.Height)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207769647468204F6620746865207269676874206D656E7520627574746F6E2028496620737570706F7274656420627920746869732072656E6465726572292E
		Function RightMenuButtonWidth() As Double
		  /// The width Of the right menu button (If supported by this renderer).
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620746869732072656E646572657220737570706F7274732074686520636F6E63657074206F662061206C656674206D656E7520627574746F6E2E
		Function SupportsLeftMenuButton() As Boolean
		  /// True if this renderer supports the concept of a left menu button.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5472756520696620746869732072656E646572657220737570706F7274732074686520636F6E63657074206F662061207269676874206D656E7520627574746F6E2E
		Function SupportsRightMenuButton() As Boolean
		  /// True if this renderer supports the concept of a right menu button.
		  ///
		  /// Part of the XUITabBarRenderer interface.
		  
		  Return False
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 41207765616B207265666572656E636520746F207468652074616220626172207468617420746869732072656E6465726572206F70657261746573206F6E2E
		Private mOwner As WeakRef
	#tag EndProperty


	#tag Constant, Name = TAB_HORIZONTAL_PADDING, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant


End Class
#tag EndClass
