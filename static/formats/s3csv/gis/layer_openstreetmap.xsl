<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- **********************************************************************
         OpenStreetMap Layers - CSV Import Stylesheet

         CSV column...........Format..........Content

         Name.................string..........Layer Name
         Description..........string..........Layer Description
         Enabled..............boolean.........Layer Enabled in SITE_DEFAULT config?
         Base.................boolean.........Layer Base?
         Visible..............boolean.........Layer Visible in SITE_DEFAULT config?
         Folder...............string..........Layer Folder
         URL..................string..........Layer URL
         URL2.................string..........Layer URL2
         URL3.................string..........Layer URL3
         Attribution..........string..........Layer Attribution
         Zoom Levels..........integer.........Layer Zoom Levels

    *********************************************************************** -->
    <xsl:output method="xml"/>

    <!-- ****************************************************************** -->
    <xsl:template match="/">
        <s3xml>
            <xsl:apply-templates select="./table/row"/>
        </s3xml>
    </xsl:template>

    <!-- ****************************************************************** -->
    <xsl:template match="row">

        <xsl:variable name="Layer" select="col[@field='Name']/text()"/>

        <resource name="gis_layer_openstreetmap">
            <xsl:attribute name="tuid">
                <xsl:value-of select="$Layer"/>
            </xsl:attribute>
            <data field="name"><xsl:value-of select="$Layer"/></data>
            <data field="description"><xsl:value-of select="col[@field='Description']"/></data>
            <data field="base"><xsl:value-of select="col[@field='Base']"/></data>
            <data field="dir"><xsl:value-of select="col[@field='Folder']"/></data>
            <data field="url1"><xsl:value-of select="col[@field='URL']"/></data>
            <data field="url2"><xsl:value-of select="col[@field='URL2']"/></data>
            <data field="url3"><xsl:value-of select="col[@field='URL3']"/></data>
            <data field="attribution"><xsl:value-of select="col[@field='Attribution']"/></data>
            <data field="zoom_levels"><xsl:value-of select="col[@field='Zoom Levels']"/></data>
        </resource>

        <resource name="gis_layer_config">
            <reference field="layer_id" resource="gis_layer_openstreetmap">
                <xsl:attribute name="tuid">
                    <xsl:value-of select="$Layer"/>
                </xsl:attribute>
            </reference>
            <reference field="config_id" resource="gis_config">
                <xsl:attribute name="uuid">
                    <xsl:text>SITE_DEFAULT</xsl:text>
                </xsl:attribute>
            </reference>
            <data field="enabled"><xsl:value-of select="col[@field='Enabled']"/></data>
            <data field="visible"><xsl:value-of select="col[@field='Visible']"/></data>
        </resource>

    </xsl:template>
    <!-- ****************************************************************** -->

</xsl:stylesheet>
