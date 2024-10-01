/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    TASKS_CRITICAL.h
  * @brief   Header file for functions related to tasks executed in each PWM timer interruption.
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

/**
 * @brief Function to be executed every TS.
 *
 * This function is called by the TIM1 trigger out handler every TS.
 */
void tasks_critical_left();

/**
 * @brief Function to be executed every TS.
 *
 * This function is called by the TIM8 trigger out handler every TS.
 */
void tasks_critical_right();
