int nTasks=...;
int nThreads=...;
int nCPUs=...;
int nCores=...;
range T=1..nTasks;
range H=1..nThreads;
range C=1..nCPUs;
range K=1..nCores;
float rh[h in H]=...;
float rc[k in K]=...;
int CK[c in C, k in K]=...;
int TH[t in T, h in H]=...;



dvar boolean x_tc[t in T, c in C]; //binary dvar
dvar boolean x_hk[h in H, k in K]; //binary dvar
dvar float+ z;


// Objective
minimize z;
subject to{
	
    // Constraint 1
	forall(h in H)
		sum(k in K) x_hk[h,k] == 1;
	
    // Constraint 2
	forall(c in C, t in T)
		sum(h in H, k in K) x_hk[h,k]*TH[t,h]*CK[c,k] == sum(h in H)TH[t,h]*x_tc[t,c];

    // Constraint 3
	forall(c in C, k in K)
		sum(h in H)rh[h]*x_hk[h,k]* CK[c,k] <= rc[c] * CK[c,k];

    // Constraint 4
	forall(c in C)
		z >= (1/(sum(k in K)CK[c,k]*rc[c])) * sum(h in H, k in K)rh[h]*x_hk[h,k]*CK[c,k];

}
