This project is to create Virtual machines for k8s cluster on AWS with ansible and terraform.
You can create the VMs required for https://github.com/git-ogawa/setup_kube_cluster.


# Requirements

The following required to use the project.

- ansible: Install with `pip install ansible`.
- ansible collections:
    - community.general: Install with `ansible-galaxy collection install community.general`.
    - amazon.aws: Install with `ansible-galaxy collection install amazon.aws`.
- python modules
    - boto3 : `pip install boto3`
- terraform: See [terraform website](https://developer.hashicorp.com/terraform/install?product_intent=terraform#Linux) for installation.


# Prerequisite

## Create Inventory

Settings for the project are set in ansible inventory `inventory.yml`. Before running the playbook, Set the required variables in the inventory. The settings are dynamically applied to terraform `main.tf`.
See the [examples/inventory.yml](examples/inventory.yml) for the example.

### AWS credentials

You need to create IAM user to create AWS resources. Generate access key and secret access key of the user and set them in inventory.yml.

```yml
all:
  vars:
    access_key: xxx
    secret_key: xxx
    region: ap-northeast-1
```

Also set credentials in `~/.aws/config` and `~/aws/.credentials` for ansible aws module.
```
$ cat ~/.aws/config
[default]
region = ap-northeast-1


$ cat ~/.aws/config
[default]
aws_access_key_id = xxx
aws_secret_access_key = xxx
```

IAM user must have an permission to create and delete EC2 resources such as `AmazonEC2FullAccess`.


### SSH keypair

You also need to create ssh keypair in AWS to log in to instances.
Set keypair name to `key_name`


```yml
all:
  vars:
    key_name: my-keypair-name
```

### Subnet CIDR

A subnet for the project is created in the default VPC.
Set the CIDR of the subnet to `subnet_cidr`. This range must not be overlapping with the other existing subnets.
```yml
all:
  vars:
    subnet_cidr: "10.0.128.0/20"
```

### VM specification

Set vcpu and memory (GiB) for each VM.
An instance type that satisfies this condition is automatically selected for the instances.

```yml
all:
  vars:
    memory: 4 # This means 4 GIb
    vcpu: 2
```

### Nodes for control plane and worker

You can set hostname and OS of the nodes for control plane and worker.
If you want to create more than one node, add more node definitions in the same way.
In the following example, three instances will be created: one for control-plane and two for worker nodes.
```yml
  control_plane:
      - hostname: master-1
        os: ubuntu-22.04-amd64
    workers:
      - hostname: worker-1
        os: ubuntu-23.04-amd64
      - hostname: worker-2
        os: rockylinux-9.2-amd64
```

The supported OS is the following. Set variable name to `os` field.

| OS | Architecture | variable name |
| - | - | - |
| Ubuntu 22.04 | amd64 | ubuntu-22.04-amd64 |
| Ubuntu 23.04 | amd64 | ubuntu-23.04-amd64 |
| Rockylinux 9.2 | amd64 | rockylinux-9.2-amd64 |
| Rockylinux 9.3 | amd64 | rockylinux-9.3-amd64 |



# Usage

## Create VMs

Run `create.yml` to create the resources.

```
$ ansible-playbook create.yml
```

The playbook runs `terraform apply` to the instances and the associated resources on AWS.

The inventory `template_inventory.yml` is created after successfully finished.
In the inventory, the public ip address and private ip address of the created nodes are listed.
```yml
    control_plane:
      hosts:
        master-1:
          ansible_host: 13.231.23.196
          internal_ipv4: 172.31.140.177
    worker:
      hosts:
        worker-1:
          ansible_host: 13.230.50.154
          internal_ipv4: 172.31.137.198
        worker-2:
          ansible_host: 13.114.103.197
          internal_ipv4: 172.31.142.211
```

This inventory can be used directly for https://github.com/git-ogawa/setup_kube_cluster.


## Delete

Run `delete.yml`.

```
$ ansible-playbook delete.yml
```

The playback runs `terraform destroy` to remove the all resources.

