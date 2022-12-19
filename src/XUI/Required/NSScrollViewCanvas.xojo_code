#tag Class
Protected Class NSScrollViewCanvas
Inherits DesktopTextInputCanvas
	#tag Event
		Sub Closing()
		  #If TargetMacOS
		    
		    RemoveObserver(NSNotificationCenter, NSScrollView)
		    
		  #EndIf
		  
		  RaiseEvent Closing
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  #If TargetMacOS
		    
		    ' LookupTable needs to exist before we do anything.
		    If LookupTable Is Nil Then
		      
		      LookupTable = New Dictionary
		      
		    End If
		    
		    ' We'll subclass NSScrollView, so we get the class
		    Var objectClass As Ptr = NSClassFromString("NSScrollView")
		    
		    ' Create an UUID for each NSScrollView / "myFlippedDocumentViewClass" instance.
		    Var oUUID As Ptr = NSClassFromString("NSUUID") 
		    Var oNSUUID As Ptr = UUID(oUUID)
		    Var sUUID As String = UUIDString(oNSUUID)
		    
		    ' Allocate a subclass of NSScrollView.
		    NSScrollViewCustom = objc_allocateClassPair(objectClass, "myCustomNSScrollViewClass" + sUUID, 0)
		    
		    ' Override the magnifyWithEvent selector.
		    Call class_addMethod(NSScrollViewCustom, _
		    NSSelectorFromString("magnifyWithEvent:"), _
		    AddressOf NSScrollViewMagnifyWithEvent, "v@:@")
		    
		    ' Add a selector to be called with NSViewBoundsDidChangeNotification.
		    Call class_addMethod(NSScrollViewCustom, _
		    NSSelectorFromString("NSViewBoundsDidChange"), _
		    AddressOf NSViewBoundsDidChange, "v@:")
		    
		    Call class_addMethod(NSScrollViewCustom, _
		    NSSelectorFromString("NSScrollerStyleChanged"), _
		    AddressOf NSScrollerStyleChanged, "v@:")
		    
		    Call class_addMethod(NSScrollViewCustom, _
		    NSSelectorFromString("NSScrollerStyleDidChange"), _
		    AddressOf NSScrollerStyleChanged, "v@:")
		    
		    ' Register the class. Then we can create instances.
		    objc_registerClassPair(NSScrollViewCustom)
		    
		    ' Create an NSView subclass.
		    objectClass = NSClassFromString("NSView")
		    
		    ' We'll also subclass NSView to override the isFlipped selector.
		    Var myFlippedDocumentViewClass As Ptr = objc_allocateClassPair(objectClass, "myFlippedDocumentViewClass" + sUUID, 0)
		    
		    ' Override the isFlipped selector with a shared method that simply returns true.
		    Call class_addMethod(myFlippedDocumentViewClass, _
		    NSSelectorFromString("isFlipped"), _
		    AddressOf NSViewIsFlipped, "B@:")
		    
		    objc_registerClassPair(myFlippedDocumentViewClass)
		    
		    ' Create the bounding rectangle.
		    Var myFrame As CGRect
		    myFrame.RectSize.Width = Self.Width
		    myFrame.RectSize.Height = Self.Height
		    
		    ' Initialize the NSScrollView subclass.
		    NSScrollView = InitWithFrame(Alloc(NSScrollViewCustom), myFrame)
		    SetAutoresizingMask(NSScrollView, 18)
		    
		    ' Initialize our NSView subclass.
		    NSDocumentView = InitWithFrame(Alloc(myFlippedDocumentViewClass), Bounds(Handle))
		    
		    ' Add the NSView as the DocumentView.
		    SetDocumentView(NSScrollView, NSDocumentView)
		    
		    ' We want to be notified when the bounds change.
		    SetPostsBoundsChangedNotifications(NSDocumentView, True)
		    
		    ' Our NSScrollView needs to be transparent.
		    SetDrawsBackground(NSScrollView, False)
		    
		    ' Do we want Scrollers?
		    If HasHorizontalScrollbar Then SetHasHorizontalScroller(NSScrollView, True)
		    If HasVerticalScrollbar Then SetHasVerticalScroller(NSScrollView, True)
		    
		    ' Initialize NSNotificationCenter.
		    NSNotificationCenter = DefaultCenter(NSClassFromString("NSNotificationCenter"))
		    
		    ' Register to receive the notifications.
		    AddObserverSelectorNameObject(NSNotificationCenter, _
		    NSScrollView, _
		    NSSelectorFromString("NSViewBoundsDidChange"), "NSViewBoundsDidChangeNotification", _
		    ContentView(NSScrollView))
		    
		    AddObserverSelectorNameObject(NSNotificationCenter, _
		    NSScrollView, _
		    NSSelectorFromString("NSScrollerStyleChanged"), "NSPreferredScrollerStyleDidChangeNotification", _
		    Nil)
		    
		    ' Add the NSScrollView as a child.
		    AddSubview(Self.Handle, NSScrollView)
		    
		    ' When the shared method is called we can find which instance of this class to work with.
		    LookupTable.Value(NSScrollView) = New WeakRef(Self)
		    
		    ' Initialize document size.
		    SetDocumentSize(Self.Width, Self.Height)
		    
		  #EndIf
		  
		  RaiseEvent Opening
		End Sub
	#tag EndEvent


	#tag ExternalMethod, Flags = &h21, Description = 52656769737465727320616E206F626A65637420746F20726563656976652061206365727461696E206E6F74696669636174696F6E2E
		Private Declare Sub AddObserverSelectorNameObject Lib kFoundation Selector "addObserver:selector:name:object:" (clss As Ptr, observer As Ptr, destSelector As Ptr, name As CFStringRef, sourceObject As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 416464732061207669657720617320612073756276696577206F66206120766965772E
		Private Declare Sub AddSubview Lib kAppKit Selector "addSubview:" (obj As Ptr, subview As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 416C6C6F6361746573206D656D6F727920666F7220616E20696E7374616E6365206F66206120636C6173732E
		Private Declare Function Alloc Lib kFoundation Selector "alloc" (obj As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 476574732074686520626F756E6473206F6620616E204E535669657720737562636C6173732E
		Private Declare Function Bounds Lib kAppKit Selector "bounds" (obj As Ptr) As CGRect
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 54656C6C73207468652072756E74696D6520746F206164642061206D6574686F6420746F206120636C6173732E
		Private Declare Function class_addMethod Lib kObjC (cls As Ptr, name As Ptr, imp As Ptr, types As CString) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 4765747320746865204E53436C697056696577206F6620616E204E535363726F6C6C566965772E
		Private Declare Function ContentView Lib kAppKit Selector "contentView" (obj As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 47657473207468652073797374656D206E6F74696669636174696F6E2063656E7465722E
		Private Declare Function DefaultCenter Lib kFoundation Selector "defaultCenter" (obj As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 52657475726E7320746865207374796C65206F66207363726F6C6C6572732074686174206170706C69636174696F6E732073686F756C642075736520776865726576657220706F737369626C652E
		Private Declare Function GetPreferredScrollerStyle Lib kAppKit Selector "preferredScrollerStyle" (id As Ptr) As NSScrollerStyles
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 496E697469616C697A657320616E20696E7374616E6365206F6620616E204E535669657720737562636C6173732E
		Private Declare Function InitWithFrame Lib kAppKit Selector "initWithFrame:" (obj As Ptr, frame As CGRect) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function Magnification Lib kAppKit Selector "magnification" (id As Ptr) As CGFloat
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 47657473206120636C617373206279206E616D652E
		Private Declare Function NSClassFromString Lib kFoundation (className As CFStringRef) As Ptr
	#tag EndExternalMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20546865207363726F6C6C6572207374796C65206368616E6765642E
		Private Shared Sub NSScrollerStyleChanged(obj As Ptr, sel As Ptr, notification As Ptr)
		  /// Internal use. The scroller style changed.
		  
		  #Pragma Unused sel
		  #Pragma Unused notification
		  
		  #If TargetMacOS
		    // Check for the `obj` key, then make sure the WeakRef is valid.
		    If LookupTable.HasKey(obj) And Not (WeakRef(LookupTable.Value(obj)).Value Is Nil) Then
		      // Cast the WeakRef value to our NSScrollView.
		      Var oNSScrollViewCanvas As NSScrollViewCanvas = NSScrollViewCanvas(WeakRef(LookupTable.Value(obj)).Value)
		      
		      // Call the instance method.
		      oNSScrollViewCanvas.PerformScrollerStyleChanged
		    End If
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20546869732069732077686572652077652068616E646C6520746865206D61676E69667920676573747572652E
		Private Shared Sub NSScrollViewMagnifyWithEvent(obj As Ptr, sel As Ptr, evt As Ptr)
		  /// Internal use. This is where we handle the magnify gesture.
		  
		  #Pragma Unused sel
		  
		  #If TargetMacOS
		    // obj is the NSScrollview, and can be used to find the `DesktopCanvas` in 
		    // our LookupTable.
		    
		    // Check for the `obj` key, then make sure the WeakRef is valid.
		    If LookupTable.HasKey(obj) And Not (WeakRef(LookupTable.Value(obj)).Value Is Nil) Then
		      // Cast the WeakRef value to our NSScrollView.
		      Var oNSScrollViewCanvas As NSScrollViewCanvas = NSScrollViewCanvas(WeakRef(LookupTable.Value(obj)).Value)
		      
		      // Call the instance method.
		      oNSScrollViewCanvas.PerformScaling(magnification(evt))
		    End If
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21, Description = 52657475726E73207468652073656C6563746F722077697468206120676976656E206E616D652E
		Private Declare Function NSSelectorFromString Lib kFoundation (selectorName As CFStringRef) As Ptr
	#tag EndExternalMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20546865207669657720626F756E647320686173206368616E6765642E
		Private Shared Sub NSViewBoundsDidChange(obj As Ptr, sel As Ptr, notification As Ptr)
		  /// Internal use. The view bounds has changed.
		  
		  #Pragma Unused sel
		  #Pragma Unused notification
		  
		  #If TargetMacOS
		    // The method we added to the NSScrollView subclass
		    // `obj` is a reference to the object receiving the notification.
		    // We could register any object to receive the notification,
		    // but we chose the NSScrollView.
		    // `sel` is the selector that was called, in this case `NSViewBoundsDidChange`
		    // because that's the selector we passed to
		    // `NSNotificationCenter addObserver:selector:name:object:`
		    //
		    // We could use the object selector on the notification object to
		    // get the NSView whose bounds changed.
		    
		    // Check for the `obj` key, then make sure the WeakRef is valid.
		    If LookupTable.HasKey(obj) And Not (WeakRef(LookupTable.Value(obj)).Value Is Nil) Then
		      // Cast the WeakRef value to our NSScrollView.
		      Var oNSScrollViewCanvas As NSScrollViewCanvas = NSScrollViewCanvas(WeakRef(LookupTable.Value(obj)).Value)
		      
		      // Call the instance method.
		      oNSScrollViewCanvas.PerformBoundsChanged
		    End If
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C206F76657272696465206D6574686F642E20416C776179732072657475726E7320547275652E
		Private Shared Function NSViewIsFlipped(obj As Ptr, sel As Ptr) As Boolean
		  // Internal use. This is the override of the view's IsFlipped selector.
		  
		  #Pragma Unused obj
		  #Pragma Unused sel
		  
		  #If TargetMacOS
		    // returning True causes the views coordinate System to behave
		    // more like Xojo's coordinate system.
		    Return True
		  #EndIf
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21, Description = 54656C6C73207468652072756E74696D6520746F20616C6C6F6361746520737061636520666F722061206E657720636C6173732E
		Private Declare Function objc_allocateClassPair Lib kObjC (superclass As Ptr, name As CString, extraBytes As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 54656C6C73207468652072756E74696D6520746F206372656174652061206E657720636C6173732E
		Private Declare Sub objc_registerClassPair Lib kObjC (cls As Ptr)
	#tag EndExternalMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E2063616C6C65642066726F6D207468652073686172656420626F756E6473206368616E676564206D6574686F642C206166746572206C6F6F6B696E672075702074686520696E7374616E636520696E20604C6F6F6B75705461626C65602E
		Private Sub PerformBoundsChanged()
		  /// Internal use. called from the shared bounds changed method, after looking 
		  /// up the instance in `LookupTable`.
		  
		  #If TargetMacOS
		    Var instance As Ptr = ContentView(NSScrollView)
		    Var oBounds As CGRect = Bounds(instance)
		    
		    Var x As Integer = oBounds.Origin.X
		    Var y As Integer = oBounds.Origin.Y
		    
		    ScrollX_ = x
		    ScrollY_ = y
		    
		    RaiseEvent NSScrollViewBoundsChanged(oBounds)
		    
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E2063616C6C65642066726F6D2074686520736861726564206D61676E696679206D6574686F642C206166746572206C6F6F6B696E672075702074686520696E7374616E636520696E20604C6F6F6B75705461626C65602E
		Private Sub PerformScaling(scaleOffset As Double)
		  /// Internal use. called from the shared magnify method, after looking 
		  /// up the instance in `LookupTable`.
		  
		  #If TargetMacOS
		    
		    RaiseEvent NSScrollViewMagnify(scaleOffset)
		    
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E2063616C6C65642066726F6D2074686520736861726564207363726F6C6C6572207374796C65206368616E676564206D6574686F642C206166746572206C6F6F6B696E672075702074686520696E7374616E636520696E20604C6F6F6B75705461626C65602E
		Private Sub PerformScrollerStyleChanged()
		  /// Internal use. called from the shared scroller style changed method, after looking 
		  /// up the instance in `LookupTable`.
		  
		  #If TargetMacOS Then
		    
		    RaiseEvent NSScrollerStyleChanged(NSScrollerStyle)
		    
		  #EndIf
		End Sub
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21, Description = 52656D6F76657320616C6C20656E74726965732073706563696679696E6720616E206F627365727665722066726F6D20746865206E6F74696669636174696F6E2063656E7465722773206469737061746368207461626C652E
		Private Declare Sub RemoveObserver Lib kFoundation Selector "removeObserver:" (obj As Ptr, notificationObserver As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Sub ScrollPoint Lib kAppKit Selector "scrollPoint:" (id As Ptr, point As CGPoint)
	#tag EndExternalMethod

	#tag Method, Flags = &h0, Description = 5363726F6C6C73207468652063616E76617320746F206120706F696E74202860782C207960292E
		Sub ScrollToPoint(x As Double, y As Double)
		  /// Scrolls the canvas to a point (`x, y`).
		  
		  #If TargetMacOS
		    
		    Var oPoint As CGPoint
		    
		    oPoint.X = x
		    oPoint.Y = y
		    
		    ScrollPoint(NSDocumentView, oPoint)
		    
		  #EndIf
		End Sub
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21, Description = 546865206F7074696F6E7320746861742064657465726D696E6520686F7720746865207669657720697320726573697A65642072656C617469766520746F20697473207375706572766965772E
		Private Declare Sub SetAutoresizingMask Lib kAppKit Selector "setAutoresizingMask:" (id As Ptr, mask As Integer)
	#tag EndExternalMethod

	#tag Method, Flags = &h0, Description = 536574732074686520646F63756D656E742073697A6520746F206077696474686020782060686569676874602E
		Sub SetDocumentSize(width As CGFloat, height As CGFloat)
		  /// Sets the document size to `width` x `height`.
		  
		  #If TargetMacOS
		    
		    Var oSize As CGSize
		    
		    oSize.Width = width
		    oSize.Height = height
		    
		    // Set the frame size. Our ScrollView will accomodate.
		    SetFrameSize(NSDocumentView, oSize)
		    
		    
		  #EndIf
		End Sub
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21, Description = 53657473206120766965772061732074686520646F63756D656E7456696577206F6620616E204E535363726F6C6C566965772E
		Private Declare Sub SetDocumentView Lib kAppKit Selector "setDocumentView:" (obj As Ptr, view As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 5365747320776865746865722061207669657720647261777320697473206261636B67726F756E642E2046616C7365203D205472616E73706172656E74
		Private Declare Sub SetDrawsBackground Lib kAppKit Selector "setDrawsBackground:" (id As Ptr, value As Boolean)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Sub SetFrameSize Lib kAppKit Selector "setFrameSize:" (id As Ptr, newSize As CGSize)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 53657473207768657468657220616E204E535363726F6C6C5669657720686173206120686F72697A6F6E74616C207363726F6C6C65722E
		Private Declare Sub SetHasHorizontalScroller Lib kAppKit Selector "setHasHorizontalScroller:" (obj As Ptr, value As Boolean)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 53657473207768657468657220616E204E535363726F6C6C5669657720686173206120766572746963616C207363726F6C6C65722E
		Private Declare Sub SetHasVerticalScroller Lib kAppKit Selector "setHasVerticalScroller:" (obj As Ptr, value As Boolean)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21, Description = 5365747320776865746865722074686520636F6E74726F6C2077696C6C20706F73742061206E6F74696669636174696F6E207768656E206974277320626F756E6473206368616E67652E
		Private Declare Sub SetPostsBoundsChangedNotifications Lib kAppKit Selector "setPostsBoundsChangedNotifications:" (obj As Ptr, value As Boolean)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function UUID Lib kAppKit Selector "UUID" (id As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function UUIDString Lib kAppKit Selector "UUIDString" (id As Ptr) As CFStringRef
	#tag EndExternalMethod


	#tag Hook, Flags = &h0, Description = 5468652063616E76617320697320636C6F73696E672E
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865207363726F6C6C6572207374796C6520686173206368616E6765642E
		Event NSScrollerStyleChanged(style As NSScrollerStyles)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 546865207363726F6C6C207669657720626F756E647320686173206368616E6765642E
		Event NSScrollViewBoundsChanged(bounds As CGRect)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520616D6F756E742062792077686963682074686520636F6E74656E742069732063757272656E746C79207363616C65642E
		Event NSScrollViewMagnify(scaleOffset As Double)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 5468652063616E766173206973206F70656E696E672E
		Event Opening()
	#tag EndHook


	#tag Note, Name = About
		A subclass of the `DesktopTextInputCanvas` that provides native scrollbars on macOS.
		
	#tag EndNote

	#tag Note, Name = Acknowledgements
		This class is a minimally modified version of a class provided by 
		Martin Trippensee. He can be found on the [Xojo forums][1].
		
		[1]: https://forum.xojo.com
		
	#tag EndNote


	#tag Property, Flags = &h1, Description = 54727565206966207468652063616E7661732073686F756C642068617665206120686F72697A6F6E74616C207363726F6C6C6261722E
		Protected HasHorizontalScrollbar As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 54727565206966207468652063616E7661732073686F756C642068617665206120686F72697A6F6E74616C207363726F6C6C6261722E
		Protected HasVerticalScrollbar As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 412064696374696F6E617279206D617070696E6720586F6A6F206F626A656374732077697468204F626A6563746976652D4320636C61737365732E204B6579203D206F626A6563742060507472602C2056616C7565203D20605765616B526566602E
		Private Shared LookupTable As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 546865207265666572656E636520746F207468652060446F63756D656E74566965776020737562636C6173732E
		Protected NSDocumentView As Ptr
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 4120706F696E74657220746F20604E534E6F74696669636174696F6E43656E746572602E
		Protected NSNotificationCenter As Ptr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1, Description = 54686520707265666572726564207363726F6C6C6572207374796C652E
		#tag Getter
			Get
			  #If TargetMacOS
			    
			    Return GetPreferredScrollerStyle(NSClassFromString("NSScroller"))
			    
			  #EndIf
			End Get
		#tag EndGetter
		Protected Shared NSScrollerStyle As NSScrollerStyles
	#tag EndComputedProperty

	#tag Property, Flags = &h1, Description = 5468697320697320746865207265666572656E636520746F20746865204E535363726F6C6C5669657720737562636C61737320696E7374616E63652E
		Protected NSScrollView As Ptr
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 496E7465726E616C207573652E204120706F696E74657220746F206F757220637573746F6D20604E535363726F6C6C56696577602E
		Protected NSScrollViewCustom As Ptr
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 546865206D6F737420726563656E742058207363726F6C6C20706F736974696F6E2E
		Protected ScrollX_ As Integer
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 546865206D6F737420726563656E742059207363726F6C6C20706F736974696F6E2E
		Protected ScrollY_ As Integer
	#tag EndProperty


	#tag Constant, Name = kAppKit, Type = String, Dynamic = False, Default = \"AppKit", Scope = Private, Description = 546865204170704B6974206C696272617279206E616D6520666F72206465636C617265732E
	#tag EndConstant

	#tag Constant, Name = kFoundation, Type = String, Dynamic = False, Default = \"Foundation", Scope = Private, Description = 54686520466F756E646174696F6E206C696272617279206E616D6520666F72206465636C617265732E
	#tag EndConstant

	#tag Constant, Name = kObjC, Type = String, Dynamic = False, Default = \"libobjc.dylib", Scope = Private, Description = 546865206F626A6563746976652D432064796E616D6963206C696272617279206E616D6520666F72206465636C617265732E
	#tag EndConstant


	#tag Enum, Name = NSScrollerStyles, Type = Integer, Flags = &h0, Description = 436F6E7374616E747320746F207370656369667920746865207363726F6C6C6572207374796C652E0A0A604C6567616379603A20537065636966696573206C65676163792D7374796C65207363726F6C6C657273206173207072696F7220746F206D61634F532031302E372E0A0A604F7665726C6179603A20537065636966696573206F7665726C61792D7374796C65207363726F6C6C65727320696E206D61634F532031302E3720616E64206C617465722E
		Legacy
		Overlay
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
