
/* [Balun Type (Spannung/Strom)] */
// Was für ein Balungehäuse:
Type="Spannung"; // ["Spannung","Strom"]

/* [Gehäuse-Teil (Spannung/Strom)] */
// Welches Teil soll generiert werden:
Teil="Körper & Deckel"; // ["Körper & Deckel","Körper", "Deckel"]

/* [Balun Gehäuse (Spannung)] */
// Ausendurchmesser:
UDurchmesserAussen=100;

// Höhe:
UHoehe=40;

// Wandstärke.
UDicke=3;

// Buchsenansatz Tiefe:
BuAnTiefe=30;

// Buchsenansatz Breite:
BuAnBreite=30;

// Abgriffe Bohrung-Durchmesser:
AbgBoDurch=5;

// Anzahl-Abgriffe:
AbgAnz=4;

// Abgriffe Start-Winkel:
Deg=90;

// Abgriffe Abstand in Grad:
AbgDeltaDeg=15;

/* [Balun Gehäuse (Strom)] */
// Breite:
IBreite=50;

// Tiefe:
ITiefe=100;

// Höhe:
IHoehe=40;

// Wandstärke.
IDicke=3;

/* [Deckel (Spannung/Strom)] */
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

/* [Anschlußflansch (Spannung/Strom)] */
// Typ des Anschluß Flansches, Norden:
FlanschTypN="UG 58 TG"; // ["UG 58 TG","Hyperflex 5"]

// Typ des Anschluß Flansches, Süden:
FlanschTypS="UG 58 TG"; // ["UG 58 TG","Hyperflex 5"]

/* [Deckel Beschriftung (Spannung/Strom)] */
// Zeile 1: Text:
Text01="Strom-";

// Zeile 1: Größe:
Text01Size=8;

// Zeile 2: Abstand zum oberen Rand:
Text01Space=5;

// Zeile 1: Linker Rand:
Text01LSpace=33;

// Zeile 2: Text:
Text02="Balun";

// Zeile 2: Größe:
Text02Size=8;

// Zeile 2: Abstand zu Zeile 1:
Text02Space=3;

// Zeile 2: Linker Rand:
Text02LSpace=20;

// Zeile 3: Text:
Text03="V0.0";

// Zeile 3: Größe:
Text03Size=8;

// Zeile 3: Abstand zu Zeile 2:
Text03Space=3;

// Zeile 3: Linker Rand:
Text03LSpace=10;

// Zeile 4: Text:
Text04="DB5ZF";

// Zeile 4: Größe:
Text04Size=8;

// Zeile 4: Abstand zu Zeile 3:
Text04Space=3;

// Zeile 4: Linker Rand:
Text04LSpace=5;

// Zeile 5: Text:
Text05="05.12.2023";

// Zeile 5: Größe:
Text05Size=6;

// Zeile 5: Abstand zu Zeile 4:
Text05Space=3;

// Zeile 5: Linker Rand:
Text05LSpace=5;

// Zeile 6: Text:
Text06="FT-114-43 &";

// Zeile 6: Größe:
Text06Size=6;

// Zeile 6: Abstand zu Zeile 5:
Text06Space=3;

// Zeile 6: Linker Rand:
Text06LSpace=5;

// Zeile 7: Text:
Text07="FT-114-77";

// Zeile 7: Größe:
Text07Size=6;

// Zeile 7: Linker Rand:
Text07LSpace=10;

// Zeile 7: Abstand zu Zeile 6:
Text07Space=3;

// Zeile 8: Text:
Text08="in Reihe.";

// Zeile 8: Größe:
Text08Size=6;

// Zeile 8: Abstand zu Zeile 7:
Text08Space=3;

// Zeile 8: Linker Rand:
Text08LSpace=15;


$fn=200;
echo($fn);

//echo($font);
//font="Liberation Sans:style=Bold Italic";



////////////////////////////////////////////////////////////////////////////////////////

Version="R.01.000";

module UGehauseA()
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
		
		// Snapin Rand, Rundung.
		translate([0, 0, UHoehe-DeEiTiefe+(DeSnapDurch/2)+0])
		rotate_extrude(convexity=10)
		translate([(UDurchmesserAussen-(2*DeRand))/2, 0, 0])
		circle(r=(DeSnapDurch/2), $fn=100);
		
		// Snapin Rand, Anschlußbox.
		//translate([IBreite-DeRand, DeRand, IHoehe-DeEiTiefe+(DeSnapDurch/2)])
		//rotate([-90, 0, 0])
		//cylinder(d=DeSnapDurch, h=BuAnTiefe+DeRand, center=false);
		
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
	}
}

module UGehauseB()
{
	//union()
	difference()
	{
		UGehauseA();
		
		// Snapin Rand, Anschlußbox, rechts.
		//translate([(BuAnBreite/2)-UDicke+DeRand, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, IHoehe-DeEiTiefe+(DeSnapDurch/2)])
		translate([(BuAnBreite/2)-DeRand, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, IHoehe-DeEiTiefe+(DeSnapDurch/2)])
		rotate([-90, 0, 0])
		cylinder(d=DeSnapDurch, h=BuAnTiefe+(UDurchmesserAussen/2), center=false);
		
		// Snapin Rand, Anschlußbox, links.
		translate([((BuAnBreite/2)-DeRand)*-1, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, IHoehe-DeEiTiefe+(DeSnapDurch/2)])
		rotate([-90, 0, 0])
		cylinder(d=DeSnapDurch, h=BuAnTiefe+(UDurchmesserAussen/2), center=false);
		
		// Snapin Rand, Anschlußbox, vorne.
		translate([((BuAnBreite/2)-(DeRand/2)-(DeSnapDurch/4))*-1, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, IHoehe-DeEiTiefe+(DeSnapDurch/2)])
		rotate([0, 90, 0])
		cylinder(d=DeSnapDurch, h=BuAnBreite-(2*DeRand)+DeSnapDurch, center=false);
	}
}

module UGehause()
{
	difference()
	//union()
	{
		UGehauseB();
		
		// Hyperflex
		if(FlanschTypS=="Hyperflex 5")
		{
			translate([0, ((UDurchmesserAussen/2)+BuAnTiefe-UDicke-1)*-1, 0]) FlanschBohrung_Hyperflex5();
		}
		
		// N-Flansch
		if(FlanschTypS=="UG 58 TG")
		{
			translate([0, ((UDurchmesserAussen/2)+BuAnTiefe-UDicke-1)*-1, 0]) FlanschBohrung_UG58TG();
		}
	}
}

module UDeckelA()
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
		
		// Snapin Rand Rundung.
		translate([0, 0, DeDicke+DeEiTiefe-(DeSnapDurch/2)])
		rotate_extrude(convexity=10)
		translate([(UDurchmesserAussen-(2*DeRand))/2, 0, 0])
		circle(r=(DeSnapDurch/2), $fn=100);
		
		// Snapin Rand, Anschlußbox, links.
		//translate([((BuAnBreite/2)-UDicke+DeRand)*-1, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, DeDicke+DeEiTiefe-(DeSnapDurch/2)])
		translate([((BuAnBreite/2)-DeRand)*-1, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, DeDicke+DeEiTiefe-(DeSnapDurch/2)])
		rotate([-90, 0, 0])
		cylinder(d=DeSnapDurch, h=BuAnTiefe+(UDurchmesserAussen/2), center=false);
		
		// Snapin Rand, Anschlußbox, rechts.
		translate([((BuAnBreite/2)-DeRand)*1, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, DeDicke+DeEiTiefe-(DeSnapDurch/2)])
		rotate([-90, 0, 0])
		cylinder(d=DeSnapDurch, h=BuAnTiefe+(UDurchmesserAussen/2), center=false);
		
		// Snapin Rand, Anschlußbox, vorne.
		translate([(((BuAnBreite)/2)-DeRand)*-1, ((UDurchmesserAussen/2)+BuAnTiefe-DeRand)*-1, DeDicke+DeEiTiefe-(DeSnapDurch/2)])
		rotate([0, 90, 0])
		cylinder(d=DeSnapDurch, h=BuAnBreite-(2*DeRand), center=false);
	}
}

module UDeckel()
{
	difference()
	{
		UDeckelA();
		
		// Text.
		Font="Liberation Sans:style=Bold";
		// 1. Zeile.
		movY1=(UDurchmesserAussen/2)-Text01Size-Text01Space;
		translate([(UDurchmesserAussen/2)-Text01LSpace, movY1, 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text01, font=Font, size=Text01Size);
		
		// 2. Zeile.
		//Font="Liberation Sans:style=Regular";
		//Font="Liberation Sans:style=Bold";
		//Font="Liberation Serif:style=Bold";
		//Font="Nimbus Sans L:style=Regular Condensed";
		//translate([(UDurchmesserAussen/4)+Text01Size, (UDurchmesserAussen/2)-Text02Space-Text01Size-Text02Size, 2])
		movY2=movY1-Text02Size-Text02Space;
		translate([(UDurchmesserAussen/2)-Text02LSpace, movY2, 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text02, font=Font, size=Text02Size);
		
		// 3. Zeile.
		movY3=movY2-Text03Size-Text03Space;
		translate([(UDurchmesserAussen/2)-Text03LSpace, movY3, 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text03, font=Font, size=Text03Size);
		
		// 4. Zeile.
		movY4=movY3-Text04Size-Text04Space;
		translate([(UDurchmesserAussen/2)-Text04LSpace, movY4, 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text04, font=Font, size=Text04Size);
		
		// 5. Zeile.
		movY5=movY4-Text05Size-Text05Space;
		translate([(UDurchmesserAussen/2)-Text05LSpace, movY5, 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text05, font=Font, size=Text05Size);
		
		// 6. Zeile.
		movY6=movY5-Text06Size-Text06Space;
		translate([(UDurchmesserAussen/2)-Text06LSpace, movY6, 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text06, font=Font, size=Text06Size);
		
		// 7. Zeile.
		movY7=movY6-Text07Size-Text07Space;
		translate([(UDurchmesserAussen/2)-Text07LSpace, movY7, 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text07, font=Font, size=Text07Size);
		
		// 8. Zeile.
		movY8=movY7-Text08Size-Text08Space;
		translate([(UDurchmesserAussen/2)-Text08LSpace, movY8, 2])
		rotate([0, 180, 0])
		linear_extrude(4)
		text(text=Text08, font=Font, size=Text08Size);
	}
}

module IGehauseA()
{
	//union()
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

module IGehause()
{
	difference()
	//union()
	{
		IGehauseA();
		
		// Hyperflex
		if(FlanschTypN=="Hyperflex 5")
		{
			translate([IBreite/2, ITiefe+1, 0]) FlanschBohrung_Hyperflex5();
		}
		
		if(FlanschTypS=="Hyperflex 5")
		{
			translate([IBreite/2, (IDicke/1)+1, 0]) FlanschBohrung_Hyperflex5();
		}
		
		// N-Flansch
		if(FlanschTypN=="UG 58 TG")
		{
			translate([IBreite/2, ITiefe+1, 0]) FlanschBohrung_UG58TG();
		}
		
		if(FlanschTypS=="UG 58 TG")
		{
			translate([IBreite/2, (IDicke/1)+1, 0]) FlanschBohrung_UG58TG();
		}
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


module FlanschBohrung_Hyperflex5()
{
	MitteDurchm=5.5;
	BefAbst=18.3;
	
	// Mittel-Durchbruch.
	translate([0, 0, IHoehe/2])
	rotate([90, 0, 0])
	cylinder(d=MitteDurchm, h=IDicke+2, center=false);
}

module FlanschBohrung_UG58TG()
{
	MitteDurchm=10;
	BefDurchm=3;
	BefAbst=18.3;
	
	// Mittel-Durchbruch.
	translate([0, 0, IHoehe/2])
	rotate([90, 0, 0])
	cylinder(d=MitteDurchm, h=IDicke+2, center=false);
	
	// Befestigung oben-links.
	translate([0-(BefAbst/2), 0, (IHoehe/2)+(BefAbst/2)])
	rotate([90, 0, 0])
	cylinder(d=BefDurchm, h=IDicke+2, center=false);
	
	// Befestigung oben-rechts.
	translate([0+(BefAbst/2), 0, (IHoehe/2)+(BefAbst/2)])
	rotate([90, 0, 0])
	cylinder(d=BefDurchm, h=IDicke+2, center=false);
	
	// Befestigung unten-links.
	translate([0-(BefAbst/2), 0, (IHoehe/2)-(BefAbst/2)])
	rotate([90, 0, 0])
	cylinder(d=BefDurchm, h=IDicke+2, center=false);
	
	// Befestigung unten-rechts.
	translate([0+(BefAbst/2), 0, (IHoehe/2)-(BefAbst/2)])
	rotate([90, 0, 0])
	cylinder(d=BefDurchm, h=IDicke+2, center=false);
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


