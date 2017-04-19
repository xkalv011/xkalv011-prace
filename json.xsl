<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text"/>                               <!-- definuje se o jaký výstup se jedná, může být i html -->
  <xsl:template match="/">
      [
	  <!--Vypsání základních informací o aplikaci-->
      <xsl:for-each select="knihovna/konfigurace">
        {
        "Kódování": "<xsl:value-of select="coding"/>",
		"Verze aplikace": "<xsl:value-of select="aplication_version"/>",
		"Název aplikace": "<xsl:value-of select="aplication_name"/>",
		"Autor aplikace": "<xsl:value-of select="autor_aplikace"/>",
		"Kontakt": "<xsl:value-of select="kontakt_mail"/>"
        }
      </xsl:for-each>
	  
      <!--Vypsání všech knih-->
      <xsl:for-each select="knihovna/kniha">
        {                                                    <!-- tyto závorky říkají, že se jedná o JSON, kdyby se jednalo o html tak by se místo toho mohlo dát třeba <p> -->
         "ID:" "<xsl:value-of select="@id"/>",               <!-- @ znamená se že jedná o atribut -->
		 "Typ literatury:" "<xsl:value-of select="@druh"/>",
		 "Název knihy": "<xsl:value-of select="nazev_knihy"/>",
		 <xsl:for-each select="knihovna/kniha/autor">
			{
			"Jmeno:" "<xsl:value-of select="jmeno"/>",
			"Prijmeni:" "<xsl:value-of select="prijmeni"/>"
			}<xsl:if test="position() != last()">,</xsl:if>     
		</xsl:for-each>
			"Rok vydání:" "<xsl:value-of select="rok_vydani"/>",
			"Stav zboží:" "<xsl:value-of select="stav"/>",
        }<xsl:if test="position() != last()">,</xsl:if>      <!-- řeší problém s  čárkou -->
      </xsl:for-each>
      
	  <!--Vypsání názvů knih seřazených dle ceny-->
      <xsl:for-each select="knihovna/kniha">
        <xsl:sort select="cena" order ="descending"/>     <!-- řazení dle ceny -->
        {                                                               
			"ID:" "<xsl:value-of select="@id"/>",               
			"Název knihy": "<xsl:value-of select="nazev_knihy"/>",
        }<xsl:if test="position() != last()">,</xsl:if>     
      </xsl:for-each>
      
	  <!--Vypsání knih, které jsou napsány v anglickém jazyce-->
      <xsl:for-each select="knihovna/kniha[jazyk_knihy = EN]">   <!-- Vložená podmínka -->
        {                                                               
         "ID:" "<xsl:value-of select="@id"/>",               
         "Jmeno:" "<xsl:value-of select="jmeno"/>",
         "Prijmeni:" "<xsl:value-of select="prijmeni"/>",
         "Ulice:" "<xsl:value-of select="adresa/ulice"/>"
        }<xsl:if test="position() != last()">,</xsl:if>    
      </xsl:for-each>
      ]
      
  </xsl:template>
</xsl:stylesheet>
