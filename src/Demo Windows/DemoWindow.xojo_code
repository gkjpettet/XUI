#tag Class
Protected Class DemoWindow
Inherits DesktopWindow
	#tag Event
		Function CancelClosing(appQuitting As Boolean) As Boolean
		  // We'll simply hide the window rather than close it (unless the app is quitting).
		  
		  If Not appQuitting Then
		    Me.Visible = False
		    Return True
		  End If
		End Function
	#tag EndEvent


End Class
#tag EndClass
