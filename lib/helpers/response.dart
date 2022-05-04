
class Response{
  final String status;
  final int totalResults;
  final List articles;

  const Response({
    required this.status,
    required this.totalResults,
    required this.articles
  });

  factory Response.fromJson(Map<String,dynamic> json){  
    return Response(
      status: json['status'], 
      totalResults: json['totalResults'],
       articles: json['articles']);
  }

}