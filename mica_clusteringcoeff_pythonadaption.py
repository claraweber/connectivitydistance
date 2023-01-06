def RandomizeClust(data, thr):
    """
    Props to Sara for original function!!
    Python adaption Clara 2022
    """
    R = bct.threshold_proportional(data, thr)
    Topo = R
    Topo[Topo != 0] =1
    N = len(Topo)
    K = (Topo.sum(axis=1).sum(axis=0))/2
    if K == N*(N-1)/2:
        # matrix is fully connected
        print('Whoopsie - graph fully connected. Use Gretna random 2')
        #R = gretnapy_gen_random_network2_weight(R)
    else:
        # matrix is not fully connected
        R = gretnapy_gen_random_network1_weight(R)
    cG, G = gretnapy_node_clustcoeff_weight(R)
    return(cG, G)

def gretnapy_node_clustcoeff_weight(W, a = 'barrat'):
    """
    Python adaption of gretna code
    Original MATLAB by Jinhui Wang 2011
    
    Inputs:
    W: weighetd adjacency matrix
    a = barrat / based on Barrat et al 1009 The aarchitecture of complex weighted networks
    
    Outputs 
    avercc = average clustering coefficient of all nodes in the graph G
    cci = clustering coefficiency of each node in the graph G
    
    2022
    """
    
    if a == 'barrat':
        A = W
        N = len(A)
        cci = np.empty(shape=(N,1))*0
        
        for i in range(N):
            NV = np.where(A[i,:])
            if len(NV) ==1 or not NV:
                cci[i]=0
            else:
                nei = A[NV,NV]
                X, Y = np.where(nei)
                cci[i] = np.array([A[i,NV[X]], A[i,NV[Y]]]).sum()/2/((len(NV)-1)*A[i,:].sum())
        avercc = np.mean(cci, axis =0)
    
    elif a =='onnela':
        print('didnt implement this one yet sorry')
        
    else:
        print('wrong algorithm mate')
    return(avercc, cci[0])

def gretnapy_gen_random_network1_weight(W):
    """
    Python adaption of MATLAB gretna_gen_random_network1_weight
    by Yong He and Jinhui Wang 2007/2011, Jinhui/Wang.1982@gmail.com
    Based on Maslov et al. 2022 / generationg a random network wirh same N K and degree
    distribution as a real weighted network H using Maslovs wiring algorithm
    2022
    
    Input:
    W: adjacency matrix (N*N symmetric)
    
    Output:
    Wrand: generated random weighted network
    """
    
    W = W - np.diag(np.diag(W))
    Wrand = W
    Topo = W
    Topo[Topo!=0]=1
    
    N = len(Topo)
    K = Topo.sum(axis=1).sum(axis=0)/2
    
    if K ==N*(N-1)/2:
        print('Matrix is fully connected - use gretna_gen_random_network2!')
    else:
        nrew = 0
        
        i1, j1 = np.where(Topo!=0)
        aux = np.where(i1>j1)
        
        i1 = i1[aux]
        j1 = j1[aux]
        Ne = len(i1)
        
        ntry = 2*Ne
        
        for i in range(ntry):
            # randomly select two links by index
            e1 = np.random.randint(0, Ne)
            e2 = np.random.randint(0, Ne)
            v1 = i1[e1]
            v2 = j1[e1]
            v3 = i1[e2]
            v4 = j1[e2]
            
            if v1!=v3 and v1!=v4 and v2!=v4 and v2!=v3:
                if np.random.rand() > 0.5:
                    if Topo[v1][v3]==0 and Topo[v2][v4]==0:
                        Topo[v1][v2]=0
                        Topo[v3][v4]=0
                        Topo[v2][v1]=0
                        Topo[v4][v3]=0
                        Topo[v1][v3]=1
                        Topo[v2][v4]=1
                        Topo[v3][v1]=1
                        Topo[v4][v2]=1
                        
                        Wrand[v1][v3] = Wrand[v1][v2]
                        Wrand[v2][v4] = Wrand[v3][v4]
                        Wrand[v3][v1] = Wrand[v2][v1]
                        Wrand[v4][v2] = Wrand[v4][v3]
                        
                        Wrand[v1][v2] = 0
                        Wrand[v3][v4] = 0
                        Wrand[v2][v1] = 0
                        Wrand[v4][v3] = 0
                        
                        nrew = nrew+1
                        
                        i1[e1] = v1
                        j1[e1] = v3
                        i1[e2] = v2
                        j1[e2] = v4
                else:
                    v5 = v3
                    v3 = v4
                    v4 = v5
                    del v5
                    
                    if Topo[v1][v3] and Topo[v2][v4]==0:
                        Topo[v1][v2]=0
                        Topo[v3][v4]=0
                        Topo[v2][v1]=0
                        Topo[v4][v3]=0
                        Topo[v1][v3]=1
                        Topo[v2][v4]=1
                        Topo[v3][v1]=1
                        Topo[v4][v2]=1
                        
                        Wrand[v1][v3] = Wrand[v1][v2]
                        Wrand[v2][v4] = Wrand[v3][v4]
                        Wrand[v3][v1] = Wrand[v2][v1]
                        Wrand[v4][v2] = Wrand[v4][v3]
                        
                        Wrand[v1][v2] = 0
                        Wrand[v3][v4] = 0
                        Wrand[v2][v1] = 0
                        Wrand[v4][v3] = 0
                        
                        nrew = nrew+1
                        
                        i1[e1] = v1
                        j1[e1] = v3
                        i1[e2] = v2
                        j1[e2] = v4
    return (Wrand)
