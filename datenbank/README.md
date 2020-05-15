# Datenbank

## Aufbau der Datenbank

![Aufbau der Datenbank](../bilder/er-diagramm-dbeaver.png)
Das Diagramm ist ein mit [DBeaver](https://dbeaver.io/) erstelltes Entity-Relationship-Diagramm. Siehe [datenbank/schema.sql](datenbank/schema.sql).

## GraphQL-Schnittstelle

Die Datenbank steht Dritten per öffentlicher GraphQL-Schnittstelle unter `https://lernplattform-graphql.herokuapp.com/v1/graphql` zur Verfügung.

Für Details, wie das Abfragen der Schnittstelle funktioniert, siehe die [Dokumentation](https://hasura.io/docs/1.0/graphql/manual/queries/simple-object-queries.html) von Hasura, welches die Schnittstelle bereitstellt. Um genestete Anfragen zu schreiben, muss der Aufbau der Datenbank beachtet werden.

### Anwendungsbeispiel

Ein einfaches Anwendungsbeispiel einer Javascript-Abfrage von einer Website aus findet sich in [beispielabfrage.html](beispielabfrage.html).

## PostgREST-Schnittstelle

Es wäre sinnvoll, auch eine PostgREST-Schnittstelle zur Verfügung zu stellen. Diese bedingt aber ein Upgrade bei Heroku von Hobby Dev auf Basic, so dass ein Benutzer mit ausschließlichen Leserechten angelegt werden kann.
