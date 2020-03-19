<xsl:stylesheet version="2.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:gn="http://www.fao.org/geonetwork"
                xmlns:gml="http://www.opengis.net/gml/3.2"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                exclude-result-prefixes="#all">

    <xsl:import href="../../iso19139.gemini23/convert/xml_gemini22gemini23.xsl"/>

    <!-- Remove geonet:* elements. -->
    <xsl:template match="gn:*" priority="2"/>

</xsl:stylesheet>