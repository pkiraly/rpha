A régi magyar versek repertóriuma Java alapú webalkalmazása

Az alkalmazás két fő összetevőn alapul: Jakarta Struts (1.2.9 változat) és az Apache Lucene (2.3.2 változat) könyvtárakon.
A Struts az alkalmazás belső logikáját határozza meg, a Lucene az adatok tárolásáért és visszakeresésért felelős.
Az alkalmazás fejlesztéséért az src és web könyvtárakat kell figyelembe venni. Az előbbi az alkalmazást működtető 
osztályokat tartalmazza, az utóbbi elsősorban a webes megjelenítést.

Az alkalmazás működését elsősorban a web/WEB-INF/struts-config.xml írja le. A bejövő adatok úgynevezett Form Beaneket
inicializálnak. Az Action osztályok innen veszik az adatokat (pl. egy keresőkérdést) és feldolgozás után ide is 
írják vissza azokat. A webes .jsp (Java Servlet Pages) oldalak pedig a Form Beanekben levő adatokat írják ki a 
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

Az fenti Form Beant a com.kirunews.rpha.struts.action.SearchAction osztály (lásd src/com/kirunews/rpha/struts/action
/SearchAction.java fájl) dolgozza fel, aminek a kimenetét (egyéb paraméterek figyelembevételével) a web/form/searchXml.jsp, 
a web/form/searchHtml.jsp stb. JSP oldalak írják ki.

Az src/com/kirunews/rpha könyvtárban a form beanek és action osztályokon kívül a model könyvtár található, ami
az adatok elérésével kapcsolatos osztályokat tartalmazza, például a könyvek listáját, vagy a keresést. A struts könyvtárban
található az InitializeServlet.java, ami egy, az alkalmazás elindulásakor automatikusan meghívott osztály tartalmaz, ami
beolvassa azokat a statikus változókat (konfigurációs fájl értékeit), ami az alkalmazás futtatásához szükséges. Valamit
itt találhatóak a nyelvi fájlok, melyek segítségével előáll a felület francia, magyar vagy angol nyelvű változata 
(src/com/kirunews/rpha/struts/ApplicationResources.properties).

Az alkalmazás általában XSLT segítségével formázza a Lucene-ből kinyert XML adatokat. Az XSLT állományok a web/xslt 
könyvtárban találhatóak.

Bármilyen kérdésre szívesen válaszolok: kirunews _ gmail _ com
