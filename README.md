A régi magyar versek repertóriuma Java alapú webalkalmazása
===

Az alkalmazás két fő összetevőn alapul: Jakarta Struts (1.2.9 változat) és az Apache Lucene (2.3.2 változat) könyvtárakon. A Struts az alkalmazás belső logikáját határozza meg, a Lucene az adatok tárolásáért és visszakeresésért felelős. Az alkalmazás fejlesztésekor az `src` és `web` könyvtárakat kell figyelembe venni. Az előbbi az alkalmazást működtető  osztályokat tartalmazza, az utóbbi elsősorban a webes megjelenítést.

Az alkalmazás működését elsősorban a `web/WEB-INF/struts-config.xml` fájl írja le. A bejövő adatok úgynevezett Form Beaneket inicializálnak. Az Action osztályok innen veszik az adatokat (pl. egy keresőkérdést) és feldolgozás után ide is írják vissza azokat. A webes `.jsp` (Java Servlet Pages) oldalak pedig a Form Beanekben levő adatokat írják ki a 
felhasználó számára.

Például:

	<form-bean name="searchForm" type="com.kirunews.rpha.struts.form.SearchForm" />

ez a searchForm-nevű formhoz a com.kirunews.rpha.struts.form.SearchForm osztályt rendeli, amit a
src/com/kirunews/rpha/struts/form/SearchForm.java fájlban definiáltunk.

	<action attribute="searchForm" input="/form/search.jsp"
		name="searchForm" path="/search" scope="request"
		type="com.kirunews.rpha.struts.action.SearchAction">
		<forward name="xml"  path="/form/searchXml.jsp"/>
		<forward name="html" path="/form/searchHtml.jsp"/>
		<forward name="book" path="/form/bookList.jsp"/>
		<forward name="search-advanced" path="/form/search-advanced.jsp"/>
		<forward name="search-rpha5"  path="/form/search-rpha5.jsp"/>
		<forward name="default" path="/form/search.jsp"/>
	</action>

Az fenti Form Beant a `com.kirunews.rpha.struts.action.SearchAction` osztály (lásd `src/com/kirunews/rpha/struts/action/SearchAction.java` fájl) dolgozza fel, aminek a kimenetét (egyéb paraméterek figyelembevételével) a `web/form/searchXml.jsp`, a `web/form/searchHtml.jsp` stb. JSP oldalak írják ki.

Az `src/com/kirunews/rpha` könyvtárban a form beanek és action osztályokon kívül a model könyvtár található, ami az adatok elérésével kapcsolatos osztályokat tartalmazza, például a könyvek listáját, vagy a keresést. A `struts` könyvtárban található az `InitializeServlet.java`, ami egy, az alkalmazás elindulásakor automatikusan meghívott osztály tartalmaz, ami beolvassa azokat a statikus változókat (konfigurációs fájl értékeit), ami az alkalmazás futtatásához szükséges. Valamint itt találhatóak a nyelvi fájlok, melyek segítségével előáll a felület francia, magyar vagy angol nyelvű változata (`src/com/kirunews/rpha/struts/ApplicationResources.properties`).

Az RPHA mögött nem relációs adatbázis, hanem egy Apache Lucene index van. Az indexben szereplő rekordoknak (a Lucene szóhasználatával dokumentumoknak) típusuk van, és a keresés során a Lucene API-jával tulajdonképpen az SQL "join" utasítását próbáljuk megvalósítani. Az index importálható/exportálható XML-be. Az alap XML szerkezet az ISIS-ben elkészített adatbázis exportjából született, de az idők során a szerkesztők módosították az adatokat. Az alkalmazás része egy parancssori export/import funkcionalitás, illetve az index optimalizálása. A Lucene verziója elég régi, 2.3.2, az alkalmazás készítése idején ez volt az aktuális verzió.

A keresés során az alkalmazás a Lucene találati listából egy ad-hoc XML-t képez, amit a weboldalon XSLT segítségével jelenít meg (az XSLT transzformáció szerver oldalon zajlik, vagyis a böngésző már egy HTML kódot kap). Az XSLT állományok a `web/xslt` könyvtárban találhatóak.

A lefordított alkalmazás könyvtárszerkezete
===

* `config`: az XML import/export fájlok helye
** `config/xslt`: az XSLT fájlok helye, ezek gondoskodnak a megjelenésről
* `index`: az Apache Lucene index könyvtára
* `log`: az alkalmazás naplófájljai
* `tomcat`: 5.5-ös Apache Tomcat szerver. (Az alábbiakban csak a fontosabb fájlokat/könyvtárakat emelem ki)
** `tomcat/bin`: indító scriptek
** `tomcat/common/classes/rpha.properties`: az RPHA alkalmazás alapvető könyvtárbeállításai (a fent felsorolt config, index és log könyvtárakat lehet itt megadni):
** `tomcat/conf/tomcat-users.xml`: itt lehet beállítani a szerkesztők jelszavát
** `tomcat/webapps/rpha`: maga az alkalmazás
** `tomcat/webapps/rpha/WEB-INF`: ez azért fontos könyvtár, mert innen lehet elindítani néhány parancssori műveletet. Ezekhez az Apache Ant szükséges, amit Ubuntun "sudo apt-get install ant" paranccsal lehet telepíteni. (A fontosabb parancsokat lásd alább.)

Példa a `tomcat/common/classes/rpha.properties` fájlra:

	rpha.configDir    = /var/rpha/config
	rpha.indexDir     = /var/rpha/index
	rpha.logDir       = /var/rpha/log

Parancssori utasítások
===
indítás:

	/var/rpha/tomcat/bin/catalina.sh start

leállítás:

	/var/rpha/tomcat/bin/catalina.sh stop

Ant parancsok (a tomcat/webapps/rpha/WEB-INF könyvtárból adjuk ki)

a parancsok listája

	ant -f util.xml -p

az adatbázis XML exportja (az eredménye a config könyvtárba írt export.YYYY.MM.DD.HH.mm.xml nevű fájl, ahol a betűk helyére az aktuális év, hónap, nap, óra, perc értékei helyettesítódnek, pl. export.2013.09.10.22.52.xml)

	ant -f util.xml export

az adatbázist XML importja (Vigyázat! Az import újragenerálja a teljes adatbázist minden korábbi rekordot törölve.)

	ant -f util.xml import -DimportFile=[file]

Lucene index optimalizálása

	ant -f util.xml optimize

Bármilyen kérdésre szívesen válaszolok: kirunews _ gmail _ com
