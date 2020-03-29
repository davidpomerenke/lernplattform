# Deutschland Lernt Selbst. <a href="https://wirvsvirushackathon.org"><img align="right" src="hackathon.png"></a>
Übersicht über Selbstlern-Angebote für die Lehrpläne aller Bundesländer.

## Hackathon-Info
- `Kategorie`: Nichtkommerzielle Neuentwicklung
- `TITEL`: Self-Learning Angebote für Schüler\*innen
- `PROBLEME`: Errichtung einer Plattform für kuratierte Self-Learning Angebote für Schüler\*innen
- `BETROFFENENGRUPPE`: Schüler\*innen und Lehrer\*innen in Zeiten des Corona-Virus und darüber hinaus
- `FORMULIERUNG HERAUSFORDERUNG`: Wie können wir den Schüler\*innen in Deutschland ein ausgewähltes Angebot mit elektronischen Lehrinhalten zur Verfügung stellen, um sie auch bei Schulschließungen von zu Hause aus weiterlernen zu lassen?
- `LÖSUNGSANSATZ`: Schulcloud.org; kiron.org; Anton App, virtuelles Klassenzimmer (ZDF), planet-schule (SWR/WDR)
- `ID`: 1952

## Mitmachen
- [Projekt-Kanban](https://github.com/davidpomerenke/deutschland-lernt-selbst/projects/2)
- Diskussionen am besten über Issues in Github, einen eigenen Slack-Channel gibt es bisher nicht, da ich das Projekt bisher alleine angehe. Wir können aber gerne einen aufmachen.

## Die Idee
Ziel ist es, für Schüler und Lehrer deutschlandweit eine Plattform bereitzustellen, auf der sie Links zu Selbstlern-Materialien miteinander austauschen können, die im Netz frei verfügbar sind:
- Jede Person soll für ihr Bundesland, ihr Fach, und ihre Klassenstufe die passenden Materialien angezeigt bekommen. 
- Jede Person soll auch selbst Materialien hinzufügen können, sowie bestehende Materialien bewerten können. Wichtig ist, dass die Materialien und Bewertungen immer für alle Bundesländer verfügbar gemacht werden. Das heißt, eine Mathelehrerin aus Berlin trägt z. B. eine interaktive Website zum Binomialgleichungen ein, die in Berlin in der siebten Klasse behandelt werden (fiktives Beispiel!). In Bayern werden diese aber schon in der sechsten Klasse behandelt. Dann wird die Website sowohl Siebtklässlern in Berlin, als auch Sechstklässlern in Bayern angezeigt, mit denselben Bewertungen.
- Es sollen alle Fächer und alle Schularten unterstützt werden (inklusive Grundschule), als Prototyp wird aber erst einmal nur Physik der Jahrgangsstufe 

Das Projekt strebt an, eine Datenbank zu erstellen, die aus zwei Teilen besteht:
1. Eine Zuordnung `Bundesland + Fach + Klassenstufe` → `Liste von Modulen`. Diese Zuordnung soll einmal aus den Lehrplänen extrahiert werden und dann gegebenenfalls jährlich aktualisiert werden.
2. Eine Zuordnung `Modul` → `Liste mit Selbstlern-Ressourcen`. Diese Daten sollen im Wesentlichen von der Community aus Schülern und Lehrern selbst eingetragen und bewertet werden.

Die Datenbank soll über eine Website zugänglich sein. Die Website soll anfangs einmal Bundesland, Klassenstufe, Kern- und Nebenfächer abfragen und lokal speichern. Daraufhin werden die verfügbaren Ressourcen pro Fach und nach Bewertungen sortiert angezeigt. Es soll auf der Website unkompliziert möglich sein, neue Einträge hinzuzufügen und bestehende Einträge zu bewerten.

### Gesellschaftlicher Mehrwert
- Open Source, komplett auf Github gehostet dank Github Pages und der Github API
- spricht alle LehrerInnen und SchülerInnen in Deutschland an

### Innovationsgrad
- Vergleich zu bestehenden Projekten siehe Abschnitt `Verwandte Projekte`

### Skalierbarkeit
- >2.5m Schüler, >750k Lehrer
- Netzwerkeffekte
- technisch leicht skalierbar dank statischem Hosting
- neue Inhalte sind effizient über das Github-System zu bewältigen

### Fortschritt
Geschafft:
- Beispiel-Lehrpläne für Physik in Gymnasien in Bayern, Baden-Württemberg und Berlin-Brandenburg in JSON
- Beispiel-Content in JSON
- Website-Prototyp mit Suchmaske und rudimentärem Anzeigen der Daten verdeutlicht das Prinzip
Noch ToDo:
- richtiges Auslesen und Anzeigen der Daten
- einfache Möglichkeit für User, Links auf der Website hinzuzufügen (Github API)
- mehr Lehrpläne in JSON übertragen

## Verwandte Projekte
- [Awesome Lists](https://github.com/topics/awesome-list) (Github): 
  - `+` Sind kollaborativ. 
  - `-` Sind auf Englisch und nicht auf Schüler zugeschnitten. Es gibt es keine Bewertungen. Der Github-Workflow ist zu kompliziert für die meisten Lehrer und Schüler.
  - `→` Insbesondere für die Oberstufe wird es Sinn machen, diese zunächst als ganze Listen zu verlinken, später dann zu den einzelnen Modulen aufzuschlüsseln und die einzelnen Links zu übernehmen.
- [Landesbildungsserver](https://www.bildungsserver.de/Die-Landesbildungsserver-450-de.html):
  - `+` Sind auf deutsch, auf die Lehrpläne zugeschnitten und von Lehrern kuratiert, daher sehr qualitativ. 
  - `-` Sind nicht bundesweit vereinheitlicht und nicht direkt kollaborativ (meistens verwalten einige wenige Lehrer den Inhalt), auch gibt es keine Bewertungsmöglichkeit. Auf den Servern gibt es teilweise schon Listen mit Links zum Selbstlernen. 
  - `→` Langfristig wäre es sinnvoll, wenn es ein HTML-Snippet gäbe, mit dem auf einfache Weise auf den Landesbildungsservern modulweise die bundesweiten Listen von diesem Projekt angezeigt werden könnten.
- [Deutscher Bildungsserver](https://www.bildungsserver.de/Sekundarbereich-Unterrichtsmaterial-702-de.html):
  - `+` Hat selbst eine Sammlung von eigenen Materialien, und gute Linklisten zu weiteren Seiten mit Materialien. Ist landesübergreifend und deutsch. Die Community ist insofern eingebunden, als sie defekte Links melden kann.
  - `-` Wer ein Thema sucht, muss sich (abgesehen von den eigenen Materialien des Bildungsservers) durch alle verlinkten Materialseiten durchklicken; es liegt keine Datenbank der eigentlichen Materialien vor. Ist nicht kollaborativ.
  - `→` Die Linklisten sind ein guter Ausgangspunkt, um die eigentlichen Materialien zur Datenbank dieses Projekts hinzuzufügen, wo sie dann durchsuchbar und bewertbar sind. Sinnvoll wäre ein Hinweis darauf auf der Website, so dass die Community dann langsam die Linklisten abarbeitet und die Materialien hinzufügt.
- [LEIFIphysik](https://www.leifiphysik.de/)
  - `+` Sehr schöne und qualitative Website, mit der Möglichkeit, nach Bundesland und Klassenstufe zu filtern. Auch mit Linklisten, sowie der Möglichkeit, eigene Links einzureichen. (Hätte ich das am Anfang gewusst, hätte ich nicht Physik als Beispiel für diesen Prototypen gewählt.)
  - `-` Fokus auf eigenen Inhalten. Nur für Physik.
  - `→` Langfristig wäre eine Kooperation dergestalt sinnvoll, dass auf einen gemeinsamen Pool von Links zugegriffen wird.
- [Übersicht der Lehrpläne](https://www.bildungsserver.de/Lehrplaene-400-de.html)

## Struktur

### Entity-Relationship-Diagramm
![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggTFJcblx0bGVybnR7bGVybnR9XG5cdGhhdHtoYXQgTWF0ZXJpYWxpZW59XG5cdFxuXHRCdW5kZXNsYW5kIC0tLXxufCBsZXJudFxuXHRGYWNoIC0tLXxufCBsZXJudFxuXHRLbGFzc2Vuc3R1ZmUgLS0tfG58IGxlcm50XG5cdGxlcm50IC0tLXxufCBNb2R1bFxuXHRNb2R1bCAtLS18bnwgaGF0XG5cdGhhdCAtLS18bnwgU2VsYnN0bGVybi1SZXNzb3VyY2Vcblx0U2VsYnN0bGVybi1SZXNzb3VyY2UgLS0tIExpbmtcblx0U2VsYnN0bGVybi1SZXNzb3VyY2UgLS0tIEJlc2NocmVpYnVuZ1xuXHRTZWxic3RsZXJuLVJlc3NvdXJjZSAtLS0gVXB2b3Rlc1xuXHRTZWxic3RsZXJuLVJlc3NvdXJjZSAtLS0gRG93bnZvdGVzIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)

Typen: Lerneinheit, Unterrichtseinheit, Experiment, vExperiment, Nachschlageseite, Wettbewerb, Sammlung, ... 

Einträge vom Typ `Sammlung` sollten langfristig ein einzelne Einträge überführt werden.


### Klassen-Diagramm
![](https://mermaid.ink/img/eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5cbmNsYXNzIEt1cnMge1xuXHQrQnVuZGVzbGFuZFxuXHQrRmFjaFxuXHQrS2xhc3NlbnN0dWZlXG5cdCtMaXN0ZSB2b24gTW9kdWxuYW1lblxufVxuXG5jbGFzcyBTZWxic3RsZXJuUmVzc291cmNlR2l0aHViIHtcblx0K0xpbmtcblx0K0Jlc2NocmVpYnVuZ1xuXHQrTGlzdGUgdm9uIE1vZHVsbmFtZW5cbn1cblxuY2xhc3MgU2VsYnN0bGVyblJlc3NvdXJjZURhdGVuYmFuayB7XG5cdCtMaW5rXG5cdCtVcHZvdGVzXG5cdCtEb3dudm90ZXNcbn1cblxuS3VycyAtLT4gU2VsYnN0bGVyblJlc3NvdXJjZUdpdGh1YlxuU2VsYnN0bGVyblJlc3NvdXJjZUdpdGh1YiAtLT4gU2VsYnN0bGVyblJlc3NvdXJjZURhdGVuYmFuayIsIm1lcm1haWQiOnsidGhlbWUiOiJkZWZhdWx0In0sInVwZGF0ZUVkaXRvciI6ZmFsc2V9)

### Ablauf-Diagramm

#### User-Interface
1. ![](https://mermaid.ink/img/eyJjb2RlIjoic2VxdWVuY2VEaWFncmFtXG5cdFVzZXItPj5XZWJzaXRlOiBTZWl0ZW5hdWZydWZcblx0V2Vic2l0ZS0tPj5Vc2VyOiBMaXN0ZSBkZXIgQnVuZGVzbMOkbmRlclxuXHRVc2VyLT4-V2Vic2l0ZTogQnVuZGVzbGFuZFxuXHRXZWJzaXRlLS0-PlVzZXI6IExpc3RlIGRlciBLbGFzc2Vuc3R1ZmVuXG5cdFVzZXItPj5XZWJzaXRlOiBLbGFzc2Vuc3R1ZmVcblx0V2Vic2l0ZS0tPj5Vc2VyOiBMaXN0ZSBkZXIgRsOkY2hlclxuXHRVc2VyLT4-V2Vic2l0ZTogQXVzd2FobCBkZXIgS2Vybi0gdW5kIE5lYmVuZsOkY2hlclxuXHRXZWJzaXRlLS0-PlVzZXI6IExpc3RlIGRlciBTZWxic3RsZXJuLVJlc3NvdXJjZW4gcHJvIEZhY2giLCJtZXJtYWlkIjp7InRoZW1lIjoiZGVmYXVsdCJ9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)
2. ![](https://mermaid.ink/img/eyJjb2RlIjoic2VxdWVuY2VEaWFncmFtXG5cdFVzZXItPj5XZWJzaXRlOiBTdWNoYmVncmlmZlxuXHRXZWJzaXRlLS0-PlVzZXI6IEVyZ2Vibmlzc2UiLCJtZXJtYWlkIjp7InRoZW1lIjoiZGVmYXVsdCJ9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)

#### Client-Server-Kommunikation
Zunächst wird ein Ansatz verfolgt, bei dem alle Daten auf einmal übertragen werden:

![](https://mermaid.ink/img/eyJjb2RlIjoic2VxdWVuY2VEaWFncmFtXG5cdENsaWVudC0-PlNlcnZlcjogU2VpdGVuYXVmcnVmXG5cdFNlcnZlci0tPj5DbGllbnQ6IFRhYmVsbGUgbWl0IEJ1bmRlc2zDpG5kZXJuLCBLbGFzc2Vuc3R1ZmVuLCBGw6RjaGVybiwgTW9kdWxlbiArIFRhYmVsbGUgbWl0IFNlbGJzdGxlcm4tUmVzc291cmNlbiBwcm8gTW9kdWwiLCJtZXJtYWlkIjp7InRoZW1lIjoiZGVmYXVsdCJ9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)

Wenn es einmal zigtausende Module gibt, sollten JSON-Tabellen pro Bundesland oder pro Bundesland+Klassenstufe oder pro Bundesland+Klassenstufe oder pro Bundesland+Klassenstufe+Fach vorkompiliert werden. (Etwa als Github-Action, die beim Annehmen einer Pull-Request ausgelöst wird; der Aufwand für das Kompilieren ist minimal.) Das Schema wäre dann im Extremfall, d. h. wenn es für jedes Bundesland+Klassenstufe+Fach:

![](https://mermaid.ink/img/eyJjb2RlIjoic2VxdWVuY2VEaWFncmFtXG5cdENsaWVudC0-PlNlcnZlcjogU2VpdGVuYXVmcnVmXG5cdFNlcnZlci0tPj5DbGllbnQ6IFRhYmVsbGUgbWl0IEJ1bmRlc2zDpG5kZXJuLCBLbGFzc2Vuc3R1ZmVuLCBGw6RjaGVyblxuXHRDbGllbnQtPj5TZXJ2ZXI6IEJ1bmRlc2xhbmQsIEtsYXNzZW5zdHVmZSwgRsOkY2hlclxuXHRTZXJ2ZXItLT4-Q2xpZW50OiBMaXN0ZSBkZXIgU2VsYnN0bGVybi1SZXNzb3VyY2VuIHBybyBGYWNoIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)


## Technologie
- Da es für neue Daten einen Review-Prozess geben soll, bietet es sich an, Github zu nutzen, insbesondere auch weil dort eine engagierte Community zu finden ist (vermutlich nehmen mehr Leute über Github am Reviewen teil, als über eine eigene Review-Lösung auf der Projekt-Website.) Die Daten können am einfachsten als JSON gespeichert werden und per Javascript lokal im Browser geladen werden. Github Pages ist eine sehr einfache und transparente und auch bei viel Traffic zuverlässige Lösung. Da es für die meisten Benutzer zu aufwendig sein wird, Github zu benutzen, sollte es ein einfaches Formular auf der Website geben, das dann per Github API eine Pull Request mit den neuen Daten erstellt. Die Website sollte mobile-friendly oder mobile-first und für junge Schüler ansprechend sein.
- Um Up- und Downvotes zu speichern macht Github eher weniger Sinn. Hier sollte es eine separate Lösung geben, die später implementiert werden kann.
