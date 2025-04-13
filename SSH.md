# Set up SSH

## Moving SSH to a New MacBook

1. **Create the `.ssh` directory**  
   On your new MacBook, open a terminal and run:
   ```zsh
   mkdir ~/.ssh
   ```

2. **Copy the public and private keys from the old PC**  
   Transfer your SSH keys (`id_rsa` and `id_rsa.pub`) from the old PC to the new MacBook. You can use a USB drive, email, or a secure file transfer method like `scp`. Place the files in the `~/.ssh` directory on the new MacBook.

3. **Set up permissions**  
   Ensure the correct permissions for the SSH keys:
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/id_rsa
   chmod 644 ~/.ssh/id_rsa.pub
   ```
   This ensures your private key is secure and readable only by you.

## Permissions

Permission is composed of three parts:

File permissions in Unix-like systems are represented by three digits, such as `777`, `700`, or `600`. Each digit represents a set of permissions for three categories of users:

1. **Owner**: The user who owns the file.
2. **Group**: Other users in the same group as the file owner.
3. **Others**: All other users.

Each digit is a sum of the following permission values:
- `4` = Read (`r`)
- `2` = Write (`w`)
- `1` = Execute (`x`)

### Examples:
- **`777`**: Full permissions for everyone.
  - Owner: Read, Write, Execute
  - Group: Read, Write, Execute
  - Others: Read, Write, Execute

- **`700`**: Full permissions for the owner, no permissions for others.
  - Owner: Read, Write, Execute
  - Group: No permissions
  - Others: No permissions

- **`600`**: Read and write permissions for the owner, no permissions for others.
  - Owner: Read, Write
  - Group: No permissions
  - Others: No permissions

### How to Set Permissions:
You can use the `chmod` command to set file permissions. For example:
```bash
chmod 777 filename
chmod 700 filename
chmod 600 filename