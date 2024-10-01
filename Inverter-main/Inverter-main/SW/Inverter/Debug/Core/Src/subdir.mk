################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Core/Src/CAN_e-Tech.c \
../Core/Src/CONTROL.c \
../Core/Src/ERRORS.c \
../Core/Src/FSM.c \
../Core/Src/INVERTER.c \
../Core/Src/MEASUREMENTS.c \
../Core/Src/MOTOR.c \
../Core/Src/PCB_IO.c \
../Core/Src/PWM.c \
../Core/Src/PergaMOD.c \
../Core/Src/REFERENCE.c \
../Core/Src/TASKS_1ms.c \
../Core/Src/TASKS_CRITICAL.c \
../Core/Src/adc.c \
../Core/Src/can.c \
../Core/Src/dac.c \
../Core/Src/dma.c \
../Core/Src/gpio.c \
../Core/Src/i2c.c \
../Core/Src/main.c \
../Core/Src/stm32f7xx_hal_msp.c \
../Core/Src/stm32f7xx_it.c \
../Core/Src/syscalls.c \
../Core/Src/sysmem.c \
../Core/Src/system_stm32f7xx.c \
../Core/Src/tim.c \
../Core/Src/usb_otg.c 

OBJS += \
./Core/Src/CAN_e-Tech.o \
./Core/Src/CONTROL.o \
./Core/Src/ERRORS.o \
./Core/Src/FSM.o \
./Core/Src/INVERTER.o \
./Core/Src/MEASUREMENTS.o \
./Core/Src/MOTOR.o \
./Core/Src/PCB_IO.o \
./Core/Src/PWM.o \
./Core/Src/PergaMOD.o \
./Core/Src/REFERENCE.o \
./Core/Src/TASKS_1ms.o \
./Core/Src/TASKS_CRITICAL.o \
./Core/Src/adc.o \
./Core/Src/can.o \
./Core/Src/dac.o \
./Core/Src/dma.o \
./Core/Src/gpio.o \
./Core/Src/i2c.o \
./Core/Src/main.o \
./Core/Src/stm32f7xx_hal_msp.o \
./Core/Src/stm32f7xx_it.o \
./Core/Src/syscalls.o \
./Core/Src/sysmem.o \
./Core/Src/system_stm32f7xx.o \
./Core/Src/tim.o \
./Core/Src/usb_otg.o 

C_DEPS += \
./Core/Src/CAN_e-Tech.d \
./Core/Src/CONTROL.d \
./Core/Src/ERRORS.d \
./Core/Src/FSM.d \
./Core/Src/INVERTER.d \
./Core/Src/MEASUREMENTS.d \
./Core/Src/MOTOR.d \
./Core/Src/PCB_IO.d \
./Core/Src/PWM.d \
./Core/Src/PergaMOD.d \
./Core/Src/REFERENCE.d \
./Core/Src/TASKS_1ms.d \
./Core/Src/TASKS_CRITICAL.d \
./Core/Src/adc.d \
./Core/Src/can.d \
./Core/Src/dac.d \
./Core/Src/dma.d \
./Core/Src/gpio.d \
./Core/Src/i2c.d \
./Core/Src/main.d \
./Core/Src/stm32f7xx_hal_msp.d \
./Core/Src/stm32f7xx_it.d \
./Core/Src/syscalls.d \
./Core/Src/sysmem.d \
./Core/Src/system_stm32f7xx.d \
./Core/Src/tim.d \
./Core/Src/usb_otg.d 


# Each subdirectory must supply rules for building sources it contributes
Core/Src/%.o Core/Src/%.su Core/Src/%.cyclo: ../Core/Src/%.c Core/Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F777xx -c -I../Core/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc -I../Drivers/STM32F7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F7xx/Include -I../Drivers/CMSIS/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Core-2f-Src

clean-Core-2f-Src:
	-$(RM) ./Core/Src/CAN_e-Tech.cyclo ./Core/Src/CAN_e-Tech.d ./Core/Src/CAN_e-Tech.o ./Core/Src/CAN_e-Tech.su ./Core/Src/CONTROL.cyclo ./Core/Src/CONTROL.d ./Core/Src/CONTROL.o ./Core/Src/CONTROL.su ./Core/Src/ERRORS.cyclo ./Core/Src/ERRORS.d ./Core/Src/ERRORS.o ./Core/Src/ERRORS.su ./Core/Src/FSM.cyclo ./Core/Src/FSM.d ./Core/Src/FSM.o ./Core/Src/FSM.su ./Core/Src/INVERTER.cyclo ./Core/Src/INVERTER.d ./Core/Src/INVERTER.o ./Core/Src/INVERTER.su ./Core/Src/MEASUREMENTS.cyclo ./Core/Src/MEASUREMENTS.d ./Core/Src/MEASUREMENTS.o ./Core/Src/MEASUREMENTS.su ./Core/Src/MOTOR.cyclo ./Core/Src/MOTOR.d ./Core/Src/MOTOR.o ./Core/Src/MOTOR.su ./Core/Src/PCB_IO.cyclo ./Core/Src/PCB_IO.d ./Core/Src/PCB_IO.o ./Core/Src/PCB_IO.su ./Core/Src/PWM.cyclo ./Core/Src/PWM.d ./Core/Src/PWM.o ./Core/Src/PWM.su ./Core/Src/PergaMOD.cyclo ./Core/Src/PergaMOD.d ./Core/Src/PergaMOD.o ./Core/Src/PergaMOD.su ./Core/Src/REFERENCE.cyclo ./Core/Src/REFERENCE.d ./Core/Src/REFERENCE.o ./Core/Src/REFERENCE.su ./Core/Src/TASKS_1ms.cyclo ./Core/Src/TASKS_1ms.d ./Core/Src/TASKS_1ms.o ./Core/Src/TASKS_1ms.su ./Core/Src/TASKS_CRITICAL.cyclo ./Core/Src/TASKS_CRITICAL.d ./Core/Src/TASKS_CRITICAL.o ./Core/Src/TASKS_CRITICAL.su ./Core/Src/adc.cyclo ./Core/Src/adc.d ./Core/Src/adc.o ./Core/Src/adc.su ./Core/Src/can.cyclo ./Core/Src/can.d ./Core/Src/can.o ./Core/Src/can.su ./Core/Src/dac.cyclo ./Core/Src/dac.d ./Core/Src/dac.o ./Core/Src/dac.su ./Core/Src/dma.cyclo ./Core/Src/dma.d ./Core/Src/dma.o ./Core/Src/dma.su ./Core/Src/gpio.cyclo ./Core/Src/gpio.d ./Core/Src/gpio.o ./Core/Src/gpio.su ./Core/Src/i2c.cyclo ./Core/Src/i2c.d ./Core/Src/i2c.o ./Core/Src/i2c.su ./Core/Src/main.cyclo ./Core/Src/main.d ./Core/Src/main.o ./Core/Src/main.su ./Core/Src/stm32f7xx_hal_msp.cyclo ./Core/Src/stm32f7xx_hal_msp.d ./Core/Src/stm32f7xx_hal_msp.o ./Core/Src/stm32f7xx_hal_msp.su ./Core/Src/stm32f7xx_it.cyclo ./Core/Src/stm32f7xx_it.d ./Core/Src/stm32f7xx_it.o ./Core/Src/stm32f7xx_it.su ./Core/Src/syscalls.cyclo ./Core/Src/syscalls.d ./Core/Src/syscalls.o ./Core/Src/syscalls.su ./Core/Src/sysmem.cyclo ./Core/Src/sysmem.d ./Core/Src/sysmem.o ./Core/Src/sysmem.su ./Core/Src/system_stm32f7xx.cyclo ./Core/Src/system_stm32f7xx.d ./Core/Src/system_stm32f7xx.o ./Core/Src/system_stm32f7xx.su ./Core/Src/tim.cyclo ./Core/Src/tim.d ./Core/Src/tim.o ./Core/Src/tim.su ./Core/Src/usb_otg.cyclo ./Core/Src/usb_otg.d ./Core/Src/usb_otg.o ./Core/Src/usb_otg.su

.PHONY: clean-Core-2f-Src

