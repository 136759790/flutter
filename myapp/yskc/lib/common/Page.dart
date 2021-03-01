class PageInfo {
  List data;
  int pageNum;
  int pageSize;
  int pages;
  int total;
  bool hasNextPage;
  bool hasPreviousPage;

  PageInfo();

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo()
      ..data = json['list'] as List
      ..pageNum = json['pageNum'] as int
      ..pageSize = json['pageSize'] as int
      ..pages = json['pages'] as int
      ..total = json['total'] as int;
  }
  Map<String, dynamic> toJson() => _$PageToJson(this);
  Map<String, dynamic> _$PageToJson(PageInfo instance) => <String, dynamic>{
        'data': instance.data,
        'pageNum': instance.pageNum,
        'pageSize': instance.pageSize,
        'pages': instance.pages,
        'hasNextPage': instance.hasNextPage,
        'hasPreviousPage': instance.hasPreviousPage,
        'total': instance.total,
      };
}
