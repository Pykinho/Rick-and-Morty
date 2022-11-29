import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_development_assignment/GQLClient.dart';
import 'package:flutter_development_assignment/Queries.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  final Queries _query = Queries();
  List episodesList = [];

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future fetchProfile() async {
    GraphQLClient _client = _graphQLConfiguration.myGQLClient();

    QueryResult result = await _client
        .query(QueryOptions(document: gql(_query.fetchEpisodes())));
    if (result.hasException) {
      print(result.exception);
    } else if (!result.hasException) {
      print(result.data);
      setState(() {
        episodesList = result.data?['episodes']['results'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Episodes',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: episodesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      // leading: Image(
                      //   image: NetworkImage(
                      //     EpisodesList[index]['image'],
                      //   ),
                      // ),
                      title: Text(
                        episodesList[index]['name'],
                      ),
                      subtitle: Text(episodesList[index]['episode']),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
