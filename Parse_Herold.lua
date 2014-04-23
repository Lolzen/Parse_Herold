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
	-- C
	-- D
	-- E
	-- F
	-- G
	-- H
	-- I
	-- J
	-- K
	-- L
	-- M
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
	for placeNum, place_name in pairs(places) do
		for k, v in ipairs(branch) do
			--print(k.." "..v)
			local rawbranch = string.gsub(v, " ", "-") --replace empty space with minus
			--fix for string.lower not working on Umlauts
			local rawbranch2 = string.gsub(rawbranch, "Ä", "ä")
			local rawbranch3 = string.gsub(rawbranch2, "Ö", "ö")
			local rawbranch4 = string.gsub(rawbranch3, "Ü", "ü")
			local formattedbranch = string.gsub(rawbranch4, "-/", "") --remove slashes 
			
			local tempurl = url..place_name.."/"..string.lower(formattedbranch)
			print(place_name..": "..k.." "..tempurl)

			--print(place_name..": "..k.." "..formattedbranch)
		end
	end
elseif input == "abort" then
	print("bye bye")
else
	print("Wrong keyword: ["..input.."], exiting now")
end




