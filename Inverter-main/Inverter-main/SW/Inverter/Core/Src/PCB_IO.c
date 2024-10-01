/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    PCB_IO.c
  * @brief   This file provides functions for handling GPIOs.
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


#include "PCB_IO.h"
#include "main.h" // Pins

// Define LED structures
LED led_left = { .port = LED_LEFT_GPIO_Port, .pin = LED_LEFT_Pin, .mode = LED_MODE_OFF };
LED led_right = { .port = LED_RIGHT_GPIO_Port, .pin = LED_RIGHT_Pin, .mode = LED_MODE_OFF };
LED ledError = { .port = LED_ERR_GPIO_Port, .pin = LED_ERR_Pin, .mode = LED_MODE_OFF };

/**
 * @brief LED handler function.
 *
 * This function handles the LED blinking modes based on the LED mode and current millisecond counter.
 *
 * @param led Pointer to the LED structure.
 * @param ms_counter Current millisecond counter.
 */
void handle_LED(LED *led, uint32_t ms_counter) {
    switch (led->mode) {
        case LED_MODE_BLINK_FAST:
            if (ms_counter % 200 < 100) {
                HAL_GPIO_WritePin(led->port, led->pin, GPIO_PIN_SET);
            } else {
                HAL_GPIO_WritePin(led->port, led->pin, GPIO_PIN_RESET);
            }
            break;
        case LED_MODE_BLINK_SLOW:
            if (ms_counter % 1000 < 500) {
                HAL_GPIO_WritePin(led->port, led->pin, GPIO_PIN_SET);
            } else {
                HAL_GPIO_WritePin(led->port, led->pin, GPIO_PIN_RESET);
            }
            break;
        case LED_MODE_ON:
            HAL_GPIO_WritePin(led->port, led->pin, GPIO_PIN_SET);
            break;
        case LED_MODE_OFF:
            HAL_GPIO_WritePin(led->port, led->pin, GPIO_PIN_RESET);
            break;
        default:
            // Invalid LED mode
            break;
    }
}

/**
 * @brief Handles the direction of the motors.
 *
 * This function reads the state of the DIR switch and updates the directions
 * of both the left and right motors. If one motor is set to rotate
 * clockwise (CW), the other one is set to rotate counterclockwise (CCW),
 * and vice versa.
 *
 * @param dir_left Pointer to the direction parameter in the left inverter structure.
 * @param dir_right Pointer to the direction parameter in the right inverter structure.
 */
void handle_direction(volatile int8_t *dir_left, volatile int8_t *dir_right){
    // Update the directions of the inverters based on the DIR switch state
    if (DIR_STATE() == GPIO_PIN_SET) {
    	*dir_left = 1;  // CW
    	*dir_right = -1;  // CCW
    } else {
    	*dir_left = -1;  // CCW
    	*dir_right = 1;  // CW
    }
}

/**
 * @brief Handles the direction of the motors and enables/disables the inverters.
 *
 * This function reads the state of the shutdown chain (SC or SDC) and enables/disables
 * the inverters based on that and an external software enable bool.
 *
 * @param[in] enableSW_left The software enable state for the left inverter.
 * @param[in] enableSW_right The software enable state for the right inverter.
 * @param[out] enable_left Output parameter for the left inverter's enable state.
 * @param[out] enable_right Output parameter for the right inverter's enable state.
 */
void enable_inverters(volatile bool enableSW_left, volatile bool enableSW_right, volatile bool *enable_left, volatile bool *enable_right){
    *enable_left = (SC_DET_STATE() == GPIO_PIN_SET) && enableSW_left;
    *enable_right = (SC_DET_STATE() == GPIO_PIN_SET) && enableSW_right;
}
