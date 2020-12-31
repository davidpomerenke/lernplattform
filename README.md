[wir lernen online](https://wirlernenonline.de/)  (supported by Wikimedia) now does everything the `lernplattform` project ever aimed to, so check them out! 🎈

<div align="center"><img src="bilder/logo-mittel.png"></div>

<h1 align="center">Lernplattform für Deutschland</h1>

<div align="center"><a href="finanzen.md">Spenden und Sponsoring</a> — <a href="https://discord.gg/EUUyrK4">Mitmachen im Discord Server</a></div>

<h2 align="center">Die Idee</h2>

Ziel ist es, für Schüler\*innen und Lehrer\*innen deutschlandweit eine Plattform bereitzustellen, auf der sie Links zu Selbstlern-Materialien miteinander austauschen können, die im Netz frei verfügbar sind:

- Jede Person soll für ihr Bundesland, ihr Fach, und ihre Klassenstufe(n) die passenden Materialien angezeigt bekommen.
- Jede Person soll auch selbst Materialien hinzufügen können, sowie bestehende Materialien bewerten können. Wichtig ist, dass die Materialien und Bewertungen immer für alle Bundesländer verfügbar gemacht werden. 
  - __Fiktives Beispiel:__ Eine Mathelehrerin aus Berlin trägt z. B. eine interaktive Website zum Binomialgleichungen ein, die in Berlin in der siebten Klasse behandelt werden. In Bayern werden diese aber schon in der sechsten Klasse behandelt. Dann wird die Website sowohl Siebtklässlern in Berlin, als auch Sechstklässlern in Bayern angezeigt, mit denselben Bewertungen.
- Es sollen alle Fächer und alle Schularten unterstützt werden (inklusive Grundschule).

Das Projekt strebt an, eine Datenbank zu erstellen, die im Wesentlichen aus zwei Teilen besteht:

1. Eine Zuordnung `Bundesland + Fach + Klassenstufe` → `Liste von Modulen`. Diese Zuordnung soll einmal automatisch aus den veröffentlichten Lehrplänen extrahiert werden und dann gegebenenfalls jährlich aktualisiert werden.
2. Eine Zuordnung `Modul` → `Liste mit Selbstlern-Materialien`. Diese Daten sollen hauptsächlich von der Community aus Schülern und Lehrern selbst eingetragen und bewertet werden.

Die Datenbank ist über eine Website zugänglich. Die Website fragt anfangs einmal Bundesland, Klassenstufe, Kern- und Nebenfächer ab und speichert diese lokal. Daraufhin werden die verfügbaren Materialien pro Fach und nach Bewertungen sortiert angezeigt. Es soll auf der Website unkompliziert möglich sein, neue Einträge hinzuzufügen und bestehende Einträge zu bewerten.

[Überblick über verwandte Projekte.](verwandte-projekte.md)

<h2 align="center">Technologie</h2>

Die Daten werden in einer [PostgreSQL](https://www.postgresql.org/docs/12/index.html)-Datenbank [bei Heroku](https://dashboard.heroku.com/apps/lernplattform-api) gespeichert. Die Website (Ordner `public`) und die API zum Zugriff auf die Datenbank (Ordner `api`) werden [bei Zeit Now](https://zeit.co/davidpomerenke/lernplattform) gehostet.

<h3 align="center">Lokale Entwicklung</h3>

- `now dev` startet einen lokalen Server für Website und API.
- Um mit der Postgres-Datenbank zu verbinden, müssen das Passwort in der Form `PGPASSWORD=xyz` in der Datei `.env` im Hauptordner hinterlegt werden, sowie gegebenenfalls die Daten in `now.json` angepasst werden. Das Passwort für die Heroku-Datenbank kann ich bei Interesse mitteilen, zumindest solange das Projekt noch in der Entwicklung ist, und danach wird es eine andere Lösung geben. In der Datenbank ist (bisher) nur ein Benutzer angelegt.
  - `yarn pg` verbindet dann mit der Datenbank zur Eingabe von SQL-Abfragen.
  - `yarn pg:dump` lädt verschiedene Kopien der Datenbank im SQL-Format herunter und speichert im Ordner `datenbank` das Schema, sowie im Ordner `datenbank/backups` vollständige Backups (gitignored).

<h3 align="center">Datenbank</h3>

![Entity-Relationship Diagramm.](bilder/er-diagramm-dbeaver.png)

Das Diagramm ist ein mit [DBeaver](https://dbeaver.io/) erstelltes Entity-Relationship-Diagramm. Siehe [datenbank/schema.sql](datenbank/schema.sql).

<h2 align="center">Mitmachen</h2>

- [__Discord-Server__](https://discord.gg/EUUyrK4)
- [Projekt-Kanban](https://github.com/davidpomerenke/deutschland-lernt-selbst/projects/2)

<div align="center"><a href="https://wirvsvirushackathon.org"><img src="bilder/hackathon.png"></a></div>
