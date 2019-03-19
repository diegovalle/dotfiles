# SSH setup

## Generate keys:

for _ed25519_ (newer with better security)

``` bash
ssh-keygen -t ed25519  -a 100 -C "diegovalle.net" -f ~/.ssh/id_ed25519_{{ hostname }}
```
or for _RSA_ (compatible with older clients)

``` bash
ssh-keygen -b 4096 -f .ssh/id_rsa_{{ hostname }} -C "diegovalle.net"
```

## Copy local public key to server

``` bash
ssh-copy-id -i ~/.ssh/id_rsa.pub user@x.x.x.x
```

## .ssh permission

Should be chmod 600 for the files and chmod 0700 for the .ssh directory

``` bash
drwx------ 204 diego diego 49152 Mar 16 20:21 ../
-rw-------   1 diego diego  2104 Mar 16 20:08 config
-rw-------   1 diego diego  1675 Mar 14 12:47 id_rsa
-rw-------   1 diego diego   396 Mar  9 19:39 id_rsa.pub
```


## Edit a remote file with emacs

``` bash
C-x C-f /ssh:diego@hostname:/var/www/hostname/index.html
```

## config example

```
ServerAliveInterval 120

Host *
     # Always use SSH2.
     Protocol 2
     Compression yes
     StrictHostKeyChecking ask
     UseRoaming no
     AddKeysToAgent yes
     IdentitiesOnly yes

Host github.com
     HostName github.com
     User git
     AddKeysToAgent yes
     IdentityFile ~/.ssh/id_ed25519_github

Host bitbucket.org
     HostName bitbucket.org
     User git
     AddKeysToAgent yes
     IdentityFile ~/.ssh/id_ed25519_bitbucket

Host gitlab.com
     HostName gitlab.com
     User git
     AddKeysToAgent yes
     IdentityFile ~/.ssh/id_ed25519_gitlab

Host socks1
     Hostname x.x.x.x
     User diego
     AddKeysToAgent yes
     IdentitiesOnly yes
     DynamicForward 8123
     RequestTTY no
     IdentityFile ~/.ssh/vps1

Host socks2
     Hostname x.x.x.x
     User diego
     AddKeysToAgent yes
     IdentitiesOnly yes
     DynamicForward 8123
     RequestTTY no
     IdentityFile ~/.ssh/vps2

VisualHostKey=yes
# Ensure KnownHosts are unreadable if leaked
HashKnownHosts yes
# https://infosec.mozilla.org/guidelines/openssh.html
HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa,ecdsa-sha2-nistp521-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp521,ecdsa-sha2-nistp384,ecdsa-sha2-nistp256

# These can be removed gor compatibility (but less security)
KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr

```
