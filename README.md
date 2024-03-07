# Recommendation System using user reviews from Steam 🎮

In this repository you will find my project for the **Network Science** exam at UniMi. 

In this case, I took a [dataset](https://www.kaggle.com/datasets/antonkozyriev/game-recommendations-on-steam) from Kaggle containing 41 million game-reviews published on the Steam platform from October 2010 to December 2022.

<figure>
    <img src="https://logos-world.net/wp-content/uploads/2020/10/Steam-Logo.png" width="185" height="100">
    <figcaption>Steam logo.</figcaption>
</figure>

The objective was to create a Reccomendation System for popular Steam games using reviews from June 2022 to December 2022 using the unsupervised learning algorithm **Node2Vec**.

#### Steps

I first preprocessed the afore mentioned dataset using **R**, in particular with the `dplyr` package of the tidyverse. Then I moved to **Python** where I created the graph thanks to the `networkx` library which was also the tool of choice to perform the study.

#### Main results

The obtained graph, already color-coded according to the [Louvain communities](https://en.wikipedia.org/wiki/Louvain_method) is:

<figure>
    <img src="https://raw.githubusercontent.com/guber25/RecSys_Steam_Reviews/main/Images/Louvain%20plot.png" width="500" height="500">
    <figcaption>Steam popular games graph.</figcaption>
</figure>

Overall, **Node2Vec** performed well suggesting games of the same saga or of the same genre.

If you have any questions or suggestions feel free to contact me via e-mail or on [linked-in](https://www.linkedin.com/in/guglielmo-berzano/)! 💻🎮
