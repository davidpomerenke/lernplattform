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

Tile <|-- TileGo
Tile <|-- TileStreet
Tile <|-- TileDraw
Tile <|-- TileFreeParking
Tile <|-- TilePrison

Game --* Player
Game --* Card
Game --* Tile

Tile --> Player
TileStreet --o Player
TileDraw --> Card

class Game {
  +Tile[] board
  +Card[] pile1
  +Card[] pile2
  +Player[] players
  +int timeSinceLastStep
  +start() void
  +update() void
  +end() void
}

class Player {
  +int id
  +move(Tile[] board, repetition=0) void
  -int position
  -int balance
  -int prisonDuration
  +getPosition() int
  +setPosition(int position) void
  +getAnimatedPosition() void
  +setAnimatedPosition(int animatedPosition) void
  +getXZ(int position, Tile[] board) double[]
  +crossGo() void
  +isActive() bool
}

class Tile {
  <<abstract>>
  +int id
  +Player owner
  +landingAction(Player current, Player next) abstract void
}

class TileGo {
  +landingAction()
}

class TileStreet {
  +int price
  +Player owner
  +int nHouses
  +bool mortgaged
  +landingAction()
  +buy() void
  +upgrade() void
  +mortgage() void
}

class TileDraw {
  +landingAction()
}

class TileFreeParking {
  +landingAction()
}

class TilePrison {
  +landingAction()
}

class Card {
  +draw() void
}
```

## Beispiel-Daten

## Ablauf-Diagramm

