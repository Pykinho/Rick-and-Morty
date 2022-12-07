import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_development_assignment/characters_page.dart';
import 'package:flutter_development_assignment/queries.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty episodes'),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(fetchEpisodes),
            variables: {
              'nPage': null,
            },
          ),
          builder: (QueryResult result, {refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading && result.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final List<dynamic> episodesList =
                (result.data?['episodes']['results'] as List<dynamic>);

            final Map pageInfo = result.data?['episodes']['info'];
            int? nextPageNo = pageInfo['next'];

            FetchMoreOptions opts = FetchMoreOptions(
              variables: {'nPage': nextPageNo},
              updateQuery: (previousResultData, fetchMoreResultData) {
                final List<dynamic> episodes = [
                  ...previousResultData?['episodes']['results']
                      as List<dynamic>,
                  ...fetchMoreResultData?['episodes']['results']
                      as List<dynamic>
                ];

                fetchMoreResultData?['episodes']['results'] = episodes;

                return fetchMoreResultData;
              },
            );

            return Column(
              children: [
                Expanded(
                  child: NotificationListener(
                    onNotification: (t) {
                      if (t is ScrollEndNotification &&
                          _scrollController.position.pixels >=
                              _scrollController.position.maxScrollExtent &&
                          nextPageNo != null) {
                        fetchMore!(opts);
                      }
                      return true;
                    },
                    child: ListView(
                      controller: _scrollController,
                      key: const PageStorageKey<String>('uniqueString'),
                      children: <Widget>[
                        for (var episode in episodesList)
                          Card(
                            child: ListTile(
                              title: Text(
                                episode['name'],
                              ),
                              subtitle: Text(episode['episode']),
                              trailing: Text(episode['air_date']),
                              onTap: () {
                                final List<dynamic> charactersList = [
                                  for (var character in episode['characters'])
                                    character['id']
                                ];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CharactersPage(
                                      episode: episode['episode'],
                                      characters: charactersList,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        if (result.isLoading)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              CircularProgressIndicator(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
