dvar float+ Gas;
dvar float+ Chloride;

maximize 
    40 + Gas + 50 * Chloride;

subject to {
    availability_N: Gas + Chloride <= 50;
    availability_H: 3 * Gas + 4 * Chloride <= 180;
    availability_Cl: Chloride <= 40;
}

