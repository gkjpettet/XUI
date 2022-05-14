#tag Module
Protected Module XUIMaths
	#tag Method, Flags = &h21, Description = 4173736572747320746861742060636F6E646974696F6E6020697320547275652C206F74686572776973652072616973657320616E20657863657074696F6E2E
		Private Sub Assert(condition As Boolean, message As String = "")
		  /// Asserts that `condition` is True, otherwise raises an exception.
		  
		  If Not condition Then Raise New RuntimeException(message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686520646F75626C652076616C756520636F72726573706F6E64696E6720746F206120676976656E2062697420726570726573656E746174696F6E2E
		Protected Function BitsToDouble(bits As Int64) As Double
		  /// Returns the double value corresponding to a given bit representation.
		  ///
		  /// The argument is considered to be a representation of a floating-point value 
		  /// according to the IEEE 754 floating-point "double format" bit layout.
		  ///
		  /// If the argument is `&h7ff0000000000000L`, the result is positive infinity.
		  /// If the argument is `&hfff0000000000000`, the result is negative infinity.
		  /// If the argument is any value in the range `&h7ff0000000000001` through
		  /// `&h7fffffffffffffff` or in the range `&hfff0000000000001` through
		  /// `&hffffffffffffffff`, the result is a `NaN`.
		  ///
		  /// No IEEE 754 floating-point operation can distinguish between two NaN values 
		  /// of the same type with different bit patterns.  Distinct values of NaN are 
		  /// only distinguishable by use of the `DoubleToRaw` method.
		  ///
		  /// In all other cases, let `s`, `e`, and `m` be three * values that can be 
		  /// computed from the argument:
		  ///
		  /// ```java
		  ///  int s = ((bits >> 63) = 0) ? 1 : -1
		  ///  int e = (int)((bits >> 52) & 0x7ffL)
		  ///  long m = (e = 0) ?
		  ///                 (bits & 0xfffffffffffffL) << 1 :
		  ///                 (bits & 0xfffffffffffffL) | 0x10000000000000L
		  /// ```
		  ///
		  /// Then the floating-point result equals the value of the mathematical 
		  /// expression `s·m·2^e-1075`
		  /// 
		  /// Note that this method may not be able to return double `NaN` with exactly 
		  /// the same bit pattern as the argument. IEEE 754 distinguishes between 
		  /// two kinds of `NaN`s, quiet `NaN`s and _signaling NaNs_. The differences 
		  /// between the two kinds of `NaN` are generally not visible. Arithmetic 
		  /// operations on signaling `NaN`s turn them into quiet NaNs with a different, 
		  /// but often similar, bit pattern. However, on some processors merely copying a signaling `NaN` 
		  /// also performs that conversion. In particular, copying a signaling `NaN` 
		  /// to return it to the calling method may perform this conversion. 
		  /// So `BitsToDouble` may not be able to return a double with a signaling 
		  /// NaN bit pattern.  Consequently, for some `UInt64` values,
		  /// `DoubleToRawBits(BitsToDouble(start))` may _not_ equal `start`. 
		  /// Moreover, which particular bit patterns represent signaling NaNs is 
		  /// platform dependent although all `NaN` bit patterns, quiet or signaling, 
		  /// must be in the `NaN` range identified above.
		  
		  Var m As MemoryBlock = New MemoryBlock(8)
		  m.Int64Value(0) = bits
		  Return m.DoubleValue(0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865207061737365642076616C756520636C616D706564206265747765656E20606D696E696D756D6020616E6420606D6178696D756D602E
		Protected Function Clamp(value As Double, minimum As Double, maximum As Double) As Double
		  /// Returns the passed value clamped between `minimum` and `maximum`.
		  
		  If value > maximum Then Return maximum
		  If value < minimum Then Return minimum
		  Return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732054727565206F722046616C73652E
		Protected Function CoinToss(trueBias As Double = 0.5) As Boolean
		  /// Returns True or False.
		  /// 
		  /// Simulates a coin toss by returning a random boolean. The optional 
		  /// `trueBias` determines the chance of True being returned. This value
		  /// should be between `0` and `1`. If `0` then there is a 0% chance that True
		  /// will be returned, if `1` then the chance is 100%.
		  
		  trueBias = Clamp(trueBias, 0.0, 1.0)
		  
		  Return System.Random.Number <= trueBias
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 436F6D7061726573207468652074776F2073706563696669656420646F75626C652076616C7565732E
		Protected Function Compare(d1 As Double, d2 As Double) As Integer
		  /// Compares the two specified double values. 
		  /// 
		  /// The value `0` if `d1` is numerically equal to `d2`, a value 
		  /// less than `0` if `d1` is numerically less than `d2` and a value 
		  /// greater than `0` if `d1` is numerically greater than `d2`.
		  
		  If d1 < d2 Then
		    Return -1 // Neither val is NaN, thisVal is smaller.
		  End If
		  
		  If d1 > d2 Then
		    Return 1 // Neither val is NaN, thisVal is larger.
		  End If
		  
		  // Cannot use `DoubleToRawBits` because of possibility of NaNs.
		  Var thisBits As Int64 = DoubleToBits(d1)
		  Var anotherBits As Int64 = DoubleToBits(d2)
		  
		  Return If(thisBits = anotherBits, 0, If(thisBits < anotherBits, -1, 1))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D707574657320616E20617070726F78696D6174696F6E206F66206D616368696E6520657073696C6F6E2E
		Private Function ComputeEpsilon() As Double
		  /// Computes an approximation of machine epsilon.
		  
		  Var e As Double = 0.5
		  
		  While (1.0 + e > 1.0)
		    e = e * 0.5
		  Wend
		  
		  Return e
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320606D61676E697475646560207769746820746865207369676E206F6620607369676E602E
		Protected Function CopySign(magnitude As Double, sign As Double) As Double
		  /// Returns `magnitude` with the sign of `sign`.
		  
		  Return If(sign < 0, -Abs(magnitude), Abs(magnitude))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206375626520726F6F74206F66206064602E
		Protected Function CubeRoot(d As Double) As Double
		  /// Returns the cube root of `d`.
		  /// 
		  /// If the argument is `NaN`, then the result Is `NaN`.
		  /// If the argument is infinite, Then the result is an infinity
		  /// with the same sign as the argument.
		  /// If the argument is zero, then the result is a zero with the same sign 
		  /// as the argument.
		  /// For positive finite `x`, `Cbrt(-x) = -cbrt(x)`
		  /// That is, the cube root of a negative value is the negative of the 
		  /// cube root of that value's magnitude.
		  
		  // Check the arguments.
		  If d.IsNotANumber Then Return NAN
		  If d.IsInfinite Then
		    If d >= 0 Then
		      Return POSITIVE_INFINITY
		    Else
		      Return NEGATIVE_INFINITY
		    End If
		  End If
		  
		  Var result As Double = Pow(d, 1.0 / 3.0)
		  
		  If result = 0 Then
		    If d >= 0 Then
		      Return 0
		    Else
		      Return -0
		    End If
		  Else
		    Return result
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206120726570726573656E746174696F6E206F6620606460206163636F7264696E6720746F2074686520494545452037353420666C6F6174696E672D706F696E742022646F75626C6520666F726D61742220626974206C61796F75742E
		Protected Function DoubleToBits(d As Double) As Int64
		  /// Returns a representation of `d` according to the IEEE 754 floating-point 
		  /// "double format" bit layout.
		  /// 
		  /// Bit 63 (the bit that is selected by the mask `0x8000000000000000`) 
		  /// represents the sign of the double number. 
		  /// Bits 62-52 (the bits that are selected by the mask `0x7ff0000000000000`) 
		  /// represent the exponent. 
		  /// Bits 51-0 (the bits that are selected by the mask `0x000fffffffffffff`) 
		  /// represent the significand (sometimes called the mantissa) of the 
		  /// floating-point number.
		  /// 
		  /// If the argument is positive infinity, the result is `&h7ff0000000000000`.
		  /// If the argument is negative infinity, the result is `&hfff0000000000000`.
		  /// If the argument is `NaN`, the result is `&h7ff8000000000000`.
		  /// 
		  /// In all cases, the result is an `Int64` integer that, when given to 
		  /// the `BitsToDouble(UInt64)` method, will produce a `Double` the same as the 
		  // argument to `DoubleToBits` (except all NaN values are collapsed to a 
		  /// single "canonical" `NaN` value).
		  
		  // Check for NaN.
		  If d.IsNotANumber Then Return &h7ff8000000000000
		  
		  Return DoubleToRawBits(d)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206120726570726573656E746174696F6E206F6620606460206163636F7264696E6720746F2074686520494545452037353420666C6F6174696E672D706F696E742022646F75626C6520666F726D61742220626974206C61796F75742C2070726573657276696E6720604E614E602076616C7565732E
		Protected Function DoubleToRawBits(d As Double) As Int64
		  /// Returns a representation of `d` according to the IEEE 754 floating-point 
		  /// "double format" bit layout, preserving `NaN` values.
		  /// 
		  /// Bit 63 (the bit that is selected by the mask `&h8000000000000000`) 
		  /// represents the sign of the floating-point number. 
		  /// Bits 62-52 (the bits that are selected by the mask `&h7ff0000000000000`) 
		  /// represent the exponent. 
		  /// Bits 51-0 (the bits that are selected by the mask `&h000fffffffffffff`) 
		  /// represent the significand (sometimes called the mantissa) of the 
		  /// floating-point number.
		  /// 
		  /// If the argument is positive infinity, the result is `&h7ff0000000000000`.
		  /// If the argument is negative infinity, the result is `&hfff0000000000000`.
		  /// If the argument is `NaN`, the result is the `Int64` integer representing 
		  /// the actual `NaN` value.
		  /// Unlike the `DoubleToBits` method, this method does not collapse 
		  /// all the bit patterns encoding a NaN to a single "canonical" `NaN` value.
		  /// 
		  /// In all cases, the result is a `UInt64` integer that, when given to the 
		  /// `BitsToDouble(Int64)` method, will produce a floating-point value the 
		  /// same as `d`.
		  
		  Var m As MemoryBlock = New MemoryBlock(8)
		  m.LittleEndian = False
		  m.DoubleValue(0) = d
		  Return m.Int64Value(0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686520756E626961736564206578706F6E656E74207573656420696E2074686520726570726573656E746174696F6E206F66206064602E
		Protected Function GetExponent(d As Double) As Int32
		  /// Returns the unbiased exponent used in the representation of `d`.
		  ///
		  /// - If the argument is NaN or infinite, then the result is `MAX_EXPONENT` + 1.
		  /// - If the argument is zero or subnormal, then the result is `MIN_EXPONENT` - 1.
		  
		  // Bitwise convert `d` to UInt64, mask out exponent bits, shift
		  // to the right and then subtract out Double's bias adjust to
		  // get true exponent value.
		  Return RShift(DoubleToRawBits(d) And DOUBLE_EXP_BIT_MASK, 52) - DOUBLE_EXP_BIAS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617274206F66207468652060506F696E74496E547269616E676C656020616C676F726974686D2E
		Private Function HalfPlaneSign(p1 As Point, p2 As Point, p3 As Point) As Double
		  /// Part of the `PointInTriangle` algorithm.
		  /// 
		  /// See [here][1].
		  ///
		  /// [1]: https://stackoverflow.com/a/2049593/278816
		  
		  Return (p1.X - p3.X) * (p2.Y - p3.Y) - (p2.X - p3.X) * (p1.Y - p3.Y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206879706F74656E75736520776974686F757420696E7465726D656469617465206F766572666C6F77206F7220756E646572666C6F772E
		Protected Function Hypotenuse(x As Double, y As Double) As Double
		  /// Returns the hypotenuse (sqrt(x2 +y2)) without intermediate overflow 
		  /// or underflow.
		  /// 
		  /// Adapted from: [here][1].
		  ///
		  /// Special cases:
		  ///   1. If either argument is infinite, then the result is positive infinity.
		  ///   2. If either argument is NaN and neither argument is infinite, 
		  ///      then the result is `NaN`.
		  ///
		  /// The computed result must be within 1 ulp of the exact result. 
		  /// If one parameter is held constant, the results must be semi-monotonic 
		  /// in the other parameter.
		  ///
		  /// [1]: https://stackoverflow.com/a/30809216/278816
		  
		  If x.IsInfinite Or y.IsInfinite Then Return POSITIVE_INFINITY
		  If x.IsNotANumber Or y.IsNotANumber Then Return NAN
		  
		  x = Abs(x)
		  y = Abs(y)
		  
		  If x < y Then
		    Var d As Double = x
		    x = y
		    y = d
		  End If
		  
		  Var xi As Integer = GetExponent(x)
		  Var yi As Integer = GetExponent(y)
		  
		  If xi > yi + 27 Then Return x
		  
		  Var bias As Integer = 0
		  If xi > 510 Or xi < -511 Then
		    bias = xi
		    x = Scalb(x, -bias)
		    y = Scalb(y, -bias)
		  End If
		  
		  Var z As Double = 0
		  If x > 2 * y Then
		    Var x1 As Double = BitsToDouble(DoubleToBits(x) And &hffffffff00000000)
		    Var x2 As Double = x - x1
		    z = Sqrt(x1 * x1 + (y * y + x2 * (x + x1)))
		  Else
		    Var t As Double = 2 * x
		    Var t1 As Double = BitsToDouble(DoubleToBits(t) And &hffffffff00000000)
		    Var t2 As Double = t - t1
		    Var y1 As Double = BitsToDouble(DoubleToBits(y) And &hffffffff00000000)
		    Var y2 As Double = y - y1
		    Var x_y As Double = x - y
		    z = Sqrt(t1 * y1 + (x_y * x_y + (t1 * y2 + t2 * y)))
		  End If
		  
		  If bias = 0 Then
		    Return z
		  Else
		    Return Scalb(z, bias)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662074686520617267756D656E7473206172652022636C6F736520656E6F7567682220746F20626520636F6E7369646572656420657175616C2E
		Protected Function IsCloseTo(d1 As Double, d2 As Double, decimalPoints As Integer = 5) As Boolean
		  /// Returns True if the arguments are "close enough" to be considered equal.
		  /// 
		  /// Thanks to [Graham Busch].
		  ///
		  /// `decimalPoints` is the number of decimal points of accuracy.
		  ///
		  /// [Graham Busch]: https://forum.xojo.com/t/double-equals-help/56862/6
		  
		  Return Round(d1 * Pow(10, decimalPoints)) = Round(d2 * Pow(10, DecimalPoints))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73205472756520696620606960206973206576656E2E
		Protected Function IsEven(i As Integer) As Boolean
		  /// Returns True if `i` is even.
		  
		  Return i Mod 2 = 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662060646020697320612077686F6C65206E756D6265722E
		Protected Function IsInteger(d As Double) As Boolean
		  /// Returns True if `d` is a whole number.
		  
		  Return d = Floor(d)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73205472756520696620606960206973206F64642E
		Protected Function IsOdd(i As Integer) As Boolean
		  /// Returns True if `i` is odd.
		  
		  Return i Mod 2 <> 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662060646020697320636F6E7369646572656420746F206265207A65726F2E
		Protected Function IsZero(d As Double) As Boolean
		  /// Returns True if `d` is considered to be zero.
		  /// 
		  /// Exists as a workaround to the buggy Xojo `Double.Equals` method.
		  ///
		  /// Returns True if `d` is within `Tolerance` of 0.0.
		  ///
		  /// Based on code by [Graham Busch].
		  ///
		  /// Modified from the code in `IsCloseTo`.
		  ///
		  /// [Graham Busch]: https://forum.xojo.com/t/double-equals-help/56862/6
		  
		  If Round(d * Pow(10, 16)) = 0 Then
		    Return True
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4C696E6561726C7920696E746572706F6C61746573206265747765656E2060616020616E642060626020627920746865206672616374696F6E206066602E
		Protected Function Lerp(a As Double, b As Double, f As Double) As Double
		  /// Linearly interpolates between `a` and `b` by the fraction `f`.
		  /// 
		  /// Assumes `f` is clamped between 0 and 1.
		  
		  Return (a * (1.0 - f)) + (b * f)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 536869667473206C656674207468652033322D62697420626974207061747465726E206F66206076602062792060736020626974732E
		Protected Function LShift32(v As Int32, s As Integer) As Int32
		  /// Shifts left the 32-bit bit pattern of `v` by `s` bits. 
		  ///
		  /// Equivalent to Java's `int << x` operator.
		  
		  Return Bitwise.ShiftLeft(v, s, 32)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 536869667473206C656674207468652036342D62697420626974207061747465726E206F66206076602062792060736020626974732E
		Protected Function LShift64(v As Int64, s As Integer) As Int64
		  /// Shifts left the 64-bit bit pattern of `v` by `s` bits.
		  ///
		  /// Equivalent to Java's `int << x` operator.
		  
		  Return Bitwise.ShiftLeft(v, s, 64)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652072656D61696E646572206F662060612F6260207969656C64696E67206120726573756C742077697468207468652073616D65207369676E206173206062602E
		Protected Function Modulo(a As Integer, b As Integer) As Integer
		  /// Returns the remainder of `a/b` yielding a result with the same sign as `b`.
		  /// 
		  /// Credit [here][1].
		  ///
		  /// Functions like Python's `%` operator.
		  ///
		  /// [1]: https://stackoverflow.com/a/42131495/278816
		  
		  Return (a Mod b + b) Mod b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686520666C6F6174696E672D706F696E742076616C75652061646A6163656E7420746F2060646020696E2074686520646972656374696F6E206F66206E6567617469766520696E66696E6974792E
		Protected Function NextDown(d As Double) As Double
		  /// Returns the floating-point value adjacent to `d` in the direction of 
		  /// negative infinity. 
		  /// 
		  /// If the argument is `NaN`, the result is `NaN`.
		  /// If the argument is negative infinity, the result is negative infinity.
		  /// If the argument is zero, the result is `-DOUBLE_MIN_VALUE`.
		  
		  If d.IsNotANumber Or d = NEGATIVE_INFINITY Then
		    Return d
		  Else
		    If d = 0.0 Then
		      Return -DOUBLE_MIN_VALUE
		    Else
		      Return BitsToDouble(DoubleToRawBits(d) + If(d > 0.0, -1, 1))
		    End If
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686520666C6F6174696E672D706F696E742076616C75652061646A6163656E7420746F2060646020696E2074686520646972656374696F6E206F6620706F73697469766520696E66696E6974792E
		Protected Function NextUp(d As Double) As Double
		  /// Returns the floating-point value adjacent to `d` in the direction of 
		  /// positive infinity.
		  ///
		  /// If the argument is `NaN`, the result is `NaN`.
		  /// If the argument is positive infinity, the result is positive infinity.
		  /// If the argument is zero, the result is `DOUBLE_MIN_VALUE`
		  
		  If d.IsNotANumber Or d = POSITIVE_INFINITY Then
		    Return d
		  Else
		    d = d + 0.0
		    Return BitsToDouble(DoubleToRawBits(d) + If(d >= 0.0, 1, -1))
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E756D626572206F66207A65726F206269747320707265636564696E672074686520686967686573742D6F726465722028226C6566746D6F73742229206F6E652D62697420696E207468652074776F277320636F6D706C656D656E742062696E61727920726570726573656E746174696F6E206F66206069602E
		Protected Function NumberOfLeadingZeros(i As Int64) As Int32
		  /// Returns the number of zero bits preceding the highest-order 
		  /// ("leftmost") one-bit in the two's complement binary representation of `i`.
		  /// 
		  /// Returns `64` if `i` has no one-bits in its two's complement 
		  /// representation, in other words if it is equal to zero.
		  /// This method is closely related to the logarithm base 2.
		  ///
		  /// For all positive Int64 values x:
		  /// ```
		  /// Floor(log₂(x)) = `63 - NumberOfLeadingZeros(x)`
		  /// Ceil(₂(x)) = `64 - NumberOfLeadingZeros(x - 1)`
		  /// ```
		  
		  If i = 0 Then Return 64
		  
		  Var n As Int32 = 1
		  Var x As Int32 = RShiftU64(i, 32)
		  
		  If x = 0 Then
		    n = n + 32
		    x = i
		  End If
		  
		  If RShiftU64(x, 16) = 0 Then
		    n = n + 16
		    x = LShift32(x, 16)
		  End If
		  
		  If RShiftU32(x, 24) = 0 Then
		    n = n + 8
		    x = LShift32(x, 8)
		  End If
		  
		  If RShiftU32(x, 28) = 0 Then
		    n = n + 4
		    x = LShift32(x, 4)
		  End If
		  
		  If RShiftU32(x, 30) = 0 Then
		    n = n + 2
		    x = LShift32(x, 2)
		  End If
		  
		  n = n - RShiftU32(x, 31)
		  
		  Return n
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E756D626572206F66207A65726F206269747320666F6C6C6F77696E6720746865206C6F776573742D6F7264657220282272696768746D6F73742229206F6E652D62697420696E207468652074776F277320636F6D706C656D656E742062696E61727920726570726573656E746174696F6E206F66206069602E
		Protected Function NumberOfTrailingZeros(i As Int64) As Int32
		  /// Returns the number of zero bits following the lowest-order ("rightmost")
		  /// one-bit in the two's complement binary representation of `i`.
		  /// 
		  /// Returns `64` if `i` has no one-bits in 
		  /// its two's complement representation, in other words if it is equal to zero.
		  
		  If i = 0 Then Return 64
		  
		  Var n As Int32 = 63
		  Var x, y As Int32
		  
		  y = i
		  If y <> 0 Then
		    n = n - 32
		    x = y
		  Else
		    x = RShiftU64(i, 32)
		  End If
		  
		  y = LShift32(x, 16)
		  If y <> 0 Then
		    n = n - 16
		    x = y
		  End If
		  
		  y = LShift32(x, 8)
		  If y <> 0 Then
		    n = n - 8
		    x = y
		  End If
		  
		  y = LShift32(x, 4)
		  If y <> 0 Then
		    n = n - 4
		    x = y
		  End If
		  
		  y = LShift32(x, 2)
		  If y <> 0 Then
		    n = n - 2
		    x = y
		  End If
		  
		  Return n - RShiftU32(LShift32(x, 1), 31)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662060706020697320696E736964652074686520747269616E676C6520666F726D656420627920746865207061737365642076657274696365732E
		Protected Function PointInTriangle(p As Point, v1 As Point, v2 As Point, v3 As Point) As Boolean
		  /// Returns True if `p` is inside the triangle formed by the passed vertices.
		  ///
		  /// Adapted from [this StackOverflow answer][1].
		  ///
		  /// [1]: https://stackoverflow.com/a/2049593/278816
		  
		  Var d1, d2, d3 As Double
		  Var has_neg, has_pos As Boolean
		  
		  d1 = HalfPlaneSign(p, v1, v2)
		  d2 = HalfPlaneSign(p, v2, v3)
		  d3 = HalfPlaneSign(p, v3, v1)
		  
		  has_neg = (d1 < 0) Or (d2 < 0) Or (d3 < 0)
		  has_pos = (d1 > 0) Or (d2 > 0) Or (d3 > 0)
		  
		  Return Not (has_neg And has_pos)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120666C6F6174696E672D706F696E7420706F776572206F662074776F20696E20746865206E6F726D616C2072616E67652E
		Private Function PowerOfTwoD(n As Int32) As Double
		  /// Returns a floating-point power of two in the normal range.
		  
		  Assert(n >= DOUBLE_MIN_EXPONENT And n <= DOUBLE_MAX_EXPONENT, _
		  "Invalid `n` passed to `PowerOfTwoD`")
		  
		  Return BitsToDouble((ShiftLeft(n + DOUBLE_EXP_BIAS, DOUBLE_SIGNIFICAND_WIDTH - 1)) _
		  And DOUBLE_EXP_BIT_MASK)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320612070737565646F2072616E646F6D206E756D626572206265747765656E20606C6F776020616E64206068696768602E
		Protected Function Random(low As Double, high As Double) As Double
		  /// Returns a psuedo random number between `low` and `high`.
		  
		  Return System.Random.Number * Abs(low - high) + low
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 536869667473206076602060736020706C6163657320746F207468652072696768742C2070726573657276696E6720746865207369676E206269742E
		Protected Function RShift(v As Int64, s As Integer) As Int64
		  /// Shifts `v` `s` places to the right, preserving the sign bit.
		  /// 
		  /// Equivalent to Java's `>>` operator.
		  ///
		  /// Thanks to code from the Xojo forum by [Rick Araujo][1].
		  ///
		  /// [1]: https://forum.xojo.com/58281-bit-shifting-right-help
		  
		  If v >= 0 Then
		    Return Bitwise.ShiftRight(v, s)
		  Else
		    If s = 1 Then
		      Return Bitwise.BitOr(&h8000000000000000, Bitwise.ShiftRight(v, s))
		    End
		    Return Bitwise.BitOr(Bitwise.ShiftLeft(-1, 64 - s), Bitwise.ShiftRight(v, s))
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 5368696674732060766020607360206269747320746F207468652072696768742E205368696674732061207A65726F20696E746F20746865206C6566742D6D6F737420706F736974696F6E2E
		Protected Function RShiftU32(v As Int32, s As Integer) As Int32
		  /// Shifts `v` `s` bits to the right. Shifts a zero into the left-most position.
		  /// 
		  /// Equivalent to Java's `int >>> x` operation.
		  
		  Return Bitwise.ShiftRight(v, s, 32)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 5368696674732060766020607360206269747320746F207468652072696768742E205368696674732061207A65726F20696E746F20746865206C6566742D6D6F737420706F736974696F6E2E
		Protected Function RShiftU64(v As Int64, shift As Integer) As Int64
		  /// Shifts `v` `s` bits to the right. Shifts a zero into the left-most position.
		  /// 
		  /// Equivalent to Java's `long >>> x` operation.
		  
		  Return Bitwise.ShiftRight(v, shift, 64)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320606420C39720325E7363616C65466163746F726020726F756E64656420617320696620706572666F726D656420627920612073696E676C6520636F72726563746C7920726F756E64656420666C6F6174696E672D706F696E74206D756C7469706C7920746F2061206D656D626572206F662074686520646F75626C652076616C7565207365742E
		Protected Function Scalb(d As Double, scaleFactor As Integer) As Double
		  /// Returns `d × 2^scaleFactor` rounded as if performed by a single correctly
		  /// rounded floating-point multiply to a member of the double value set. 
		  /// 
		  /// If the exponent of the result is between `MIN_EXPONENT` and `MAX_EXPONENT`, 
		  /// the answer is calculated exactly. If the exponent of the result
		  /// would be larger than `MAX_EXPONENT` then infinity is returned. 
		  /// If the result is subnormal, precision may be lost. That is, when 
		  /// `Scalb(x, n)` is subnormal, `Scalb(scalb(x, n), -n)` may not equal `x`. 
		  /// When the result is non-`NaN`, the result has the same sign as `d`.
		  /// 
		  /// Special cases:
		  /// - If the first argument is `NaN`, `NaN` is returned.
		  /// - If the first argument is infinite, then an infinity of the same sign is returned.
		  /// - If the first argument is zero, then a zero of the same sign is returned.
		  ///
		  /// When scaling up, it does not matter what order the
		  /// multiply-store operations are done, the result will be
		  /// finite or overflow regardless of the operation ordering.
		  /// However, to get the correct result when scaling down, a
		  /// particular ordering must be used.
		  ///
		  /// When scaling down, the multiply-store operations are
		  /// sequenced so that it is not possible for two consecutive
		  /// multiply-stores to return subnormal results.  If one
		  /// multiply-store result is subnormal, the next multiply will
		  /// round it away to zero.  This is done by first multiplying
		  /// by 2 ^ (scaleFactor % n) and then multiplying several
		  /// times by by 2^n as needed where n is the exponent of number
		  /// that is a covenient power of two.  In this way, at most one
		  /// real rounding error occurs.  If the double value set is
		  /// being used exclusively, the rounding will occur on a
		  /// multiply.  If the double-extended-exponent value set is
		  /// being used, the products will (perhaps) be exact but the
		  /// stores to d are guaranteed to round to the double value set.
		  ///
		  /// It is _not_ a valid implementation to first multiply `d` by
		  /// `2^MIN_EXPONENT` and then by `2 ^ (scaleFactor % MIN_EXPONENT)`
		  /// since eduble ounding on underflow could occur e.g. if the `scaleFactor`
		  /// argument was `MIN_EXPONENT - n` and the exponent of `d` was a
		  /// little less than `-(MIN_EXPONENT - n)`, meaning the final
		  /// result would be subnormal.
		  ///
		  /// Since exact reproducibility of this method can be achieved
		  /// without any undue performance burden, there is no
		  /// compelling reason to allow double rounding on underflow in `scalb`.
		  
		  // Magnitude of a power of two so large that scaling a finite
		  // non-zero value by it would be guaranteed to over or
		  // underflow due to rounding, scaling down takes takes an
		  // additional power of two which is reflected here.
		  Var MAX_SCALE As Int32 = DOUBLE_MAX_EXPONENT + -DOUBLE_MIN_EXPONENT + DOUBLE_SIGNIFICAND_WIDTH + 1
		  Var exp_adjust As Int32 = 0
		  Var scale_increment As Int32 = 0
		  Var exp_delta As Double = NAN
		  
		  // Make sure scaling factor is in a reasonable range.
		  If scaleFactor < 0 Then
		    scaleFactor = Max(scaleFactor, -MAX_SCALE)
		    scale_increment = -512
		    exp_delta = TWO_TO_THE_DOUBLE_SCALE_DOWN
		  Else
		    scaleFactor = Min(scaleFactor, MAX_SCALE)
		    scale_increment = 512
		    exp_delta = TWO_TO_THE_DOUBLE_SCALE_UP
		  End If
		  
		  // Calculate (scaleFactor % +/-512), 512 = 2^9, using
		  // technique from "Hacker's Delight" section 10-2.
		  Var t As Int32 = RShiftU32(RShift(scaleFactor, 8), 23)
		  exp_adjust = ((scaleFactor + t) And CType(511, Int32)) - t
		  
		  d = d * PowerOfTwoD(exp_adjust)
		  scaleFactor = scaleFactor - exp_adjust
		  
		  While scaleFactor <> 0
		    d = d * exp_delta
		    scaleFactor = scaleFactor - scale_increment
		  Wend
		  
		  Return d
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865207369676E206F66206064602E
		Protected Function Signum(d As Double) As Double
		  /// Returns the sign of `d`.
		  /// 
		  ///  Returns:
		  ///  * Zero if the argument is zero
		  ///  * `1.0` if the argument is greater than zero
		  ///  * `-1.0` if the argument is less than zero.
		  ///  * If the argument is NaN, then the result is NaN.
		  
		  If d.IsNotANumber Then
		    Return d
		  Else
		    Return Sign(d)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F6620612063757272656E63792076616C75652E
		Function ToBinaryString(Extends currencyValue As Currency) As String
		  /// Returns a binary string representation of a currency value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var mb As New MemoryBlock(8)
		  mb.LittleEndian = False
		  mb.CurrencyValue(0) = currencyValue
		  Var ui64 As UInt64 = mb.UInt64Value(0)
		  
		  Var s As String = _
		  "0000000000000000000000000000000000000000000000000000000000000000" + ui64.ToBinary
		  
		  Return s.Right(64)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F66206120646F75626C652076616C75652E
		Function ToBinaryString(Extends doubleValue As Double) As String
		  /// Returns a binary string representation of a double value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var mb As New MemoryBlock(8)
		  mb.LittleEndian = false
		  mb.DoubleValue(0) = doubleValue
		  Var ui64 As UInt64 = mb.UInt64Value(0)
		  
		  Var s As String = _
		  "0000000000000000000000000000000000000000000000000000000000000000" + ui64.ToBinary
		  
		  Return s.Right(64)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F662061207369676E65642031362D62697420696E74656765722076616C75652E
		Function ToBinaryString(Extends i16 As Int16) As String
		  /// Returns a binary string representation of a signed 16-bit integer value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var s As String = "0000000000000000" + i16.ToBinary
		  
		  Return s.Right(16)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F662061207369676E65642033322D62697420696E74656765722076616C75652E
		Function ToBinaryString(Extends i32 As Int32) As String
		  /// Returns a binary string representation of a signed 32-bit integer value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var s As String = "00000000000000000000000000000000" + i32.ToBinary
		  
		  Return s.Right(32)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F662061207369676E65642036342D62697420696E74656765722076616C75652E
		Function ToBinaryString(Extends i64 As Int64) As String
		  /// Returns a binary string representation of a signed 64-bit integer value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var s As String = _
		  "0000000000000000000000000000000000000000000000000000000000000000" + i64.ToBinary
		  
		  Return s.Right(64)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F662061207369676E656420382D62697420696E74656765722076616C75652E
		Function ToBinaryString(Extends i8 As Int8) As String
		  /// Returns a binary string representation of a signed 8-bit integer value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var s As String = "00000000" + i8.ToBinary
		  
		  Return s.Right(8)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F66206120586F6A6F206053696E676C65602076616C75652E
		Function ToBinaryString(Extends singleValue As Single) As String
		  /// Returns a binary string representation of a Xojo `Single` value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var mb As New MemoryBlock(4)
		  mb.LittleEndian = false
		  mb.SingleValue(0) = singlevalue
		  Var ui32 As UInt32 = mb.UInt32Value(0)
		  
		  Var s As String = "00000000000000000000000000000000" + ui32.ToBinary
		  
		  Return s.Right(32)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F6620616E20756E7369676E65642031362D62697420696E74656765722076616C75652E
		Function ToBinaryString(Extends i16 As UInt16) As String
		  /// Returns a binary string representation of an unsigned 16-bit integer value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var s As String = "0000000000000000" + i16.ToBinary
		  
		  Return s.Right(16)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F6620616E20756E7369676E65642033322D62697420696E74656765722076616C75652E
		Function ToBinaryString(Extends i32 As UInt32) As String
		  /// Returns a binary string representation of an unsigned 32-bit integer value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  
		  Var s As String = "00000000000000000000000000000000" + i32.ToBinary
		  
		  Return s.Right(32)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F6620616E20756E7369676E65642036342D62697420696E74656765722076616C75652E
		Function ToBinaryString(Extends i64 As UInt64) As String
		  /// Returns a binary string representation of an unsigned 64-bit integer value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var s As String = _
		  "0000000000000000000000000000000000000000000000000000000000000000" + i64.ToBinary
		  
		  Return s.Right(64)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612062696E61727920737472696E6720726570726573656E746174696F6E206F6620616E20756E7369676E656420382D62697420696E74656765722076616C75652E
		Function ToBinaryString(Extends i8 As UInt8) As String
		  /// Returns a binary string representation of an unsigned 8-bit integer value.
		  ///
		  /// Credit to [Norman Palardy][1].
		  ///
		  /// [1]: https://www.great-white-software.com/blog/2020/01/29/bin-hex-and-oct/
		  
		  Var s As String = "00000000" + i8.ToBinary
		  
		  Return s.Right(8)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206072616469616E736020696E20646567726565732E
		Protected Function ToDegrees(radians As Double) As Double
		  /// Returns `radians` in degrees.
		  
		  Static m180_OVER_PI As Double = 180 / PI
		  
		  Return radians * m180_OVER_PI
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732060646567726565736020696E2072616469616E732E
		Protected Function ToRadians(degrees As Double) As Double
		  /// Returns `degrees` in radians.
		  
		  Static mPI_OVER_180 As Double = PI / 180
		  
		  Return degrees * mPI_OVER_180
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 577261707320606960206265747765656E207A65726F20616E6420606D617856616C7565602E
		Protected Function WrapInteger(i As Integer, maxValue As Integer) As Integer
		  /// Wraps `i` between zero and `maxValue`.
		  
		  // Easy exit.
		  If i >= 0 And i <= maxValue Then Return i
		  
		  If i > maxValue Then
		    Var tmp As Integer = i Mod maxValue
		    Return If(tmp <= 0, maxValue + tmp, tmp)
		  Else
		    // i must be < 0
		    Var tmp As Integer = i Mod maxValue
		    Return If(tmp < 0, maxValue + tmp, tmp)
		  End If
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		This module exposes a wide range of mathematical methods.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h1, Description = 42696173207573656420696E20726570726573656E74696E67206120446F75626C65206578706F6E656E742E
		#tag Getter
			Get
			  Return 1023
			End Get
		#tag EndGetter
		Protected DOUBLE_EXP_BIAS As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 426974206D61736B20746F2069736F6C61746520746865206578706F6E656E74206669656C64206F66206120446F75626C652E
		#tag Getter
			Get
			  Return &h7FF0000000000000
			  
			End Get
		#tag EndGetter
		Protected DOUBLE_EXP_BIT_MASK As Int64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 4D6178696D756D206578706F6E656E7420612066696E69746520446F75626C65207661726961626C65206D617920686176652E20497420697320657175616C20746F207468652076616C75652072657475726E656420627920604D617468734B69742E4765744578706F6E656E7428444F55424C455F4D41585F56414C554529602E
		#tag Getter
			Get
			  Return 1023
			  
			End Get
		#tag EndGetter
		Protected DOUBLE_MAX_EXPONENT As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 4D696E696D756D206578706F6E656E742061206E6F726D616C6973656420446F75626C65207661726961626C65206D617920686176652E2020497420697320657175616C20746F207468652076616C75652072657475726E656420627920604D617468734B69742E4765744578706F6E656E7428444F55424C455F4D494E5F4E4F524D414C29602E
		#tag Getter
			Get
			  Return -1022
			End Get
		#tag EndGetter
		Protected DOUBLE_MIN_EXPONENT As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 546865206578706F6E656E742074686520736D616C6C65737420706F73697469766520446F75626C65207375626E6F726D616C2076616C756520776F756C64206861766520696620697420636F756C64206265206E6F726D616C697365642E
		#tag Getter
			Get
			  Return -1076
			End Get
		#tag EndGetter
		Protected DOUBLE_MIN_SUB_EXPONENT As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 5468652077696474682028696E206269747329206F6620746865207369676E69666963616E64206F66206120646F75626C652E
		#tag Getter
			Get
			  Return 53
			End Get
		#tag EndGetter
		Protected DOUBLE_SIGNIFICAND_WIDTH As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 426974206D61736B20746F2069736F6C61746520746865207369676E69666963616E64206669656C64206F66206120446F75626C652E
		#tag Getter
			Get
			  Return &h000FFFFFFFFFFFFF
			  
			End Get
		#tag EndGetter
		Protected DOUBLE_SIGNIF_BIT_MASK As Int64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 426974206D61736B20746F2069736F6C61746520746865207369676E20626974206F66206120446F75626C652E
		#tag Getter
			Get
			  Return &h8000000000000000
			End Get
		#tag EndGetter
		Protected DOUBLE_SIGN_BIT_MASK As Int64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 416E20617070726F78696D6174696F6E206F66206D616368696E6520657073696C6F6E2E
		#tag Getter
			Get
			  // Returns an approximation of machine epsilon.
			  
			  Static e As Double = ComputeEpsilon
			  
			  Return e
			  
			End Get
		#tag EndGetter
		Protected Epsilon As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 52657475726E7320604E614E6020286E6F742061206E756D626572292E
		#tag Getter
			Get
			  Static mNAN As Double = 0.0 / 0.0
			  
			  Return mNAN
			  
			End Get
		#tag EndGetter
		Protected NAN As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 5468652076616C7565206F66206E6567617469766520696E66696E6974792E
		#tag Getter
			Get
			  Static mNEGATIVE_INFINITY As Double = -1.0 / 0.0
			  
			  Return mNEGATIVE_INFINITY
			End Get
		#tag EndGetter
		Protected NEGATIVE_INFINITY As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 5468652076616C7565206F6620706F73697469766520696E66696E6974792E
		#tag Getter
			Get
			  Static mPOSITIVE_INFINITY As Double = 1.0 / 0.0
			  
			  Return mPOSITIVE_INFINITY
			End Get
		#tag EndGetter
		Protected POSITIVE_INFINITY As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 4120707265636F6D70757465642076616C7565206F66206032202A20CF80602E
		#tag Getter
			Get
			  Static twoPi As Double = 2 * PI
			  Return twoPi
			  
			End Get
		#tag EndGetter
		Protected TWO_PI As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21, Description = 4120636F6E7374616E74207573656420696E20605363616C622829602E
		#tag Getter
			Get
			  Static mTWO_TO_THE_DOUBLE_SCALE_DOWN As Double = PowerOfTwoD(-512)
			  
			  Return mTWO_TO_THE_DOUBLE_SCALE_DOWN
			End Get
		#tag EndGetter
		Private TWO_TO_THE_DOUBLE_SCALE_DOWN As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21, Description = 4120636F6E7374616E74207573656420696E20605363616C622829602E
		#tag Getter
			Get
			  Static mTWO_TO_THE_DOUBLE_SCALE_UP As Double = PowerOfTwoD(512)
			  
			  Return mTWO_TO_THE_DOUBLE_SCALE_UP
			  
			End Get
		#tag EndGetter
		Private TWO_TO_THE_DOUBLE_SCALE_UP As Double
	#tag EndComputedProperty


	#tag Constant, Name = DOUBLE_MAX_VALUE, Type = Double, Dynamic = False, Default = \"1.7976931348623157e+308", Scope = Protected, Description = 546865206C61726765737420706F7369746976652066696E6974652076616C7565206F66207479706520446F75626C652E
	#tag EndConstant

	#tag Constant, Name = DOUBLE_MIN_NORMAL, Type = Double, Dynamic = False, Default = \"2.2250738585072014E-308", Scope = Protected, Description = 54686520736D616C6C65737420706F736974697665206E6F726D616C20446F75626C652076616C75652C2060325E2D31303232602E20204974277320657175616C20746F20604D617468734B69742E42697473546F446F75626C652826683030313030303030303030303030303029602E
	#tag EndConstant

	#tag Constant, Name = DOUBLE_MIN_VALUE, Type = Double, Dynamic = False, Default = \"4.94065645841246544176568792868221372e-324", Scope = Protected, Description = 54686520736D616C6C65737420706F736974697665206E6F6E2D7A65726F2076616C7565206F66207479706520446F75626C653A2020325E2D313037342E
	#tag EndConstant

	#tag Constant, Name = INT32_MAX_VALUE, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Protected, Description = 546865206D6178696D756D2076616C7565206F6620616E2060496E743332602E
	#tag EndConstant

	#tag Constant, Name = INT32_MIN_VALUE, Type = Double, Dynamic = False, Default = \"-2147483648", Scope = Protected, Description = 546865206D696E696D756D2076616C7565206F6620616E2060496E743332602E
	#tag EndConstant

	#tag Constant, Name = INT64_MAX_VALUE, Type = Double, Dynamic = False, Default = \"&h7fffffffffffffff", Scope = Protected, Description = 546865206D6178696D756D2076616C7565206F6620616E2060496E743634602E
	#tag EndConstant

	#tag Constant, Name = PI, Type = Double, Dynamic = False, Default = \"3.14159265359", Scope = Protected, Description = 5468652076616C7565206F662060CF806020746F20313120646563696D616C20706C616365732E
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
