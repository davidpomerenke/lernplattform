<div align="center"><img src="bilder/logo-mittel.png"></div>
<h1 align="center">Deutschland lernt selbst.</h1>

<h2 align="center">Die Idee</h2>

Ziel ist es, für Schüler\*innen und Lehrer\*innen deutschlandweit eine Plattform bereitzustellen, auf der sie Links zu Selbstlern-Ressourcen miteinander austauschen können, die im Netz frei verfügbar sind:
- Jede Person soll für ihr Bundesland, ihr Fach, und ihre Klassenstufe die passenden Materialien angezeigt bekommen. 
- Jede Person soll auch selbst Materialien hinzufügen können, sowie bestehende Materialien bewerten können. Wichtig ist, dass die Materialien und Bewertungen immer für alle Bundesländer verfügbar gemacht werden. Das heißt, eine Mathelehrerin aus Berlin trägt z. B. eine interaktive Website zum Binomialgleichungen ein, die in Berlin in der siebten Klasse behandelt werden. In Bayern werden diese aber schon in der sechsten Klasse behandelt. Dann wird die Website sowohl Siebtklässlern in Berlin, als auch Sechstklässlern in Bayern angezeigt, mit denselben Bewertungen. (Fiktives Beispiel!)
- Es sollen alle Fächer und alle Schularten unterstützt werden (inklusive Grundschule). Für den Prototyp werden erst einmal die Lehrpläne für Deutsch und Physik in den gymnasialen Oberstufen in Baden-Württemberg, Bayern und Berlin erstellt.

Das Projekt strebt an, eine Datenbank zu erstellen, die aus zwei Teilen besteht:
1. Eine Zuordnung `Bundesland + Fach + Klassenstufe` → `Liste von Modulen`. Diese Zuordnung soll (je nach verfügbarem Format manuell bzw. automatisiert) einmal aus den Lehrplänen extrahiert werden und dann gegebenenfalls jährlich aktualisiert werden.
2. Eine Zuordnung `Modul` → `Liste mit Selbstlern-Ressourcen`. Diese Daten sollen im Wesentlichen von der Community aus Schülern und Lehrern selbst eingetragen und bewertet werden.

Die Datenbank soll über eine Website zugänglich sein. Die Website soll anfangs einmal Bundesland, Klassenstufe, Kern- und Nebenfächer abfragen und lokal speichern. Daraufhin werden die verfügbaren Ressourcen pro Fach und nach Bewertungen sortiert angezeigt. Es soll auf der Website unkompliziert möglich sein, neue Einträge hinzuzufügen und bestehende Einträge zu bewerten.

[Überblick über verwandte Projekte.](verwandte-projekte.md)

<h2 align="center">Technologie</h2>

Die Daten werden in einer [PostgreSQL](https://www.postgresql.org/docs/12/index.html)-Datenbank [bei Heroku](https://dashboard.heroku.com/apps/lernplattform-api) gespeichert. Die Website (Ordner `public`) und die API zum Zugriff auf die Datenbank (Ordner `api`) werden [bei Zeit Now](https://zeit.co/davidpomerenke/lernplattform) gehostet, da es bei Heroku Probleme mit dem SSL-Zertifikat gibt.

<h3 align="center">Lokale Entwicklung</h3>
- `now dev` startet einen lokalen Server für Website und API.
- Um mit der Postgres-Datenbank zu verbinden, müssen das Passwort in der Form `PGPASSWORD=xyz` in der Datei `.env` im Hauptordner hinterlegt werden, sowie gegebenenfalls die Daten in `now.json` angepasst werden. Das Passwort für die Heroku-Datenbank kann ich bei Interesse mitteilen, zumindest solange das Projekt noch in der Entwicklung ist. In der Datenbank ist nur ein Benutzer angelegt.
  - `yarn pg` verbindet dann mit der Datenbank zur Eingabe von SQL-Abfragen.
  - `yarn pg:dump` lädt dann eine Kopie der Datenbank im SQL-Format herunter.

<h3 align="center">Datenbank</h3>

![Entity-Relationship Diagramm in Chen-Notation.](bilder/er-diagramm.png)

Das Diagramm ist ein Entity-Relationship-Diagramm in [Chen-Notation](https://www.vertabelo.com/blog/chen-erd-notation/), wobei die Schlüssel nicht dargestellt sind. Für den Aufbau der Tabellen siehe [datenbank/aufsetzen.sql](datenbank/aufsetzen.sql).

<h2 align="center">Mitmachen</h2>

- [Discord-Server](https://discord.gg/EUUyrK4)
- [Projekt-Kanban](https://github.com/davidpomerenke/deutschland-lernt-selbst/projects/2)

<div align="center"><a href="https://wirvsvirushackathon.org"><img src="bilder/hackathon.png"></a></div>