# Deutschland Lernt Selbst. <a href="https://wirvsvirushackathon.org"><img align="right" src="hackathon.png"></a>
Übersicht über Selbstlern-Angebote für die Lehrpläne aller Bundesländer.

## Hackathon-Info
- `TITEL`: Self-Learning Angebote für Schüler*innen
- `PROBLEME`: Errichtung einer Plattform für kuratierte Self-Learning Angebote für Schüler*innen
- `BETROFFENENGRUPPE`: Schüler*innen und Lehrer*innen in Zeiten des Corona-Virus und darüber hinaus
- `FORMULIERUNG HERAUSFORDERUNG`: Wie können wir den Schüler*innen in Deutschland ein ausgewähltes Angebot mit elektronischen Lehrinhalten zur Verfügung stellen, um sie auch bei Schulschließungen von zu Hause aus weiterlernen zu lassen?
- `LÖSUNGSANSATZ`: Schulcloud.org; kiron.org; Anton App, virtuelles Klassenzimmer (ZDF), planet-schule (SWR/WDR)
- `ID`: 1952

## Mitmachen
- [Projekt-Kanban](https://github.com/davidpomerenke/deutschland-lernt-selbst/projects/2)
- Diskussionen am besten über Issues in Github, einen eigenen Slack-Channel gibt es bisher nicht, da ich das Projekt bisher alleine angehe. Wir können aber gerne einen aufmachen.

## Die Idee
Ziel ist es, für Schüler und Lehrer deutschlandweit eine Plattform bereitzustellen, auf der sie Links zu Selbstlern-Materialien miteinander austauschen können, die im Netz frei verfügbar sind:
- Jede Person soll für ihr Bundesland, ihr Fach, und ihre Klassenstufe die passenden Materialien angezeigt bekommen. 
- Jede Person soll auch selbst Materialien hinzufügen können, sowie bestehende Materialien bewerten können. Wichtig ist, dass die Materialien und Bewertungen immer für alle Bundesländer verfügbar gemacht werden. Das heißt, eine Mathelehrerin aus Berlin trägt z. B. eine interaktive Website zum Binomialgleichungen ein, die in Berlin in der siebten Klasse behandelt werden (fiktives Beispiel!). In Bayern werden diese aber schon in der sechsten Klasse behandelt. Dann wird die Website sowohl Siebtklässlern in Berlin, als auch Sechstklässlern in Bayern angezeigt, mit denselben Bewertungen.

Das Projekt strebt an, eine Datenbank zu erstellen, die aus zwei Teilen besteht:
1. Eine Zuordnung `Bundesland + Fach + Klassenstufe` → `Liste von Modulen`. Diese Zuordnung soll einmal aus den Lehrplänen extrahiert werden und dann gegebenenfalls jährlich aktualisiert werden.
2. Eine Zuordnung `Modul` → `Liste mit Selbstlern-Ressourcen`. Diese Daten sollen im Wesentlichen von der Community aus Schülern und Lehrern selbst eingetragen und bewertet werden.

Die Datenbank soll über eine Website zugänglich sein. Die Website soll anfangs einmal Bundesland, Klassenstufe, Kern- und Nebenfächer abfragen und lokal speichern. Daraufhin werden die verfügbaren Ressourcen pro Fach und nach Bewertungen sortiert angezeigt. Es soll auf der Website unkompliziert möglich sein, neue Einträge hinzuzufügen und bestehende Einträge zu bewerten.

## Struktur

### Entity-Relationship-Diagramm
![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggTFJcblx0bGVybnR7bGVybnR9XG5cdGhhdHtoYXQgTWF0ZXJpYWxpZW59XG5cdFxuXHRCdW5kZXNsYW5kIC0tLXxufCBsZXJudFxuXHRGYWNoIC0tLXxufCBsZXJudFxuXHRLbGFzc2Vuc3R1ZmUgLS0tfG58IGxlcm50XG5cdGxlcm50IC0tLXxufCBNb2R1bFxuXHRNb2R1bCAtLS18bnwgaGF0XG5cdGhhdCAtLS18bnwgU2VsYnN0bGVybi1SZXNzb3VyY2Vcblx0U2VsYnN0bGVybi1SZXNzb3VyY2UgLS0tIExpbmtcblx0U2VsYnN0bGVybi1SZXNzb3VyY2UgLS0tIEJlc2NocmVpYnVuZ1xuXHRTZWxic3RsZXJuLVJlc3NvdXJjZSAtLS0gVXB2b3Rlc1xuXHRTZWxic3RsZXJuLVJlc3NvdXJjZSAtLS0gRG93bnZvdGVzIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)

### Klassen-Diagramm
![](https://mermaid.ink/img/eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5cbmNsYXNzIEt1cnMge1xuXHQrQnVuZGVzbGFuZFxuXHQrRmFjaFxuXHQrS2xhc3NlbnN0dWZlXG5cdCtMaXN0ZSB2b24gTW9kdWxuYW1lblxufVxuXG5jbGFzcyBTZWxic3RsZXJuUmVzc291cmNlR2l0aHViIHtcblx0K01vZHVsbmFtZVxuXHQrTGlua1xuXHQrQmVzY2hyZWlidW5nXG59XG5cbmNsYXNzIFNlbGJzdGxlcm5SZXNzb3VyY2VEYXRlbmJhbmsge1xuXHQrTW9kdWxuYW1lXG5cdCtVcHZvdGVzXG5cdCtEb3dudm90ZXNcbn1cblxuS3VycyAtLT4gU2VsYnN0bGVyblJlc3NvdXJjZUdpdGh1YlxuS3VycyAtLT4gU2VsYnN0bGVyblJlc3NvdXJjZURhdGVuYmFuayIsIm1lcm1haWQiOnsidGhlbWUiOiJkZWZhdWx0In0sInVwZGF0ZUVkaXRvciI6ZmFsc2V9)

### Ablauf-Diagramm

#### User-Interface
![](https://mermaid.ink/img/eyJjb2RlIjoic2VxdWVuY2VEaWFncmFtXG5cdENsaWVudC0-PlNlcnZlcjogU2VpdGVuYXVmcnVmXG5cdFNlcnZlci0tPj5DbGllbnQ6IExpc3RlIGRlciBCdW5kZXNsw6RuZGVyXG5cdENsaWVudC0-PlNlcnZlcjogQnVuZGVzbGFuZFxuXHRTZXJ2ZXItLT4-Q2xpZW50OiBMaXN0ZSBkZXIgS2xhc3NlbnN0dWZlblxuXHRDbGllbnQtPj5TZXJ2ZXI6IEtsYXNzZW5zdHVmZVxuXHRTZXJ2ZXItLT4-Q2xpZW50OiBMaXN0ZSBkZXIgRsOkY2hlclxuXHRDbGllbnQtPj5TZXJ2ZXI6IEF1c3dhaGwgZGVyIEtlcm4tIHVuZCBOZWJlbmbDpGNoZXJcblx0U2VydmVyLS0-PkNsaWVudDogTGlzdGUgZGVyIFNlbGJzdGxlcm4tUmVzc291cmNlbiBwcm8gRmFjaCIsIm1lcm1haWQiOnsidGhlbWUiOiJkZWZhdWx0In0sInVwZGF0ZUVkaXRvciI6ZmFsc2V9)

#### Client-Server-Kommunikation
Zunächst wird ein Ansatz verfolgt, bei dem alle Daten auf einmal übertragen werden:

![](https://mermaid.ink/img/eyJjb2RlIjoic2VxdWVuY2VEaWFncmFtXG5cdENsaWVudC0-PlNlcnZlcjogU2VpdGVuYXVmcnVmXG5cdFNlcnZlci0tPj5DbGllbnQ6IFRhYmVsbGUgbWl0IEJ1bmRlc2zDpG5kZXJuLCBLbGFzc2Vuc3R1ZmVuLCBGw6RjaGVybiwgTW9kdWxlbiArIFRhYmVsbGUgbWl0IFNlbGJzdGxlcm4tUmVzc291cmNlbiBwcm8gTW9kdWwiLCJtZXJtYWlkIjp7InRoZW1lIjoiZGVmYXVsdCJ9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)]

Wenn es einmal zigtausende Module gibt, sollten JSON-Tabellen pro Bundesland oder pro Bundesland+Klassenstufe oder pro Bundesland+Klassenstufe oder pro Bundesland+Klassenstufe+Fach vorkompiliert werden. (Etwa als Github-Action, die beim Annehmen einer Pull-Request ausgelöst wird; der Aufwand für das Kompilieren ist minimal.) Das Schema wäre dann im Extremfall, d. h. wenn es für jedes Bundesland+Klassenstufe+Fach:

![](https://mermaid.ink/img/eyJjb2RlIjoic2VxdWVuY2VEaWFncmFtXG5cdENsaWVudC0-PlNlcnZlcjogU2VpdGVuYXVmcnVmXG5cdFNlcnZlci0tPj5DbGllbnQ6IFRhYmVsbGUgbWl0IEJ1bmRlc2zDpG5kZXJuLCBLbGFzc2Vuc3R1ZmVuLCBGw6RjaGVyblxuXHRDbGllbnQtPj5TZXJ2ZXI6IEJ1bmRlc2xhbmQsIEtsYXNzZW5zdHVmZSwgRsOkY2hlclxuXHRTZXJ2ZXItLT4-Q2xpZW50OiBMaXN0ZSBkZXIgU2VsYnN0bGVybi1SZXNzb3VyY2VuIHBybyBGYWNoIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)


## Technologie
- Da es für neue Daten einen Review-Prozess geben soll, bietet es sich an, Github zu nutzen, insbesondere auch weil dort eine engagierte Community zu finden ist (vermutlich nehmen mehr Leute über Github am Reviewen teil, als über eine eigene Review-Lösung auf der Projekt-Website.) Die Daten können am einfachsten als JSON gespeichert werden und per Javascript lokal im Browser geladen werden. Github Pages ist eine sehr einfache und transparente und auch bei viel Traffic zuverlässige Lösung. Da es für die meisten Benutzer zu aufwendig sein wird, Github zu benutzen, sollte es ein einfaches Formular auf der Website geben, das dann per Github API eine Pull Request mit den neuen Daten erstellt. Die Website sollte mobile-friendly oder mobile-first und für junge Schüler ansprechend sein.
- Um Up- und Downvotes zu speichern macht Github eher weniger Sinn. Hier sollte es eine separate Lösung geben, die später implementiert werden kann.

## Verwandte Projekte
- _awesome-lists_ (Github): 
  - `+` Sind kollaborativ. 
  - `-` Sind auf Englisch und nicht auf Schüler zugeschnitten. Es gibt es keine Bewertungen. Der Github-Workflow ist zu kompliziert für die meisten Lehrer und Schüler.
  - `→` Insbesondere für die Oberstufe wird es Sinn machen, diese zunächst als ganze Listen zu verlinken, später dann zu den einzelnen Modulen aufzuschlüsseln und die einzelnen Links zu übernehmen.
- Landesbildungsserver: 
  - `+` Sind auf deutsch, auf die Lehrpläne zugeschnitten und von Lehrern kuratiert, daher sehr qualitativ. 
  - `-` Sind nicht bundesweit vereinheitlicht und nicht direkt kollaborativ (meistens verwalten einige wenige Lehrer den Inhalt), auch gibt es keine Bewertungsmöglichkeit. Auf den Servern gibt es teilweise schon Listen mit Links zum Selbstlernen. 
  - `→` Langfristig wäre es sinnvoll, wenn es ein HTML-Snippet gäbe, mit dem auf einfache Weise auf den Landesbildungsservern modulweise die bundesweiten Listen von diesem Projekt angezeigt werden könnten.
