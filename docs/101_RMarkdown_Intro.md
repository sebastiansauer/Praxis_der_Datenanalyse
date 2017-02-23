



# Was ist RMarkdown?


<img src="images/Kommunizieren.pdf" width="70%" style="display: block; margin: auto;" />



Nehmen wir an, Sie möchten die Ergebnisse Ihrer Datenanalyse niederschreiben. Sei es, dass Sie einen Professor beglücken ~müssen~, wollen; sei es, dass Sie einem Kunden eine Bericht der Quartalszahlen inkl. Forecast erstellen oder mit einem Kollegen Ideen austauschen. Welche Anforderungen stellen Sie an ein Werkzeug, mit dem Sie die Ergebnisse niederschreiben? 


## Forderungen an Werkzeuge zur Berichtserstellung

Einige Anforderungen sind im Folgenden aufgelistet:

>    1. R sollte integrierbar sein; sowohl die Ergebnisse als auch die Syntax.
     2. Man sollte sich beim Schreiben auf das Schreiben konzentrieren können - ohne sich auf die Formatierung konzentrieren zu müssen.
     3. Das Werkzeug sollte einfach zu erlernen (und zu bedienen) sein.
     4. Es sollte verschiedene Ausgabeformate (PDF, HTML,...) unterstützen.
     5. Das Dokument sollte optisch ansprechend formatiert sein.
     6. Das Werkzeug sollte übergreifend (Betriebssysteme, Zeiten, Versionen) arbeiten.
     7. Das Werzeug sollte mächtig (funktionsreich) sein.
     8. Das Werkzeug sollte frei (quelloffen sowie ggf. kostenfrei) sein.
     9. Das Werkzeug sollte Kollaboration leicht machen.
     10. Das Werkzeug sollte Versionierungen und Änderungsverfolgung unterstützen.
     
Mit Werkzeug ist hier die Software zur Erstellung des Berichts gemeint; häufig MS Word.

Betrachten wir die einzelnen Forderungen näher.    

>     R sollte integrierbar sein; sowohl die Ergebnisse als auch die Syntax.

Sind das Werkzeug der Datenanalyse und das Werkzeug zur Berichterstellung voneinander getrennt, gibt es eine Schnittstselle, die wie eine Sollbuchstelle wirkt. Dieser Graben ist stets zu überwinden. Zwei Dinge, die dann fast zwangsläufig passieren: Copy-Paste und manuelles Aktualisieren. Copy-Paste ist mühsam und fehleranfällig. Mitunter weicht man vielleicht auf Neu-Eintippen aus: "Ok, der Mittelwert war doch 12,34..."; Fehler sind dann vorprogrammiert. Zum manuellen Aktualisieren: Stellen Sie sich vor, Ihr Bericht beinhaltet sagen wir 50 Diagramme und eine Reihe Tabellen und sonstige Zahlen - pro Kunde, pro Berichtszeitraum. Sie haben 100 Kunden, die einen Bericht pro Woche verlangen... Und jetzt für jedes Diagramm etc. in der Berichts-Software auf "Einfügen..." klicken??? Professionell geht anders. Kurz: Die Analyse sollte sich nahtlos in Ihren Bericht einfügen. Das ist vor allem für die Ergebnisse (Zahlen, Diagramme, Tabellen...) wichtig, aber sekundär auch für die Syntax.


>       Man sollte sich beim Schreiben auf das Schreiben konzentrieren können - ohne sich auf die Formatierung konzentrieren zu müssen.
     
Entscheidend sind die Inhalte, die Formatierung ist zweitrangig und außerdem zeitlich nachgelagert. Bietet das Werkzeug reichhaltige Möglichkeiten zur Formatierung besteht die Gefahr, dass verfrüht der geistige Fokus von den Inhalten zur Dekoration der Inhalte wandert. Besser ist es, sich in gestalterischer Askese zu üben und die mentalen Ressourcen komplett auf die Inhalte konzentrieren zu können. Außerdem ist es wünschenswert, wenn das Werkzeug sich selbständig um das Formatieren kümmert. Damit soll dem Autor nicht die Möglichkeit verwehrt sein, selber zu gestalten; doch sollte ihm optisch ansprechende Standards automatisch angeboten werden.


>    Das Werkzeug sollte einfach zu erlernen (und zu bedienen) sein.

Nimmt mir das Werkzeug die Formatierung weitgehend ab, so bleibt (fast nur) das reine Schreiben von Text übrig. Das ist einfach zu bewerkstelligen (oder sollte es sein). Aufwändiges Einarbeiten in neue Werkzeuge sollte entfallen.

>    Es sollte verschiedene Ausgabeformate (PDF, HTML,...) unterstützen.

Die wichtigsten Formate, um Berichte zu erstellen sind sicherlich PDF, DOC, PPT und neuerdings zunehmend HTML und EPUB-Formate. Diese Formate sollten unterstützt werden. HTML und EPUB gewinnen mit der Verbreitung elektronischer Lesegeräte an Bedeutung. So ist z.B. HTML an einem Tablett oder Handy besser zu lesen als eine PDF-Datei. Ein wesentlicher Grund ist, dass bei HTML Zeilenumbrüche flexibel sind, z.B. je nach Größe des Displays. Bei PDF-Dateien ist dies fix. 


>    Das Dokument sollte optisch ansprechend formatiert sein.

Das Werkzeug sollte - idealerweise als Standard ohne Eingriffe des Nutzers - optisch ansprechende Dokumente erzeugen. Dazu gehört vor allem schöner Schriftsatz: keine hässlichen Löcher zwischen Wörtern oder zwischen Buchstaben, elegante Schriftsätze oder schöne Formeln. Für HTML-Dateien sind "coole" Designs - z.B. mit benuterfreundlicher Navigationsspalte - sinnvoll.


>    Das Werkzeug sollte übergreifend (Betriebssysteme, Zeiten, Versionen) arbeiten.

Ärgerlich ist, wenn das Werkzeug nur für bestimmte Betriebssysteme (oder Versionen davon) funktioniert. Nicht so schlimm, aber auch nervig ist, wenn die Varianten eines Werkzeugs zwar übergreifend funktionieren, aber nicht *ganz* gleich sind - wenn z.B. Farben sich ändern oder Textfelder verrutschen. Auch in ein paar Jahren sollten die Dateien noch lesbar sein. 


>    Das Werzeug sollte mächtig (funktionsreich) sein.

Die Quadratur des Kreises: Ein Werkzeug sollte einfach zu bedienen sein, aber mächtig, also einen großen Funktionsumfang besitzen. Beide Ziele sind nicht leicht unter einen Hut zu bringen und vielleicht das Grundproblem von Benutzerfreundlichkeit von Computersystemen. Eine pragmatische Lösung ist es (oder sollte sein), dem Nutzer vernünftige Standardwerte anzubieten bzw. diese ungefragt anzuwenden aber gleichzeitig dem Nutzer die Möglichkeit geben, in viele Details einzugreifen. Letzteres ist häufig kompliziert(er), aber für viele Nutzer nicht nötig, wenn die Standards gut sind.


>   Das Werkzeug sollte frei (quelloffen sowie ggf. kostenfrei) sein.

Als "Normalnutzer" denken Sie vielleicht: "Ist mir doch egal, ob das Werkzeug von Firma XYZ angeboten wird, kauf ich mir halt!. Das ist in einigen Fällen stimmig. Aber: Die Erfahrung zeigt, dass einige quelloffenen Software tendenziell schneller weiterentwickelt wird (oder Fehler beseitigt werden). Fortgeschrittene Nutzer können so einfach ihre Ideen zur Verfügung stellen. Das geht viel schneller (in der Regel) als wenn es bei einem Konzern durch die Instanzen sickern muss. R ist bestes Beispiel dafür. Außerdem: Manche Werkzeuge der Datenanalyse sind *sehr* teuer; da ist es schön, wenn man (bessere) Leistung kostenfrei bekommt! Nicht jeder ist mit ausreichend Finanzmitteln gesegnet... "Offen" beinhaltet in dem Zusammenhang idealerweise auch, dass die Quelldateien menschenlesbar sind, also reine Text-Dateien. Damit kann jeder, auch ohne ein bestimmtes Werkzeug zu nutzen, die Quelldatei lesen. Reine Textdateien haben wohl von allen Datei-Formaten die beste Aussicht, in 10, 20, 50 oder 100 Jahren noch lesbar zu sein.


>    Das Werkzeug sollte Kollaboration leicht machen.

Mit Kollaboration ist gemeint, Sie schreiben einen Bericht sagen wir mit 5 Kollegen. Eine beliebte Variante der Zusammenarbeit ist dabei, dass Sie Ihren Entwurf an die Kollegen senden mit der Bitte um Hinweise, Korrekturen oder Überarbeitung. Netterweise bekommen Sie 6 Versionen zurück (ein Kollege schrieb 3 Mails, sie wusste dann selber nicht mehr warum, dafür meldete sich ein Kollege gar nicht). Ihnen bleibt die glorreiche Aufgabe, diese 6+1 Dokumente zusammenzuführen. Natürlich widersprechen sich die Hinweise der Kollegen, die in Unkenntnis der Hinweise der anderen entstanden... Außerdem nutzten nicht alle die selbe Methode für ihre Hinwese. Kurz: Nach einigen Schreikrämpfen müssen Sie erstmal Spazieren gehen. Schöner wäre ein zentrales Dokument, an dem alle arbeiten. So kann jeder den aktuellen Stand sehen und idealerweise auch die Änderungen der Kollegen (oder die eigenen Änderungen) einsehen. Einfache Werkzeuge dafür sind z.B. Google Docs oder der Drobox, welche Versionierungsfunktionen bietet. Besser (aber komplexer in der Bedienung) sind spezielle Versionierungs-Werkzeuge. Das bekannteste heißt "Git"[^97].


>    Das Werkzeug sollte Versionierungen und Änderungsverfolgung unterstützen.

Ähnlich zur Kolloboration ist die Versionierung. Hier geht es darum, die Entwicklungshistorie eines Dokuments nachvollziehen zu können. Das ist umso wichtiger, je größer das Dokument bzw. das Projekt zu dem Dokument ist. Eine studentische Abschlussarbiet ist ein gutes Beispiel, aber viele Berichte in Unternehmen taugen auch als Beispiel. Haben Sie schon mal Dateinamen gesehen wie "Bericht_V23_Korrektur_Edit_Willi_Final_2017-02-23_v3_final_Ergänzung.pdf"? Ich gebe zu, das Beispiel ist bewusst auf die Spitze getrieben, aber es schält die Problematik gut heraus. Der Änderungsmodus von MS-Word und ähnlichen Werkzeugen ist hilfreich für eine begrenzte Anzahl von Änderungen. Wurde aber eine bestimmte Passage mehrfach geändert, so kommt dieses Funktionalität schnell an ihre Grenzen. Kurz: Bei wichtigeren oder komplexeren Dokumenten ist eine professionelle Lösung sinnvoll.


RMarkdown erfüllt diese Forderungen. Nicht perfekt, aber besser wohl als jedes andere Werkzeug. Daher ist es ein sehr wertvolles Werkzeug, das Sie kennen sollten, wenn Sie Berichte mit Ergebnissen von Datenanalysen schreiben.

## Bevor es losgeht

RMarkdown wird als Teil von RStudio mitgeliefert, kostenlos und großteils quelloffen. Es ist bereits installiert, wenn Sie RStudio installiert haben.

Der Name "RMarkdown" suggeriert, dass R in eine Rolle spielt. Das ist richtig. Doch was heißt "Markdown"? Der Name rührt von der Idee von Auszeichnungssprachen (engl. "markup languages") her. Auszeichnungssprachen sind, einfach gesgat, ein paar Befehle, die man in einen Text hineinschreibt, um den Text zu formatieren. Der Text ist also eine Mischung von Inhalt und Formatierungszeichen. HTML oder TeX sind bekannte Auszeichnungsprachen. Beide sind aber recht komplex, bzw. der Text sieht aus wie Kraut und Rüben vor lauter Auszeichnungsbefehlen. Markdown will anders sein, einfacher. Daher keine "Markup-", sondern eine "Markdown-"Sprache. Vor "Sprache" braucht man sich hier nicht beunruhigen zu lassen. Die "Sprache" Markdown ist in 10 Minuten gelernt!

RMarkdown-Dateien haben sinnvollerweise die Endung `.Rmd`. Rmd-Dateiein sind, genau wie normale Markdown-Dateien, schnöde Text-Dateien und können entsprechend von jedem Text-Editor (auch mit RStudio, das hier mit Syntax-Highlighting verwöhnt) geöffnet werden. 


## RMarkdown in Action

Werden wir praktisch! Ein Beispiel zur Arbeit mit Markdown. 

- Öffnen Sie RStudio.

- Klicken Sie das Icon für "neue Datei" und wählen Sie "R Markdown...", um eine neue RMarkdown-Datei zu erstellen.
<div class="figure" style="text-align: center">
<img src="images/new_rmd.png" alt="Neue Rmd-Datei erstellen" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-3)Neue Rmd-Datei erstellen</p>
</div>

- Es öffnet sich eine Maske, die Sie fragt, welche Art von Rmd-Datei Sie öffnen möchten. Lassen Sie alle Voreinstellungen, wie Sie sind und klicken Sie auf "OK".

<div class="figure" style="text-align: center">
<img src="images/new_md2.png" alt="Optionen für neue Rmd-Dateien" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-4)Optionen für neue Rmd-Dateien</p>
</div>

- Dann öffnet sich eine einfache Rmd-Datei, die nicht ganz leer ist, sondern aus didaktischen Gründen ein paar einfache, aber typische, Rmd-Befehle enthält. Schauen Sie sich den Inhalt kurz an; Sie sehen eine Mischung aus "Prosa" und R. 

- Jetzt "verstricken" wir R und Prosa zu einer Datei, HTML in dem Fall, welche sowohl Text, R-Ausgaben als auch R-Syntax enthält. Dafür klicken wir auf das Stricknadel-Icon:

<div class="figure" style="text-align: center">
<img src="images/rmd_demo.png" alt="Wir stricken" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-5)Wir stricken</p>
</div>

- Ach ja, RStudio bittet Sie noch, die Rmd-Datei zu speichern. Tun Sie RStudio den Gefallen.

- Als Ergebnis müsste sich im Reiter "Viewer" das Ergebnis zeigen. Sie haben eine, vielleicht Ihre erste HTML-Datei aus einer Rmd-Datei erstellt. Verweilen Sie in Andacht. Sie können sich das Ergebnis, die HTML-Datei im Browser anschauen, in dem Sie betreffende HTML-Datei im Browser öffnen (diese liegt dort, wo auch die zugehörige Rmd-Datei liegt.)

<div class="figure" style="text-align: center">
<img src="images/rmd_all_panes.png" alt="HTML-Datei aus Rmd-Datei erstellt!" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-6)HTML-Datei aus Rmd-Datei erstellt!</p>
</div>


## Die Arbeitsschritte mit RMarkdown

Die Arbeitsschritte mit RMarkdown von den ersten Gedanken bis zum fertigen Bericht kann man so zusammenfassen.

<div class="figure" style="text-align: center">
<img src="images/Rmarkdown_flow.pdf" alt="Die Arbeitsschritte mit RMarkdown" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-7)Die Arbeitsschritte mit RMarkdown</p>
</div>


Zuerst bietet es sich an - ganz ohne Gedanken an wohl geformte Sprache und roten Faden - seine Gedanken zu Papier (oder in eine Textdatei) zu kriegen ("Ideen sammeln"). Für viele Menschen sind hier Schmier- und Notizzettel oder Schemata, Mindmaps oder andere Visualisierungen hilfreich. Eine Gliederung zu erstellen gehört auch in diesen Schritt. Hat man schließlich die Struktur erarbeitet, so kann den Text - jetzt mit wohlgeformter(er) Sprache und roten Faden - zusammensetzen ("Text schreiben"). Dabei ist es oft so, dass man die Beiträge der Coautoren ~~ertragen muss~~ integrieren möchte. Dies ist mit am besten mit einer zusätzlichen Software mit dem Namen "Git" bzw. "Github" zu erreichen, die ebenfalls quelloffen, kostenlos (und weit verbreitet bei Tekkies) ist ("Coautoren integrieren"). Diese Software erlaubt nicht nur Versionierung lokal an einem eigenen Computer, sondern auch in Zusammenarbeit mit Coautoren ("Änderungen nachverfolgen"). Parallel zum Schreiben des Textes sind die Daten zu analysieren; eine Aufgabe, die prinzipiell unahbängig vom Schreiben des Textes ist ("Daten analysieren"). Aber die Ergebnisse der Analyse sind in den Text zu integrieren. Um Schnittstellen zu vermeiden, ist es sinnvoll, den Inhalt-Text sowie die R-Syntax in einer Datei zu "verstricken". Dieser Schritt ("R ausführen") wird von einem R-Paket namens "knitr" [@xie2015] besorgt (engl. "to knit" - stricken). Knitr führt die R-Syntax im Dokument aus und liefert das Ergebnis im Markdown-Format zurück. Aus R+Markdown wird reines Markdown. Die Markdown-Datei kann nun in fast jedes denkbare andere Markup-Format übersetzt werden, die wichtigsten sind HTML und TeX. Die Übersetzung führt RStudio wiederum, genau wie das "Knittern" für uns komfortabel im Hintergrund aus. Dazu wird auf ein Programm names "pandoc"[^124] zurückgegriffen. Pandoc übersetzt eine Markup-Sprache in eine andere. Haben wir z.B. in TeX übersetzt, so können wir - vorausgesetzt TeX, LaTeX o.ä. ist installiert - von TeX in PDF umwandeln lassen. Ist TeX auf Ihrem Rechner installiert, so wird dieser Übersetzung wiederum automatisch vorgenommen.











[^97]: https://de.wikipedia.org/wiki/Git, https://git-scm.comm, https://github.com

[^124]: http://pandoc.org 
