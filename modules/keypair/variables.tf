variable "keyname"{
    description = "aws keypair name"
    default = "jm_bastion_key"
}

variable "private_key_path"{
    description = "path to write private keyfile"
    default = "./bastion_private.pem"
}

variable "public_key_path"{
    description = "path to write public keyfile"
    default = "./bastion_public"
}

variable "key_alg"{
    description = "algorithm for keypair"
    default = "ED25519"
}