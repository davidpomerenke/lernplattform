drop table if exists Module, ModulHierarchie, Lehrplan, SelbstlernRessource, Zuordnung;
drop type if exists bundesland;

create table Module
( Modulname varchar(500) primary key
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

create table Lehrplan
( Bundesland bundesland
, Fach varchar(100)
, Klassenstufe smallint
, Modulname varchar(500) references Module(Modulname)
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
  , Modulname
  )
);

create table SelbstlernRessource
( Link varchar(500) primary key
, Beschreibung text default ''
, Upvotes int default 0
, Downvotes int default 0
);

create table Zuordnung
( Modulname varchar(500) references Module(Modulname)
, Link varchar(500) references SelbstlernRessource(Link)
, primary key
  ( Modulname
  , Link
  )
);

create table ModulHierarchie
( Untermodul varchar(500) references Module(Modulname)
, Übermodul varchar(500) references Module(Modulname)
);