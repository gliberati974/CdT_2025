<?xml version="1.0" encoding="UTF-8"?>
<!--<xsl:stylesheet> è l'elemento radice di un foglio di stile XSLT, che contiene tutte le istruzioni di trasformazione (da xslt a xml)-->
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/> <!--Questo elemento indica che l'output HTML deve essere generato con codifica UTF-8.-->
    <!--"indent"formattare con rientri-->

    <!-- html template -->
     
    <!-- Applico questo template al nodo radice
	     indicato dal carattere / -->
    <!--Questo elemento definisce il modello principale (o root template) che avvia il processo di trasformazione per l'intero documento XML. -->
    <xsl:template match="/">
                           

        <html>
            <head>               

                <link rel="stylesheet" type="text/css" href="style.css"/>

                <title>Progetto di Codifica di Testi</title>
   

            </head>

            <body>
                        
                        
                        

                <!--In XSLT, si utilizza <div class="header"> per generare un elemento <div>. 
                "header" si riferisce invece a informazioni di intestazione-->
                <div class="header">

                        <!--L'attributo src nel tag <img> indica la posizione del file immagine.-->

                        <img src="https://rassegnasettimanale.animi.it/wp-content/uploads/2019/03/logo_rassegna_new.jpg" width="1000" height="650"
                            alt="La Rassegna Settimanale Logo" />
         
                </div>
                
                <!--In XSLT, si utilizza <div class="heading"> per generare un elemento <div>.-->
                
                <div class="heading">
                    <h1>
                        <!--Questo tag reatituisce il titolo nel file xml all'indirizzo indicato dalla stringa-->
                        <xsl:value-of
                            select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title" />
                    </h1>
                    <span>

                        <!--L'attributo src nel tag <img> indica la posizione del file immagine.-->
                        <img src="https://upload.wikimedia.org/wikipedia/it/e/e2/Stemma_unipi.svg"
                            alt="Logo Università di Pisa" style="width:80px" />
                    </span>
                    <h3>
                        <!--Questo tag reatituisce il titolo nel file xml all'indirizzo indicato dalla stringa-->
                        <xsl:value-of
                            select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:sponsor" />
                    </h3>
                </div>
    
                <!--Descrizione bibliografica-->

                <div class="container" id="descBibl">
                    <div class="bgTabella">
                        <div class="containerTabella">
                            <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc" />
                        </div>
                    </div>
                </div>


                <!-- Testo -->

                <div class="container">

                    <div class="containerSection">
                        <!-- Itera su ogni sezione tei:div-->
                        <xsl:for-each
                            select="tei:TEI/tei:text/tei:body/tei:div[@type='journal']/tei:div">
                            <!-- Estraggo e visualizzo il titolo di ogni sezione -->
                            <div
                                class="section">
                                <h2>
                                    <xsl:value-of
                                        select="tei:head" />
                                </h2>

                                <xsl:for-each select="tei:pb">
                                    <!--Questa istruzione crea una variabile temporanea chiamata page_id all'interno del ciclo.-->
                                    <xsl:variable name="page_id">
                                        <!--Questo comando estrae il valore dell'attributo xml:id dell'elemento <tei:pb> corrente
                                         e lo assegna alla variabile page_id definita nel passaggio precedente.-->
                                        <xsl:value-of select="@xml:id" />
                                    <!--Chiude la definizione della variabile-->
                                    </xsl:variable>

                                    <div class="page">
                                        <div class="facsimile">
                                            <!--viene usata per indicare al motore XSLT di cercare e applicare i template corrispondenti al nodo corrente (.)
                                            Il punto (.) rappresenta il nodo corrente del documento XML. Quando si trova all'interno di un template, l'elemento 
                                            <xsl:apply-templates select="." /> chiede al motore XSLT di elaborare il nodo stesso.-->
                                            <xsl:apply-templates select="." />
                                        </div>

                                        <table class="columns">
                                            <tbody>
                                                <tr>
                                                    <th>Colonna 1</th>
                                                    <th>Colonna 2</th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="column left">
                                                            <!--serve a selezionare ed elaborare un nodo specifico tra i fratelli successivi (following-sibling) del nodo -->
                                                            <xsl:apply-templates select="following-sibling::tei:cb[@corresp=concat('#',$page_id) and @n=1]" />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="column right">
                                                            <xsl:apply-templates select="following-sibling::tei:cb[@corresp=concat('#',$page_id) and @n=2]" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </div>
                                </xsl:for-each>
                            </div>
                        </xsl:for-each>
                    </div>

                </div>


               <!--display: flex
                è una proprietà CSS che rende un elemento un "contenitore flessibile",
                il che significa che i suoi elementi figli (chiamati "flex items")
                vengono disposti in modo flessibile, consentendo di controllarne la disposizione,
                l'allineamento e la distribuzione dello spazio. Questa proprietà è uno strumento
                fondamentale per creare layout web reattivi e moderni, eliminando la necessità
                di metodi più datati come il float. -->
                <div style="display: flex;">
                    <!-- Tabella 1 -->
                    <div class="tab1">
                        <!--questo elemento viene usata per far sì che il div si espanda e riempia
                         lo spazio vuoto nel contenitore padre, rendendolo flessibile. -->
                        <div style="flex: 1;">    
                            <h2>Nomi di persone trovati:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Nomi</th>
                                </tr>
                                <xsl:for-each select="//tei:name[@type='person']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>
                    </div>
                      

                    <!-- Tabella 2 -->
                    <div class="tab2">
                        <div style="flex: 1;">
                            <h2>Nomi di luoghi trovati:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Luoghi</th>
                                </tr>
                                <xsl:for-each select="//tei:name[@type='place']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>
                    </div>
                

                    <!-- Tabella 3 -->
                    <div class="tab8">
                        <div style="flex: 1;">
                            <h2>Religioni trovate:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Religioni</th>
                                </tr>
                                <xsl:for-each select="//tei:name[@type='religion']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>
                    </div>


                    <!-- Tabella 4 -->
                    <div class="tab4">
                        <div style="flex: 1;">
                            <h2>Organizzazioni trovate:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Organizzazioni</th>
                                </tr>
                                <xsl:for-each select="//tei:name[@type='org']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>
                    </div>


                    <!-- Tabella 5 -->
                    <div class="tab5">
                        <div style="flex: 1;">
                            <h2>Bibliografie trovate:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Bibliografie</th>
                                </tr>
                                <xsl:for-each select="//tei:name[@type='bibl']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>   
                    </div>                 


                    <!-- Tabella 6 -->
                    <div class="tab6">
                        <div style="flex: 1;">
                            <h2>Donne:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Donne</th>
                                </tr>
                                <xsl:for-each select="//tei:gender[@value='W']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>                    
                    </div>

                    
                    <!-- Tabella 7 -->
                    <div class="tab7">
                        <div style="flex: 1;">
                            <h2>Uomini:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Uomini</th>
                                </tr>
                                <xsl:for-each select="//tei:gender[@value='M']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>   
                    </div>                 


                    <!-- Tabella 8 -->
                    <div class="tab8">
                        <div style="flex: 1;">
                            <h2>Femmine:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Femmine</th>
                                </tr>
                                <xsl:for-each select="//tei:sex[@value='F']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>                    
                    </div>

                    <!-- Tabella 9 -->
                    <div class="tab9">
                        <div style="flex: 1;">
                            <h2>Maschi:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Maschi</th>
                                </tr>
                                <xsl:for-each select="//tei:sex[@value='M']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>                    
                    </div>

                    <!-- Tabella 10 -->
                    <div class="tab10">
                        <div style="flex: 1;">
                            <h2>Parole arcaiche:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Parole arcaiche</th>
                                </tr>
                                <xsl:for-each select="//tei:distinct[@type='archaic']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>                    
                    </div>

                    <!-- Tabella 11 -->
                    <div class="tab10">
                        <div style="flex: 1;">
                            <h2>Parole di enfasi:</h2>
                            <table border="1">
                                <tr bgcolor="#FFFFFF">
                                    <th>Parole di enfasi</th>
                                </tr>
                                <xsl:for-each select="//tei:emph[@rend='italic']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                        </div>                    
                    </div>

                </div>

    

            </body>

            <!--Footer-->

            <div class="ft">
                <!--All'interno del foglio di stile XSLT, si definiscono le regole per creare
                 un elemento che fungerà da footer nella trasformazione.-->
                <footer>
                    <!--L'uso di <p> in XSLT è generare un paragrafo HTML nel risultato finale.-->
                    <p>

                        <!--L'elemento <span> viene inserito nell'output HTML generato dalla trasformazione
                        per racchiudere porzioni di testo.-->
                        <span>
                            <!--Questo tag reatituisce "i crediti" nel footer, presenti nel file xml all'indirizzo indicato dalla stringa-->
                            <xsl:value-of
                            select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:resp" />
                        </span>

                        <span>
                            <xsl:value-of
                            select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name" />
                        </span>
                            
                            
                    </p>
                    <p>Repository <a target="_blank" href="https://github.com/gliberati974">GitHub</a></p>
                </footer>
            </div>
        </html>
    </xsl:template>

    
    <!-- elemento fileDesc che appartiene allo spazio dei nomi TEI-->
    <!--un modello (template) che viene applicato a tutti gli elementi
    <fileDesc> all'interno di un documento XML.
    "Match" seleziona i nodi (elementi, attributi, ecc.) nel documento XML
     di origine a cui si applica il modello specifico.-->
    <xsl:template match="tei:fileDesc">
        <h3>Descrizione bibliografica</h3>
        <table>
            <tr></tr>
            <tr>
                <td>
                    <h3>Pubblicazione</h3>
                </td>
                <td>
                    <xsl:apply-templates select="tei:publicationStmt" />
                </td>
            </tr>
            <tr>
                <td>
                    <h3>Serie</h3>
                </td>
                <td>
                    <xsl:apply-templates select="tei:seriesStmt" />
                </td>
            </tr>
            <tr>
                <td>
                    <h3>Note</h3>
                </td>
                <td>
                    <xsl:apply-templates select="tei:notesStmt" />
                </td>
            </tr>
            <tr>
                <td>
                    <h3>Fonte</h3>
                </td>
                <td>
                    <xsl:apply-templates select="tei:sourceDesc" />
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="tei:publicationStmt">
        <table>
            <tr>
                <td>
                    <strong>Editore</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:publisher" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Luogo, data</strong>
                </td>
                <td><xsl:value-of select="tei:pubPlace" />, <xsl:value-of select="tei:date" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Risorsa</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:availability/tei:p" />
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="tei:availability/tei:ref/@target" />
                        </xsl:attribute>
                        <xsl:value-of select="tei:availability/tei:ref" />
                    </a>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="tei:seriesStmt">
        <table>
            <tr>
                <td>
                    <strong>Serie</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:title" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Coordinatore</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:respStmt" />
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="tei:notesStmt">
        <table>
            <tr>
                <td>
                    <xsl:value-of select="tei:note[1]" />
                </td>
            </tr>
            <tr>
                <td>
                    <xsl:value-of select="tei:note[2]" />
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="tei:ref/@target" />
                        </xsl:attribute>
                        <xsl:value-of select="tei:ref" />
                    </a>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="tei:sourceDesc">
        <table>
            <tr>
                <td>
                    <strong>Titolo</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:title" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>
                        <xsl:value-of select="tei:biblStruct/tei:monogr/tei:respStmt/tei:resp" />
                    </strong>
                </td>
                <td><xsl:value-of select="tei:biblStruct/tei:monogr/tei:respStmt/tei:name[1]" />, 
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:respStmt/tei:name[2]" /></td>
            </tr>
            <tr>
                <td>
                    <strong>Editore</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:publisher" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Lingua</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:textLang" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Luogo, data</strong>
                </td>
                <td><xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:pubPlace" />, 
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:date" /></td>
            </tr>
            <tr>
                <td>
                    <strong>Volume, fascicolo</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[1]" />, 
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[2]" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Pagine</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[3]" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Sezioni codificate</strong>
                </td>
                <td>
                    <xsl:for-each select="tei:biblStruct/tei:analytic">
                        <xsl:value-of select="tei:title" />
                        <xsl:if test="count(tei:author)>0">, <span>
                                <xsl:value-of select="tei:author/tei:persName" />
                            </span>
                        </xsl:if><br />
                    </xsl:for-each>
                </td>
            </tr>
        </table>
    </xsl:template>
    

    <!-- cb -->
        <!--un modello (template) che viene applicato a tutti gli elementi
        <cb> all'interno di un documento XML.-->
        <xsl:template match="tei:cb">
        <!--Questa parte dichiara una variabile e le assegna un nome, col_id. 
        @xml:id seleziona l'attributo xml:id dell'elemento XML -->
        <xsl:variable name="col_id" select="@xml:id"/>
        <!--Questa istruzione indica al processore XSLT di continuare l'elaborazione del documento
        XML applicando i modelli appropriati ai nodi specificati nell'attributo select.
        Seleziona tutti i nodi "fratelli" (dello stesso livello gerarchico e con lo stesso genitore)
        che seguono il nodo corrente nel documento XML.
        Specifica che tra i fratelli successivi, devono essere selezionati solo quelli che sono
        elementi ab appartenenti allo spazio dei nomi (namespace) tei.
        Questo è un predicato che filtra ulteriormente i nodi tei:ab. Seleziona solo quelli 
        il cui attributo corresp ha un valore uguale alla concatenazione del carattere # e del 
        valore contenuto nella variabile XSLT $col_id. -->
        <xsl:apply-templates select="following-sibling::tei:ab[@corresp=concat('#', $col_id)] |
                                    following-sibling::tei:head[@corresp=concat('#', $col_id)] |
                                    following-sibling::tei:closer[@corresp=concat('#', $col_id)] |
                                    following-sibling::tei:div[@corresp=concat('#', $col_id)]/tei:ab |
                                    following-sibling::tei:div[@corresp=concat('#', $col_id)]/tei:head |
                                    following-sibling::tei:div[@corresp=concat('#', $col_id)]/tei:list" />
    </xsl:template>
   

    <!-- ab -->
     <!--definisce un modello (template) che viene applicato a tutti gli elementi "ab"-->
    <xsl:template match="tei:ab">
        <div class="paragraph">
                    <!--serve a estrarre e mostrare la parte di testo di un attributo (@facs)
                    che viene dopo il primo carattere '#' -->
                    <strong><xsl:value-of select="substring-after(@facs, '#')"/></strong>
            <div class="block">
                <!--comando fondamentale che dice al processore XSLT di cercare e applicare i template (modelli)-->
                <xsl:apply-templates />
            </div>
        </div>
    </xsl:template>


    <!-- list item -->
     <!--definisce un modello (template) che viene applicato a tutti gli elementi "item"-->
    <xsl:template match="tei:item">
        <div class="paragraph">
                    <!--serve a estrarre e mostrare la parte di testo di un attributo (@facs)
                    che viene dopo il primo carattere '#' -->
                    <strong><xsl:value-of select="substring-after(@facs, '#')"/></strong>           
            <div class="block">
                <!--comando fondamentale che dice al processore XSLT di cercare e applicare i template (modelli)-->
                <xsl:apply-templates />
            </div>
        </div>
    </xsl:template>


    <!-- lb -->
     <!--definisce un modello (template) che viene applicato a tutti gli elementi "lb"-->
    <xsl:template match="tei:lb">
        <div class="line">
            <!--comando fondamentale che dice al processore XSLT di cercare e applicare i template (modelli)-->
            <xsl:apply-templates />
        </div>
    </xsl:template>

   
</xsl:stylesheet>