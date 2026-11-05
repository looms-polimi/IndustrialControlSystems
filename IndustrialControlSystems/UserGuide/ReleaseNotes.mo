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
<a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/2\">PR #2</a> to <a href=\"https://github.com/looms-polimi/IndustrialControlSystems/pull/6\">PR #6</a>. The issue links point to the issue tracker of the
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
<li>Typos in class names fixed. <b>These classes are renamed</b>, and models that use them must be updated by hand:
<ul>
<li><code>MathOperations.RealType.Signals.SmoothThooth</code> &rarr; <code>SmoothTooth</code></li>
<li><code>MathOperations.RealType.Signals.SmoothThoothSignal</code> &rarr; <code>SmoothToothSignal</code></li>
<li><code>Applications.TrasferFunctions</code> &rarr; <code>Applications.TransferFunctions</code></li>
<li><code>Logical.LogicalOperations.Examples.FliFlop</code> &rarr; <code>FlipFlop</code></li>
</ul></li>
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
<p>New models in <code>Controllers.Examples</code>. Each runs continuous and sampled controllers side by side with constant inputs,
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
