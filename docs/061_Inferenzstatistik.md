
# Der p-Wert


\BeginKnitrBlock{rmdcaution}<div class="rmdcaution">Lernziele:

- Den p-Wert erläutern können.
- Den p-Wert kritisieren können.
- Den p-Wert auf Basis von Simulationen berechnen können.
- Grundlegende Inferenzstatistiken für metrische Variablen berechnen können.
- Grundlegende Inferenzstatistiken für nominale Variablen berechnen können.

</div>\EndKnitrBlock{rmdcaution}



<div class="figure" style="text-align: center">
<img src="images/Ronald_Fisher.jpg" alt="Der größte Statistiker des 20. Jahrhunderts (p &lt; .05)" width="10%" />
<p class="caption">(\#fig:sir-fisher)Der größte Statistiker des 20. Jahrhunderts (p < .05)</p>
</div>

## Der p-Wert sagt nicht das, was viele denken


Der p-Wert, entwickelt von Sir Ronald Fisher (Abb. \@ref(fig:sir-fisher)), ist die heilige Kuh der Forschung. Das ist nicht normativ, sondern deskriptiv gemeint. Der p-Wert entscheidet (häufig) darüber, was publiziert wird, und damit, was als Wissenschaft sichtbar ist - und damit, was Wissenschaft ist (wiederum deskriptiv, nicht normativ gemeint). Kurz: Dem p-Wert wird viel Bedeutung zugemessen. 


<div class="figure" style="text-align: center">
<img src="images/p_value_who_said.png" alt="Der p-Wert wird oft als wichtig erachtet" width="234" />
<p class="caption">(\#fig:who-said)Der p-Wert wird oft als wichtig erachtet</p>
</div>


Was sagt uns der p-Wert? Eine gute intuitive Definition ist:

>    Der p-Wert sagt, wie gut die Daten zur Nullhypothese passen.


Je größer p, desto besser passen die Daten zur Nullhypothese.

Allerdings hat der p-Wert seine Probleme. Vor allem: Er wird missverstanden. Jetzt kann man sagen, dass es dem p-Wert (dem armen) nicht anzulasten, dass andere/ einige ihm missverstehen. Auf der anderen Seite finde ich, dass sich Technologien dem Nutzer anpassen sollten (soweit als möglich) und nicht umgekehrt. Die (genaue) Definition des p-Werts ist aber auch so kompliziert, man kann sie leicht missverstehen:

> Der p-Wert gibt die Wahrscheinlichkeit P unserer Daten D an (und noch extremerer), unter der Annahme, dass die getestete Hypothese H wahr ist (und wenn wir den Versuch unendlich oft wiederholen würden, unter identischen Bedingungen und ansonsten zufällig).
p = P(D|H)

Viele Menschen - inkl. Professoren und Statistik-Dozenten - haben Probleme mit dieser Definition [@Gigerenzer2004]. Das ist nicht deren Schuld: Die Definition ist kompliziert. Vielleicht denken viele, der p-Wert sage das, was tatsächlich interessant ist: die Wahrscheinlichkeit der (getesteten) Hypothese H, gegeben der Tatsache, dass bestimmte Daten D vorliegen. Leider ist das *nicht* die Definition des p-Werts. Also:

$$ P(D|H) \ne P(H|D) $$


Formeln haben die merkwürdige Angewohnheit vor dem inneren Auge zu verschwimmen; Bilder sind für viele Menschen klarer, scheint's. Übersetzen wir die obige Formel in folgenden Satz:

>   Wahrscheinlichkeit, Moslem zu sein, wenn man Terrorist ist UNGLEICH zur 
Wahrscheinlichkeit, Terrorist zu sein, wenn man Moslem ist.


Oder kürzer:


$$ P(M|T) \ne P(T|M) $$


Als Bild:

![](images/moslems_terroristen_crop.pdf)<!-- -->


## Weitere Kritik am p-Wert

Der p-Wert ist für weitere Dinge kritisiert worden [@Wagenmakers2007, @uncertainty]; z.B. dass die "5%-Hürde" einen zu schwachen Test für die getestete Hypothese bedeutet. Letzterer Kritikpunkt ist aber nicht dem p-Wert anzulasten, denn dieses Kriterium ist beliebig, könnte konservativer gesetzt werden und jegliche mechanisierte Entscheidungsmethode kann ausgenutzt werden. Ähnliches kann man zum Thema "P-Hacking" argumentieren [@Head2015, @Wicherts2016]; andere statistische Verfahren können auch gehackt werden.

Ein wichtiger Anklagepunkt lautet, dass der p-Wert nicht nur eine Funktion der Effektgröße ist, sondern auch der Stichprobengröße. Sprich: Bei großen Stichproben wird jede Hypothese signifikant. Damit verliert der p-Wert an Nützlichkeit. Die Verteitigung argumentiert hier, dass das "kein Bug, sondern ein Feature" sei: Wenn man z.B. die Hypothese prüfe, dass der Gewichtsunteschied zwischen Männern und Frauen 0,000000000kg sei und man findet 0,000000123kg Unterschied, ist die getestete Hypothese falsch. Punkt. Der p-Wert gibt demnach das korrekte Ergebnis. Meiner Ansicht nach ist die Antwort zwar richtig, geht aber an den Anforderungen der Praxis vorbei.

Meine Meinung ist, dass der p-Wert ein problematisch ist (und ein Dinosaurier) und nicht oder weniger benutzt werden sollte (das ist eine normative Aussage). Da der p-Wert aber immer noch der Platzhirsch auf vielen Forschungsauen ist, führt kein Weg um ihn herum. Er muss genau verstanden werden: Was er sagt und - wichtiger noch - was er nicht sagt.


<img src="images/meme_pwert_1iw22a_pvalue_dino.jpg" width="250" style="display: block; margin: auto;" />




