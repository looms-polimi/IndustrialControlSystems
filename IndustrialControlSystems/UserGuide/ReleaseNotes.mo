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

<p>Version 2.0.1 Mar. 18, 2026 Made compatible with Modelon Impact by removing a few minor compliance errors. Also fixed name-typos, and updated to MSL 4.1.0.</p>

<p>Version: 2.0.0 Aug 7, 2024: Maintenance release, update to Modelica 4.0.0 Version 2.0.0 is the same as 1.2.0 but it works with MSL 4.0.0. 
Technically speaking it is not backwards compatible with 1.2.0 because it depends on the non-backwards compatible MSL 4.0.0, 
but in practice the conversion script only affects the examples and applications in the library, but it doesn't change the code of the used blocks in the library</p>

<p>Version: 1.1.0 Dec 6, 2019: Maintenance release and update to Modelica 3.2.3</p>
<p>Version: 1.0.0 May 15, 2012: Initial release</p>
</html>"));
end ReleaseNotes;
