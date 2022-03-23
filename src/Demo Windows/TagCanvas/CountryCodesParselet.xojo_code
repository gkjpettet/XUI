#tag Class
Protected Class CountryCodesParselet
Implements XUITagParselet
	#tag Method, Flags = &h21, Description = 506172736573207468652062756E646C6564204A534F4E2066696C6520696E746F20612064696374696F6E617279206D617070696E6720636F756E747279206E616D657320746F2074686569722074776F20646967697420636F64652E
		Private Shared Function ConstructDictionary() As Dictionary
		  /// Parses the bundled JSON file into a dictionary mapping country names to their two digit code.
		  
		  Var d As New Dictionary
		  
		  Var data() As Object = ParseJSON(COUNTRY_CODES_JSON)
		  For Each obj As Object In data
		    d.Value(Dictionary(obj).Value("Name")) = Dictionary(obj).Value("Code")
		  Next obj
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4966206073602069732061207265636F676E6973656420636F756E747279206E616D65207468656E2072657475726E732061207461672077686F7365207469746C652069732074686520636F756E74727927732074776F20646967697420636F646520616E64206E6F2061726269747261727920646174612E
		Function Parse(s As String) As XUITag
		  /// If `s` is a recognised country name then returns a tag whose title is the country's two digit code 
		  /// and no arbitrary data.
		  ///
		  /// Part of the XUITagParselet interface.
		  
		  If CountryNameCodeDict.HasKey(s) Then
		    Return New XUITag(CountryNameCodeDict.Value(s), Nil)
		  Else
		    Return Nil
		  End If
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 41207374617469632064696374696F6E617279206D617070696E6720636F756E747279206E616D657320284B65792920746F2074686569722074776F20646967697420636F6465202856616C7565292E
		#tag Getter
			Get
			  Static d As Dictionary = ConstructDictionary
			  Return d
			  
			End Get
		#tag EndGetter
		Shared CountryNameCodeDict As Dictionary
	#tag EndComputedProperty


	#tag Constant, Name = COUNTRY_CODES_JSON, Type = String, Dynamic = False, Default = \"[{\"Code\": \"AF\"\x2C \"Name\": \"Afghanistan\"}\x2C{\"Code\": \"AX\"\x2C \"Name\": \"\\u00c5land Islands\"}\x2C{\"Code\": \"AL\"\x2C \"Name\": \"Albania\"}\x2C{\"Code\": \"DZ\"\x2C \"Name\": \"Algeria\"}\x2C{\"Code\": \"AS\"\x2C \"Name\": \"American Samoa\"}\x2C{\"Code\": \"AD\"\x2C \"Name\": \"Andorra\"}\x2C{\"Code\": \"AO\"\x2C \"Name\": \"Angola\"}\x2C{\"Code\": \"AI\"\x2C \"Name\": \"Anguilla\"}\x2C{\"Code\": \"AQ\"\x2C \"Name\": \"Antarctica\"}\x2C{\"Code\": \"AG\"\x2C \"Name\": \"Antigua and Barbuda\"}\x2C{\"Code\": \"AR\"\x2C \"Name\": \"Argentina\"}\x2C{\"Code\": \"AM\"\x2C \"Name\": \"Armenia\"}\x2C{\"Code\": \"AW\"\x2C \"Name\": \"Aruba\"}\x2C{\"Code\": \"AU\"\x2C \"Name\": \"Australia\"}\x2C{\"Code\": \"AT\"\x2C \"Name\": \"Austria\"}\x2C{\"Code\": \"AZ\"\x2C \"Name\": \"Azerbaijan\"}\x2C{\"Code\": \"BS\"\x2C \"Name\": \"Bahamas\"}\x2C{\"Code\": \"BH\"\x2C \"Name\": \"Bahrain\"}\x2C{\"Code\": \"BD\"\x2C \"Name\": \"Bangladesh\"}\x2C{\"Code\": \"BB\"\x2C \"Name\": \"Barbados\"}\x2C{\"Code\": \"BY\"\x2C \"Name\": \"Belarus\"}\x2C{\"Code\": \"BE\"\x2C \"Name\": \"Belgium\"}\x2C{\"Code\": \"BZ\"\x2C \"Name\": \"Belize\"}\x2C{\"Code\": \"BJ\"\x2C \"Name\": \"Benin\"}\x2C{\"Code\": \"BM\"\x2C \"Name\": \"Bermuda\"}\x2C{\"Code\": \"BT\"\x2C \"Name\": \"Bhutan\"}\x2C{\"Code\": \"BO\"\x2C \"Name\": \"Bolivia\x2C Plurinational State of\"}\x2C{\"Code\": \"BQ\"\x2C \"Name\": \"Bonaire\x2C Sint Eustatius and Saba\"}\x2C{\"Code\": \"BA\"\x2C \"Name\": \"Bosnia and Herzegovina\"}\x2C{\"Code\": \"BW\"\x2C \"Name\": \"Botswana\"}\x2C{\"Code\": \"BV\"\x2C \"Name\": \"Bouvet Island\"}\x2C{\"Code\": \"BR\"\x2C \"Name\": \"Brazil\"}\x2C{\"Code\": \"IO\"\x2C \"Name\": \"British Indian Ocean Territory\"}\x2C{\"Code\": \"BN\"\x2C \"Name\": \"Brunei Darussalam\"}\x2C{\"Code\": \"BG\"\x2C \"Name\": \"Bulgaria\"}\x2C{\"Code\": \"BF\"\x2C \"Name\": \"Burkina Faso\"}\x2C{\"Code\": \"BI\"\x2C \"Name\": \"Burundi\"}\x2C{\"Code\": \"KH\"\x2C \"Name\": \"Cambodia\"}\x2C{\"Code\": \"CM\"\x2C \"Name\": \"Cameroon\"}\x2C{\"Code\": \"CA\"\x2C \"Name\": \"Canada\"}\x2C{\"Code\": \"CV\"\x2C \"Name\": \"Cape Verde\"}\x2C{\"Code\": \"KY\"\x2C \"Name\": \"Cayman Islands\"}\x2C{\"Code\": \"CF\"\x2C \"Name\": \"Central African Republic\"}\x2C{\"Code\": \"TD\"\x2C \"Name\": \"Chad\"}\x2C{\"Code\": \"CL\"\x2C \"Name\": \"Chile\"}\x2C{\"Code\": \"CN\"\x2C \"Name\": \"China\"}\x2C{\"Code\": \"CX\"\x2C \"Name\": \"Christmas Island\"}\x2C{\"Code\": \"CC\"\x2C \"Name\": \"Cocos (Keeling) Islands\"}\x2C{\"Code\": \"CO\"\x2C \"Name\": \"Colombia\"}\x2C{\"Code\": \"KM\"\x2C \"Name\": \"Comoros\"}\x2C{\"Code\": \"CG\"\x2C \"Name\": \"Congo\"}\x2C{\"Code\": \"CD\"\x2C \"Name\": \"Congo\x2C the Democratic Republic of the\"}\x2C{\"Code\": \"CK\"\x2C \"Name\": \"Cook Islands\"}\x2C{\"Code\": \"CR\"\x2C \"Name\": \"Costa Rica\"}\x2C{\"Code\": \"CI\"\x2C \"Name\": \"C\\u00f4te d\'Ivoire\"}\x2C{\"Code\": \"HR\"\x2C \"Name\": \"Croatia\"}\x2C{\"Code\": \"CU\"\x2C \"Name\": \"Cuba\"}\x2C{\"Code\": \"CW\"\x2C \"Name\": \"Cura\\u00e7ao\"}\x2C{\"Code\": \"CY\"\x2C \"Name\": \"Cyprus\"}\x2C{\"Code\": \"CZ\"\x2C \"Name\": \"Czech Republic\"}\x2C{\"Code\": \"DK\"\x2C \"Name\": \"Denmark\"}\x2C{\"Code\": \"DJ\"\x2C \"Name\": \"Djibouti\"}\x2C{\"Code\": \"DM\"\x2C \"Name\": \"Dominica\"}\x2C{\"Code\": \"DO\"\x2C \"Name\": \"Dominican Republic\"}\x2C{\"Code\": \"EC\"\x2C \"Name\": \"Ecuador\"}\x2C{\"Code\": \"EG\"\x2C \"Name\": \"Egypt\"}\x2C{\"Code\": \"SV\"\x2C \"Name\": \"El Salvador\"}\x2C{\"Code\": \"GQ\"\x2C \"Name\": \"Equatorial Guinea\"}\x2C{\"Code\": \"ER\"\x2C \"Name\": \"Eritrea\"}\x2C{\"Code\": \"EE\"\x2C \"Name\": \"Estonia\"}\x2C{\"Code\": \"ET\"\x2C \"Name\": \"Ethiopia\"}\x2C{\"Code\": \"FK\"\x2C \"Name\": \"Falkland Islands (Malvinas)\"}\x2C{\"Code\": \"FO\"\x2C \"Name\": \"Faroe Islands\"}\x2C{\"Code\": \"FJ\"\x2C \"Name\": \"Fiji\"}\x2C{\"Code\": \"FI\"\x2C \"Name\": \"Finland\"}\x2C{\"Code\": \"FR\"\x2C \"Name\": \"France\"}\x2C{\"Code\": \"GF\"\x2C \"Name\": \"French Guiana\"}\x2C{\"Code\": \"PF\"\x2C \"Name\": \"French Polynesia\"}\x2C{\"Code\": \"TF\"\x2C \"Name\": \"French Southern Territories\"}\x2C{\"Code\": \"GA\"\x2C \"Name\": \"Gabon\"}\x2C{\"Code\": \"GM\"\x2C \"Name\": \"Gambia\"}\x2C{\"Code\": \"GE\"\x2C \"Name\": \"Georgia\"}\x2C{\"Code\": \"DE\"\x2C \"Name\": \"Germany\"}\x2C{\"Code\": \"GH\"\x2C \"Name\": \"Ghana\"}\x2C{\"Code\": \"GI\"\x2C \"Name\": \"Gibraltar\"}\x2C{\"Code\": \"GR\"\x2C \"Name\": \"Greece\"}\x2C{\"Code\": \"GL\"\x2C \"Name\": \"Greenland\"}\x2C{\"Code\": \"GD\"\x2C \"Name\": \"Grenada\"}\x2C{\"Code\": \"GP\"\x2C \"Name\": \"Guadeloupe\"}\x2C{\"Code\": \"GU\"\x2C \"Name\": \"Guam\"}\x2C{\"Code\": \"GT\"\x2C \"Name\": \"Guatemala\"}\x2C{\"Code\": \"GG\"\x2C \"Name\": \"Guernsey\"}\x2C{\"Code\": \"GN\"\x2C \"Name\": \"Guinea\"}\x2C{\"Code\": \"GW\"\x2C \"Name\": \"Guinea-Bissau\"}\x2C{\"Code\": \"GY\"\x2C \"Name\": \"Guyana\"}\x2C{\"Code\": \"HT\"\x2C \"Name\": \"Haiti\"}\x2C{\"Code\": \"HM\"\x2C \"Name\": \"Heard Island and McDonald Islands\"}\x2C{\"Code\": \"VA\"\x2C \"Name\": \"Holy See (Vatican City State)\"}\x2C{\"Code\": \"HN\"\x2C \"Name\": \"Honduras\"}\x2C{\"Code\": \"HK\"\x2C \"Name\": \"Hong Kong\"}\x2C{\"Code\": \"HU\"\x2C \"Name\": \"Hungary\"}\x2C{\"Code\": \"IS\"\x2C \"Name\": \"Iceland\"}\x2C{\"Code\": \"IN\"\x2C \"Name\": \"India\"}\x2C{\"Code\": \"ID\"\x2C \"Name\": \"Indonesia\"}\x2C{\"Code\": \"IR\"\x2C \"Name\": \"Iran\x2C Islamic Republic of\"}\x2C{\"Code\": \"IQ\"\x2C \"Name\": \"Iraq\"}\x2C{\"Code\": \"IE\"\x2C \"Name\": \"Ireland\"}\x2C{\"Code\": \"IM\"\x2C \"Name\": \"Isle of Man\"}\x2C{\"Code\": \"IL\"\x2C \"Name\": \"Israel\"}\x2C{\"Code\": \"IT\"\x2C \"Name\": \"Italy\"}\x2C{\"Code\": \"JM\"\x2C \"Name\": \"Jamaica\"}\x2C{\"Code\": \"JP\"\x2C \"Name\": \"Japan\"}\x2C{\"Code\": \"JE\"\x2C \"Name\": \"Jersey\"}\x2C{\"Code\": \"JO\"\x2C \"Name\": \"Jordan\"}\x2C{\"Code\": \"KZ\"\x2C \"Name\": \"Kazakhstan\"}\x2C{\"Code\": \"KE\"\x2C \"Name\": \"Kenya\"}\x2C{\"Code\": \"KI\"\x2C \"Name\": \"Kiribati\"}\x2C{\"Code\": \"KP\"\x2C \"Name\": \"Korea\x2C Democratic People\'s Republic of\"}\x2C{\"Code\": \"KR\"\x2C \"Name\": \"Korea\x2C Republic of\"}\x2C{\"Code\": \"KW\"\x2C \"Name\": \"Kuwait\"}\x2C{\"Code\": \"KG\"\x2C \"Name\": \"Kyrgyzstan\"}\x2C{\"Code\": \"LA\"\x2C \"Name\": \"Lao People\'s Democratic Republic\"}\x2C{\"Code\": \"LV\"\x2C \"Name\": \"Latvia\"}\x2C{\"Code\": \"LB\"\x2C \"Name\": \"Lebanon\"}\x2C{\"Code\": \"LS\"\x2C \"Name\": \"Lesotho\"}\x2C{\"Code\": \"LR\"\x2C \"Name\": \"Liberia\"}\x2C{\"Code\": \"LY\"\x2C \"Name\": \"Libya\"}\x2C{\"Code\": \"LI\"\x2C \"Name\": \"Liechtenstein\"}\x2C{\"Code\": \"LT\"\x2C \"Name\": \"Lithuania\"}\x2C{\"Code\": \"LU\"\x2C \"Name\": \"Luxembourg\"}\x2C{\"Code\": \"MO\"\x2C \"Name\": \"Macao\"}\x2C{\"Code\": \"MK\"\x2C \"Name\": \"Macedonia\x2C the Former Yugoslav Republic of\"}\x2C{\"Code\": \"MG\"\x2C \"Name\": \"Madagascar\"}\x2C{\"Code\": \"MW\"\x2C \"Name\": \"Malawi\"}\x2C{\"Code\": \"MY\"\x2C \"Name\": \"Malaysia\"}\x2C{\"Code\": \"MV\"\x2C \"Name\": \"Maldives\"}\x2C{\"Code\": \"ML\"\x2C \"Name\": \"Mali\"}\x2C{\"Code\": \"MT\"\x2C \"Name\": \"Malta\"}\x2C{\"Code\": \"MH\"\x2C \"Name\": \"Marshall Islands\"}\x2C{\"Code\": \"MQ\"\x2C \"Name\": \"Martinique\"}\x2C{\"Code\": \"MR\"\x2C \"Name\": \"Mauritania\"}\x2C{\"Code\": \"MU\"\x2C \"Name\": \"Mauritius\"}\x2C{\"Code\": \"YT\"\x2C \"Name\": \"Mayotte\"}\x2C{\"Code\": \"MX\"\x2C \"Name\": \"Mexico\"}\x2C{\"Code\": \"FM\"\x2C \"Name\": \"Micronesia\x2C Federated States of\"}\x2C{\"Code\": \"MD\"\x2C \"Name\": \"Moldova\x2C Republic of\"}\x2C{\"Code\": \"MC\"\x2C \"Name\": \"Monaco\"}\x2C{\"Code\": \"MN\"\x2C \"Name\": \"Mongolia\"}\x2C{\"Code\": \"ME\"\x2C \"Name\": \"Montenegro\"}\x2C{\"Code\": \"MS\"\x2C \"Name\": \"Montserrat\"}\x2C{\"Code\": \"MA\"\x2C \"Name\": \"Morocco\"}\x2C{\"Code\": \"MZ\"\x2C \"Name\": \"Mozambique\"}\x2C{\"Code\": \"MM\"\x2C \"Name\": \"Myanmar\"}\x2C{\"Code\": \"NA\"\x2C \"Name\": \"Namibia\"}\x2C{\"Code\": \"NR\"\x2C \"Name\": \"Nauru\"}\x2C{\"Code\": \"NP\"\x2C \"Name\": \"Nepal\"}\x2C{\"Code\": \"NL\"\x2C \"Name\": \"Netherlands\"}\x2C{\"Code\": \"NC\"\x2C \"Name\": \"New Caledonia\"}\x2C{\"Code\": \"NZ\"\x2C \"Name\": \"New Zealand\"}\x2C{\"Code\": \"NI\"\x2C \"Name\": \"Nicaragua\"}\x2C{\"Code\": \"NE\"\x2C \"Name\": \"Niger\"}\x2C{\"Code\": \"NG\"\x2C \"Name\": \"Nigeria\"}\x2C{\"Code\": \"NU\"\x2C \"Name\": \"Niue\"}\x2C{\"Code\": \"NF\"\x2C \"Name\": \"Norfolk Island\"}\x2C{\"Code\": \"MP\"\x2C \"Name\": \"Northern Mariana Islands\"}\x2C{\"Code\": \"NO\"\x2C \"Name\": \"Norway\"}\x2C{\"Code\": \"OM\"\x2C \"Name\": \"Oman\"}\x2C{\"Code\": \"PK\"\x2C \"Name\": \"Pakistan\"}\x2C{\"Code\": \"PW\"\x2C \"Name\": \"Palau\"}\x2C{\"Code\": \"PS\"\x2C \"Name\": \"Palestine\x2C State of\"}\x2C{\"Code\": \"PA\"\x2C \"Name\": \"Panama\"}\x2C{\"Code\": \"PG\"\x2C \"Name\": \"Papua New Guinea\"}\x2C{\"Code\": \"PY\"\x2C \"Name\": \"Paraguay\"}\x2C{\"Code\": \"PE\"\x2C \"Name\": \"Peru\"}\x2C{\"Code\": \"PH\"\x2C \"Name\": \"Philippines\"}\x2C{\"Code\": \"PN\"\x2C \"Name\": \"Pitcairn\"}\x2C{\"Code\": \"PL\"\x2C \"Name\": \"Poland\"}\x2C{\"Code\": \"PT\"\x2C \"Name\": \"Portugal\"}\x2C{\"Code\": \"PR\"\x2C \"Name\": \"Puerto Rico\"}\x2C{\"Code\": \"QA\"\x2C \"Name\": \"Qatar\"}\x2C{\"Code\": \"RE\"\x2C \"Name\": \"R\\u00e9union\"}\x2C{\"Code\": \"RO\"\x2C \"Name\": \"Romania\"}\x2C{\"Code\": \"RU\"\x2C \"Name\": \"Russian Federation\"}\x2C{\"Code\": \"RW\"\x2C \"Name\": \"Rwanda\"}\x2C{\"Code\": \"BL\"\x2C \"Name\": \"Saint Barth\\u00e9lemy\"}\x2C{\"Code\": \"SH\"\x2C \"Name\": \"Saint Helena\x2C Ascension and Tristan da Cunha\"}\x2C{\"Code\": \"KN\"\x2C \"Name\": \"Saint Kitts and Nevis\"}\x2C{\"Code\": \"LC\"\x2C \"Name\": \"Saint Lucia\"}\x2C{\"Code\": \"MF\"\x2C \"Name\": \"Saint Martin (French part)\"}\x2C{\"Code\": \"PM\"\x2C \"Name\": \"Saint Pierre and Miquelon\"}\x2C{\"Code\": \"VC\"\x2C \"Name\": \"Saint Vincent and the Grenadines\"}\x2C{\"Code\": \"WS\"\x2C \"Name\": \"Samoa\"}\x2C{\"Code\": \"SM\"\x2C \"Name\": \"San Marino\"}\x2C{\"Code\": \"ST\"\x2C \"Name\": \"Sao Tome and Principe\"}\x2C{\"Code\": \"SA\"\x2C \"Name\": \"Saudi Arabia\"}\x2C{\"Code\": \"SN\"\x2C \"Name\": \"Senegal\"}\x2C{\"Code\": \"RS\"\x2C \"Name\": \"Serbia\"}\x2C{\"Code\": \"SC\"\x2C \"Name\": \"Seychelles\"}\x2C{\"Code\": \"SL\"\x2C \"Name\": \"Sierra Leone\"}\x2C{\"Code\": \"SG\"\x2C \"Name\": \"Singapore\"}\x2C{\"Code\": \"SX\"\x2C \"Name\": \"Sint Maarten (Dutch part)\"}\x2C{\"Code\": \"SK\"\x2C \"Name\": \"Slovakia\"}\x2C{\"Code\": \"SI\"\x2C \"Name\": \"Slovenia\"}\x2C{\"Code\": \"SB\"\x2C \"Name\": \"Solomon Islands\"}\x2C{\"Code\": \"SO\"\x2C \"Name\": \"Somalia\"}\x2C{\"Code\": \"ZA\"\x2C \"Name\": \"South Africa\"}\x2C{\"Code\": \"GS\"\x2C \"Name\": \"South Georgia and the South Sandwich Islands\"}\x2C{\"Code\": \"SS\"\x2C \"Name\": \"South Sudan\"}\x2C{\"Code\": \"ES\"\x2C \"Name\": \"Spain\"}\x2C{\"Code\": \"LK\"\x2C \"Name\": \"Sri Lanka\"}\x2C{\"Code\": \"SD\"\x2C \"Name\": \"Sudan\"}\x2C{\"Code\": \"SR\"\x2C \"Name\": \"Suriname\"}\x2C{\"Code\": \"SJ\"\x2C \"Name\": \"Svalbard and Jan Mayen\"}\x2C{\"Code\": \"SZ\"\x2C \"Name\": \"Swaziland\"}\x2C{\"Code\": \"SE\"\x2C \"Name\": \"Sweden\"}\x2C{\"Code\": \"CH\"\x2C \"Name\": \"Switzerland\"}\x2C{\"Code\": \"SY\"\x2C \"Name\": \"Syrian Arab Republic\"}\x2C{\"Code\": \"TW\"\x2C \"Name\": \"Taiwan\x2C Province of China\"}\x2C{\"Code\": \"TJ\"\x2C \"Name\": \"Tajikistan\"}\x2C{\"Code\": \"TZ\"\x2C \"Name\": \"Tanzania\x2C United Republic of\"}\x2C{\"Code\": \"TH\"\x2C \"Name\": \"Thailand\"}\x2C{\"Code\": \"TL\"\x2C \"Name\": \"Timor-Leste\"}\x2C{\"Code\": \"TG\"\x2C \"Name\": \"Togo\"}\x2C{\"Code\": \"TK\"\x2C \"Name\": \"Tokelau\"}\x2C{\"Code\": \"TO\"\x2C \"Name\": \"Tonga\"}\x2C{\"Code\": \"TT\"\x2C \"Name\": \"Trinidad and Tobago\"}\x2C{\"Code\": \"TN\"\x2C \"Name\": \"Tunisia\"}\x2C{\"Code\": \"TR\"\x2C \"Name\": \"Turkey\"}\x2C{\"Code\": \"TM\"\x2C \"Name\": \"Turkmenistan\"}\x2C{\"Code\": \"TC\"\x2C \"Name\": \"Turks and Caicos Islands\"}\x2C{\"Code\": \"TV\"\x2C \"Name\": \"Tuvalu\"}\x2C{\"Code\": \"UG\"\x2C \"Name\": \"Uganda\"}\x2C{\"Code\": \"UA\"\x2C \"Name\": \"Ukraine\"}\x2C{\"Code\": \"AE\"\x2C \"Name\": \"United Arab Emirates\"}\x2C{\"Code\": \"GB\"\x2C \"Name\": \"United Kingdom\"}\x2C{\"Code\": \"US\"\x2C \"Name\": \"United States\"}\x2C{\"Code\": \"UM\"\x2C \"Name\": \"United States Minor Outlying Islands\"}\x2C{\"Code\": \"UY\"\x2C \"Name\": \"Uruguay\"}\x2C{\"Code\": \"UZ\"\x2C \"Name\": \"Uzbekistan\"}\x2C{\"Code\": \"VU\"\x2C \"Name\": \"Vanuatu\"}\x2C{\"Code\": \"VE\"\x2C \"Name\": \"Venezuela\x2C Bolivarian Republic of\"}\x2C{\"Code\": \"VN\"\x2C \"Name\": \"Viet Nam\"}\x2C{\"Code\": \"VG\"\x2C \"Name\": \"Virgin Islands\x2C British\"}\x2C{\"Code\": \"VI\"\x2C \"Name\": \"Virgin Islands\x2C U.S.\"}\x2C{\"Code\": \"WF\"\x2C \"Name\": \"Wallis and Futuna\"}\x2C{\"Code\": \"EH\"\x2C \"Name\": \"Western Sahara\"}\x2C{\"Code\": \"YE\"\x2C \"Name\": \"Yemen\"}\x2C{\"Code\": \"ZM\"\x2C \"Name\": \"Zambia\"}\x2C{\"Code\": \"ZW\"\x2C \"Name\": \"Zimbabwe\"}]", Scope = Private, Description = 416E206172726179206F662064696374696F6E61726965732E2044696374696F6E61727920666F726D61743A207B436F64653A20537472696E672C204E616D653A20537472696E677D2E
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
End Class
#tag EndClass
