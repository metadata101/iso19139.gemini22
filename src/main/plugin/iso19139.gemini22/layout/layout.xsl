<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gts="http://www.isotc211.org/2005/gts"
  xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmx="http://www.isotc211.org/2005/gmx"
  xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:gn="http://www.fao.org/geonetwork"
  xmlns:gn-fn-core="http://geonetwork-opensource.org/xsl/functions/core"
  xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
  xmlns:gn-fn-iso19139="http://geonetwork-opensource.org/xsl/functions/profiles/iso19139"
  xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="#all">

  <xsl:include href="layout-custom-fields.xsl"/>
  <xsl:include href="utility-tpl.xsl"/>

  <xsl:template mode="mode-iso19139" priority="30000" match="*[*/@codeList and name()!='gmd:dateType' and $schema='iso19139.gemini22']">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>
    <xsl:param name="codelists" select="$codelists" required="no"/>


    <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(.)"/>
    <xsl:variable name="isoType" select="if (../@gco:isoType) then ../@gco:isoType else ''"/>
    <xsl:variable name="elementName" select="name()"/>

		<!-- check iso19139.gemini22 first, then fall back to iso19139 -->
		<xsl:variable name="listOfValues" as="node()">
			<xsl:variable name="gemini22List" as="node()" select="gn-fn-metadata:getCodeListValues($schema, name(*[@codeListValue]), $codelists, .)"/>
			<xsl:choose>
				<xsl:when test="count($gemini22List/*)=0"> <!-- do iso19139 -->
					<xsl:copy-of select="gn-fn-metadata:getCodeListValues('iso19139', name(*[@codeListValue]), $iso19139codelists, .)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="$gemini22List"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

    <xsl:call-template name="render-element">
      <xsl:with-param name="label"
        select="gn-fn-metadata:getLabel($schema, name(), $labels, name(..), $isoType, $xpath)"/>
      <xsl:with-param name="value" select="*/@codeListValue"/>
      <xsl:with-param name="cls" select="local-name()"/>
      <xsl:with-param name="xpath" select="$xpath"/>
      <xsl:with-param name="type" select="gn-fn-iso19139:getCodeListType(name())"/>
      <xsl:with-param name="name"
        select="if ($isEditing) then concat(*/gn:element/@ref, '_codeListValue') else ''"/>
      <xsl:with-param name="editInfo" select="*/gn:element"/>
      <xsl:with-param name="parentEditInfo" select="gn:element"/>
      <xsl:with-param name="listOfValues" select="$listOfValues"/>
      <xsl:with-param name="isFirst" select="count(preceding-sibling::*[name() = $elementName]) = 0"/>
    </xsl:call-template>

  </xsl:template>
<<<<<<< HEAD
=======

	<!--
    Take care of enumerations. Same as for codelists, check iso19139.gemini22
		first and if not found there, then check iso19139.

    In the metadocument an enumeration provide the list of possible values:
  <gmd:topicCategory>
    <gmd:MD_TopicCategoryCode>
    <geonet:element ref="69" parent="68" uuid="gmd:MD_TopicCategoryCode_0073afa8-bc8f-4c52-94f3-28d3aa686772" min="1" max="1">
      <geonet:text value="farming"/>
      <geonet:text value="biota"/>
      <geonet:text value="boundaries"/
  -->
  <xsl:template mode="mode-iso19139" priority="30000" match="*[gn:element/gn:text and $schema='iso19139.gemini22']">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>
    <xsl:param name="codelists" select="$iso19139.gemini22codelists" required="no"/>

		<!-- check iso19139.gemini22 first, then fall back to iso19139 -->
		<xsl:variable name="listOfValues" as="node()">
			<xsl:variable name="gemini22List" as="node()" select="gn-fn-metadata:getCodeListValues($schema, name(), $codelists, .)"/>
			<xsl:choose>
				<xsl:when test="count($gemini22List/*)=0"> <!-- do iso19139 -->
					<xsl:copy-of select="gn-fn-metadata:getCodeListValues('iso19139', name(), $iso19139codelists, .)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="$gemini22List"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

    <xsl:call-template name="render-element">
      <xsl:with-param name="label"
        select="gn-fn-metadata:getLabel($schema, name(..), $labels, name(../..), '', '')/label"/>
      <xsl:with-param name="value" select="text()"/>
      <xsl:with-param name="cls" select="local-name()"/>
      <xsl:with-param name="type" select="gn-fn-iso19139:getCodeListType(name())"/>
      <xsl:with-param name="name" select="gn:element/@ref"/>
      <xsl:with-param name="editInfo" select="*/gn:element"/>
      <xsl:with-param name="listOfValues" select="$listOfValues"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Rendering date type as a dropdown to select type
  and the calendar next to it.
  -->
  <xsl:template mode="mode-iso19139" priority="2000" match="gmd:CI_Date/gmd:date[$schema='iso19139.gemini22']">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>
    <xsl:param name="codelists" select="$iso19139.gemini22codelists" required="no"/>

    <xsl:variable name="labelConfig"
                  select="gn-fn-metadata:getLabel($schema, name(), $labels)"/>

    <xsl:variable name="dateTypeElementRef"
                  select="../gn:element/@ref"/>

		<!-- check iso19139.mcp first, then fall back to iso19139 -->
		<xsl:variable name="listOfValues" as="node()">
			<xsl:variable name="gemini22List" as="node()" select="gn-fn-metadata:getCodeListValues($schema, 'gmd:CI_DateTypeCode', $codelists, .)"/>
			<xsl:choose>
				<xsl:when test="count($gemini22List/*)=0"> <!-- do iso19139 -->
					<xsl:copy-of select="gn-fn-metadata:getCodeListValues('iso19139', 'gmd:CI_DateTypeCode', $iso19139codelists, .)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="$gemini22List"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

    <div class="form-group gn-field gn-title gn-required"
         id="gn-el-{$dateTypeElementRef}"
         data-gn-field-highlight="">
      <label class="col-sm-2 control-label">
        <xsl:value-of select="$labelConfig/label"/>
      </label>
      <div class="col-sm-3 gn-value">
        <xsl:call-template name="render-codelist-as-select">
          <xsl:with-param name="listOfValues" select="$listOfValues"/>
          <xsl:with-param name="lang" select="$lang"/>
          <xsl:with-param name="isDisabled" select="ancestor-or-self::node()[@xlink:href]"/>
          <xsl:with-param name="elementRef" select="../gmd:dateType/gmd:CI_DateTypeCode/gn:element/@ref"/>
          <xsl:with-param name="isRequired" select="true()"/>
          <xsl:with-param name="hidden" select="false()"/>
          <xsl:with-param name="valueToEdit" select="../gmd:dateType/gmd:CI_DateTypeCode/@codeListValue"/>
          <xsl:with-param name="name" select="concat(../gmd:dateType/gmd:CI_DateTypeCode/gn:element/@ref, '_codeListValue')"/>
        </xsl:call-template>


        <xsl:call-template name="render-form-field-control-move">
          <xsl:with-param name="elementEditInfo" select="../../gn:element"/>
          <xsl:with-param name="domeElementToMoveRef" select="$dateTypeElementRef"/>
        </xsl:call-template>
      </div>
      <div class="col-sm-6 gn-value">
        <div data-gn-date-picker="{gco:Date|gco:DateTime}"
             data-label=""
             data-element-name="{name(gco:Date|gco:DateTime)}"
             data-element-ref="{concat('_X', gn:element/@ref)}">
        </div>


        <!-- Create form for all existing attribute (not in gn namespace)
         and all non existing attributes not already present. -->
        <div class="well well-sm gn-attr {if ($isDisplayingAttributes) then '' else 'hidden'}">
          <xsl:apply-templates mode="render-for-field-for-attribute"
                               select="
            ../../@*|
            ../../gn:attribute[not(@name = parent::node()/@*/name())]">
            <xsl:with-param name="ref" select="../../gn:element/@ref"/>
            <xsl:with-param name="insertRef" select="../gn:element/@ref"/>
          </xsl:apply-templates>
        </div>
      </div>
      <div class="col-sm-1 gn-control">
        <xsl:call-template name="render-form-field-control-remove">
          <xsl:with-param name="editInfo" select="../gn:element"/>
          <xsl:with-param name="parentEditInfo" select="../../gn:element"/>
        </xsl:call-template>
      </div>
    </div>
  </xsl:template>

  <xsl:template mode="mode-iso19139"
                match="gmd:topicCategory[1]"
                priority="2100">

    <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(.)"/>
    <xsl:variable name="isoType" select="if (../@gco:isoType) then ../@gco:isoType else ''"/>
    <xsl:variable name="labelConfig" select="gn-fn-metadata:getLabel($schema, name(), $labels, name(..), $isoType, $xpath)"/>


    <xsl:variable name="elementName" select="name()" />

    <xsl:variable name="topicCategories">
      <xsl:for-each select="../*[name() = $elementName]">
        <xsl:value-of select="gmd:MD_TopicCategoryCode/text()" />
        <xsl:if test="position() != last()">,</xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:call-template name="render-element">
      <xsl:with-param name="label"
                      select="$labelConfig"/>
      <xsl:with-param name="value" select="$topicCategories"/>
      <xsl:with-param name="cls" select="local-name()"/>
      <xsl:with-param name="xpath" select="$xpath"/>
      <xsl:with-param name="directive" select="'gn-topiccategory-selector'"/>
      <xsl:with-param name="editInfo" select="gn:element"/>
      <xsl:with-param name="parentEditInfo" select="../gn:element"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Ignore the following topic categories-->
  <xsl:template mode="mode-iso19139"
                match="gmd:topicCategory[
                        preceding-sibling::*[1]/name() = name()]|gn:child[@name = 'topicCategory']"
                priority="2100"/>

  <!-- Template to don't display online resources in editor form. Commented as current support to edit
       online resources after adding them in the right side panel is not powerful enough unless displayed
       the elements in the editor.
  -->
  <!--<xsl:template mode="mode-iso19139" priority="30000" match="//gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine" />-->
>>>>>>> eacadce... Fixes for topic category validation issue
</xsl:stylesheet>
