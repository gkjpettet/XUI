#tag Class
Protected Class XUIColorComponentSlider
Inherits DesktopCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  mMouseDownX = x
		  mMouseDownY = y
		  mMouseDownTicks = System.Ticks
		  
		  If mScrubberBounds <> Nil Then
		    mClickedScrubberOnMouseDown = mScrubberBounds.Contains(x, y)
		    Return True
		  End If
		  
		  Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(x As Integer, y As Integer)
		  If System.Ticks - mMouseDownTicks > DRAG_THRESHOLD_TICKS Then
		    
		    mMouseDownTicks = System.Ticks
		    
		    If Abs(x - mMouseDownX) > DRAG_THRESHOLD_DISTANCE Or _
		      Abs(y - mMouseDownY) > DRAG_THRESHOLD_DISTANCE Then
		      
		      If Not mClickedScrubberOnMouseDown Then Return
		      
		      UpdateComponentValueFromXCoord(x)
		      
		      mIsDragging = True
		      
		      RaiseEvent IsDraggingScrubber
		      
		    End If
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  If mIsDragging Then RaiseEvent FinishedDraggingScrubber
		  mIsDragging = False
		  
		  If Not mClickedScrubberOnMouseDown Then
		    // Clicked on the slider bar but not the scrubber. Update the component value.
		    UpdateComponentValueFromXCoord(x)
		    RaiseEvent PressedSlider(CompleteColor)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused areas
		  
		  // ===========
		  // SLIDER
		  // ===========
		  If mLinearBrush = Nil Or mNeedsFullRedraw Then
		    UpdateLinearBrush(g)
		  End If
		  g.Brush = mLinearBrush
		  If Self.ComponentType <> ComponentTypes.Alpha Then
		    g.FillRoundRectangle(0, 0, g.Width, g.Height, g.Height, g.Height)
		  Else
		    Var pb As New PictureBrush
		    pb.Mode = PictureBrush.Modes.Tile
		    // Thanks to Feedback case 68166, PictureBrush causes a hard crash on Windows & Linux.
		    #If TargetMacOS
		      pb.Image = CheckerboardPattern
		    #Else
		      #Pragma Warning "HACK: Feedback 68166 requires this"
		      pb.Image = CheckerboardPattern.BestRepresentation(16, 16, 1.0)
		    #EndIf
		    g.Brush = pb
		    g.FillRoundRectangle(0, 0, g.Width, g.Height, g.Height, g.Height)
		    
		    // Draw the linear opacity.
		    g.Brush = mLinearBrush
		    g.FillRoundRectangle(0, 0, g.Width, g.Height, g.Height, g.Height)
		  End If
		  
		  // Clear out the brush.
		  g.Brush = Nil
		  
		  // Draw the slider border.
		  g.DrawingColor = mSliderBorderColor
		  g.DrawRoundRectangle(0, 0, g.Width, g.Height, g.Height, g.Height)
		  
		  // ===========
		  // SCRUBBER
		  // ===========
		  Var scrubberDiameter As Double = g.Height - 2
		  
		  Var x As Double = ComponentValueToXCoord(g.Width, scrubberDiameter)
		  
		  // Set the scrubber's bounds.
		  mScrubberBounds = _
		  New Rect(x, (g.Height / 2) - (scrubberDiameter / 2), scrubberDiameter, scrubberDiameter)
		  
		  // Draw the scrubber.
		  g.ShadowBrush = mScrubberShadowBrush
		  g.DrawingColor = mScrubberColor
		  g.PenSize = 2
		  g.DrawOval(x, mScrubberBounds.Top, scrubberDiameter, scrubberDiameter)
		  g.ShadowBrush = Nil
		  
		  mNeedsFullRedraw = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, Description = 52657475726E7320746865205820636F6F7264696E61746520616C6F6E672074686520736C6964657220746F2075736520666F72207468697320736C6964657227732063757272656E7420636F6D706F6E656E742076616C75652E
		Private Function ComponentValueToXCoord(graphicsWidth As Double, scrubberDiameter As Double) As Double
		  /// Returns the X coordinate along the slider to use for this slider's current component value.
		  
		  Select Case ComponentType
		  Case ComponentTypes.Alpha, ComponentTypes.Red, ComponentTypes.Green, ComponentTypes.Blue
		    // These component types are integers 0 - 255.
		    Return XUIMaths.Clamp((ComponentValue / 255) * graphicsWidth, 0, graphicsWidth - scrubberDiameter - 1)
		    
		  Else
		    // All other component types are doubles 0 - 1.0.
		    Return XUIMaths.Clamp(ComponentValue * graphicsWidth, 0, graphicsWidth - scrubberDiameter - 1)
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		  mScrubberColor = New ColorGroup(Color.White, Color.White)
		  mSliderBorderColor = New ColorGroup(&c777777, &c333434)
		  
		  mScrubberShadowBrush = New ShadowBrush
		  mScrubberShadowBrush.BlurAmount = 3
		  mScrubberShadowBrush.ShadowColor = Color.Gray
		  mScrubberShadowBrush.Offset = New Point(0, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 536574732074686520636F6D706F6E656E742076616C7565206261736564206F6E20746865206C6F63616C205820636F6F7264696E617465207061737365642E
		Private Sub UpdateComponentValueFromXCoord(x As Integer)
		  /// Sets the component value based on the local X coordinate passed.
		  
		  If ComponentType = ComponentTypes.Alpha Then
		    // Always 0 - 255.
		    Self.ComponentValue = (x / Self.Width) * 255
		    Return
		  End If
		  
		  Select Case ColorMode
		  Case ColorModes.RGB
		    // Integers 0 - 255.
		    Self.ComponentValue = (x / Self.Width) * 255
		  Case ColorModes.CMY, ColorModes.HSV
		    // Doubles 0 - 1.0.
		    Self.ComponentValue = x / Self.Width
		  Else
		    Raise New UnsupportedOperationException("Unknown color mode.")
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 55706461746573206F757220636163686564206C696E65617220627275736820606D4C696E65617242727573686020666F72207468652063757272656E742060436F6D706C657465436F6C6F726020646570656E64696E67206F6E2074686520736C69646572277320436F6C6F724D6F64652E
		Private Sub UpdateLinearBrush(g As Graphics)
		  /// Updates our cached linear brush `mLinearBrush` for the current `CompleteColor` depending on the 
		  /// slider's ColorMode.
		  
		  Var startPoint, endPoint As Point
		  If ComponentType = ComponentTypes.Alpha Then
		    startPoint = New Point(g.Width, g.Height)
		    endPoint = New Point(0, 0)
		  Else
		    startPoint = New Point(0, 0)
		    endPoint = New Point(g.Width, g.Height)
		  End If
		  
		  Select Case ColorMode
		  Case ColorModes.RGB
		    UpdateLinearBrushRGB(startPoint, endPoint)
		    
		  Case ColorModes.CMY
		    UpdateLinearBrushCMY(startPoint, endPoint)
		    
		  Case ColorModes.HSV
		    UpdateLinearBrushHSV(startPoint, endPoint)
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown color mode.")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 55706461746573206F757220636163686564206C696E65617220627275736820606D4C696E65617242727573686020666F72207468652063757272656E742060436F6D706C657465436F6C6F726020666F7220434D5920636F6D706F6E656E7420736C69646572732E
		Private Sub UpdateLinearBrushCMY(startPoint As Point, endPoint As Point)
		  /// Updates our cached linear brush `mLinearBrush` for the current `CompleteColor` for CMY component sliders.
		  
		  mLinearBrush = New LinearGradientBrush
		  
		  mLinearBrush.StartPoint = startPoint
		  mLinearBrush.EndPoint = endPoint
		  
		  Var cyan As Double = CompleteColor.Cyan
		  Var magenta As Double = CompleteColor.Magenta
		  Var yellow As Double = CompleteColor.Yellow
		  Var alpha As Integer = CompleteColor.Alpha
		  
		  // Compute the gradient points.
		  Var stop0, stop1, stop2, stop3, stop4, stop5, stop6, stop7, stop8, stop9, stop10 As Color
		  Select Case Self.ComponentType
		  Case ComponentTypes.Cyan
		    stop0 = Color.CMY(0, magenta, yellow, alpha)
		    stop1 = Color.CMY(0.1, magenta, yellow, alpha)
		    stop2 = Color.CMY(0.2, magenta, yellow, alpha)
		    stop3 = Color.CMY(0.3, magenta, yellow, alpha)
		    stop4 = Color.CMY(0.4, magenta, yellow, alpha)
		    stop5 = Color.CMY(0.5, magenta, yellow, alpha)
		    stop6 = Color.CMY(0.6, magenta, yellow, alpha)
		    stop7 = Color.CMY(0.7, magenta, yellow, alpha)
		    stop8 = Color.CMY(0.8, magenta, yellow, alpha)
		    stop9 = Color.CMY(0.9, magenta, yellow, alpha)
		    stop10 = Color.CMY(1.0, magenta, yellow, alpha)
		    
		  Case ComponentTypes.Magenta
		    stop0 = Color.CMY(cyan, 0, yellow, alpha)
		    stop1 = Color.CMY(cyan, 0.1, yellow, alpha)
		    stop2 = Color.CMY(cyan, 0.2, yellow, alpha)
		    stop3 = Color.CMY(cyan, 0.3, yellow, alpha)
		    stop4 = Color.CMY(cyan, 0.4, yellow, alpha)
		    stop5 = Color.CMY(cyan, 0.5, yellow, alpha)
		    stop6 = Color.CMY(cyan, 0.6, yellow, alpha)
		    stop7 = Color.CMY(cyan, 0.7, yellow, alpha)
		    stop8 = Color.CMY(cyan, 0.8, yellow, alpha)
		    stop9 = Color.CMY(cyan, 0.9, yellow, alpha)
		    stop10 = Color.CMY(cyan, 1.0, yellow, alpha)
		    
		  Case ComponentTypes.Yellow
		    stop0 = Color.CMY(cyan, magenta, 0, alpha)
		    stop1 = Color.CMY(cyan, magenta, 0.1, alpha)
		    stop2 = Color.CMY(cyan, magenta, 0.2, alpha)
		    stop3 = Color.CMY(cyan, magenta, 0.3, alpha)
		    stop4 = Color.CMY(cyan, magenta, 0.4, alpha)
		    stop5 = Color.CMY(cyan, magenta, 0.5, alpha)
		    stop6 = Color.CMY(cyan, magenta, 0.6, alpha)
		    stop7 = Color.CMY(cyan, magenta, 0.7, alpha)
		    stop8 = Color.CMY(cyan, magenta, 0.8, alpha)
		    stop9 = Color.CMY(cyan, magenta, 0.9, alpha)
		    stop10 = Color.CMY(cyan, magenta, 1.0, alpha)
		    
		  Case ComponentTypes.Alpha
		    stop0 = Color.CMY(cyan, magenta, yellow, 255)
		    stop1 = Color.CMY(cyan, magenta, yellow, 225)
		    stop2 = Color.CMY(cyan, magenta, yellow, 200)
		    stop3 = Color.CMY(cyan, magenta, yellow, 175)
		    stop4 = Color.CMY(cyan, magenta, yellow, 150)
		    stop5 = Color.CMY(cyan, magenta, yellow, 125)
		    stop6 = Color.CMY(cyan, magenta, yellow, 100)
		    stop7 = Color.CMY(cyan, magenta, yellow, 75)
		    stop8 = Color.CMY(cyan, magenta, yellow, 50)
		    stop9 = Color.CMY(cyan, magenta, yellow, 25)
		    stop10 = Color.CMY(cyan, magenta, yellow, 0)
		  End Select
		  
		  // Add the gradient stops.
		  mLinearBrush.GradientStops.Add(New Pair(0.0, stop0))
		  mLinearBrush.GradientStops.Add(New Pair(0.1, stop1))
		  mLinearBrush.GradientStops.Add(New Pair(0.2, stop2))
		  mLinearBrush.GradientStops.Add(New Pair(0.3, stop3))
		  mLinearBrush.GradientStops.Add(New Pair(0.4, stop4))
		  mLinearBrush.GradientStops.Add(New Pair(0.5, stop5))
		  mLinearBrush.GradientStops.Add(New Pair(0.6, stop6))
		  mLinearBrush.GradientStops.Add(New Pair(0.7, stop7))
		  mLinearBrush.GradientStops.Add(New Pair(0.8, stop8))
		  mLinearBrush.GradientStops.Add(New Pair(0.9, stop9))
		  mLinearBrush.GradientStops.Add(New Pair(1.0, stop10))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 55706461746573206F757220636163686564206C696E65617220627275736820606D4C696E65617242727573686020666F72207468652063757272656E742060436F6D706C657465436F6C6F726020666F722048535620636F6D706F6E656E7420736C69646572732E
		Private Sub UpdateLinearBrushHSV(startPoint As Point, endPoint As Point)
		  /// Updates our cached linear brush `mLinearBrush` for the current `CompleteColor` for HSV component sliders.
		  
		  mLinearBrush = New LinearGradientBrush
		  
		  mLinearBrush.StartPoint = startPoint
		  mLinearBrush.EndPoint = endPoint
		  
		  Var hue As Double = CompleteColor.Hue
		  Var sat As Double = CompleteColor.Saturation
		  Var value As Double = CompleteColor.Value
		  Var alpha As Integer = CompleteColor.Alpha
		  
		  // Compute the gradient points.
		  Var stop0, stop1, stop2, stop3, stop4, stop5, stop6, stop7, stop8, stop9, stop10 As Color
		  Select Case Self.ComponentType
		  Case ComponentTypes.Hue
		    stop0 = Color.HSV(0, sat, value, alpha)
		    stop1 = Color.HSV(0.1, sat, value, alpha)
		    stop2 = Color.HSV(0.2, sat, value, alpha)
		    stop3 = Color.HSV(0.3, sat, value, alpha)
		    stop4 = Color.HSV(0.4, sat, value, alpha)
		    stop5 = Color.HSV(0.5, sat, value, alpha)
		    stop6 = Color.HSV(0.6, sat, value, alpha)
		    stop7 = Color.HSV(0.7, sat, value, alpha)
		    stop8 = Color.HSV(0.8, sat, value, alpha)
		    stop9 = Color.HSV(0.9, sat, value, alpha)
		    stop10 = Color.HSV(1.0, sat, value, alpha)
		    
		  Case ComponentTypes.Saturation
		    stop0 = Color.HSV(hue, 0, value, alpha)
		    stop1 = Color.HSV(hue, 0.1, value, alpha)
		    stop2 = Color.HSV(hue, 0.2, value, alpha)
		    stop3 = Color.HSV(hue, 0.3, value, alpha)
		    stop4 = Color.HSV(hue, 0.4, value, alpha)
		    stop5 = Color.HSV(hue, 0.5, value, alpha)
		    stop6 = Color.HSV(hue, 0.6, value, alpha)
		    stop7 = Color.HSV(hue, 0.7, value, alpha)
		    stop8 = Color.HSV(hue, 0.8, value, alpha)
		    stop9 = Color.HSV(hue, 0.9, value, alpha)
		    stop10 = Color.HSV(hue, 1.0, value, alpha)
		    
		  Case ComponentTypes.Value
		    stop0 = Color.HSV(hue, sat, 0, alpha)
		    stop1 = Color.HSV(hue, sat, 0.1, alpha)
		    stop2 = Color.HSV(hue, sat, 0.2, alpha)
		    stop3 = Color.HSV(hue, sat, 0.3, alpha)
		    stop4 = Color.HSV(hue, sat, 0.4, alpha)
		    stop5 = Color.HSV(hue, sat, 0.5, alpha)
		    stop6 = Color.HSV(hue, sat, 0.6, alpha)
		    stop7 = Color.HSV(hue, sat, 0.7, alpha)
		    stop8 = Color.HSV(hue, sat, 0.8, alpha)
		    stop9 = Color.HSV(hue, sat, 0.9, alpha)
		    stop10 = Color.HSV(hue, sat, 1.0, alpha)
		    
		  Case ComponentTypes.Alpha
		    stop0 = Color.HSV(hue, sat, value, 255)
		    stop1 = Color.HSV(hue, sat, value, 225)
		    stop2 = Color.HSV(hue, sat, value, 200)
		    stop3 = Color.HSV(hue, sat, value, 175)
		    stop4 = Color.HSV(hue, sat, value, 150)
		    stop5 = Color.HSV(hue, sat, value, 125)
		    stop6 = Color.HSV(hue, sat, value, 100)
		    stop7 = Color.HSV(hue, sat, value, 75)
		    stop8 = Color.HSV(hue, sat, value, 50)
		    stop9 = Color.HSV(hue, sat, value, 25)
		    stop10 = Color.HSV(hue, sat, value, 0)
		  End Select
		  
		  // Add the gradient stops.
		  mLinearBrush.GradientStops.Add(New Pair(0.0, stop0))
		  mLinearBrush.GradientStops.Add(New Pair(0.1, stop1))
		  mLinearBrush.GradientStops.Add(New Pair(0.2, stop2))
		  mLinearBrush.GradientStops.Add(New Pair(0.3, stop3))
		  mLinearBrush.GradientStops.Add(New Pair(0.4, stop4))
		  mLinearBrush.GradientStops.Add(New Pair(0.5, stop5))
		  mLinearBrush.GradientStops.Add(New Pair(0.6, stop6))
		  mLinearBrush.GradientStops.Add(New Pair(0.7, stop7))
		  mLinearBrush.GradientStops.Add(New Pair(0.8, stop8))
		  mLinearBrush.GradientStops.Add(New Pair(0.9, stop9))
		  mLinearBrush.GradientStops.Add(New Pair(1.0, stop10))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 55706461746573206F757220636163686564206C696E65617220627275736820606D4C696E65617242727573686020666F72207468652063757272656E742060436F6D706C657465436F6C6F726020666F722052474220636F6D706F6E656E7420736C69646572732E
		Private Sub UpdateLinearBrushRGB(startPoint As Point, endPoint As Point)
		  /// Updates our cached linear brush `mLinearBrush` for the current `CompleteColor` for RGB component sliders.
		  ///
		  /// The gradient runs from &h00 on the left to &hFF on the right of this slider's component type.
		  /// For example, if the current colour is &c48ADEF and this is a red component slider then the left hand
		  /// gradient will be &c00ADEF and the right hand gradient will be &cFFADEF.
		  /// So for a red component slider, we vary the red component between &h00 and &hFF but keep the green, blue and 
		  /// alpha components the same.mLinearBrush = New LinearGradientBrush
		  
		  mLinearBrush = New LinearGradientBrush
		  
		  mLinearBrush.StartPoint = startPoint
		  mLinearBrush.EndPoint = endPoint
		  
		  Var red As Integer = CompleteColor.Red
		  Var green As Integer = CompleteColor.Green
		  Var blue As Integer = CompleteColor.Blue
		  Var alpha As Integer = CompleteColor.Alpha
		  
		  // Compute the gradient points.
		  Var stop0, stop1, stop2, stop3, stop4, stop5, stop6, stop7, stop8, stop9, stop10 As Color
		  Select Case Self.ComponentType
		  Case ComponentTypes.Red
		    stop0 = Color.RGB(0, green, blue, alpha)
		    stop1 = Color.RGB(25, green, blue, alpha)
		    stop2 = Color.RGB(50, green, blue, alpha)
		    stop3 = Color.RGB(75, green, blue, alpha)
		    stop4 = Color.RGB(100, green, blue, alpha)
		    stop5 = Color.RGB(125, green, blue, alpha)
		    stop6 = Color.RGB(150, green, blue, alpha)
		    stop7 = Color.RGB(175, green, blue, alpha)
		    stop8 = Color.RGB(200, green, blue, alpha)
		    stop9 = Color.RGB(225, green, blue, alpha)
		    stop10 = Color.RGB(255, green, blue, alpha)
		    
		  Case ComponentTypes.Green
		    stop0 = Color.RGB(red, 0, blue, alpha)
		    stop1 = Color.RGB(red, 25, blue, alpha)
		    stop2 = Color.RGB(red, 50, blue, alpha)
		    stop3 = Color.RGB(red, 75, blue, alpha)
		    stop4 = Color.RGB(red, 100, blue, alpha)
		    stop5 = Color.RGB(red, 125, blue, alpha)
		    stop6 = Color.RGB(red, 150, blue, alpha)
		    stop7 = Color.RGB(red, 175, blue, alpha)
		    stop8 = Color.RGB(red, 200, blue, alpha)
		    stop9 = Color.RGB(red, 225, blue, alpha)
		    stop10 = Color.RGB(red, 255, blue, alpha)
		    
		  Case ComponentTypes.Blue
		    stop0 = Color.RGB(red, green, 0, alpha)
		    stop1 = Color.RGB(red, green, 25, alpha)
		    stop2 = Color.RGB(red, green, 50, alpha)
		    stop3 = Color.RGB(red, green, 75, alpha)
		    stop4 = Color.RGB(red, green, 100, alpha)
		    stop5 = Color.RGB(red, green, 125, alpha)
		    stop6 = Color.RGB(red, green, 150, alpha)
		    stop7 = Color.RGB(red, green, 175, alpha)
		    stop8 = Color.RGB(red, green, 200, alpha)
		    stop9 = Color.RGB(red, green, 225, alpha)
		    stop10 = Color.RGB(red, green, 255, alpha)
		    
		  Case ComponentTypes.Alpha
		    stop0 = Color.RGB(red, green, blue, 255)
		    stop1 = Color.RGB(red, green, blue, 225)
		    stop2 = Color.RGB(red, green, blue, 200)
		    stop3 = Color.RGB(red, green, blue, 175)
		    stop4 = Color.RGB(red, green, blue, 150)
		    stop5 = Color.RGB(red, green, blue, 125)
		    stop6 = Color.RGB(red, green, blue, 100)
		    stop7 = Color.RGB(red, green, blue, 75)
		    stop8 = Color.RGB(red, green, blue, 50)
		    stop9 = Color.RGB(red, green, blue, 25)
		    stop10 = Color.RGB(red, green, blue, 0)
		  End Select
		  
		  // Add the gradient stops.
		  mLinearBrush.GradientStops.Add(New Pair(0.0, stop0))
		  mLinearBrush.GradientStops.Add(New Pair(0.1, stop1))
		  mLinearBrush.GradientStops.Add(New Pair(0.2, stop2))
		  mLinearBrush.GradientStops.Add(New Pair(0.3, stop3))
		  mLinearBrush.GradientStops.Add(New Pair(0.4, stop4))
		  mLinearBrush.GradientStops.Add(New Pair(0.5, stop5))
		  mLinearBrush.GradientStops.Add(New Pair(0.6, stop6))
		  mLinearBrush.GradientStops.Add(New Pair(0.7, stop7))
		  mLinearBrush.GradientStops.Add(New Pair(0.8, stop8))
		  mLinearBrush.GradientStops.Add(New Pair(0.9, stop9))
		  mLinearBrush.GradientStops.Add(New Pair(1.0, stop10))
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 546865207363727562626572206861732066696E6973686564206265696E6720647261676765642E
		Event FinishedDraggingScrubber()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520736C696465722773207363727562626572206973206265696E6720647261676765642E
		Event IsDraggingScrubber()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520757365722068617320707265737365642074686520736C6964657220286E6F7420746865207363727562626572292C206368616E67696E672069747320636F6C6F722E
		Event PressedSlider(newColor As Color)
	#tag EndHook


	#tag Property, Flags = &h0
		ColorMode As XUIColorComponentSlider.ColorModes = XUIColorComponentSlider.ColorModes.RGB
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6D706C65746520636F6C6F75722074686174207468697320636F6D706F6E656E7420726570726573656E74732070617274206F662E
		#tag Getter
			Get
			  Return mCompleteColor
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mCompleteColor = value
			  mNeedsFullRedraw = True
			  Refresh
			End Set
		#tag EndSetter
		CompleteColor As Color
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ComponentType As XUIColorComponentSlider.ComponentTypes = XUIColorComponentSlider.ComponentTypes.Red
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652076616C7565206F66207468697320636F6D706F6E656E742E
		#tag Getter
			Get
			  Return mComponentValue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Clamp the value as required.
			  If ComponentType = ComponentTypes.Alpha Then
			    // Alpha is always an integer value between 0 - 255.
			    Var i As Integer = XUIMaths.Clamp(value, 0, 255)
			    mComponentValue = i
			  Else
			    Select Case ColorMode
			    Case ColorModes.RGB
			      // Only allow integer values between 0 - 255.
			      Var i As Integer = XUIMaths.Clamp(value, 0, 255)
			      mComponentValue = i
			    Case ColorModes.HSV, ColorModes.CMY
			      // Only allow double values between 0 - 1.0.
			      mComponentValue = XUIMaths.Clamp(value, 0, 1.0)
			    End Select
			  End If
			  
			  // Update the complete colour based on this new component value.
			  Select Case ComponentType
			  Case ComponentTypes.Red
			    mCompleteColor = Color.RGB(mComponentValue, mCompleteColor.Green, mCompleteColor.Blue, mCompleteColor.Alpha)
			    
			  Case ComponentTypes.Green
			    mCompleteColor = Color.RGB(mCompleteColor.Red, mComponentValue, mCompleteColor.Blue, mCompleteColor.Alpha)
			    
			  Case ComponentTypes.Blue
			    mCompleteColor = Color.RGB(mCompleteColor.Red, mCompleteColor.Green, mComponentValue, mCompleteColor.Alpha)
			    
			  Case ComponentTypes.Alpha
			    Select Case ColorMode
			    Case ColorModes.RGB
			      mCompleteColor = Color.RGB(mCompleteColor.Red, mCompleteColor.Green, mCompleteColor.Blue, mComponentValue)
			    Case ColorModes.HSV
			      mCompleteColor = Color.HSV(mCompleteColor.Hue, mCompleteColor.Saturation, mCompleteColor.Value, mComponentValue)
			    Case ColorModes.CMY
			      mCompleteColor = Color.CMY(mCompleteColor.Cyan, mCompleteColor.Magenta, mCompleteColor.Yellow, mComponentValue)
			    End Select
			    
			  Case ComponentTypes.Hue
			    mCompleteColor = Color.HSV(mComponentValue, mCompleteColor.Saturation, mCompleteColor.Value, mCompleteColor.Alpha)
			    
			  Case ComponentTypes.Saturation
			    mCompleteColor = Color.HSV(mCompleteColor.Hue, mComponentValue, mCompleteColor.Value, mCompleteColor.Alpha)
			    
			  Case ComponentTypes.Value
			    mCompleteColor = Color.HSV(mCompleteColor.Hue, mCompleteColor.Saturation, mComponentValue, mCompleteColor.Alpha)
			    
			  Case ComponentTypes.Cyan
			    mCompleteColor = Color.CMY(mComponentValue, mCompleteColor.Magenta, mCompleteColor.Yellow, mCompleteColor.Alpha)
			    
			  Case ComponentTypes.Magenta
			    mCompleteColor = Color.CMY(mCompleteColor.Cyan, mComponentValue, mCompleteColor.Yellow, mCompleteColor.Alpha)
			    
			  Case ComponentTypes.Yellow
			    mCompleteColor = Color.CMY(mCompleteColor.Cyan, mCompleteColor.Magenta, mComponentValue, mCompleteColor.Alpha)
			  End Select
			  
			  Refresh
			  
			End Set
		#tag EndSetter
		ComponentValue As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652073637275626265722077617320636C69636B656420647572696E6720746865206C61737420604D6F757365446F776E60206576656E742E
		Private mClickedScrubberOnMouseDown As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6D706C65746520636F6C6F75722074686174207468697320636F6D706F6E656E7420726570726573656E74732070617274206F662E
		Private mCompleteColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652076616C7565206F66207468697320636F6D706F6E656E742E
		Private mComponentValue As Double = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468652073637275626265722069732063757272656E746C79206265696E6720647261676765642E
		Private mIsDragging As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C696E65617220627275736820746F2075736520666F72207468652063757272656E742060436F6D706C657465436F6C6F726020736C69646572206772616469656E7420696E2074686520605061696E7460206576656E742E20436F6D707574656420696E20605570646174654C696E65617242727573682829602E
		Private mLinearBrush As LinearGradientBrush
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207469636B73207768656E20746865206C61737420604D6F757365446F776E60206F722022616374696F6E65642220604D6F7573654472616760206576656E74206F636375727265642E
		Private mMouseDownTicks As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060586020636F6F7264696E61746520696E20746865206C61737420604D6F757365446F776E60206576656E742E2053657420746F20602D316020696E2074686520604D6F757365557060206576656E742E
		Private mMouseDownX As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060596020636F6F7264696E61746520696E20746865206C61737420604D6F757365446F776E60206576656E742E2053657420746F20602D316020696E2074686520604D6F757365557060206576656E742E
		Private mMouseDownY As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520736C69646572206E6565647320612066756C6C207265647261772E
		Private mNeedsFullRedraw As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520626F756E6473206F66207468652073637275626265722C206C6F63616C20746F20746869732063616E7661732E
		Private mScrubberBounds As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrubberColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520736861646F7720627275736820746F20757365207768656E2064726177696E67207468652073637275626265722E
		Private mScrubberShadowBrush As ShadowBrush
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F7572206F662074686520736C6964657220626F726465722E
		Private mSliderBorderColor As ColorGroup
	#tag EndProperty


	#tag Constant, Name = DRAG_THRESHOLD_DISTANCE, Type = Double, Dynamic = False, Default = \"5", Scope = Private, Description = 546865206E756D626572206F6620706978656C7320646966666572656E6365206265747765656E207468652063757272656E74206D6F75736520706F736974696F6E20616E6420746865206C61737420746F207472696767657220612064726167206F7065726174696F6E2E
	#tag EndConstant

	#tag Constant, Name = DRAG_THRESHOLD_TICKS, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 546865206E756D626572206F66207469636B732074686174206D757374206861766520656C6170736564206265747765656E20746865206C6173742064726167206F7065726174696F6E20746F207472696767657220616E6F7468657220647261672E
	#tag EndConstant


	#tag Enum, Name = ColorModes, Type = Integer, Flags = &h0
		RGB
		  CMY
		HSV
	#tag EndEnum

	#tag Enum, Name = ComponentTypes, Type = Integer, Flags = &h0
		Alpha
		  Blue
		  Green
		  Red
		  Hue
		  Saturation
		  Value
		  Cyan
		  Magenta
		Yellow
	#tag EndEnum


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
			InitialValue=""
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="200"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="16"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
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
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ComponentType"
			Visible=true
			Group="Behavior"
			InitialValue="XUIColorComponentSlider.Types.Red"
			Type="XUIColorComponentSlider.ComponentTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Alpha"
				"1 - Blue"
				"2 - Green"
				"3 - Red"
				"4 - Hue"
				"5 - Saturation"
				"6 - Value"
				"7 - Cyan"
				"8 - Magenta"
				"9 - Yellow"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="CompleteColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ComponentValue"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorMode"
			Visible=true
			Group="Behavior"
			InitialValue="XUIColorComponentSlider.ColorModes.RGB"
			Type="XUIColorComponentSlider.ColorModes"
			EditorType="Enum"
			#tag EnumValues
				"0 - RGB"
				"1 - CMY"
				"2 - HSV"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
