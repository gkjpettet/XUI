#tag Class
Protected Class TKLocalTime
	#tag Method, Flags = &h0
		Sub Constructor(hour As Integer, minute As Integer, second As Integer, nanosecond As Integer = 0)
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

	#tag Method, Flags = &h0
		Sub Constructor(copyFrom As TKLocalTime)
		  Constructor(copyFrom.Hour, copyFrom.Minute, copyFrom.Second, copyFrom.Nanosecond)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(timeString As String) As TKLocalTime
		  Var match As RegExMatch = TOMLKit.RxTimeString.Search( timeString )
		  If match Is Nil Then
		    Raise New InvalidArgumentException( "Must in in format HH:MM:SS or MHH:MM:SS.mmmmmmm" )
		  End If
		  
		  Return TOMLKit.RegExMatchToLocalTime( match )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Now() As TKLocalTime
		  Var now As DateTime = DateTime.Now
		  Return New TKLocalTime( now.Hour, now.Minute, now.Second, now.Nanosecond )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden )  Function Operator_Convert() As String
		  Return ToString
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mHour
			End Get
		#tag EndGetter
		Hour As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mHour As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mMinute
			  
			End Get
		#tag EndGetter
		Minute As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mMinute As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mNanosecond As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mSecond As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mSecondsFromMidnight As Double = -1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mStringValue As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mNanosecond
			  
			End Get
		#tag EndGetter
		Nanosecond As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mSecond
			End Get
		#tag EndGetter
		Second As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
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

	#tag ComputedProperty, Flags = &h0
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