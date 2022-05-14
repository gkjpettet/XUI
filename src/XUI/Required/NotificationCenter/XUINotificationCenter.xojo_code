#tag Module
Protected Module XUINotificationCenter
	#tag Method, Flags = &h21, Description = 44656C6567617465206D6574686F642C2063616C6C65642062792074686520696E7465726E616C2074696D65722C20746861742061637475616C6C79206469737061746368657320746865206E6F74696669636174696F6E732E
		Private Sub DispatchTimerAction(sender As Timer)
		  /// Delegate method, called by the internal timer, that actually dispatches the notifications.
		  /// 
		  /// `sender` is the timer whose `Action` event fired.
		  
		  #Pragma Unused sender
		  
		  // Delay notification dispatching if the notification centre is currently unregistering a listener.
		  If mUnregistering Then Return
		  
		  While mDispatchQueue.Count > 0
		    
		    // Get the notification to send.
		    Var n As XUINotification = mDispatchQueue(0)
		    
		    // Remove this notification from the dispatch queue.
		    mDispatchQueue.RemoveAt(0)
		    
		    // Get all listeners that are interested in this notification.
		    For Each key As String In mKeyListenerDictionary.Keys
		      
		      Var r As New RegEx
		      r.SearchPattern = "^" + key
		      r.Options.StringBeginIsLineBegin = True
		      r.options.StringEndIsLineEnd = True
		      
		      Var match As RegExMatch = r.Search(n.Key)
		      
		      Var TMP As String = ""
		      If match <> Nil Then TMP = match.SubExpressionString(0)
		      
		      If match <> Nil And match.SubExpressionString(0) = n.Key Then
		        Var listenersForKey() As WeakRef = mKeyListenerDictionary.Value(key)
		        
		        // Send the notification to each listener.
		        Var containsDeadRefs As Boolean = False
		        For Each wr As WeakRef In listenersForKey
		          If wr = Nil Or wr.Value = Nil Then
		            // This listener has gone out of scope. We will therefore prune this 
		            // array after all living listeners have been sent the notification.
		            containsDeadRefs = True
		          Else
		            Var listener As XUINotificationListener = XUINotificationListener(wr.Value)
		            listener.NotificationReceived(n)
		          End If
		        Next wr
		        
		        // Remove any dead listeners.
		        If containsDeadRefs Then RemoveDeadReferences(listenersForKey)
		        
		        // Reassign the array of listeners to our dictionary.
		        mKeyListenerDictionary.Value(key) = listenersForKey
		      End If
		      
		    Next key
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265676973746572732074686520606C697374656E65726020746F206C697374656E20666F72206E6F74696669636174696F6E7320776974682074686520606B6579602E
		Sub ListenForKey(Extends listener As XUINotificationListener, key As String)
		  /// Registers the `listener` to listen for notifications with the `key`.
		  
		  // NB: We don't need to normalise the keys as this will happen in `Register`.
		  Register(key, listener)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265676973746572732074686520606C697374656E65726020746F206C697374656E20666F72206E6F74696669636174696F6E732077697468207468652073706563696669656420606B657973602E
		Sub ListenForKeys(Extends listener As XUINotificationListener, keys() As String)
		  /// Registers the `listener` to listen for notifications with the specified `keys`.
		  
		  For Each key As String In keys
		    // NB: We don't need to normalise the keys as this will happen in `Register`.
		    Register(key, listener)
		  Next key
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4E6F726D616C6973657320606B65796020736F20697420646F65736E277420627265616B2073756273657175656E7420726567657820717565726965732E
		Private Function NormaliseKey(key As String) As String
		  /// Normalises `key` so it doesn't break subsequent regex queries.
		  ///
		  /// Keys can be hierarchical with children separated by a `.`
		  ///
		  /// Wildcard matching is permitted with `*`
		  ///
		  /// Examples:
		  ///
		  /// `Prefs` Matches the key `Prefs` only.  
		  /// `Prefs.Editor` matches `Prefs.Editor` only.  
		  /// `Prefs.*` matches `Prefs.Editor`, `Prefs.Compiler`, etc.  
		  /// `Prefs.Editor.*` matches `Prefs.Editor.Colours`, `Prefs.Editor.Fonts`, etc.  
		  
		  key = key.ReplaceAll(".", "SLASHDOT")
		  key = key.ReplaceAll("*", ".*")
		  
		  key = key.ReplaceAll("[", "\[")
		  key = key.ReplaceAll("]", "\]")
		  
		  key = key.ReplaceAll("(", "\(")
		  key = key.ReplaceAll(")", "\)")
		  
		  key = key.ReplaceAll("{", "\{")
		  key = key.ReplaceAll("}", "\}")
		  
		  key = key.ReplaceAll("^", "\^")
		  key = key.ReplaceAll("$", "\$")
		  
		  key = key.ReplaceAll("\", "\\")
		  key = key.ReplaceAll("?", "\?")
		  key = key.ReplaceAll("+", "\+")
		  key = key.ReplaceAll("|", "\|")
		  key = key.ReplaceAll("<", "\<")
		  key = key.ReplaceAll("=", "\=")
		  key = key.ReplaceAll(":", "\:")
		  key = key.ReplaceAll("!", "\!")
		  
		  key = key.ReplaceAll("SLASHDOT", "\.")
		  
		  Return key
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52656769737465727320606C697374656E65726020746F206265206E6F746966696564207768656E657665722061206E6F74696669636174696F6E207769746820606B657960206F63637572732E
		Protected Sub Register(key As String, listener As XUINotificationListener)
		  /// Registers `listener` to be notified whenever a notification with `key` occurs.
		  
		  // Nil object checks.
		  If listener = Nil Then Return
		  If mKeyListenerDictionary = Nil Then mKeyListenerDictionary = New Dictionary
		  
		  // Normalise the key.
		  key = NormaliseKey(key)
		  
		  // Get the current listeners for this key.
		  Var listenersForKey() As WeakRef
		  If mKeyListenerDictionary.HasKey(key) Then
		    listenersForKey = mKeyListenerDictionary.Value(key)
		  End If
		  
		  // Is this listener already registered for this key?
		  For Each wr As WeakRef In listenersForKey
		    If wr.Value = listener Then
		      // The passed listener is already listening.
		      Return
		    End If
		  Next wr
		  
		  // This is a new listener for this key.
		  listenersForKey.Add(New WeakRef(listener))
		  mKeyListenerDictionary.Value(key) = listenersForKey
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656D6F76657320616E792064656164207265666572656E6365732066726F6D20746865206172726179206F66207765616B207265666572656E6365732E
		Private Sub RemoveDeadReferences(references() As WeakRef)
		  /// Removes any dead references from the array of weak references.
		  
		  Var iMax As Integer = references.LastIndex
		  For i As Integer = iMax DownTo 0
		    If references(i) = Nil Or references(i).Value = Nil Then
		      references.RemoveAt(i)
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4372656174657320616E64207175657565732074686520706173736564206E6F74696669636174696F6E20666F722073656E64696E672E
		Protected Sub Send(sender As Variant, key As String, data As Variant = Nil)
		  /// Creates and queues the passed notification for sending.
		  
		  // Construct a notification object.
		  Var n As New XUINotification(sender, key, data)
		  
		  If mKeyListenerDictionary <> Nil Then
		    mDispatchQueue.Add(n)
		    
		    If mDispatchTimer = Nil Then
		      mDispatchTimer = New Timer
		      mDispatchTimer.Period = DISPATCH_INTERVAL_MILLISECONDS
		      AddHandler mDispatchTimer.Action, AddressOf DispatchTimerAction
		    End If
		    
		    If mDispatchTimer.RunMode <> Timer.RunModes.Multiple Then
		      mDispatchTimer.RunMode = Timer.RunModes.Multiple
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53746F707320606C697374656E6572602066726F6D206C697374656E696E6720746F20616C6C206E6F74696669636174696F6E732E
		Sub StopListening(Extends listener As XUINotificationListener)
		  /// Stops `listener` from listening to all notifications.
		  
		  If mKeyListenerDictionary = Nil Then
		    // There are no listeners.
		    Return
		  End If
		  
		  For Each entry As DictionaryEntry In mKeyListenerDictionary
		    // Each entry represents a key:listener() pairing.
		    Var listenersForKey() As WeakRef = entry.Value
		    Var iMax As Integer = listenersForKey.LastIndex
		    For i As Integer = iMax DownTo 0
		      Var wr As WeakRef = listenersForKey(i)
		      If wr = Nil Or wr.Value = Nil Or wr.Value = listener Then
		        // Either we've found the reference to this listener (listening to 
		        // this key) or an incidental dead reference. Either way, remove it.
		        listenersForKey.RemoveAt(i)
		      End If
		    Next i
		  Next entry
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53746F707320606C697374656E6572602066726F6D206C697374656E696E6720746F206E6F74696669636174696F6E73207769746820606B6579602E
		Sub StopListeningForKey(Extends listener As XUINotificationListener, key As String)
		  /// Stops `listener` from listening to notifications with `key`.
		  
		  // Normalise the key.
		  key = NormaliseKey(key)
		  
		  If mKeyListenerDictionary = Nil Or Not mKeyListenerDictionary.HasKey(key) Then
		    // There are no listeners for this key.
		    Return
		  End If
		  
		  Var listenersForKey() As WeakRef = mKeyListenerDictionary.Value(key)
		  Var iMax As Integer = listenersForKey.LastIndex
		  For i As Integer = iMax DownTo 0
		    Var wr As WeakRef = listenersForKey(i)
		    If wr = Nil Or wr.Value = Nil Or wr.Value = listener Then
		      // Either we've found the reference to this listener (listening to 
		      // this key) or an incidental dead reference. Either way, remove it.
		      listenersForKey.RemoveAt(i)
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 556E72656769737465727320606C697374656E6572602066726F6D20616C6C206E6F74696669636174696F6E732E
		Protected Sub Unregister(listener As XUINotificationListener)
		  /// Unregisters `listener` from all notifications.
		  
		  mUnregistering = True
		  
		  For Each entry As DictionaryEntry In mKeyListenerDictionary
		    Var weakrefs() As WeakRef = entry.Value
		    For i As Integer = weakrefs.LastIndex DownTo 0
		      Var wr As WeakRef = weakrefs(i)
		      If wr = Nil Then
		        weakrefs.RemoveAt(i)
		      ElseIf wr.Value = listener Then
		        weakrefs.RemoveAt(i)
		      End If
		    Next i
		  Next entry
		  
		  mUnregistering = False
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 556E72656769737465727320606C697374656E6572602066726F6D206E6F74696669636174696F6E73207769746820606B6579602E
		Protected Sub UnregisterForKey(listener As XUINotificationListener, key As String)
		  /// Unregisters `listener` from notifications with `key`.
		  
		  // Nil object checks.
		  If listener = Nil Then Return
		  If mKeyListenerDictionary = Nil Then mKeyListenerDictionary = New Dictionary
		  
		  // Normalise the key.
		  key = NormaliseKey(key)
		  
		  // Get the current listeners for this key.
		  Var listenersForKey() As WeakRef
		  If mKeyListenerDictionary.HasKey(key) Then
		    listenersForKey = mKeyListenerDictionary.Value(key)
		  End If
		  
		  // If the listener is currently registered then unregister them.
		  For i As Integer = listenersForKey.LastIndex DownTo 0
		    Var wr As WeakRef = listenersForKey(i)
		    If wr = Nil Then
		      listenersForKey.RemoveAt(i)
		    ElseIf wr.Value = listener Then
		      listenersForKey.RemoveAt(i)
		      Return
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 556E72656769737465727320606C697374656E6572602066726F6D206E6F74696669636174696F6E732077697468207468652073706563696669656420606B657973602E
		Protected Sub UnregisterForKeys(listener As XUINotificationListener, keys() As String)
		  /// Unregisters `listener` from notifications with the specified `keys`.
		  
		  For Each key As String In keys
		    UnregisterForKey(listener, key)
		  Next key
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		This module provides a global mechanism for sending in-app notifications (essentially messages 
		between objects in your app) in the form of a `XUINotification`.
		
		
	#tag EndNote

	#tag Note, Name = Examples
		Let's suppose you have an instance of a class (`sender`) that periodically sends out a notification.  
		This could be accomplished like so:
		
		```xojo
		NotificationCenter.Send("MyKey", someValue)
		```
		
		Will will also imagine that we have an instance of a class (`listener`) that wants to listen for these notifications. 
		This is easily achieved:
		
		```xojo
		listener.Register("MyKey")
		```
		
		Now whenever `sender` calls `NotificationCenter.Send()` with `"MyKey"` as the key, `listener`'s 
		`NotificationReceived()` method is invoked by the notification center.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 546865207175657565206F66206E6F74696669636174696F6E73207468617420726571756972652073656E64696E672E
		Private mDispatchQueue() As XUINotification
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652074696D6572207573656420746F206469737061746368206E6F74696669636174696F6E732E
		Private mDispatchTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4B6579203D204E6F74696669636174696F6E204B65792028537472696E67292C2056616C7565203D204E4B4C697374656E657220285765616B526566292E
		Private mKeyListenerDictionary As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966204E6F74696669636174696F6E4B697420697320696E20746865206D6964646C65206F6620756E7265676973746572696E672061206C697374656E65722E
		Private mUnregistering As Boolean = False
	#tag EndProperty


	#tag Constant, Name = DISPATCH_INTERVAL_MILLISECONDS, Type = Double, Dynamic = False, Default = \"100", Scope = Private, Description = 546865206E756D626572206F66206D696C6C697365636F6E6473206265747765656E20636865636B7320666F72206E6577206D6573736167657320746F2073656E642E
	#tag EndConstant


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
End Module
#tag EndModule
