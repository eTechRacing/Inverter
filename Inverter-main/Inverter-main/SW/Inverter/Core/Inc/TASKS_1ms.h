/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    TASKS_1ms.h
  * @brief   Header file for functions related to tasks executed every 1ms.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2024 David Redondo (@dweggg in GitHub).
  * All rights reserved.
  *
  * This software is licensed under the Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) license.
  * For more information, see: https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
  *
  ******************************************************************************
  */

/* USER CODE END Header */


#ifndef TASKS_1MS_H
#define TASKS_1MS_H

#include "INVERTER.h" // needs invLeft/invRight


/**
 * @brief Function to be executed every 1ms.
 *
 * This function is called by the TIM6 IRQ handler every millisecond.
 */
void tasks_1ms(void);

/**
 * @brief Function to read temperatures and handle overtemperature faults.
 */
void read_temperatures(void);

/**
 * @brief Function to handle overtemperature faults.
 * 
 * @param[in, out] inv Pointer to the InverterStruct structure.
 */
void handle_overtemperature_faults(volatile InverterStruct *inv);

#endif /* TASKS_1MS_H */
