mkdir -p cachegrind
scp -C -i ~/.vagrant.d/insecure_private_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@192.168.33.30:~/cachegrind/* cachegrind/
