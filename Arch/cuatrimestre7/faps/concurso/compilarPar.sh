#Opciones de miscelanea
CodigoMq="+asm"           #Produce el codigo mq
Info="+Oinfo"             # Muestra informacion sobre las optimizaciones realizadas
Report="+Oreport=all"     # Muestra un informe de optimizaciones

#Opciones de optimizacion
Alinear="+A"              # Alineacion
Promote8="+autodbl"       # Promociona enteros,reales,etc a 8B
                          # [ALTERNATIVA] --> +real_constant=single (o bien -R4)
DA2="+DA.20.W"            # Cambia el tamanyo estandar de un puntero en Cray
JerarquiaMem="+DC7200"    # Optimiza la jerarquia de memoria
SchedulerOpt="+DSPA8500"  # Realiza Scheduling de las instrucciones
StaticStorage="-K"        # Usa almacenamiento estatico para variables locales en vez de stack
#Oaggressive="+Oaggressive" # [AGRUPACION]
                          #  +Oentrysched //Scheduling de instrucciones
                          #  +Olibcalls   //Usa rutinas con poco overhead en invocacion
                          #  +Onofltacc
                          #  +Onoinitcheck //Deshabilita la inicializacion de var locales
                          #  +FPD
#Oall="+Oall"              # [AGRUPACION]
                          #  +Oaggressive 
			  #  +Onolimit // No suprime opt de alto costo de compi-time
LoopTransform="+Oloop_transform" # Transformaciones de bucles
NoSize="+Onosize"         # No suprime optimizacion que aumentan el tamanyo de codigo
PadCache="+Ocache_pad_common" # Padding en los bloques de cache para evitar colisiones
CxLimitedRange="+Ocxlimitedrange" # Activa matematica de fp en al unidad de compilacion
CrossRegAddr="+Ocross_region_addressing" # Activa el uso de cross-region addresing
Odataprefetch="+Odataprefetch"
dataprefetch="+Odataprefetch=indirect"   # Activa prefetch directo e indirecto
entrysched="+Oentrysched"                # Scheduling de instrucciones
fast="+Ofast"             # [AGRUPACION]
                          # +Olibcalls
                          # +Onolimit
                          # +Ofltacc=relaxed
                          # +FPD
                          # +DSnative
                          # [LINKER]
                          # +pi 4M +pd 4M +mergeseg
fastAccess="+Ofastaccess" # Habilita acceso rapido a datos globales
faster="+Ofaster"         # Habilita +Ofaster
FDP="+FPD"                #
fenvaccess="+Ofenvaccess" # [PELIGROSA] No-access to the floating point enviroment
fltacc="+Ofltacc=relaxed" # [PELIGROSA] Optimizaciones de codigo FP; FMA, reordenacion...
noInitCheck="+Onoinitcheck" # Deshabilita la inicializacion de variables locales
inline="+Oinline"         # Habilita inlinear el codigo
inlineAgresivo="+Oinline_budget=1000000" # Inlineado agresivo
libcalls="+Olibcalls"     # Usa rutinas con poco overhead en invocacion
noLimit="+Onolimit"       # No suprime optimizaciones costosas en tiempo
loopBlock="+Oloop_block"  # Habilita el bloqueo de bucles para opt de cache
loopUnroll="+Oloop_unroll" # [=n] Desenrolla bucles, se puede especificar grado n
loopUnrollJam="+Oloop_unroll_jam" # Permite opt de unroll y jam de bucles
MoveFlops="+Omoveflops"   # Permite mover ins cond FP fuera de bucles
Regreassoc="+Oregreassoc" # Habilita la reasociacion de registros
ShortData="+Oshortdata"   # ubica los objetos en el area de datos pequeños

#Opciones relacionadas con optimizaciones
FastAllocatableArray="+fastallocatable" # Usa repr de allocate vectores evitando fallos de Opt
StripSymbolTable="-s"     # Strip symbol table information from linker output

#Opciones de paralelismo automatico
Parallel="+parallel"     #Genera un ejecutable paralelo
ParIntrinsecos="+Oparallel_intrinsics"   #Linka con la ver paralela de librerias
                                         #intrinsecas de lib90_paralela
Oparallel="+Oparallel"
AutoPar="+Oautopar"      # Paraleliza bucles automaticamente si puede

#Vectorizacion
Vectorizar="+Ovectorize"  # Vectoriza los bucles que puede

OpcionesComp=$Alinear" "$Promote" "$DA" "$JerarquiaMem" "$SchedulerOpt" "\
$StaticStorage" "$Oaggressive" "$Oall" "$LoopTransform" "$NoSize" "$PadCache" "\
$CxLimitedRange" "$CrossRegAddr" "$Odataprefetch" "$dataprefetch" "$entrysched" "$fast" "\
$fastAccess" "$faster" "$FDP" "$fenvaccess" "$fltacc" "$noInitCheck" "$inline" "$inlineAgresivo" "\
$libcalls" "$noLimit" "$loopBlock" "$loopUnroll" "$loopUnrollJam" "$MoveFlops" "\
$NoCachePrefetchReturns" "$LatenciaPrefetch" "$Regreassoc" "$ShortData" "\
$StaticPrediction" "$Vectorizar" "$FastAllocatableArray" "$MinShared" "\
$StripSymbolTable" "

OpcionesParallel=$Parallel" "$ParIntrinsecos" "$AutoPar" "$Oparallel" "

OpcionesInfo=$Report" "$Info

echo "--------------------------------------------------------------------------------"
echo "Compilamos (Paralelo)....  esto cuesta un rato.. paciencia..."
echo f90 -O4 $OpcionesComp $OpcionesParallel $OpcionesInfo $1.f90 -o $1 -L. -lpresum -lveclib
echo "--------------------------------------------------------------------------------"

f90 -O4 $OpcionesComp $OpcionesParallel $OpcionesInfo $1.f90 -o $1 -L. -lpresum -lveclib
