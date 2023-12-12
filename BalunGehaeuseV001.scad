
/* [Balun-Type] */
// Was für ein Balungehäuse:
Type="Spannung"; // ["Spannung","Strom"]

/* [Gehäuse-Teil] */
// Welches Teil soll generiert werden:
Teil="Körper & Deckel"; // ["Körper & Deckel","Körper", "Deckel"]

/* [Spannungs-Balun-Gehäuse] */
// Ausendurchmesser:
UDurchmesserAussen=100;

// Höhe:
UHoehe=40;

// Wandstärke.
UDicke=3;

/* [Strom-Balun-Gehäuse] */
// Breite:
IBreite=50;

// Tiefe:
ITiefe=100;

// Höhe:
IHoehe=40;

// Wandstärke.
IDicke=3;

/* [Buchsen-Ansatz] */
// Tiefe:
BuAnTiefe=30;

// Breite:
BuAnBreite=30;

/* [Deckel] */
// Deckel Dicke ohne Eindringtiefe:
DeDicke=3;

// Eindring-Tiefe in Gehäuse:
DeEiTiefe=5;

// Deckel-Rand
DeRand=1.5;

// Snapin Durchmesser.
DeSnapDurch=1;

// slider widget for number in range
DeScaleXY=0.99; // [0.98:0.01:1.02]

/* [Abgriffe] */
// Bohrung-Durchmesser:
AbgBoDurch=5;

// Anzahl-Abgriffe:
AbgAnz=4;

// Start-Winkel:
Deg=90;

// Abstand in Grad:
AbgDeltaDeg=15;

/* [Anschlußflansch] */
// Typ des Anschluß Flansches:
FlanschTyp="UG 58 TG"; // ["UG 58 TG","Hyperflex 5"]

/* [Deckel Beschriftung] */
// Zeile 1: Text:--------------------------
Text01="Strom-";

// Zeile 1: Größe:
Text01Size=8;

// Zeile 2: Text:--------------------------
Text02="Balun";

// Zeile 2: Größe:
Text02Size=8;

// Zeile 2: Abstand zu Zeile 1:
Text02Space=3;

// Zeile 3: Text:--------------------------
Text03="V0.0";

// Zeile 3: Größe:
Text03Size=8;

// Zeile 3: Abstand zu Zeile 2:
Text03Space=3;

// Zeile 4: Text:
Text04="DB5ZF";

// Zeile 4: Größe:
Text04Size=8;

// Zeile 4: Abstand zu Zeile 3:
Text04Space=3;

// Zeile 5: Text:
Text05="05.12.2023";

// Zeile 5: Größe:
Text05Size=6;

// Zeile 5: Abstand zu Zeile 4:
Text05Space=3;

// Zeile 6: Text:
Text06="FT-114-43 &";

// Zeile 6: Größe:
Text06Size=6;

// Zeile 6: Abstand zu Zeile 5:
Text06Space=3;

// Zeile 7: Text:
Text07="FT-114-77";

// Zeile 7: Größe:
Text07Size=6;

// Zeile 7: Abstand zu Zeile 6:
Text07Space=3;

// Zeile 8: Text:
Text08="in Reihe.";

// Zeile 8: Größe:
Text08Size=6;

// Zeile 8: Abstand zu Zeile 7:
Text08Space=3;


$fn=200;
echo($fn);

//echo($font);
//font="Liberation Sans:style=Bold Italic";
////////////////////////////////////////////////////////////////////////////////////////

module UGehause()
{
	// Innen.
	difference()
	{
		// Aussen.
		union()
		{
			// Balunkörper.
			translate([0, 0, 0])
			rotate([0, 0, 0])
			cylinder(d=UDurchmesserAussen, h=UHoehe, center=false);
			
			// Buchsen-Ansatz.
			translate([(BuAnBreite/2)*-1, ((UDurchmesserAussen/2)+BuAnTiefe)*-1, 0])
			cube([BuAnBreite, (UDurchmesserAussen/2)+BuAnTiefe, UHoehe], center=false);
		}
		
		// Innen.
		union()
		{
			// Balunkörper
			translate([0, 0, UDicke])
			rotate([0, 0, 0])
			cylinder(d=UDurchmesserAussen-(2*UDicke), h=UHoehe, center=false);
			
			// Buchsen-Ansatz.
			translate([((BuAnBreite/2)-UDicke)*-1, ((UDurchmesserAussen/2)+BuAnTiefe-UDicke)*-1, UDicke])
			cube([BuAnBreite-(2*UDicke), (UDurchmesserAussen/2)+BuAnTiefe-UDicke, UHoehe], center=false);
		}
		
		// Deckel-Rand.
		union()
		{
			// Balunkörper
			translate([0, 0, UHoehe-DeEiTiefe+0])
			rotate([0, 0, 0])
			cylinder(d=UDurchmesserAussen-(2*DeRand), h=DeEiTiefe+1, center=false);
			
			// Buchsen-Ansatz.
			translate([((BuAnBreite/2)-DeRand)*-1, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, UHoehe-DeEiTiefe+0])
			cube([BuAnBreite-(2*DeRand), (UDurchmesserAussen/2)+BuAnTiefe-DeRand, DeEiTiefe+1], center=false);
		}
		
		// Snapin Rand.
		translate([0, 0, UHoehe-DeEiTiefe+(DeSnapDurch/2)+0])
		rotate_extrude(convexity=10)
		translate([(UDurchmesserAussen-(2*DeRand))/2, 0, 0])
		circle(r=(DeSnapDurch/2), $fn=100);
		
		// Abgriffe
		for(deg=[Deg:AbgDeltaDeg:Deg+((AbgAnz-1)*AbgDeltaDeg)])
		{
			// Abgriffe.
			echo(deg)
			echo(AbgDeltaDeg)
			echo(AbgAnz*AbgDeltaDeg)
			echo("----")
			translate([0, 0, (UHoehe-DeEiTiefe)/2])
			rotate([90, 0, deg*-1])
			cylinder(d=AbgBoDurch, h=(UDurchmesserAussen/2)+1, center=false);
		}
		
		// Anschluß-Flansch.
		if(FlanschTyp=="UG 58 TG")
		{
			MitteDurchm=10;
			BefDurchm=3;
			BefAbst=18.3;
			
			// Mittel-Durchbruch.
			translate([0, 0, UHoehe/2])
			rotate([90, 0, 0])
			cylinder(d=MitteDurchm, h=(UDurchmesserAussen/2)+BuAnTiefe+1, center=false);
			
			// Befestigung oen-links.
			translate([(BefAbst/2)*-1, 0, (UHoehe/2)+(BefAbst/2)])
			rotate([90, 0, 0])
			cylinder(d=BefDurchm, h=(UDurchmesserAussen/2)+BuAnTiefe+1, center=false);
			
			// Befestigung oen-rechts.
			translate([(BefAbst/2), 0, (UHoehe/2)+(BefAbst/2)])
			rotate([90, 0, 0])
			cylinder(d=BefDurchm, h=(UDurchmesserAussen/2)+BuAnTiefe+1, center=false);
			
			// Befestigung unten-links.
			translate([(BefAbst/2)*-1, 0, (UHoehe/2)-(BefAbst/2)])
			rotate([90, 0, 0])
			cylinder(d=BefDurchm, h=(UDurchmesserAussen/2)+BuAnTiefe+1, center=false);
			
			// Befestigung unten-rechts.
			translate([(BefAbst/2), 0, (UHoehe/2)-(BefAbst/2)])
			rotate([90, 0, 0])
			cylinder(d=BefDurchm, h=(UDurchmesserAussen/2)+BuAnTiefe+1, center=false);
		}
		
		if(FlanschTyp=="Hyperflex 5")
		{
			MitteDurchm=5;
			BefAbst=18.3;
			
			// Mittel-Durchbruch.
			// translate([IBreite/2, ITiefe+1, IHoehe/2])
			translate([0, 0, UHoehe/2])
			rotate([90, 0, 0])
			cylinder(d=MitteDurchm, h=ITiefe+2, center=false);
		}
	}
}

module UDeckel()
{
	//
	union()
	{
		// Balunkörper.
		translate([0, 0, 0])
		rotate([0, 0, 0])
		cylinder(d=UDurchmesserAussen, h=DeDicke, center=false);
		
		// Buchsen-Ansatz.
		translate([(BuAnBreite/2)*-1, ((UDurchmesserAussen/2)+BuAnTiefe)*-1, 0])
		cube([BuAnBreite, (UDurchmesserAussen/2)+BuAnTiefe, DeDicke], center=false);
		
		// Eindringrand-Balunkörper
		translate([0, 0, DeDicke])
		rotate([0, 0, 0])
		cylinder(d=UDurchmesserAussen-(2*DeRand), h=DeEiTiefe, center=false);
		
		// Eindringrand-Buchsen-Ansatz.
		translate([((BuAnBreite/2)-DeRand)*-1, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, DeDicke])
		cube([BuAnBreite-(2*DeRand), (UDurchmesserAussen/2)+BuAnTiefe-DeRand, DeEiTiefe], center=false);
		
		// Snapin Rand.
		translate([0, 0, DeDicke+DeEiTiefe-(DeSnapDurch/2)])
		rotate_extrude(convexity=10)
		translate([(UDurchmesserAussen-(2*DeRand))/2, 0, 0])
		circle(r=(DeSnapDurch/2), $fn=100);
	}
}

module IGehause()
{
	difference()
	{
		// Außen.
		translate([0, 0, 0])
		cube([IBreite, ITiefe, IHoehe], center=false);
		
		// Innen.
		translate([IDicke, IDicke, IDicke])
		cube([IBreite-(IDicke*2), ITiefe-(IDicke*2), IHoehe], center=false);
		
		// Deckelrand Eindringtiefe.
		translate([DeRand, DeRand, IHoehe-DeEiTiefe])
		cube([IBreite-(2*DeRand), ITiefe-(2*DeRand), DeEiTiefe+1], center=false);
		
		// Anschluß-Flansch.
		if(FlanschTyp=="UG 58 TG")
		{
			MitteDurchm=10;
			BefDurchm=3;
			BefAbst=18.3;
			
			// Mittel-Durchbruch.
			translate([IBreite/2, ITiefe+1, IHoehe/2])
			rotate([90, 0, 0])
			cylinder(d=MitteDurchm, h=ITiefe+2, center=false);
			
			// Befestigung oben-links.
			translate([(IBreite/2)-(BefAbst/2), ITiefe+1, (IHoehe/2)+(BefAbst/2)])
			rotate([90, 0, 0])
			cylinder(d=BefDurchm, h=ITiefe+2, center=false);
			
			// Befestigung oben-rechts.
			translate([(IBreite/2)+(BefAbst/2), ITiefe+1, (IHoehe/2)+(BefAbst/2)])
			rotate([90, 0, 0])
			cylinder(d=BefDurchm, h=ITiefe+2, center=false);
			
			// Befestigung unten-links.
			translate([(IBreite/2)-(BefAbst/2), ITiefe+1, (IHoehe/2)-(BefAbst/2)])
			rotate([90, 0, 0])
			cylinder(d=BefDurchm, h=ITiefe+2, center=false);
			
			// Befestigung unten-rechts.
			translate([(IBreite/2)+(BefAbst/2), ITiefe+1, (IHoehe/2)-(BefAbst/2)])
			rotate([90, 0, 0])
			cylinder(d=BefDurchm, h=ITiefe+2, center=false);
		}
		
		if(FlanschTyp=="Hyperflex 5")
		{
			MitteDurchm=5;
			BefAbst=18.3;
			
			// Mittel-Durchbruch.
			translate([IBreite/2, ITiefe+1, IHoehe/2])
			rotate([90, 0, 0])
			cylinder(d=MitteDurchm, h=ITiefe+2, center=false);
		}
		
		// Snapin Rand links.
		translate([DeRand, DeRand, IHoehe-DeEiTiefe+(DeSnapDurch/2)])
		rotate([-90, 0, 0])
		cylinder(d=DeSnapDurch, h=ITiefe-(2*DeRand), center=false);
		
		// Snapin Rand rechts.
		translate([IBreite-DeRand, DeRand, IHoehe-DeEiTiefe+(DeSnapDurch/2)])
		rotate([-90, 0, 0])
		cylinder(d=DeSnapDurch, h=ITiefe-(2*DeRand), center=false);
		
		// Snapin Rand vorne.
		translate([DeRand-(DeSnapDurch/2), DeRand, IHoehe-DeEiTiefe+(DeSnapDurch/2)])
		rotate([0, 90, 0])
		cylinder(d=DeSnapDurch, h=IBreite-(2*DeRand)+DeSnapDurch, center=false);
		
		// Snapin Rand hinten.
		translate([DeRand-(DeSnapDurch/2), ITiefe-DeRand, IHoehe-DeEiTiefe+(DeSnapDurch/2)])
		rotate([0, 90, 0])
		cylinder(d=DeSnapDurch, h=IBreite-(2*DeRand)+DeSnapDurch, center=false);
		
	}
}

module IDeckel()
{
	difference()
	//union()
	{
		union()
		{
			// Außen.
			translate([0, 0, 0])
			cube([IBreite, ITiefe, IDicke], center=false);
			
			// Eindringtiefe.
			translate([DeRand, DeRand, IDicke])
			cube([IBreite-(2*DeRand), ITiefe-(2*DeRand), DeEiTiefe], center=false);
			
			// Snapin Rand links.
			translate([DeRand, DeRand, IDicke+DeEiTiefe-(DeSnapDurch/2)])
			rotate([-90, 0, 0])
			cylinder(d=DeSnapDurch, h=ITiefe-(2*DeRand), center=false);
			
			// Snapin Rand rechts.
			translate([IBreite-DeRand, DeRand, IDicke+DeEiTiefe-(DeSnapDurch/2)])
			rotate([-90, 0, 0])
			cylinder(d=DeSnapDurch, h=ITiefe-(2*DeRand), center=false);
			
			// Snapin Rand vorne.
			translate([DeRand, DeRand, IDicke+DeEiTiefe-(DeSnapDurch/2)])
			rotate([0, 90, 0])
			cylinder(d=DeSnapDurch, h=IBreite-(2*DeRand), center=false);
			
			// Snapin Rand hinten.
			translate([DeRand, ITiefe-DeRand, IDicke+DeEiTiefe-(DeSnapDurch/2)])
			rotate([0, 90, 0])
			cylinder(d=DeSnapDurch, h=IBreite-(2*DeRand), center=false);
		}
		
		// Text.
		Font="Liberation Sans:style=Bold";
		// 1. Zeile.
		translate([IBreite-IDicke, (ITiefe-Text01Size-IDicke), 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text01, font=Font, size=Text01Size);
		
		// 2. Zeile.
		//Font="Liberation Sans:style=Regular";
		//Font="Liberation Sans:style=Bold";
		//Font="Liberation Serif:style=Bold";
		//Font="Nimbus Sans L:style=Regular Condensed";
		translate([IBreite-IDicke, (ITiefe-Text01Size-IDicke)-(Text02Size+Text02Space), 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text02, font=Font, size=Text02Size);
		
		// 3. Zeile.
		translate([IBreite-IDicke, (ITiefe-Text01Size-IDicke)-(Text02Size+Text02Space)-(Text03Size+Text03Space), 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text03, font=Font, size=Text03Size);
		
		// 4. Zeile.
		translate([IBreite-IDicke, (ITiefe-Text01Size-IDicke)-(Text02Size+Text02Space)-(Text03Size+Text03Space)-(Text04Size+Text04Space), 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text04, font=Font, size=Text04Size);
		
		// 5. Zeile.
		translate([IBreite-IDicke, (ITiefe-Text01Size-IDicke)-(Text02Size+Text02Space)-(Text03Size+Text03Space)-(Text04Size+Text04Space)-(Text05Size+Text05Space), 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text05, font=Font, size=Text05Size);
		
		// 6. Zeile.
		translate([IBreite-IDicke, (ITiefe-Text01Size-IDicke)-(Text02Size+Text02Space)-(Text03Size+Text03Space)-(Text04Size+Text04Space)-(Text05Size+Text05Space)-(Text06Size+Text06Space), 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text06, font=Font, size=Text06Size);
		
		// 7. Zeile.
		translate([IBreite-IDicke, (ITiefe-Text01Size-IDicke)-(Text02Size+Text02Space)-(Text03Size+Text03Space)-(Text04Size+Text04Space)-(Text05Size+Text05Space)-(Text06Size+Text06Space)-(Text07Size+Text07Space), 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text07, font=Font, size=Text07Size);
		
		// 8. Zeile.
		translate([IBreite-IDicke, (ITiefe-Text01Size-IDicke)-(Text02Size+Text02Space)-(Text03Size+Text03Space)-(Text04Size+Text04Space)-(Text05Size+Text05Space)-(Text06Size+Text06Space)-(Text07Size+Text07Space)-(Text08Size+Text08Space), 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text08, font=Font, size=Text08Size);
	}
}


if(Type=="Spannung")
{
	if(Teil=="Körper")
	{
		translate([0, 0, 0]) UGehause();
	}

	if(Teil=="Deckel")
	{
		scale([DeScaleXY, DeScaleXY, 1]) translate([0, 0, 0]) UDeckel();
	}

	if(Teil=="Körper & Deckel")
	{
		scale([1, 1, 1])                 translate([(UDurchmesserAussen/2)+10,      0, 0]) UGehause();
		scale([DeScaleXY, DeScaleXY, 1]) translate([((UDurchmesserAussen/2)+10)*-1, 0, 0]) UDeckel();
	}
}


if(Type=="Strom")
{
	// Körper.
	if(Teil=="Körper")
	{
		translate([0, 0, 0]) IGehause();
	}
	
	// Deckel.
	if(Teil=="Deckel")
	{
		scale([DeScaleXY, DeScaleXY, 1]) translate([0, 0, 0]) IDeckel();
	}
	
	if(Teil=="Körper & Deckel")
	{
		scale([1, 1, 1])                 translate([10,      0, 0]) IGehause();
		scale([DeScaleXY, DeScaleXY, 1]) translate([(IBreite+10)*-1, 0, 0]) IDeckel();
	}
}


