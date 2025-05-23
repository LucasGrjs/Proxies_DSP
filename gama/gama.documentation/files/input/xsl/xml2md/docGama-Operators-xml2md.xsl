<?xml version="1.0" encoding="UTF-8"?><!---->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wiki="www.google.fr">
<xsl:import href="docGama-utils-xml2md.xsl"/>

<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

<xsl:variable name="fileAA" select="'OperatorsAA'"/>
<xsl:variable name="fileBC" select="'OperatorsBC'"/>
<xsl:variable name="fileDH" select="'OperatorsDH'"/>
<xsl:variable name="fileIM" select="'OperatorsIM'"/>
<xsl:variable name="fileNR" select="'OperatorsNR'"/>
<xsl:variable name="fileSZ" select="'OperatorsSZ'"/>
<xsl:variable name="alphabetID" select="'*'"/>
<xsl:variable name="fileName" select="'Operators'"/>
<xsl:variable name="aa" select="'aa'"/>
<xsl:variable name="bc" select="'bc'"/>
<xsl:variable name="dh" select="'dh'"/>
<xsl:variable name="im" select="'im'"/>
<xsl:variable name="nr" select="'nr'"/>
<xsl:variable name="sz" select="'sz'"/>

<xsl:template match="/">
 	<xsl:text># </xsl:text> <xsl:value-of select="$fileName"/> <xsl:text>
 	
----

**This file is automatically generated from java files. Do Not Edit It.**

----

## Definition 

Operators in the GAML language are used to compose complex expressions. An operator performs a function on one, two, or n operands (which are other expressions and thus may be themselves composed of operators) and returns the result of this function. 

Most of them use a classical prefixed functional syntax (i.e. `operator_name(operand1, operand2, operand3)`, see below), with the exception of arithmetic (e.g. `+`, `/`), logical (`and`, `or`), comparison (e.g. `&gt;`, `&lt;`), access (`.`, `[..]`) and pair (`::`) operators, which require an infixed notation (i.e. `operand1 operator_symbol operand1`). 

The ternary functional if-else operator, `? :`, uses a special infixed syntax composed with two symbols (e.g. `operand1 ? operand2 : operand3`). Two unary operators (`-` and `!`) use a traditional prefixed syntax that does not require parentheses unless the operand is itself a complex expression (e.g. ` - 10`, `! (operand1 or operand2)`). 

Finally, special constructor operators (`{...}` for constructing points, `[...]` for constructing lists and maps) will require their operands to be placed between their two symbols (e.g. `{1,2,3}`, `[operand1, operand2, ..., operandn]` or `[key1::value1, key2::value2... keyn::valuen]`).

With the exception of these special cases above, the following rules apply to the syntax of operators:

* if they only have one operand, the functional prefixed syntax is mandatory (e.g. `operator_name(operand1)`)
* if they have two arguments, either the functional prefixed syntax (e.g. `operator_name(operand1, operand2)`) or the infixed syntax (e.g. `operand1 operator_name operand2`) can be used.
* if they have more than two arguments, either the functional prefixed syntax (e.g. `operator_name(operand1, operand2, ..., operand)`) or a special infixed syntax with the first operand on the left-hand side of the operator name (e.g. `operand1 operator_name(operand2, ..., operand)`) can be used.

All of these alternative syntaxes are completely equivalent.

Operators in GAML are purely functional, i.e. they are guaranteed to not have any side effects on their operands. For instance, the `shuffle` operator, which randomizes the positions of elements in a list, does not modify its list operand but returns a new shuffled list.


----

## Priority between operators

The priority of operators determines, in the case of complex expressions composed of several operators, which one(s) will be evaluated first.

GAML follows in general the traditional priorities attributed to arithmetic, boolean, comparison operators, with some twists. Namely:

* the constructor operators, like `::`, used to compose pairs of operands, have the lowest priority of all operators (e.g. `a &gt; b :: b &gt; c` will return a pair of boolean values, which means that the two comparisons are evaluated before the operator applies. Similarly, `[a &gt; 10, b &gt; 5]` will return a list of boolean values.
* it is followed by the `?:` operator, the functional if-else (e.g. ` a &gt; b ? a + 10 : a - 10` will return the result of the if-else).
* next are the logical operators, `and` and `or` (e.g. `a &gt; b or b &gt; c` will return the value of the test)
* next are the comparison operators (i.e. `&gt;`, `&lt;`, `&lt;=`, `&gt;=`, `=`, `!=`)
* next the arithmetic operators in their logical order (multiplicative operators have a higher priority than additive operators)
* next the unary operators `-` and `!`
* next the access operators `.` and `[]` (e.g. `{1,2,3}.x &gt; 20 + {4,5,6}.y` will return the result of the comparison between the x and y ordinates of the two points)
* and finally the functional operators, which have the highest priority of all.

----

## Using actions as operators

Actions defined in species can be used as operators, provided they are called on the correct agent. The syntax is that of normal functional operators, but the agent that will perform the action must be added as the first operand.

For instance, if the following species is defined:

```
species spec1 {
        int min(int x, int y) {
                return x &gt; y ? x : y;
        }
}
```

Any agent instance of spec1 can use `min` as an operator (if the action conflicts with an existing operator, a warning will be emitted). For instance, in the same model, the following line is perfectly acceptable:

```
global {
        init {
                create spec1;
                spec1 my_agent &lt;- spec1[0];
                int the_min &lt;- my_agent min(10,20); // or min(my_agent, 10, 20);
        }
}
```

If the action doesn't have any operands, the syntax to use is `my_agent the_action()`. Finally, if it does not return a value, it might still be used but is considering as returning a value of type `unknown` (e.g. `unknown result &lt;- my_agent the_action(op1, op2);`).

Note that due to the fact that actions are written by modelers, the general functional contract is not respected in that case: actions might perfectly have side effects on their operands (including the agent).

	</xsl:text>

----

## Table of Contents

----

## Operators by categories
	<xsl:call-template name="buildOperatorsByCategories"/>
	
----

## Operators
	<xsl:call-template name="buildOperators"/>
	
	<xsl:text>
	</xsl:text>
</xsl:template>

<xsl:template name="buildOperatorsByName">
	<xsl:for-each select="/doc/operators/operator"> 
		<xsl:sort select="@name" />
			<xsl:text>[</xsl:text><xsl:value-of select="@name"/><xsl:text>](</xsl:text><xsl:choose>
				<xsl:when test="@alphabetOrder = $aa">
					<xsl:value-of select="$fileAA"/>
				</xsl:when>
				<xsl:when test="@alphabetOrder = $bc">
					<xsl:value-of select="$fileBC"/>
				</xsl:when>
				<xsl:when test="@alphabetOrder = $dh">
					<xsl:value-of select="$fileDH"/>
				</xsl:when>
				<xsl:when test="@alphabetOrder = $im">
					<xsl:value-of select="$fileIM"/>
				</xsl:when>
				<xsl:when test="@alphabetOrder = $nr">
					<xsl:value-of select="$fileNR"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$fileSZ"/>
				</xsl:otherwise>
				</xsl:choose><xsl:text>#</xsl:text> <xsl:value-of select="translate(@name, $uppercase, $smallcase)"/> <xsl:text> </xsl:text> <xsl:value-of select="@name"/> <xsl:text>), </xsl:text> 	
	</xsl:for-each>
</xsl:template>
 
<xsl:template name="buildOperatorsByCategories">
	<xsl:for-each select="//doc/operatorsCategories/category[not(@id = (preceding-sibling::*/@id))]">
		<xsl:sort select="@id"/>
		<xsl:variable name="categoryGlobal" select="@id"/> 
		<xsl:text>

----

### </xsl:text> <xsl:value-of select="@id"/> <xsl:text>
</xsl:text>
		<xsl:for-each select="/doc/operators/operator"> 
			<xsl:sort select="@name" />
				<xsl:variable name="nameOp" select="@name"/>
				<xsl:variable name="alphabetOrderOp" select="@alphabetOrder"/>			
			<xsl:for-each select="operatorCategories/category">
				<xsl:variable name="catItem" select="@id"/>
				<xsl:if test="$catItem = $categoryGlobal "> 
					<xsl:text>[</xsl:text><xsl:value-of select="$nameOp"/><xsl:text>](</xsl:text>
					<xsl:choose>
					<xsl:when test="$alphabetOrderOp = $aa">
						<xsl:value-of select="$fileAA"/>
					</xsl:when>
					<xsl:when test="$alphabetOrderOp = $bc">
						<xsl:value-of select="$fileBC"/>
					</xsl:when>
					<xsl:when test="$alphabetOrderOp = $dh">
						<xsl:value-of select="$fileDH"/>
					</xsl:when>
					<xsl:when test="$alphabetOrderOp = $im">
						<xsl:value-of select="$fileIM"/>
					</xsl:when>
					<xsl:when test="$alphabetOrderOp = $nr">
						<xsl:value-of select="$fileNR"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$fileSZ"/>
					</xsl:otherwise>
					</xsl:choose><xsl:text>#</xsl:text><xsl:value-of select="translate($nameOp, $uppercase, $smallcase)"/><xsl:text>), </xsl:text> 
				</xsl:if>			
			</xsl:for-each>
		</xsl:for-each>    	
	</xsl:for-each>
</xsl:template>
    
 <xsl:template name="buildOperators"> 
    <xsl:for-each select="doc/operators/operator[@alphabetOrder = $alphabetID or $alphabetID = '*']">
    	<xsl:sort select="@name" />
    	<xsl:variable name="operatorName" select="@name"/>
    	
----
<!-- <xsl:call-template name="keyword">     -->
<!-- 	<xsl:with-param name="category" select="'operator'"/> -->
<!-- 	<xsl:with-param name="nameGAMLElement" select="@name"/> -->
<!-- </xsl:call-template> -->
### <xsl:call-template name="checkName"/> 
  	<xsl:if test="@alternativeNameOf">
  		<xsl:variable name="nameOpAlt" select="@alternativeNameOf"/>  	
<xsl:text>
   Same signification as [</xsl:text><xsl:value-of select="@alternativeNameOf"/><xsl:text>](</xsl:text><xsl:choose><xsl:when test="/doc/operators/operator[@id = $nameOpAlt]/@alphabetOrder = $aa"><xsl:value-of select="$fileAA"/></xsl:when><xsl:when test="/doc/operators/operator[@id = $nameOpAlt]/@alphabetOrder = $bc"><xsl:value-of select="$fileBC"/></xsl:when><xsl:when test="/doc/operators/operator[@id = $nameOpAlt]/@alphabetOrder = $dh"><xsl:value-of select="$fileDH"/></xsl:when><xsl:when test="/doc/operators/operator[@id = $nameOpAlt]/@alphabetOrder = $im"><xsl:value-of select="$fileIM"/></xsl:when><xsl:when test="/doc/operators/operator[@id = $nameOpAlt]/@alphabetOrder = $nr"><xsl:value-of select="$fileNR"/></xsl:when><xsl:otherwise><xsl:value-of select="$fileSZ"/></xsl:otherwise></xsl:choose>#<xsl:value-of select="@alternativeNameOf"/><xsl:text>)</xsl:text>
  	</xsl:if>
  	
  	<xsl:if test="combinaisonIO[node()]">
		<xsl:call-template name="buildOperands">
		<xsl:with-param name="operatorName" select="$operatorName"/>
		</xsl:call-template>
	</xsl:if>
	
	<xsl:if test="documentation/result[text()]"> 

**Result:** <xsl:value-of select="documentation/result"/>
    </xsl:if>
    
  <xsl:if test="documentation/comment[text()]">  

**Comment:** <xsl:value-of select="documentation/comment"/> 
  </xsl:if>
  
  <xsl:if test="documentation/specialCases[node()] | documentation/usages[node()] | documentation/usagesNoExample[node()]">

#### Special cases: </xsl:if> 
  <xsl:if test="documentation/specialCases[node()]">
  <xsl:for-each select="documentation/specialCases/case">    
* <xsl:value-of select="@item"/> </xsl:for-each> </xsl:if>     
  <xsl:if test="documentation/usages[node()] | documentation/usagesNoExample[node()]">
	<xsl:for-each select="documentation/usagesNoExample/usage">    
* <xsl:value-of select="@descUsageElt"/> </xsl:for-each>
  <xsl:for-each select="documentation/usages/usage">    
* <xsl:value-of select="@descUsageElt"/> 
  
```<xsl:call-template name="generateExamples"/>
``` 

</xsl:for-each>
  </xsl:if>

  <xsl:if test="documentation/usagesExamples[node()]">

#### Examples: 
```<xsl:for-each select="documentation/usagesExamples/usage"><xsl:call-template name="generateExamples"/> </xsl:for-each>
```
  </xsl:if>
  
  <xsl:if test="documentation/seeAlso[node()]">    


**See also:** <xsl:for-each select="documentation/seeAlso/see">
  	<xsl:variable name="idOpSee" select="@id"/>
   <xsl:text>[</xsl:text><xsl:value-of select="@id"/><xsl:text>](</xsl:text><xsl:choose><xsl:when test="/doc/operators/operator[@id = $idOpSee]/@alphabetOrder = $aa"><xsl:value-of select="$fileAA"/></xsl:when><xsl:when test="/doc/operators/operator[@id = $idOpSee]/@alphabetOrder = $bc"><xsl:value-of select="$fileBC"/></xsl:when><xsl:when test="/doc/operators/operator[@id = $idOpSee]/@alphabetOrder = $dh"><xsl:value-of select="$fileDH"/></xsl:when><xsl:when test="/doc/operators/operator[@id = $idOpSee]/@alphabetOrder = $im"><xsl:value-of select="$fileIM"/></xsl:when><xsl:when test="/doc/operators/operator[@id = $idOpSee]/@alphabetOrder = $nr"><xsl:value-of select="$fileNR"/></xsl:when><xsl:otherwise><xsl:value-of select="$fileSZ"/></xsl:otherwise></xsl:choose><xsl:text>#</xsl:text><xsl:value-of select="translate(@id, $uppercase, $smallcase)"/><xsl:text>), </xsl:text> </xsl:for-each>
  </xsl:if>


  <xsl:if test="documentation/examples[node()]">
   <xsl:for-each select="documentation" > <xsl:call-template name="generateExamples"/> </xsl:for-each> ```
</xsl:if>
  	</xsl:for-each>
 </xsl:template>   
 
 <xsl:template name="buildOperands">
 	<xsl:param name="operatorName"/>

#### Possible uses: <xsl:for-each select="combinaisonIO/operands"> <xsl:sort select="count(operand)"/> <xsl:call-template name="buildOperand"><xsl:with-param name="operatorName" select="$operatorName"/></xsl:call-template> </xsl:for-each>
 </xsl:template> 
 
 <xsl:template name="buildOperand">
 	<xsl:param name="operatorName"/>
 	<xsl:variable name="nbOperands" select="count(operand)"/>
 	
	<xsl:choose>
	<xsl:when test="count(operand) = 1">
* <xsl:text>**`</xsl:text> <xsl:value-of select="$operatorName"/> <xsl:text>`** </xsl:text>(<xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="operand/@type"/></xsl:with-param></xsl:call-template>) --->  <xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="@returnType"/></xsl:with-param></xsl:call-template> 
	</xsl:when>
	<xsl:when test="count(operand) = 2">
* <xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="operand[@position=0]/@type"/></xsl:with-param></xsl:call-template> <xsl:text> **`</xsl:text> <xsl:value-of select="$operatorName"/> <xsl:text>`** </xsl:text> <xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="operand[@position=1]/@type"/></xsl:with-param></xsl:call-template> --->  <xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="@returnType"/></xsl:with-param></xsl:call-template>
* <xsl:text>**`</xsl:text> <xsl:value-of select="$operatorName"/> <xsl:text>`** </xsl:text>(<xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="operand[@position=0]/@type"/></xsl:with-param></xsl:call-template> <xsl:text> , </xsl:text> <xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="operand[@position=1]/@type"/></xsl:with-param></xsl:call-template>) --->  <xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="@returnType"/></xsl:with-param></xsl:call-template>		
	</xsl:when>	
	<xsl:otherwise>
* <xsl:text>**`</xsl:text> <xsl:value-of select="$operatorName"/> <xsl:text>`** </xsl:text>(<xsl:for-each select="operand">
		<xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="@type"/></xsl:with-param></xsl:call-template>

		<xsl:choose>		
			<xsl:when test="@position = ($nbOperands - 1)">)</xsl:when>
			<xsl:otherwise>, </xsl:otherwise>
		</xsl:choose>		
	
	</xsl:for-each> --->  <xsl:call-template name="checkType"><xsl:with-param name="type"><xsl:value-of select="@returnType"/></xsl:with-param></xsl:call-template> 
	</xsl:otherwise>
	</xsl:choose>
 </xsl:template> 


 <xsl:template name="checkType">
  	<xsl:param name="type"/>
	<xsl:choose> 
 		<xsl:when test="$type = 'list&lt;list&gt;'"><xsl:text>`list&lt;list&gt;`</xsl:text></xsl:when>
  		<xsl:when test="$type = 'list&lt;list&lt;point&gt;&gt;'"><xsl:text>`list&lt;list&lt;point&gt;&gt;`</xsl:text></xsl:when>
    	<xsl:when test="$type = 'list&lt;list&lt;agent&gt;&gt;'"><xsl:text>`list&lt;list&lt;agent&gt;&gt;`</xsl:text></xsl:when>
 		<xsl:when test="$type = 'list&lt;agent&gt;'"><xsl:text>`list&lt;agent&gt;`</xsl:text></xsl:when>
 		<xsl:when test="$type = 'list&lt;geometry&gt;'"><xsl:text>`list&lt;geometry&gt;`</xsl:text></xsl:when>
 		<xsl:when test="$type = 'list&lt;point&gt;'"><xsl:text>`list&lt;point&gt;`</xsl:text></xsl:when>
 		<xsl:when test="$type = 'list&lt;path&gt;'"><xsl:text>`list&lt;path&gt;`</xsl:text></xsl:when>
 		<xsl:when test="$type = 'list&lt;float&gt;'"><xsl:text>`list&lt;float&gt;`</xsl:text></xsl:when>
 		<xsl:when test="$type = 'list&lt;rgb&gt;'"><xsl:text>`list&lt;rgb&gt;`</xsl:text></xsl:when>
  		<xsl:when test="$type = 'list&lt;KeyType&gt;'"><xsl:text>`list&lt;KeyType&gt;`</xsl:text></xsl:when>
 		
 		<xsl:when test="$type = 'container&lt;geometry&gt;'"><xsl:text>`container&lt;geometry&gt;`</xsl:text></xsl:when>
  		<xsl:when test="$type = 'container&lt;agent&gt;'"><xsl:text>`container&lt;agent&gt;`</xsl:text></xsl:when>
  		<xsl:when test="$type = 'container&lt;float&gt;'"><xsl:text>`container&lt;float&gt;`</xsl:text></xsl:when>  		
  		<xsl:when test="$type = 'container&lt;KeyType,ValueType&gt;'"><xsl:text>`container&lt;KeyType,ValueType&gt;`</xsl:text></xsl:when>
  		
  		<xsl:when test="$type = 'map&lt;string,unknown&gt;'"><xsl:text>`map&lt;string,unknown&gt;`</xsl:text></xsl:when>	
  		<xsl:when test="$type = 'map&lt;string,list&gt;'"><xsl:text>`map&lt;string,list&gt;`</xsl:text></xsl:when>	
   		<xsl:when test="$type = 'map&lt;point,float&gt;'"><xsl:text>`map&lt;point,float&gt;`</xsl:text></xsl:when>	
   		<xsl:when test="$type = 'map&lt;agent,float&gt;'"><xsl:text>`map&lt;agent,float&gt;`</xsl:text></xsl:when>	
  		
 		<xsl:when test="$type = 'matrix&lt;float&gt;'"><xsl:text>`matrix&lt;float&gt;`</xsl:text></xsl:when>
  		<xsl:when test="$type = 'matrix&lt;int&gt;'"><xsl:text>`matrix&lt;int&gt;`</xsl:text></xsl:when>
  		
  		
 		
 		<xsl:otherwise>`<xsl:value-of select="$type"/>`</xsl:otherwise>
 	</xsl:choose> 
 </xsl:template>
</xsl:stylesheet>
