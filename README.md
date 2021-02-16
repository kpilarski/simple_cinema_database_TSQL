### Koncepcja projektu 

Przedstawiona baza danych umożliwia tworzenie zbiorów danych związanych z funkcjonowaniem prostego kina. Pozwala ona potencjalnemu klientowi na zakup biletu na wybrany seans filmowy. Każdy seans charakteryzuje się konkretnym filmem, salą w jakiej jest wyświetlany oraz konkretną datą w jakiej odbywa się dany seans. Klient kupując bilet na wybrany seans może wybrać miejsce siedzące w jakim chce usiąść (na jedno miejsce składa się kombinacja danego rzędu oraz numeru fotela). Klient szukając seansu, na który chciałby się wybrać, może również wyszukiwać interesujący go film nie tylko po samym tytule, ale również po ulubionych aktorach, reżyserach czy też gatunkach filmowych. Trzy powyższe informacje są mu udostępniane, dzięki czemu klient może filtrować interesujące go seanse, nie znając konkretnych filmów, posiadając natomiast preferencje dotyczące gatunków, ulubionych aktorów czy też reżyserów. 
Po znalezieniu interesującego go filmu, potencjalny nabywca naszej usługi otrzymuje informacje takie jak język filmu, dostępność napisów, ograniczenia wiekowe, kraj produkcji czy też czas trwania. Kupując bilet klient jest zobowiązany do wprowadzenia przynajmniej trzech informacji: imienia, nazwiska oraz daty urodzenia.


#### Ogólne założenia dotyczące bazy:

-  Konieczność podania przynajmniej podstawowych danych osobowych przez klienta chcącego zakupić bilet na wybrany seans (imię, nazwisko, data urodzenia).
-  Każda sala znajdująca się w kinie jest tej samej wielkości (rząd * fotel)-  Bilet na wybrany seans musi być zapłacony z góry, dlatego też nie ma możliwości „rezerwacji” miejsca. Nie znajdziemy poprzez to również informacji o statusie biletu.

#### Dostęp do informacji:

-  Klient ma możliwość dostępu do informacji na temat filmu takich jak: język filmu, czas trwania, ograniczenia wiekowe, dostępność napisów, gatunek filmu, przejrzenie dorobku reżysera danego filmu, przejrzenie historii występów aktorów występujących w filmie.
-  Dla strony obsługi technicznej kina, baza umożliwia dostęp do wszechstronnych informacji zarówno od strony biznesowej, jak i technicznej kina.

    - Strona biznesowa: preferencje klientów (jakie seanse, kiedy oraz w jakich   porach, w jakich miejscach w sali)

    - Strona techniczna: dostępność miejsca na dane seanse, informacje na temat biletów oraz samych seansów, wyświetlanie filmów oraz powiązań jakie mu towarzyszą.

#### Diagram przedstawiający omawianą bazę danych:

![schema_postgres_database](static_files/database_schema.PNG)