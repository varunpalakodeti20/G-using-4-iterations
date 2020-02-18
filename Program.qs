namespace Quantum.QSharpApplication12 
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation Oracle0 () : Unit 
    {
        mutable oracle = 0;
        mutable other = 0;
        using (q = Qubit[6])
        {
            let cqoracle = [q[0],q[1],q[2],q[3],q[4]];
            let cqiomean = [q[0],q[1],q[2],q[3]];
            for(i in 1..100)
            {
                //|-> (Ket '-')
                X(q[5]);

                //Uniform Super Position
                H(q[0]);
                H(q[1]);
                H(q[2]);
                H(q[3]);
                H(q[4]);
                H(q[5]);

                for(g in 1..4)
                {
                    //Oracle
                    X(q[0]);
                    X(q[1]);
                    X(q[2]);
                    X(q[3]);
                    X(q[4]);
                    
                    //
                    Controlled X(cqoracle,q[5]);

                    //
                    X(q[0]);
                    X(q[1]);
                    X(q[2]);
                    X(q[3]);
                    X(q[4]);
                    
                    //Uniform Super Position
                    H(q[0]);
                    H(q[1]);
                    H(q[2]);
                    H(q[3]);
                    H(q[4]);
   
                    X(q[0]);
                    X(q[1]);
                    X(q[2]);
                    X(q[3]);
                    X(q[4]);
   
                    //
                    H(q[4]);
                  
                    Controlled X(cqiomean,q[4]);
                    
                    H(q[4]);
 
                    X(q[0]);
                    X(q[1]);
                    X(q[2]);
                    X(q[3]);
                    X(q[4]);

                    H(q[0]);
                    H(q[1]);
                    H(q[2]);
                    H(q[3]);
                    H(q[4]);        
                }

                let q1 = M(q[0]);
                let q2 = M(q[1]);
                let q3 = M(q[2]);
                let q4 = M(q[3]);
                let q5 = M(q[4]);
                
                ResetAll(q);
                if(q1 == Zero and q2 ==Zero and q3 == Zero and q4 == Zero and q5 == Zero)
                {
                    set oracle = oracle + 1;        
				}
                else 
                {
                    set other = other + 1;        
				}
                
			}
            Message($"State 00 -> {oracle}");
            Message($"other ----> {other}");
		}
    }
}