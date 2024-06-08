# DataDriven-IGBT-Inverter-Modeling

This repository contains the code and dataset for the paper **"Data-Driven Modeling of Three-Phase IGBT Two-Level Inverter for Electrical Drives using ANNs"**. The project uses MATLAB to develop and train Artificial Neural Networks (ANNs) to model a three-phase IGBT two-level inverter for electrical drives.

![architecture](https://github.com/Shengwei0516/DataDriven-IGBT-Inverter-Modeling/blob/main/imgs/Inverter_circuit_diagram.png)

## Overview

Precise phase voltage information is crucial for the efficient and accurate control of electric motor drives, particularly for torque-controlled operations. This project aims to estimate these voltages using data-driven inverter models due to the impracticality of analytical white-box modeling in this context. The provided dataset, which includes approximately 235,000 samples, facilitates the training of black-box inverter models to predict phase voltages accurately.

## Dataset

The data set comprises several sensor data collected from a typical combined system between an inverter, an induction motor, and a control system, deployed on a test bench. It is publicly available and can be downloaded from [Kaggle](https://www.kaggle.com/datasets/stender/inverter-data-set/data).

## Repository Structure

- `main.m`: MATLAB script that includes data preprocessing, model training, evaluation, and visualization of results.

## Requirements

- MATLAB (R2023b or later)
- Deep Learning Toolbox

## Getting Started

1. Clone the repository:
    ```bash
    git clone https://github.com/Shengwei0516/DataDriven-IGBT-Inverter-Modeling.git
    ```

2. Navigate to the repository directory:
    ```bash
    cd DataDriven-IGBT-Inverter-Modeling
    ```

3. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/stender/inverter-data-set/data) and place the files in the same directory as `main.m`.

4. Open MATLAB and set the repository directory as the current folder.

## Usage

Run the `main.m` script to perform data preprocessing, model training, evaluation, and visualization.

```matlab
run('main.m')
```

## Results

The script will generate performance metrics and plots demonstrating the accuracy of the phase voltage predictions by the ANN models. These results will be displayed in the MATLAB environment.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a Pull Request.

## Acknowledgements

We thank the LEA department at Paderborn University for providing the dataset used in this study. Special thanks to Professor Yih-Hua Liu of National Taiwan University of Science and Technology for his expertise and lectures in the "Applications of Power Electronics" course. We also acknowledge the support of the teaching assistants of the course.

## Contact

For any questions or inquiries, please contact us at m11207330@mail.ntust.edu.tw

