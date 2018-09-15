with open('/etc/selinux/config', 'r') as f:
    original_config = f.readlines()

with open('/etc/selinux/config', 'w') as f:
    for line in original_config:
        line = line.replace('enforcing', 'permissive')
        f.write(line)