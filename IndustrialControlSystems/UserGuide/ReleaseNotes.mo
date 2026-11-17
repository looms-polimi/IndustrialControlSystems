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

<p><b>Unreleased changes after 2.0.1</b>. Bug fixes that change simulation results for the
configurations listed; regenerate reference results of models that use them.</p>
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
<li><code>LinearSystems.Discrete.MultiStepsDelay</code>: delayed by N-1 samples instead of the documented
N, and its default <code>N = 1</code> violated its own assertion <code>N &gt; 1</code>. It now delays by N
samples, and N = 1 is allowed (same as <code>Delay</code>).</li>
<li><code>Controllers.PD</code>: the controller now implements proportional + derivative action,
<code>CS = Kp*[(SP-PV) + sTd/(1+sTd/N)*(SP-PV)] + Bias</code>, as its name and description state.
Before, it implemented only the scaled filtered derivative <code>Kp*sTd/(1+sTd/N)*(SP-PV)</code>, with
no output for a constant error. <code>CS_start</code> is now the initial output (saturated if
<code>AntiWindup = true</code>); before, it initialised the derivative filter state.
<b>Results of all models using <code>PD</code> change.</b>
(<a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/4\">#4</a>)</li>
<li><code>Controllers.I</code>, continuous time: with <code>useBIAS = true</code> the integrator ramped at
<code>Bias/eps</code> whenever the output was not saturated, because of an error in the anti-windup term.
Models without bias are not affected. (<a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/3\">#3</a>)</li>
<li><code>Controllers.P</code>, <code>PI</code>, <code>I</code>: with <code>useGS = true</code> the sampled
versions (<code>Ts &gt; 0</code>) ignored the gain-scheduling inputs and used the parameters; they now use
the scheduled values, read at each sampling instant. A continuous <code>PI</code> with a gain schedule now
starts at <code>CS_start</code>. Models without <code>useGS</code> are not affected.
(<a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/5\">#5</a>)</li>
<li>Tracking mode (<code>useTS = true</code>, <code>TS = true</code>): all controllers now output
<code>CS = TR</code> (saturated if <code>AntiWindup = true</code>) without adding the bias, as documented.
Before, the continuous <code>PI</code>, <code>I</code> (without anti-windup) and <code>PID</code> (both
versions) added the bias. In <code>I</code> the integrator state follows <code>TR - Bias</code>, so the
return to automatic mode is bumpless. Models without <code>useBIAS</code> are not affected.
(<a href=\"https://github.com/hubertus65/IndustrialControlSystems/issues/6\">#6</a>)</li>
<li>Bumpless transfer from tracking to automatic mode: in <code>PI</code>, <code>PID</code>,
<code>AutoTuning.ATPIrelayNCdigital</code> and <code>AutoTuning.ATPIrelayNCmixedMode</code> the integral
(reset) state now follows <code>TR - Bias - P</code> (and <code>- D</code> in <code>PID</code>) while tracking,
instead of <code>TR</code>, so the output continues from <code>TR</code> without a step when tracking ends.
Before, it jumped by the proportional (and derivative) action plus the bias. <code>I</code> follows
<code>TR - Bias</code> (see above). The digital <code>PID_2dof</code> controllers are incremental and were
already bumpless. <code>P</code>, <code>PD</code> and <code>D</code> have no integral state: on release
their output still steps from <code>TR</code> to the value of their control law.
Results change only for models that use tracking mode.</li>
</ul>

<p>Version 2.0.1 Mar. 18, 2026 Made compatible with Modelon Impact by removing a few minor compliance errors. Also fixed name-typos, and updated to MSL 4.1.0.</p>

<p>Version: 2.0.0 Aug 7, 2024: Maintenance release, update to Modelica 4.0.0 Version 2.0.0 is the same as 1.2.0 but it works with MSL 4.0.0. 
Technically speaking it is not backwards compatible with 1.2.0 because it depends on the non-backwards compatible MSL 4.0.0, 
but in practice the conversion script only affects the examples and applications in the library, but it doesn't change the code of the used blocks in the library</p>

<p>Version: 1.1.0 Dec 6, 2019: Maintenance release and update to Modelica 3.2.3</p>
<p>Version: 1.0.0 May 15, 2012: Initial release</p>
</html>"));
end ReleaseNotes;
