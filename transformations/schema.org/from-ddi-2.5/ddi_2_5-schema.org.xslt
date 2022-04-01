<?xml version="1.0" encoding="UTF-8"?>
<!--
Description:
XSLT Stylesheet for conversion between DDI-C version 2.5 and dc/schema.org

This file is free software: you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation, either
version 3 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library.  If not, see <http://www.gnu.org/licenses/>.

-->
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:meta="transformation:metadata"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
  xmlns:schema="http://schema.org/"
  xmlns:c="ddi:codebook:2_5"
  xsi:schemaLocation="ddi:codebook:2_5 http://www.ddialliance.org/Specification/DDI-Codebook/2.5/XMLSchema/codebook.xsd"

  exclude-result-prefixes="#all"
  version="2.0">

  <meta:metadata>
    <identifier>ddi-2.5-to-schema.org</identifier>
    <title>DDI 2.5 to schema.org (RDF/XML)</title>
    <description>Convert DDI Codebook (2.5) to Schema.org in RDF/XML format</description>
    <outputFormat>XML</outputFormat>
    <parameters/>
  </meta:metadata>

  <xsl:output method="xml" indent="yes" />
  <xsl:param name="main-root" select="/c:codeBook/c:stdyDscr"/>
  
  <xsl:template match="/">
    <rdf:RDF>
      <xsl:namespace name="rdf">http://www.w3.org/1999/02/22-rdf-syntax-ns#</xsl:namespace>
      <xsl:namespace name="schema">http://schema.org/</xsl:namespace>
      
      <schema:Dataset rdf:about="{meta:getRootIdentifier()}">
        <xsl:apply-templates select="$main-root/c:citation/c:titlStmt/c:titl" />
        <xsl:apply-templates select="$main-root/c:citation/c:titlStmt/c:parTitl" />
        <xsl:apply-templates select="$main-root/c:citation/c:titlStmt/c:altTitl" />
        <xsl:apply-templates select="$main-root/c:citation/c:prodStmt/c:producer" />
        <xsl:apply-templates select="$main-root/c:citation/c:distStmt/c:contact" />
        <xsl:apply-templates select="$main-root/c:citation/c:distStmt/c:distDate" />
        <xsl:apply-templates select="$main-root/c:sumDscr/c:geogCover" />
        <xsl:apply-templates select="$main-root/c:citation/c:titlStmt/c:IDNo" />
        <xsl:apply-templates select="$main-root/c:citation/c:verStmt/c:version" />
        <xsl:apply-templates select="$main-root/c:stdyInfo/c:abstract" />
        <xsl:apply-templates select="$main-root/c:stdyInfo/c:subject/c:keyword" />
        <xsl:apply-templates select="$main-root/c:stdyInfo/c:subject/c:topcClas" />
        <xsl:apply-templates select="$main-root/c:method/c:dataColl/c:sampProc" />
        <xsl:apply-templates select="$main-root/c:citation/c:prodStmt/c:fundAg" />
        <xsl:apply-templates select="$main-root/c:stdyInfo/c:sumDscr/c:nation" />
      </schema:Dataset>
    </rdf:RDF>
  </xsl:template>

  <xsl:template match="c:titl|c:parTitl">
    <schema:name>
      <xsl:copy-of select="@xml:lang" />
      <xsl:value-of select="." />
    </schema:name>
  </xsl:template>

  <xsl:template match="c:altTitl">
    <schema:alternateName>
      <xsl:copy-of select="@xml:lang" />
      <xsl:value-of select="." />
    </schema:alternateName>
  </xsl:template>

  <xsl:template match="c:abstract">
    <schema:description>
      <xsl:copy-of select="@xml:lang" />
      <xsl:value-of select="." />
    </schema:description>
  </xsl:template>

  <xsl:template match="c:producer">
    <schema:producer>
      <xsl:copy-of select="@xml:lang" />
      <xsl:value-of select="." />
    </schema:producer>
  </xsl:template>

  <xsl:template match="c:keyword|c:topcClas">
    <schema:keywords>
      <xsl:copy-of select="@xml:lang" />
      <xsl:value-of select="." />
    </schema:keywords>
  </xsl:template>

  <xsl:template match="c:IDNo"> 
    <schema:identifier>
      <xsl:value-of select="." />
    </schema:identifier>
  </xsl:template>

  <xsl:template match="c:version"> 
    <schema:version>
      <xsl:value-of select="." />
    </schema:version>
  </xsl:template>

  <xsl:template match="c:sampProc">
    <schema:measurementTechnique>
      <xsl:copy-of select="@xml:lang" />
      <xsl:value-of select="." />
    </schema:measurementTechnique>
  </xsl:template>

  <xsl:template match="c:fundAg">
    <schema:funder>
      <schema:Organization>
        <schema:name><xsl:value-of select="." /></schema:name>
      </schema:Organization>
    </schema:funder>
  </xsl:template>

  <xsl:template match="c:contact">
    <schema:contactPoint>
      <xsl:copy-of select="@xml:lang" />
      <xsl:value-of select="." />
    </schema:contactPoint>
  </xsl:template>

  <xsl:template match="c:geogCover">
    <schema:spatialCoverage>
      <xsl:copy-of select="@xml:lang" />
      <xsl:value-of select="." />
    </schema:spatialCoverage>
  </xsl:template>

  <xsl:template match="c:distDate">
    <schema:datePublished><xsl:value-of select="." /></schema:datePublished>
  </xsl:template>

  <xsl:template match="c:nation">
    <schema:spatialCoverage>
      <schema:Place>
        <schema:name>
          <xsl:copy-of select="@xml:lang" />
          <xsl:value-of select="." />
        </schema:name>
      </schema:Place>
    </schema:spatialCoverage>
  </xsl:template>

  <xsl:function name="meta:getRootIdentifier">
    <xsl:choose>
      <xsl:when test="$main-root/c:citation/c:titlStmt/c:IDNo[@agency='DataCite']">
        <xsl:value-of select="$main-root/c:citation/c:titlStmt/c:IDNo[@agency='DataCite']" />
      </xsl:when>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>