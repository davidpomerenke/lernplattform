drop table if exists Module, ModulHierarchie, Lehrplan, SelbstlernRessource, Zuordnung;
drop type if exists bundesland, schulart, ressourcenart;

create table Module
( Modul varchar(500) primary key
);

create type bundesland as enum
  ( 'Baden-Württemberg'
  , 'Bayern'
  , 'Berlin'
  , 'Brandenburg'
  , 'Bremen'
  , 'Hamburg'
  , 'Hessen'
  , 'Mecklenburg-Vorpommern'
  , 'Niedersachsen'
  , 'Nordrhein-Westfalen'
  , 'Rheinland-Pfalz'
  , 'Saarland'
  , 'Sachsen'
  , 'Sachsen-Anhalt'
  , 'Schleswig-Holstein'
  , 'Thüringen');

create type schulart as enum
  ( 'Grundschule'
  , 'Gemeinschaftsschule'
  , 'Realschule'
  , 'Gymnasium'
  );

create table Lehrplan
( Bundesland bundesland
, Schulart schulart
, Fach varchar(100)
, Klassenstufe smallint
, Modul varchar(500) references Module(Modul)
, LehrplanTitel varchar(500)
, LehrplanBeschreibung text
, LehrplanLehrziel text
, LehrplanQuelle varchar(500)
, EintragsDatum date
, primary key
  ( Bundesland
  , Schulart
  , Fach
  , Klassenstufe
  , Modul
  )
);

create type ressourcenart as enum
  ( 'vExperiment'
  , 'Sammlung'
  , 'Wettbewerb'
  , 'Nachschlageseite'
  , 'Tutorial'
  , 'Aufgaben'
  , 'Lerneinheit'
  , 'Lerntext'
  , 'Animation'
  , 'Erklärvideo'
  , 'Podcast'
  , 'Reportage'
  , 'Bericht'
  , 'Interview'
  , 'Originaltext'
  , 'Übersetzung'
  , 'Fachartikel'
  , 'Interpretation'
  , 'Vortrag'
  , 'Musik'
  , 'App'
  , 'Tool'
  , 'Code'
  , 'Klassenarbeit'
  , 'Musterlösung'
  , 'Community'
  , 'Q&A'
  );

create table SelbstlernRessource
( Link varchar(500) primary key
, Art ressourcenart not null
, Titel varchar(500) not null
, Beschreibung text default ''
, Upvotes int default 0
, Downvotes int default 0
, EintragsDatum date default current_date
, ÜberprüfungsDatum date default current_date
);

create table Zuordnung
( Modul varchar(500) references Module(Modul)
, Link varchar(500) references SelbstlernRessource(Link)
, primary key
  ( Modul
  , Link
  )
);

create table ModulHierarchie
( Untermodul varchar(500) references Module(Modul)
, Übermodul varchar(500) references Module(Modul)
);