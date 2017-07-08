#**********************************************************************
#**********************************************************************
#**                                                                  **
#**        (C)Copyright 1985-2012, American Megatrends, Inc.         **
#**                                                                  **
#**                       All Rights Reserved.                       **
#**                                                                  **
#**         5555 Oakbrook Pkwy, Suite 200, Norcross, GA 30093        **
#**                                                                  **
#**                       Phone: (770)-246-8600                      **
#**                                                                  **
#**********************************************************************
#**********************************************************************
# $Header:$
#
# $Revision:$
#
# $Date:$
#**********************************************************************
#**********************************************************************
# Revision History
# ----------------
# $Log:$
# 
#**********************************************************************
#<AMI_FHDR_START>
#**********************************************************************
#
# Name:         Oemem.mak
#
# Description:  
#
#**********************************************************************
#<AMI_FHDR_END>

#---------------------------------------------------------------------------
#			Begin of OEMEM Source files path
#---------------------------------------------------------------------------


PROJECT_DIR :=$(ROOT)

OEMEM_PEI_SOURCES :=\
$(OEMEM_DIR)/OememPeiLib.c\
$(OEMEM_DIR)/OememPeiCore.c\
$(OEMEM_PEI_SOURCES)

OEMEM_DXE_SOURCES :=\
$(OEMEM_DIR)/OememLib.c\
$(OEMEM_DIR)/OememDxeLib.c\
$(OEMEM_DIR)/OememDxeCore.c\
$(OEMEM_DXE_SOURCES)

OEMEM_SMI_SOURCES :=\
$(OEMEM_DIR)/OememLib.c\
$(OEMEM_DIR)/OememSmiLib.c\
$(OEMEM_DIR)/OememSmiCore.c\
$(OEMEM_SMI_SOURCES)


#---------------------------------------------------------------------------
#			End of OEMEM Source files path
#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
#			Begin of Prepare process instrution
#---------------------------------------------------------------------------

Prepare : OEMEM_PREPARE OEMEM_PREPARE_1 OEMEM_PREPARE_2 OEMEM_PREPARE_FINISH
OEMEM_PREPARE_FINISH : OEMEM_PREPARE_2
OEMEM_PREPARE_2 : OEMEM_PREPARE_1
OEMEM_PREPARE_1 : OEMEM_PREPARE

OEMEM_PREPARE : 
	@echo OEMEM_PREPARE....................................

OEMEM_PREPARE_1 :
	@echo OEMEM_PREPARE_1 .................................

OEMEM_PREPARE_2 :
	@echo OEMEM_PREPARE_2 .................................

OEMEM_PREPARE_FINISH :
	@echo OEMEM_PREPARE_FINISH ............................

OEMEM_PREPARE : $(BUILD_DIR)/append.txt $(BUILD_DIR)/OememPeiBin.inf $(BUILD_DIR)/OememDxeBin.inf $(BUILD_DIR)/OememSmiBin.inf



#---------------------------------------------------------------------------
#			End of Prepare process instrution
#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
#			Begin of OememPeiBin
#---------------------------------------------------------------------------
$(BUILD_DIR)/OememPeiBin.inf : $(OEMEM_PEI_SOURCES)
	$(ECHO)  \
"[Defines]$(EOL)\
  INF_VERSION                    = 0x00010005$(EOL)\
  BASE_NAME                      = OememPeiBin$(EOL)\
  FILE_GUID                      = 0A602C5B-05A0-40c4-9181-EDCD891D0003$(EOL)\
  MODULE_TYPE                    = PEIM$(EOL)\
  VERSION_STRING                 = 1.0$(EOL)\
  ENTRY_POINT                    = OememPEIDriverEntryPoint$(EOL)\
$(EOL)\
[Sources]$(EOL)\
$(patsubst %,../%,$(subst $(SPACE),$(EOL)$(SPACE),$(filter %.c %.asm,$(subst \,/,$^))))$(EOL)\
$(EOL)\
[Packages]$(EOL)\
  $(filter %.dec, $(subst \,/,$^))$(EOL)\
  $(OEMEM_DIR)/OEMEM.dec$(EOL)\
  AmiCompatibilityPkg/AmiCompatibilityPkg.dec$(EOL)\
  AmiModulePkg/AmiModulePkg.dec$(EOL)\
  MdePkg/MdePkg.dec$(EOL)\
  IntelFrameworkPkg/IntelFrameworkPkg.dec$(EOL)\
  $(EOL)\
[LibraryClasses]$(EOL)\
  PeimEntryPoint$(EOL)\
  AmiPeiLib$(EOL)\
#carlos-  AmiChipsetIoLib$(EOL)\
  $(EOL)\
[Ppis]$(EOL)\
  $(EOL)\
[Depex]$(EOL)\
  $(OEMEM_PEI_DXS)$(EOL)\
  $(EOL)"\
> $(BUILD_DIR)/OememPeiBin.inf
#---------------------------------------------------------------------------
#			End of OememPeiBin
#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
#			Begin of OememDxeBin
#---------------------------------------------------------------------------
$(BUILD_DIR)/OememDxeBin.inf : $(OEMEM_DXE_SOURCES)
	$(ECHO)  \
"[Defines]$(EOL)\
  INF_VERSION                    = 0x00010005$(EOL)\
  BASE_NAME                      = OememDxeBin$(EOL)\
  FILE_GUID                      = 0A602C5B-05A0-40c4-9181-EDCD891D0001$(EOL)\
  MODULE_TYPE                    = DXE_DRIVER$(EOL)\
  VERSION_STRING                 = 1.0$(EOL)\
  ENTRY_POINT                    = OememDXEDriverEntryPoint$(EOL)\
$(EOL)\
[Sources]$(EOL)\
$(patsubst %,../%,$(subst $(SPACE),$(EOL)$(SPACE),$(filter %.c %.asm,$(subst \,/,$^))))$(EOL)\
$(EOL)\
[Packages]$(EOL)\
  $(filter %.dec, $(subst \,/,$^))$(EOL)\
  $(OEMEM_DIR)/OEMEM.dec$(EOL)\
  AmiCompatibilityPkg/AmiCompatibilityPkg.dec$(EOL)\
  AmiModulePkg/AmiModulePkg.dec$(EOL)\
  MdePkg/MdePkg.dec$(EOL)\
  $(EOL)\
  $(EOL)\
[Protocols]$(EOL)\
  gBdsAllDriversConnectedProtocolGuid$(EOL)\
  gEfiLegacyBiosExtProtocolGuid$(EOL)\
  gEfiOememInterfaceProtocolGuid$(EOL)\
$(EOL)\
[LibraryClasses]$(EOL)\
  UefiDriverEntryPoint$(EOL)\
  AmiDxeLib$(EOL)\
  AmiCspLib$(EOL)\
  $(EOL)\
[Depex]$(EOL)\
  $(OEMEM_DXE_DXS)$(EOL)\
  $(EOL)"\
> $(BUILD_DIR)/OememDxeBin.inf
#---------------------------------------------------------------------------
#			End of OememDxeBin
#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
#			Begin of OememSmiBin
#---------------------------------------------------------------------------
$(BUILD_DIR)/OememSmiBin.inf : $(OEMEM_SMI_SOURCES)
	$(ECHO)  \
"[Defines]$(EOL)\
  INF_VERSION                    = 0x00010005$(EOL)\
  BASE_NAME                      = OememSmiBin$(EOL)\
  FILE_GUID                      = 0A602C5B-05A0-40c4-9181-EDCD891D0002$(EOL)\
  MODULE_TYPE                    = DXE_SMM_DRIVER$(EOL)\
  VERSION_STRING                 = 1.0$(EOL)\
  PI_SPECIFICATION_VERSION       = 0x0001000A$(EOL)\
  ENTRY_POINT                    = OememSMIDriverEntryPoint$(EOL)\
$(EOL)\
[Sources]$(EOL)\
$(patsubst %,../%,$(subst $(SPACE),$(EOL)$(SPACE),$(filter %.c %.asm,$(subst \,/,$^))))$(EOL)\
$(EOL)\
[Packages]$(EOL)\
  $(subst $(SPACE),$(EOL)$(SPACE),$(filter %.dec,$(subst \,/,$^)))$(EOL)\
  $(OEMEM_DIR)/OEMEM.dec$(EOL)\
  AmiCompatibilityPkg/AmiCompatibilityPkg.dec$(EOL)\
  AmiModulePkg/AmiModulePkg.dec$(EOL)\
  MdePkg/MdePkg.dec$(EOL)\
  IntelFrameworkPkg/IntelFrameworkPkg.dec$(EOL)\
#carlos-  AmiChipsetPkg/AmiChipsetPkg.dec$(EOL)\
  $(EOL)\
[Protocols]$(EOL)\
  gEfiSmmSwDispatchProtocolGuid$(EOL)\
  gEfiSmmGpiDispatchProtocolGuid$(EOL)\
  gEfiSmmSxDispatchProtocolGuid$(EOL)\
  gEfiSmmSwDispatch2ProtocolGuid$(EOL)\
  gEfiSmmGpiDispatch2ProtocolGuid$(EOL)\
  gEfiSmmSxDispatch2ProtocolGuid$(EOL)\
  $(EOL)\
[LibraryClasses]$(EOL)\
  UefiDriverEntryPoint$(EOL)\
  AmiDxeLib$(EOL)\
  $(EOL)\
[Depex.common.DXE_SMM_DRIVER]$(EOL)\
  $(OEMEM_SMI_DXS)$(EOL)\
  $(EOL)"\
> $(BUILD_DIR)/OememSmiBin.inf
#---------------------------------------------------------------------------
#			End of OememSmiBin
#---------------------------------------------------------------------------


#---------------------------------------------------------------------------
#			Begin of 
#---------------------------------------------------------------------------
$(BUILD_DIR)/OememLib.inf :
	$(ECHO)  \
"[Defines]$(EOL)\
  INF_VERSION                    = 0x00010005$(EOL)\
  BASE_NAME                      = OememLib$(EOL)\
  FILE_GUID                      = 0A602C5B-05A0-40c4-9181-EDCD891D0100$(EOL)\
  MODULE_TYPE                    = BASE$(EOL)\
  VERSION_STRING                 = 1.0$(EOL)\
  PI_SPECIFICATION_VERSION       = 0x0001000A$(EOL)\
  LIBRARY_CLASS                  = OememLib$(EOL)\
$(EOL)\
$(EOL)\
[Sources]$(EOL)\
$(patsubst %,../%,$(subst $(SPACE),$(EOL)$(SPACE),$(filter %.c %.asm,$(subst \,/,$(OEMEM_LIB_SOURCES)))))$(EOL)\
$(EOL)\
$(EOL)\
[Sources.X64]$(EOL)\
$(patsubst %,../%,$(subst $(SPACE),$(EOL)$(SPACE),$(filter %.c %.asm,$(subst \,/,$(OEMEM_LIB_X64_SOURCES)))))$(EOL)\
$(EOL)\
$(EOL)\
[Sources.Ia32]$(EOL)\
$(patsubst %,../%,$(subst $(SPACE),$(EOL)$(SPACE),$(filter %.c %.asm,$(subst \,/,$(OEMEM_LIB_IA32_SOURCES)))))$(EOL)\
$(EOL)\
$(EOL)\
[Packages]$(EOL)\
  $(subst $(SPACE),$(EOL)$(SPACE),$(filter %.dec,$(subst \,/,OEMEM_LIB_SOURCES)))$(EOL)\
  AmiCompatibilityPkg/AmiCompatibilityPkg.dec$(EOL)\
  $(OEMEM_DIR)/OEMEM.dec$(EOL)\
  $(EOL)\
[LibraryClasses]$(EOL)\
  AmiLib$(EOL)\
  $(EOL)\
$(EOL)\
> $(BUILD_DIR)/OememLib.inf
#---------------------------------------------------------------------------
#			End of 
#---------------------------------------------------------------------------

#**********************************************************************
#**********************************************************************
#**                                                                  **
#**        (C)Copyright 1985-2012, American Megatrends, Inc.         **
#**                                                                  **
#**                       All Rights Reserved.                       **
#**                                                                  **
#**         5555 Oakbrook Pkwy, Suite 200, Norcross, GA 30093        **
#**                                                                  **
#**                       Phone: (770)-246-8600                      **
#**                                                                  **
#**********************************************************************
#**********************************************************************
