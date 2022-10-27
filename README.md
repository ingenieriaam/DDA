# DDA
Advanced Digital Design course material

## Tools

See the instructions for the makefile in the __verilog_test/sim_support__ folder for the use of these tools once installed.
To generate folder structures, see the __make_folder__ file.
___

### <img src="https://terostechnology.github.io/terosHDLdoc/_static/logo.png" alt="drawing" width="30"/> Teros HDL: IDE

> Open source IDE for HDL devlopers with functionalities commonly used by software developers.

>https://terostechnology.github.io/terosHDLdoc/

### <img src="https://wikiimg.tojsiabtv.com/wikipedia/en/thumb/0/00/XilinxVivado_Logo.jpg/440px-XilinxVivado_Logo.jpg" alt="drawing" width="70"/> : Synthesis and implementation 
> It is reserved for synthesis and implementation since the workflow and time invested are cumbersome for its use.

### <img src="https://upload.wikimedia.org/wikipedia/en/c/cb/Icarus_Verilog_logo2.png" alt="drawing" width="50"/> : Verilog synthesis & simulation
> RTL level test compatible with Teros HDL

> http://iverilog.icarus.com/

### <img src="https://www.cocotb.org/assets/img/cocotb-logo.svg" alt="drawing" width="50"/> : Verilog synthesis & simulation using python
> It allows to generate simulations with python in a very high level

> https://docs.cocotb.org/en/stable/

### <img src="https://upload.wikimedia.org/wikipedia/commons/7/79/Docker_%28container_engine%29_logo.png" alt="drawing" width="80"/> : Automation of application deployment within software containers
> A container is provided with what is necessary for the implementation of HW with the tools mentioned above.

### Use:

Standing on the working folder, example GP01 of this repository.
```bash
docker run --rm -v $PWD:/project -w /project -it andresdemski/spl2019:cocotb
./docker_env.sh
```

> https://www.docker.com/products/docker-desktop/

___
## FPGA board
[Artix-35T](https://www.xilinx.com/products/boards-and-kits/arty.html)

![arty7](https://www.xilinx.com/content/xilinx/en/products/boards-and-kits/arty/_jcr_content/root/fullParsys/xilinxflexibleslab_1141911343/xilinxflexibleslab-parsys/xilinxtabs/childParsys-specifications/xilinximage.img.png/1503511073525.png)

## Utils
For explore some git repo online with vscode (on navigator), use prefix vscode.dev/

ex:
> https://vscode.dev/github/cocotb/cocotb/tree/2f695a6aeaf4e89aa8c68ea931502ec89c3ca488/examples

# Notes:

- [Class 1](https://onedrive.live.com/redir?resid=71656CC072A17A83%211909&authkey=%21AJVzlWE3PQHxBFE&page=Edit&wd=target%28DDA.one%7C1250178f-4834-44f4-b3ac-d37a29de5e78%2FClase%201%7Cf4623614-bb72-4b9a-b318-0e13ccdb7fc4%2F%29&wdorigin=703)

## TODO:

- Generate a generic sim_suport folder for entire project