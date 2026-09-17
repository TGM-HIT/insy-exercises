```mysql
#Was ist das kürzeste SQL auf eine Tabelle? * steht als Platzhalter für alle Spalten
SELECT * FROM planes;

#Statt dem * können auch nur bestimmte Spalten ausgegeben werden.
SELECT manufacturer, type FROM planes

#Ist SQL Case-Sensitive?
#Befehle nicht, Tabellennamen, Spaltennamen, Werte schon
#Befehle zur übersichtlichkeit CAPS
SELECT * FROM planes

#Wie können Werte gefiltert werden?
SELECT * FROM planes WHERE id >= 50
SELECT * FROM planes WHERE manufacturer='Airbus'

#Wie filtern wir leere Werte/Zellen?
SELECT * FROM `planes` WHERE maxspeed IS  NULL
SELECT * FROM `planes` WHERE maxspeed IS NOT NULL

#Gib alle Flugzeuge aus mit einer Maxspeed zwischen 400 und 500.
SELECT * FROM `planes` WHERE maxspeed > 400 AND maxspeed < 500
SELECT * FROM `planes` WHERE maxspeed BETWEEN 400 AND 500

#Gib alle Flugzeuge aus mit einer Maxspeed kleiner als 400 oder größer 500.
SELECT * FROM `planes` WHERE maxspeed < 400 OR maxspeed > 500

#Gib alle Airbus oder Boeing Flugzeuge aus mit einer Maxspeed kleiner als 500.
#Berechnungen können im SELECT durchgeführt werden.
#AS lässt Spalten umbenennen.
SELECT *, 500-maxspeed AS Differenz FROM `planes` WHERE maxspeed < 500 AND (manufacturer='Airbus' OR manufacturer='Boeing')

#Gib alle Flugzeuge aus von einem Hersteller der mit B beginnt.
#% wildcard für beliebig viele beliebige Zeichen
#_ ein beliebiges Zeichen
SELECT * FROM planes WHERE manufacturer LIKE 'B%'

#Wie viele Einträge hat diese Tabelle?
SELECT COUNT(*) FROM planes
```

