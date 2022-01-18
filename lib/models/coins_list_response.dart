class CoinListResponse {
  Status? status;
  List<CoinData>? data;

  CoinListResponse({this.status, this.data});

  CoinListResponse.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['data'] != null) {
      data = <CoinData>[];
      json['data'].forEach((v) {
        data!.add(CoinData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String? timestamp;
  int? errorCode;
  String? errorMessage;
  int? elapsed;
  int? creditCount;
  String? notice;
  int? totalCount;

  Status(
      {this.timestamp,
        this.errorCode,
        this.errorMessage,
        this.elapsed,
        this.creditCount,
        this.notice,
        this.totalCount});

  Status.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    errorCode = json['error_code'];
    errorMessage = json['error_message'];
    elapsed = json['elapsed'];
    creditCount = json['credit_count'];
    notice = json['notice'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['error_code'] = this.errorCode;
    data['error_message'] = this.errorMessage;
    data['elapsed'] = this.elapsed;
    data['credit_count'] = this.creditCount;
    data['notice'] = this.notice;
    data['total_count'] = this.totalCount;
    return data;
  }
}

class CoinData {
  int? id;
  String? name;
  String? symbol;
  String? slug;
  int? numMarketPairs;
  String? dateAdded;
  List<String>? tags;
  int? maxSupply;
  double? circulatingSupply;
  double? totalSupply;
  Platform? platform;
  int? cmcRank;
  String? lastUpdated;
  Quote? quote;

  CoinData(
      {this.id,
        this.name,
        this.symbol,
        this.slug,
        this.numMarketPairs,
        this.dateAdded,
        this.tags,
        this.maxSupply,
        this.circulatingSupply,
        this.totalSupply,
        this.platform,
        this.cmcRank,
        this.lastUpdated,
        this.quote});

  CoinData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
    numMarketPairs = json['num_market_pairs'];
    dateAdded = json['date_added'];
    tags = json['tags'].cast<String>();
    maxSupply = json['max_supply'];
    circulatingSupply = double.parse(json['circulating_supply'].toString()!="null"?json['circulating_supply'].toString():"0.0");
    totalSupply = double.parse(json['total_supply'].toString()!="null"?json['total_supply'].toString():"0.0");
    platform = json['platform'] != null
        ? new Platform.fromJson(json['platform'])
        : null;
    cmcRank = json['cmc_rank'];
    lastUpdated = json['last_updated'];
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['slug'] = this.slug;
    data['num_market_pairs'] = this.numMarketPairs;
    data['date_added'] = this.dateAdded;
    data['tags'] = this.tags;
    data['max_supply'] = this.maxSupply;
    data['circulating_supply'] = this.circulatingSupply;
    data['total_supply'] = this.totalSupply;
    if (this.platform != null) {
      data['platform'] = this.platform!.toJson();
    }
    data['cmc_rank'] = this.cmcRank;
    data['last_updated'] = this.lastUpdated;
    if (this.quote != null) {
      data['quote'] = this.quote!.toJson();
    }
    return data;
  }
}

class Platform {
  int? id;
  String? name;
  String? symbol;
  String? slug;
  String? tokenAddress;

  Platform({this.id, this.name, this.symbol, this.slug, this.tokenAddress});

  Platform.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
    tokenAddress = json['token_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['slug'] = this.slug;
    data['token_address'] = this.tokenAddress;
    return data;
  }
}

class Quote {
  USD? uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? USD.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uSD != null) {
      data['USD'] = uSD!.toJson();
    }
    return data;
  }
}

class USD {
  double? price;
  double? volume24h;
  double? volumeChange24h;
  double? percentChange1h;
  double? percentChange24h;
  double? percentChange7d;
  double? percentChange30d;
  double? percentChange60d;
  double? percentChange90d;
  double? marketCap;
  double? marketCapDominance;
  double? fullyDilutedMarketCap;
  String? lastUpdated;

  USD(
      {this.price,
        this.volume24h,
        this.volumeChange24h,
        this.percentChange1h,
        this.percentChange24h,
        this.percentChange7d,
        this.percentChange30d,
        this.percentChange60d,
        this.percentChange90d,
        this.marketCap,
        this.marketCapDominance,
        this.fullyDilutedMarketCap,
        this.lastUpdated});

  USD.fromJson(Map<String, dynamic> json) {
    price = double.parse(json['price'].toString()!="null"?json['price'].toString():"0.0");
    volume24h = double.parse(json['volume_24h'].toString()!="null"?json['volume_24h'].toString():"0.0");
    volumeChange24h = double.parse(json['volume_change_24h'].toString()!="null"?json['volume_change_24h'].toString():"0.0");
    percentChange1h = double.parse(json['percent_change_1h'].toString()!="null"?json['percent_change_1h'].toString():"0.0");
    percentChange24h = double.parse(json['percent_change_24h'].toString()!="null"?json['percent_change_24h'].toString():"0.0");
    percentChange7d = double.parse(json['percent_change_7d'].toString()!="null"?json['percent_change_7d'].toString():"0.0");
    percentChange30d = double.parse(json['percent_change_30d'].toString()!="null"?json['percent_change_30d'].toString():"0.0");
    percentChange60d = double.parse(json['percent_change_60d'].toString()!="null"?json['percent_change_60d'].toString():"0.0");
    percentChange90d = double.parse(json['percent_change_90d'].toString()!="null"?json['percent_change_90d'].toString():"0.0");
    marketCap = double.parse(json['volume_change_24h'].toString()!="null"?json['volume_change_24h'].toString():"0.0");
    marketCapDominance = double.parse(json['market_cap_dominance'].toString()!="null"?json['market_cap_dominance'].toString():"0.0");
    fullyDilutedMarketCap = double.parse(json['fully_diluted_market_cap'].toString()!="null"?json['fully_diluted_market_cap'].toString():"0.0");
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['volume_24h'] = this.volume24h;
    data['volume_change_24h'] = this.volumeChange24h;
    data['percent_change_1h'] = this.percentChange1h;
    data['percent_change_24h'] = this.percentChange24h;
    data['percent_change_7d'] = this.percentChange7d;
    data['percent_change_30d'] = this.percentChange30d;
    data['percent_change_60d'] = this.percentChange60d;
    data['percent_change_90d'] = this.percentChange90d;
    data['market_cap'] = this.marketCap;
    data['market_cap_dominance'] = this.marketCapDominance;
    data['fully_diluted_market_cap'] = this.fullyDilutedMarketCap;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}
