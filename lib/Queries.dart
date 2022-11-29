class Queries {
  String fetchEpisodes() {
    return '''
      query episodes{
        episodes{
          info{
            count
            pages
            next
          }
          results{
            name
            episode
            id
            characters {
              id
            }
          }
        }
      }
      ''';
  }

  String fetchCharacters(List ids) {
    return '''
      query characters{
        charactersByIds(ids:$ids) 
            {
              name
              status
              image
              species
              origin{
                name
              }
            }
        }
    ''';
  }
}
