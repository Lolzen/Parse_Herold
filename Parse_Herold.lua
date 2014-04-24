--// A script to parse certain fields of www.herold.at to an excell file
--// Uses Lua and luasocket libraries

-- Settings
local db = {}
local url = "http://www.herold.at/gelbe-seiten/"
local places = {
	"baden",
--	"wr-neustadt-neunkirchen",
--	"schwechat",
}
local branch = {
	-- A
	"Abbeizereien u Ablaugeunternehmen",
	"Abbruchunternehmen",
	"Abdichtungen",
	"Abfall-, Entsorgungs- u Deponietechnik",
	"Abfallentsorgung u -verwertung",
	"Abflussdienste",
	"Abfüllanlagen u -maschinen",
	"Abluftreinigung",
	"Absauganlagen u -geräte",
	"Abscheider u Separatoren",
	"Abschleppdienste",
	"Absturzsicherungssysteme",
	"Abwasseraufbereitung, -reinigung u -anlagen",
	"Abwasserbeseitigung",
	"Abwassertechnik",
	"Abzeichen u Embleme",
	"Abziehbilder",
	"Acrylglas",
	"Adressen- u Telefonbuchverlage",
	"Adventure Sports",
	"Aerosole",
	"Aggregate",
	"Aids / Beratung u Information",
	"Airbrush",
	"Akkumulatoren",
	"Aktenvernichtung / Service",
	"Akupunktur / Akupressur",
	"Akustik u Akustikbau",
	"Akustikdecken",
	"Alarmanlagen u Sicherheitssysteme",
	"Allergien",
	"Allgemeinbildende Höhere Schulen",
	"Altbausanierungen",
	"Alteisen u Altmetalle",
	"Alternativtherapie",
	"Altöl- u Altfettentsorgung",
	"Altpapier",
	"Altwaren",
	"Aluminium",
	"Aluminiumbe- u -verarbeitung",
	"Aluminiumbleche",
	"Aluminiumhalbfabrikate",
	"Aluminiumprofile",
	"Ambulanzflüge",
	"Ambulatorien",
	"Analysegeräte",
	"Änderungsschneidereien",
	"Anhänger u Aufbauten",
	"Anhängerteile, -kupplungen u -vorrichtungen",
	"Anlagenbau u -technik",
	"Ansichts- u Glückwunschkarten",
	"Antennen",
	"Antennentechnik",
	"Antiquariate",
	"Antiquitäten",
	"Antiquitätenrestaurierung",
	"Antriebstechnik",
	"Apotheken",
	"Apothekenbedarf u -einrichtungen",
	"Apparatebau",
	"Appartements / Ferienwohnungen",
	"Aquarien u Aquarienbedarf",
	"Arbeitsbühnen",
	"Arbeitsinspektorate",
	"Arbeitsschutz u Arbeitsschutzartikel",
	"Arbeitsvermittlung",
	"Architekten",
	"Architekturmodellbau",
	"Architekturvisualisierungen",
	"Archive",
	"Armaturen / Einzelhandel",
	"Armaturen / Erzeugung u Großhandel",
	"Armaturen / Reparatur",
	"Army Shops",
	"Ärzte / f Allgemeinmedizin",
	"Ärzte / Fachärzte f Anästhesiologie u Intensivmedizin",
	"Ärzte / Fachärzte f Anatomie",
	"Ärzte / Fachärzte f Angiologie",
	"Ärzte / Fachärzte f Arbeits- u Betriebsmedizin",
	"Ärzte / Fachärzte f Augenheilkunde u Optometrie",
	"Ärzte / Fachärzte f Blutgruppenserologie u Transfusionsmedizin",
	"Ärzte / Fachärzte f Chirurgie",
	"Ärzte / Fachärzte f Frauenheilkunde u Geburtshilfe",
	"Ärzte / Fachärzte f Gastroenterologie u Hepatologie",
	"Ärzte / Fachärzte f Gefäßchirurgie",
	"Ärzte / Fachärzte f Gerichtsmedizin",
	"Ärzte / Fachärzte f Hals-, Nasen- u Ohrenkrankheiten",
	"Ärzte / Fachärzte f Hämato-Onkologie",
	"Ärzte / Fachärzte f Haut- u Geschlechtskrankheiten",
	"Ärzte / Fachärzte f Herzchirurgie",
	"Ärzte / Fachärzte f Hygiene u Mikrobiologie",
	"Ärzte / Fachärzte f Immunologie",
	"Ärzte / Fachärzte f Innere Medizin",
	"Ärzte / Fachärzte f Kardiologie",
	"Ärzte / Fachärzte f Kinder- u Jugendchirurgie",
	"Ärzte / Fachärzte f Kinder- u Jugendheilkunde",
	"Ärzte / Fachärzte f Kinder- u Jugendneuropsychiatrie",
	"Ärzte / Fachärzte f Kinder- u Jugendpsychiatrie",
	"Ärzte / Fachärzte f Lungenkrankheiten",
	"Ärzte / Fachärzte f Medizinisch-Chemische Labordiagnostik",
	"Ärzte / Fachärzte f Medizinische Genetik",
	"Ärzte / Fachärzte f Mund-, Kiefer- u Gesichtschirurgie",
	"Ärzte / Fachärzte f Nephrologie",
	"Ärzte / Fachärzte f Neurochirurgie",
	"Ärzte / Fachärzte f Neurologie",
	"Ärzte / Fachärzte f Nuklearmedizin",
	"Ärzte / Fachärzte f Orthopädie u orthopädische Chirurgie",
	"Ärzte / Fachärzte f Pathologie",
	"Ärzte / Fachärzte f Physikalische Medizin u allgemeine Rehabilitation",
	"Ärzte / Fachärzte f Plastische, Ästhetische u. Rekonstruktive Chirurgie",
	"Ärzte / Fachärzte f Psychiatrie",
	"Ärzte / Fachärzte f Radiologie",
	"Ärzte / Fachärzte f Rheumatologie",
	"Ärzte / Fachärzte f Strahlentherapie-Radioonkologie",
	"Ärzte / Fachärzte f Tropenmedizin u Spezifische Prophylaxe",
	"Ärzte / Fachärzte f Unfallchirurgie",
	"Ärzte / Fachärzte f Urologie",
	"Ärzte / Fachärzte f Virologie",
	"Ärzte / Fachärzte f Zahn-, Mund- u Kieferheilkunde",
	"Ärzte / Fachärzte f Zytodiagnostik",
	"Ärzte / Sportmedizin",
	"Ärzte / Zahnärzte",
	"Ärzte- u Gesundheitszentren",
	"Ärzte- u Spitalsbedarf",
	"Ärzte- u Spitalseinrichtungen",
	"Asphaltierungen",
	"Astrologie",
	"Astronomie",
	"Atemschutztechnik",
	"Atemtherapie & Atempädagogik",
	"Ätherische Öle u Essenzen",
	"Audio-, Videokassetten u Zubehör",
	"Audiovisuelle Geräte u Lehrmittel",
	"Audiovisuelle Geräte u Lehrmittel / Vermietung",
	"Audiovisuelle Produktionen",
	"Aufsperrdienste",
	"Aufzüge",
	"Aufzüge / Service u Überwachung",
	"Ausflugsziele",
	"Auskunfteien",
	"Ausländische Handelskammern",
	"Auspuffe",
	"Ausschneidereien",
	"Autobahnraststätten",
	"Autobedarf u -zubehör",
	"Autobeschriftungen",
	"Autobusse / Service u Vertrieb",
	"Autobusunternehmen",
	"Autoelektrik u -ersatzteile",
	"Autoersatzteile u -zubehör",
	"Autoglas",
	"Autohandel",
	"Autoheizungen",
	"Autoklimaanlagen",
	"Autokrane",
	"Autokühler",
	"Autolacke",
	"Autolackierereien",
	"Automaten",
	"Automatendrehereien",
	"Automatische Türen u Tore",
	"Automatisierungstechnik",
	"Autoradios u Zubehör",
	"Autorengesellschaften",
	"Autoreparatur",
	"Autorepräsentanzen",
	"Autosattlereien",
	"Autoschnellservice",
	"Autospenglereien",
	"Autotuning",
	"Autovermietung",
	"Autoverwertung",
	"Autowaschanlagen / Erzeugung u Vertrieb",
	"Autowäsche u -reinigung",
	"Ayurveda",
	-- B
	"Babyausstattung",
	"Bachblüten",
	"Bäckerei- u Konditoreibedarf",
	"Bäckereieinrichtungen u -maschinen",
	"Bäckereien",
	"Bäder",
	"Badewannenbeschichtungen, -einsätze, -reparaturen",
	"Badezimmer u Badezimmereinrichtungen",
	"Badminton",
	"Bahnhöfe",
	"Balkenschlösser",
	"Balkon-, Loggien- u Terrassenverbauten",
	"Balkone u -geländer",
	"Ballenpressen",
	"Ballett- u Theatertanzartikel",
	"Ballettschulen",
	"Ballonfahrten",
	"Bandagen u Bandagisten",
	"Bänder u Bandwaren / Erzeugung u Großhandel",
	"Banken u Sparkassen",
	"Bankomat-Standorte",
	"Barcode-Lesegeräte u -systeme",
	"Bars-Cafes",
	"Bastelbedarf",
	"Batterien u -zubehör",
	"Bauchtanz",
	"Bauernhöfe",
	"Bauernmöbel u -stuben",
	"Baukoordination / Bauaufsicht",
	"Bauleitung u -betreuung",
	"Baumabtragungen",
	"Baumakler",
	"Baumanagement",
	"Baumärkte",
	"Baumaschinen u -geräte",
	"Baumaschinen u -geräte / Reparatur",
	"Baumaschinenverleih",
	"Baumeister",
	"Baumfällung",
	"Baumpflege, Baumschutz u Baumchirurgie",
	"Baumschulen",
	"Bauphysik",
	"Bausoftware",
	"Bausparkassen",
	"Bauspenglereien",
	"Baustoffe u -material",
	"Bautenschutz",
	"Bautischlereien",
	"Bauträger u Bauentwicklung",
	"Bautrocknung",
	"Bauunternehmen",
	"Befestigungstechnik",
	"Behälter",
	"Behindertenhilfsmittel",
	"Behinderungen / Leben mit Behinderungen",
	"Bekleidung / Einzelhandel",
	"Bekleidung / Erzeugung u Großhandel",
	"Beleuchtung",
	"Beleuchtungsanlagen",
	"Beleuchtungskörper / Einzelhandel",
	"Beleuchtungskörper / Erzeugung u Großhandel",
	"Beratungsstellen",
	"Beregnungsanlagen",
	"Berg- u Hüttenwerksausrüstungen",
	"Bergbahnen",
	"Bergbauunternehmen",
	"Bergsportartikel",
	"Berufsbekleidung / Einzelhandel",
	"Berufsbekleidung / Erzeugung u Großhandel",
	"Berufsbildende Mittlere u Höhere Schulen",
	"Berufsschulen",
	"Beschichtungen",
	"Beschläge",
	"Beschriftungen",
	"Besen / Erzeugung",
	"Bestattungsartikel",
	"Bestattungsunternehmen",
	"Bestecke u Tafelgeräte",
	"Beteiligungen u Finanzierungen",
	"Beton- u Betonsteinwerke",
	"Betonbearbeitungen",
	"Betonbohr- u -schneidedienst",
	"Betonerzeugnisse",
	"Betonsanierungen",
	"Betonstahl",
	"Betreuung Schwerkranker u Sterbender",
	"Betriebs- u Fernverpflegung",
	"Betriebsbeteiligungen",
	"Betriebseinrichtungen",
	"Betriebshygiene",
	"Betten",
	"Bettfedern",
	"Bettfedernreinigung",
	"Bettwaren",
	"Bewachungsunternehmen",
	"Bewässerungsanlagen",
	"Bezirkshauptmannschaften",
	"Bibliotheken",
	"Bibliothekseinrichtungen",
	"Bierdepots",
	"Bierlokale-Pubs",
	"Bijouteriewaren",
	"Bilanzbuchhalter",
	"Bildagenturen u -archive",
	"Bilder",
	"Bilderrahmen",
	"Bildhauer",
	"Bildungsservice / Allgemeine Informationsstellen",
	"Billardcafes",
	"Billards u Billardartikel",
	"Biofeedback",
	"Biologische Produkte",
	"Bioresonanz",
	"Biotreibstoffe / Erzeugung u Großhandel",
	"Blattgold",
	"Blechbe- u -verarbeitung",
	"Blechbe- u -verarbeitungsmaschinen u -werkzeuge",
	"Bleche u Blechwaren",
	"Blechzuschnitte u Kantung",
	"Blitzableiter u Blitzschutzanlagen",
	"Blockhäuser",
	"Blower Door Messung",
	"Blumeneinzelhandel",
	"Blumengroßhandel",
	"Blumenversand u -vermittlung",
	"Blut- u Plasmaspenden",
	"Blutdruckmessgeräte",
	"Bodenbeläge",
	"Bodenmarkierungen",
	"Bodenreinigungs- u -pflegemaschinen",
	"Bodenuntersuchungen",
	"Bodenverlegung",
	"Bohrgeräte, -maschinen u -zubehör",
	"Bohrunternehmen",
	"Bonsai",
	"Boote, Yachten u Zubehör",
	"Bootsmotoren",
	"Bootsvermietung",
	"Bordelle",
	"Börsenmakler",
	"Botendienste",
	"Botschaften",
	"Boutiquen",
	"Brandmeldeanlagen",
	"Brandrauchentlüftungen",
	"Brandschadensanierung",
	"Brandschutz",
	"Brandschutztüren u -tore",
	"Brauereianlagen u -bedarf",
	"Brauereien",
	"Brautkleider u -artikel",
	"Brautkleider u -artikel / Vermietung",
	"Bremsen- u Kupplungsdienste",
	"Brenner",
	"Brennereianlagen u -bedarf",
	"Brennstoffe",
	"Brief- u Paketwaagen",
	"Briefkästen",
	"Briefmarken (Philatelie)",
	"Brillen u -fassungen / Erzeugung u Großhandel",
	"Bronzewaren",
	"Brötchen",
	"Brückenuntersichtbefahranlagen",
	"Brunnen u Brunnenbau",
	"Brunnenringe",
	"Buchbindereien",
	"Buchbindereimaschinen u -bedarf",
	"Buchgemeinschaften",
	"Buchhalter / Gewerbliche u Selbständige",
	"Buchhaltung",
	"Buchhandlungen",
	"Buchprüfer",
	"Büchsenmachereien",
	"Buchstaben",
	"Buffets u Imbissstuben",
	"Bügelgeräte u -maschinen",
	"Bühnen u Tribünen",
	"Bühnenbeleuchtung",
	"Bühneneinrichtungen",
	"Bundesheer",
	"Bundesministerien",
	"Bürobedarf",
	"Büromaschinen",
	"Büromaschinen / Reparatur u Service",
	"Büromöbel u -einrichtungen",
	"Büroorganisation u -systeme",
	"Büroservice u -vermietung",
	"Bürostühle",
	"Bürsten u Pinsel",
	-- C
	"CAD/CAE/CAM/PLM/PDM/CIM-Systeme",
	"Call Center",
	"Callgirls / Callboys",
	"Callshops",
	"Campingartikel u -ausrüstungen",
	"Campingplätze",
	"Carports",
	"Catering",
	"CD, DVD / Erzeugung u Produktion",
	"CD, DVD u Schallplatten / Vertrieb",
	"CD-ROMs, DVD-ROMs",
	"Chemikalien",
	"Chemisch-technische Produkte",
	"Chemische Produkte",
	"Chemische Rohstoffe",
	"Chinesische Medizin",
	"Chiropraktiker",
	"Christbaumschmuck",
	"CNC-Bearbeitungen",
	"Coaching",
	"Comics",
	"Computer",
	"Computer / Datenrettung",
	"Computer / Reparatur u Service",
	"Computer- u EDV-Beratung",
	"Computer- u Videospiele",
	"Computerkassen",
	"Computernetzwerke",
	"Computerperipherie",
	"Computerschulen u -ausbildung",
	"Computersysteme",
	"Computerzubehör",
	"Container",
	"Containerdienste",
	"Containertransporte",
	"Cranio-Sacral-Therapie",
	-- D
	"Dachbodenausbau",
	"Dachdeckereibedarf u -material",
	"Dachdeckereien",
	"Dachflächenfenster",
	"Dachgärten",
	"Damenmoden",
	"Dämmstoffe",
	"Dampfkessel",
	"Dampfkesselprüfungen u -überwachungen",
	"Därme",
	"Darts",
	"Daten- u Aktenvernichtung",
	"Daten- u Aktenvernichtungsgeräte",
	"Datenerfassung",
	"Datenprojektion",
	"Datenverarbeitung",
	"Decken- u Wandverkleidungen",
	"Dekor- u Möbelstoffe",
	"Dekorationen",
	"Dekorationsartikel",
	"Dekorationsmalerei",
	"Dentalwaren",
	"Designer",
	"Desinfektionsgeräte u -mittel",
	"Desk Top Publishing",
	"Detekteien",
	"Devotionalien u Paramente",
	"Diabetes / Zuckerkrankheit",
	"Dialyseinstitute",
	"Diamanten u -werkzeuge / f Industrie u Gewerbe",
	"Diätnahrung",
	"Dichtungen",
	"Dichtungsmassen u -materialien",
	"Dienstleistungen A-Z",
	"Dieseleinspritzanlagen u -pumpen",
	"Dieselmotoren u -reparaturen",
	"Digitaldruck",
	"Diktiergeräte",
	"Direktmarketing",
	"Discjockeys u -service",
	"Diskotheken",
	"Diskothekenanlagen u -vermietung",
	"Displays",
	"Dolmetschanlagen",
	"Dolmetscher",
	"Dolmetscher / Bulgarisch",
	"Dolmetscher / Italienisch",
	"Dolmetscher / Polnisch",
	"Dolmetscher / Russisch",
	"Doppelböden",
	"Dosieranlagen u -pumpen",
	"Drähte u Drahtwaren",
	"Drahtgitter u -zäune",
	"Drahtseile",
	"Drechslereien",
	"Drehereien",
	"Drogerien",
	"Drucker",
	"Druckereien",
	"Druckereimaschinen u -bedarf",
	"Druckluftanlagen u -maschinen",
	"Druckluftarmaturen",
	"Druckluftsteuerungen",
	"Drucklufttechnik",
	"Druckluftwerkzeuge u -geräte",
	"Druckregler u -schalter",
	"Dübel",
	"Düngemittel",
	"Dunstabzugshauben",
	"Durchlauferhitzer",
	"Duschkabinen u -trennwände",
	"Düsen",
	-- E
	"E-Commerce",
	"Edelbrände & Schnäpse",
	"Edelmetalle u -verarbeitung",
	"Edelstahl",
	"Edelstahlverarbeitung",
	"Edelsteine",
	"EDV-Dienstleistungen",
	"Ehe- u Partnerberatung",
	"Eichungen",
	"Eier",
	"Einbruchschutz",
	"Einfriedungen",
	"Eingangsverbauten",
	"Einkaufszentren",
	"Einrichtungshäuser",
	"Einspritzpumpen",
	"Eis / Erzeugung",
	"Eisautomaten u -maschinen",
	"Eisen",
	"Eisenwaren",
	"Eissalons",
	"Elektrische Haushaltsgeräte",
	"Elektrische Heizungen",
	"Elektrizitätswerke u -gesellschaften",
	"Elektro- u Solarfahrzeuge",
	"Elektroaltgeräte - Koordinierungsstellen",
	"Elektrogeräte / Einzelhandel",
	"Elektrogeräte / Erzeugung u Großhandel",
	"Elektrogeräte / Reparatur",
	"Elektrogroßhandel",
	"Elektroinstallationsmaterial",
	"Elektroinstallationsnotdienste",
	"Elektroinstallationsunternehmen",
	"Elektroisoliermaterial u Lackdrähte",
	"Elektromechanische Werkstätten",
	"Elektromotoren / Reparatur u Wicklerei",
	"Elektromotoren u -maschinen",
	"Elektronik",
	"Elektronische Bauelemente u Bauteile",
	"Elektronotdienste",
	"Elektroplanung",
	"Elektrosmogmessungen",
	"Elektrotechnik",
	"Elektrowerkzeuge",
	"Eloxierungen",
	"Emaillierungen",
	"Endlosformulare u -papier",
	"Energethiker",
	"Energieberatung u -untersuchung",
	"Energiespartechnik",
	"Energietechnik",
	"Entbindungsheime",
	"Entfeuchtungen",
	"Entfeuchtungsgeräte u -anlagen",
	"Entkalkungen",
	"Entrümpelungen",
	"Entsorgungen",
	"Entstaubungsanlagen",
	"Entwässerungstechnik",
	"Erdarbeiten",
	"Erdbau",
	"Erdwärme",
	"Ergotherapie",
	"Ernährungsberatung und Diätologen",
	"Erotische Lokale / Clubs / Studios",
	"Erotische Massagen",
	"Escortservice",
	"Esoterik",
	"Espresso- u Kaffeemaschinen",
	"Essen auf Rädern",
	"Essenzen u Aromen",
	"Estriche",
	-- F
	"Facility Management",
	"Factoringgesellschaften",
	"Fahnen u Wimpel",
	"Fahrräder u -bestandteile",
	"Fahrradreparatur",
	"Fahrradverleih",
	"Fahrschulen",
	"Fahrsicherheitszentren",
	"Fahrtschreiber",
	"Fahrzeugbau",
	"Fahrzeugeinrichtungen u -umbauten",
	"Fairer Handel",
	"Faltkartons u Faltschachteln",
	"Falzmaschinen",
	"Familien / Beratung",
	"Farb-, Stil- u Typberatung",
	"Farben u Lacke / Einzelhandel",
	"Farben u Lacke / Erzeugung u Großhandel",
	"Färbereien",
	"Farbkopiergeräte",
	"Farbspritzapparate u -anlagen",
	"Faschingsartikel",
	"Fassaden",
	"Fassadenanstriche",
	"Fassadenreinigung",
	"Fassbindereien",
	"Fässer",
	"Faxgeräte u -zubehör",
	"Federn",
	"Feinkost",
	"Feinmechanik",
	"Felle, Häute u Rauhwaren",
	"Feng-Shui",
	"Fenster",
	"Fenster- u Türdichtungen",
	"Fensterbänke",
	"Fensterläden",
	"Fensterreinigung",
	"Fensterrenovierung, -reparatur u -service",
	"Fernschulen",
	"Fernseh- u Radiogeräte",
	"Fernseh- u Radiogesellschaften",
	"Fernsehservice",
	"Fernwärme",
	"Fertiggaragen",
	"Fertighäuser",
	"Fertigteilbau",
	"Feuerfestbau u -materialien",
	"Feuerlöschanlagen u -geräte",
	"Feuerwehrausrüstungen",
	"Feuerwehren",
	"Feuerwerksartikel u Feuerwerke / Pyrotechnik",
	"Feuerzeuge",
	"Fiaker",
	"Film- u Videogeräte",
	"Film- u Videogeräte / Vermietung",
	"Filmkopieranstalten",
	"Filmproduktionen",
	"Filmsynchronisation",
	"Filmverleih u -vertrieb",
	"Filter",
	"Filteranlagen",
	"Filze u Filzwaren",
	"Finanz- u Wirtschaftsberatung",
	"Finanzämter u Landesdirektionen",
	"Firmengründungen",
	"Fische u Fischwaren / Einzelhandel",
	"Fische u Fischwaren / Erzeugung u Großhandel",
	"Fischerei",
	"Fischereigeräte u -artikel",
	"Fischzucht",
	"Fitnesscenter",
	"Fitnessgeräte",
	"Fitnesspräparate",
	"Flaschen",
	"Fleisch-, Wurst- u Selchwaren / Erzeugung u Großhandel",
	"Fleischereibedarf u -zubehör",
	"Fleischereimaschinen u -einrichtungen",
	"Fleischhauereien",
	"Fliesen u Platten / Reparatur",
	"Fliesen und Platten",
	"Fliesen- u Plattenverlegungen",
	"Flugcharter",
	"Fluggesellschaften",
	"Flughafenbetriebsgesellschaften",
	"Flughafentransfer",
	"Flugschulen",
	"Flugservice",
	"Flugzeuge",
	"Flüssiggase",
	"Folien",
	"Folienschweißgeräte",
	"Förderanlagen u -geräte",
	"Förderbänder",
	"Förderbänder / Reparatur",
	"Fördertechnik",
	"Formenbau",
	"Forschungsinstitute",
	"Forstbedarf",
	"Forstverwaltungen",
	"Fotoapparate u -artikel / Einzelhandel",
	"Fotoapparate u -artikel / Erzeugung u Großhandel",
	"Fotoapparate u -artikel / Reparatur",
	"Fotoausarbeitungen",
	"Fotobücher",
	"Fotografen",
	"Frankiermaschinen",
	"Fräsarbeiten",
	"Frauengesundheit",
	"Freizeit- u Sportbekleidung",
	"Freizeitangebote u -einrichtungen",
	"Fremdenführer",
	"Friedhöfe u Aufbahrungshallen",
	"Friedhofsgärtnereien",
	"Friseurbedarf",
	"Friseure u Frisiersalons",
	"Friseureinrichtungen",
	"Frottierwaren",
	"Fruchtsäfte u -konzentrate",
	"Füllfedern u Kugelschreiber",
	"Füllstoffe",
	"Fundraising-Agenturen",
	"Funkanlagen u -geräte",
	"Funksprechanlagen, -geräte u -zubehör",
	"Furniere",
	"Fußabstreifer u -matten",
	"Fußböden",
	"Fußbodenbeläge",
	"Fußbodenheizungen",
	"Fußbodenpflege u -mittel",
	"Fußbodenschleifereien u -versiegelung",
	"Fußbodenschleifmaschinen",
	"Fußpflege u Fußpflegesalons",
	"Futtermittel",
	-- G
	"Gabelstapler",
	"Galerien",
	"Galvanisierungen",
	"Garagen (Parkgaragen)",
	"Garagenbau",
	"Garagentore u -antriebe",
	"Garderobeneinrichtungen",
	"Garten- u Landschaftsgestaltung",
	"Gartenanlagen",
	"Gartenarchitekten",
	"Gartenbaubedarf",
	"Gartenbedarf u -geräte",
	"Gartencenter",
	"Gartenmöbel",
	"Gartenpflege",
	"Gartenteiche u -zubehör",
	"Gärtnereien",
	"Gasbrenner",
	"Gase",
	"Gasgeräte",
	"Gasheizungen",
	"Gasthäuser u Gasthöfe",
	"Gastronomie- u Hotelbedarf",
	"Gastronomie- u Hotelbetriebsgesellschaften",
	"Gastronomie- u Hoteleinrichtungen",
	"Gasversorgungsunternehmen",
	"Gebäude- u Energieausweise",
	"Gebäudemanagement / Gebäudeservice",
	"Gebäudereinigung",
	"Gebäudetechnik",
	"Gebläse",
	"Gebrauchtwagen",
	"Gefahrgutbeauftragter",
	"Gefahrguttransporte",
	"Geflügelzucht u Geflügelzuchtbedarf",
	"Gegensprechanlagen",
	"Gehäuse u Gehäuseeinheiten",
	"Geigen",
	"Geländer",
	"Geldzähl-, Sortier- u Verpackungsmaschinen",
	"Gelenkwellen u -lager",
	"Gemeinden",
	"Gemüsekonserven / Erzeugung",
	"Generatoren",
	"Genossenschaften",
	"Geographische Informationssysteme",
	"Geologie",
	"Geomantie",
	"Geometer",
	"Gerbereien",
	"Gerichte",
	"Gerichtsdolmetscher",
	"Gerüste",
	"Geschäftseinrichtungen",
	"Geschäftsvermittlungen",
	"Geschenkartikel",
	"Geschirr",
	"Geschirrspülmaschinen",
	"Gesundenuntersuchung",
	"Gesundheit / Allgemeine Informationsstellen",
	"Gesundheitsdienste",
	"Gesundheitsvorsorge",
	"Getränke",
	"Getränkeautomaten",
	"Getreidemühlen",
	"Getriebe",
	"Getriebemotoren",
	"Gewerbeparks",
	"Gewerkschaften",
	"Gewürze",
	"Gießereieinrichtungen u -bedarf",
	"Gießereien",
	"Gips u Gipsprodukte",
	"Gitter",
	"Gitterroste",
	"Glas / Glashandel",
	"Glasbe- u -verarbeitung",
	"Glasbläsereien",
	"Glasbruch",
	"Glasdach- u Glaswandbau",
	"Glasereien",
	"Glasfasern",
	"Glasgraveure u -ätzereien",
	"Glashäuser",
	"Glaskunst u -gestaltung",
	"Glaswaren",
	"Gleisbau",
	"Glockengießereien",
	"Goldankauf",
	"Golfplätze",
	"Golfsportausrüstungen",
	"Grabkreuze u -laternen",
	"Grabpflege",
	"Grabsteine u Grabdenkmäler",
	"Grafische Bedarfsartikel",
	"Grafische Maschinen u Reparaturen",
	"Granitwerke",
	"Graphologen",
	"Graveure",
	"Graviermaschinen u Graviermaterialien",
	"Grill- u Bratgeräte",
	"Großformatdruck",
	"Großküchenanlagen u -einrichtungen",
	"Großküchenmaschinen u -bedarf",
	"Großküchenplanung",
	"Grundstück- u Immobilienverwertung",
	"Gummi u Gummiwaren",
	"Gurte",
	"Gürtlereien",
	"Gutsverwaltungen",
	"Gymnastikinstitute",
	-- H
	"Haarentfernungen",
	"Haarinstitute",
	"Haartrockner",
	"Hackgut / Erzeugung",
	"Hafnerbedarf",
	"Hafnereien",
	"Hallenbau u -sanierung",
	"Hallenvermietung",
	"Hand- u Fußpflege",
	"Handarbeiten",
	"Handelsagenturen",
	"Händetrockner",
	"Handschuhe",
	"Hanf- u Grow-Shops",
	"Hängematten",
	"Härtereien",
	"Hauptschulen",
	"Haus- u Küchengeräte u -reparatur",
	"Hausbetreuung / Hausbesorger",
	"Haushaltsartikel",
	"Hauskrankenpflege / Heimhilfe / Personenbetreuung",
	"Haustüren",
	"Hausverwaltungen",
	"Hauszustellung / Zustelldienste",
	"Hebammen",
	"Hebebänder, Zurrgurte u Rundschlingen",
	"Hebebühnen",
	"Hebetechnik",
	"Heil- u Krankengymnastik",
	"Heilmassagen",
	"Heizbänder u -kabel",
	"Heizgas",
	"Heizgeräte",
	"Heizkörper",
	"Heizkörperverkleidungen",
	"Heizkostenabrechnungen",
	"Heizöle",
	"Heizungen",
	"Heizungsanlagen",
	"Hemden",
	"Herrenmoden",
	"Heurigen / Buschenschenken",
	"Hi-Fi-Anlagen",
	"Hilfsorganisationen u Entwicklungshilfe",
	"Hobbyvereine",
	"Hochdruckreinigungsmaschinen u -geräte",
	"Hochzeitsservice u -bedarf",
	"Holdinggesellschaften",
	"Holzbau",
	"Holzbe- u -verarbeitung",
	"Holzbearbeitungsmaschinen u -werkzeuge",
	"Holzdecken u Wandverkleidungen",
	"Holzfachmärkte",
	"Holzfußböden",
	"Holzgroßhandel",
	"Holzhandel",
	"Holzhäuser",
	"Holzleisten",
	"Holzplatten",
	"Holzschindeln",
	"Holzschlägerung",
	"Holzschnitzereien",
	"Holzschutz",
	"Holzwaren",
	"Homöopathie",
	"Homöopathische Erzeugnisse u Präparate",
	"Hörgeräte",
	"Hörgeräteakustiker",
	"Hornwaren",
	"Hosenträger",
	"Hotels",
	"Hubschrauberflugdienste",
	"Hubtische",
	"Hufschmiede",
	"Hunde u Hundeartikel",
	"Hunde- u Katzensalons",
	"Hundeausbildung und -schulen",
	"Hundebetreuung",
	"Hundepsychologie",
	"Hüte u Kappen / Erzeugung u Großhandel",
	"Hydraulik",
	"Hydraulikschläuche u -kupplungen",
	"Hydraulikzylinder",
	"Hydrokulturen",
	"Hygieneartikel / Erzeugung u Großhandel",
	"Hygienepapiere",
	"Hypnose",
	-- I
	"Imkereibedarf",
	"Imkereien",
	"Immobilien",
	"Immobilienbewertung",
	"Immobilienmakler",
	"Immobilienverwaltungen",
	"Implantologie",
	"Industrieanlagenbau u -planung",
	"Industrieausrüstungen u -bedarf",
	"Industrieböden u -beläge",
	"Industrieöfen u -ofenbau",
	"Industriereinigung",
	"Industrieroboterbau",
	"Industriesauger",
	"Industrievertretungen",
	"Infrarotheizungen",
	"Infrarotkabinen",
	"Ingenieurbüros (vorm: Technische Büros)",
	"Ingenieurkonsulenten / Zivilingenieure",
	"Inkassoinstitute",
	"Innenarchitektur",
	"Innenausbau",
	"Innenputz",
	"Innungen",
	"Insektenschutz",
	"Insektenschutzgitter",
	"Installateure - Gasgeräte - Notdienste",
	"Installateurnotdienste",
	"Installationsmaterialien",
	"Installationsunternehmen",
	"Institute",
	"Interessensvertretungen",
	"Internate u Schülerheime",
	"Internationale Organisationen",
	"Internet",
	"Internet-Cafes",
	"Internet-Provider",
	"Internet-Vermarkter",
	"Isolierglas",
	"Isoliermaterialien",
	"Isolierungen",
	"IT-Solutions",
	-- J
	"Jagdausrüstungen u -bekleidung",
	"Jalousien",
	"Jalousienreparatur u -zubehör",
	"Jugendheime",
	"Jugendherbergen",
	"Jugendliche (Teenager) / Beratung",
	"Justizanstalten",
	"Juwelen, Gold- u Silberwaren / Einzelhandel",
	"Juwelen, Gold- u Silberwaren / Erzeugung u Großhandel",
	"Juwelier- u Uhrmacherbedarf",
	"Juweliere, Gold- u Silberschmiede",
	-- K
	"Ärzte / Kieferorthopädie / Zahnregulierungen",
	"Kabaretts",
	"Kabel u -zubehör",
	"Kabelfernsehen",
	"Kabelformsteine",
	"Kabelkonfektionen",
	"Kabelmaschinen u -trommeln",
	"Kachel- u Kaminöfen",
	"Kaffee",
	"Kaffee / Import u Großhandel",
	"Kaffeeautomaten",
	"Kaffeehäuser",
	"Kaffeekonditoreien",
	"Kaffeeröstereien",
	"Kalender",
	"Kalk",
	"Kälte- u Klimatechnik",
	"Kälteanlagentechnik",
	"Kamin- u Schornsteinbau",
	"Kaminsanierungen u -ausschleifereien",
	"Kammern",
	"Kampfmittelbeseitigung",
	"Kampfsport",
	"Kanal- und Leitungsüberprüfungen",
	"Kanalbau",
	"Kanalräumung u -reinigung",
	"Kanalsanierung",
	"Kappen",
	"Karniesen",
	"Karosseriebau",
	"Kartbahnen",
	"Kartenbüros",
	"Kartonagen",
	"Kaschier- u Laminiergeräte",
	"Kaschierungen",
	"Kassetten",
	"Katzen u Katzenbedarf",
	"Kaufhäuser",
	"Kegel- u Bowlingbahnen",
	"Kegel- u Bowlingbahnen / Bau u Service",
	"Kehrmaschinen",
	"Keilriemen",
	"Keilriemenscheiben",
	"Keller u Fertigkeller",
	"Kellerbau",
	"Kellereimaschinen u -bedarf",
	"Kellerentfeuchtungsgeräte",
	"Keramik",
	"Keramikbedarf",
	"Kerzen u Wachswaren",
	"Kessel u Kesselbau",
	"Kessel- u Ofenreinigung",
	"Ketten",
	"KFZ-Reparatur",
	"KFZ-Zulassungen",
	"Kinderbekleidung",
	"Kinderbetreuung",
	"Kindergartenbedarf u -einrichtungen",
	"Kinderwagen",
	"Kinderwunschkliniken",
	"Kinesiologie",
	"Kinos",
	"Kirchliche u religiöse Institutionen",
	"Kisten",
	"Kläranlagen",
	"Klassenlotteriegeschäftsstellen",
	"Klaviere",
	"Klaviere / Reparatur",
	"Klaviere / Vermietung",
	"Klavierstimmer",
	"Klebebänder u -rollen",
	"Klebetechnik",
	"Klebstoffe",
	"Kleiderbügel",
	"Kleiderständer",
	"Kleinkläranlagen",
	"Kleintransporte",
	"Klettverschlüsse",
	"Klimaanlagen u -technik",
	"Klimaanlagen u -technik / Service / Reinigung",
	"Klimaanlagenzubehör",
	"Klimageräte",
	"Klischeeanstalten",
	"Klosetts",
	"Klöster, Kirchen, Stifte u Abteien",
	"Knöpfe u Schnallen",
	"Koffer u Taschen",
	"Kohlebürsten",
	"Kohlen, Koks u Brennholz / Großhandel",
	"Kohlen, Koks u Brennholz / Handel",
	"Kohlensäure",
	"Kolben u Kolbenringe",
	"Kommunalfahrzeuge",
	"Komplementäre Medizin",
	"Kompostierung",
	"Kompressoren",
	"Kompressoren / Vermietung",
	"Kondensatoren",
	"Konditoren (Zuckerbäcker)",
	"Konferenzdienste",
	"Kongress- u Seminarausstattung",
	"Konstruktionsbüros",
	"Konsulate",
	"Kontaktlinsen / Erzeugung u Vertrieb",
	"Kontaktlinsenoptiker",
	"Konzertagenturen",
	"Konzertdirektionen",
	"Kopfhörer",
	"Kopierdienste",
	"Kopiergeräte u -zubehör",
	"Korb- u Flechtwaren",
	"Korbmöbel",
	"Korken u Korkwaren",
	"Korrosionsschutz",
	"Kosmetikanwendungsberatung",
	"Kosmetikbedarf",
	"Kosmetikinstitute",
	"Kosmetiksaloneinrichtungen u -geräte",
	"Kosmetikschulen",
	"Kosmetische Produkte / Einzelhandel",
	"Kosmetische Produkte / Erzeugung u Großhandel",
	"Kostüm- u Kleiderverleih",
	"Krane",
	"Kranken- u Patiententransporte",
	"Kranken- Unfall- u Pensionskassen",
	"Krankenbetten",
	"Krankenhäuser u Kliniken",
	"Krankenpflegeartikel",
	"Kranverleih u -arbeiten",
	"Kränze",
	"Kranzschleifen",
	"Kräuter u Kräuterprodukte",
	"Krawatten u Mascherln",
	"Krebs / Hilfe u Beratung",
	"Kreditinstitute",
	"Kreditkartengesellschaften",
	"Kreditvermittler",
	"Kreide",
	"Krematorien",
	"Kristallglas",
	"Kristallluster",
	"Kristallluster / Restaurierung u Reinigung",
	"Küchen",
	"Küchenarbeitsplatten",
	"Küchenentlüftungsanlagen",
	"Küchenrenovierungen",
	"Kugelhähne",
	"Kugellager",
	"Kugelstrahlarbeiten",
	"Kühl- u Tiefkühlschränke",
	"Kühl- u Tiefkühlschränke / Reparatur",
	"Kühlanlagen u -geräte",
	"Kühlanlagen u -geräte / Ersatzteile u Zubehör",
	"Kühlanlagen u -geräte / Reparatur",
	"Kühllagerhäuser",
	"Kühlpulte u -vitrinen",
	"Kühlräume u -zellen",
	"Kühltürme",
	"Kultur- u Sportveranstalter",
	"Kulturvereine",
	"Kunstblumen",
	"Kunstgewerbe",
	"Kunstgießereien",
	"Kunstglasereien",
	"Kunsthandel",
	"Kunstharz",
	"Kunstharzbeschichtungen",
	"Kunstleder",
	"Künstleragenturen",
	"Künstlerbedarf",
	"Kunstmalerei",
	"Kunstschlossereien",
	"Kunstschmieden",
	"Kunstschmiedewaren",
	"Kunststeinarbeiten",
	"Kunststeinwerke",
	"Kunststoffbe- u -verarbeitung",
	"Kunststoffbeschichtungen",
	"Kunststoffe",
	"Kunststofffenster",
	"Kunststoffhalbfabrikate",
	"Kunststoffplatten",
	"Kunststoffrohre",
	"Kunststoffverarbeitungsmaschinen",
	"Kunststoffverpackungen",
	"Kunststoffwaren",
	"Kunststopfereien",
	"Kunsttischlereien",
	"Kupferhalbfabrikate",
	"Kupferschmiede",
	"Kupplungen",
	"Kur- u Erholungsheime / Heilbäder",
	"Kurierdienste",
	"Kürschnereien",
	"Kuvertiermaschinen",
	"Kuverts",
	-- L
	"Laboratorien",
	"Laborbedarf",
	"Laboreinrichtungen u -möbel",
	"Laborgeräte",
	"Laborgeräte / Service",
	"Lackierereien",
	"Ladebordwände",
	"Ladenbau",
	"Lager / Einlagerungen / Lagerräume gewerblich u privat",
	"Lager- u Transportbehälter",
	"Lager- u Transportgeräte",
	"Lagereinrichtungen",
	"Lagerhäuser u -betriebe",
	"Lampen",
	"Lampenschirme",
	"Land- u Panoramakarten",
	"Landesregierungen",
	"Landwirtschaftliche Maschinen u Geräte",
	"Landwirtschaftliche Produkte",
	"Lärmschutz",
	"Laserdrucker",
	"Laserschneiden u -schweißen",
	"Lasertechnik",
	"Lastkraftwagen",
	"Laufhäuser",
	"Lautsprecher u Verstärkeranlagen",
	"Leasing",
	"Lebens- u Sozialberatung",
	"Lebensmittel / Einzelhandel",
	"Lebensmittel / Erzeugung u Großhandel",
	"Lebensmittelmaschinen",
	"Lebensmittelverarbeitung / Grundstoffe",
	"Lebzeltereien",
	"Leckortung",
	"LED-Beleuchtung und- technik",
	"Leder",
	"Lederbekleidung",
	"Lederreinigung",
	"Lederwaren / Einzelhandel",
	"Lederwaren / Erzeugung u Großhandel",
	"Legasthenie-Therapie",
	"Lehmputze",
	"Lehrmittel",
	"Leichtkraftfahrzeuge",
	"Leitern",
	"Lektorate",
	"Lesezirkel",
	"Leuchten",
	"Leuchtschilder u -schriften",
	"Lichtkuppeln",
	"Lichtschranken",
	"Lichttechnik",
	"Lichtwerbung",
	"Liegenschaften / Vermietung",
	"Liftkarniesen",
	"Limousinen",
	"Logistik",
	"Logopädie",
	"Lohnabfüllung u -verpackung",
	"Lohnfertigung",
	"Lötgeräte u -mittel",
	"Lottokollekturen",
	"Luftballons",
	"Luftbefeuchter u -befeuchtungsanlagen",
	"Luftbildaufnahmen",
	"Luftburgen",
	"Luftentfeuchter u -entfeuchtungsanlagen",
	"Luftfilter",
	"Luftfracht",
	"Luftheizungsanlagen u -geräte",
	"Luftreinigung",
	"Lüftungsanlagen u -technik",
	"Luster",
	-- M
	"Magistrate",
	"Magnete",
	"Magnetfeldtherapie",
	"Magnetventile",
	"Mailings",
	"Maler / freischaffende Künstler",
	"Maler, Anstreicher u Lackierer",
	"Malerbedarf u -zubehör",
	"Management",
	"Mannequin- u Modellschulen",
	"Manometer",
	"Marketing",
	"Marketingberatung",
	"Markisen",
	"Markt- u Meinungsforschung",
	"Marmor u Marmorwaren",
	"Maschinenbau",
	"Maschinenbestand- u ersatzteile",
	"Maschinenhandel",
	"Maschinenreparatur",
	"Maschinenvermietung u -verleih",
	"Maßmöbel",
	"Massageapparate u -einrichtungen",
	"Massagen",
	"Massageschulen u -kurse",
	"Maßschuhe",
	"Massivhäuser",
	"Maste",
	"Matratzen",
	"Matratzenreinigung",
	"Matten u Mattenvermietung",
	"Maturaschulen",
	"Mauertrockenlegungen",
	"Mautstraßen",
	"Mechanische Werkstätten",
	"Medaillen",
	"Mediaagenturen",
	"Mediation",
	"Medienbeobachtung",
	"Meditation",
	"Medizinische Apparate u Geräte",
	"Medizinische Beratung",
	"Medizinische Institute",
	"Medizinischer Bedarf",
	"Medizintechnik",
	"Mentaltraining",
	"Mess- u Prüftechnik",
	"Mess-, Steuer- u Regeltechnik",
	"Messe- u Ausstellungsbau u -gestaltung",
	"Messen u Ausstellungen",
	"Messer",
	"Messerschleifereien",
	"Messerschmiede",
	"Messerschmiedewaren",
	"Messgeräte",
	"Messingsonderanfertigungen",
	"Metallbau",
	"Metallbe- u -verarbeitung",
	"Metallbearbeitungsmaschinen u -werkzeuge",
	"Metalldrückereien u -pressereien",
	"Metalle u -halbfabrikate",
	"Metallsuchgeräte",
	"Metalltechniker / Metallbearbeitungstechniker",
	"Metallveredelung",
	"Metallwaren / Einzelhandel",
	"Metallwaren / Erzeugung u Großhandel",
	"Mieder u Miederwaren",
	"Mietautos",
	"Mietwäsche",
	"Mikrofilme",
	"Mikrofilmgeräte u -materialien",
	"Mikrofone u Mikrofonanlagen",
	"Mikroskope",
	"Mikrowellenherde",
	"Mineralien",
	"Mineralöle",
	"Mineralölprodukte",
	"Minigolfanlagen u -bedarf",
	"Möbel / Einzelhandel",
	"Möbel / Erzeugung u Großhandel",
	"Möbel / Vermietung",
	"Möbelstoffe",
	"Möbeltransporte",
	"Mobile Services / SMS",
	"Mobiltelefone u -zubehör",
	"Modellagenturen",
	"Modellbahnen",
	"Modellbau",
	"Modellbauwerkstätten",
	"Modeschmuck / Accessoires",
	"Modisten",
	"Molkereien u Molkereiprodukte",
	"Montagen u Montagetechnik",
	"Mopeds u Mopedautos",
	"Mosaik",
	"Mostschenken",
	"Motor-Tuning",
	"Motorboote",
	"Motorbootfahrschulen",
	"Motoren",
	"Motorenbestandteile u -material",
	"Motoreninstandsetzung",
	"Motorradbedarf u -zubehör",
	"Motorradbekleidung",
	"Motorräder / Reparatur",
	"Motorräder / Vermietung",
	"Motorräder u -roller",
	"Motorsägen u -zubehör",
	"Motorsport",
	"Mühlen",
	"Mühlenbau u -einrichtungen",
	"Mulden",
	"Müllabfuhr",
	"Mülldeponien",
	"Müllverdichter u -pressen",
	"Multimedia",
	"Münzen",
	"Museen / Ausstellungen",
	"Musikagenturen",
	"Musikalien",
	"Musikanlagen u -vermietung",
	"Musikgruppen",
	"Musikinstrumente u -zubehör",
	"Musiktherapie",
	"Musikunterricht",
	"Musikvereinigungen",
	"Musikverlage",
	"Musterkarten",
	-- N
	-- O
	-- P
	-- Q
	-- R
	-- S
	-- T	
	-- U
	-- V
	-- W
	-- X
	-- Y
	-- Z
}

-- Script magic
local http = require("socket.http") --load luasocket library

-- Greet the user with the available options
local input
io.write("Options:")
io.write("\nType in the keyword as provided")
io.write("\nfetch -> fetch data and outputs it to an excell file, then exit")
io.write("\nabort -> exit this script")
io.write("\n>")

input = io.read()
if input == "fetch" then
	local body,c,l,h = http.request(url)
--	if string.find(body, "branche") then
--		print("branche found")
--	else
--		print("error")
--	end
--	print(body)
	for placeNum, placeName in pairs(places) do
		for k, v in ipairs(branch) do
			--print(k.." "..v)
			local rawbranch = string.gsub(v, " ", "-") --replace empty space with minus
			--fix for string.lower not working on Umlauts
			local rawbranch2 = string.gsub(rawbranch, "Ä", "ä")
			local rawbranch3 = string.gsub(rawbranch2, "Ö", "ö")
			local rawbranch4 = string.gsub(rawbranch3, "Ü", "ü")
			--remove slashes 
			local rawbranch5 = string.gsub(rawbranch4, "-/", "")
			local formattedbranch = string.gsub(rawbranch5, "/", "-")
			
			local tempurl = url..placeName.."/"..string.lower(formattedbranch)
			print(placeName..": "..k.." "..tempurl)

			--print(place_name..": "..k.." "..formattedbranch)
		end
	end
elseif input == "abort" then
	print("bye bye")
else
	print("Wrong keyword: ["..input.."], exiting now")
end




