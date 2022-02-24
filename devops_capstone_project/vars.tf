variable "AWS_ACCESS_KEY" {
  type = string
  default = "ASIA5ROHSDOADKV57ZFR"
}

variable "AWS_SECRET_KEY" {
  type = string
  default = "/ypAa7IbUF1lCHfe31VrUB1Id5WjPiMigq5u+6/l"
}

variable "AWS_TOKEN" {
  type = string
  default = "FwoGZXIvYXdzED0aDLBqKKC0PnrwFct/0SK8Ace0qd4PotE9vpF6Mn5q9/gcMlRfK7rvJDu6LuTFu0UnFRZOz78gzbmA6PE3pzo/OlasgGuqxfP2ahrx5jhTxKda/DeWxXjjmRY7DSxc2aSQyDuH0Lev1Ad6iKi+/4zwmIOtB06T75G66JcT9mpiuskRX6+ItUDZ7O5uFwACUmxGOdZQsGvSw6M0OBSg2u6zfaSkstuH4lIIZvZYmgO/DRCL+a3bFZWWuPEY83wS9Jxmrc6VYcB9s29/qIlRKL2D3JAGMi0V0PbCc/WHomRL3IkYsV34pKVcrtMoXzMU1uvIFNcGbB+FAI+pN4xATGorqX0="
}

variable "AWS_REGION" {
  type = string
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-04505e74c0741db8d"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-0d729a60"
    
  }

}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

