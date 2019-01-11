<?xml version="1.0" encoding="UTF-8"?>
<!--
    Converts old-style links to thumbnails to new-style api links. Does not take into account whether link exists or not. Call with no parameters
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:geonet="http://www.fao.org/geonetwork" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:gmd="http://www.isotc211.org/2005/gmd" version="1.0">


    <!-- Remove geonet:* elements. -->
    <xsl:template match="geonet:*" priority="2"/>

    <!-- Replace in gmd:URL (uploaded document) 
        or gco:CharacterString (eg. resource identifier may be based on host name) -->
    <xsl:template match="*/gmd:graphicOverview/gmd:MD_BrowseGraphic/gmd:fileName">

        <xsl:variable name="url"> 
            <xsl:value-of select="./gco:CharacterString"/>
        </xsl:variable>
        <xsl:message>url: <xsl:value-of select="$url" /></xsl:message>
        <!-- If the URL is already a new-style one don't apply the fix -->
        <xsl:choose>
        <xsl:when test="not(contains($url,'api'))">
        <xsl:variable name="urlroot">
            <xsl:choose>
                <xsl:when test="not(substring-before(substring-after($url,'://'),':'))">
                    <xsl:value-of select="substring-before(substring-after($url,'://'),'/geonetwork')"/>
                </xsl:when>
                <xsl:when test="substring-before(substring-after($url,'://'),':')">
                    <xsl:value-of select="substring-before(substring-after($url,'://'),':')"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="node">
            <xsl:value-of select="substring-before(substring-after(substring-after($url,'://'),'geonetwork/'),'/eng')"/>
        </xsl:variable>
        <xsl:variable name='uuid'>
         <xsl:value-of select="substring-before(substring-after($url,'resources.get?uuid='),'&amp;')"/>
     </xsl:variable>
        <xsl:variable name='fname'>
        <xsl:value-of select="substring-after($url,'fname=')"/>
    </xsl:variable>
        <xsl:variable name="newurl">
        <xsl:value-of select="concat('https://',$urlroot,'/geonetwork/',$node,'/api/records/',$uuid,'/attachments/',$fname)"/>
    </xsl:variable>
        <xsl:message>urlroot: <xsl:value-of select="$urlroot" /></xsl:message>
        <xsl:message>node: <xsl:value-of select="$node" /></xsl:message>
        <xsl:message>uuid: <xsl:value-of select="$uuid" /></xsl:message>
        <xsl:message>fname: <xsl:value-of select="$fname" /></xsl:message>
        <xsl:message>newurl: <xsl:value-of select="$newurl" /></xsl:message>
        <gmd:fileName>
            <gco:CharacterString>
            <xsl:value-of select="$newurl"/>
        </gco:CharacterString>
        </gmd:fileName>
    </xsl:when>
            <xsl:otherwise>
                <gmd:fileName>
                    <gco:CharacterString>
                        <xsl:value-of select="$url"/>
                    </gco:CharacterString>
                </gmd:fileName>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

        <!-- Do a copy of every node and attributes -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
