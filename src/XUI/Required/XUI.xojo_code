#tag Module
Protected Module XUI
	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E756D626572206F66207469636B7320746861742074776F20636C69636B73206D757374206F636375722077697468696E20746F20626520636F6E73696465726564206120646F75626C6520636C69636B2E
		Protected Function GetDoubleClickTimeTicks() As Integer
		  /// Returns the number of ticks that two clicks must occur within to be considered a double click.
		  
		  // Choose a reasonable default in case any of the declares fail.
		  Const DEFAULT_TICKS = 30 // 30 ticks = 500ms
		  
		  Var doubleClickTime As Integer
		  
		  #If TargetMacOS
		    Const CocoaLib As String = "Cocoa.framework"
		    Declare Function NSClassFromString Lib CocoaLib(aClassName As CFStringRef) As Ptr
		    Declare Function doubleClickInterval Lib CocoaLib Selector "doubleClickInterval" (aClass As Ptr) As Double
		    Try
		      Var RefToClass As Ptr = NSClassFromString("NSEvent")
		      doubleClickTime = doubleClickInterval(RefToClass) * 60
		    Catch err As ObjCException
		      doubleClickTime = DEFAULT_TICKS
		    End Try
		  #EndIf
		  
		  #If TargetWindows Then
		    Try
		      Declare Function GetDoubleClickTime Lib "User32.DLL" () As Integer
		      doubleClickTime = GetDoubleClickTime()
		      // `doubleClickTime` now holds the number of milliseconds - convert to ticks.
		      doubleClickTime = doubleClickTime / 1000.0 * 60
		    Catch e
		      doubleClickTime = DEFAULT_TICKS
		    End Try
		  #EndIf
		  
		  #If TargetLinux Then
		    Const libname = "libgtk-3"
		    Soft Declare Function gtk_settings_get_default Lib libname () As Ptr
		    Soft Declare Sub g_object_get Lib libname (Obj As Ptr, first_property_name As CString, ByRef doubleClicktime As Integer, Null As Integer)
		    If Not system.IsFunctionAvailable ("gtk_settings_get_default", libname) Then
		      doubleClickTime = DEFAULT_TICKS
		    Else
		      Var gtkSettings As Ptr = gtk_settings_get_default()
		      g_object_get (gtkSettings, "gtk-double-click-time", doubleClickTime, 0)
		      // `doubleClickTime` now holds the number of milliseconds - convert to ticks.
		      doubleClickTime = doubleClickTime / 1000.0 * 60
		    End If
		  #EndIf
		  
		  // Catch any other platforms.
		  If doubleClickTime <= 0 Then
		    doubleClickTime = DEFAULT_TICKS
		  End If
		  
		  Return doubleClickTime
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A required module that includes utility methods and enumerations used within the framework.
		
	#tag EndNote


	#tag Enum, Name = ClickTypes, Type = Integer, Flags = &h1, Description = 526570726573656E74732074686520766172696F7573207479706573206F66206D6F75736520636C69636B732E
		ContextualClick
		  DoubleClick
		  TripleClick
		SingleClick
	#tag EndEnum


End Module
#tag EndModule
