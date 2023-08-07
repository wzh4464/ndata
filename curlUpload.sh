#bash

# curl to upload
# https://dav.jianguoyun.com/dav/dataset
# account: `zihanwu7@icloud.com`
# password: `agv5ea83j27scqr3`

# upload file `main.py` to `dataset` folder
# curl -T main.py -u zihanwu7@icloud.com:agv5ea83j27scqr3 https://dav.jianguoyun.com/dav/dataset/main.py

curl -T $1 -u zihanwu7@icloud.com:agv5ea83j27scqr3 https://dav.jianguoyun.com/dav/dataset/