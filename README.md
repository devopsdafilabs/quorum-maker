# Quorum Maker Setup Guide

---

## 1. Install Docker & Docker Compose

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

---

## 2. Start Docker

```bash
sudo systemctl enable --now docker
```

---

## 3. Run as Non-root (Optional)

```bash
sudo usermod -aG docker $USER && newgrp docker
```

---

## 4. Test Installation

```bash
docker run hello-world
```

This installs Docker, enables it, and verifies the installation with a test.

---

## 5. Cloning the Quorum Maker Repository

1. **Navigate to Your Working Directory**:

    ```bash
    cd /BLOCKCHAIN_MONITORING
    ```

2. **Clone the Repository**:

    ```bash
    git clone git@github.com:blockchainbsdev/quorum-maker.git
    ```

3. **Verify the Cloning**:

    ```bash
    ls
    ```

   You should see a `quorum-maker` directory listed.

---

## 6. Setting Up Permissions

Ensure that the setup script has the necessary execution permissions.

1. **Navigate to the Quorum Maker Directory**:

    ```bash
    cd /BLOCKCHAIN_MONITORING/quorum-maker
    ```

2. **Make `setup.sh` Executable**:

    ```bash
    sudo chmod +x setup.sh
    ```

3. **Confirm Permission Change**:

    ```bash
    ls -l setup.sh
    ```

   *Expected Output Example:*

    ```
    -rwxr-xr-x 1 root root 4450 Oct 10 07:50 setup.sh
    ```

---

## 7. Modifying the `setup.sh` Script

To ensure that the setup script correctly locates the `qm.variables` file, modify the script as follows:

1. **Open `setup.sh` in a Text Editor**:

    ```bash
    nano setup.sh
    ```

2. **Locate the Sourcing Section**:

   Find the following lines:

    ```bash
    # Check if qm.variables exists and source it
    if [ -f /quorum-maker/qm.variables ]; then
        echo "Sourcing qm.variables..."
        source /quorum-maker/qm.variables
    else
        echo "Error: qm.variables not found"
        exit 1
    fi
    ```

3. **Modify to Use Current Directory Path**:

    ```bash
    # Check if qm.variables exists and source it
    if [ -f $(pwd)/qm.variables ]; then
        echo "Sourcing qm.variables..."
        source $(pwd)/qm.variables
    else
        echo "Error: qm.variables not found"
        exit 1
    fi
    ```

4. **Save and Exit**:
   - Press `Ctrl + O` to save.
   - Press `Ctrl + X` to exit the editor.

---

## 8. Running the Setup Script

Now, you are ready to run the setup script to configure Quorum Maker.

1. **Execute the Setup Script**:

    ```bash
    ./setup.sh
    ```

2. **Observe the Output**:

   You should see a menu with options:

    ```
       ______   __      __
      / ____ \ |  \    /  |
     / /    \ \|   \  /   |
     | |     | |    \/    |
     | |     | | |\    /| |
     | |     |  \| \  / | |
     \ \____/ /\ \  \/  | |
      \______/  \_\     |_|  Version 2.6.5 Built on Quorum 2.6.0
    
    Please select an option:
     1) Create Network
     2) Join Network
     3) Attach to an existing Node
     4) Setup Development/Test Network
     5) Exit
    ```

---

## 9. Attaching to an Existing Node

Since you already have a private blockchain set up, choose to attach Quorum Maker to your existing node.

1. **Choose Option 3**:
   - Type `3` and press **Enter**.

    ```
    option: 3
    ```

2. **Provide Node Details**:
   - **Node Name**: Enter a meaningful name (e.g., `Oneblock_Bootnode`).
   - **IP Address of Geth**: Enter the external IP address of your existing Geth node (e.g., `34.128.98.216`).
   - **Public Key of Constellation**: Enter the Constellation public key you retrieved earlier (e.g., `BULeR8JyUWhiuuCMU/HLA0Q5pzkYT+cHII3ZKBey3Bo=`).
   - **RPC Port of Geth**: Enter `8545`.
   - **Network Listening Port of Geth**: Press **Enter** to accept the default `8546`.
   - **Constellation Port**: Press **Enter** to accept the default `8547`.
   - **Raft Port**: Enter `50400`.

---

## 10. Restarting the Node

If you need to restart the node after it stops, follow these steps:

1. **Navigate to Your Repository Directory**:  
   Go to the directory containing the folder named after your node:

   ```bash
   cd /path/to/your/repo/<node_folder_name>
   ```

2. **List the Files**:  
   Use the `ls` command to list the files in the directory:

   ```bash
   ls
   ```

3. **Start the Script**:  
   Run the script to start the node again:

   ```bash
   ./start_script.sh
   ```

   Replace `./start_script.sh` with the appropriate script name if it differs.

   Make sure to replace `<node_folder_name>` with the actual name of the folder you assigned to your node.

---

## Additional Information

### Access the NodeManager UI

Replace `<your_machine_external_ip>` and `<NodeManager_port>` with your actual values. For example:

```
http://<your_machine_external_ip>:<NodeManager_port>
```

**Example:**  
```
http://34.101.221.93:50401
```

---

### Change the Logo

To change the Quorum Maker logo, follow these steps:

1. **Navigate to the images directory**:

    ```bash
    sudo cd /var/lib/docker/overlay2/7e614c780c834fda58047806f091356fff27a8dba5cf9b12968756dbb2b62e83/diff/root/quorum-maker/NodeManagerUI/qm/assets/images
    ```

2. **Replace the `quorum-maker.svg` file**:

   - Upload your custom logo file to this directory.
   - Delete the original `quorum-maker.svg` file.
   - Rename your custom logo file to `quorum-maker.svg`.

   This will update the logo in the NodeManager UI with your custom version.

---
