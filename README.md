<div align="center"><img src="bilder/logo-mittel.png"></div>

# Lernplattform für Deutschland

[![Discord](https://img.shields.io/discord/696395974343655484?color=%23738ADB&label=discord)](https://discord.gg/EUUyrK4)

## Die Idee

Ziel ist es, für Schüler\*innen und Lehrer\*innen deutschlandweit eine Plattform bereitzustellen, auf der sie Links zu Selbstlern-Materialien miteinander austauschen können, die im Netz frei verfügbar sind:

- Jede Person soll für ihr Bundesland, ihr Fach, und ihre Klassenstufe(n) die passenden Materialien angezeigt bekommen.
- Jede Person soll auch selbst Materialien hinzufügen können, sowie bestehende Materialien bewerten können. Wichtig ist, dass die Materialien und Bewertungen immer für alle Bundesländer verfügbar gemacht werden. 
  - __Fiktives Beispiel:__ Eine Mathelehrerin aus Berlin trägt z. B. eine interaktive Website zum Binomialgleichungen ein, die in Berlin in der siebten Klasse behandelt werden. In Bayern werden diese aber schon in der sechsten Klasse behandelt. Dann wird die Website sowohl Siebtklässlern in Berlin, als auch Sechstklässlern in Bayern angezeigt, mit denselben Bewertungen.
- Es sollen alle Fächer und alle Schularten unterstützt werden (inklusive Grundschule).

Das Projekt strebt an, eine Datenbank zu erstellen, die im Wesentlichen aus zwei Teilen besteht:

1. Eine Zuordnung `Bundesland + Fach + Klassenstufe` → `Liste von Modulen`. Diese Zuordnung soll einmal automatisch aus den veröffentlichten Lehrplänen extrahiert werden und dann gegebenenfalls jährlich aktualisiert werden.
2. Eine Zuordnung `Modul` → `Liste mit Selbstlern-Materialien`. Diese Daten sollen hauptsächlich von der Community aus Schülern und Lehrern selbst eingetragen und bewertet werden.

Die Datenbank ist über eine Website zugänglich. Die Website fragt anfangs einmal Bundesland, Klassenstufe, Kern- und Nebenfächer ab und speichert diese lokal. Daraufhin werden die verfügbaren Materialien pro Fach und nach Bewertungen sortiert angezeigt. Es soll auf der Website unkompliziert möglich sein, neue Einträge hinzuzufügen und bestehende Einträge zu bewerten.

[Überblick über verwandte Projekte.](https://github.com/davidpomerenke/lernplattform/wiki/Verwandte-Projekte)

## Dokumentation

Informationen zur Entwicklung und zur Benutzung der öffentlichen Schnittstelle siehe [Siehe Wiki](https://github.com/davidpomerenke/lernplattform/wiki).
