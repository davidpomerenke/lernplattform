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
	+Modulname
	+Link
	+Beschreibung
}

class SelbstlernRessourceDatenbank {
	+Modulname
	+Upvotes
	+Downvotes
}

Kurs --> SelbstlernRessourceGithub
Kurs --> SelbstlernRessourceDatenbank
```

## Beispiel-Daten

## Ablauf-Diagramm

```mermaid
sequenceDiagram
	Client->>Server: Seitenaufruf
	Server-->>Client: Liste der Bundesländer
	Client->>Server: Bundesland
	Server-->>Client: Liste der Klassenstufen
	Client->>Server: Klassenstufe
	Server-->>Client: Liste der Fächer
	Client->>Server: Auswahl der Kern- und Nebenfächer
	Server-->>Client: Liste der Selbstlern-Ressourcen pro Fach
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

