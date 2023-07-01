import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'miniApps/BmiCalculator.dart';
import 'miniApps/BmrCalculator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> ciekawostkiODietach = [
    "Dieta ketogeniczna indukuje stan ketozy, w którym organizm spala tłuszcz jako główne źródło energii.",
    "Dieta śródziemnomorska, bogata w owoce, warzywa, pełnoziarniste produkty zbożowe i zdrowe tłuszcze, jest uważana za zdrowy sposób odżywiania.",
    "Dieta wegetariańska wyklucza spożywanie mięsa i ryb, skupiając się na roślinach, nabiale i jajach.",
    "Dieta wegańska wyklucza spożywanie wszelkich produktów pochodzenia zwierzęcego, w tym mięsa, ryb, nabiału, jaj i miodu.",
    "Dieta bezglutenowa jest konieczna dla osób z nietolerancją glutenu, taką jak celiakia.",
    "Dieta paleo naśladuje sposób odżywiania się naszych przodków, opierając się na naturalnych i nieprzetworzonych składnikach.",
    "Dieta surowa (raw food) polega na spożywaniu głównie surowych, nieprzetworzonych produktów.",
    "Dieta bez laktozy wyklucza spożywanie nabiału lub produktów zawierających laktozę.",
    "Dieta niskowęglowodanowa ogranicza spożycie węglowodanów, często skupiając się na białkach i zdrowych tłuszczach.",
    "Dieta niskokaloryczna polega na ograniczeniu spożycia kalorii w celu utraty wagi.",
    "Dieta DASH została opracowana jako sposób na obniżenie ciśnienia krwi poprzez zdrowe odżywianie.",
    "Dieta medyterranejska promuje spożywanie świeżych owoców, warzyw, ryb, orzechów i oliwy z oliwek.",
    "Dieta flexitarian to elastyczne podejście do jedzenia, które skupia się na roślinach, ale pozwala na okazjonalne spożywanie mięsa.",
    "Dieta bez cukru ogranicza lub wyklucza spożywanie cukru i produktów zawierających dodany cukier.",
    "Dieta niskotłuszczowa polega na ograniczeniu spożycia tłuszczów, szczególnie nasyconych i trans.",
    "Dieta o niskim indeksie glikemicznym skupia się na spożywaniu pokarmów, które powodują wolne i stabilne podnoszenie poziomu glukozy we krwi.",
    "Dieta bogata w błonnik przynosi wiele korzyści dla zdrowia, takich jak utrzymanie prawidłowej wagi i poprawa trawienia.",
    "Dieta bez soli polega na ograniczeniu spożycia sodu i soli kuchennej, co jest korzystne dla osób z nadciśnieniem.",
    "Dieta bez laktozy wyklucza spożywanie nabiału lub produktów zawierających laktozę.",
    "Dieta sokowa polega na spożywaniu świeżo wyciskanych soków owocowych i warzywnych, często w ramach detoksu organizmu.",
    "Dieta pescetariańska to dieta, w której wyklucza się mięso, ale pozwala się na spożywanie ryb i owoców morza.",
    "Dieta makrobiotyczna opiera się na zasadzie równowagi yin i yang oraz spożywaniu naturalnych, niewyszukanych produktów.",
    "Dieta bezglutenowa nie tylko jest konieczna dla osób z celiakią, ale także może być stosowana przez osoby z nietolerancją glutenu lub w celu poprawy zdrowia jelit.",
    "Dieta bezmleczna eliminuje spożywanie zarówno nabiału, jak i innych produktów mlecznych.",
    "Dieta owocowo-warzywna polega na spożywaniu głównie owoców, warzyw i soków, często w formie detoksu lub oczyszczania organizmu.",
    "Dieta wysokobiałkowa skupia się na spożywaniu większej ilości białka, co może być korzystne dla osób aktywnych fizycznie lub dążących do budowy mięśni.",
    "Dieta kwasnoprzetworowa ogranicza spożycie żywności kwasotwórczej, takiej jak mięso, nabiał, rafinowane produkty zbożowe i słodycze.",
    "Dieta bezglutenowa może wymagać uważnego czytania etykiet produktów, ponieważ wiele spożywczych produktów przetworzonych zawiera gluten jako składnik.",
    "Dieta eliminacyjna polega na wykluczeniu potencjalnie uczulających lub nietolerowanych pokarmów w celu ustalenia ich wpływu na zdrowie.",
    "Dieta wysokotłuszczowa, znana również jako dieta ketogeniczna, polega na spożywaniu wysokiej zawartości tłuszczu, umiarkowanej ilości białka i niskiej ilości węglowodanów w celu indukcji stanu ketozy.",
    "Dieta eliminacyjna FODMAP może pomóc w łagodzeniu objawów zespołu jelita drażliwego poprzez eliminację pokarmów bogatych w fermentowalne węglowodany.",
    "Białko jest niezwykle ważne dla budowy i naprawy tkanek w organizmie, takich jak mięśnie, skóra, kości i narządy.",
    "Białko składa się z aminokwasów, które są podstawowymi jednostkami budulcowymi białek.",
    "Niektóre bogate źródła białka to mięso, ryby, jaja, nabiał, orzechy i nasiona.",
    "Spożycie odpowiedniej ilości białka może pomóc w utrzymaniu uczucia sytości i wspierać proces odchudzania.",
    "Białko jest niezbędne dla prawidłowego funkcjonowania układu immunologicznego i transportu substancji w organizmie.",
    "Węglowodany są głównym źródłem energii dla organizmu.",
    "Istnieją dwa główne rodzaje węglowodanów: proste (np. cukry) i złożone (np. skrobia i błonnik).",
    "Zdrowe źródła węglowodanów obejmują owoce, warzywa, pełnoziarniste produkty zbożowe i strączkowe.",
    "Węglowodany są szczególnie istotne dla osób aktywnych fizycznie, ponieważ dostarczają paliwa potrzebnego do wykonywania intensywnych treningów.",
    "Unikaj nadmiernego spożycia prostych węglowodanów, takich jak słodycze i napoje gazowane, ponieważ mogą powodować nagły wzrost poziomu cukru we krwi.",
    "Tłuszcze są ważnym składnikiem diety, ale powinny być spożywane w umiarkowanych ilościach.",
    "Istnieją różne rodzaje tłuszczów, w tym tłuszcze nasycone, tłuszcze jednonienasycone i tłuszcze wielonienasycone.",
    "Tłuszcze jednonienasycone i wielonienasycone (np. zawarte w oliwie z oliwek, awokado, orzechach i nasionach) są korzystne dla zdrowia serca.",
    "Spożycie nadmiaru tłuszczów nasyconych (znajdujących się głównie w produktach zwierzęcych) może zwiększać ryzyko chorób serca.",
    "Tłuszcze są niezbędne do wchłaniania niektórych witamin rozpuszczalnych w tłuszczach, takich jak witamina A, D, E i K.",
    "Kaloria jest jednostką energii dostarczaną przez żywność.",
    "Spożywanie większej liczby kalorii, niż organizm potrzebuje, może prowadzić do przyrostu masy ciała.",
    "Różne rodzaje żywności mają różną gęstość kaloryczną. Na przykład, tłuste potrawy mogą mieć więcej kalorii niż produkty o niskiej zawartości tłuszczu, pomimo podobnej objętości.",
    "Równowaga energetyczna, czyli dostosowanie spożycia kalorii do zapotrzebowania organizmu, jest ważna dla utrzymania zdrowej wagi.",
    "Ważne jest świadome spożywanie kalorii i wybieranie produktów bogatych w składniki odżywcze, takie jak warzywa, owoce, pełnoziarniste produkty zbożowe i źródła białka o niskiej zawartości tłuszczu.",
  "Witaminy są niezbędne dla prawidłowego funkcjonowania organizmu. Pomagają regulować procesy metaboliczne, wzmacniają układ odpornościowy i wspierają zdrowie ogólne.",
  "Istnieje kilka grup witamin, takich jak witaminy A, B, C, D, E i K, z których każda pełni różne funkcje i występuje w różnych źródłach żywności.",
  "Niektóre witaminy są rozpuszczalne w wodzie (np. witaminy C i B) i są łatwo usuwane z organizmu, dlatego ważne jest regularne spożywanie żywności bogatej w te witaminy."
  "Inne witaminy są rozpuszczalne w tłuszczach (np. witamina A, D, E i K) i są magazynowane w organizmie, co oznacza, że nie muszą być spożywane codziennie.",
  "Niedobór witamin może prowadzić do różnych problemów zdrowotnych, takich jak osłabienie układu odpornościowego, problemy z widzeniem, anemia czy choroby skórne.",
  "Makroelementy to składniki odżywcze, które są potrzebne w większych ilościach przez organizm.",
  "Najważniejsze makroelementy to wapń, magnez, potas, sód, fosfor i chlor.",
  "Wapń jest niezbędny do budowy i utrzymania mocnych kości i zębów.",
  "Magnez jest ważny dla zdrowia serca, funkcji mięśni, układu nerwowego i procesów metabolicznych.",
  "Potas, sód i chlor są elektrolitami, które regulują równowagę płynów w organizmie i są niezbędne dla prawidłowego funkcjonowania mięśni i układu nerwowego.",
  "Fosfor jest kluczowym składnikiem budulcowym kości i zębów, a także pełni ważną rolę w procesach metabolicznych.",
  "Wiele żywności, takich jak mleko i produkty mleczne, warzywa liściaste, owoce, orzechy i nasiona, jest bogatych w makroelementy.",
  "Nadmiar soli, która zawiera sód i chlor, może prowadzić do wzrostu ciśnienia krwi i zwiększenia ryzyka chorób serca.",
  "Regularne spożywanie żywności bogatej w wapń, magnez i potas może pomóc w utrzymaniu zdrowego układu kostnego, funkcji mięśni i równowagi elektrolitowej.",
  "Warto dbać o zrównoważoną dietę, która zapewni odpowiednie spożycie witamin i makroelementów, aby wspierać zdrowie i dobre samopoczucie."
  ];
  String randomCiekawostka = '';

  @override
  void initState() {
    super.initState();
    final random = Random();
    randomCiekawostka =
    ciekawostkiODietach[random.nextInt(ciekawostkiODietach.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Witaj!',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Lottie.asset('assets/animations/happy_fruit.json',
              width: 200, height: 200),
          Container(
            width: double.infinity,
            child: Card(
              color: const Color(0xFF4FAD79),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                      'Czy wiesz, że ...',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 10),
                    child: Text(
                      randomCiekawostka,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Twoje mini-aplikacje",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BmrCalculator()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.calculate_rounded,
                        size: 64,
                        color: const Color(0xFF2E8B57),
                      ),
                      Text(
                        "BMR",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BmiCalculator()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.compare,
                        size: 64,
                        color: const Color(0xFF2E8B57),
                      ),
                      Text(
                        "BMI",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}