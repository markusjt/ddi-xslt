<?xml version='1.0' encoding='utf-8'?>
<!-- ddi-dataCollector.xsl -->
<!-- ============================== -->
<!-- match: ddi:dataCollector       -->
<!-- value: <fo:block>              -->
<!-- ============================== -->

<!-- functions: -->
<!-- util:trim() [local] -->

<xsl:template match="dataCollector"
              xpath-default-namespace="http://www.icpsr.umich.edu/DDI"
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <fo:block>  
    <xsl:value-of select="util:trim(.)" />

    <!-- abbr -->
    <xsl:if test="@abbr">
      <xsl:text>(</xsl:text>
      <xsl:value-of select="@abbr"/>
      <xsl:text>)</xsl:text>
    </xsl:if>

    <!-- affiliation -->
    <xsl:if test="@affiliation"> ,
      <xsl:value-of select="@affiliation" />
    </xsl:if>

  </fo:block>

</xsl:template>
