#tag Class
Protected Class XUISemanticVersion
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F72
		Sub Constructor(major As Integer = 1, minor As Integer = 0, patch As Integer = 0)
		  /// Default constructor
		  ///
		  /// Defaults to `1.0.0`.
		  
		  Self.Major = major
		  Self.Minor = minor
		  Self.Patch = patch
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E7374727563747320612073656D616E7469632076657273696F6E20636C6173732066726F6D206120737472696E6720696E2074686520666F726D3A20224D414A4F522E4D494E4F522E5041544348222E
		Sub Constructor(version As String)
		  /// Constructs a semantic version class from a string in the 
		  /// form: "MAJOR.MINOR.PATCH".
		  
		  Const invalidFormat = "The string should be in the form: ""MAJOR.MINOR.PATCH"""
		  
		  // Split on the dot.
		  Var s() As String = version.Split(".")
		  If s.Count <> 3 Then Raise New InvalidArgumentException(InvalidFormat)
		  
		  // Validate each component.
		  For Each component As String In s
		    If Not IsNumeric(component) Then
		      Raise New InvalidArgumentException(InvalidFormat)
		    Else
		      // Make sure the components are >= 0.
		      If Integer.FromString(component) < 0 Then
		        Raise New InvalidArgumentException("Components must be >= 0")
		      End If
		    End If
		  Next component
		  
		  /// All good.
		  Self.Major = Integer.FromString(s(0))
		  Self.Minor = Integer.FromString(s(1))
		  Self.Patch = Integer.FromString(s(2))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D706172657320746869732073656D616E7469632076657273696F6E20746F20612076657273696F6E206E756D62657220737472696E6720696E2074686520666F726D3A20224D414A4F522E4D494E4F522E5041544348222E
		Function Operator_Compare(s As String) As Integer
		  /// Compares this semantic version to a version number string in 
		  /// the form: `"MAJOR.MINOR.PATCH"`.
		  ///
		  /// Returns:
		  /// ```
		  /// 0 : Self = other
		  /// -1: Self < other
		  /// 1 : Self > other
		  /// ```
		  /// Raises an `InvalidArgumentException` if `s` is not in the correct format.
		  
		  Return Operator_Compare(New XUISemanticVersion(s))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D706172657320746869732073656D616E7469632076657273696F6E20746F20606F74686572602E
		Function Operator_Compare(other As XUISemanticVersion) As Integer
		  /// Compares this semantic version to `other`.
		  ///
		  /// Returns:
		  /// ```
		  /// 0 : Self = other
		  /// -1: Self < other
		  /// 1 : Self > other
		  /// ```
		  
		  // Equal?
		  If Self Is other Then Return 0
		  If Major = other.Major And Minor = other.Minor And Patch = other.Patch Then
		    Return 0
		  End If
		  
		  // Greater than `other`?
		  If Major > other.Major Then Return 1
		  If Major = other.Major Then
		    If Minor > other.Minor Then
		      Return 1
		    ElseIf Minor = other.Minor Then
		      If Patch > other.Patch Then
		        Return 1
		      Else
		        Return -1
		      End If
		    Else
		      // Major match but Self.Minor < other.Minor
		      Return -1
		    End If
		  End If
		  
		  // Self is smaller than `other`.
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652076616C7565206F6620746869732076657273696F6E20746F206073602E
		Sub Operator_Convert(s As String)
		  /// Sets the value of this version to `s`.
		  ///
		  /// Raises an `InvalidArgumentException` if `s` is not a valid version string of 
		  /// the format: `"MAJOR.MINOR.PATCH"`.
		  
		  Var newVersion As XUISemanticVersion
		  Try
		    newVersion = New XUISemanticVersion(s)
		  Catch e
		    Raise New InvalidArgumentException("The passed string is not in " + _
		    "the format: ""MAJOR.MINOR.PATCH""")
		  End Try
		  
		  Self.Major = newVersion.Major
		  Self.Minor = newVersion.Minor
		  Self.Patch = newVersion.Patch
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061204A534F4E20726570726573656E746174696F6E206F6620746869732073656D616E7469632076657273696F6E2E
		Function ToJSON() As String
		  /// Returns a JSON representation of this semantic version.
		  
		  Return GenerateJSON(Self.ToString)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746869732073656D616E7469632076657273696F6E206173206120737472696E6720696E2074686520666F726D3A2060224D414A4F522E4D494E4F522E50415443482260
		Function ToString() As String
		  /// Returns this semantic version as a string in the form: `"MAJOR.MINOR.PATCH"`
		  
		  Return Major.ToString + "." + Minor.ToString + "." + Patch.ToString
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A class for representing and manipulating a [semantic version].
		
		[semantic version]: https://semver.org
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 546865206D616A6F722076657273696F6E206E756D6265722E
		#tag Getter
			Get
			  Return mMajor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Enforce >= 0.
			  mMajor = Max(value, 0)
			  
			End Set
		#tag EndSetter
		Major As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206D696E6F722076657273696F6E206E756D6265722E
		#tag Getter
			Get
			  Return mMinor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Enforce >= 0.
			  mMinor = Max(value, 0)
			  
			End Set
		#tag EndSetter
		Minor As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520604D616A6F726020636F6D70757465642070726F70657274792E
		Private mMajor As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F722074686520604D696E6F726020636F6D70757465642070726F70657274792E
		Private mMinor As Integer
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4261636B696E67206669656C6420666F7220746865206050617463686020636F6D70757465642070726F70657274792E
		Private mPatch As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652070617463682076657273696F6E2E
		#tag Getter
			Get
			  Return mPatch
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Enforce >= 0.
			  mPatch = Max(value, 0)
			  
			End Set
		#tag EndSetter
		Patch As Integer
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
			Name="Patch"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Major"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Minor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
