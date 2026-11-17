within IndustrialControlSystems.Controllers;
model PD "Proportional + Derivative controller"
  extends Interfaces.Controller;
  parameter Real Kp = 5 "Proportional gain"
    annotation(Evaluate = true, Dialog(group = "Parameters"));
  parameter Real Td = 1 "Derivative time"
    annotation(Evaluate = true, Dialog(group = "Parameters"));
  parameter Real N =  10 "Derivative filter ratio"
    annotation(Evaluate = true, Dialog(group = "Parameters"));
  Real Fin "Low-pass filtered error, scaled by Kp*N (state of the derivative filter)";
  Real satin "input of the saturation block";
initial equation

  // Initialise the derivative filter so that the output starts at CS_start
  // (saturated if AntiWindup): Kp*(SP-PV) + Kp*N*(SP-PV) - Fin + bias = CS_start.
  // In the sampled branch this sets the state one sample before t=0, so at t=0
  // the derivative part has already decayed by one filter step.
  if Ts > 0 then
    // Discrete time initialisation
    pre(Fin) = Kp*(1 + N)*(SP - PV) + bias
               - (if AntiWindup then max(CSmin,min(CSmax,CS_start)) else CS_start);
  else
    // Continuous time initialisation
    Fin = Kp*(1 + N)*(SP - PV) + bias
          - (if AntiWindup then max(CSmin,min(CSmax,CS_start)) else CS_start);
  end if;

equation

  if Ts > 0 then
    // Discrete time controller
    when sample(0,Ts) then
      CS    = if AntiWindup then max(CSmin,min(CSmax,satin)) else satin;
      // proportional action + real derivative action Kp*N*(e - lowpass(e))
      satin = if ts then tr else Kp*(SP - PV) + Kp*N*(SP - PV) - Fin + pre(bias);
      Fin = IndustrialControlSystems.LinearSystems.Discrete.Functions.f1Pole(
        alfa,
        SP - PV,
        pre(SP) - pre(PV),
        pre(Fin),
        Ts,
        Kp*N,
        Td/N);
    end when;
  else
    // Continuous time controller
    CS    = if AntiWindup then max(CSmin,min(CSmax,satin)) else satin;
    // proportional action + real derivative action Kp*N*(e - lowpass(e))
    satin = if ts then tr else Kp*(SP - PV) + Kp*N*(SP - PV) - Fin + bias;
    Fin + Td/N*der(Fin) = Kp*N*(SP - PV);
  end if;

  annotation (Icon(graphics={Text(
          extent={{-40,28},{40,-42}},
          lineColor={0,0,255},
          textString="PD")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Proportional + real derivative controller with Automatic, Tracking mode and bias signal.<br/>
  The control law is defined as
  <pre>
            [                      sTd                      ]
  CS(s) = Kp[ (SP(s) - PV(s)) + ----------- (SP(s) - PV(S)) ] + Bias
            [                   1 + sTd/N                   ]
  </pre>
  The output starts at <code>CS_start</code> (saturated to [CSmin, CSmax] if AntiWindup = true):
  the state of the derivative filter is initialised accordingly. In the sampled version
  (Ts &gt; 0) the state is set one sample before t = 0, so the derivative part has already
  decayed by one filter step at t = 0.
  <br/><br/>
  <b>Scheme</b><br/><br/>
  <img src=\"modelica://IndustrialControlSystems/Resources/Images/Controllers/PropDerivative.png\">
  <br/><br/>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH><TH>Conditional?</TH></TR>
  <tr>  <td>SP</td><td>Set Point</td><td>NO</td></tr>
  <tr>  <td>PV</td><td>Process Variable</td><td>NO</td></tr>
  <tr>  <td>CS</td><td>Control Signal</td><td>NO</td></tr>
  <tr>  <td>TR</td><td>Track Reference signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>TS</td><td>Track Switch signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>Bias</td><td>Biasing signal</td><td>YES (useBIAS)</td></tr>
  <tr>  <td>ATreq</td><td>AutoTuning request</td><td>YES (*)</td></tr>
  </table>
  (*) AutoTuning Not available here, please see the package<br>
  <a href=\"Modelica://IndustrialControlSystems.Controllers.AutoTuning\">AutoTuning</a>
  <br/><br/>
  The controller can have various operating conditions:
  <ul>
  <li>Automatic,</li>
  <li>and Tracking</li>
  </ul><br/>
  
  In the Automatic mode, the control output is computed with the proportional + derivative control law, while in the tracking mode<br>
  it is defined by the input TR.<br/><br/>
  To note that in the tracking mode the output signal CS is equal to TR.
  </p>
  </HTML>",
          revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &lt;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&gt;</dd>
<dd>Alberto Leva &lt;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&gt;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end PD;
