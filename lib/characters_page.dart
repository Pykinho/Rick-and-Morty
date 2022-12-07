import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_development_assignment/queries.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage(
      {super.key, required this.episode, required this.characters});
  final String episode;
  final List characters;

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Characters in ${widget.episode}'),
        ),
        body: Query(
            options: QueryOptions(
              document: gql(fetchCharacters),
              variables: {
                'characterIds': widget.characters,
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

              final List<dynamic> charactersList =
                  (result.data?['charactersByIds'] as List<dynamic>);

              return GridView.count(
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                crossAxisCount: 2,
                children: <Widget>[
                  //return Container(
                  for (var character in charactersList)
                    Card(
                      child: GridTile(
                        header: character['status'] == 'Dead'
                            ? Image.asset(
                                'assets/images/skull.png',
                                scale: 4.0,
                                alignment: Alignment.topRight,
                              )
                            : const Text(''),

                        footer: Text(
                          character['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(-1.5, -1.5),
                                ),
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(1.5, -1.5),
                                ),
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(-1.5, 1.5),
                                ),
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(1.5, 1.5),
                                ),
                              ]),
                          textAlign: TextAlign.center,
                        ),
                        child: Image.network(
                          character['image'],
                          fit: BoxFit.fill,
                        ),
                        // leading: Image.network(character['image']),
                        // title: Text(
                        //   character['name'],
                        // ),
                        // subtitle: Text(character['species']),
                        // trailing: Text(character['status']),
                      ),
                    ),
                ],
              );
            }));
  }
}
