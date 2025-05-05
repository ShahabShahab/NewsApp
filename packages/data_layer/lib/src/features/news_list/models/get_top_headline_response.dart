import 'package:data_layer/src/features/news_list/models/article_model.dart';
import 'package:json_annotation/json_annotation.dart';

/// status : "ok"
/// totalResults : 19363
/// articles : [{"source":{"id":"the-verge","name":"The Verge"},"author":"Tom Warren","title":"Microsoft turns 50","description":"Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software that helped it achieve an early goal of a PC on every desk and …","url":"https://www.theverge.com/news/643336/microsoft-50-years","urlToImage":"https://platform.theverge.com/wp-content/uploads/sites/2/2025/03/microsoftoldlogo.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200","publishedAt":"2025-04-04T13:21:07Z","content":"Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software tha… [+2822 chars]"},null]

part 'get_top_headline_response.g.dart';

@JsonSerializable()
class GetTopHeadlineResponse {
  GetTopHeadlineResponse({
      this.status, 
      this.totalResults, 
      this.articles,});

  String? status;
  int? totalResults;
  List<ArticleModel>? articles;

  factory GetTopHeadlineResponse.fromJson(Map<String, dynamic> json) =>
          _$GetTopHeadlineResponseFromJson(json);

      Map<String, dynamic> toJson() => _$GetTopHeadlineResponseToJson(this);

}

/// source : {"id":"the-verge","name":"The Verge"}
/// author : "Tom Warren"
/// title : "Microsoft turns 50"
/// description : "Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software that helped it achieve an early goal of a PC on every desk and …"
/// url : "https://www.theverge.com/news/643336/microsoft-50-years"
/// urlToImage : "https://platform.theverge.com/wp-content/uploads/sites/2/2025/03/microsoftoldlogo.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200"
/// publishedAt : "2025-04-04T13:21:07Z"
/// content : "Microsoft was originally founded on April 4th, 1975 and the tech giant is now celebrating its 50-year anniversary. Microsoft started with a focus on personal computers, building the very software tha… [+2822 chars]"
