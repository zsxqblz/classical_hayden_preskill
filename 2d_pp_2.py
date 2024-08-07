import numpy as np
from tqdm import tqdm
import os.path

for file_idx in range(41,61):

    job_arr_start = 0
    job_arr_end = 9
    job_arr_step = 1
    job_arr_l = np.arange(job_arr_start,job_arr_end+1,job_arr_step)

    cnt = 0

    for job_id in tqdm(job_arr_l):
        job_name = "data/240405/240405_n%d_%d"%(job_id,file_idx)
        if os.path.isfile(job_name+"_scanx.csv") == False:
            print(job_id)
            continue

        if cnt == 0:
            x_l = np.loadtxt(job_name+"_scanx.csv",skiprows=1,delimiter=",")
            y_l = np.loadtxt(job_name+"_scany.csv",skiprows=1,delimiter=",")
            data_raw =  np.loadtxt(job_name+"_data.csv",skiprows=1,delimiter=",")
            x_length = len(x_l)
            y_length = len(y_l)
            # y_length = 1
            data_ave_l = data_raw[:,0].reshape((y_length,x_length))
            data_snd_l = data_raw[:,1].reshape((y_length,x_length))
            data_trd_l = data_raw[:,2].reshape((y_length,x_length))
            data_fth_l = data_raw[:,3].reshape((y_length,x_length))
            # data_ave_l = data_raw[:,0].reshape((y_length,x_length))
            # data_std_l = data_raw[:,1].reshape((y_length,x_length))

        else:
            data_raw =  np.loadtxt(job_name+"_data.csv",skiprows=1,delimiter=",")
            data_ave_l = data_ave_l + data_raw[:,0].reshape((y_length,x_length))
            data_snd_l = data_snd_l + data_raw[:,1].reshape((y_length,x_length))
            data_trd_l = data_trd_l + data_raw[:,2].reshape((y_length,x_length))
            data_fth_l = data_fth_l + data_raw[:,3].reshape((y_length,x_length))
            # data_ave_l = data_ave_l + data_raw[:,0].reshape((y_length,x_length))
            # data_std_l = data_std_l + data_raw[:,1].reshape((y_length,x_length))

        cnt = cnt + 1

    data_ave_l = data_ave_l / cnt
    data_snd_l = data_snd_l / cnt
    data_trd_l = data_trd_l / cnt
    data_fth_l = data_fth_l / cnt
    # data_std_l = data_std_l / cnt

    np.savez("data/240405/240405_n%d_"%(file_idx)+"pp.npz",
        x_l=x_l,
        y_l=y_l,
        data_ave_l=data_ave_l,
        data_snd_l=data_snd_l,
        data_trd_l=data_trd_l,
        data_fth_l=data_fth_l
        # data_std_l=data_std_l
    )