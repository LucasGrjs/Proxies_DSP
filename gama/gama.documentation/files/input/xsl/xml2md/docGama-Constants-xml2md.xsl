<?xml version="1.0" encoding="UTF-8"?><!---->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wiki="www.google.fr">
<xsl:import href="docGama-utils-xml2md.xsl"/>
<xsl:variable name="colors" select="'Colors'"/>

<xsl:template match="/">
 	<xsl:text># Units and constants</xsl:text>
 	
<xsl:call-template name="msgIntro"/>

<xsl:text>
## Introduction
Units can be used to qualify the values of numeric variables. By default, unqualified values are considered as:

* meters for distances, lengths...
* seconds for durations
* cubic meters for volumes
* kilograms for masses 

So, an expression like:
```
float foo &lt;- 1;
```

will be considered as 1 meter if `foo` is a distance, or 1 second if it is a duration, or 1 meter/second if it is a speed. If one wants to specify the unit, it can be done very simply by adding the unit symbol (° or `#`) followed by an unit name after the numeric value, like:

```
float foo &lt;- 1 °centimeter;
```

or

```
float foo &lt;- 1 #centimeter;
```

In that case, the numeric value of `foo` will be automatically translated to 0.01 (meter). It is recommended to always use float as the type of the variables that might be qualified by units (otherwise, for example in the previous case, they might be truncated to 0). 
Several units names are allowed as qualifiers of numeric variables. 
These units represent the basic metric and US units. Composed and derived units (like velocity, acceleration, special volumes or surfaces) can be obtained by combining these units using the `*` and `/` operators. For instance:
```
float one_kmh &lt;- 1 °km / °h const: true;
float one_millisecond &lt;-1 °sec / 1000;
float one_cubic_inch &lt;- 1 °sqin * 1 °inch;
... etc ...
```


	</xsl:text>

<xsl:call-template name="buildUnits"/>
<xsl:text>
</xsl:text>
<xsl:call-template name="buildColors"/>

<xsl:text>
</xsl:text>

</xsl:template>

<xsl:template name="buildUnits">
	<xsl:for-each select="doc/constantsCategories/category">
		<xsl:sort select="@id"/>
		<xsl:if test="@id != $colors">
		<xsl:variable name="categoryGlobal" select="@id"/> 
		<xsl:text>
		
----

## </xsl:text> <xsl:value-of select="@id"/> 
		<xsl:for-each select="/doc/constants/constant"> 
			<xsl:sort select="@name" />
			<xsl:variable name="unitName" select="@name"/>
			<xsl:variable name="unitAltNames" select="@altNames"/>
			<xsl:variable name="unitValue" select="@value"/>

			<xsl:for-each select="categories/category">
				<xsl:variable name="catItem" select="@id"/>
				<xsl:if test="$catItem = $categoryGlobal"> 
<xsl:text>
</xsl:text>
<!--  			<xsl:call-template name="keyword">     -->
<!-- 					<xsl:with-param name="category" select="'constant'"/> -->
<!-- 					<xsl:with-param name="nameGAMLElement" select="$unitName"/> -->
<!-- 				</xsl:call-template>							 -->
<xsl:text>* **`</xsl:text> <xsl:value-of select="$unitName"/> <xsl:text>`**</xsl:text> <xsl:if test="../../@altNames"> <xsl:text> (</xsl:text> <xsl:value-of select="$unitAltNames"/> <xsl:text>)</xsl:text></xsl:if><xsl:text>, value= </xsl:text> <xsl:value-of select="$unitValue"/> 
  	<xsl:if test="../../documentation/result[text()]"> <xsl:text>, Comment: </xsl:text> <xsl:value-of select="../../documentation/result[text()]"/>  
    </xsl:if>
				</xsl:if>		 
			</xsl:for-each>
		</xsl:for-each> 
		</xsl:if>   	
	</xsl:for-each>
</xsl:template>
 
<xsl:template name="buildColors">
<xsl:text>

----

## </xsl:text> <xsl:value-of select="$colors"/> <xsl:text>

In addition to the previous units, GAML provides a direct access to the 147 named colors defined in CSS (see http://www.cssportal.com/css3-color-names/). E.g,
```
rgb my_color &lt;- °teal;
```
</xsl:text>
    <xsl:for-each select="/doc/constants/constant[categories/category/@id = $colors]">
			<xsl:sort select="@name" />
			<xsl:variable name="unitName" select="@name"/>
			<xsl:variable name="unitAltNames" select="@altNames"/>
			<xsl:variable name="unitValue" select="@value"/>
<xsl:text>
</xsl:text>
<!-- <xsl:call-template name="keyword">     -->
<!-- 	<xsl:with-param name="category" select="'constant'"/> -->
<!-- 	<xsl:with-param name="nameGAMLElement" select="$unitName"/> -->
<!-- </xsl:call-template>	 -->
<xsl:text>* **`</xsl:text> <xsl:value-of select="$unitName"/> <xsl:text>`**</xsl:text> <xsl:if test="@altNames"> <xsl:text> (</xsl:text> <xsl:value-of select="$unitAltNames"/> <xsl:text>)</xsl:text></xsl:if><xsl:text>, value= </xsl:text> <xsl:value-of select="$unitValue"/> 
  	<xsl:if test="documentation/result[text()]"> <xsl:text>, Comment: </xsl:text> <xsl:value-of select="documentation/result[text()]"/>  
    </xsl:if>	
	</xsl:for-each>
</xsl:template> 
 
</xsl:stylesheet>

