within IndustrialControlSystems.UserGuide;
model ReleaseNotes "Release Notes"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Modelica library for Industrial Control Systems</h4>
<p>IndustrialControlSystems is a Modelica library providing a set of control blocks,
with functionality usually found in industrial controllers. Each block has two 
implementations, one continuous-time and one discrete-time.</p>
<p>The first version of the library was presented at the 9th Modelica conference,
held in Munich 3-5 September 2012. The library won the 2nd prize at the Modelica library competition award.</p>
<p>Main authors: Marco Bonvini and Alberto Leva 2010-2012.</p>
<p>Maintenance contributors: Thomas Beutlich, Francesco Casella, Peter Harman, Matthis Thorade, Martin Sjoelund, Dietmar Winkler, Hubertus Tummescheit.</p>

<h4>Version 2.0.1 (unreleased)</h4>
<p>Version 2.0.1 collects the changes proposed to the upstream repository in
<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/2\">PR #2</a> to <a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/6\">PR #6</a>, and the test library with the fixes it found in <a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/8\">PR #8</a>. The issue links point to the issue tracker of the
<a href=\"https://github.com/hubertus65/IndustrialControlSystems\">fork</a> where each fix was reviewed.</p>

<h5>Compatibility and maintenance (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/2\">PR #2</a>)</h5>
<ul>
<li>Uses Modelica Standard Library 4.1.0. The <code>conversion</code> annotation declares that no conversion is needed from 2.0.0
(<code>noneFromVersion=\"2.0.0\"</code>); the conversion script from 1.1.0 and 1.2.0 moved to
<code>Resources/Scripts/Conversion</code>.</li>
<li>Compatible with Modelon Impact / OCT: conditional components are used in the way the Modelica language specification allows,
and an illegal <code>noEvent()</code> in a <code>when</code> clause was removed. A function output was given an explicit size.</li>
<li>Images and references moved from the Dymola-specific <code>help</code> folder to <code>Resources/Images</code> and
<code>Resources/References</code>, and are referenced with <code>modelica://</code> URIs.</li>
<li>Packages have MSL-style icons.</li>
<li>Typos in class names fixed:
<ul>
<li><code>MathOperations.RealType.Signals.SmoothThooth</code> &rarr; <code>SmoothTooth</code></li>
<li><code>MathOperations.RealType.Signals.SmoothThoothSignal</code> &rarr; <code>SmoothToothSignal</code></li>
<li><code>Applications.TrasferFunctions</code> &rarr; <code>Applications.TransferFunctions</code></li>
<li><code>Logical.LogicalOperations.Examples.FliFlop</code> &rarr; <code>FlipFlop</code></li>
</ul>
The two signal blocks keep their old names as obsolete classes that extend the new ones, so models built with 2.0.0 still work;
tools mark them as obsolete. They will be removed in a later version. The other two are examples.</li>
</ul>

<h5>Bug fixes that change simulation results (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/2\">PR #2</a>, <a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/5\">PR #5</a>, <a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/6\">PR #6</a>)</h5>
<p>Each fix changes results only for the configurations listed; regenerate the reference results of models that use them.</p>
<ul>
<li><code>Controllers.PD</code>: the controller now implements proportional + derivative action,
<code>CS = Kp*[(SP-PV) + sTd/(1+sTd/N)*(SP-PV)] + Bias</code>, as its name and description state.
Before, it implemented only the scaled filtered derivative <code>Kp*sTd/(1+sTd/N)*(SP-PV)</code>, with
no output for a constant error. <code>CS_start</code> is now the initial output (saturated if
<code>AntiWindup = true</code>); before, it initialised the derivative filter state.
<b>Results of all models using <code>PD</code> change.</b>
(<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/2\">PR #2</a>, <a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/4\">issue 4</a>)</li>
<li><code>Controllers.I</code>, continuous time: with <code>useBIAS = true</code> the integrator ramped at
<code>Bias/eps</code> whenever the output was not saturated, because of an error in the anti-windup term.
Models without bias are not affected. (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/2\">PR #2</a>, <a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/3\">issue 3</a>)</li>
<li><code>Controllers.P</code>, <code>PI</code>, <code>I</code>: with <code>useGS = true</code> the sampled
versions (<code>Ts &gt; 0</code>) ignored the gain-scheduling inputs and used the parameters; they now use
the scheduled values, read at each sampling instant. A continuous <code>PI</code> with a gain schedule now
starts at <code>CS_start</code>. Models without <code>useGS</code> are not affected.
(<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/2\">PR #2</a>, <a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/5\">issue 5</a>)</li>
<li>Tracking mode (<code>useTS = true</code>, <code>TS = true</code>): all controllers now output
<code>CS = TR</code> (saturated if <code>AntiWindup = true</code>) without adding the bias, as documented.
Before, the continuous <code>PI</code>, <code>I</code> (without anti-windup) and <code>PID</code> (both
versions) added the bias. In <code>I</code> the integrator state follows <code>TR - Bias</code>, so the
return to automatic mode is bumpless. Models without <code>useBIAS</code> are not affected.
(<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/2\">PR #2</a>, <a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/6\">issue 6</a>)</li>
<li>Bumpless transfer from tracking to automatic mode: in <code>PI</code>, <code>PID</code>,
<code>AutoTuning.ATPIrelayNCdigital</code> and <code>AutoTuning.ATPIrelayNCmixedMode</code> the integral
(reset) state now follows <code>TR - Bias - P</code> (and <code>- D</code> in <code>PID</code>) while tracking,
instead of <code>TR</code>, so the output continues from <code>TR</code> without a step when tracking ends.
Before, it jumped by the proportional (and derivative) action plus the bias. <code>I</code> follows
<code>TR - Bias</code> (see above). The digital <code>PID_2dof</code> controllers are incremental and were
already bumpless. <code>P</code>, <code>PD</code> and <code>D</code> have no integral state: on release
their output still steps from <code>TR</code> to the value of their control law.
Results change only for models that use tracking mode. (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/2\">PR #2</a>)</li>
<li>Initial output <code>CS_start</code>: <code>I</code>, <code>PI</code> and <code>D</code> now start at
<code>CS_start</code> (saturated if <code>AntiWindup = true</code>) in every configuration. Before, with
<code>AntiWindup = true</code>, <code>I</code> started at <code>CS_start + Bias</code> and <code>PI</code> at
<code>CS_start + Bias + Kp*(SP - PV)</code>; the sampled <code>I</code> ignored <code>CS_start</code>; and
<code>D</code> initialised its filtered error with <code>CS_start - Bias</code>. As in <code>PD</code>, the
sampled versions set the state one sample before t = 0. Results change only at the start of the simulation,
and only for these configurations.
(<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/5\">PR #5</a>, <a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/15\">issue 15</a>)</li>
<li><code>Controllers.PID</code> now starts at <code>CS_start</code> (saturated if <code>AntiWindup = true</code>),
like the other controllers. Before, it ignored <code>CS_start</code>: the integral and derivative filter states
started at zero, so the output started at <code>Kp*(b*SP - PV) + Bias</code> plus a derivative kick of
<code>Kp*N*(c*SP - PV)</code> whenever the initial error was nonzero. The derivative filter now starts in steady
state (no kick for a constant error) and the integral state at <code>CS_start - Bias - Kp*(b*SP - PV)</code>.
<b>The start-up of all models using <code>PID</code> with a nonzero initial error, bias or <code>CS_start</code>
changes</b>; the closed-loop steady state does not.
(<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/6\">PR #6</a>, <a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/17\">issue 17</a>)</li>
</ul>

<h5>Bug fixes found by the self-checking tests (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/8\">PR #8</a>)</h5>
<p>Each fix changes results only for the configurations listed; regenerate the reference results of models that use them.</p>
<ul>
<li><code>LinearSystems.Continuous.TwoPolesTwoZeroes</code>: the integrator state integrated
<code>T1*u</code> instead of <code>u</code>, so the block realised mu(1+sT1)(1+sT2)/(s(1+sT3)) only for
<code>T1 = 1</code>. <b>Results of all models using it with <code>T1 &lt;&gt; 1</code> change.</b></li>
<li>Sampled blocks with a continuous-time input: <code>LinearSystems.Discrete.Delay</code>,
<code>FirstOrder</code>, <code>Integrator</code>, <code>LeadLag</code>, <code>ComplexPoles</code>,
<code>TwoPolesTwoZeroes</code>, and the sampled versions (<code>Ts &gt; 0</code>) of
<code>Controllers.I</code>, <code>D</code>, <code>PD</code> and <code>PID</code> used <code>pre(u)</code>
(<code>pre(SP)</code>, <code>pre(PV)</code>) inside <code>when sample()</code> as the input of the previous
sampling instant. For a continuous-time input <code>pre(u)</code> is the current value, so
<code>Delay</code> did not delay and the difference equations used u[n] in place of u[n-1].
The blocks now store the input in a discrete variable at each sampling instant and use its previous value.
Only an input that changes at events other than the block's own sampling instants was handled correctly
before. Behind a <code>Modelica.Blocks.Discrete.ZeroOrderHold</code> with the same sampling instants the
blocks were affected too: that block outputs <code>pre(ySample)</code>, so at the common instant the
block reads the previous held value; <code>Delay</code> appeared to work there only because of this, and now
gives one more sample of delay in that arrangement. The first-sample history now starts from the initial input instead of 0
(<code>ComplexPoles</code>, <code>TwoPolesTwoZeroes</code>) and <code>Delay</code> outputs
<code>y_start</code> during the first sampling period. With Backward Euler (the default
<code>method</code>) the first-order blocks, <code>Integrator</code> and the controllers do not use u[n-1]
and are not affected; with Forward Euler or Tustin, and for <code>Delay</code>, <code>ComplexPoles</code>
and <code>TwoPolesTwoZeroes</code>, results change.</li>
<li><code>LinearSystems.Discrete.Functions.fDerivator</code> ignored its gain input <code>k</code>.
The library calls it with <code>k = 1</code> only, so no library result changes.</li>
<li><code>MathOperations.RealType.Functions.toFixedPoint</code> rounded negative values one count too low
(<code>floor(x - 0.5)</code>: -123.4 gave -124, and a value saturated at <code>MIN</code> gave
<code>MIN - 1</code>). It now rounds to nearest, halves away from zero, for both signs.
<b>Results of the fixed-point math blocks with negative signals change.</b></li>
<li><code>Controllers.I</code>, sampled (<code>Ts &gt; 0</code>): the integrator state was rebuilt as
<code>pre(CS) - pre(bias)</code>; for a continuous-time bias <code>pre(bias)</code> is the current bias, so a change of
the bias cancelled itself and never reached CS. The bias is now sampled into a discrete variable.
<b>Results of sampled <code>I</code> controllers with a varying bias change.</b></li>
<li><code>Controllers.AutoTuning.ATPIrelayNCdigital</code>: in PI mode the output was always limited to
[<code>CSmin</code>, <code>CSmax</code>], whatever <code>AntiWindup</code>. It now honours the flag, like every other
controller: limited (with the anti-windup of the reset state) only if <code>AntiWindup = true</code>.
<b>Results of models using it with <code>AntiWindup = false</code> whose output leaves the limits change.</b></li>
<li><code>Controllers.AutoTuning.ATPIrelayNCmixedMode</code>: in tracking mode the output was TR even with
<code>AntiWindup = true</code>; it is now TR limited to [<code>CSmin</code>, <code>CSmax</code>], as documented for all
controllers.</li>
<li><code>Controllers.Blocks.ComplexPoles</code>: in tracking mode the equations did not define the derivative of
the second state, so a simulation stopped with a singular Jacobian when <code>TS</code> became true. The states now
follow <code>TR</code> through a critically damped second-order lag with time constant <code>eps</code>.</li>
<li><code>MathOperations.RealType.Div</code> with <code>FixedPoint = true</code>: the quotient was wrong. For
|u2| &lt; 1 (with a scale factor &gt; 1) the integer division dropped the fractional part of the quotient (1/0.3 gave 3);
otherwise u2 was rounded to an integer before dividing (u1/1.5 became u1/2), and with scale factor 1 and |u2| &lt; 1 it
divided by zero. The quotient is now rounded to the output scale and limited to [MIN, MAX], like the other operators.
<b>Results of fixed-point divisions change.</b></li>
<li><code>LinearSystems.Discrete.TransferFunction</code>: the update equation left out the denominator coefficient of
the state (it assumed it is 1, as in the default <code>den</code>), so other denominators gave a wrong response; and the
initialisation flags had no effect, because they set the output or zero states instead of the discrete states before the
first sample (the output always started near 0). <code>initOutput</code> now starts the output at <code>y_start</code>,
<code>initSteadyState</code> and <code>initSteadyOutput</code> at the steady state for the initial input.
<b>Results of models using it with a denominator whose second coefficient is not 1, or with an initialisation flag,
change.</b></li>
<li><code>Controllers.Digital.PID_2dof</code>, <code>PID_2dof_TDO</code>,
<code>PID_2dof_TDO_FullyEventBased</code>: the bias entered as the increment <code>bias - pre(bias)</code>,
which is 0 at a sampling instant for a continuous-time bias signal, so the bias was never applied. The
bias is now sampled into a discrete variable and its increment since the last sample is added.
<b>Results of models using the bias input of these controllers change.</b></li>
<li><code>LinearSystems.Discrete.MultiStepsDelay</code>: delayed by N-1 samples instead of the documented
N, and its default <code>N = 1</code> violated its own assertion <code>N &gt; 1</code>. It now delays by N
samples, and N = 1 is allowed (same as <code>Delay</code>).</li>
</ul>

<h5>Tests: a separate library with examples, self-checking tests and MC/DC tests (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/8\">PR #8</a>)</h5>
<p>The tests and examples are no longer part of <code>IndustrialControlSystems</code>. They are in the separate top-level library
<code>Tests</code> (same repository, folder <code>Tests</code>, <code>uses(IndustrialControlSystems(version=\"2.0.1\"))</code>), which
has to be loaded in addition to the library to run them. The library keeps the <code>Applications</code> examples.</p>
<ul>
<li><b>Examples moved.</b> Every <code>IndustrialControlSystems.*.Examples</code> package moved to <code>Tests</code>, without the
<code>Examples</code> level: for example <code>Controllers.Examples.TestPI_bias</code> is now <code>Tests.Controllers.TestPI_bias</code>,
and the regression tests of 2.0.1 listed below are in <code>Tests.Controllers</code>. Models that referred to an example must use its
new name.</li>
<li><b>Self-checking tests.</b> Each has a Boolean <code>passed</code>, true when every check passed; a failed check also issues an
assertion warning at the end of the run. They cover the classes the examples did not exercise
(<code>Tests.LinearSystems</code>, <code>Tests.Logical</code>, <code>Tests.MathOperations</code>) and every library function
(<code>Tests.FunctionChecks</code>). The regression tests <code>TestI_biasNoDrift</code>, <code>TestGainScheduling</code>,
<code>TestTracking_bias</code>, <code>TestInit_CSstart</code>, <code>TestI_bias</code> and <code>TestI_tracking</code> now check
their documented expected values as well (<code>TestGainScheduling</code> and <code>TestInit_CSstart</code> run 0.05 s longer, so that the
sampled value at the end of the table can be checked). The check blocks are in <code>Tests.Utilities</code>.</li>
<li><b>MC/DC tests.</b> <code>Tests.Controllers.MCDC</code> holds 187 tests for modified condition/decision coverage of every controller
class (<code>P</code>, <code>PI</code>, <code>I</code>, <code>D</code>, <code>PD</code>, <code>PID</code>, the digital PIDs, the
autotuners, <code>Blocks</code> and the relays): per class a <code>Base</code> model with every option off and one variant per option
change (<code>extends Base(useTS=true)</code>, continuous and sampled), each self-checking against an independent reference or a
flag-dependent invariant. They found the defects listed above in the sampled <code>I</code> with a bias, the digital PIDs' bias,
<code>ATPIrelayNCdigital</code>, <code>ATPIrelayNCmixedMode</code> and <code>Blocks.ComplexPoles</code>. The package is generated by
<code>Tests/Scripts/generate_mcdc.py</code>.</li>
<li><b>MC/DC tests of the other packages.</b> 60 more tests with the same structure, generated by
<code>Tests/Scripts/generate_mcdc_library.py</code>:
<ul>
<li><code>Tests.Logical.MCDC</code> (21): <code>And</code>, <code>Or</code>, <code>Xor</code> (continuous, sampled, two
inputs), <code>Not</code>, <code>FlipFlopSR</code> (<code>q_start</code>), the five timers and the counter (scenarios with an
independently stated expectation).</li>
<li><code>Tests.MathOperations.MCDC</code> (27): <code>RealType.Add</code>, <code>Sub</code>, <code>Mult</code>,
<code>Div</code>, <code>Pow</code> (floating and fixed point, continuous and sampled, saturation) and
<code>Expression</code> (also <code>useInputs</code>), <code>IntegerType.Expression</code>.</li>
<li><code>Tests.LinearSystems.MCDC</code> (12): continuous and discrete <code>TransferFunction</code> (the three
initialisation flags, biproper, a denominator whose state coefficient is not 1, Forward Euler and Tustin).</li>
</ul>
They found the defects in <code>RealType.Div</code> and <code>Discrete.TransferFunction</code> listed above. Classes
already covered in both branches by self-checking tests (comparisons, <code>Nand</code>/<code>Nor</code>/<code>Xnor</code>,
the integer operators) are left out. A check of <code>Tests.Utilities.CheckRealWhile</code> now fails if its window never
opened.</li>
</ul>

<h5>New features (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/3\">PR #3</a>)</h5>
<ul>
<li><code>Controllers.PI</code>: new parameters <code>initFromFBstart</code> (default <code>false</code>) and <code>FBstart</code>
in the Initialisation group. With <code>initFromFBstart = true</code> the reset state starts at <code>FBstart</code>
(<code>FBout = FBstart</code> in continuous time, <code>pre(FBout) = FBstart</code> when sampled) instead of being computed from
<code>CS_start</code>. The default keeps the previous behaviour.</li>
<li>New example package <code>Applications.ControlStrategies</code> with <code>LeadLagFilter</code>: a noisy, sensor-filtered step
passes through a low-pass filter and a lead-lag filter that compensates the phase lag of the low-pass filter.</li>
</ul>

<h5>Documentation (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/3\">PR #3</a>)</h5>
<ul>
<li>HTML documentation added or expanded for about 100 classes in Applications, Controllers, LinearSystems, Logical,
MathOperations, Icons and UserGuide.</li>
<li>Descriptions added to every class and variable that had none, including the discrete variables of <code>PID_2dof</code>,
the TDO PIDs, the AutoTuning blocks, the timers, the counter, LinearSystems and the signal generators.</li>
<li>The documentation of <code>I</code>, <code>PI</code>, <code>PD</code>, <code>D</code> and <code>PID</code> describes how the
output is initialised from <code>CS_start</code> (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/5\">PR #5</a>, <a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/6\">PR #6</a>).</li>
</ul>

<h5>Regression tests (<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/4\">PR #4</a>, <a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/5\">PR #5</a>, <a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/6\">PR #6</a>)</h5>
<p>New models, now in <code>Tests.Controllers</code>. Each runs continuous and sampled controllers side by side with constant inputs,
and its documentation lists the expected values:</p>
<ul>
<li><code>TestI_biasNoDrift</code>: an <code>I</code> controller with bias and zero error does not drift.</li>
<li><code>TestPD_proportional</code>: proportional action of <code>PD</code> and its initial output.</li>
<li><code>TestGainScheduling</code>: gain scheduling in <code>P</code>, <code>PI</code> and <code>I</code>, continuous and sampled.</li>
<li><code>TestTracking_bias</code>: <code>CS = TR</code> without bias while tracking, for <code>PI</code>, <code>I</code> and <code>PID</code>.</li>
<li><code>TestTracking_bumpless</code>: no step on return from tracking for <code>PI</code>, <code>PID</code> and the PI autotuners.</li>
<li><code>TestPI_initFromFBstart</code>: the new <code>initFromFBstart</code> option of <code>PI</code>.</li>
<li><code>TestInit_CSstart</code>: <code>I</code>, <code>PI</code> and <code>D</code> start at <code>CS_start</code>, with and without anti-windup.</li>
<li><code>TestPID_initCSstart</code>: <code>PID</code> starts at <code>CS_start</code> without a derivative kick.</li>
</ul>

<p>Version: 2.0.0 Aug 7, 2024: Maintenance release, update to Modelica 4.0.0 Version 2.0.0 is the same as 1.2.0 but it works with MSL 4.0.0. 
Technically speaking it is not backwards compatible with 1.2.0 because it depends on the non-backwards compatible MSL 4.0.0, 
but in practice the conversion script only affects the examples and applications in the library, but it doesn't change the code of the used blocks in the library</p>

<p>Version: 1.1.0 Dec 6, 2019: Maintenance release and update to Modelica 3.2.3</p>
<p>Version: 1.0.0 May 15, 2012: Initial release</p>
</html>"));
end ReleaseNotes;
