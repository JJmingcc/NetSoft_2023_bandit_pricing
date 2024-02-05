# Dynamic pricing for heterogenous edge resources
This repo contains the implementation of the code for paper: [A Bandit Approach to Online Pricing for Heterogeneous Edge Resource Allocation](https://arxiv.org/pdf/2302.06953.pdf).

In this paper, we propose to cast the problem as a multi-armed bandit problem and develop two novel online pricing mechanisms (**Online posted pricing scheme**), the Kullback-Leibler Upper Confidence Bound (KL-UCB) algorithm and the Min-Max Optimal algorithm, for heterogeneous edge resource allocation. These mechanisms operate in real-time and do not require prior knowledge of demand distribution, which can be difficult to obtain in practice. The proposed posted pricing schemes allow users to select and pay for their preferred resources, with the platform dynamically adjusting resource prices based on observed historical data. Numerical results show the advantages of the proposed mechanisms compared to several benchmark schemes derived from traditional bandit algorithms, including the Epsilon-Greedy, basic UCB, and Thompson Sampling algorithms.

In this repo, it covers several different techniques to remcommend arm:
- Proposed:\\
- **Kullback-Leibler Upper Confidence Bound (KL-UCB)**: [Arxiv](https://proceedings.mlr.press/v19/garivier11a/garivier11a.pdf) 
- **Min-Max Optimal algorithm (MOSS)**: [Arxiv](https://www.di.ens.fr/willow/pdfscurrent/COLT09a.pdf)

- Baseline:\\
- **UCB**: [Arxiv](https://homes.di.unimi.it/~cesabian/Pubblicazioni/ml-02.pdf)
- **Epsilon-Greedy (EG)**: [Arxiv](https://arxiv.org/pdf/1904.07272.pdf)
- **Thompson Sampling (TS)**: [Arxiv](https://arxiv.org/pdf/1205.4217.pdf)

## Get started
For general bandit algorithm, it includes the two parts: exploration and exploitation. Bandit based pricing algorithm will recommend the price arm with highest expected reward.

### Results
Please refer to results in the 'result' folder:


## Citation and Acknowledgements
**Bibtex.**
If you find our code useful for your research, you can refer to our paper that considers multiple uncertainties in the problem [paper](https://ieeexplore.ieee.org/document/10175461):
```bibtex

@article{cheng2023bandit,
  title={A Bandit Approach to Online Pricing for Heterogeneous Edge Resource Allocation},
  author={Cheng, Jiaming and Nguyen, Duong Thuy Anh and Wang, Lele and Nguyen, Duong Tung and Bhargava, Vijay K},
  journal={arXiv preprint arXiv:2302.06953},
  year={2023}
}
```

## Contact
Please submit a GitHub issue or contact [jiaming@ece.ubc.ca](mailto:jiaming@ece.ubc.ca) if you have any questions or find any bugs.
