import pandas as pd
import numpy as np
import os


def create_zscoretable(inmatrix, name):
    # inmatrix has shape len(casenumber) x n(vertices)
    
    asd_table = np.empty(shape=(103,20484))
    tdc_table = np.empty(shape=(108,20484))
    asdcount = 0 
    tdccount = 0
    
    origdata = pd.read_csv('abide_func_fn_abideI.csv')
    filter_quality = origdata['Func_MeanFD'] <=0.3
    origdata = origdata[filter_quality]
    
    # divide data table in asd vs controls
    for i, group in enumerate(origdata.Group):
        if group == 'ASD':
            for j in range(20484):
                asd_table[asdcount][j]=inmatrix[i][j]
            asdcount +=1
        elif group == 'CONTROL':
            for j in range(20484):
                tdc_table[tdccount][j]=inmatrix[i][j]
            tdccount +=1
            
    # build dataframes for zscores and means for asd and controls separately
    columns_asd = ['vertex', 'mean_TDC', 'std_TDC']
    columns_con = ['vertex', 'mean_TDC', 'std_TDC']
    zscores = pd.DataFrame([], columns = columns_asd)
    means = pd.DataFrame([], columns = columns_asd)
    zscores_controls = pd.DataFrame([], columns = columns_con)
    means_controls = pd.DataFrame([], columns = columns_con)
    
    # determine mean and std for later zscoring based on control group only
    mean_con= np.mean(tdc_table, axis =0)
    std_con= np.std(tdc_table, axis =0)
    
    filter_asddata = origdata['Group']=='ASD'
    asddata = origdata[filter_asddata]
    asd_subjects = asddata['ID']
    asd_cases = []
    for subject in asd_subjects:
        columns_asd.append(str(subject))
        asd_cases.append(str(subject))
        
    filter_tdcdata = origdata['Group']=='CONTROL'
    tdcdata = origdata[filter_tdcdata]
    tdc_subjects = tdcdata['ID']
    tdc_cases = []
    for subject in tdc_subjects:
        columns_con.append(str(subject))
        tdc_cases.append(str(subject))
    
    for vertex in range(20484):
        line_z = [] 
        line_m = []
        line_z_controls = []
        line_m_controls = []
        mean_con_vrtx = mean_con[vertex]
        std_con_vrtx = std_con[vertex]
        for k in [vertex, mean_con_vrtx,std_con_vrtx]:
            line_z.append(k)
            line_m.append(k)
            line_z_controls.append(k)
            line_m_controls.append(k)

        for i, case in enumerate(asd_cases):
            case_value = asd_table[i][vertex]
            z = (case_value-mean_con_vrtx)/std_con_vrtx
            line_z.append(z)
            line_m.append(case_value)

        zscores = zscores.append(pd.DataFrame([line_z], columns = columns_asd))
        means = means.append(pd.DataFrame([line_m], columns = columns_asd))
        
        for i, case in enumerate(tdc_cases):
            case_value = tdc_table[i][vertex]
            z = (case_value-mean_con_vrtx)/std_con_vrtx
            line_z_controls.append(z)
            line_m_controls.append(case_value)

        zscores_controls = zscores_controls.append(pd.DataFrame([line_z_controls], columns = columns_con))
        means_controls = means_controls.append(pd.DataFrame([line_m_controls], columns = columns_con))
    pth = '/Users/root'
    opth_zscores = os.path.join(pth, f'{name}_zscores_asd2control.csv')
    opth_means = os.path.join(pth, f'{name}_means_asd.csv')
    opth_zscores_controls = os.path.join(pth, f'{name}_zscores_con2control.csv')
    opth_means_controls = os.path.join(pth, f'{name}_means_con.csv')
    
    zscores.to_csv(opth_zscores)
    print('Saving zscores for ASD with length', len(zscores), 'to ', opth_zscores)
    means.to_csv(opth_means)
    print('Saving means for ASD with length', len(means), 'to ', opth_means)
    zscores_controls.to_csv(opth_zscores_controls)
    print('Saving zscores for Controls with length', len(zscores_controls), 'to ', opth_zscores_controls)
    means_controls.to_csv(opth_means_controls)
    print('Saving means for Controls with length', len(means_controls), 'to ', opth_means_controls)
