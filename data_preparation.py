# global imports
import pandas as pd
import os


# specify path to working directory
wd = '/path/to/wd'

# specify path to csv file with demographic and imaging information
pth = os.path.join(wd, '

origdata = pd.read_csv(pth)

# filter data by quality rating
filter_quality = origdata['Noise']<0.3

filter_asddata = origdata['Group']=='ASD'
asddata = origdata[filter_asddata]
asd_subjects = asddata['ID']

filter_tdcdata = origdata['Group']=='CONTROL'
tdcdata = origdata[filter_tdcdata]
tdc_subjects = tdcdata['ID']

all_subjects = origdata['ID']

asd_cases = []
tdc_cases = []
all_cases = []

for subject in asd_subjects:
    asd_cases.append(str(subject))
for subject in tdc_subjects:
    tdc_cases.append(str(subject))
for subject in all_subjects:
    all_cases.append(str(subject))
