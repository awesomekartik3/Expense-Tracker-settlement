class Currency {
  final String code;
  final String symbol;
  final String name;
  final String country;
  final String flag;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
    required this.country,
    required this.flag,
  });

  Map<String, dynamic> toJson() => {
    'code': code,
    'symbol': symbol,
    'name': name,
    'country': country,
    'flag': flag,
  };

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    code: json['code'] as String? ?? 'INR',
    symbol: json['symbol'] as String? ?? '₹',
    name: json['name'] as String? ?? 'Indian Rupee',
    country: json['country'] as String? ?? 'India',
    flag: json['flag'] as String? ?? '🇮🇳',
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Currency &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;

  static const Currency defaultCurrency = Currency(
    code: 'INR',
    symbol: '₹',
    name: 'Indian Rupee',
    country: 'India',
    flag: '🇮🇳',
  );

  static const List<Currency> popularCurrencies = [
    Currency(code: 'INR', symbol: '₹', name: 'Indian Rupee', country: 'India', flag: '🇮🇳'),
    Currency(code: 'USD', symbol: '\$', name: 'US Dollar', country: 'United States', flag: '🇺🇸'),
    Currency(code: 'EUR', symbol: '€', name: 'Euro', country: 'European Union', flag: '🇪🇺'),
    Currency(code: 'GBP', symbol: '£', name: 'British Pound', country: 'United Kingdom', flag: '🇬🇧'),
    Currency(code: 'AED', symbol: 'د.إ', name: 'UAE Dirham', country: 'United Arab Emirates', flag: '🇦🇪'),
    Currency(code: 'CAD', symbol: 'C\$', name: 'Canadian Dollar', country: 'Canada', flag: '🇨🇦'),
    Currency(code: 'AUD', symbol: 'A\$', name: 'Australian Dollar', country: 'Australia', flag: '🇦🇺'),
    Currency(code: 'SAR', symbol: '﷼', name: 'Saudi Riyal', country: 'Saudi Arabia', flag: '🇸🇦'),
    Currency(code: 'JPY', symbol: '¥', name: 'Japanese Yen', country: 'Japan', flag: '🇯🇵'),
    Currency(code: 'SGD', symbol: 'S\$', name: 'Singapore Dollar', country: 'Singapore', flag: '🇸🇬'),
    Currency(code: 'KWD', symbol: 'KD', name: 'Kuwaiti Dinar', country: 'Kuwait', flag: '🇰🇼'),
    Currency(code: 'QAR', symbol: 'QR', name: 'Qatari Riyal', country: 'Qatar', flag: '🇶🇦'),
  ];

  static const List<Currency> allCurrencies = [
    Currency(code: 'AED', symbol: 'د.إ', name: 'UAE Dirham', country: 'United Arab Emirates', flag: '🇦🇪'),
    Currency(code: 'AFN', symbol: '؋', name: 'Afghan Afghani', country: 'Afghanistan', flag: '🇦🇫'),
    Currency(code: 'ALL', symbol: 'L', name: 'Albanian Lek', country: 'Albania', flag: '🇦🇱'),
    Currency(code: 'AMD', symbol: '֏', name: 'Armenian Dram', country: 'Armenia', flag: '🇦🇲'),
    Currency(code: 'ANG', symbol: 'ƒ', name: 'Netherlands Antillean Guilder', country: 'Curaçao', flag: '🇨🇼'),
    Currency(code: 'AOA', symbol: 'Kz', name: 'Angolan Kwanza', country: 'Angola', flag: '🇦🇴'),
    Currency(code: 'ARS', symbol: '\$', name: 'Argentine Peso', country: 'Argentina', flag: '🇦🇷'),
    Currency(code: 'AUD', symbol: 'A\$', name: 'Australian Dollar', country: 'Australia', flag: '🇦🇺'),
    Currency(code: 'AWG', symbol: 'ƒ', name: 'Aruban Florin', country: 'Aruba', flag: '🇦🇼'),
    Currency(code: 'AZN', symbol: '₼', name: 'Azerbaijani Manat', country: 'Azerbaijan', flag: '🇦🇿'),
    Currency(code: 'BAM', symbol: 'KM', name: 'Bosnia-Herzegovina Convertible Mark', country: 'Bosnia and Herzegovina', flag: '🇧🇦'),
    Currency(code: 'BBD', symbol: 'Bds\$', name: 'Barbadian Dollar', country: 'Barbados', flag: '🇧🇧'),
    Currency(code: 'BDT', symbol: '৳', name: 'Bangladeshi Taka', country: 'Bangladesh', flag: '🇧🇩'),
    Currency(code: 'BGN', symbol: 'лв', name: 'Bulgarian Lev', country: 'Bulgaria', flag: '🇧🇬'),
    Currency(code: 'BHD', symbol: 'BD', name: 'Bahraini Dinar', country: 'Bahrain', flag: '🇧🇭'),
    Currency(code: 'BIF', symbol: 'FBu', name: 'Burundian Franc', country: 'Burundi', flag: '🇧🇮'),
    Currency(code: 'BMD', symbol: '\$', name: 'Bermudan Dollar', country: 'Bermuda', flag: '🇧🇲'),
    Currency(code: 'BND', symbol: 'B\$', name: 'Brunei Dollar', country: 'Brunei', flag: '🇧🇳'),
    Currency(code: 'BOB', symbol: 'Bs.', name: 'Bolivian Boliviano', country: 'Bolivia', flag: '🇧🇴'),
    Currency(code: 'BRL', symbol: 'R\$', name: 'Brazilian Real', country: 'Brazil', flag: '🇧🇷'),
    Currency(code: 'BSD', symbol: 'B\$', name: 'Bahamian Dollar', country: 'Bahamas', flag: '🇧🇸'),
    Currency(code: 'BTN', symbol: 'Nu.', name: 'Bhutanese Ngultrum', country: 'Bhutan', flag: '🇧🇹'),
    Currency(code: 'BWP', symbol: 'P', name: 'Botswanan Pula', country: 'Botswana', flag: '🇧🇼'),
    Currency(code: 'BYN', symbol: 'Br', name: 'Belarusian Ruble', country: 'Belarus', flag: '🇧🇾'),
    Currency(code: 'BZD', symbol: 'BZ\$', name: 'Belize Dollar', country: 'Belize', flag: '🇧🇿'),
    Currency(code: 'CAD', symbol: 'C\$', name: 'Canadian Dollar', country: 'Canada', flag: '🇨🇦'),
    Currency(code: 'CDF', symbol: 'FC', name: 'Congolese Franc', country: 'DR Congo', flag: '🇨🇩'),
    Currency(code: 'CHF', symbol: 'CHF', name: 'Swiss Franc', country: 'Switzerland', flag: '🇨🇭'),
    Currency(code: 'CLP', symbol: '\$', name: 'Chilean Peso', country: 'Chile', flag: '🇨🇱'),
    Currency(code: 'CNY', symbol: '¥', name: 'Chinese Yuan', country: 'China', flag: '🇨🇳'),
    Currency(code: 'COP', symbol: '\$', name: 'Colombian Peso', country: 'Colombia', flag: '🇨🇴'),
    Currency(code: 'CRC', symbol: '₡', name: 'Costa Rican Colón', country: 'Costa Rica', flag: '🇨🇷'),
    Currency(code: 'CUP', symbol: '\$', name: 'Cuban Peso', country: 'Cuba', flag: '🇨🇺'),
    Currency(code: 'CVE', symbol: '\$', name: 'Cape Verdean Escudo', country: 'Cape Verde', flag: '🇨🇻'),
    Currency(code: 'CZK', symbol: 'Kč', name: 'Czech Koruna', country: 'Czech Republic', flag: '🇨🇿'),
    Currency(code: 'DJF', symbol: 'Fdj', name: 'Djiboutian Franc', country: 'Djibouti', flag: '🇩🇯'),
    Currency(code: 'DKK', symbol: 'kr', name: 'Danish Krone', country: 'Denmark', flag: '🇩🇰'),
    Currency(code: 'DOP', symbol: 'RD\$', name: 'Dominican Peso', country: 'Dominican Republic', flag: '🇩🇴'),
    Currency(code: 'DZD', symbol: 'د.ج', name: 'Algerian Dinar', country: 'Algeria', flag: '🇩🇿'),
    Currency(code: 'EGP', symbol: 'E£', name: 'Egyptian Pound', country: 'Egypt', flag: '🇪🇬'),
    Currency(code: 'ERN', symbol: 'Nfk', name: 'Eritrean Nakfa', country: 'Eritrea', flag: '🇪🇷'),
    Currency(code: 'ETB', symbol: 'Br', name: 'Ethiopian Birr', country: 'Ethiopia', flag: '🇪🇹'),
    Currency(code: 'EUR', symbol: '€', name: 'Euro', country: 'European Union', flag: '🇪🇺'),
    Currency(code: 'FJD', symbol: 'FJ\$', name: 'Fijian Dollar', country: 'Fiji', flag: '🇫🇯'),
    Currency(code: 'FKP', symbol: '£', name: 'Falkland Islands Pound', country: 'Falkland Islands', flag: '🇫🇰'),
    Currency(code: 'GBP', symbol: '£', name: 'British Pound', country: 'United Kingdom', flag: '🇬🇧'),
    Currency(code: 'GEL', symbol: '₾', name: 'Georgian Lari', country: 'Georgia', flag: '🇬🇪'),
    Currency(code: 'GHS', symbol: 'GH₵', name: 'Ghanaian Cedi', country: 'Ghana', flag: '🇬🇭'),
    Currency(code: 'GIP', symbol: '£', name: 'Gibraltar Pound', country: 'Gibraltar', flag: '🇬🇮'),
    Currency(code: 'GMD', symbol: 'D', name: 'Gambian Dalasi', country: 'Gambia', flag: '🇬🇲'),
    Currency(code: 'GNF', symbol: 'FG', name: 'Guinean Franc', country: 'Guinea', flag: '🇬🇳'),
    Currency(code: 'GTQ', symbol: 'Q', name: 'Guatemalan Quetzal', country: 'Guatemala', flag: '🇬🇹'),
    Currency(code: 'GYD', symbol: 'G\$', name: 'Guyanaese Dollar', country: 'Guyana', flag: '🇬🇾'),
    Currency(code: 'HKD', symbol: 'HK\$', name: 'Hong Kong Dollar', country: 'Hong Kong', flag: '🇭🇰'),
    Currency(code: 'HNL', symbol: 'L', name: 'Honduran Lempira', country: 'Honduras', flag: '🇭🇳'),
    Currency(code: 'HRK', symbol: 'kn', name: 'Croatian Kuna', country: 'Croatia', flag: '🇭🇷'),
    Currency(code: 'HTG', symbol: 'G', name: 'Haitian Gourde', country: 'Haiti', flag: '🇭🇹'),
    Currency(code: 'HUF', symbol: 'Ft', name: 'Hungarian Forint', country: 'Hungary', flag: '🇭🇺'),
    Currency(code: 'IDR', symbol: 'Rp', name: 'Indonesian Rupiah', country: 'Indonesia', flag: '🇮🇩'),
    Currency(code: 'ILS', symbol: '₪', name: 'Israeli New Shekel', country: 'Israel', flag: '🇮🇱'),
    Currency(code: 'INR', symbol: '₹', name: 'Indian Rupee', country: 'India', flag: '🇮🇳'),
    Currency(code: 'IQD', symbol: 'ع.د', name: 'Iraqi Dinar', country: 'Iraq', flag: '🇮🇶'),
    Currency(code: 'IRR', symbol: '﷼', name: 'Iranian Rial', country: 'Iran', flag: '🇮🇷'),
    Currency(code: 'ISK', symbol: 'kr', name: 'Icelandic Króna', country: 'Iceland', flag: '🇮🇸'),
    Currency(code: 'JMD', symbol: 'J\$', name: 'Jamaican Dollar', country: 'Jamaica', flag: '🇯🇲'),
    Currency(code: 'JOD', symbol: 'JD', name: 'Jordanian Dinar', country: 'Jordan', flag: '🇯🇴'),
    Currency(code: 'JPY', symbol: '¥', name: 'Japanese Yen', country: 'Japan', flag: '🇯🇵'),
    Currency(code: 'KES', symbol: 'KSh', name: 'Kenyan Shilling', country: 'Kenya', flag: '🇰🇪'),
    Currency(code: 'KGS', symbol: 'с', name: 'Kyrgystani Som', country: 'Kyrgyzstan', flag: '🇰🇬'),
    Currency(code: 'KHR', symbol: '៛', name: 'Cambodian Riel', country: 'Cambodia', flag: '🇰🇭'),
    Currency(code: 'KMF', symbol: 'CF', name: 'Comorian Franc', country: 'Comoros', flag: '🇰🇲'),
    Currency(code: 'KPW', symbol: '₩', name: 'North Korean Won', country: 'North Korea', flag: '🇰🇵'),
    Currency(code: 'KRW', symbol: '₩', name: 'South Korean Won', country: 'South Korea', flag: '🇰🇷'),
    Currency(code: 'KWD', symbol: 'KD', name: 'Kuwaiti Dinar', country: 'Kuwait', flag: '🇰🇼'),
    Currency(code: 'KYD', symbol: 'CI\$', name: 'Cayman Islands Dollar', country: 'Cayman Islands', flag: '🇰🇾'),
    Currency(code: 'KZT', symbol: '₸', name: 'Kazakhstani Tenge', country: 'Kazakhstan', flag: '🇰🇿'),
    Currency(code: 'LAK', symbol: '₭', name: 'Laotian Kip', country: 'Laos', flag: '🇱🇦'),
    Currency(code: 'LBP', symbol: 'L£', name: 'Lebanese Pound', country: 'Lebanon', flag: '🇱🇧'),
    Currency(code: 'LKR', symbol: 'Rs', name: 'Sri Lankan Rupee', country: 'Sri Lanka', flag: '🇱🇰'),
    Currency(code: 'LRD', symbol: 'L\$', name: 'Liberian Dollar', country: 'Liberia', flag: '🇱🇷'),
    Currency(code: 'LSL', symbol: 'L', name: 'Lesotho Loti', country: 'Lesotho', flag: '🇱🇸'),
    Currency(code: 'LYD', symbol: 'LD', name: 'Libyan Dinar', country: 'Libya', flag: '🇱🇾'),
    Currency(code: 'MAD', symbol: 'DH', name: 'Moroccan Dirham', country: 'Morocco', flag: '🇲🇦'),
    Currency(code: 'MDL', symbol: 'L', name: 'Moldovan Leu', country: 'Moldova', flag: '🇲🇩'),
    Currency(code: 'MGA', symbol: 'Ar', name: 'Malagasy Ariary', country: 'Madagascar', flag: '🇲🇬'),
    Currency(code: 'MKD', symbol: 'ден', name: 'Macedonian Denar', country: 'North Macedonia', flag: '🇲🇰'),
    Currency(code: 'MMK', symbol: 'K', name: 'Myanmar Kyat', country: 'Myanmar', flag: '🇲🇲'),
    Currency(code: 'MNT', symbol: '₮', name: 'Mongolian Tugrik', country: 'Mongolia', flag: '🇲🇳'),
    Currency(code: 'MOP', symbol: 'MOP\$', name: 'Macanese Pataca', country: 'Macau', flag: '🇲🇴'),
    Currency(code: 'MRU', symbol: 'UM', name: 'Mauritanian Ouguiya', country: 'Mauritania', flag: '🇲🇷'),
    Currency(code: 'MUR', symbol: '₨', name: 'Mauritian Rupee', country: 'Mauritius', flag: '🇲🇺'),
    Currency(code: 'MVR', symbol: 'Rf', name: 'Maldivian Rufiyaa', country: 'Maldives', flag: '🇲🇻'),
    Currency(code: 'MWK', symbol: 'MK', name: 'Malawian Kwacha', country: 'Malawi', flag: '🇲🇼'),
    Currency(code: 'MXN', symbol: 'Mex\$', name: 'Mexican Peso', country: 'Mexico', flag: '🇲🇽'),
    Currency(code: 'MYR', symbol: 'RM', name: 'Malaysian Ringgit', country: 'Malaysia', flag: '🇲🇾'),
    Currency(code: 'MZN', symbol: 'MT', name: 'Mozambican Metical', country: 'Mozambique', flag: '🇲🇿'),
    Currency(code: 'NAD', symbol: 'N\$', name: 'Namibian Dollar', country: 'Namibia', flag: '🇳🇦'),
    Currency(code: 'NGN', symbol: '₦', name: 'Nigerian Naira', country: 'Nigeria', flag: '🇳🇬'),
    Currency(code: 'NIO', symbol: 'C\$', name: 'Nicaraguan Córdoba', country: 'Nicaragua', flag: '🇳🇮'),
    Currency(code: 'NOK', symbol: 'kr', name: 'Norwegian Krone', country: 'Norway', flag: '🇳🇴'),
    Currency(code: 'NPR', symbol: 'रू', name: 'Nepalese Rupee', country: 'Nepal', flag: '🇳🇵'),
    Currency(code: 'NZD', symbol: 'NZ\$', name: 'New Zealand Dollar', country: 'New Zealand', flag: '🇳🇿'),
    Currency(code: 'OMR', symbol: 'OMR', name: 'Omani Rial', country: 'Oman', flag: '🇴🇲'),
    Currency(code: 'PAB', symbol: 'B/.', name: 'Panamanian Balboa', country: 'Panama', flag: '🇵🇦'),
    Currency(code: 'PEN', symbol: 'S/', name: 'Peruvian Sol', country: 'Peru', flag: '🇵🇪'),
    Currency(code: 'PGK', symbol: 'K', name: 'Papua New Guinean Kina', country: 'Papua New Guinea', flag: '🇵🇬'),
    Currency(code: 'PHP', symbol: '₱', name: 'Philippine Peso', country: 'Philippines', flag: '🇵🇭'),
    Currency(code: 'PKR', symbol: '₨', name: 'Pakistani Rupee', country: 'Pakistan', flag: '🇵🇰'),
    Currency(code: 'PLN', symbol: 'zł', name: 'Polish Zloty', country: 'Poland', flag: '🇵🇱'),
    Currency(code: 'PYG', symbol: '₲', name: 'Paraguayan Guarani', country: 'Paraguay', flag: '🇵🇾'),
    Currency(code: 'QAR', symbol: 'QR', name: 'Qatari Riyal', country: 'Qatar', flag: '🇶🇦'),
    Currency(code: 'RON', symbol: 'lei', name: 'Romanian Leu', country: 'Romania', flag: '🇷🇴'),
    Currency(code: 'RSD', symbol: 'дин.', name: 'Serbian Dinar', country: 'Serbia', flag: '🇷🇸'),
    Currency(code: 'RUB', symbol: '₽', name: 'Russian Ruble', country: 'Russia', flag: '🇷🇺'),
    Currency(code: 'RWF', symbol: 'RF', name: 'Rwandan Franc', country: 'Rwanda', flag: '🇷🇼'),
    Currency(code: 'SAR', symbol: '﷼', name: 'Saudi Riyal', country: 'Saudi Arabia', flag: '🇸🇦'),
    Currency(code: 'SBD', symbol: 'SI\$', name: 'Solomon Islands Dollar', country: 'Solomon Islands', flag: '🇸🇧'),
    Currency(code: 'SCR', symbol: 'SR', name: 'Seychellois Rupee', country: 'Seychelles', flag: '🇸🇨'),
    Currency(code: 'SDG', symbol: 'SDG', name: 'Sudanese Pound', country: 'Sudan', flag: '🇸🇩'),
    Currency(code: 'SEK', symbol: 'kr', name: 'Swedish Krona', country: 'Sweden', flag: '🇸🇪'),
    Currency(code: 'SGD', symbol: 'S\$', name: 'Singapore Dollar', country: 'Singapore', flag: '🇸🇬'),
    Currency(code: 'SHP', symbol: '£', name: 'Saint Helena Pound', country: 'Saint Helena', flag: '🇸🇭'),
    Currency(code: 'SLE', symbol: 'Le', name: 'Sierra Leonean Leone', country: 'Sierra Leone', flag: '🇸🇱'),
    Currency(code: 'SOS', symbol: 'S', name: 'Somali Shilling', country: 'Somalia', flag: '🇸🇴'),
    Currency(code: 'SRD', symbol: 'Sr\$', name: 'Surinamese Dollar', country: 'Suriname', flag: '🇸🇷'),
    Currency(code: 'STN', symbol: 'Db', name: 'São Tomé and Príncipe Dobra', country: 'São Tomé and Príncipe', flag: '🇸🇹'),
    Currency(code: 'SYP', symbol: '£S', name: 'Syrian Pound', country: 'Syria', flag: '🇸🇾'),
    Currency(code: 'SZL', symbol: 'E', name: 'Swazi Lilangeni', country: 'Eswatini', flag: '🇸🇿'),
    Currency(code: 'THB', symbol: '฿', name: 'Thai Baht', country: 'Thailand', flag: '🇹🇭'),
    Currency(code: 'TJS', symbol: 'SM', name: 'Tajikistani Somoni', country: 'Tajikistan', flag: '🇹🇯'),
    Currency(code: 'TMT', symbol: 'T', name: 'Turkmenistani Manat', country: 'Turkmenistan', flag: '🇹🇲'),
    Currency(code: 'TND', symbol: 'DT', name: 'Tunisian Dinar', country: 'Tunisia', flag: '🇹🇳'),
    Currency(code: 'TOP', symbol: 'T\$', name: 'Tongan Paʻanga', country: 'Tonga', flag: '🇹🇴'),
    Currency(code: 'TRY', symbol: '₺', name: 'Turkish Lira', country: 'Turkey', flag: '🇹🇷'),
    Currency(code: 'TTD', symbol: 'TT\$', name: 'Trinidad and Tobago Dollar', country: 'Trinidad and Tobago', flag: '🇹🇹'),
    Currency(code: 'TWD', symbol: 'NT\$', name: 'New Taiwan Dollar', country: 'Taiwan', flag: '🇹🇼'),
    Currency(code: 'TZS', symbol: 'TSh', name: 'Tanzanian Shilling', country: 'Tanzania', flag: '🇹🇿'),
    Currency(code: 'UAH', symbol: '₴', name: 'Ukrainian Hryvnia', country: 'Ukraine', flag: '🇺🇦'),
    Currency(code: 'UGX', symbol: 'USh', name: 'Ugandan Shilling', country: 'Uganda', flag: '🇺🇬'),
    Currency(code: 'USD', symbol: '\$', name: 'US Dollar', country: 'United States', flag: '🇺🇸'),
    Currency(code: 'UYU', symbol: '\$U', name: 'Uruguayan Peso', country: 'Uruguay', flag: '🇺🇾'),
    Currency(code: 'UZS', symbol: 'soʻm', name: 'Uzbekistani Som', country: 'Uzbekistan', flag: '🇺🇿'),
    Currency(code: 'VES', symbol: 'Bs.S', name: 'Venezuelan Bolívar', country: 'Venezuela', flag: '🇻🇪'),
    Currency(code: 'VND', symbol: '₫', name: 'Vietnamese Dong', country: 'Vietnam', flag: '🇻🇳'),
    Currency(code: 'VUV', symbol: 'VT', name: 'Vanuatu Vatu', country: 'Vanuatu', flag: '🇻🇺'),
    Currency(code: 'WST', symbol: 'WS\$', name: 'Samoan Tala', country: 'Samoa', flag: '🇼🇸'),
    Currency(code: 'XAF', symbol: 'FCFA', name: 'Central African CFA Franc', country: 'Central Africa', flag: '🇨🇲'),
    Currency(code: 'XCD', symbol: 'EC\$', name: 'East Caribbean Dollar', country: 'East Caribbean', flag: '🇦🇬'),
    Currency(code: 'XOF', symbol: 'CFA', name: 'West African CFA Franc', country: 'West Africa', flag: '🇸🇳'),
    Currency(code: 'XPF', symbol: 'CFPF', name: 'CFP Franc', country: 'French Polynesia', flag: '🇵🇫'),
    Currency(code: 'YER', symbol: '﷼', name: 'Yemeni Rial', country: 'Yemen', flag: '🇾🇪'),
    Currency(code: 'ZAR', symbol: 'R', name: 'South African Rand', country: 'South Africa', flag: '🇿🇦'),
    Currency(code: 'ZMW', symbol: 'ZK', name: 'Zambian Kwacha', country: 'Zambia', flag: '🇿🇲'),
    Currency(code: 'ZWL', symbol: 'Z\$', name: 'Zimbabwean Dollar', country: 'Zimbabwe', flag: '🇿🇼'),
  ];

  static Currency findByCode(String code, [String? fallbackSymbol]) {
    try {
      return allCurrencies.firstWhere(
        (c) => c.code.toUpperCase() == code.toUpperCase(),
      );
    } catch (_) {
      if (fallbackSymbol != null) {
        try {
          return allCurrencies.firstWhere(
            (c) => c.symbol == fallbackSymbol,
          );
        } catch (_) {}
      }
      return defaultCurrency;
    }
  }

  static Currency findBySymbol(String symbol) {
    try {
      return allCurrencies.firstWhere((c) => c.symbol == symbol);
    } catch (_) {
      return defaultCurrency;
    }
  }
}
