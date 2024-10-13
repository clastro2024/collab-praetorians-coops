
Var
{	
  
  // estrategias y tacticas
  handle hCivCatuvelaunos         = NULL;
  handle hCivAtrebates            = NULL;
  handle hCivCantiacos            = NULL;
  handle hCivTrinovantes          = NULL;
  handle hEstCatuvelaunos         = NULL;
  handle hEstAtrebates            = NULL;
  handle hEstCantiacos            = NULL;
  handle hEstTrinovantes          = NULL;

  handle hObjAtaqueInicial        = NULL;
  handle hObjAtaqueLateral        = NULL;

  handle hObjIATamesis1           = NULL;
  handle hObjIATamesis2           = NULL;
  handle hObjIATamesis3           = NULL;
  handle hObjIATamesis4           = NULL;
  handle hObjIACon1               = NULL;
  handle hObjIACon2               = NULL;
  handle hObjIACon3               = NULL;
  handle hObjIACon4               = NULL;
  handle hObjIAPatrullas          = NULL;
  
  handle hObjIAPatrullasAT        = NULL;
  handle hObjIAPatrullasCA        = NULL;
  handle hObjIAPatrullasTR        = NULL;

    
  // bandos rebotados con el jugador
  bool bAtrebatesRebotados        = FALSE;
  bool bCantiacosRebotados        = FALSE;
  bool bTrinovantesRebotados      = FALSE;
  
  // bandos que se han acojonao
  bool bAtrebatesAcojonados       = FALSE;
  bool bCantiacosAcojonados       = FALSE;
  bool bTrinovantesAcojonados     = FALSE;
  
  // briefing
  float fPuntoSincronia           = 0;
  handle hPuntoSincronia          = NULL;
  bool bBriefingEnded             = NULL;
  
  // objetivos de misión
  handle hObjCayoVivo             = NULL;
  handle hObjComioVivo            = NULL;
  handle hObjCampamento           = NULL;
  handle hObjCassivelauno         = NULL;
  
  // niveles de dificultad
  float fNivelDificultad          = 0;
  
}

#include "FunScript.h"


// *******************************************************************
// ***********************   MAIN   **********************************
// *******************************************************************
Trigger "Main" [ Activo ]  
(
  TRUE
)
Do
{

  // tips de la misión
  IntroducirTip("LTEXT_TIP0_TEXTO", "LTEXT_TIP0_TITULO");
  IntroducirTip("LTEXT_TIP1_TEXTO", "LTEXT_TIP1_TITULO");
  IntroducirTip("LTEXT_TIP2_TEXTO", "LTEXT_TIP2_TITULO");
  IntroducirTip("LTEXT_TIP3_TEXTO", "LTEXT_TIP3_TITULO");
  IntroducirTip("LTEXT_TIP4_TEXTO", "LTEXT_TIP4_TITULO");
  IntroducirTip("LTEXT_TIP5_TEXTO", "LTEXT_TIP5_TITULO");
  IntroducirTip("LTEXT_TIP6_TEXTO", "LTEXT_TIP6_TITULO");
  IntroducirTip("LTEXT_TIP7_TEXTO", "LTEXT_TIP7_TITULO");
  IntroducirTip("LTEXT_TIP8_TEXTO", "LTEXT_TIP8_TITULO");
  IntroducirTip("LTEXT_TIP9_TEXTO", "LTEXT_TIP9_TITULO");
  IntroducirTip("LTEXT_TIP10_TEXTO", "LTEXT_TIP10_TITULO");
  
  // alianzas
  CrearAlianzaPorNombre("CATUVELAUNOS", "ATREBATES");
  CrearAlianzaPorNombre("CATUVELAUNOS", "CANTIACOS");
  CrearAlianzaPorNombre("CATUVELAUNOS", "TRINOVANTES");
  
  // tu quieto
  OrdenarTropaMantenerPosicion("CASSIVELAUNO", TRUE);
  
  ActivarTrigger("Briefing");
  
}



Trigger "Main2" [Inactivo]
(
  TRUE
)
Var
{
  handle  hTimer;
  bool    bEntrenarCatuvelaunos;
  bool    bEntrenarDemas;
  float   fDelay;
}
Do
{

  // que se vean los pueblos de su color  
  IluminarZonaOnOff(18, 2, 136, 20, "casiovelauno", TRUE);
  IluminarZonaOnOff(160, 0, 135, 20, "pueblo1", TRUE);
  IluminarZonaOnOff(104, 0, 42, 20, "pueblo2", TRUE);
  IluminarZonaOnOff(75, 2, 126, 20, "pueblo3", TRUE);

  IluminarZonaOnOff(18, 2, 136, 20, "casiovelauno", FALSE);
  IluminarZonaOnOff(160, 0, 135, 20, "pueblo1", FALSE);
  IluminarZonaOnOff(104, 0, 42, 20, "pueblo2", FALSE);
  IluminarZonaOnOff(75, 2, 126, 20, "pueblo3", FALSE);


  
  //restricciones de maquinas da asalto
  IntroducirRestriccionUnidad("ORDEN_CONSTRUIR", "ESCALA_BARBARA", "");
  IntroducirRestriccionUnidad("ORDEN_CONSTRUIR", "ESCALA_ROMANA", "");
  IntroducirRestriccionUnidad("ORDEN_CONSTRUIR", "ESCALA_EGIPCIA", "");
  IntroducirRestriccionUnidad("ORDEN_CONSTRUIR", "TORRE_ASALTO_EGIPCIA", "");
  IntroducirRestriccionUnidad("ORDEN_CONSTRUIR", "TORRE_ASALTO_BARBARA", "");
  IntroducirRestriccionUnidad("ORDEN_CONSTRUIR", "TORRE_ASALTO_ROMANA", "");  
  
  // Restricciones de reclutamiento
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "CABALLERIA_GERMANA", "");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_ESPADON", "");
    
  // Romanos: no pueden reclutar gladiadores ni pretorianos
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GLADIADOR", "CESAR");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "PIQUERO_ELITE", "CESAR");
    
  // Atrebates: no pueden reclutar ni caballerias  ni  espadones ni piqeruos
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_CABALLERIA_PESADA", "ATREBATES");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_CABALLERIA_ARQUERA", "ATREBATES");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "CABALLERIA_GERMANA", "ATREBATES");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_ESPADON", "ATREBATES");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_PIQUERO", "ATREBATES");
    
  // Cantiacos: no pueden reclutar espadones ni infanteria pesada ni cazadores
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_ESPADON", "CANTIACOS");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_CAZADOR", "CANTIACOS");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_PESADA", "CANTIACOS");
  
  // Trinovantes: no pueden reclutar caballerias ni cazadores
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_CABALLERIA_PESADA", "TRINOVANTES");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_CABALLERIA_ARQUERA", "TRINOVANTES");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "CABALLERIA_GERMANA", "TRINOVANTES");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_CAZADOR", "TRINOVANTES");
  
  // Catuvelaunos: no pueden reclutar cazadores ni espadones ni caballeria germana
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_ESPADON", "CATUVELAUNOS");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "GALO_CAZADOR", "CATUVELAUNOS");
  IntroducirRestriccionUnidad("ORDEN_ENTRENAR_TROPAS", "CABALLERIA_GERMANA", "CATUVELAUNOS");
  
  // niveles de dificultad
  fNivelDificultad = DarDificultadMision();
  
  if ( fNivelDificultad == 1 )
  {
    bEntrenarDemas = FALSE;
    bEntrenarCatuvelaunos = FALSE;
    fDelay = 0;
  }
  else
  if ( fNivelDificultad == 2 )
  {
    bEntrenarDemas = FALSE;
    bEntrenarCatuvelaunos = TRUE;
    fDelay = 120;
   }
  else
  if ( fNivelDificultad == 3 )
  {
    bEntrenarDemas = TRUE;
    bEntrenarCatuvelaunos = TRUE;
    fDelay = 60;
  }
  else
  {
    MensajeChat("Nivel de dificultad chungo, oiga", fNivelDificultad);
    bEntrenarDemas = TRUE;
    bEntrenarCatuvelaunos = TRUE;
    fDelay = 90;
  }
  
  // objetivos
  hObjCayoVivo      = CrearHandle("Bool");
  hObjComioVivo     = CrearHandle("Bool");
  hObjCampamento    = CrearHandle("Bool");
  hObjCassivelauno  = CrearHandle("Bool");
  
  AgregarObjetivoMision(hObjCassivelauno, "LTEXT_MISION12_OBJETIVO_00_TXT");
  AgregarObjetivoMision(hObjCampamento, "LTEXT_MISION12_OBJETIVO_01_TXT");
  AgregarObjetivoMision(hObjCayoVivo, "LTEXT_MISION12_OBJETIVO_02_TXT");
  AgregarObjetivoMision(hObjComioVivo, "LTEXT_MISION12_OBJETIVO_03_TXT");

  // inicializamos estrategias
  hCivCatuvelaunos = DarCivilizacion("CATUVELAUNOS");
  hEstCatuvelaunos = CrearEstrategiaScript();
  AsignarEstrategia(hCivCatuvelaunos, hEstCatuvelaunos);
  StartEstrategia(hEstCatuvelaunos);

  hCivAtrebates = DarCivilizacion("ATREBATES");
  hEstAtrebates = CrearEstrategiaScript();
  AsignarEstrategia(hCivAtrebates, hEstAtrebates);
  StartEstrategia(hEstAtrebates);

  hCivCantiacos = DarCivilizacion("CANTIACOS");
  hEstCantiacos = CrearEstrategiaScript();
  AsignarEstrategia(hCivCantiacos, hEstCantiacos);
  StartEstrategia(hEstCantiacos);

  hCivTrinovantes = DarCivilizacion("TRINOVANTES");
  hEstTrinovantes = CrearEstrategiaScript();
  AsignarEstrategia(hCivTrinovantes, hEstTrinovantes);
  StartEstrategia(hEstTrinovantes);
    
  // tacticas y objetivos
  hObjIATamesis1 = CrearObjetivo(hEstCatuvelaunos, "DefenderPosicion");
  AnyadirGrupoAObjetivo(hObjIATamesis1, "CATUVELAUNOS_ALIADOS");
  AnyadirObjetivo(hEstCatuvelaunos, hObjIATamesis1);

  hObjIATamesis2 = CrearObjetivo(hEstAtrebates, "DefenderPosicion");
  AnyadirGrupoAObjetivo(hObjIATamesis2, "ATREBATES_ALIADOS");
  AnyadirObjetivo(hEstAtrebates, hObjIATamesis2);

  hObjIATamesis3 = CrearObjetivo(hEstCantiacos, "DefenderPosicion");
  AnyadirGrupoAObjetivo(hObjIATamesis3, "CANTIACOS_ALIADOS");
  AnyadirObjetivo(hEstCantiacos, hObjIATamesis3);

  hObjIATamesis4 = CrearObjetivo(hEstTrinovantes, "DefenderPosicion");
  AnyadirGrupoAObjetivo(hObjIATamesis4, "TRINOVANTES_ALIADOS");
  AnyadirObjetivo(hEstTrinovantes, hObjIATamesis4);

  hObjIACon1 = CrearObjetivo(hEstCatuvelaunos, "ConquistaPueblo2", "VERULANIUM");
  AnyadirGrupoAObjetivo(hObjIACon1, "CATUVELAUNOS_PUEBLO");
  AnyadirObjetivo(hEstCatuvelaunos, hObjIACon1);
  SetParamObjetivo(hObjIACon1, "PuedePedirRefuerzos", FALSE);
  
  hObjIAPatrullas = CrearObjetivo(hEstCatuvelaunos, "PatrullaOleadasPeriodicas", 10000, 10000, 120, 480);
  SetParamObjetivo(hObjIAPatrullas, "ObjetivoAtracable", hObjIACon1);
  SetParamObjetivo(hObjIAPatrullas, "ForzarAccion", "ATACAR");
  AnyadirObjetivo(hEstCatuvelaunos, hObjIAPatrullas);

  hObjIACon2 = CrearObjetivo(hEstAtrebates, "ConquistaPueblo2", "CHICHESTER");
  AnyadirGrupoAObjetivo(hObjIACon2, "ATEBATES_PUEBLO");
  AnyadirObjetivo(hEstAtrebates, hObjIACon2);
  SetParamObjetivo(hObjIACon2, "DegradarParaReparar", TRUE); 
  SetParamObjetivo(hObjIACon2, "PuedePedirRefuerzos", FALSE);
    
  hObjIACon3 = CrearObjetivo(hEstCantiacos, "ConquistaPueblo2", "DUROVERNUM");
  AnyadirGrupoAObjetivo(hObjIACon3, "CANTIACOS_PUEBLO");
  AnyadirObjetivo(hEstCantiacos, hObjIACon3);
  SetParamObjetivo(hObjIACon3, "DegradarParaReparar", TRUE); 
  SetParamObjetivo(hObjIACon3, "PuedePedirRefuerzos", FALSE);
   
  hObjIACon4 = CrearObjetivo(hEstTrinovantes, "ConquistaPueblo2", "CAMULODUMUN");
  AnyadirGrupoAObjetivo(hObjIACon4, "TRINOVANTES_PUEBLO");
  AnyadirObjetivo(hEstTrinovantes, hObjIACon4);
  SetParamObjetivo(hObjIACon4, "DegradarParaReparar", TRUE); 
  SetParamObjetivo(hObjIACon4, "PuedePedirRefuerzos", FALSE);
 
  // Modificaciones por dificultad
  SetEntrenamientoPueblo(hEstCatuvelaunos, "VERULANIUM", bEntrenarCatuvelaunos);
  SetEntrenamientoPueblo(hEstAtrebates, "CHICHESTER", bEntrenarDemas);
  SetEntrenamientoPueblo(hEstCantiacos, "DUROVERNUM", bEntrenarDemas);
  SetEntrenamientoPueblo(hEstTrinovantes, "CAMULODUMUN", bEntrenarDemas);

  SetDelayEntrenamientoTropasPueblo(hEstCatuvelaunos, "VERULANIUM",fDelay);
  SetDelayEntrenamientoTropasPueblo(hEstAtrebates, "CHICHESTER", fDelay);
  SetDelayEntrenamientoTropasPueblo(hEstCantiacos, "DUROVERNUM", fDelay);
  SetDelayEntrenamientoTropasPueblo(hEstTrinovantes, "CAMULODUMUN", fDelay);
  
  // Y si el nivel de dificultad es el adecuado...
  if ( fNivelDificultad == 3 )
  {
    
    // patrullas a mansalva
    
    hObjIAPatrullasAT = CrearObjetivo(hEstAtrebates, "PatrullaOleadasPeriodicas", 5000, 5000, 120, 480);
    SetParamObjetivo(hObjIAPatrullasAT, "ObjetivoAtracable", hObjIACon2);
    SetParamObjetivo(hObjIAPatrullasAT, "ForzarAccion", "ATACAR");
    AnyadirObjetivo(hEstAtrebates, hObjIAPatrullasAT);
  
    hObjIAPatrullasCA = CrearObjetivo(hEstCantiacos, "PatrullaOleadasPeriodicas", 5000, 5000, 120, 480);
    SetParamObjetivo(hObjIAPatrullasCA, "ObjetivoAtracable", hObjIACon3);
    SetParamObjetivo(hObjIAPatrullasCA, "ForzarAccion", "ATACAR");
    AnyadirObjetivo(hEstCantiacos, hObjIAPatrullasCA);

    hObjIAPatrullasTR = CrearObjetivo(hEstTrinovantes, "PatrullaOleadasPeriodicas", 5000, 5000, 120, 480);
    SetParamObjetivo(hObjIAPatrullasTR, "ObjetivoAtracable", hObjIACon4);
    SetParamObjetivo(hObjIAPatrullasTR, "ForzarAccion", "ATACAR");
    AnyadirObjetivo(hEstTrinovantes, hObjIAPatrullasTR);
    
  }
 
 
  // este cenutrión a currar
  OrdenarTropaMantenerPosicion("CASSIVELAUNO", FALSE);
  AnyadirGrupoAObjetivo(hObjIACon1, "G_CASSIVELAUNO");
 
  // triggers de mision  
  ActivarTrigger("AtaqueInicial");
  ActivarTrigger("AtaqueLateral");
  ActivarTrigger("AtrebatesAltar");
  ActivarTrigger("CantiacosAltar");
  ActivarTrigger("TrinovantesAltar");
  ActivarTrigger("TrinovantesRebotados");
  ActivarTrigger("AtrebatesRebotados");
  ActivarTrigger("CantiacosRebotados");
  
  // fueeeeeeera
  DestruirTrigger("Main2");
  
}

/////////////////////////////////////////////////
// Briefing

Trigger "Briefing" [Inactivo]
(
  TRUE
)
Var
{
  float x, y;
  handle hCamaraEnd;
  handle hPresentacion;
  handle hEscape;
}
Do
{

  // handle de final y presentacion
  hCamaraEnd = CrearHandle("Bool");
  hPresentacion = CrearHandle("Bool");
  hEscape = CrearHandle("Bool");
  
  // contamos los puntos de sincronia
  hPuntoSincronia = CrearHandle("Bool");
  PonerHandleEsperaSincronizacion(hPuntoSincronia);
  ActivarTrigger("ContarPuntosSincronia");

  // cazar escape
  PonerHandleInterrupcion(hEscape);
  
  // posición actual
  DarPosicionCamara(&x, &y);

  // cine
  ActivarCinemascope(TRUE);
    
  // Presentacion
  ActivarPresentacion(TRUE, "LTEXT_MISION12_PRESENTACION_TITULO",
                            "LTEXT_MISION12_PRESENTACION_LUGAR", hPresentacion);
                            
  // camara a donde debe empezar
  EncolarColocarYMirarPunto("BRIEFING_1");
  EjecutarOrdenesCamara();
  
  WaitBool(HandleDisparado(hPresentacion) || HandleDisparado(hEscape));
 
  ActivarPresentacion(FALSE, "", "", NULL);

  // cámaras
  IntroducirPonerModoJuegoCamara(FALSE);
  
  EncolarPausaCamara(2000);
  EncolaTrayectoriaCamara("BRIEFING_2", FALSE, FALSE, 0, 0);
  EncolarPausaCamara(1000);
  IntroducirLocucion("12N0", "LTEXT_MISION12_LOCUCION_00_TXT", 8000, 600, 100);
  IntroducirPuntoSincronia();        

  EncolaTrayectoriaCamara("BRIEFING_3", FALSE, FALSE, 0, 0);
  EncolarPausaCamara(2000);
  IntroducirLocucion("", "", 100, 0, 0);  
  IntroducirLocucion("12N1", "LTEXT_MISION12_LOCUCION_01_TXT", 8000, 600, 100);
  IntroducirPuntoSincronia();        

  EncolarColocarYMirarPunto("BRIEFING_4");
  EncolarPausaCamara(3000);
  EncolarColocarYMirarPunto("BRIEFING_5");
  EncolarPausaCamara(2000);
  EncolarColocarYMirarPunto("BRIEFING_6");
  EncolarPausaCamara(2000);
  IntroducirLocucion("", "", 100, 0, 0);
  IntroducirLocucion("12N2", "LTEXT_MISION12_LOCUCION_02_TXT", 8000, 600, 100);
  IntroducirPuntoSincronia();

  EncolaTrayectoriaCamara("BRIEFING_7", FALSE, FALSE, 0, 0);
  EncolarPausaCamara(1000);
  EncolaTrayectoriaCamara("BRIEFING_8", FALSE, FALSE, 0, 0);
  EncolarPausaCamara(1000);
  EncolaTrayectoriaCamara("BRIEFING_9", FALSE, FALSE, 0, 0);
  EncolarPausaCamara(2000);
  IntroducirLocucion("", "", 100, 0, 0);
  IntroducirLocucion("12N3", "LTEXT_MISION12_LOCUCION_03_TXT", 9000, 600, 100);
  IntroducirPuntoSincronia();        

  EncolarColocarYMirarPunto("BRIEFING_10");
  EncolarPausaCamara(1000);
  EncolaTrayectoriaCamara("BRIEFING_11", FALSE, FALSE, 0, 0);
  EncolarPausaCamara(1000);
  IntroducirLocucion("", "", 100, 0, 0);
  IntroducirLocucion("12N4", "LTEXT_MISION12_LOCUCION_04_TXT", 5000, 600, 100);
  IntroducirLocucion("", "", 100, 0, 0);
  IntroducirLocucion("12N5", "LTEXT_MISION12_LOCUCION_05_TXT", 3000, 600, 100);
  IntroducirPuntoSincronia();        

  IntroducirPonerModoJuegoCamara(TRUE);


  // si no se ha interrumpido
  if ( !HandleDisparado(hEscape) )
  {

    // efectos especiales
    ActivarTrigger("EfectosBriefing");
    
    // iluminación
    HacerVisibleGrupoTropas("ATEBATES_ALIADOS", TRUE);
    HacerVisibleGrupoTropas("CATUVELAUNOS_ALIADOS", TRUE);
    HacerVisibleGrupoTropas("TRINOVANTES_ALIADOS", TRUE);
    HacerVisibleGrupoTropas("CANTIACOS_ALIADOS", TRUE);
    IluminarZonaOnOff(18, 2, 136, 20, "casiovelauno", TRUE);
    IluminarZonaOnOff(160, 0, 135, 20, "pueblo1", TRUE);
    IluminarZonaOnOff(104, 0, 42, 20, "pueblo2", TRUE);
    IluminarZonaOnOff(75, 2, 126, 20, "pueblo3", TRUE);
    IluminarZonaOnOff(158, 2, 98, 20, "altar1", TRUE);
    IluminarZonaOnOff(80, 0, 58, 20, "altar2", TRUE);
    IluminarZonaOnOff(100, 0, 131, 20, "altar3", TRUE);

    // acción
    EjecutarOrdenesCamara();

    // final  
    PonerHandleBoolACamara(hCamaraEnd);
    WaitBool(HandleDisparado(hCamaraEnd) || HandleDisparado(hEscape));

    // fuera luces
    HacerVisibleGrupoTropas("ATEBATES_ALIADOS", FALSE);
    HacerVisibleGrupoTropas("CATUVELAUNOS_ALIADOS", FALSE);
    HacerVisibleGrupoTropas("TRINOVANTES_ALIADOS", FALSE);
    HacerVisibleGrupoTropas("CANTIACOS_ALIADOS", FALSE);
    IluminarZonaOnOff(18, 2, 136, 20, "casiovelauno", FALSE);
    IluminarZonaOnOff(160, 0, 135, 20, "pueblo1", FALSE);
    IluminarZonaOnOff(104, 0, 42, 20, "pueblo2", FALSE);
    IluminarZonaOnOff(75, 2, 126, 20, "pueblo3", FALSE);
    IluminarZonaOnOff(158, 2, 98, 20, "altar1", FALSE);
    IluminarZonaOnOff(80, 0, 58, 20, "altar2", FALSE);
    IluminarZonaOnOff(100, 0, 131, 20, "altar3", FALSE);
   
  }

  VaciarOrdenesCamara();
  VaciarLocuciones();

  // esto es todo amigos
  bBriefingEnded = TRUE;

  // colocamos la cámara
  if ( HandleDisparado(hEscape) )
  {
    MirarAPunto(x, y);
  }

  // restaurar
  ActivarCinemascope(FALSE);

  // activamos el main2 (reordenar luego)
  ActivarTrigger("Main2");

  // eliminamos el briefing  
  DestruirTrigger("Briefing");
  
}

/////////////////////////////////////////////
// Efectos del briefing
Trigger "EfectosBriefing" [Inactivo]
(
  TRUE
)
Var
{
  handle hTimer; 
}
Do
{
  DestruirTrigger("EfectosBriefing"); 
}



// Contamos los puntos de sincronia

Trigger "ContarPuntosSincronia" [Inactivo]
(
  Wait(hPuntoSincronia)
)
Do
{
  fPuntoSincronia = fPuntoSincronia + 1;
  PonerHandleEsperaSincronizacion(hPuntoSincronia);
}





////////////////////////////////////////////////////////////////
// TRIGGERS DE MISION
////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////
// Ataques escriptados
////////////////////////////////////////////////////////////////

Trigger "AtaqueInicial" [Inactivo]
(
  HanEntradoCivilizacionesEnZona("ATAQUE_INICIAL_1", "CESAR")
  ||
  HanEntradoCivilizacionesEnZona("ATAQUE_INICIAL_2", "CESAR")
)
Do
{

  // objetivo del ataque inicial
  hObjAtaqueInicial = CrearObjetivo(hEstCatuvelaunos, "ConquistaPueblo2", "CAMPAMENTO_CESAR");
  AnyadirGrupoAObjetivo(hObjAtaqueInicial, "CATUVELAUNOS_INICIAL");
  SetParamObjetivo(hObjAtaqueInicial, "PuedePedirRefuerzos", FALSE);
  SetParamObjetivo(hObjAtaqueInicial, "PuedeRetirarse", FALSE);
  AnyadirObjetivo(hEstCatuvelaunos, hObjAtaqueInicial);

  
  DestruirTrigger("AtaqueInicial");

}  // Ataque inicial


Trigger "AtaqueLateral" [Inactivo]
(
  HanEntradoCivilizacionesEnZona("ATAQUE_LATERAL_1", "CESAR")
  ||
  HanEntradoCivilizacionesEnZona("ATAQUE_LATERAL_2", "CESAR")
)
Do
{

  // objetivo del ataque lateral
  hObjAtaqueLateral = CrearObjetivo(hEstCatuvelaunos, "ConquistaPueblo2", "CAMPAMENTO_CESAR");
  AnyadirGrupoAObjetivo(hObjAtaqueLateral, "CATUVELAUNOS_LATERAL");
  SetParamObjetivo(hObjAtaqueLateral, "PuedePedirRefuerzos", FALSE);
  SetParamObjetivo(hObjAtaqueLateral, "PuedeRetirarse", FALSE);
  AnyadirObjetivo(hEstCatuvelaunos, hObjAtaqueLateral);

  DestruirTrigger("AtaqueLateral");
  
}


////////////////////////////////////////////////////////////////
// Altares
////////////////////////////////////////////////////////////////

Trigger "AtrebatesAltar" [Inactivo]
(
  EstructuraDestruida("ATREBATES_ALTAR") && !bAtrebatesRebotados
)
Var
{
  handle hTimer; 
}
Do
{
  
  MensajeLocucionado("12N6","LTEXT_MISION12_MENSAJE_00_TXT");
  AvisoCivilizacion("CESAR", 101, 45);
  
  NeutralizarCivilizacion("ATREBATES", TRUE);
  
  // que no traten de reparar su guarnicion
  SetParamObjetivo(hObjIACon2, "ProhibidoReparar", TRUE); 
  
  GrupoTropasSeguirRutaPredefinida("ATREBATES_ALIADOS", "ATREBATES_RUTA");
  bAtrebatesAcojonados = TRUE;

  hTimer = CrearTimer(2000);
  Wait(hTimer);

  // por si su guarnición estaba incendiada
  PonerFuegoEnte("ATREBATES_GUARNICION", 0);

  DestruirTrigger("AtrebatesAltar");
  
}

Trigger "CantiacosAltar" [Inactivo]
(
  EstructuraDestruida("CANTIACOS_ALTAR") && !bCantiacosRebotados
)
Var
{
  handle hTimer;  
}
Do
{
  
  MensajeLocucionado("12N7","LTEXT_MISION12_MENSAJE_01_TXT");
  AvisoCivilizacion("CESAR", 160, 142);
  
  NeutralizarCivilizacion("CANTIACOS", TRUE);
  
  GrupoTropasSeguirRutaPredefinida("CANTIACOS_ALIADOS", "CANTIACOS_RUTA");
  bCantiacosAcojonados = TRUE;

  hTimer = CrearTimer(2000);
  Wait(hTimer);

  // que no traten de reparar su guarnicion
  SetParamObjetivo(hObjIACon3, "ProhibidoReparar", TRUE); 

  // por si su guarnición estaba incendiada
  PonerFuegoEnte("CANTIACOS_GUARNICION", 0);

  DestruirTrigger("CantiacosAltar");
  
}

Trigger "TrinovantesAltar" [Inactivo]
(
  EstructuraDestruida("TRINOVANTES_ALTAR") && !bTrinovantesRebotados
)
Var
{
  handle hTimer;
}
Do
{
  
  MensajeLocucionado("12N8","LTEXT_MISION12_MENSAJE_02_TXT");
  AvisoCivilizacion("CESAR", 74, 133);
 
  NeutralizarCivilizacion("TRINOVANTES", TRUE);

  // que no traten de reparar su guarnicion
  SetParamObjetivo(hObjIACon4, "ProhibidoReparar", TRUE); 
  
  GrupoTropasSeguirRutaPredefinida("TRINOVANTES_ALIADOS", "TRINOVANTES_RUTA");
  bTrinovantesAcojonados = TRUE;

  hTimer = CrearTimer(2000);
  Wait(hTimer);

  // por si su guarnición estaba incendiada
  PonerFuegoEnte("TRINOVANTES_GUARNICION", 0);

  DestruirTrigger("TrinovantesAltar");
  
}


////////////////////////////////////////////////////////////////
// Rebotes
////////////////////////////////////////////////////////////////

Trigger "AtrebatesRebotados" [Inactivo]
(
  EstructuraDestruida("ATREBATES_GUARNICION")
  ||
  EsEstructuraAtacada("CHICHESTER", "CESAR")
)
Do
{
 
  if ( !bAtrebatesAcojonados )      // si no habían sido acojonados
  {
    MensajeLocucionado("12N9","LTEXT_MISION12_MENSAJE_03_TXT");
    bAtrebatesRebotados = TRUE;
  }
  else                              // ¡traición!
  {
    ActivarTrigger("Traicion");    
  }
 
  DestruirTrigger("AtrebatesRebotados"); 
  
}



Trigger "CantiacosRebotados" [Inactivo]
(
  EstructuraDestruida("CANTIACOS_GUARNICION")
  ||
  EsEstructuraAtacada("DUROVERNUM", "CRASO")
)
Do
{

  if ( !bCantiacosAcojonados )   // si no habían sido acojonados
  {
    MensajeLocucionado("12NA","LTEXT_MISION12_MENSAJE_04_TXT");
    bCantiacosRebotados = TRUE;
  }
  else
  {
    ActivarTrigger("Traicion"); 
  }
 
  DestruirTrigger("CantiacosRebotados");
  
}



Trigger "TrinovantesRebotados" [Inactivo]
(
  EstructuraDestruida("TRINOVANTES_GUARNICION")
  ||
  EsEstructuraAtacada("CAMULODUMUN", "CRASO")
)
Do
{
 
  if ( !bTrinovantesAcojonados )
  {
    MensajeLocucionado("12NB","LTEXT_MISION12_MENSAJE_05_TXT");
    bTrinovantesRebotados = TRUE;
  }
  else
  {
    ActivarTrigger("Traicion"); 
  }

  DestruirTrigger("TrinovantesRebotados"); 
  
}


// se ha atacado a uno de los pueblos que se habían vuelto neutrales
Trigger "Traicion" [Inactivo]
(
  TRUE
)
Do
{
  
  // Mensaje
  MensajeLocucionado("12NC","LTEXT_MISION12_MENSAJE_06_TXT");
  
  // volvemos a los bandos agresivos de nuevo
  NeutralizarCivilizacion("TRINOVANTES", FALSE);
  NeutralizarCivilizacion("CANTIACOS", FALSE);
  NeutralizarCivilizacion("ATREBATES", FALSE);
  
  // que puedan arreglar su casa
  SetParamObjetivo(hObjIACon2, "ProhibidoReparar", TRUE); 
  SetParamObjetivo(hObjIACon3, "ProhibidoReparar", TRUE); 
  SetParamObjetivo(hObjIACon4, "ProhibidoReparar", TRUE); 
  
  // están mosca
  bAtrebatesRebotados = TRUE;
  bCantiacosRebotados = TRUE;
  bTrinovantesRebotados = TRUE;
  
  // desactivamos estos triggers que ya no son necesarios
  DestruirTrigger("AtrebatesRebotados");
  DestruirTrigger("CantiacosRebotados");
  DestruirTrigger("TrinovantesRebotados");
  DestruirTrigger("AtrebatesAltar");
  DestruirTrigger("CantiacosAltar");
  DestruirTrigger("TrinovantesAltar");
  
  DestruirTrigger("Traicion"); 
  
}

////////////////////////////////////////////////////////////////
// CONDICIONES DE TERMINACION DEL ESCENARIO
////////////////////////////////////////////////////////////////

Trigger "CondicionesVictoria" [Activo]
(
  !EstaTropaViva("CAYO_CRASTINO")
  ||
  !EstaTropaViva("COMIO")
  ||
  !EstaTropaViva("CASSIVELAUNO")
  ||
  !EstaPuebloConquistado("CESAR", "CAMPAMENTO_CESAR")
)
Do
{
  
  if ( !EstaTropaViva("CASSIVELAUNO") )
  {
    
    IndicarObjetivoCumplido(hObjCampamento);
    IndicarObjetivoCumplido(hObjCassivelauno);
    IndicarObjetivoCumplido(hObjCayoVivo);
    IndicarObjetivoCumplido(hObjComioVivo);
        
    FinalizarMision(TRUE);
    
  }
  else
  {
    
    IndicarObjetivoFracasado(hObjCassivelauno);
    
    if ( !EstaTropaViva("CAYO_CRASTINO") )
    {
      IndicarObjetivoFracasado(hObjCayoVivo);
    }
    
    if ( !EstaTropaViva("COMIO") )
    {
      IndicarObjetivoFracasado(hObjComioVivo);
    }
    
    if ( !EstaPuebloConquistado("CESAR", "CAMPAMENTO_CESAR") )
    {
      IndicarObjetivoFracasado(hObjCampamento);
    }
    
    FinalizarMision(FALSE);
    
  }
  
  DesactivarTrigger("CondicionesVictoria");
  DestruirTrigger("CondicionesVictoria");
    
}





////////////////////////////////////////////////////////////////
//---------END----------
////////////////////////////////////////////////////////////////

Trigger "End" [ Activo ]  
(
  TRUE
)
Do
{

}


