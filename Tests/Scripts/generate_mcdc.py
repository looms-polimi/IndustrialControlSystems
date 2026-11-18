#!/usr/bin/env python3
"""Generate the MC/DC test package Tests.Controllers.MCDC.

One base model per controller class (the class under test `dut` with every option off, its
stimuli, an independent reference and flag-dependent checks) and one variant per option
change, `extends Base(<flag>=...)`. Sources that only a flag needs are conditional
components (`if useTS`, ...). Checks are Tests.Utilities blocks bound by modifiers; each is
enabled only for the configurations it applies to, so every variant carries the same check
set and `passed` is the conjunction.

usage: python3 generate_mcdc.py [--layout-lib DIR]
  DIR holds diagram_layout.py (the modelica-diagram-layout skill's scripts directory).
Writes Tests/Controllers/MCDC/** relative to this file and prints the layout report of each base.
"""
import argparse
import pathlib
import shutil
import sys
import textwrap

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parent / "Controllers" / "MCDC"
ap = argparse.ArgumentParser()
ap.add_argument("--layout-lib", default="/home/jovyan/github/skills/plugins/sim/skills/modelica-diagram-layout/scripts")
args = ap.parse_args()
sys.path.insert(0, args.layout_lib)
from diagram_layout import Layout  # noqa: E402

ICS = "IndustrialControlSystems.Controllers"
from mcdc_common import *  # noqa: E402,F401,F403
from mcdc_common import PROBLEMS, report  # noqa: E402

# ------------------------------------------------------------------------------ stimuli --
SP_TABLE = "[0,0; 1.02,0; 1.02,1; 15.02,1; 15.02,-1.5; 30.02,-1.5; 30.02,0; 40,0]"
TS_TABLE = "{6.02, 8.02, 20.02, 23.02}"
TR_TABLE = "[0,0.5; 14,0.5; 14,1.5; 40,1.5]"
SETTLED = "not ((time > 1.02 and time < 3.0) or (time > 15.02 and time < 17.0) or (time > 30.02 and time < 32.0))"
TRACK_WINDOWS = "(time > 7.1 and time < 8.0) or (time > 21.1 and time < 23.0)"
STIMULI_DOC = """<p>Open loop, PV = 0: the set point is 0, steps to 1 at t = 1.02 s, to -1.5 at 15.02 s and
back to 0 at 30.02 s, so the output of every class leaves [CSmin, CSmax] = [0, 1] upwards and
downwards when nothing limits it. Event times are off the sampling grid of the sampled
variants. Tracking (<code>useTS</code>): TS is true on [6.02, 8.02] (TR = 0.5, inside the
limits) and [20.02, 23.02] (TR = 1.5, above CSmax). Bias (<code>useBIAS</code>): 0.3 from
3.02 s.</p>"""


# ================================================================ family A: Controllers.* --
# Controllers.Interfaces.Controller: P, PI, I, D, PD, PID
CTRL = {"SP": (-80, 60), "CS": (90, 0), "BIAS": (-40, 80), "TR": (0, 80), "TS": (40, 80),
        # the GS inputs of P and I have no iconTransformation: their placement centre (0,-92)
        # is off the grid at the standard size; (0,-90) is inside the connector
        "Kp_GS@P": (0, -90), "T_GS@I": (0, -90), "Kp_GS@PI": (-20, -80),
        # PI.Ti_GS is drawn at icon x = 42 (off grid); x = 40 is inside the connector
        "Ti_GS@PI": (40, -80)}

FAM_A = {
    "P": dict(params="Kp=2", gs=[("Kp_GS", "kpGS", "KpGS", 4.0)],
              eff=["KpE = if useGS then KpGS else 2"],
              b="{KpE}", a="{1}", tf="KpE (PV = 0)", methods=False),
    "PI": dict(params="Kp=2, Ti=5, initFromFBstart=initFromFBstart, FBstart=FBstart",
               gs=[("Kp_GS", "kpGS", "KpGS", 4.0), ("Ti_GS", "tiGS", "TiGS", 2.5)],
               eff=["KpE = if useGS then KpGS else 2", "TiE = if useGS then TiGS else 5"],
               b="KpE*{TiE, 1}", a="{TiE, 0}", tf="KpE*(1 + 1/(s*TiE))", methods=True,
               extra=["parameter Boolean initFromFBstart = false \"PI option: initialise the reset state from FBstart\" annotation(Evaluate=true);",
                      "parameter Real FBstart = 0.4 \"Reset state at t = 0 if initFromFBstart\";"],
               offset="(if initFromFBstart then FBstart else 0)"),
    "I": dict(params="T=5", gs=[("T_GS", "tGS", "TGS", 2.5)],
              eff=["TE = if useGS then TGS else 5"],
              b="{1}", a="{TE, 0}", tf="1/(s*TE)", methods=True),
    "D": dict(params="Td=1, N=5", gs=[], eff=[], b="{1, 0}", a="{1/5, 1}",
              tf="s*Td/(1 + s*Td/N), Td = 1, N = 5", methods=True),
    "PD": dict(params="Kp=2, Td=1, N=5", gs=[], eff=[], b="2*{1/5 + 1, 1}", a="{1/5, 1}",
               tf="Kp*(1 + s*Td/(1 + s*Td/N)), Kp = 2, Td = 1, N = 5", methods=True),
    "PID": dict(params="Kp=2, Ti=5, Td=Td, N=5, b=1, c=1, Tt=if Td > 0 then sqrt(5*Td) else 2.5",
                gs=[], eff=[],
                b="if Td > 0 then 2*{5*Td*(1 + 1/5), 5 + Td/5, 1} else 2*{5, 5 + 1, 1}",
                a="if Td > 0 then {5*Td/5, 5, 0} else {5, 5, 0}",
                tf="Kp*(1 + 1/(s*Ti) + s*Td/(1 + s*Td/N)), Kp = 2, Ti = 5, N = 5; for Td = 0 the "
                   "PI part times (1+s)/(1+s)", methods=True,
                extra=["parameter Real Td = 1 \"Derivative time (0 removes the derivative path)\" annotation(Evaluate=true);"]),
}

VARIANTS_A = [  # name, modifiers, description, MC/DC role
    ("AntiWindup", {"AntiWindup": "true"}, "anti-windup on",
     "pairs with Base for AntiWindup (limits held, recovery after the set-point reversal vs. the output leaving the limits)."),
    ("Tracking", {"useTS": "true"}, "tracking inputs on",
     "pairs with Base for useTS, and gives TS both values within the run."),
    ("TrackingAntiWindup", {"useTS": "true", "AntiWindup": "true"}, "tracking and anti-windup on",
     "pairs with Tracking for AntiWindup inside the tracking branch (TR = 1.5 is limited to CSmax)."),
    ("Bias", {"useBIAS": "true"}, "bias input on",
     "pairs with Base for useBIAS (output = reference + bias)."),
    ("TrackingBias", {"useTS": "true", "useBIAS": "true"}, "tracking and bias on",
     "pairs with Tracking for useBIAS inside the tracking branch (the bias is not added while tracking)."),
    ("Saturation", {"useSAT": "true"}, "saturation outputs on, anti-windup off",
     "pairs with SaturationAntiWindup for AntiWindup in `CS >= CSmax and AntiWindup` (satHI/satLOW stay false)."),
    ("SaturationAntiWindup", {"useSAT": "true", "AntiWindup": "true"}, "saturation outputs and anti-windup on",
     "pairs with AntiWindup for useSAT, and with Saturation for AntiWindup (satHI and satLOW both occur)."),
]
EXTRA_A = {
    "P": [("GainScheduling", {"useGS": "true"}, "gain-scheduling input on (Kp_GS = 4)",
           "pairs with Base for useGS (output follows the scheduled gain).")],
    "I": [("GainScheduling", {"useGS": "true"}, "gain-scheduling input on (T_GS = 2.5)",
           "pairs with Base for useGS (output follows the scheduled integral time).")],
    "PI": [("GainScheduling", {"useGS": "true"}, "gain-scheduling inputs on (Kp_GS = 4, Ti_GS = 2.5)",
            "pairs with Base for useGS."),
           ("InitFromFBstart", {"initFromFBstart": "true"}, "reset state initialised from FBstart = 0.4",
            "pairs with Base for initFromFBstart (output starts at FBstart and keeps it as an offset).")],
    "PID": [("NoDerivative", {"Td": "0"}, "derivative path removed (Td = 0)",
             "pairs with Base for `Td > 0`.")],
}
EXP_A = "StopTime=40, Interval=0.01, Tolerance=1e-6"


def family_a(name, spec):
    pkg = ROOT / name
    within = f"Tests.Controllers.MCDC.{name}"
    L = Layout(scale=0.1, grid=1, pitch=10)
    conns = {k.split("@")[0]: v for k, v in CTRL.items() if "@" not in k or k.endswith("@" + name)}
    L.comp("dut", conns, 0, 0)
    L.comp("ts", SRC, -60, 80)
    L.comp("tr", SRC, -60, 50)
    L.comp("bias", SRC, -60, 20)
    L.comp("sp", SRC, -60, -10)
    L.route("ts.y", "dut.TS", ("x", 4))
    L.route("tr.y", "dut.TR", ("x", 0))
    L.route("bias.y", "dut.BIAS", ("x", -4))
    L.route("sp.y", "dut.SP", ("x", -30), ("y", 6))
    gs = spec["gs"]
    y = -50
    for con, src, _, _ in gs:
        L.comp(src, SRC, -60, y)
        x = L.pin("dut." + con)[0]
        L.route(f"{src}.y", f"dut.{con}", ("x", x))
        y -= 30
    yref = y - 10 if gs else -50
    L.comp("spRef", SRC, -60, yref)
    L.comp("ref", SISO, -20, yref)
    L.route("spRef.y", "ref.u")

    offset = spec.get("offset", "0")
    checks = [
        Check("chkStart", "CheckRealWhile",
              ["actual=dut.CS", f"expected={offset}", "active=time < 1", "absTol=1e-3", "tStart=0.05", "dt=0.1"],
              "Output before the first set-point step: CS_start = 0 (FBstart for initFromFBstart)"),
        Check("chkRef", "CheckRealWhile",
              ["enable=not AntiWindup and not useTS", "actual=dut.CS", f"expected=ref.y + dut.bias + {offset}",
               "absTol=if Ts > 0 then 0.05 else 1e-3", "relTol=if Ts > 0 then 0.05 else 1e-3",
               f"active=Ts <= 0 or {SETTLED}", "tStart=0.9", "dt=1"],
              "Without limits and tracking: output = continuous ideal + bias; sampled: within 0.05 + 5 %, "
              "except in the 2 s after a set-point step (the discretised derivative filter decays differently)"),
        Check("chkTrack", "CheckRealWhile",
              ["enable=useTS", "actual=dut.CS",
               "expected=if AntiWindup then max(CSmin, min(CSmax, dut.tr)) else dut.tr",
               f"active={TRACK_WINDOWS}", "absTol=0.01", "tStart=0.05", "dt=0.1"],
              "Tracking: CS = TR (limited if AntiWindup), 1 s after TS rises"),
        Check("limits", "Never",
              ["enable=AntiWindup", "u=dut.CS > CSmax + tolAW or dut.CS < CSmin - tolAW"],
              "AntiWindup: CS stays in [CSmin, CSmax]"),
        Check("recovers", "Witness",
              ["enable=AntiWindup", "u=time > 15.02 and time < 18 and dut.CS < CSmax - tolAW"],
              "AntiWindup: CS leaves CSmax within 3 s of the set-point reversal (no wind-up)"),
        Check("exceedsMax", "Witness",
              ["enable=not AntiWindup", "u=dut.CS > CSmax + tolAW"],
              "No anti-windup: CS goes above CSmax (the limit is not applied)"),
        Check("exceedsMin", "Witness",
              ["enable=not AntiWindup", "u=dut.CS < CSmin - tolAW"],
              "No anti-windup: CS goes below CSmin"),
        Check("satHigh", "Witness", ["enable=useSAT and AntiWindup", "u=dut.satHigh"], "useSAT with AntiWindup: satHI occurs"),
        Check("satLow", "Witness", ["enable=useSAT and AntiWindup", "u=dut.satLow"], "useSAT with AntiWindup: satLOW occurs"),
        Check("satNone", "Never", ["enable=useSAT and not AntiWindup", "u=dut.satHigh or dut.satLow"],
              "useSAT without AntiWindup: satHI and satLOW stay false"),
        Check("satBoth", "Never", ["enable=useSAT", "u=dut.satHigh and dut.satLow"], "satHI and satLOW never together"),
    ]
    check_grid(L, checks, 50, 80)
    found = L.report(quiet=True)
    report(name, found, L)

    gsdecl = "\n".join(
        f"  Modelica.Blocks.Sources.Constant {src}(k={par}) if useGS \"Scheduled {con[:-3]}\"\n    {place(L, src)};"
        for con, src, par, _ in gs)
    gspar = "\n".join(f"  parameter Real {par} = {val} \"Scheduled value of {con[:-3]} (useGS)\";" for con, _, par, val in gs)
    extra = "\n".join("  " + e for e in spec.get("extra", []))
    eff = "\n".join(f"  final parameter Real {e} \"Effective value used by the reference\";" for e in spec["eff"])
    gsflag = ("  parameter Boolean useGS = false \"Gain-scheduling inputs\" annotation(Evaluate=true);\n"
              if gs else "")
    gsmod = "useGS=useGS, " if gs else ""
    gsconn = "\n".join(ann_line(L, f"{src}.y", f"dut.{con}", REAL) for con, src, _, _ in gs)
    x0, y0, x1, y1 = L.canvas()
    write(pkg / "Base.mo", f'''
within {within};
model Base "MC/DC base: {ICS}.{name}, open loop, every option off"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0 "Sampling time of the controller under test (0: continuous)" annotation(Evaluate=true);
  parameter IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod method=
    IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE "Discretisation method (Ts > 0)"
    annotation(Evaluate=true);
  parameter Boolean AntiWindup = false "Output limits and anti-windup" annotation(Evaluate=true);
  parameter Boolean useTS = false "Tracking inputs TS, TR" annotation(Evaluate=true);
  parameter Boolean useBIAS = false "Bias input" annotation(Evaluate=true);
  parameter Boolean useSAT = false "Saturation outputs satHI, satLOW" annotation(Evaluate=true);
{gsflag}{extra}
  parameter Real CSmin = 0 "Lower output limit";
  parameter Real CSmax = 1 "Upper output limit";
  parameter Real tolAW = 0.1
    "Tolerance of the limit checks: the limits act on CS directly, the anti-windup only once a limit has been passed";
{gspar}
{eff}
  Modelica.Blocks.Sources.BooleanTable ts(table={TS_TABLE}, startValue=false) if useTS "Track switch"
    {place(L, "ts")};
  Modelica.Blocks.Sources.TimeTable tr(table={TR_TABLE}) if useTS "Track reference"
    {place(L, "tr")};
  Modelica.Blocks.Sources.Step bias(height=0.3, startTime=3.02) if useBIAS "Bias"
    {place(L, "bias")};
  Modelica.Blocks.Sources.TimeTable sp(table={SP_TABLE}) "Set point"
    {place(L, "sp")};
{gsdecl}
  {ICS}.{name} dut(Ts=Ts, method=method, AntiWindup=AntiWindup, useTS=useTS, useBIAS=useBIAS,
    useSAT=useSAT, {gsmod}CSmin=CSmin, CSmax=CSmax, CS_start=0, {spec["params"]}, PV=0) "Controller under test"
    {place(L, "dut")};
  Modelica.Blocks.Sources.TimeTable spRef(table={SP_TABLE}) "Set point of the reference"
    {place(L, "spRef")};
  Modelica.Blocks.Continuous.TransferFunction ref(b={spec["b"]}, a={spec["a"]},
    initType=Modelica.Blocks.Types.Init.InitialState) "Continuous ideal: {spec["tf"]}"
    {place(L, "ref")};
{check_decls(L, checks)}
{passed_decl(checks)}
equation
{ann_line(L, "ts.y", "dut.TS", BOOL)}
{ann_line(L, "tr.y", "dut.TR", REAL)}
{ann_line(L, "bias.y", "dut.BIAS", REAL)}
{ann_line(L, "sp.y", "dut.SP", REAL)}
{gsconn}
{ann_line(L, "spRef.y", "ref.u", REAL)}
  annotation (
    experiment({EXP_A}),
    Diagram(coordinateSystem(extent={{{{{x0},{y0}}},{{{x1},{y1}}}}}, grid={{1,1}})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\\"modelica://{ICS}.{name}\\">{ICS}.{name}</a>: the class
under test <code>dut</code> with every option off, its stimuli, a continuous ideal
<code>ref</code> built from <code>Modelica.Blocks</code>, and the checks. The variants in this
package extend it and change one option (or the pair an MC/DC independence pair needs); a
source that only an option needs is instantiated only with it.</p>
{html(STIMULI_DOC)}
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul>{"".join(f"<li><code>{c.name}</code>: {html(c.doc)}</li>" for c in checks)}</ul>
<p>Limit checks use the tolerance <code>tolAW</code> = 0.1 (anti-windup acts only once a limit
has been passed). Sampled variants (<code>Ts</code> = 0.05) are compared with the continuous
ideal within 0.05 + 5 %.</p>
</html>"));
end Base;
''')
    variants = list(VARIANTS_A) + EXTRA_A.get(name, [])
    order = ["Base"]
    for vname, mods, desc, role in variants:
        variant_file(pkg, within, vname, mods, f"{name}: {desc}", role, EXP_A)
        order.append(vname)
    sampled = [("Sampled", {"Ts": "0.05"}, "sampled (Ts = 0.05, Backward Euler)",
                "pairs with Base for `Ts > 0` (the sampled branch); compared with the continuous ideal.")]
    for vname, mods, desc, role in variants:
        sampled.append(("Sampled" + vname, dict(mods, Ts="0.05"), desc + ", sampled (Ts = 0.05)",
                        role.replace("pairs with ", "pairs with Sampled").replace("SampledBase", "Sampled")))
    if spec["methods"]:
        sampled += [
            ("SampledForwardEuler", {"Ts": "0.05", "method": "IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE"},
             "sampled, Forward Euler", "covers method = FE in the discretisation decision."),
            ("SampledTustin", {"Ts": "0.05", "method": "IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU"},
             "sampled, Tustin", "covers method = TU in the discretisation decision.")]
    for vname, mods, desc, role in sampled:
        variant_file(pkg, within, vname, mods, f"{name}: {desc}", role, EXP_A)
        order.append(vname)
    write_package(pkg, "Tests.Controllers.MCDC", name,
                  f"MC/DC tests of {ICS}.{name}. Base model and one variant per option change; "
                  f"continuous and sampled (Ts = 0.05).", order)
    return order


# ================================================================ family D: Controllers.Digital --
DIG = {"SP": (-80, 80), "CS": (90, 0), "BIAS": (-40, 80), "TR": (0, 80), "TS": (40, 80),
       "MAN": (-80, 0), "CSinc": (-80, -40), "Finc": (-40, -80), "Fdec": (20, -80)}
FAM_D = {"PID_2dof": False, "PID_2dof_TDO": True, "PID_2dof_TDO_FullyEventBased": True}
TS_D = 0.1
VARIANTS_D = [
    ("AntiWindup", {"AntiWindup": "true"}, "anti-windup on",
     "pairs with Base for AntiWindup in `cs > CSmax and AntiWindup` and `cs < CSmin and AntiWindup`."),
    ("Tracking", {"useTS": "true"}, "tracking inputs on", "pairs with Base for useTS (`not ts` in the mode decision)."),
    ("TrackingAntiWindup", {"useTS": "true", "AntiWindup": "true"}, "tracking and anti-windup on",
     "pairs with Tracking for AntiWindup (TR = 1.5 limited to CSmax)."),
    ("Bias", {"useBIAS": "true"}, "bias input on", "pairs with Base for useBIAS."),
    ("TrackingBias", {"useTS": "true", "useBIAS": "true"}, "tracking and bias on",
     "pairs with Tracking for useBIAS (no bias while tracking)."),
    ("Manual", {"useMAN": "true"}, "manual inputs on",
     "pairs with Base for useMAN (`not man` in the mode decision; CS += CSinc per sample)."),
    ("ManualTracking", {"useMAN": "true", "useTS": "true"}, "manual and tracking inputs on",
     "pairs with Tracking for `man` (manual has priority over tracking)."),
    ("Forbid", {"useForbid": "true"}, "forbid inputs on",
     "pairs with Base for useForbid; F_inc while CS rises and falls, F_dec while it falls and rises "
     "(each condition of `F_inc and (not man) and cs > pre(cs)`)."),
    ("ForbidManual", {"useForbid": "true", "useMAN": "true"}, "forbid and manual inputs on",
     "pairs with Forbid for `not man` in the forbid decisions (manual increments pass F_inc)."),
    ("NoDerivative", {"Td": "0"}, "derivative path removed (Td = 0)", "pairs with Base for `Td > 0`."),
]
EXP_D = "StopTime=40, Interval=0.01, Tolerance=1e-6"


def family_d(name, pwm):
    pkg = ROOT / "Digital" / name
    within = f"Tests.Controllers.MCDC.Digital.{name}"
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", DIG, 0, 0)
    L.comp("ts", SRC, -60, 80)
    L.comp("tr", SRC, -60, 50)
    L.comp("bias", SRC, -60, 20)
    L.comp("sp", SRC, -60, -10)
    L.comp("man", SRC, -60, -40)
    L.comp("csInc", SRC, -60, -70)
    L.comp("fInc", SRC, -60, -100)
    L.comp("fDec", SRC, -60, -130)
    L.route("ts.y", "dut.TS", ("x", 4))
    L.route("tr.y", "dut.TR", ("x", 0))
    L.route("bias.y", "dut.BIAS", ("x", -4))
    L.route("sp.y", "dut.SP", ("x", -30), ("y", 8))
    L.route("man.y", "dut.MAN", ("x", -20), ("y", 0))
    L.route("csInc.y", "dut.CSinc", ("x", -14), ("y", -4))
    L.route("fInc.y", "dut.Finc", ("x", -4))
    L.route("fDec.y", "dut.Fdec", ("x", 2))
    L.comp("spRef", SRC, -60, -160)
    L.comp("ref", SISO, -20, -160)
    L.route("spRef.y", "ref.u")
    if pwm:
        L.comp("csMean", SISO, 40, -40)
        L.route("dut.CS", "csMean.u", ("x", 20), ("y", -40))
    sig = "dut.cs" if pwm else "dut.CS"
    checks = [
        Check("chkStart", "CheckRealWhile", [f"actual={sig}", "expected=0", "active=time < 1", "absTol=1e-3",
                                             "tStart=0.05", "dt=0.1"], "Output before the first set-point step: 0"),
        Check("chkRef", "CheckRealWhile",
              ["enable=not AntiWindup and not useTS and not useMAN and not useForbid", f"actual={sig}",
               "expected=ref.y + dut.bias", "absTol=0.05", "relTol=0.05", f"active={SETTLED}", "tStart=0.9", "dt=1"],
              "Automatic mode without limits: control signal = continuous ideal + bias, within 0.05 + 5 %, "
              "except in the 2 s after a set-point step (the discretised derivative filter decays differently)"),
        Check("chkTrack", "CheckRealWhile",
              ["enable=useTS", f"actual={sig}", "expected=if AntiWindup then max(CSmin, min(CSmax, dut.tr)) else dut.tr",
               "active=(time > 6.35 and time < 6.5) or (time > 7.85 and time < 8.0) or (time > 20.35 and time < 23.0)",
               "absTol=1e-6", "tStart=0.05", "dt=0.1"],
              "Tracking (and not manual): control signal = TR (limited if AntiWindup), from the second sample"),
        Check("chkMan", "CheckRealWhile",
              ["enable=useMAN", f"actual={sig}", f"expected=csMan0 + 0.01/{TS_D}*(time - 6.55)",
               "active=time > 6.75 and time < 7.5", "absTol=0.02", "tStart=0.05", "dt=0.1"],
              "Manual (MAN on [6.52, 7.52]): control signal rises by CSinc = 0.01 per sample, also while TS or F_inc"),
        Check("chkFrozen", "CheckRealWhile",
              ["enable=useForbid", f"actual={sig}", "expected=if time < 10 then csInc0 else csDec0",
               "active=(time > 3.8 and time < 6.45) or (time > 17.8 and time < 19.5)", "absTol=1e-6",
               "tStart=0.05", "dt=0.1"],
              "F_inc while the signal rises, F_dec while it falls: the control signal is held"),
        Check("incPasses", "Witness", ["enable=useForbid and not useMAN", f"u=time > 10.3 and time < 12 and {sig} > csDec1 + 0.1"],
              "F_dec while the signal rises: the rise passes"),
        Check("decPasses", "Witness", ["enable=useForbid and not useMAN", f"u=time > 24.3 and time < 26 and {sig} < csInc1 - 0.1"],
              "F_inc while the signal falls: the fall passes"),
        Check("limits", "Never", ["enable=AntiWindup", f"u={sig} > CSmax + tolAW or {sig} < CSmin - tolAW"],
              "AntiWindup: the control signal stays in [CSmin, CSmax]"),
        Check("recovers", "Witness", ["enable=AntiWindup", f"u=time > 15.02 and time < 18 and {sig} < CSmax - tolAW"],
              "AntiWindup: the control signal leaves CSmax within 3 s of the set-point reversal"),
        Check("exceedsMax", "Witness", ["enable=not AntiWindup", f"u={sig} > CSmax + tolAW"], "No anti-windup: above CSmax"),
        Check("exceedsMin", "Witness", ["enable=not AntiWindup", f"u={sig} < CSmin - tolAW"], "No anti-windup: below CSmin"),
        Check("satHigh", "Witness", ["enable=AntiWindup", "u=dut.satHI"], "AntiWindup: satHI occurs"),
        Check("satNone", "Never", ["enable=not AntiWindup", "u=dut.satHI or dut.satLOW"], "No anti-windup: satHI, satLOW stay false"),
    ]
    if pwm:
        checks += [
            Check("pwmLevels", "Never", ["u=dut.CS > CSmin + 1e-9 and dut.CS < CSmax - 1e-9"],
                  "Time-division output: CS is always CSmin or CSmax"),
            Check("pwmMean", "CheckRealWhile",
                  ["actual=csMean.y", "expected=max(CSmin, min(CSmax, csPrev))", "absTol=0.02",
                   f"tStart={TS_D}*1.5", f"dt={TS_D}"],
                  "Time-division output: its mean over each period = the control signal of that period, limited"),
        ]
    check_grid(L, checks, 80, 80)
    report("Digital." + name, L.report(quiet=True), L)
    x0, y0, x1, y1 = L.canvas()
    pwm_decl = (f'''  Modelica.Blocks.Math.Mean csMean(f=1/{TS_D}, x0=0) "Mean of CS over each sampling period"
    {place(L, "csMean")};
  discrete Real csPrev(start=0, fixed=true) "Control signal of the previous sampling period";
''' if pwm else "")
    pwm_eq = (f'''  connect(dut.CS, csMean.u) annotation (Line(points={L.points("dut.CS", "csMean.u")}, color={REAL}));
  when sample({TS_D}, {TS_D}) then
    csPrev = pre(csLast);
  end when;
''' if pwm else "")
    if pwm:
        pwm_eq = (f'''  connect(dut.CS, csMean.u) annotation (Line(points={L.points("dut.CS", "csMean.u")}, color={REAL}));
  when sample({TS_D}, {TS_D}) then
    csPrev = pre(csLast);
    csLast = dut.cs;
  end when;
''')
        pwm_decl += "  discrete Real csLast(start=0, fixed=true) \"Control signal sampled at the start of a period\";\n"
    write(pkg / "Base.mo", f'''
within {within};
model Base "MC/DC base: {ICS}.Digital.{name}, open loop, every option off"
  extends Modelica.Icons.Example;
  parameter Boolean AntiWindup = false "Output limits and anti-windup" annotation(Evaluate=true);
  parameter Boolean useTS = false "Tracking inputs TS, TR" annotation(Evaluate=true);
  parameter Boolean useBIAS = false "Bias input" annotation(Evaluate=true);
  parameter Boolean useMAN = false "Manual inputs MAN, CSinc" annotation(Evaluate=true);
  parameter Boolean useForbid = false "Forbid inputs Finc, Fdec" annotation(Evaluate=true);
  parameter Real Td = 1 "Derivative time (0 removes the derivative path)" annotation(Evaluate=true);
  parameter Real CSmin = 0 "Lower output limit";
  parameter Real CSmax = 1 "Upper output limit";
  parameter Real tolAW = 0.1 "Tolerance of the limit checks";
  Modelica.Blocks.Sources.BooleanTable ts(table={TS_TABLE}, startValue=false) if useTS "Track switch"
    {place(L, "ts")};
  Modelica.Blocks.Sources.TimeTable tr(table={TR_TABLE}) if useTS "Track reference"
    {place(L, "tr")};
  Modelica.Blocks.Sources.Step bias(height=0.3, startTime=3.02) if useBIAS "Bias"
    {place(L, "bias")};
  Modelica.Blocks.Sources.TimeTable sp(table={SP_TABLE}) "Set point"
    {place(L, "sp")};
  Modelica.Blocks.Sources.BooleanTable man(table={{6.52, 7.52}}, startValue=false) if useMAN "Manual mode"
    {place(L, "man")};
  Modelica.Blocks.Sources.Constant csInc(k=0.01) if useMAN "Manual increment per sample"
    {place(L, "csInc")};
  Modelica.Blocks.Sources.BooleanTable fInc(table={{3.52, 7.52, 24.02, 26.02}}, startValue=false) if useForbid
    "Forbid increments: while rising (and manual), then while falling"
    {place(L, "fInc")};
  Modelica.Blocks.Sources.BooleanTable fDec(table={{10.02, 12.02, 17.52, 19.52}}, startValue=false) if useForbid
    "Forbid decrements: while rising, then while falling"
    {place(L, "fDec")};
  {ICS}.Digital.{name} dut(Ts={TS_D}, AntiWindup=AntiWindup, useTS=useTS, useBIAS=useBIAS, useMAN=useMAN,
    useForbid=useForbid, CSmin=CSmin, CSmax=CSmax, Kp=2, Ti=5, Td=Td, N=5, b=1, c=1, PV=0) "Controller under test"
    {place(L, "dut")};
  Modelica.Blocks.Sources.TimeTable spRef(table={SP_TABLE}) "Set point of the reference"
    {place(L, "spRef")};
  Modelica.Blocks.Continuous.TransferFunction ref(
    b=if Td > 0 then 2*{{5*Td*(1 + 1/5), 5 + Td/5, 1}} else 2*{{5, 5 + 1, 1}},
    a=if Td > 0 then {{5*Td/5, 5, 0}} else {{5, 5, 0}},
    initType=Modelica.Blocks.Types.Init.InitialState)
    "Continuous ideal: Kp*(b + 1/(s*Ti) + c*s*Td/(1 + s*Td/N)), Kp = 2, Ti = 5, N = 5, b = c = 1"
    {place(L, "ref")};
{pwm_decl}  discrete Real csMan0(start=0, fixed=true) "Control signal when manual mode starts";
  discrete Real csInc0(start=0, fixed=true) "Control signal when F_inc rises the first time";
  discrete Real csDec0(start=0, fixed=true) "Control signal when F_dec rises the second time";
  discrete Real csDec1(start=0, fixed=true) "Control signal when F_dec rises the first time";
  discrete Real csInc1(start=0, fixed=true) "Control signal when F_inc rises the second time";
{check_decls(L, checks)}
{passed_decl(checks)}
equation
{ann_line(L, "ts.y", "dut.TS", BOOL)}
{ann_line(L, "tr.y", "dut.TR", REAL)}
{ann_line(L, "bias.y", "dut.BIAS", REAL)}
{ann_line(L, "sp.y", "dut.SP", REAL)}
{ann_line(L, "man.y", "dut.MAN", BOOL)}
{ann_line(L, "csInc.y", "dut.CSinc", REAL)}
{ann_line(L, "fInc.y", "dut.Finc", BOOL)}
{ann_line(L, "fDec.y", "dut.Fdec", BOOL)}
{ann_line(L, "spRef.y", "ref.u", REAL)}
{pwm_eq}  when time >= 6.52 then
    csMan0 = {sig};
  end when;
  when time >= 3.52 then
    csInc0 = {sig};
  end when;
  when time >= 24.02 then
    csInc1 = {sig};
  end when;
  when time >= 10.02 then
    csDec1 = {sig};
  end when;
  when time >= 17.52 then
    csDec0 = {sig};
  end when;
  annotation (
    experiment({EXP_D}),
    Diagram(coordinateSystem(extent={{{{{x0},{y0}}},{{{x1},{y1}}}}}, grid={{1,1}})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\\"modelica://{ICS}.Digital.{name}\\">{ICS}.Digital.{name}</a>
(Ts = {TS_D}, Kp = 2, Ti = 5, Td = 1, N = 5, b = c = 1): <code>dut</code> with every option off, its
stimuli, a continuous ideal <code>ref</code>, and the checks. The variants extend it and change one
option or an MC/DC pair; a source that only an option needs is instantiated only with it.</p>
{html(STIMULI_DOC)}
<p>Manual (<code>useMAN</code>): MAN on [6.52, 7.52] (inside the first tracking window and the first
F_inc window), CSinc = 0.01. Forbid (<code>useForbid</code>): F_inc on [3.52, 7.52] (signal rising)
and [24.02, 26.02] (falling); F_dec on [10.02, 12.02] (rising) and [17.52, 19.52] (falling, after the derivative kick of the set-point reversal has decayed).</p>
{"<p>The output is time-division (PWM) between CSmin and CSmax, so the checks of the control law use the public internal signal <code>dut.cs</code>; <code>pwmLevels</code> and <code>pwmMean</code> check the output itself.</p>" if pwm else ""}
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul>{"".join(f"<li><code>{c.name}</code>: {html(c.doc)}</li>" for c in checks)}</ul>
</html>"));
end Base;
''')
    order = ["Base"]
    for vname, mods, desc, role in VARIANTS_D:
        variant_file(pkg, within, vname, mods, f"Digital.{name}: {desc}", role, EXP_D)
        order.append(vname)
    write_package(pkg, "Tests.Controllers.MCDC.Digital", name,
                  f"MC/DC tests of {ICS}.Digital.{name}. Base model and one variant per option change.", order)
    return order


# ================================================================ family T: AutoTuning --
FAM_T = ["ATPIrelayNCdigital", "ATPIrelayNCmixedMode"]
CTRL_T = dict(CTRL, ATreq=(-80, -80), PV=(-80, -10))
VARIANTS_T = VARIANTS_A[:5]
EXP_T = "StopTime=260, Interval=0.05, Tolerance=1e-6"


def family_t(name):
    pkg = ROOT / "AutoTuning" / name
    within = f"Tests.Controllers.MCDC.AutoTuning.{name}"
    L = Layout(scale=0.1, grid=1, pitch=10)
    conns = {k: v for k, v in CTRL_T.items() if "@" not in k}
    L.comp("dut", conns, 0, 0)
    L.comp("ts", SRC, -80, 80)
    L.comp("tr", SRC, -80, 50)
    L.comp("bias", SRC, -80, 20)
    L.comp("sp", SRC, -80, -10)
    L.comp("atReq", SRC, -30, -40)
    L.comp("add", {"u1": (-120, 60), "u2": (-120, -60), "y": (110, 0)}, 40, 0)
    L.comp("load", SRC, 10, -30)
    L.comp("plant", SISO, 80, 0)
    L.route("ts.y", "dut.TS", ("x", 4))
    L.route("tr.y", "dut.TR", ("x", 0))
    L.route("bias.y", "dut.BIAS", ("x", -4))
    L.route("sp.y", "dut.SP", ("x", -60), ("y", 6))
    L.route("atReq.y", "dut.ATreq", ("x", -8))
    L.route("dut.CS", "add.u1", ("x", 20), ("y", 6))
    L.route("load.y", "add.u2", ("x", 24), ("y", -6))
    L.route("add.y", "plant.u")
    L.route("plant.y", "dut.PV", ("x", 100), ("y", -60), ("x", -50), ("y", -1))
    checks = [
        Check("tuned", "Witness", ["u=time > 61 and dut.iMode == 0 and abs(dut.K - Kp0) > 1e-3"],
              "The autotuning started at t = 60 s ends and changes the gain"),
        Check("chkK", "CheckRealWhile", ["actual=dut.K", "expected=Kexp", "relTol=0.2", "active=time > 130", "tStart=0.5", "dt=10"],
              "Tuned gain within 20 % of the value for the exact -90 degree point of the plant"),
        Check("chkTI", "CheckRealWhile", ["actual=dut.TI", "expected=TIexp", "relTol=0.2", "active=time > 130", "tStart=0.5", "dt=10"],
              "Tuned integral time within 20 % of the exact value"),
        Check("chkTrack", "CheckRealWhile",
              ["enable=useTS", "actual=dut.CS", "expected=if AntiWindup then max(CSmin, min(CSmax, dut.tr)) else dut.tr",
               "active=(time > 141 and time < 150) or (time > 241 and time < 250)", "absTol=0.01", "tStart=0.05", "dt=0.1"],
              "Tracking (TS on [140, 150] with TR = 0.3 and [240, 250] with TR = 1.5): CS = TR, limited if AntiWindup"),
        Check("biasStep", "Witness",
              ["enable=useBIAS", "u=time > 160.05 and time < 160.3 and abs(dut.CS - cs0 - 0.2) < 0.03"],
              "The bias step of 0.2 at t = 160.02 s appears in CS"),
        Check("limits", "Never", ["enable=AntiWindup", "u=dut.iMode == 0 and (dut.CS > CSmax + tolAW or dut.CS < CSmin - tolAW)"],
              "AntiWindup: in PI mode CS stays in [CSmin, CSmax] (the relay test is not limited)"),
        Check("recovers", "Witness", ["enable=AntiWindup", "u=time > 230.02 and time < 236 and dut.CS < CSmax - tolAW"],
              "AntiWindup: CS leaves CSmax soon after the load returns at t = 230 s"),
        Check("exceedsMax", "Witness", ["enable=not AntiWindup", "u=time > 180 and dut.CS > CSmax + tolAW"],
              "No anti-windup: the load from t = 180 s drives CS above CSmax"),
    ]
    check_grid(L, checks, 140, 80)
    report("AutoTuning." + name, L.report(quiet=True), L)
    x0, y0, x1, y1 = L.canvas()
    write(pkg / "Base.mo", f'''
within {within};
model Base "MC/DC base: {ICS}.AutoTuning.{name}, closed loop, every option off"
  extends Modelica.Icons.Example;
  parameter Boolean AntiWindup = false "Output limits and anti-windup in PI mode" annotation(Evaluate=true);
  parameter Boolean useTS = false "Tracking inputs TS, TR" annotation(Evaluate=true);
  parameter Boolean useBIAS = false "Bias input" annotation(Evaluate=true);
  parameter Real CSmin = 0 "Lower output limit";
  parameter Real CSmax = 1 "Upper output limit";
  parameter Real tolAW = 0.1 "Tolerance of the limit checks";
  parameter Real Kp0 = 0.2 "Initial gain";
  parameter Real pm = 45 "Required phase margin [deg]";
  final parameter Real wox = tan(Modelica.Constants.pi/6) "Plant 1/(s+1)^3 has -90 degrees at tan(30 deg) rad/s";
  final parameter Real Pox = 1/(1 + wox^2)^1.5 "Plant gain at wox";
  final parameter Real TIexp = tan(pm*Modelica.Constants.pi/180)/wox "Integral time the method gives for the exact point";
  final parameter Real Kexp = wox*TIexp/Pox/sqrt(1 + (wox*TIexp)^2) "Gain the method gives for the exact point";
  discrete Real cs0(start=0, fixed=true) "CS just before the bias step";
  Modelica.Blocks.Sources.BooleanTable ts(table={{140, 150, 240, 250}}, startValue=false) if useTS "Track switch"
    {place(L, "ts")};
  Modelica.Blocks.Sources.TimeTable tr(table=[0,0.3; 200,0.3; 200,1.5; 260,1.5]) if useTS "Track reference"
    {place(L, "tr")};
  Modelica.Blocks.Sources.Step bias(height=0.2, startTime=160.02) if useBIAS "Bias"
    {place(L, "bias")};
  Modelica.Blocks.Sources.Step sp(offset=0.5, height=0.3, startTime=120.02) "Set point"
    {place(L, "sp")};
  Modelica.Blocks.Sources.BooleanTable atReq(table={{60, 60.1}}, startValue=false) "Autotuning request"
    {place(L, "atReq")};
  {ICS}.AutoTuning.{name} dut(Ts=0.1, AntiWindup=AntiWindup, useTS=useTS, useBIAS=useBIAS,
    CSmin=CSmin, CSmax=CSmax, Kp=Kp0, Ti=2, slope=0.02, pm=pm) "Controller under test"
    {place(L, "dut")};
  Modelica.Blocks.Math.Add add "Control signal + load"
    {place(L, "add")};
  Modelica.Blocks.Sources.TimeTable load(table=[0,0; 180,0; 180,-0.8; 230,-0.8; 230,0; 260,0])
    "Load that needs CS = 1.6 from t = 180 s to 230 s"
    {place(L, "load")};
  IndustrialControlSystems.LinearSystems.Continuous.TransferFunction plant(num={{1}}, den={{1, 3, 3, 1}},
    initSteadyState=true) "Plant 1/(s+1)^3"
    {place(L, "plant")};
{check_decls(L, checks)}
{passed_decl(checks)}
equation
{ann_line(L, "ts.y", "dut.TS", BOOL)}
{ann_line(L, "tr.y", "dut.TR", REAL)}
{ann_line(L, "bias.y", "dut.BIAS", REAL)}
{ann_line(L, "sp.y", "dut.SP", REAL)}
{ann_line(L, "atReq.y", "dut.ATreq", BOOL)}
{ann_line(L, "dut.CS", "add.u1", REAL)}
{ann_line(L, "load.y", "add.u2", REAL)}
{ann_line(L, "add.y", "plant.u", REAL)}
{ann_line(L, "plant.y", "dut.PV", REAL)}
  when time >= 159.95 then
    cs0 = dut.CS;
  end when;
  annotation (
    experiment({EXP_T}),
    Diagram(coordinateSystem(extent={{{{{x0},{y0}}},{{{x1},{y1}}}}}, grid={{1,1}})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\\"modelica://{ICS}.AutoTuning.{name}\\">{ICS}.AutoTuning.{name}</a>
on the plant 1/(s+1)^3 (as in <code>Tests.Controllers.AutoTuning</code>): initial PI Kp = 0.2,
Ti = 2; autotuning requested at t = 60 s (relay slope 0.02, pm = 45 deg); set point 0.5, 0.8 from
120 s; a load of -0.8 on [180, 230] s needs CS = 1.6, above CSmax = 1. The variants extend it and
change one option or an MC/DC pair.</p>
<p>The expected tuning uses the exact -90 degree point of the plant (w = tan 30 deg,
|P| = 0.65); the method estimates it from the relay oscillation by a describing function, hence
the 20 % tolerance.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul>{"".join(f"<li><code>{c.name}</code>: {html(c.doc)}</li>" for c in checks)}</ul>
</html>"));
end Base;
''')
    order = ["Base"]
    for vname, mods, desc, role in VARIANTS_T:
        variant_file(pkg, within, vname, mods, f"AutoTuning.{name}: {desc}", role, EXP_T)
        order.append(vname)
    write_package(pkg, "Tests.Controllers.MCDC.AutoTuning", name,
                  f"MC/DC tests of {ICS}.AutoTuning.{name}. Base model and one variant per option change.", order)
    return order


# ================================================================ family B: Controllers.Blocks --
BLK = {"u": (-80, 0), "y": (90, 0), "TS": (50, 80),
       # Interfaces.Block draws TR at icon x = 2 (off grid at the standard size); x = 0 is inside it
       "TR": (0, 80)}
FAM_B = {
    "P": ("Kp=2", "Modelica.Blocks.Math.Gain ref(k=2)", "gain 2"),
    "I": ("T=5", "Modelica.Blocks.Continuous.Integrator ref(k=1/5, initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=0)", "1/(5 s)"),
    "FO": ("mu=2, T=2", "Modelica.Blocks.Continuous.FirstOrder ref(k=2, T=2, initType=Modelica.Blocks.Types.Init.InitialOutput, y_start=0)", "2/(1 + 2 s)"),
    "LeadLAG": ("mu=2, Tp=1, Tz=2", "Modelica.Blocks.Continuous.TransferFunction ref(b=2*{2, 1}, a={1, 1}, initType=Modelica.Blocks.Types.Init.InitialState)", "2(1 + 2 s)/(1 + s)"),
    "ComplexPoles": ("mu=2, omega=1, xi=0.5", "Modelica.Blocks.Continuous.SecondOrder ref(k=2, w=1, D=0.5, initType=Modelica.Blocks.Types.Init.InitialState, y_start=0, yd_start=0)", "2/(1 + s + s^2)"),
}
VARIANTS_B = [VARIANTS_A[0], VARIANTS_A[1], VARIANTS_A[2]]
EXP_B = "StopTime=40, Interval=0.01, Tolerance=1e-6"


def family_b(name, spec):
    params, refdecl, tf = spec
    pkg = ROOT / "Blocks" / name
    within = f"Tests.Controllers.MCDC.Blocks.{name}"
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", BLK, 0, 0)
    L.comp("ts", SRC, -60, 60)
    L.comp("tr", SRC, -60, 30)
    L.comp("u", SRC, -60, 0)
    L.comp("uRef", SRC, -60, -40)
    L.comp("ref", SISO, -20, -40)
    L.route("ts.y", "dut.TS", ("x", 5))
    L.route("tr.y", "dut.TR", ("x", 0))
    L.route("u.y", "dut.u")
    L.route("uRef.y", "ref.u")
    checks = [
        Check("chkStart", "CheckRealWhile", ["actual=dut.y", "expected=0", "active=time < 1", "absTol=1e-3",
                                             "tStart=0.05", "dt=0.1"], "Output before the first input step: 0"),
        Check("chkRef", "CheckRealWhile", ["enable=not AntiWindup and not useTS", "actual=dut.y", "expected=ref.y",
                                           "absTol=1e-3", "relTol=1e-3", "tStart=0.9", "dt=1"],
              f"Without limits and tracking: y = {tf} of u (Modelica.Blocks reference)"),
        Check("chkTrack", "CheckRealWhile",
              ["enable=useTS", "actual=dut.y", "expected=if AntiWindup then max(Ymin, min(Ymax, dut.tr)) else dut.tr",
               f"active={TRACK_WINDOWS}", "absTol=0.01", "tStart=0.05", "dt=0.1"],
              "Tracking: y = TR (limited if AntiWindup), 1 s after TS rises"),
        Check("limits", "Never", ["enable=AntiWindup", "u=dut.y > Ymax + tolAW or dut.y < Ymin - tolAW"],
              "AntiWindup: y stays in [Ymin, Ymax]"),
        Check("recovers", "Witness", ["enable=AntiWindup", "u=time > 15.02 and time < 18 and dut.y < Ymax - tolAW"],
              "AntiWindup: y leaves Ymax within 3 s of the input reversal"),
        Check("exceedsMax", "Witness", ["enable=not AntiWindup", "u=dut.y > Ymax + tolAW"], "No anti-windup: y goes above Ymax"),
        Check("exceedsMin", "Witness", ["enable=not AntiWindup", "u=dut.y < Ymin - tolAW"], "No anti-windup: y goes below Ymin"),
    ]
    check_grid(L, checks, 50, 60)
    report("Blocks." + name, L.report(quiet=True), L)
    x0, y0, x1, y1 = L.canvas()
    refdecl = refdecl.replace(" ref(", f" ref(", 1)
    write(pkg / "Base.mo", f'''
within {within};
model Base "MC/DC base: {ICS}.Blocks.{name}, every option off"
  extends Modelica.Icons.Example;
  parameter Boolean AntiWindup = false "Output limits and anti-windup" annotation(Evaluate=true);
  parameter Boolean useTS = false "Tracking inputs TS, TR" annotation(Evaluate=true);
  parameter Real Ymin = 0 "Lower output limit";
  parameter Real Ymax = 1 "Upper output limit";
  parameter Real tolAW = 0.1 "Tolerance of the limit checks";
  Modelica.Blocks.Sources.BooleanTable ts(table={TS_TABLE}, startValue=false) if useTS "Track switch"
    {place(L, "ts")};
  Modelica.Blocks.Sources.TimeTable tr(table={TR_TABLE}) if useTS "Track reference"
    {place(L, "tr")};
  Modelica.Blocks.Sources.TimeTable u(table={SP_TABLE}) "Input"
    {place(L, "u")};
  {ICS}.Blocks.{name} dut(AntiWindup=AntiWindup, useTS=useTS, Ymin=Ymin, Ymax=Ymax, {params}) "Block under test"
    {place(L, "dut")};
  Modelica.Blocks.Sources.TimeTable uRef(table={SP_TABLE}) "Input of the reference"
    {place(L, "uRef")};
  {refdecl} "Reference: {tf}"
    {place(L, "ref")};
{check_decls(L, checks)}
{passed_decl(checks)}
equation
{ann_line(L, "ts.y", "dut.TS", BOOL)}
{ann_line(L, "tr.y", "dut.TR", REAL)}
{ann_line(L, "u.y", "dut.u", REAL)}
{ann_line(L, "uRef.y", "ref.u", REAL)}
  annotation (
    experiment({EXP_B}),
    Diagram(coordinateSystem(extent={{{{{x0},{y0}}},{{{x1},{y1}}}}}, grid={{1,1}})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\\"modelica://{ICS}.Blocks.{name}\\">{ICS}.Blocks.{name}</a>
({html(params)}): <code>dut</code> with every option off, its input, a reference from
<code>Modelica.Blocks</code> ({html(tf)}), and the checks. The variants extend it and change one option or
an MC/DC pair.</p>
{html(STIMULI_DOC.replace("set point", "input"))}
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul>{"".join(f"<li><code>{c.name}</code>: {html(c.doc)}</li>" for c in checks)}</ul>
</html>"));
end Base;
''')
    order = ["Base"]
    for vname, mods, desc, role in VARIANTS_B:
        variant_file(pkg, within, vname, mods, f"Blocks.{name}: {desc}", role, EXP_B)
        order.append(vname)
    write_package(pkg, "Tests.Controllers.MCDC.Blocks", name,
                  f"MC/DC tests of {ICS}.Blocks.{name}. Base model and one variant per option change.", order)
    return order


# ================================================================ family L: Controllers.Logic --
def family_l(name):
    hyst = name == "RelayHysteresis"
    pkg = ROOT / "Logic" / name
    within = f"Tests.Controllers.MCDC.Logic.{name}"
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", {"u": (-80, 0), "y": (90, 0)}, 0, 0)
    L.comp("u", SRC, -40, 0)
    L.route("u.y", "dut.u")
    band = "(if Ts > 0 then 0.2 else 0.01)"
    if hyst:
        active = f"abs(u.y - ThH) > {band} and abs(u.y - ThL) > {band}"
        expected = "if hi then Ymax else Ymin"
        doc = "y = Ymax after u reached ThH, Ymin after u reached ThL, the initial state before either"
    else:
        active = f"abs(u.y - Th) > {band}"
        expected = "if u.y >= Th then Ymax else Ymin"
        doc = "y = Ymax where u >= Th, Ymin elsewhere"
    checks = [Check("chkRelay", "CheckRealWhile", ["actual=dut.y", f"expected={expected}", f"active={active}",
                                                   "absTol=1e-9", "tStart=0.01", "dt=0.02"],
                    doc + " (away from the thresholds by more than the input moves in one sample)")]
    check_grid(L, checks, 40, 0)
    report("Logic." + name, L.report(quiet=True), L)
    x0, y0, x1, y1 = L.canvas()
    hdecl = ('  parameter Boolean initState = false "Initial state of the relay" annotation(Evaluate=true);\n'
             '  parameter Real ThL = -0.3 "Low threshold";\n  parameter Real ThH = 0.3 "High threshold";\n'
             '  discrete Boolean hi(start=initState, fixed=true) "Expected state";\n') if hyst else \
        '  parameter Real Th = 0.3 "Threshold";\n'
    hmods = "ThL=ThL, ThH=ThH, initState=initState" if hyst else "Th=Th"
    heq = ("  when u.y >= ThH then\n    hi = true;\n  elsewhen u.y <= ThL then\n    hi = false;\n  end when;\n"
           if hyst else "")
    write(pkg / "Base.mo", f'''
within {within};
model Base "MC/DC base: {ICS}.Logic.{name}, continuous, every option off"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);
  parameter Real Ymin = 0 "Output when off";
  parameter Real Ymax = 1 "Output when on";
{hdecl}  Modelica.Blocks.Sources.Sine u(amplitude=1, f=0.2) "Input"
    {place(L, "u")};
  {ICS}.Logic.{name} dut(Ts=Ts, Ymin=Ymin, Ymax=Ymax, {hmods}) "Relay under test"
    {place(L, "dut")};
{check_decls(L, checks)}
{passed_decl(checks)}
equation
{ann_line(L, "u.y", "dut.u", REAL)}
{heq}  annotation (
    experiment(StopTime=12, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{{{{x0},{y0}}},{{{x1},{y1}}}}}, grid={{1,1}})),
    Documentation(info="<html>
<p>Base of the MC/DC tests of <a href=\\"modelica://{ICS}.Logic.{name}\\">{ICS}.Logic.{name}</a>:
a sine of amplitude 1 and 0.2 Hz{" between the thresholds -0.3 and 0.3" if hyst else " against the threshold 0.3"}.
The expected output is stated independently{" by a state that switches on at ThH and off at ThL" if hyst else ""};
<code>chkRelay</code>: {html(doc)}.</p>
</html>"));
end Base;
''')
    variants = [("Sampled", {"Ts": "0.1"}, "sampled (Ts = 0.1)", "pairs with Base for `Ts > 0`.")]
    if hyst:
        variants = [("InitTrue", {"initState": "true"}, "initial state on",
                     "pairs with Base for initState (the first half-wave starts between the thresholds).")] + variants + [
            ("SampledInitTrue", {"Ts": "0.1", "initState": "true"}, "sampled, initial state on",
             "pairs with Sampled for initState.")]
    order = ["Base"]
    for vname, mods, desc, role in variants:
        variant_file(pkg, within, vname, mods, f"Logic.{name}: {desc}", role, "StopTime=12, Interval=0.005, Tolerance=1e-6")
        order.append(vname)
    write_package(pkg, "Tests.Controllers.MCDC.Logic", name,
                  f"MC/DC tests of {ICS}.Logic.{name}. Base model and one variant per option change.", order)
    return order



# -------------------------------------------------------------------------------- main --
if ROOT.exists():
    shutil.rmtree(ROOT)
counts = {}
for n, s in FAM_A.items():
    counts[n] = len(family_a(n, s))
for n, pwm in FAM_D.items():
    counts["Digital." + n] = len(family_d(n, pwm))
for n in FAM_T:
    counts["AutoTuning." + n] = len(family_t(n))
for n, s in FAM_B.items():
    counts["Blocks." + n] = len(family_b(n, s))
for n in ["Relay", "RelayHysteresis"]:
    counts["Logic." + n] = len(family_l(n))

write_package(ROOT / "Digital", "Tests.Controllers.MCDC", "Digital",
              f"MC/DC tests of {ICS}.Digital.", list(FAM_D))
write_package(ROOT / "AutoTuning", "Tests.Controllers.MCDC", "AutoTuning",
              f"MC/DC tests of {ICS}.AutoTuning.", FAM_T)
write_package(ROOT / "Blocks", "Tests.Controllers.MCDC", "Blocks",
              f"MC/DC tests of {ICS}.Blocks.", list(FAM_B))
write_package(ROOT / "Logic", "Tests.Controllers.MCDC", "Logic",
              f"MC/DC tests of {ICS}.Logic.", ["Relay", "RelayHysteresis"])
total = sum(counts.values())
rows = "".join(f"<tr><td>{k}</td><td>{v}</td></tr>" for k, v in counts.items())
write_package(ROOT, "Tests.Controllers", "MCDC", f"""MC/DC (modified condition/decision coverage) tests of the controllers.
<p>For every class of {ICS} a package holds a <code>Base</code> model (the class with every option
off, its stimuli, an independent reference and flag-dependent checks) and one variant per option change,
<code>extends Base(option=...)</code>. Each variant either changes a single condition of a decision
against the base, or forms the pair that a compound decision needs to show the independent effect of
one of its conditions (for example <code>CS &gt;= CSmax and AntiWindup</code>: Saturation vs.
SaturationAntiWindup). Run-time conditions (tracking on/off, limits reached or not, manual, forbid) take
both values within each run. Each variant's documentation names its MC/DC pair.</p>
<p>Every model is self-checking: <code>passed</code> is true when every check that applies to its
configuration passed; a failed check issues an assertion warning at the end of the run. Change
detection beyond these verdicts is left to regression testing against stored results.</p>
<p>There is no Modelica coverage instrumentation in the tool chain, so coverage is by construction:
the decisions are listed per class in the base documentation and the pairs in the variants'.</p>
<p>Generated by <code>Tests/Scripts/generate_mcdc.py</code>; edit the generator, not the models.</p>
<table border=\"1\"><tr><th>Class</th><th>Tests</th></tr>{rows}<tr><td><b>Total</b></td><td><b>{total}</b></td></tr></table>""",
              list(FAM_A) + ["Digital", "AutoTuning", "Blocks", "Logic"])
print("total tests:", total)
for name, f in PROBLEMS:
    print("LAYOUT", name, {k: v for k, v in f.items() if v})
