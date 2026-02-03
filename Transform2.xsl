<?xml version="1.0" encoding="UTF-8"?>
<!--<xsl:stylesheet> foglio di stile XSLT, che contiene tutte le istruzioni di trasformazione (da xml a html)-->
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/> <!--Questo elemento indica che l'output HTML deve essere generato con codifica UTF-8.-->
    <!--"indent"formattare con rientri-->

    <!-- html template -->
     
    <!-- Applico questo template al nodo radice
	     indicato dal carattere / -->
    <!--Questo elemento definisce una regola (ovvero un modello) di trasformazione il modello principale (root template o parent) che avvia il processo di trasformazione per l'intero documento XML. -->
    <xsl:template match="/">
                           
        <html>
                <!--Creo una variabile e creo il percorso per trovare l'immagine nella cartella-->
                <xsl:variable name="imageFolder" select="'img/logo_rassegna_new.jpg'" />
                <xsl:variable name="imageFolder1" select="'img/Stemma_unipi.svg'" />

            <head>               

                <link rel="stylesheet" type="text/css" href="style.css"/>

                <title>Progetto di Codifica di Testi</title>
   

            </head>

            <body>
               

                <!--In XSLT, si utilizza <div class="header"> per generare un elemento <div>. 
                "header" si riferisce invece a informazioni di intestazione
                usato per raggruppare elementi e definire sezioni di layout-->

                <div class="header">  

                  
                        <!--Recupero l'immagine nella cartella -->
                        <img src="{concat($imageFolder, @logo_rassegna_new.jpg)}" alt="Immagine" />

                        <!--<img src="https://rassegnasettimanale.animi.it/wp-content/uploads/2019/03/logo_rassegna_new.jpg" 
                            alt="La Rassegna Settimanale Logo" />-->
                   
         
                </div>
                
                <!--In XSLT, si utilizza <div class="heading"> per generare un elemento <div>.-->
                
                <div class="heading">
                    <!--Restituisce il contenuto del nodo selezionato secondo
                    l'espressione XPath indicata.
                    (Il contenuto di un elemento e' costituito da tutti i caratteri che
                    si trovano fra tag di apertura e tag di chiusura)
                    -->
                        <!--Questo tag reatituisce il titolo nel file xml all'indirizzo indicato dalla stringa-->
                        <xsl:value-of
                            select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title" />
                    
                    <!--usato per raggruppare piccole porzioni di testo o altri elementi all'interno di un blocco
                     più grande (come <div>)-->
                    <span>

                        <!--Recupero l'immagine nella cartella -->
                        <img src="{concat($imageFolder1, @Stemma_unipi.svg)}" alt="Immagine" />

                        <!--L'attributo src nel tag <img> indica la posizione del file immagine.-->
                        <!--<img src="https://upload.wikimedia.org/wikipedia/it/e/e2/Stemma_unipi.svg"
                            alt="Logo Università di Pisa" style="width:80px" />-->

                    </span>
                    
                        <!--Questo tag restituisce il titolo nel file xml all'indirizzo indicato dalla stringa, individuando
                        un nodo specifico-->
                        <xsl:value-of
                            select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:sponsor" />
                    
                </div>
    
                <!--terzo Blocco Descrizione bibliografica-->

                <div class="container-description">
                             <!--cercare e applicare i modelli (templates) definiti nel foglio di stile
                             agli elementi figli del nodo corrente (fileDesc)-->
                            <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc" />               
                </div>




                
                <!-- Tabella Legenda -->

                    <!--questo elemento viene usato per far sì che il div si espanda e riempia
                    lo spazio vuoto nel contenitore padre, rendendolo flessibile. -->
                <div style="display: flex;">
                    
                    <div class="tab_legenda">
                        
                        
                        <table border="1">
                
                                <th class="legenda-color_white">LEGENDA COLORI:</th>
                                <th class="legenda-color_green">Nomi di persona: green</th>
                                <th class="legenda-color_purple">Cognomi di persona: purple</th>
                                <th class="legenda-color_pink">Luoghi: pink</th>
                                <th class="legenda-color_orange">Religioni: orange</th>
                                <th class="legenda-color_grey">Organizzazioni: grey</th>
                                <th class="legenda-color_blue">Biografie: blu</th>
                                <th class="legenda-color_magenta">Donne: magenta</th>
                                <th class="legenda-color_cyan">Uomini: cyan</th>
                                <th class="legenda-color_gold">Ruoli: gold</th>
                                <th class="legenda-color_olive">Popolazioni: olive</th>
                                <th class="legenda-color_red">Parole arcaiche: red</th>
                                <th class="legenda-color_maroon">Parole di enfasi: maroon</th>    
                                <th class="legenda-color_yellow">Nomi sacri: yellow</th>
                                <th class="legenda-color_teal">Citazioni: teal</th>
                                <th class="legenda-color_salmon">Numeri: salmon</th>

                            
                        </table>
                    </div>
                </div>


                <!-- Titolo di ogni articolo, bibliografia e notizia -->

                <div class="container">

                    <div class="containerSection">
                        <!-- Itera su ogni sezione/paragrafo tei:div-->
                        <xsl:for-each
                            select="tei:TEI/tei:text/tei:body/tei:div[@type='journal']/tei:div">
                            <!-- Estraggo e visualizzo il titolo di ogni sezione/articolo -->
                            <div
                                class="section">
                                
                                    <xsl:value-of
                                        select="tei:head" />
                                

                                <xsl:for-each select="tei:pb">
                                    <!--Questa istruzione crea una variabile temporanea chiamata page_id all'interno del ciclo.-->
                                    <xsl:variable name="page_id">
                                        <!--Questo comando estrae il valore dell'attributo xml:id dell'elemento <tei:pb> corrente
                                         e lo assegna alla variabile page_id definita nel passaggio precedente.-->
                                        <xsl:value-of select="@xml:id" />
                                    <!--Chiude la definizione della variabile-->
                                    </xsl:variable>

                                    
                        


                                        <table class="columns">
                                            <tbody>
                                                <tr>
                                                    <th class="col1">Colonna 1</th>
                                                    <th class="col2">Colonna 2</th>
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

                                    <!--</div>-->
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
                            <table border="1">
                                
                                    <th class="color">Nomi di persona</th>
                                
                                <xsl:for-each select="//tei:name[@type='person']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                    </div>


                    <!-- Tabella 2 -->
                    <div class="tab2">
                            <table border="1">
            
                                    <th class="color">Cognomi di persona</th>
            
                                <xsl:for-each select="//tei:surname[@type='person']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                    </div>

                      

                    <!-- Tabella 3 -->
                    <div class="tab3">
                            <table border="1">
                                
                                    <th class="color">Luoghi</th>
                                
                                <xsl:for-each select="//tei:name[@type='place']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                    </div>
                

                    <!-- Tabella 4 -->
                    <div class="tab4">
                            <table border="1">
                                
                                    <th class="color">Religioni</th>
                                
                                <xsl:for-each select="//tei:name[@type='religion']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                    </div>


                    <!-- Tabella 5 -->
                    <div class="tab5">
                            <table border="1">
                                
                                    <th class="color">Organizzazioni</th>
                                
                                <xsl:for-each select="//tei:name[@type='org']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                    </div>


                    <!-- Tabella 6 -->
                    <div class="tab6">
                            <table border="1">
                                
                                    <th class="color">Bibliografie</th>
                                
                                <xsl:for-each select="//tei:name[@type='bibl']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>   
                    </div>                 


                    <!-- Tabella 7 -->
                    <div class="tab7">
                            <table border="1">
                                
                                    <th class="color">Donne</th>
                                
                                <xsl:for-each select="//tei:term[@type='female']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                                            
                    </div>

                    
                    <!-- Tabella 8 -->
                    <div class="tab8">
                            <table border="1">
                                
                                    <th class="color">Uomini</th>
                                
                                <xsl:for-each select="//tei:term[@type='male']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>   
                    </div>                 


                    <!-- Tabella 9 -->
                    <div class="tab9">
                            <table border="1">
                                
                                    <th class="color">Ruolo</th>
                                
                                <xsl:for-each select="//tei:roleName[@type='public']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>                    
                    </div>

                    <!-- Tabella 10 -->
                    <div class="tab10">
                            <table border="1">
                                
                                    <th class="color">Popolazioni</th>
                                
                                <xsl:for-each select="//tei:population[@type='people']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                    </div>

                    <!-- Tabella 11 -->
                    <div class="tab11">
                            <table border="1">
                                
                                    <th class="color">Parole arcaiche</th>
                                
                                <xsl:for-each select="//tei:distinct[@type='archaic']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                    </div>

                    <!-- Tabella 12 -->
                    <div class="tab12">     
                            <table border="1">
                                
                                    <th class="color">Parole di enfasi</th>
                                
                                <xsl:for-each select="//tei:emph[@rend='italic']">
                                <tr>
                                <td><xsl:value-of select="."/></td>
                                </tr>
                                </xsl:for-each>
                            </table>
                    </div>
                                      




                </div>

    

            </body>

            <!--Footer-->

            <div class="ft">
                <!--All'interno del foglio di stile XSLT, si definiscono le regole per creare
                 un elemento che fungerà da footer nella trasformazione.-->
                
                    <!--L'uso di <p> in XSLT è generare un paragrafo HTML nel risultato finale.-->
                    

                        <!--L'elemento <span> viene inserito nell'output HTML generato dalla trasformazione
                        per racchiudere porzioni di testo.-->
                        <span>
                            <!--Questo tag reatituisce "i crediti" nel footer, presenti nel file xml all'indirizzo indicato dalla stringa-->
                            <xsl:value-of
                            select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:resp" />
                        
                            <xsl:value-of
                            select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name" />
                        </span>
                            
                            
                    
                    
                
            </div>
        </html>
    </xsl:template>



    <!--Colorazioni delle parole nel testo-->
    
    
    <xsl:template match="tei:name[@type='person']">
        <span class="name-person-color-green">
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:template match="tei:surname[@type='person']">
    <span class="surname-person-color-purple">
        <xsl:apply-templates/>
    </span>
    </xsl:template>
    
    

    <xsl:template match="tei:name[@type='place']">
        <span class="place-color-pink">
            <xsl:apply-templates/>
        </span>
    </xsl:template>



    <xsl:template match="tei:name[@type='bibl']">
        <span class="bibl-color-blue">
            <xsl:apply-templates/>
        </span>
    </xsl:template>



    <xsl:template match="tei:emph[@rend='italic']">
        <span class="emph-color-maroon">
            <xsl:apply-templates/>
        </span>
    </xsl:template>



    <xsl:template match="tei:name[@type='religion']">
        <span class="religion-color-orange">
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:template match="tei:name[@type='org']">
        <span class="org-color-grey">
            <xsl:apply-templates/>
        </span>
    </xsl:template>



    <xsl:template match="tei:term[@type='female']">
        <span class="donne-color-magenta">
            <xsl:apply-templates/>
        </span>
    </xsl:template>



    <xsl:template match="tei:term[@type='male']">
        <span class="uomini-color-cyan">
            <xsl:apply-templates/>
        </span>
    </xsl:template>



   
    <xsl:template match="tei:roleName[@type='public']">
        <span class="role-color-gold">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
   

    <xsl:template match="tei:population[@type='people']">
        <span class="population-color-olive">
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:template match="tei:distinct[@type='archaic']">
        <span class="archaic-color-red">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    
    <xsl:template match="tei:name[@type='sacred']">
        <span class="sacred-color-yellow">
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:template match="tei:quote[@source='scienza_rel']">
    <span class="scienza_rel-color-teal">
        <xsl:apply-templates/>
    </span>
    </xsl:template>
    

    <xsl:template match="tei:num[@type='cardinal']">
    <span class="num-color-salmon">
        <xsl:apply-templates/>
    </span>
    </xsl:template>



    <!-- elemento fileDesc che appartiene allo spazio dei nomi TEI-->
    <!--un modello (template) che viene applicato a tutti gli elementi
    <fileDesc> all'interno di un documento XML.
    "Match" seleziona i nodi (elementi, attributi, ecc.) nel documento XML
     di origine a cui si applica il modello specifico.-->
    <xsl:template match="tei:fileDesc">
        
        <table>
        <td class="title">
        Descrizione bibliografica: 
        </td>
             <tr>
                <td class="sub-title">
                    Pubblicazione
                </td>
                <td>
                    <xsl:apply-templates select="tei:publicationStmt" />
                </td>
            </tr>
            <tr>
                <td class="sub-title">
                    Serie
                </td>
                <td>
                    <xsl:apply-templates select="tei:seriesStmt" />
                </td>
            </tr>
            <tr>
                <td class="sub-title">
                    Note
                </td>
                <td>
                    <xsl:apply-templates select="tei:notesStmt" />
                </td>
            </tr>
            <tr>
                <td class="sub-title">
                    Fonte
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
                    Editore
                </td>
                <td>
                    <xsl:value-of select="tei:publisher" />
                </td>
            </tr>
            <tr>
                <td>
                    Luogo, data
                </td>
                <td><xsl:value-of select="tei:pubPlace" />, <xsl:value-of select="tei:date" />
                </td>
            </tr>
            <tr>
                <td>
                    Risorsa
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
                    Serie
                </td>
                <td>
                    <xsl:value-of select="tei:title" />
                </td>
            </tr>
            <tr>
                <td>
                    Coordinatore
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
                    Titolo
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:title" />
                </td>
            </tr>
            <tr>
                <td>
                    
                        <xsl:value-of select="tei:biblStruct/tei:monogr/tei:respStmt/tei:resp" />
                    
                </td>
                <td><xsl:value-of select="tei:biblStruct/tei:monogr/tei:respStmt/tei:name[1]" />, 
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:respStmt/tei:name[2]" /></td>
            </tr>
            <tr>
                <td>
                    Editore
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:publisher" />
                </td>
            </tr>
            <tr>
                <td>
                    Lingua
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:textLang" />
                </td>
            </tr>
            <tr>
                <td>
                    Luogo, data
                </td>
                <td><xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:pubPlace" />, 
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:imprint/tei:date" /></td>
            </tr>
            <tr>
                <td>
                    Volume, fascicolo
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[1]" />, 
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[2]" />
                </td>
            </tr>
            <tr>
                <td>
                    Pagine
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr/tei:biblScope[3]" />
                </td>
            </tr>
            <tr>
                <td>
                    Sezioni codificate
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
        <!--un modello (template) che viene applicato (mecciare) a tutti gli elementi
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
        valore contenuto nella variabile XSLT $col_id. 
        @corresp: Seleziona l'attributo corresp dell'elemento tei:ab.
        =concat('#', $col_id): Confronta il valore dell'attributo corresp con una stringa generata unendo 
        il carattere # e il valore contenuto nella variabile XSLT $col_id. 

        In sintesi, il codice seleziona tutti gli elementi tei:ab che sono fratelli successivi del nodo 
        corrente e il cui attributo corresp ha lo stesso valore della variabile
        $col_id preceduta da un #, e applica a essi i template definiti altrove nel foglio di stile.
        
        Confronta ogni nodo presente all'interno del nodo selezionato
        con le template rules del foglio di stile e se viene trovata una
        regola applicabile questa viene applicata.
        -->
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
                    <xsl:value-of select="substring-after(@facs, '#')"/>
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
                    <xsl:value-of select="substring-after(@facs, '#')"/>           
            <!--<div class="block">-->
                <!--comando fondamentale che dice al processore XSLT di cercare e applicare i template (modelli)-->
                    <xsl:apply-templates />
            <!--</div>-->
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

    
    <xsl:template match="tei:ab[@facs]">
        <div class="facsimile-container">
            <!-- 1. Recupero l'URL dell'immagine usando l'ID contenuto in @facs -->
            <xsl:variable name="imageID" select="substring-after(@facs, '#')"/>
            <xsl:variable name="imageUrl" select="//tei:surface[@xml:id = $imageID]/tei:graphic/@url"/>

        <!-- Mostra l'immagine solo se l'URL esiste -->
        <xsl:if test="$imageUrl">
            <!-- 2. Genero il tag immagine HTML -->
            <img src="{$imageUrl}" alt="Facsimile" style="width: 400px;  height: auto;"/>
        </xsl:if>
    
            <!-- 3. Visualizzo il testo trascritto -->
            <p><xsl:apply-templates/></p>
        </div>
    </xsl:template>
    


   
</xsl:stylesheet>