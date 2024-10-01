/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    MOTOR.c
  * @brief   Source file for motor parameters.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2024 David Redondo (@dweggg on GitHub).
  * All rights reserved.
  *
  * This software is licensed under the Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) license.
  * For more information, see: https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
  *
  ******************************************************************************
  */

#include "MOTOR.h"
#include <math.h>

// May 9th 2024: updated with Mavilor motor parameters (motor located at CITCEA Mec-1 lab)

/**
 * @brief Left motor parameters
 */
MotorParameters motor_left = {
	.Ld = 0.00291F,
	.Lq = 0.00291F,
	.Rs = 1.95F,
	.lambda = 0.13391F,
	.pp = 4,
	.J = 0.00093F,
	.b = 0.632653F,
	.torqueMax = 10.0F,
	.dTorqueMax = 1.0F,
	.speedMax_RPM = 8500.0F,
	.iMax = 60.0F,
	.vDCMax = 450.0F
};

/**
 * @brief Right motor parameters
 */
MotorParameters motor_right = {
    .Ld = 0.00291F,
    .Lq = 0.00291F,
    .Rs = 1.95F,
    .lambda = 0.13391F,
    .pp = 4,
    .J = 0.00093F,
    .b = 0.632653F,
    .torqueMax = 10.0F,
    .dTorqueMax = 1.0F,
    .speedMax_RPM = 8500.0F,
    .iMax = 60.0F,
    .vDCMax = 450.0F
};

/**
 * @brief Precomputes the constants for a motor and updates the MotorParameters structure
 * 
 * @param motor  [in, out] Pointer to the motor parameters structure
 */
void precalculate_motor_constants(MotorParameters * motor) {
    motor->constants.threePpLambda = 3.0F * motor->pp * motor->lambda;
    motor->constants.threePpLdMinusLq = 3.0F * motor->pp * (motor->Ld - motor->Lq);
    motor->constants.invThreePpLambda = 1.0F / (3.0F * motor->pp * motor->lambda);
    motor->constants.isc = motor->lambda / motor->Ld;
    motor->constants.torqueBase = 3.0F * motor->pp * (motor->lambda * motor->lambda) / motor->Ld;
    motor->constants.invTorqueBase = 1.0F / motor->constants.torqueBase;
    motor->constants.xi = motor->Lq / motor->Ld;
    motor->constants.xiSquared = motor->constants.xi * motor->constants.xi;
    motor->constants.oneMinusXi = 1.0F - motor->constants.xi;
    motor->constants.twoMinusXi = 2.0F - motor->constants.xi;
    motor->constants.fourTimesOneMinusXi = 4.0F * motor->constants.oneMinusXi;
    motor->constants.eightTimesOneMinusXiSquared = 8.0F * motor->constants.oneMinusXi * motor->constants.oneMinusXi;
    motor->constants.twoMinusXiSquared = motor->constants.twoMinusXi * motor->constants.twoMinusXi;
    motor->constants.twoTimesOneMinusXiOnePlusXiSquared = 2.0F * motor->constants.oneMinusXi * (1.0F + motor->constants.xiSquared);
    motor->constants.twoTimesOneMinusXiXiSquared = 2.0F * motor->constants.oneMinusXi * motor->constants.xiSquared;
    motor->constants.fourTimesOneMinusXiOnePlusXiSquared = 4.0F * motor->constants.oneMinusXi * (1.0F + motor->constants.xiSquared);
    motor->constants.fourTimesOneMinusXiXiSquared = 4.0F * motor->constants.oneMinusXi * motor->constants.xiSquared;
    motor->constants.lambdaDivLqMinusLd = motor->lambda / (motor->Lq - motor->Ld);
    motor->constants.betaMinusIsc = motor->constants.lambdaDivLqMinusLd - motor->constants.isc;
}

/**
  * @brief Perform a parameter check and correct possible errors.
  * @param[in] motor Pointer to the MotorParameters struct.
  * @retval OK 0 if an error occurred, 1 if successful.
  */
int check_motor_parameters(MotorParameters *motor, float Ts) {

	int OK = 1;

	float Ld_over_Lq_tolerance = 1.1F;

    // Error 1 - Evaluate Rs
    if (motor->Rs < 0.002F || motor->Rs > 10.0F) {
        // Adjust Rs if out of bounds
        if (motor->Rs < 0.002F)
        	motor->Rs = 0.002F, OK = 0;
        else if (motor->Rs > 10.0F)
        	motor->Rs = 10.0F, OK = 0;
    }

    // Error 2 - Evaluate Ld, Lq
    if (motor->Ld < 0.000001F || motor->Ld > 0.05F ||
        fabs(motor->Ld / motor->Rs) < Ts / 10.0F ||
		motor->Lq < 0.000001F || motor->Lq > 0.05F ||
        fabs(motor->Lq / motor->Rs) < Ts / 10.0F) {
        // Adjust parameters if out of bounds
        if (motor->Ld < 0.000001F)
        	motor->Ld = 0.000001F, OK = 0;
        else if (motor->Ld > 0.05F)
        	motor->Ld = 0.05F, OK = 0;

        if (fabs(motor->Ld / motor->Rs) < Ts / 10.0F)
        	motor->Ld = Ts / 10 * motor->Rs, OK = 0;

        if (motor->Lq < 0.000001F)
        	motor->Lq = 0.000001F;
        else if (motor->Lq > 0.05F)
        	motor->Lq = 0.05F, OK = 0;

        if (fabs(motor->Lq / motor->Rs) < Ts / 10.0F)
        	motor->Lq = Ts / 10 * motor->Rs, OK = 0;
    }

    // Error 3 - Evaluate Lq/Ld
    if (motor->Lq < motor->Ld) {
        if (motor->Ld / motor->Lq > Ld_over_Lq_tolerance)
        	motor->Lq = motor->Ld, OK = 0;
    }

    // Error 4 - Evaluate lambda
    if (motor->lambda < 0.0001F || motor->lambda > 1.0F ||
    		motor->iMax < motor->lambda / motor->Ld - motor->vDCMax / sqrt(3) / motor->Ld / (motor->speedMax_RPM * (float)motor->pp * 2.0F * M_PI / 60.0F)) {
        // Adjust parameters if out of bounds
        if (motor->lambda < 0.0001F)
        	motor->lambda = 0.0001F, OK = 0;
        else if (motor->lambda > 1.0F)
        	motor->lambda = 1.0F, OK = 0;

        if (motor->iMax < motor->lambda / motor->Ld - motor->vDCMax / sqrt(3) / motor->Ld / (motor->speedMax_RPM * (float)motor->pp * 2.0F * M_PI / 60.0F))
        	motor->iMax = motor->lambda / motor->Ld - motor->vDCMax / sqrt(3) / motor->Ld / (motor->speedMax_RPM * (float)motor->pp * 2.0F * M_PI / 60.0F), OK = 0;
    }

    // Error 5 - Evaluate J, b
    if (motor->J == 0 || motor->b == 0) {
        // Cannot calculate J/b, no adjustments needed
    } else {
        if (motor->J / motor->b <= motor->Lq / motor->Rs) {
            // Adjust J or b if necessary
            // For this example, let's just set J or b to 1 if the condition is met
            if (motor->J / motor->b <= motor->Lq / motor->Rs) {
            	motor->J = 1;
            	motor->b = 1;
            }
        }
    }

    // Error 6 - Evaluate pp

    if (motor->pp < 1 || motor->pp > 20) {
		// Adjust Rs if out of bounds
		if (motor->pp < 1)
			motor->pp = 1, OK = 0;
		else if (motor->pp > 20)
			motor->pp = 20, OK = 0;
    }
    return OK;
}

