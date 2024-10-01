/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    REFERENCE.c
  * @brief   Source file for torque reference handling.
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

#include "REFERENCE.h"
#include <math.h>


// These variables should be updated via CAN
float torqueRefIn_left = 0.0F;
float torqueRefIn_right = 0.0F;
/**
 * @brief Handles torque control based on the reference torque, direction, maximum torque, maximum speed, measured speed,
 *        maximum torque rate of change, speed control loop parameters, and sampling time.
 *
 * @param torqueRefIn     Input reference torque.
 * @param direction       Direction of torque (1 for positive torque, -1 for negative torque).
 * @param torqueMax       Maximum allowable torque.
 * @param speedMaxRPM     Maximum allowable speed in RPM.
 * @param speedMeas       Measured speed.
 * @param loopSpeed       Speed control loop parameters.
 *
 * @return The output torque after handling direction, saturation, and rate limiting.
 */
float handle_torqueRef(float torqueRefIn, int8_t direction, float torqueMax, float speedMaxRPM, float speedMeas, volatile pi_struct *loopSpeed){

	// Handle direction and saturation
	float torqueRefOut = set_torque_direction(torqueRefIn,direction);
	torqueRefOut = saturate_symmetric(torqueRefOut, torqueMax);

	// Saturate torque again with speed loop
	torqueRefOut =  limit_torque_to_prevent_overspeed(speedMaxRPM, speedMeas, torqueRefOut, loopSpeed);

	return torqueRefOut;
}

/**
 * @brief Set torque direction based on inverter direction.
 *
 * This function adjusts the torque reference based on the desired direction.
 * If the motor is set to rotate counterclockwise (CCW), positive torque represents traction, negative is braking.
 * If the motor is set to rotate clockwise (CW), negative torque represents traction, positive is braking.
 *
 * @param[in] torqueRefIn The torque reference value to adjust.
 * @param[in] direction Pointer to the direction of the inverter (1 for CW, -1 for CCW).
 * @return torqueRefOut The adjusted torque reference value.
 */
float set_torque_direction(float torqueRefIn, int8_t direction) {
    float torqueRefOut;

    if (direction == -1) {
        torqueRefOut = -torqueRefIn; // Adjust torque for counterclockwise rotation
    } else if (direction == 1) {
        torqueRefOut = torqueRefIn; // Adjust torque for clockwise rotation
    } else {
        torqueRefOut = 0; // No torque adjustment if direction is invalid
    }

    return torqueRefOut;
}

/**
 * @brief Symmetrically saturate a reference value.
 *
 * This function symmetrically saturates a reference value based on the maximum allowed value.
 * If the reference value exceeds the maximum allowed value, it is saturated to the maximum value.
 * If the reference value is less than the negative of the maximum allowed value, it is saturated to the negative of the maximum value.
 *
 * @param[in] ref The reference value to saturate.
 * @param[in] max The maximum allowed value for saturation.
 * @return The saturated reference value.
 */
float saturate_symmetric(float ref, float max) {
    if (ref > max) {
        return max;
    } else if (ref < -max) {
        return -max;
    } else {
        return ref;
    }
}



/**
 * @brief Speed loop acts as a torque saturation, reducing torque in order to limit the maximum speed.
 * @param[in] speedMaxRPM The maximum speed value in RPM.
 * @param[in] speedMeas The measured speed value in RPM.
 * @param[in] torqueRefIn The torque reference value before this saturation.
 * @param[in] loopSpeed Pointer to the speed PI controller structure.
 * @return torqueRefOut The limited torque reference value after this saturation.
 */
float limit_torque_to_prevent_overspeed(float speedMaxRPM, float speedMeas, float torqueRefIn, volatile pi_struct *loopSpeed){

	// Set speed reference and feedback
	loopSpeed->pi_consig = speedMaxRPM;
	loopSpeed->pi_fdb = fabsf(speedMeas); // Absolute value of speed

    pi_calc(loopSpeed);

    // Calculate limited torque reference based on speed controller output
    float max_torque = loopSpeed->pi_out;

    // Limit torque reference within bounds
    float torqueRefOut;

    if (torqueRefIn > max_torque) {
    	torqueRefOut = max_torque;
    } else if (torqueRefIn < -max_torque) {
    	torqueRefOut = -max_torque;
    } else {
    	torqueRefOut = torqueRefIn;
    }

    return torqueRefOut;
}


/**
 * @brief Calculate derated current based on temperature thresholds. It implements a simple
 * linear derating from tempStart to tempMax.
 *
 * @param[in] temperature The current temperature.
 * @param[in] tempStart The temperature at which derating starts.
 * @param[in] tempMax The temperature at which the current is fully derated to 0.
 * @param[in] iMax The maximum current.
 *
 * @return The derated current.
 */
float calculate_derated_current(float temperature, float tempStart, float tempMax, float iMax) {
    if (temperature <= tempStart) {
        return iMax;
    } else if (temperature >= tempMax) {
        return 0.0F;
    } else {
        // Linear interpolation between tempStart and tempMax
        return iMax * (tempMax - temperature) / (tempMax - tempStart);
    }
}

/**
 * @brief Derate the current reference based on both motor and inverter temperatures.
 *
 * @param[in] tempMotor The motor temperature.
 * @param[in] tempInverter The inverter temperature.
 * @param[in] iMax The maximum current.
 *
 * @return The derated current reference.
 */
float derate_current_reference(float tempMotor, float tempInverter, float iMax) {
    // Derate based on motor temperature
    float deratedCurrentMotor = calculate_derated_current(tempMotor, TEMP_MOTOR_DERATING, TEMP_MOTOR_MAX, iMax);
    
    // Derate based on inverter temperature
    float deratedCurrentInverter = calculate_derated_current(tempInverter, TEMP_INVERTER_DERATING, TEMP_INVERTER_MAX, iMax);
    
    // Return the lower of the two derated currents
    return (deratedCurrentMotor < deratedCurrentInverter) ? deratedCurrentMotor : deratedCurrentInverter;
}
