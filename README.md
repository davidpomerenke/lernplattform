# Deutschland Lernt Selbst. <img align="right" src="hackathon.png">
Übersicht über Selbstlern-Angebote für die Lehrpläne aller Bundesländer.

## Hackathon-Info
- `TITEL`: Self-Learning Angebote für Schüler*innen
- `PROBLEME`: Errichtung einer Plattform für kuratierte Self-Learning Angebote für Schüler*innen
- `BETROFFENENGRUPPE`: Schüler*innen und Lehrer*innen in Zeiten des Corona-Virus und darüber hinaus
- `FORMULIERUNG HERAUSFORDERUNG`: Wie können wir den Schüler*innen in Deutschland ein ausgewähltes Angebot mit elektronischen Lehrinhalten zur Verfügung stellen, um sie auch bei Schulschließungen von zu Hause aus weiterlernen zu lassen?
- `LÖSUNGSANSATZ`: Schulcloud.org; kiron.org; Anton App, virtuelles Klassenzimmer (ZDF), planet-schule (SWR/WDR)
- `ID`: 1952

## Mitmachen
- [Projekt-Kanban auf Github](https://github.com/davidpomerenke/deutschland-lernt-selbst/projects/2)
- Diskussionen am besten über Issues in Github, einen eigenen Slack-Channel gibt es bisher nicht.

## Die Idee
Ziel ist es, für Schüler und Lehrer deutschlandweit eine Plattform bereitzustellen, auf der sie Links zu Selbstlern-Materialien miteinander austauschen können, die im Netz frei verfügbar sind:
- Jede Person soll für ihr Bundesland, ihr Fach, und ihre Klassenstufe die passenden Materialien angezeigt bekommen. 
- Jede Person soll auch selbst Materialien hinzufügen können, sowie bestehende Materialien bewerten können. Wichtig ist, dass die Materialien und Bewertungen immer für alle Bundesländer verfügbar gemacht werden. Das heißt, eine Mathelehrerin aus Berlin trägt z. B. eine interaktive Website zum Binomialgleichungen ein, die in Berlin in der siebten Klasse behandelt werden (fiktives Beispiel!). In Bayern werden diese aber schon in der sechsten Klasse behandelt. Dann wird die Website sowohl Siebtklässlern in Berlin, als auch Sechstklässlern in Bayern angezeigt, mit denselben Bewertungen.

Das Projekt strebt an, eine Datenbank zu erstellen, die aus zwei Teilen besteht:
1. Eine Zuordnung `Bundesland + Fach + Klassenstufe` → `Liste von Modulen`. Diese Zuordnung soll einmal aus den Lehrplänen extrahiert werden und dann gegebenenfalls jährlich aktualisiert werden.
2. Eine Zuordnung `Modul` → `Liste mit Selbstlern-Ressourcen`. Diese Daten sollen im Wesentlichen von der Community aus Schülern und Lehrern selbst eingetragen und bewertet werden.

Die Datenbank soll über eine Website zugänglich sein. Die Website soll anfangs einmal Bundesland, Klassenstufe, Kern- und Nebenfächer abfragen und lokal speichern. Daraufhin werden die verfügbaren Ressourcen pro Fach und nach Bewertungen sortiert angezeigt. Es soll auf der Website unkompliziert möglich sein, neue Einträge hinzuzufügen und bestehende Einträge zu bewerten.

## Struktur

## Technologie

## Verwandte Projekte
- _awesome-lists_ (Github): 
  - `+` Sind kollaborativ. 
  - `-` Sind auf Englisch und nicht auf Schüler zugeschnitten. Es gibt es keine Bewertungen. Der Github-Workflow ist zu kompliziert für die meisten Lehrer und Schüler.
  - `→` Insbesondere für die Oberstufe wird es Sinn machen, diese zunächst als ganze Listen zu verlinken, später dann zu den einzelnen Modulen aufzuschlüsseln und die einzelnen Links zu übernehmen.
- Landesbildungsserver: 
  - `+` Sind auf deutsch, auf die Lehrpläne zugeschnitten und von Lehrern kuratiert, daher sehr qualitativ. 
  - `-` Sind nicht bundesweit vereinheitlicht und nicht direkt kollaborativ (meistens verwalten einige wenige Lehrer den Inhalt), auch gibt es keine Bewertungsmöglichkeit. Auf den Servern gibt es teilweise schon Listen mit Links zum Selbstlernen. Langfristig wäre es sinnvoll, wenn es ein HTML-Snippet gäbe, mit dem auf einfache Weise auf den Landesbildungsservern modulweise die bundesweiten Listen von diesem Projekt angezeigt werden könnten.
