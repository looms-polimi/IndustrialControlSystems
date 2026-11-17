within Tests;
model FunctionChecks
  "Direct checks of every library function that no other test calls directly"
  extends Modelica.Icons.Example;
  import LF = IndustrialControlSystems.LinearSystems.Discrete.Functions;
  import CF = IndustrialControlSystems.Logical.Counter.Functions;
  import BF = IndustrialControlSystems.Logical.LogicalOperations.Functions;
  import TF = IndustrialControlSystems.Logical.Timers.Functions;
  import MF = IndustrialControlSystems.MathOperations.RealType.Functions;
  import Tests.Utilities.near;

  // ---- data for the discrete linear-system functions -------------------------------
  constant Real Ts = 0.1 "Sampling time";
  constant Real k = 3 "Gain";
  constant Real tau = 2 "Time constant of the first-order lag";
  constant Real T1 = 1.5 "Zero time constant of the lead-lag";
  constant Real T2 = 0.4 "Pole time constant of the lead-lag";
  constant Real u = 2 "u[n]";
  constant Real u1 = 1 "u[n-1]";
  constant Real u2 = 0.5 "u[n-2]";
  constant Real y1 = 0.5 "y[n-1]";
  constant Real y2 = 0.2 "y[n-2]";
  constant Real mu = 2 "Gain of the complex-pole pair";
  constant Real xi = 0.3 "Damping of the complex-pole pair";
  constant Real wn = 4 "Natural frequency of the complex-pole pair";

  // Expected values: the textbook recurrence of each discretisation, written
  // independently of the alpha-form used in the library
  Boolean ok_fIntegrator =
    near(LF.fIntegrator(1, u, u1, y1, Ts, k), y1 + k*Ts*u) and
    near(LF.fIntegrator(0, u, u1, y1, Ts, k), y1 + k*Ts*u1) and
    near(LF.fIntegrator(0.5, u, u1, y1, Ts, k), y1 + k*Ts*(u + u1)/2)
    "k/s, BE/FE/TU";
  Boolean ok_f1Pole =
    near(LF.f1Pole(1, u, u1, y1, Ts, k, tau), (tau*y1 + k*Ts*u)/(tau + Ts)) and
    near(LF.f1Pole(0, u, u1, y1, Ts, k, tau), y1 + Ts/tau*(k*u1 - y1)) and
    near(LF.f1Pole(0.5, u, u1, y1, Ts, k, tau), ((2*tau - Ts)*y1 + k*Ts*(u + u1))/(2*tau + Ts))
    "k/(1+s*tau), BE/FE/TU";
  Boolean ok_f1p1z =
    near(LF.f1p1z(1, T1, T2, u, u1, y1, Ts, k), (T2*y1 + k*((T1 + Ts)*u - T1*u1))/(T2 + Ts)) and
    near(LF.f1p1z(0, T1, T2, u, u1, y1, Ts, k), (k*(T1*u + (Ts - T1)*u1) - (Ts - T2)*y1)/T2) and
    near(LF.f1p1z(0.5, T1, T2, u, u1, y1, Ts, k),
      (k*((Ts + 2*T1)*u + (Ts - 2*T1)*u1) - (Ts - 2*T2)*y1)/(Ts + 2*T2))
    "k(1+s*T1)/(1+s*T2), BE/FE/TU";
  Boolean ok_fDerivator_unitGain =
    near(LF.fDerivator(1, u, u1, y1, Ts, 1), (u - u1)/Ts) and
    near(LF.fDerivator(0.5, u, u1, y1, Ts, 1), 2*(u - u1)/Ts - y1)
    "s, BE/TU";
  Boolean ok_fDerivator_gain =
    near(LF.fDerivator(1, u, u1, y1, Ts, k), k*(u - u1)/Ts) and
    near(LF.fDerivator(0.5, u, u1, k*y1, Ts, k), k*(2*(u - u1)/Ts - y1))
    "k*s, BE/TU: the gain input k must scale the output";
  Boolean ok_fCmplx =
    near(LF.fCmplx(1, u, u1, u2, y1, y2, Ts, mu, xi, wn),
      (mu*wn^2*u + (2/Ts^2 + 2*xi*wn/Ts)*y1 - y2/Ts^2)/(1/Ts^2 + 2*xi*wn/Ts + wn^2)) and
    near(LF.fCmplx(0.5, u, u1, u2, y1, y2, Ts, mu, xi, wn),
      (mu*wn^2*(u + 2*u1 + u2) - (2*wn^2 - 8/Ts^2)*y1 - (4/Ts^2 - 4*xi*wn/Ts + wn^2)*y2)
      /(4/Ts^2 + 4*xi*wn/Ts + wn^2)) and
    near(LF.fCmplx(0, 1, 1, 1, mu, mu, Ts, mu, xi, wn), mu)
    "mu*wn^2/(s^2+2*xi*wn*s+wn^2), BE/TU, FE at steady state";

  // ---- counter ----------------------------------------------------------------------
  // count(val, preset, S, S_old, CU, CU_old, CD, CD_old, R, Max)
  Integer cntN[9] "Counter value returned by count";
  Boolean cntQ[9] "Counter output returned by count";
  Boolean ok_count =
    cntN[1] == 0 and not cntQ[1] and       // reset dominates
    cntN[2] == 5 and cntQ[2] and           // rising set loads the preset
    cntN[3] == 6 and cntQ[3] and           // rising count-up
    cntN[4] == 4 and cntQ[4] and           // rising count-down
    cntN[5] == 0 and not cntQ[5] and       // count-up past Max wraps to 0
    cntN[6] == 9 and cntQ[6] and           // count-down below 0 wraps to Max
    cntN[7] == 3 and cntQ[7] and           // not set: no counting
    cntN[8] == 3 and cntQ[8] and           // up and down together: no change
    cntN[9] == 3 and cntQ[9]               // count-up held high, no edge: no change
    "Logical.Counter.Functions.count";

  // ---- Boolean functions -------------------------------------------------------------
  Boolean notOut[3] = BF.Not({true, false, true}, 3) "Not of {true,false,true}";
  Boolean ok_Not = not notOut[1] and notOut[2] and not notOut[3] "Not, elementwise";
  Boolean ok_And = BF.And({true, true, true}, 3) and not BF.And({true, false, true}, 3)
    and not BF.And({false, false}, 2) "And of 2 and 3 inputs";
  Boolean ok_Or = BF.Or({false, false, true}, 3) and not BF.Or({false, false, false}, 3)
    and BF.Or({true, false}, 2) "Or of 2 and 3 inputs";
  Boolean ok_Xor = BF.Xor({true, false}, 2) and not BF.Xor({true, true}, 2)
    and BF.Xor({true, true, true}, 3) and not BF.Xor({true, true, false}, 3)
    and BF.Xor({false, false, true}, 3) "Xor = odd parity";
  Boolean ok_SR = BF.SR(true, false, false) and not BF.SR(true, true, true)
    and not BF.SR(false, true, true) and BF.SR(false, false, true)
    and not BF.SR(false, false, false) "Set-reset, reset dominant, memory";

  // ---- timer functions ---------------------------------------------------------------
  Boolean ok_hold = TF.hold(false, true, false, false) and TF.hold(true, false, false, false)
    and TF.hold(true, true, false, false) and TF.hold(false, false, false, true)
    and not TF.hold(false, false, false, false) and not TF.hold(true, true, true, true)
    "hold(S_old, S, R, S_hold)";
  Boolean ok_positiveEdge = near(TF.positiveEdge(false, true, false, 1, 5), 5)
    and near(TF.positiveEdge(true, true, false, 1, 5), 1)
    and near(TF.positiveEdge(false, true, true, 1, 5), 1)
    "positiveEdge(S_old, S, R, s_time, t): start time latched on a rising edge";
  Real reT[3] "st_time from risingEdge";
  Boolean reRun[3] "Run from risingEdge";
  Boolean ok_risingEdge = near(reT[1], 5) and reRun[1] and near(reT[2], 1) and reRun[2]
    and near(reT[3], 1) and not reRun[3] "risingEdge(S_old, S, R, s_time, t, Run_old)";
  Real feT[3] "st_time from fallingEdge";
  Boolean feRun[3] "Run from fallingEdge";
  Boolean ok_fallingEdge = near(feT[1], 5) and feRun[1] and near(feT[2], 1) and not feRun[2]
    and near(feT[3], 1) and feRun[3] "fallingEdge(S_old, S, R, s_time, t, Run_old)";
  Boolean timQ[3] "Q from tim";
  Boolean timRun[3] "run from tim";
  Boolean ok_tim = timQ[1] and timRun[1] and not timQ[2] and not timRun[2] and not timQ[3]
    "tim(S, R, duration, t, start): Q while t - start <= duration";
  Boolean odtQ[3] "Q from odt";
  Boolean odtRun[3] "run from odt";
  Boolean ok_odt = odtQ[1] and odtRun[1] and not odtQ[2] and not odtQ[3]
    "odt(S, R, duration, t, start): Q once t >= start + duration";
  Boolean ok_odts = TF.odts(false, 2, 5, 2, true) and not TF.odts(false, 2, 3, 2, true)
    and not TF.odts(false, 2, 5, 2, false) and not TF.odts(true, 2, 5, 2, true)
    "odts(R, duration, t, start, run)";

  // ---- set-point and fixed-point functions -------------------------------------------
  // Ramp with parabolic blends, 0 -> 1, slope 1, alfa = 0.25: blend 0.25 s (height 0.125),
  // ramp 0.75 s, from tin = 1 to 2.25
  Boolean ok_fSmoothStep =
    near(MF.fSmoothStep(0.5, 1, 0.25, 1, 0, 1), 0) and
    near(MF.fSmoothStep(1.1, 1, 0.25, 1, 0, 1), 2*0.1^2) and
    near(MF.fSmoothStep(1.625, 1, 0.25, 1, 0, 1), 0.5) and
    near(MF.fSmoothStep(2.15, 1, 0.25, 1, 0, 1), 1 - 2*0.1^2) and
    near(MF.fSmoothStep(3, 1, 0.25, 1, 0, 1), 1) and
    near(MF.fSmoothStep(1.1, 1, 0.25, -1, 1, 0), 1 - 2*0.1^2) and
    near(MF.fSmoothStep(2, 1, 0, 0.5, 0, 1), 0.5) and
    near(MF.fSmoothStep(4, 1, 0, 0.5, 0, 1), 1) and
    near(MF.fSmoothStep(2, 1, 0, 0.5, 1, 0), 0.5)
    "fSmoothStep(t, tin, alfa, M, yin, yfin): blended and pure ramps, up and down";
  Boolean ok_f =
    near(MF.f(true, false, 1.625, 1, 10, 0.25, 1, 0, 1), 0.5) and
    near(MF.f(true, true, 10.1, 1, 10, 0.25, 1, 0, 1), 1 - 2*0.1^2) and
    near(MF.f(false, false, 1.625, 1, 10, 0.25, 1, 0, 1), 0)
    "f(up, down, t, ts, td, alfa, m, yin, yfin): step up at ts, back down at td";
  Boolean ok_toFixedPoint =
    MF.toFixedPoint(1.234, 100, 1000, -1000) == 123 and
    MF.toFixedPoint(1.236, 100, 1000, -1000) == 124 and
    MF.toFixedPoint(20, 100, 1000, -1000) == 1000 and
    MF.toFixedPoint(-1.234, 100, 1000, -1000) == -123 and
    MF.toFixedPoint(-1.236, 100, 1000, -1000) == -124 and
    MF.toFixedPoint(-20, 100, 1000, -1000) == -1000
    "toFixedPoint: round to nearest, saturate to [MIN, MAX], both signs";

  Boolean passed = ok_fIntegrator and ok_f1Pole and ok_f1p1z and ok_fDerivator_unitGain
    and ok_fDerivator_gain and ok_fCmplx and ok_count and ok_Not and ok_And and ok_Or
    and ok_Xor and ok_SR and ok_hold and ok_positiveEdge and ok_risingEdge
    and ok_fallingEdge and ok_tim and ok_odt and ok_odts and ok_fSmoothStep and ok_f
    and ok_toFixedPoint "true if every check in this test passed";

equation
  (cntN[1], cntQ[1]) = CF.count(7, 5, true, true, true, false, false, false, true, 9);
  (cntN[2], cntQ[2]) = CF.count(7, 5, true, false, false, false, false, false, false, 9);
  (cntN[3], cntQ[3]) = CF.count(5, 5, true, true, true, false, false, false, false, 9);
  (cntN[4], cntQ[4]) = CF.count(5, 5, true, true, false, false, true, false, false, 9);
  (cntN[5], cntQ[5]) = CF.count(9, 5, true, true, true, false, false, false, false, 9);
  (cntN[6], cntQ[6]) = CF.count(0, 5, true, true, false, false, true, false, false, 9);
  (cntN[7], cntQ[7]) = CF.count(3, 5, false, false, true, false, false, false, false, 9);
  (cntN[8], cntQ[8]) = CF.count(3, 5, true, true, true, false, true, false, false, 9);
  (cntN[9], cntQ[9]) = CF.count(3, 5, true, true, true, true, false, false, false, 9);

  (reT[1], reRun[1]) = TF.risingEdge(false, true, false, 1, 5, false);
  (reT[2], reRun[2]) = TF.risingEdge(true, true, false, 1, 5, true);
  (reT[3], reRun[3]) = TF.risingEdge(true, true, true, 1, 5, true);

  (feT[1], feRun[1]) = TF.fallingEdge(true, false, false, 1, 5, false);
  (feT[2], feRun[2]) = TF.fallingEdge(false, false, false, 1, 5, false);
  (feT[3], feRun[3]) = TF.fallingEdge(false, false, false, 1, 5, true);

  (timRun[1], timQ[1]) = TF.tim(true, false, 2, 3, 2);
  (timRun[2], timQ[2]) = TF.tim(true, false, 2, 5, 2);
  (timRun[3], timQ[3]) = TF.tim(true, true, 2, 3, 2);

  (odtRun[1], odtQ[1]) = TF.odt(true, false, 2, 5, 2);
  (odtRun[2], odtQ[2]) = TF.odt(true, false, 2, 3, 2);
  (odtRun[3], odtQ[3]) = TF.odt(false, false, 2, 5, 2);

  when terminal() then
    assert(ok_fIntegrator, "fIntegrator failed", AssertionLevel.warning);
    assert(ok_f1Pole, "f1Pole failed", AssertionLevel.warning);
    assert(ok_f1p1z, "f1p1z failed", AssertionLevel.warning);
    assert(ok_fDerivator_unitGain, "fDerivator with k = 1 failed", AssertionLevel.warning);
    assert(ok_fDerivator_gain, "fDerivator ignores its gain k", AssertionLevel.warning);
    assert(ok_fCmplx, "fCmplx failed", AssertionLevel.warning);
    assert(ok_count, "count failed", AssertionLevel.warning);
    assert(ok_Not and ok_And and ok_Or and ok_Xor and ok_SR, "a Boolean function failed", AssertionLevel.warning);
    assert(ok_hold and ok_positiveEdge and ok_risingEdge and ok_fallingEdge, "an edge/hold function failed", AssertionLevel.warning);
    assert(ok_tim and ok_odt and ok_odts, "a timer function failed", AssertionLevel.warning);
    assert(ok_fSmoothStep and ok_f, "a set-point function failed", AssertionLevel.warning);
    assert(ok_toFixedPoint, "toFixedPoint failed", AssertionLevel.warning);
  end when;
  annotation (
    experiment(StopTime=1),
    Documentation(info="<html>
<p>Calls each non-partial function of the library that no other test calls directly,
with fixed arguments, and compares the result with an independently stated value.
There is no diagram: the checks are equations.</p>
<ul>
<li>Discrete linear-system functions (<code>LinearSystems.Discrete.Functions</code>):
the expected value is the textbook recurrence of each discretisation (Backward Euler,
Forward Euler, Tustin), written independently of the alpha-form the library uses.
<code>f2p2z</code> is checked in
<a href=\"modelica://Tests.LinearSystems.TwoPolesTwoZeroesDiscrete\">TwoPolesTwoZeroesDiscrete</a>.</li>
<li><code>Logical.Counter.Functions.count</code>: reset, preset, count up/down, wrap-around
at 0 and <code>Max</code>, disabled counting, simultaneous up/down, no edge.</li>
<li><code>Logical.LogicalOperations.Functions</code>: truth tables of <code>Not</code>,
<code>And</code>, <code>Or</code>, <code>Xor</code> (2 and 3 inputs) and <code>SR</code>.</li>
<li><code>Logical.Timers.Functions</code>: <code>hold</code>, the edge detectors and the
timer decisions <code>tim</code>, <code>odt</code>, <code>odts</code>.</li>
<li><code>MathOperations.RealType.Functions</code>: <code>fSmoothStep</code> (blended and
pure ramps, both directions), <code>f</code>, and <code>toFixedPoint</code> rounding and
saturation for both signs.</li>
</ul>
<p>Each <code>ok_*</code> variable is the verdict for one function; <code>passed</code> is
the overall verdict. A failed check issues an assertion warning at the end of the run.</p>
</html>"));
end FunctionChecks;
