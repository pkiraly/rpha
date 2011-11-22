<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<p><b>v165</b> - A vers adatlapjának belső hivatkozása (<b>BELSŐ CF.</b>). Míg 
a CF. ENCORE rovat azt a célt szolgálta, hogy a vers adatai mellett jelenjenek 
meg más adatlapokra történő hivatkozások is, ez a rovat arra való, hogy a vers 
adatlapja kapcsolódjon más adatlapokhoz, de a megjelenítésnél ez a hivatkozás 
ne jelenjen meg. Például egy metrumváltó vers különböző metrumait csak külön 
adatlapokon tudjuk tárolni. Ilyenkor a főlapon (RECTYP=0) a metrumtípusnál az 
áll, hogy a vers metrumváltó (Typme=15), és a BELSŐ CF. rovat mutatja meg, 
hogy hány és milyen azonosítójú mellékadatlap (RECTYP=6) kapcsolódik a vershez, 
amelyeken az egyes metrumok vannak feltüntetve. Hasonló módon történik a 
váltakozó nótajelzések adatainak tárolása is. Ezekről az esetekről a
mellékadatlapok leírásánál (v91, RECTYP=6, RECTYP=8) volt szó részletesebben. 
A rovat ismételhető, hossza 200 betűhelynyi.</p>