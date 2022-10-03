###################################################################################################
GTK_ARGS = --rcvar 'fontname_signals Monospace 16' --rcvar 'fontname_waves Monospace 16'

# For CocoTB case
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += ../rtl/$(tle).v
TOPLEVEL = $(tle)
MODULE = $(tle)_tb
# can be TRACE, DEBUG, INFO, WARNING, ERROR, CRITICAL.
LOG=INFO
WAVES = 1
###################################################################################################
# RULES
###################################################################################################
all: help

check:
	iverilog -o mydesign_synth $(VERILOG_SOURCES)
run_v:
	iverilog -o mydesign_synth $(VERILOG_SOURCES) $(MODULE).v
	vvp mydesign_synth

run_coco:
	$(MAKE) -f $(shell cocotb-config --makefiles)/Makefile.sim SIM=$(SIM) TOPLEVEL_LANG=$(TOPLEVEL_LANG) VERILOG_SOURCES=$(VERILOG_SOURCES) TOPLEVEL=$(TOPLEVEL) MODULE=$(MODULE) COCOTB_LOG_LEVEL=$(LOG)

waves:
	gtkwave *.vcd $(GTK_ARGS)

clean:
	rm -rf mydesign_synth *.vcd

help:
	clear
	@echo "*************************************************************************"
	@echo "   MENU DE AYUDA                                                         "
	@echo "*************************************************************************"
	@echo "                                                                         "
	@echo "    A continuación se listan las reglas para trabajar y algunos ejemplos "
	@echo "    Se espera que el modulo y testBench tengan la forma:					"
	@echo "    MyModule.v 															"
	@echo "    MyModule_tb.v 														"
	@echo "                                                                         "
	@echo "    check : Corre un chequeo de sintaxis con icarus                      "
	@echo "            make check tle=<module>                                      "
	@echo "                                                                         "
	@echo "    run_v : Simula la entidad de mayor jerarquía con Icarus.             "
	@echo "            Sólo válido para ejercicios que tienen TB disponible.        "
	@echo "            Requiere argumento tle=<module>                              "
	@echo "            Ejemplo de uso: Para el ejercicio 1, la TLE es xor_gate      "
	@echo "            Comando > make run tle=xor_gate                              "
	@echo "                                                                         "
	@echo "    run_coco: Simula la entidad de mayor jerarquía.                      "
	@echo "            Sólo válido para ejercicios que tienen TB disponible tipo py "
	@echo "            Requiere argumento tle=<module>                              "
	@echo "                                                                         "
	@echo "    waves : Permite visualizar las formas de onda de la simulación       "
	@echo "            Sólo válido luego de correr el comando **run**               "
	@echo "            Comando > make waves                                         "
	@echo "                                                                         "
	@echo "    clean : Limpia el directorio de trabajo                              "
	@echo "            Comando > make clean                                         "
	@echo "                                                                         "
	@echo "    all   : Imprime este menu de opciones                                "
	@echo "            Comando > make                                               "
	@echo "                                                                         "
	@echo "*************************************************************************"
