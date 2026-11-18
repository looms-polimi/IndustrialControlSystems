#!/usr/bin/env python3
"""Generate the MC/DC tests of the non-controller classes:
Tests.Logical.MCDC, Tests.MathOperations.MCDC, Tests.LinearSystems.MCDC.

Same structure as generate_mcdc.py (controllers): per class a Base model (the class under test
`dut` with every option off, its stimuli, an independent expectation and checks) and one
variant per option change; classes without options (timers, counter) get one scenario model.
Classes whose two branches are already covered by self-checking tests are left out
(Logical.Comparisons.*, Nand/Nor/Xnor, the IntegerType operators).

usage: python3 generate_mcdc_library.py [--layout-lib DIR]
"""
import argparse
import pathlib
import shutil
import sys

HERE = pathlib.Path(__file__).resolve().parent
TESTS = HERE.parent
ap = argparse.ArgumentParser()
ap.add_argument("--layout-lib", default="/home/jovyan/github/skills/plugins/sim/skills/modelica-diagram-layout/scripts")
args = ap.parse_args()
sys.path.insert(0, args.layout_lib)
sys.path.insert(0, str(HERE))
from diagram_layout import Layout  # noqa: E402
from mcdc_common import (Check, ann_line, check_decls, check_grid, html, passed_decl, place,  # noqa: E402
                         report, variant_file, write, write_package, PROBLEMS)

ICS = "IndustrialControlSystems"
REAL, BOOL, INT = "{0,0,127}", "{255,0,255}", "{255,127,0}"
SRC = {"y": (110, 0)}
SISO = {"u": (-120, 0), "y": (110, 0)}


def base_file(path, within, name, desc, params, decls, checks, L, eqs, experiment, doc, extra_eq=""):
    x0, y0, x1, y1 = L.canvas()
    write(path, f'''
within {within};
model {name} "{desc}"
  extends Modelica.Icons.Example;
{params}
{decls}
{check_decls(L, checks)}
{passed_decl(checks)}
equation
{eqs}
{extra_eq}  annotation (
    experiment({experiment}),
    Diagram(coordinateSystem(extent={{{{{x0},{y0}}},{{{x1},{y1}}}}}, grid={{1,1}})),
    Documentation(info="<html>
{doc}
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul>{"".join(f"<li><code>{c.name}</code>: {html(c.doc)}</li>" for c in checks)}</ul>
</html>"));
end {name};
''')


def settled(margin, edges=("0.03",)):
    """Active away from the input edges (all at these fractional seconds) by `margin`."""
    frac = "(time - floor(time))"
    return " and ".join(f"abs({frac} - {e}) > {margin} and abs({frac} - {e} - 1) > {margin}" for e in edges)


# ============================================================== Logical.LogicalOperations --
GATES = {
    "And": ("Modelica.Math.BooleanVectors.allTrue(src.y)", "AND of all inputs"),
    "Or": ("Modelica.Math.BooleanVectors.anyTrue(src.y)", "OR of all inputs"),
    "Xor": ("mod(Modelica.Math.BooleanVectors.countTrue(src.y), 2) == 1", "odd number of true inputs"),
}
EXP_G = "StopTime=8.5, Interval=0.005, Tolerance=1e-6"


def gate(name, expr, what):
    within = f"Tests.Logical.MCDC.{name}"
    pkg = TESTS / "Logical" / "MCDC" / name
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", {"u": (-80, 0), "y": (90, 0)}, 0, 0)
    L.comp("src", SRC, -40, 0)
    L.route("src.y", "dut.u")
    notgate = name == "Not"
    if notgate:
        mism = "sum(if (dut.y[i] and src[i].y) or (not dut.y[i] and not src[i].y) then 1 else 0 for i in 1:n)"
        checks = [Check("chkY", "CheckRealWhile",
                        [f"actual={mism}", "expected=0", f"active=Ts <= 0 or ({settled('0.15')})",
                         "absTol=0.5", "tStart=0.01", "dt=0.05"],
                        "every output is the negation of its input (sampled: away from the input edges)")]
        dutmods = "nInput=n, nOutput=n, Ts=Ts"
    else:
        checks = [Check("chkY", "CheckRealWhile",
                        ["actual=if dut.y[1] then 1 else 0", f"expected=if {expr} then 1 else 0",
                         f"active=Ts <= 0 or ({settled('0.15')})", "absTol=0.5", "tStart=0.01", "dt=0.05"],
                        f"y = {what}, for every input combination (sampled: away from the input edges)")]
        dutmods = "nInput=n, Ts=Ts"
    check_grid(L, checks, 40, 0)
    report("Logical." + name, L.report(quiet=True), L)
    base_file(pkg / "Base.mo", within, "Base", f"MC/DC base: {ICS}.Logical.LogicalOperations.{name}, continuous, 3 inputs",
              '  parameter Integer n = 3 "Number of inputs" annotation(Evaluate=true);\n'
              '  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);',
              f'''  Modelica.Blocks.Sources.BooleanPulse src[n](period={{2^i for i in 1:n}}, each width=50, each startTime=0.03)
    "Inputs: every combination once in 2^n s"
    {place(L, "src")};
  {ICS}.Logical.LogicalOperations.{name} dut({dutmods}) "Gate under test"
    {place(L, "dut")};''', checks, L, ann_line(L, "src.y", "dut.u", BOOL), EXP_G,
              f"<p>Base of the MC/DC tests of <a href=\\\"modelica://{ICS}.Logical.LogicalOperations.{name}\\\">"
              f"{name}</a>: Boolean pulses of periods 2, 4, 8 s run through every input combination; the "
              f"expected output is stated with <code>Modelica.Math.BooleanVectors</code>.</p>")
    variants = [("Sampled", {"Ts": "0.1"}, "sampled (Ts = 0.1)", "pairs with Base for `Ts > 0`.")]
    if not notgate:
        variants.append(("TwoInputs", {"n": "2"}, "two inputs",
                         "pairs with Base for the loop over inputs 3..n (not entered with two inputs)."))
    order = ["Base"]
    for v, mods, desc, role in variants:
        variant_file(pkg, within, v, mods, f"{name}: {desc}", role, EXP_G)
        order.append(v)
    write_package(pkg, "Tests.Logical.MCDC", name, f"MC/DC tests of {ICS}.Logical.LogicalOperations.{name}", order)


def flipflop():
    within = "Tests.Logical.MCDC.FlipFlopSR"
    pkg = TESTS / "Logical" / "MCDC" / "FlipFlopSR"
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", {"u1": (-80, 50), "u2": (-80, -50), "y1": (90, 50), "y2": (90, -40)}, 0, 0)
    L.comp("s", SRC, -60, 20)
    L.comp("r", SRC, -60, -20)
    L.route("s.y", "dut.u1", ("x", -30), ("y", 5))
    L.route("r.y", "dut.u2", ("x", -24), ("y", -5))
    act = f"{settled('0.15')} and abs(time - 6.53) > 0.15"
    checks = [
        Check("chkQ", "CheckRealWhile", ["actual=if dut.y1 then 1 else 0", "expected=if q then 1 else 0",
                                         f"active={act}", "absTol=0.5", "tStart=0.01", "dt=0.05"],
              "y1 follows the set-reset logic (reset dominant), from q_start until the first edge"),
        Check("complement", "Never", ["u=(dut.y1 and dut.y2) or (not dut.y1 and not dut.y2)"], "y2 = not y1 always")]
    check_grid(L, checks, 40, 20)
    report("Logical.FlipFlopSR", L.report(quiet=True), L)
    base_file(pkg / "Base.mo", within, "Base", f"MC/DC base: {ICS}.Logical.LogicalOperations.FlipFlopSR, q_start = false",
              '  parameter Boolean q_start = false "Initial output" annotation(Evaluate=true);\n'
              '  discrete Boolean q(start=q_start, fixed=true) "Expected state";',
              f'''  Modelica.Blocks.Sources.BooleanTable s(table={{1.03, 2.03, 5.03, 7.03}}, startValue=false) "Set"
    {place(L, "s")};
  Modelica.Blocks.Sources.BooleanTable r(table={{3.03, 4.03, 6.03, 6.53}}, startValue=false) "Reset (inside the second set pulse)"
    {place(L, "r")};
  {ICS}.Logical.LogicalOperations.FlipFlopSR dut(Ts=0.1, q_start=q_start) "Flip-flop under test"
    {place(L, "dut")};''', checks, L,
              ann_line(L, "s.y", "dut.u1", BOOL) + "\n" + ann_line(L, "r.y", "dut.u2", BOOL), EXP_G,
              "<p>Base of the MC/DC tests of <a href=\\\"modelica://IndustrialControlSystems.Logical.LogicalOperations.FlipFlopSR\\\">"
              "FlipFlopSR</a> (Ts = 0.1): set alone, hold, reset alone, set and reset together (reset wins), set again "
              "after the reset. The expected state <code>q</code> is stated independently.</p>",
              extra_eq="  when r.y then\n    q = false;\n  elsewhen s.y and not r.y then\n    q = true;\n  end when;\n")
    variant_file(pkg, within, "InitTrue", {"q_start": "true"}, "FlipFlopSR: initial output true",
                 "pairs with Base for q_start (output true until the first edge).", EXP_G)
    write_package(pkg, "Tests.Logical.MCDC", "FlipFlopSR", f"MC/DC tests of {ICS}.Logical.LogicalOperations.FlipFlopSR",
                  ["Base", "InitTrue"])


# ---------------------------------------------------------------------------- timers --
TIMERS = {
    "Timer_On": ("s.y and not r.y and time - tRise <= PV",
                 "ON timer: Q is true while S is true, for at most PV after the last rising edge of S; R forces false"),
    "Timer_On_Redge": ("latchRise and not r.y and time - tRise <= PV",
                       "ON timer on the rising edge: Q is true for PV after a rising edge of S, also if S falls; R ends it"),
    "Timer_OffDelay": ("s.y and not r.y and time - tRise >= PV",
                       "delay timer (documented: Q rises PV after S becomes true): Q true while S is true and PV has "
                       "passed since its last rising edge; R forces false"),
    "Timer_OffDelay_Redge": ("latchRise and not r.y and time - tRise >= PV",
                             "delay timer on the rising edge: Q rises PV after a rising edge of S and stays true until R"),
    "Timer_OffDelay_Fedge": ("latchFall and not r.y and time - tFall >= PV",
                             "delay timer on the falling edge: Q rises PV after a falling edge of S and stays true until R"),
}
EXP_T = "StopTime=20, Interval=0.005, Tolerance=1e-6"


def timer(name, expr, what):
    within = "Tests.Logical.MCDC"
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", {"S": (-80, 40), "R": (-80, -40), "PV": (-40, -80), "Q": (90, 0)}, 0, 0)
    L.comp("s", SRC, -60, 20)
    L.comp("r", SRC, -60, -10)
    L.comp("pv", SRC, -60, -40)
    L.route("s.y", "dut.S", ("x", -30), ("y", 4))
    L.route("r.y", "dut.R", ("x", -20), ("y", -4))
    L.route("pv.y", "dut.PV", ("x", -4))
    checks = [Check("chkQ", "CheckRealWhile",
                    ["actual=if dut.Q then 1 else 0", f"expected=if {expr} then 1 else 0",
                     f"active={settled('0.05', ('0.03', '0.53'))}", "absTol=0.5", "tStart=0.01", "dt=0.02"],
                    what)]
    check_grid(L, checks, 40, 0)
    report("Logical." + name, L.report(quiet=True), L)
    base_file(TESTS / "Logical" / "MCDC" / f"{name}.mo", within, name,
              f"MC/DC scenario: {ICS}.Logical.Timers.{name}",
              '  parameter Real PV = 2 "Programmed time";\n'
              '  discrete Real tRise(start=-100, fixed=true) "Time of the last rising edge of S";\n'
              '  discrete Real tFall(start=-100, fixed=true) "Time of the last falling edge of S";\n'
              '  discrete Boolean latchRise(start=false, fixed=true) "Set by a rising edge of S, cleared by R";\n'
              '  discrete Boolean latchFall(start=false, fixed=true) "Set by a falling edge of S, cleared by R";',
              f'''  Modelica.Blocks.Sources.BooleanTable s(table={{1.03, 6.03, 8.03, 9.03, 11.03, 16.03}}, startValue=false)
    "Set: long, short (< PV), long with a reset inside"
    {place(L, "s")};
  Modelica.Blocks.Sources.BooleanTable r(table={{13.03, 13.53}}, startValue=false) "Reset"
    {place(L, "r")};
  Modelica.Blocks.Sources.Constant pv(k=PV) "Programmed time"
    {place(L, "pv")};
  {ICS}.Logical.Timers.{name} dut "Timer under test (Ts = 0.01)"
    {place(L, "dut")};''', checks, L,
              "\n".join([ann_line(L, "s.y", "dut.S", BOOL), ann_line(L, "r.y", "dut.R", BOOL),
                         ann_line(L, "pv.y", "dut.PV", REAL)]), EXP_T,
              f"<p>MC/DC scenario of <a href=\\\"modelica://{ICS}.Logical.Timers.{name}\\\">{name}</a> (no options; "
              f"its decisions are run-time): S on [1.03, 6.03] (longer than PV = 2 s), [8.03, 9.03] (shorter) and "
              f"[11.03, 16.03] with R on [13.03, 13.53]. Expected: {html(what)}. The edge times and latches are "
              f"stated independently in the test. Inputs switch between the samples of the timer (Ts = 0.01).</p>",
              extra_eq=("  when s.y then\n    tRise = time;\n  end when;\n"
                        "  when not s.y then\n    tFall = time;\n  end when;\n"
                        "  when {s.y, r.y} then\n    latchRise = s.y and not r.y;\n  end when;\n"
                        "  when {not s.y, r.y} then\n    latchFall = not s.y and not r.y;\n  end when;\n"))
    return name


def counter():
    within = "Tests.Logical.MCDC"
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", {"CU": (-80, 80), "CD": (-80, 40), "S": (-80, 0), "R": (-80, -40), "PV": (-40, -80),
                   "CV": (90, 30), "Q": (90, -30)}, 0, 0)
    for n, y in [("cu", 80), ("cd", 50), ("s", 20), ("r", -20), ("pv", -50)]:
        L.comp(n, SRC, -60, y)
    L.route("cu.y", "dut.CU", ("x", -14), ("y", 8))
    L.route("cd.y", "dut.CD", ("x", -20), ("y", 4))
    L.route("s.y", "dut.S", ("x", -26), ("y", 0))
    L.route("r.y", "dut.R", ("x", -17), ("y", -4))
    L.route("pv.y", "dut.PV", ("x", -4))
    cv = ("if time < 0.53 then 0 elseif time < 1.03 then 5 elseif time < 2.03 then 6 elseif time < 3.03 then 7 "
          "elseif time < 4.03 then 8 elseif time < 5.03 then 9 elseif time < 7.03 then 0 elseif time < 8.03 then 9 "
          "elseif time < 10.03 then 8 elseif time < 11.03 then 0 else 1")
    act = settled("0.05", ("0.03", "0.53"))
    checks = [
        Check("chkCV", "CheckRealWhile", ["actual=dut.CV", f"expected={cv}", f"active={act}", "absTol=0.5",
                                          "tStart=0.01", "dt=0.02"],
              "CV: preset 5 on the rising edge of S, +1 per rising CU, wrap 9 -> 0, -1 per rising CD, wrap 0 -> 9, "
              "0 on R, no change for CU and CD together or without S"),
        Check("chkQ", "CheckRealWhile", ["actual=if dut.Q then 1 else 0", f"expected=if ({cv}) <> 0 and not r.y then 1 else 0",
                                         f"active={act} and time > 0.6", "absTol=0.5", "tStart=0.01", "dt=0.02"],
              "Q is true while the counter value is not 0 and R is false")]
    check_grid(L, checks, 40, 30)
    report("Logical.Counter", L.report(quiet=True), L)
    base_file(TESTS / "Logical" / "MCDC" / "Counter.mo", within, "Counter", f"MC/DC scenario: {ICS}.Logical.Counter.Counter",
              "", f'''  Modelica.Blocks.Sources.BooleanTable cu(table={{1.03, 1.53, 2.03, 2.53, 3.03, 3.53, 4.03, 4.53, 5.03, 5.53,
    11.03, 11.53, 12.03, 12.53, 14.03, 14.53}}, startValue=false) "Count up"
    {place(L, "cu")};
  Modelica.Blocks.Sources.BooleanTable cd(table={{7.03, 7.53, 8.03, 8.53, 12.03, 12.53}}, startValue=false) "Count down"
    {place(L, "cd")};
  Modelica.Blocks.Sources.BooleanTable s(table={{0.53, 13.03}}, startValue=false) "Set (enables counting)"
    {place(L, "s")};
  Modelica.Blocks.Sources.BooleanTable r(table={{10.03, 10.53}}, startValue=false) "Reset"
    {place(L, "r")};
  Modelica.Blocks.Sources.IntegerConstant pv(k=5) "Preset value"
    {place(L, "pv")};
  {ICS}.Logical.Counter.Counter dut(Max=9) "Counter under test (Ts = 0.01, modulus 9)"
    {place(L, "dut")};''', checks, L,
              "\n".join([ann_line(L, "cu.y", "dut.CU", BOOL), ann_line(L, "cd.y", "dut.CD", BOOL),
                         ann_line(L, "s.y", "dut.S", BOOL), ann_line(L, "r.y", "dut.R", BOOL),
                         ann_line(L, "pv.y", "dut.PV", INT)]), "StopTime=16, Interval=0.005, Tolerance=1e-6",
              f"<p>MC/DC scenario of <a href=\\\"modelica://{ICS}.Logical.Counter.Counter\\\">Counter</a> (Max = 9, PV = 5): "
              "preset, five counts up with the wrap 9 -> 0, two counts down with the wrap 0 -> 9, reset, a count up "
              "after the reset, CU and CD together (no change), and CU while S is false (no change). Each condition "
              "of the count function's decisions takes both values.</p>")
    return "Counter"


# ======================================================================= MathOperations --
FP = "Nbit=16, scaleFactor=100"
LO, HI = "-32767/100", "32768/100"
OPS = {  # name: (u1 phases, u2 phases, ideal, fixed-point limits lo, hi, extra doc)
    "Add": ([0.5, 200, -200, 3.3], [1.25, 200, -150, -1.7], "u1.y + u2.y", LO, HI, ""),
    "Sub": ([0.5, 200, -200, 3.3], [1.25, -200, 150, 1.7], "u1.y - u2.y", LO, HI, ""),
    "Mult": ([0.5, 2, -2, 1.2], [1.5, 2, 2, -0.7], "u1.y*u2.y", "-32767/100^2", "32768/100^2",
             " The fixed-point product is scaled by scaleFactor^2, so it saturates at 3.2768."),
    "Div": ([1, 1, 200, -200, 2.5], [0.3, 1.5, 0.5, 0.5, -4], "u1.y/u2.y", LO, HI,
            " u2 takes values below and above 1 in magnitude."),
    "Pow": ([1.5, 3, -1.2, 0.3, 1.1], [2, 2, 3, 3, 1], "u1.y^u2.y", "-32767/100^u2.y", "32768/100^u2.y",
            " The exponent is an integer; the fixed-point power is scaled by scaleFactor^u2."),
}
EXP_M = "StopTime={}, Interval=0.005, Tolerance=1e-6"


def table(vals):
    rows = []
    for k, v in enumerate(vals):
        t0 = 0.03 + k if k else 0
        rows.append(f"{t0},{v}")
        rows.append(f"{0.03 + k + 1},{v}")
    return "[" + "; ".join(rows) + "]"


def int_table(vals):
    """IntegerTable rows (strictly increasing times): value k from 0.03 + k on."""
    return "[" + "; ".join(f"{0.03 + k if k else 0},{v}" for k, v in enumerate(vals)) + "]"


def simple_op(name, spec):
    u1v, u2v, ideal, lo, hi, extra = spec
    within = f"Tests.MathOperations.MCDC.RealType.{name}"
    pkg = TESTS / "MathOperations" / "MCDC" / "RealType" / name
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", {"u1": (-80, 40), "u2": (-80, -40), "y": (90, 0)}, 0, 0)
    L.comp("u1", SRC, -60, 20)
    L.comp("u2", SRC, -60, -20)
    L.route("u1.y", "dut.u1", ("x", -30), ("y", 4))
    L.route("u2.y", "dut.u2", ("x", -24), ("y", -4))
    stop = len(u1v) + 0.5
    act = f"Ts <= 0 or ({settled('0.15')})"
    checks = [
        Check("chkY", "CheckRealWhile",
              ["actual=dut.y", f"expected=if FixedPoint then max({lo}, min({hi}, {ideal})) else {ideal}",
               f"active={act}", "absTol=if FixedPoint then 0.02 else 1e-9", "relTol=if FixedPoint then 0.02 else 1e-9",
               "tStart=0.01", "dt=0.05"],
              f"y = {ideal.replace('.y', '')}; fixed point: limited to the representable range, within the quantisation (0.02 + 2 %)"),
        Check("saturates", "Witness", ["enable=FixedPoint", f"u=abs(dut.y - ({hi})) < 1e-9 or abs(dut.y - ({lo})) < 1e-9"],
              "fixed point: the result reaches a limit of the representable range in the saturating phases")]
    check_grid(L, checks, 40, 10)
    report("RealType." + name, L.report(quiet=True), L)
    base_file(pkg / "Base.mo", within, "Base", f"MC/DC base: {ICS}.MathOperations.RealType.{name}, continuous, floating point",
              '  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);\n'
              '  parameter Boolean FixedPoint = false "Fixed-point arithmetic (16 bit, scale 100)" annotation(Evaluate=true);',
              f'''  Modelica.Blocks.Sources.TimeTable u1(table={table(u1v)}) "First operand"
    {place(L, "u1")};
  Modelica.Blocks.Sources.TimeTable u2(table={table(u2v)}) "Second operand"
    {place(L, "u2")};
  {ICS}.MathOperations.RealType.{name} dut(Ts=Ts, FixedPoint=FixedPoint, {FP}) "Operator under test"
    {place(L, "dut")};''', checks, L,
              ann_line(L, "u1.y", "dut.u1", REAL) + "\n" + ann_line(L, "u2.y", "dut.u2", REAL), EXP_M.format(stop),
              f"<p>Base of the MC/DC tests of <a href=\\\"modelica://{ICS}.MathOperations.RealType.{name}\\\">{name}</a>: "
              f"one operand pair per second (u1 = {u1v}, u2 = {u2v}), including pairs whose fixed-point result "
              f"leaves the 16-bit range (scale 100: [-327.67, 327.68]).{html(extra)} Note the library default "
              f"Ts = 0.1; the base sets Ts = 0.</p>")
    variants = [("Sampled", {"Ts": "0.1"}, "sampled (Ts = 0.1)", "pairs with Base for `Ts > 0` in the floating-point branch."),
                ("FixedPoint", {"FixedPoint": "true"}, "fixed point", "pairs with Base for FixedPoint."),
                ("SampledFixedPoint", {"FixedPoint": "true", "Ts": "0.1"}, "fixed point, sampled",
                 "pairs with FixedPoint for `Ts > 0` in the fixed-point branch.")]
    order = ["Base"]
    for v, mods, desc, role in variants:
        variant_file(pkg, within, v, mods, f"RealType.{name}: {desc}", role, EXP_M.format(stop))
        order.append(v)
    write_package(pkg, "Tests.MathOperations.MCDC.RealType", name,
                  f"MC/DC tests of {ICS}.MathOperations.RealType.{name}", order)


def expression_real():
    within = "Tests.MathOperations.MCDC.RealType.Expression"
    pkg = TESTS / "MathOperations" / "MCDC" / "RealType" / "Expression"
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", {"u": (-80, 0), "y": (90, 0)}, 0, 0)
    L.comp("u", SRC, -40, 0)
    L.route("u.y", "dut.u")
    vals = [[1, 150, -150, 0.25], [2, 150, -150, -0.5], [3, 150, -150, 1.75]]
    tabs = ", ".join(table(v) for v in vals)
    ideal = "(if useInputs then sum(dut.u_set) else 0)"
    checks = [
        Check("chkY", "CheckRealWhile",
              ["actual=dut.y", f"expected=if FixedPoint then max({LO}, min({HI}, {ideal})) else {ideal}",
               f"active=Ts <= 0 or ({settled('0.15')})", "absTol=if FixedPoint then 0.02 else 1e-9",
               "relTol=if FixedPoint then 0.02 else 1e-9", "tStart=0.01", "dt=0.05"],
              "y = sum of the inputs (0 without inputs); fixed point: limited to the representable range"),
        Check("saturates", "Witness", ["enable=FixedPoint", f"u=abs(dut.y - ({HI})) < 1e-9 or abs(dut.y - ({LO})) < 1e-9"],
              "fixed point: the sum reaches a limit of the representable range")]
    check_grid(L, checks, 40, 10)
    report("RealType.Expression", L.report(quiet=True), L)
    write(pkg / "Sum.mo", '''
within Tests.MathOperations.MCDC.RealType.Expression;
function Sum "Sum of the inputs (for the Expression tests)"
  extends IndustrialControlSystems.MathOperations.RealType.Functions.GeneralFunction;
algorithm
  y := sum(u);
end Sum;
''')
    base_file(pkg / "Base.mo", within, "Base", f"MC/DC base: {ICS}.MathOperations.RealType.Expression, continuous, floating point",
              '  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);\n'
              '  parameter Boolean FixedPoint = false "Fixed-point arithmetic (16 bit, scale 100)" annotation(Evaluate=true);\n'
              '  parameter Boolean useInputs = true "Inputs enabled" annotation(Evaluate=true);',
              f'''  Modelica.Blocks.Sources.TimeTable u[3](table={{{tabs}}}) if useInputs "Inputs"
    {place(L, "u")};
  {ICS}.MathOperations.RealType.Expression dut(nInput=3, Ts=Ts, FixedPoint=FixedPoint, useInputs=useInputs, {FP},
    redeclare function f = Tests.MathOperations.MCDC.RealType.Expression.Sum,
    redeclare function g = Tests.MathOperations.reScale, fname="sum") "Expression under test"
    {place(L, "dut")};''', checks, L, ann_line(L, "u.y", "dut.u", REAL), EXP_M.format(4.5),
              f"<p>Base of the MC/DC tests of <a href=\\\"modelica://{ICS}.MathOperations.RealType.Expression\\\">Expression</a> "
              "with f = sum of three inputs and g = division by the scale factor; one input triple per second, the "
              "second and third leaving the fixed-point range. Without inputs (<code>useInputs = false</code>) the block "
              "uses zeros.</p>")
    variants = [("Sampled", {"Ts": "0.1"}, "sampled (Ts = 0.1)", "pairs with Base for `Ts > 0` (floating point)."),
                ("FixedPoint", {"FixedPoint": "true"}, "fixed point", "pairs with Base for FixedPoint."),
                ("SampledFixedPoint", {"FixedPoint": "true", "Ts": "0.1"}, "fixed point, sampled",
                 "pairs with FixedPoint for `Ts > 0` (fixed point)."),
                ("NoInputs", {"useInputs": "false"}, "inputs disabled", "pairs with Base for useInputs.")]
    order = ["Base", "Sum"]
    for v, mods, desc, role in variants:
        variant_file(pkg, within, v, mods, f"RealType.Expression: {desc}", role, EXP_M.format(4.5))
        order.append(v)
    write_package(pkg, "Tests.MathOperations.MCDC.RealType", "Expression",
                  f"MC/DC tests of {ICS}.MathOperations.RealType.Expression", order)


def expression_int():
    within = "Tests.MathOperations.MCDC.IntegerType.Expression"
    pkg = TESTS / "MathOperations" / "MCDC" / "IntegerType" / "Expression"
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", {"u": (-80, 0), "y": (90, 0)}, 0, 0)
    L.comp("u", SRC, -40, 0)
    L.route("u.y", "dut.u")
    vals = [[1, -3, 4], [2, 5, -6], [3, 0, 7]]
    tabs = ", ".join(int_table(v) for v in vals)
    checks = [Check("chkY", "CheckRealWhile",
                    ["actual=dut.y", "expected=sum(u[i].y^2 for i in 1:3)", f"active=Ts <= 0 or ({settled('0.15')})",
                     "absTol=0.5", "tStart=0.01", "dt=0.05"], "y = sum of the squares of the inputs")]
    check_grid(L, checks, 40, 0)
    report("IntegerType.Expression", L.report(quiet=True), L)
    base_file(pkg / "Base.mo", within, "Base", f"MC/DC base: {ICS}.MathOperations.IntegerType.Expression, continuous",
              '  parameter Real Ts = 0 "Sampling time (0: continuous)" annotation(Evaluate=true);',
              f'''  Modelica.Blocks.Sources.IntegerTable u[3](table={{{tabs}}}) "Inputs"
    {place(L, "u")};
  {ICS}.MathOperations.IntegerType.Expression dut(nInput=3, Ts=Ts, redeclare function f = Tests.MathOperations.SumSquare,
    fname="sum of squares") "Expression under test"
    {place(L, "dut")};''', checks, L, ann_line(L, "u.y", "dut.u", INT), EXP_M.format(3.5),
              f"<p>Base of the MC/DC tests of <a href=\\\"modelica://{ICS}.MathOperations.IntegerType.Expression\\\">"
              "Expression</a> with f = sum of squares (<code>Tests.MathOperations.SumSquare</code>).</p>")
    variant_file(pkg, within, "Sampled", {"Ts": "0.1"}, "IntegerType.Expression: sampled (Ts = 0.1)",
                 "pairs with Base for `Ts > 0`.", EXP_M.format(3.5))
    write_package(pkg, "Tests.MathOperations.MCDC.IntegerType", "Expression",
                  f"MC/DC tests of {ICS}.MathOperations.IntegerType.Expression", ["Base", "Sampled"])


# ======================================================================== LinearSystems --
def transfer_function(discrete):
    name = "DiscreteTransferFunction" if discrete else "ContinuousTransferFunction"
    cls = f"{ICS}.LinearSystems.{'Discrete' if discrete else 'Continuous'}.TransferFunction"
    within = f"Tests.LinearSystems.MCDC.{name}"
    pkg = TESTS / "LinearSystems" / "MCDC" / name
    L = Layout(scale=0.1, grid=1, pitch=10)
    L.comp("dut", {"u": (-80, 0), "y": (90, 0)}, 0, 0)
    L.comp("u", SRC, -40, 0)
    L.comp("uRef", SRC, -40, -30)
    L.comp("ref", SISO, 0, -30)
    L.route("u.y", "dut.u")
    L.route("uRef.y", "ref.u")
    utab = "[0,1; 5.02,1; 5.02,2; 10,2]"
    act = "time > 0.05 and abs(time - 5.02) > 0.1" if discrete else "true"
    checks = [Check("chkY", "CheckRealWhile",
                    ["actual=dut.y", "expected=ref.y", f"active={act}",
                     f"absTol={'0.02' if discrete else '1e-4'}", f"relTol={'0.02' if discrete else '1e-4'}",
                     "tStart=0.01", "dt=0.05"],
                    "y = the Modelica.Blocks.Continuous.TransferFunction with the corresponding initialisation"
                    + (" (sampled: within 0.02 + 2 %, away from t = 0 and the input step)" if discrete else "")),
              Check("chkStart", "CheckRealWhile",
                    ["actual=dut.y", "expected=y0", "active=time < 0.0015", f"absTol={'0.02' if discrete else '1e-3'}",
                     "tStart=0", "dt=0.001"],
                    "start value: 0 without initialisation (state 0), y_start = 0.5 with initOutput, 1 (= steady state "
                    "for u = 1) with initSteadyState or initSteadyOutput; biproper without initialisation: 1.5")]
    check_grid(L, checks, 40, 0)
    report("LinearSystems." + name, L.report(quiet=True), L)
    disc_params = ('  parameter Real Ts = 0.01 "Sampling time";\n'
                   '  parameter IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod method=\n'
                   '    IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE "Discretisation method"\n'
                   '    annotation(Evaluate=true);\n') if discrete else ""
    disc_mods = "Ts=Ts, method=method, " if discrete else ""
    base_file(pkg / "Base.mo", within, "Base",
              f"MC/DC base: {cls}, strictly proper first order, no initialisation",
              disc_params +
              '  parameter Real num[:] = {1} "Numerator" annotation(Evaluate=true);\n'
              '  parameter Real den[:] = {2, 1} "Denominator" annotation(Evaluate=true);\n'
              '  parameter Boolean initOutput = false annotation(Evaluate=true);\n'
              '  parameter Boolean initSteadyState = false annotation(Evaluate=true);\n'
              '  parameter Boolean initSteadyOutput = false annotation(Evaluate=true);\n'
              '  parameter Real y_start = 0.5 "Initial output with initOutput";\n'
              '  final parameter Real y0 = if initOutput then y_start elseif initSteadyState or initSteadyOutput then '
              'num[end]/den[end] else (if size(num, 1) == size(den, 1) then num[1]/den[1] else 0)\n'
              '    "Expected output at t = 0 (u = 1)";',
              f'''  Modelica.Blocks.Sources.TimeTable u(table={utab}) "Input: 1, step to 2 at 5.02 s"
    {place(L, "u")};
  {cls} dut({disc_mods}num=num, den=den, initOutput=initOutput,
    initSteadyState=initSteadyState, initSteadyOutput=initSteadyOutput, y_start=y_start) "Transfer function under test"
    {place(L, "dut")};
  Modelica.Blocks.Sources.TimeTable uRef(table={utab}) "Input of the reference"
    {place(L, "uRef")};
  Modelica.Blocks.Continuous.TransferFunction ref(b=num, a=den,
    initType=if initOutput then Modelica.Blocks.Types.Init.InitialOutput elseif initSteadyState or initSteadyOutput then
      Modelica.Blocks.Types.Init.SteadyState else Modelica.Blocks.Types.Init.InitialState, y_start=y_start)
    "Continuous reference with the same initialisation"
    {place(L, "ref")};''', checks, L,
              ann_line(L, "u.y", "dut.u", REAL) + "\n" + ann_line(L, "uRef.y", "ref.u", REAL),
              "StopTime=10, Interval=0.005, Tolerance=1e-8",
              f"<p>Base of the MC/DC tests of <a href=\\\"modelica://{cls}\\\">{cls.split('.', 1)[1]}</a> on the first-order "
              "system 1/(2s + 1) (one state, so each initialisation flag fixes the start completely), input 1 stepping "
              "to 2 at t = 5.02 s, against <code>Modelica.Blocks.Continuous.TransferFunction</code>"
              f"{' (the sampled block with Ts = 0.01 within the discretisation error)' if discrete else ''}.</p>")
    variants = [("InitOutput", {"initOutput": "true"}, "output initialised to y_start = 0.5", "pairs with Base for initOutput."),
                ("InitSteadyState", {"initSteadyState": "true"}, "initialised at steady state", "pairs with Base for initSteadyState."),
                ("InitSteadyOutput", {"initSteadyOutput": "true"}, "initialised at steady output", "pairs with Base for initSteadyOutput."),
                ("Biproper", {"num": "{3, 1}"}, "biproper (3s + 1)/(2s + 1)", "pairs with Base for `D == N`."),
                ("ScaledDenominator", {"num": "{2}", "den": "{4, 2}"}, "2/(4s + 2), the same system as Base",
                 "not an MC/DC pair: checks that the coefficient of the state in the denominator is used (Base has 1 there).")]
    if discrete:
        variants += [("ForwardEuler", {"method": "IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE"},
                      "Forward Euler", "covers method = FE."),
                     ("Tustin", {"method": "IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU"},
                      "Tustin", "covers method = TU.")]
    order = ["Base"]
    for v, mods, desc, role in variants:
        variant_file(pkg, within, v, mods, f"{name}: {desc}", role, "StopTime=10, Interval=0.005, Tolerance=1e-8")
        order.append(v)
    write_package(pkg, "Tests.LinearSystems.MCDC", name, f"MC/DC tests of {cls}", order)


# --------------------------------------------------------------------------------- main --
INTRO = ("<p>Each class has a <code>Base</code> model (the class under test <code>dut</code> with every option off, "
         "its stimuli, an independently stated expectation and checks) and one variant per option change, "
         "<code>extends Base(option=...)</code>; classes without options get one scenario model whose run "
         "gives every condition of their run-time decisions both values. Every model is self-checking "
         "(<code>passed</code>). Generated by <code>Tests/Scripts/generate_mcdc_library.py</code>; edit the "
         "generator, not the models. See also <a href=\"modelica://Tests.Controllers.MCDC\">Tests.Controllers.MCDC</a>.</p>")
for d in ["Logical", "MathOperations", "LinearSystems"]:
    if (TESTS / d / "MCDC").exists():
        shutil.rmtree(TESTS / d / "MCDC")
for g, (e, w) in GATES.items():
    gate(g, e, w)
gate("Not", None, None)
flipflop()
timers = [timer(n, e, w) for n, (e, w) in TIMERS.items()]
counter()
write_package(TESTS / "Logical" / "MCDC", "Tests.Logical", "MCDC",
              "MC/DC tests of Logical.LogicalOperations, Logical.Timers and Logical.Counter. " + INTRO
              + "<p>Logical.Comparisons and Nand, Nor, Xnor are covered in both branches by the self-checking tests in "
              "Tests.Logical.Comparisons and Tests.Logical.LogicalOperations.NegatedGates.</p>",
              list(GATES) + ["Not", "FlipFlopSR"] + timers + ["Counter"])
for n, s in OPS.items():
    simple_op(n, s)
expression_real()
expression_int()
write_package(TESTS / "MathOperations" / "MCDC" / "RealType", "Tests.MathOperations.MCDC", "RealType",
              "MC/DC tests of MathOperations.RealType", list(OPS) + ["Expression"])
write_package(TESTS / "MathOperations" / "MCDC" / "IntegerType", "Tests.MathOperations.MCDC", "IntegerType",
              "MC/DC tests of MathOperations.IntegerType.Expression", ["Expression"])
write_package(TESTS / "MathOperations" / "MCDC", "Tests.MathOperations", "MCDC",
              "MC/DC tests of MathOperations. " + INTRO + "<p>The IntegerType operators are covered in both branches by "
              "Tests.MathOperations.IntegerOperations.</p>", ["RealType", "IntegerType"])
transfer_function(False)
transfer_function(True)
write_package(TESTS / "LinearSystems" / "MCDC", "Tests.LinearSystems", "MCDC",
              "MC/DC tests of LinearSystems.Continuous.TransferFunction and LinearSystems.Discrete.TransferFunction "
              "(initialisation options, biproper systems, discretisation method). " + INTRO,
              ["ContinuousTransferFunction", "DiscreteTransferFunction"])
for d in ["Logical", "MathOperations", "LinearSystems"]:
    po = TESTS / d / "package.order"
    names = po.read_text().split()
    if "MCDC" not in names:
        po.write_text("\n".join(names + ["MCDC"]) + "\n")
n = sum(1 for p in TESTS.glob("*/MCDC/**/*.mo") if p.name != "package.mo" and p.stem != "Sum"
        and "Controllers" not in p.parts)
print("tests:", n)
for name, f in PROBLEMS:
    print("LAYOUT", name, {k: v for k, v in f.items() if v})
