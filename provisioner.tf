resource "null_resource" "ansible_provisioning" {
  provisioner "local-exec" {
    command = <<EOF

az vm wait -g rmqRG -n rabbitmq-node1 --created
az vm wait -g rmqRG -n rabbitmq-node2 --created
az vm wait -g rmqRG -n rabbitmq-node3 --created

/bin/bash inventory/inventory_setup.sh

ansible-playbook  install.yaml > stdout/play.stdout

EOF
  }
}
