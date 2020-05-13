# Commuters analysis

Methods developped by Marianne Guérois & Laurent Beauguitte.

The statmat function provides for a source origin matrix a certain number of useful elements for knowing the initial data but also statistically justifying the method or the selected threshold. We obtain in particular the total volume of flows and the basic statistical indicators on these flows (quartiles, average, etc.), the density, the number, the size and the composition of the related components, the weighted and unweighted degree of the vertices. Graphical outputs are used to study the distribution of degrees (weighted and unweighted) and links (mustache box and Lorenz curve on the intensity of flows).

With regard to selection, three families of methods are implemented:

- classic dominant flows
- local criteria (for each summit, keep the flows satisfying such criteria)
- global criteria (considering all flows, keep those satisfying such criteria).

In our methods, we choose global criterion to analyse the most used paths.

- Flow selection from Origins: above the median
- DominantFlows selects which flow (fij or fji) must be kept. If the ratio weight of destination (wj) / weight of origin (wi) is greater than 1.

## Global commuters

1. Taking into account the whole dataset: 
    - 177861 flows (sum of all fij) from 38851 users
    - nb. links: 645 
    - density: 0.9923077 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 177861 
    - min: 1 
    - Q1: 5 
    - median: 16 
    - Q3: 58 
    - max: 46297 
    - mean: 275.7535 
    - sd: 2104.854 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatGlobal.png)  |  ![](commutersGLOBAL.png)

2. Taking into account comments by Australia's user: 
    - 1367 flows from 374 users
    - nb. links: 127 
    - density: 0.2509881 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 1367 
    - min: 1 
    - Q1: 1 
    - median: 2 
    - Q3: 4.5 
    - max: 402 
    - mean: 10.76378 
    - sd: 42.32836 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatAustralia.png)  |  ![](commutersAustralia.png)

3. Taking into account comments by Belgium's user: 
    - 16617 flows from 4084 users
    - nb. links: 304 
    - density: 0.4676923 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 16617 
    - min: 1 
    - Q1: 1 
    - median: 3 
    - Q3: 8.25 
    - max: 3728 
    - mean: 54.66118 
    - sd: 316.4072 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatBelgium.png)  |  ![](commutersBelgium.png)

4. Taking into account comments by Brazil's user: 
    - 632 flows from 129 users
    - nb. links: 66 
    - density: 0.1571429 
    - nb. of components (weak) 2 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 632 
    - min: 1 
    - Q1: 1 
    - median: 1 
    - Q3: 2 
    - max: 334 
    - mean: 9.575758 
    - sd: 41.59107

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatBrazil.png)  |  No dominant flows.

5. Taking into account comments by Canada's user: 
    - 989 flows from 255 users
    - nb. links: 122 
    - density: 0.2210145 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 989 
    - min: 1 
    - Q1: 1 
    - median: 1 
    - Q3: 3 
    - max: 189 
    - mean: 8.106557 
    - sd: 25.35461 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatCanada.png)  |  ![](commutersCanada.png)

6. Taking into account comments by France's user: 
    - 129063 flows from 26325 users
    - nb. links: 627 
    - density: 0.9646154 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 129063 
    - min: 1 
    - Q1: 4 
    - median: 13 
    - Q3: 43.5 
    - max: 35546 
    - mean: 205.8421 
    - sd: 1596.727 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatFrance.png)  |  ![](commutersFrance.png)

7. Taking into account comments by Germany's user: 
    - 909 flows from 248 users
    - nb. links: 111 
    - density: 0.2193676 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 909 
    - min: 1 
    - Q1: 1 
    - median: 1 
    - Q3: 3 
    - max: 199 
    - mean: 8.189189 
    - sd: 23.93837

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatGermany.png)  |  ![](commutersGermany.png)

8. Taking into account comments by Italy's user: 
    - 1546 flows from 402 users
    - nb. links: 170 
    - density: 0.2833333 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 1546 
    - min: 1 
    - Q1: 1 
    - median: 2 
    - Q3: 3 
    - max: 483 
    - mean: 9.094118 
    - sd: 39.7354

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatItaly.png)  |  ![](commutersItaly.png)

9. Taking into account comments by Netherlands's user: 
    - 2784 flows from 709 users
    - nb. links: 188 
    - density: 0.2892308 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 2784 
    - min: 1 
    - Q1: 1 
    - median: 1.5 
    - Q3: 4 
    - max: 1352 
    - mean: 14.80851 
    - sd: 100.9047

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatNetherlands.png)  |  ![](commutersNetherlands.png)

10. Taking into account comments by Russia's user:  
    - 877 flows from 130 users
    - nb. links: 113 
    - density: 0.2445887 
    - nb. of components (weak) 2 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 877 
    - min: 1 
    - Q1: 1 
    - median: 1 
    - Q3: 3 
    - max: 308 
    - mean: 7.761062 
    - sd: 31.0832 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatRussia.png)  |  ![](commutersRussia.png)

11. Taking into account comments by Spain's user: 
    - 848 flows from 203 users
    - nb. links: 108 
    - density: 0.18 
    - nb. of components (weak) 2 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 848 
    - min: 1 
    - Q1: 1 
    - median: 1 
    - Q3: 3 
    - max: 223 
    - mean: 7.851852 
    - sd: 25.16258 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatSpain.png)  |  ![](commutersSpain.png)

12. Taking into account comments by Switzerland's user: 
    - 659 flows from 164 users
    - nb. links: 98 
    - density: 0.1633333 
    - nb. of components (weak) 2 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 659 
    - min: 1 
    - Q1: 1 
    - median: 1 
    - Q3: 3 
    - max: 279 
    - mean: 6.72449 
    - sd: 28.95634 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatSwitzerland.png)  |  ![](commutersSwitzerland.png)

13. Taking into account comments by UK's user: 
    - 19528 flows from 5272 users
    - nb. links: 386 
    - density: 0.5938462 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 19528 
    - min: 1 
    - Q1: 1 
    - median: 3 
    - Q3: 11 
    - max: 3846 
    - mean: 50.59067 
    - sd: 283.8452 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatUK.png)  |  ![](commutersUK.png)

14. Taking into account comments by USA's user: 
    - 2042 flows from 556 users
    - nb. links: 192 
    - density: 0.32 
    - nb. of components (weak) 1 
    - nb. of components (weak, size > 1) 1 
    - sum of flows: 2042 
    - min: 1 
    - Q1: 1 
    - median: 1.5 
    - Q3: 3 
    - max: 499 
    - mean: 10.63542 
    - sd: 42.21427 

Statistics             |  Commuters at 5%
:-------------------------:|:-------------------------:
![](statmatUSA.png)  |  ![](commutersUSA.png)
