 # Diagramme

[Mermaid](https://mermaid-js.github.io/mermaid/#/classDiagram) is used for rendering. It is supported natively by some markdown editors such as [Typora](https://typora.io/), otherwise it is easiest to copypaste the code from and to the [Mermaid web editor](https://mermaid-js.github.io/mermaid-live-editor).

## Entity-Relationship Diagramm

```mermaid
graph LR
	lernt{lernt}
	hat{hat Materialien}
	
	Bundesland ---|n| lernt
	Fach ---|n| lernt
	Klassenstufe ---|n| lernt
	lernt ---|n| Modul
	Modul ---|n| hat
	hat ---|n| Selbstlern-Ressource
	Selbstlern-Ressource --- Link
	Selbstlern-Ressource --- Beschreibung
	Selbstlern-Ressource --- Typ
	Selbstlern-Ressource --- Upvotes
	Selbstlern-Ressource --- Downvotes
```

## Klassen-Diagramm

```mermaid
classDiagram

class Kurs {
	+Bundesland
	+Fach
	+Klassenstufe
	+Liste von Modulnamen
}

class SelbstlernRessourceGithub {
	+Link
	+Beschreibung
	+Liste von Modulnamen
}

class SelbstlernRessourceDatenbank {
	+Link
	+Upvotes
	+Downvotes
}

Kurs --> SelbstlernRessourceGithub
SelbstlernRessourceGithub --> SelbstlernRessourceDatenbank
```

## Beispiel-Daten

## Ablauf-Diagramm

```mermaid
sequenceDiagram
	User->>Website: Seitenaufruf
	Website-->>User: Liste der Bundesländer
	User->>Website: Bundesland
	Website-->>User: Liste der Klassenstufen
	User->>Website: Klassenstufe
	Website-->>User: Liste der Fächer
	User->>Website: Auswahl der Kern- und Nebenfächer
	Website-->>User: Liste der Selbstlern-Ressourcen pro Fach
```

```mermaid
sequenceDiagram
	User->>Website: Suchbegriff
	Website-->>User: Ergebnisse
```

```mermaid
sequenceDiagram
	Client->>Server: Seitenaufruf
	Server-->>Client: Tabelle mit Bundesländern, Klassenstufen, Fächern
	Client->>Server: Bundesland, Klassenstufe, Fächer
	Server-->>Client: Liste der Selbstlern-Ressourcen pro Fach
```

```mermaid
sequenceDiagram
	Client->>Server: Seitenaufruf
	Server-->>Client: Tabelle mit Bundesländern, Klassenstufen, Fächern, Modulen + Tabelle mit Selbstlern-Ressourcen pro Modul
```