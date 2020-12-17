:TITLE Ca Pool
TITLE Mod file for component: Component(id=CaPoolTH type=fixedFactorConcentrationModel)

NEURON {
    SUFFIX CaPoolTH
    USEION ca READ ica WRITE cai VALENCE 2
    RANGE resting_concentration
    RANGE decay
    RANGE rho
}

UNITS {
    (nA)    = (nanoamp)
    (uA)    = (microamp)
    (mA)    = (milliamp)
    (A)     = (amp)
    (mV)    = (millivolt)
    (mS)    = (millisiemens)
    (uS)    = (microsiemens)
    (molar) = (1/liter)
    (kHz)   = (kilohertz)
    (mM)    = (millimolar)
    (um)    = (micrometer)
    (umol)  = (micromole)
    (S)     = (siemens)
}

PARAMETER {
    surface_area                       (um2)
    resting_concentration =  0.0       (mM)
    decay                 = 11.5943    (ms)
    rho                   = 2.38919E-4 (mM m2 /A /s)
}

ASSIGNED { rate_concentration (mM/ms) }

STATE    { concentration (mM) }

INITIAL  { concentration = cai }

BREAKPOINT {
    SOLVE states METHOD cnexp
    if (concentration < 0) { concentration = 0 }
}

DERIVATIVE states {
    concentration' = rates(ica)
    cai            = concentration
}

FUNCTION rates(ica) {
 rates = -0.01*ica*rho - (concentration - resting_concentration)/decay 
 }
