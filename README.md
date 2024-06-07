# DataDriven-IGBT-Inverter-Modeling

This repository contains the code and dataset for the paper **"Data-Driven Modeling of Three-Phase IGBT Two-Level Inverter for Electrical Drives using ANNs"**. The project uses MATLAB to develop and train Artificial Neural Networks (ANNs) to model a three-phase IGBT two-level inverter for electrical drives.

## Overview

Precise phase voltage information is crucial for the efficient and accurate control of electric motor drives, particularly for torque-controlled operations. This project aims to estimate these voltages using data-driven inverter models due to the impracticality of analytical white-box modeling in this context. The provided dataset, which includes approximately 235,000 samples, facilitates the training of black-box inverter models to predict phase voltages accurately.

## Dataset

The dataset captures the mean phase voltages for each PWM interval along with other relevant signals across the complete operating range of an exemplary drive system. It is publicly available and intended for use in training and validating the ANN models.

## Requirements

- MATLAB (R2023b or later)
- Deep Learning Toolbox
