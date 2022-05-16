#tag Class
Protected Class TKLocalTime
	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E65772060544B4C6F63616C54696D65602066726F6D2060686F7572602C20606D696E757465602C20607365636F6E646020616E6420616E206F7074696F6E616C20606E616E6F7365636F6E64602E
		Sub Constructor(hour As Integer, minute As Integer, second As Integer, nanosecond As Integer = 0)
		  /// Constructs a new `TKLocalTime` from `hour`, `minute`, `second` and an optional `nanosecond`.
		  
		  If hour < 0 Or hour >= 24 Then
		    Raise New InvalidArgumentException("Hour is out of range")
		  End If
		  mHour = hour
		  
		  If minute < 0 Or minute >= 60 Then
		    Raise New InvalidArgumentException("Minute is out of range")
		  End If
		  mMinute = minute
		  
		  If second < 0 Or second >= 60 Then
		    Raise New InvalidArgumentException("Second is out of range")
		  End If
		  mSecond = second
		  
		  If nanosecond < 0 Or nanosecond >= kBillion Then
		    Raise New InvalidArgumentException("Nanosecond is out of range")
		  End If
		  mNanosecond = nanosecond
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E737472756374732061206E65772060544B4C6F63616C54696D65602066726F6D2060636F707946726F6D602E
		Sub Constructor(copyFrom As TKLocalTime)
		  /// Constructs a new `TKLocalTime` from `copyFrom`.
		  
		  Constructor(copyFrom.Hour, copyFrom.Minute, copyFrom.Second, copyFrom.Nanosecond)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E65772060544B4C6F63616C54696D65602066726F6D206120737472696E672E
		Shared Function FromString(timeString As String) As TKLocalTime
		  /// Returns a new `TKLocalTime` from a string.
		  
		  Var match As RegExMatch = TOMLKit.RxTimeString.Search( timeString )
		  If match Is Nil Then
		    Raise New InvalidArgumentException( "Must in in format HH:MM:SS or MHH:MM:SS.mmmmmmm" )
		  End If
		  
		  Return TOMLKit.RegExMatchToLocalTime( match )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686973206D6F6D656E7420696E2074696D652061732061206E65772060544B4C6F63616C54696D65602E
		Shared Function Now() As TKLocalTime
		  /// Returns this moment in time as a new `TKLocalTime`.
		  
		  Var now As DateTime = DateTime.Now
		  Return New TKLocalTime( now.Hour, now.Minute, now.Second, now.Nanosecond )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F662074686973206F626A6563742E
		Attributes( Hidden )  Function Operator_Convert() As String
		  /// Returns a string representation of this object.
		  
		  Return ToString
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Represents a TOML local time.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 54686520686F75722E
		#tag Getter
			Get
			  Return mHour
			End Get
		#tag EndGetter
		Hour As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520636F6D70757465642060486F7572602070726F70657274792E
		Attributes( Hidden ) Private mHour As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206D696E7574652E
		#tag Getter
			Get
			  Return mMinute
			  
			End Get
		#tag EndGetter
		Minute As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520604D696E7574656020636F6D70757465642070726F70657274792E
		Attributes( Hidden ) Private mMinute As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520604E616E6F7365636F6E646020636F6D70757465642070726F70657274792E
		Attributes( Hidden ) Private mNanosecond As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520605365636F6E646020636F6D70757465642070726F70657274792E
		Attributes( Hidden ) Private mSecond As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420757365642077697468696E2074686520605365636F6E647346726F6D4D69646E696768746020636F6D70757465642070726F70657274792E
		Attributes( Hidden ) Private mSecondsFromMidnight As Double = -1.0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420757365642077697468696E207468652060546F537472696E676020636F6D70757465642070726F70657274792E
		Attributes( Hidden ) Private mStringValue As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616E6F7365636F6E642E
		#tag Getter
			Get
			  Return mNanosecond
			  
			End Get
		#tag EndGetter
		Nanosecond As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207365636F6E642E
		#tag Getter
			Get
			  Return mSecond
			End Get
		#tag EndGetter
		Second As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66207365636F6E64732066726F6D206D69646E696768742E
		#tag Getter
			Get
			  If mSecondsFromMidnight < 0.0 Then
			    Var billion As Double = kBillion
			    Var ns As Double = Nanosecond
			    ns = ns / billion
			    
			    mSecondsFromMidnight = ( Hour * 60.0 * 60.0 ) + ( Minute * 60.0 ) + Second + ns
			  End If
			  
			  Return mSecondsFromMidnight
			  
			End Get
		#tag EndGetter
		SecondsFromMidnight As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 4120737472696E6720726570726573656E746174696F6E206F662074686973206C6F63616C2074696D652E
		#tag Getter
			Get
			  If mStringValue = "" Then
			    Const kColon As String = ":"
			    
			    mStringValue = Hour.ToString( "00" ) + kColon + Minute.ToString( "00" ) + kColon + Second.ToString( "00" )
			    
			    If Nanosecond > kMillion Then
			      Var s As Double = Nanosecond / kBillion
			      Var iµs As Integer = s * kMillion
			      s = iµs / kMillion
			      mStringValue = mStringValue + s.ToString( ".0#####" )
			    End If
			  End If
			  
			  Return mStringValue
			  
			End Get
		#tag EndGetter
		ToString As String
	#tag EndComputedProperty


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
			Name="Hour"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Minute"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Nanosecond"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Second"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecondsFromMidnight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
