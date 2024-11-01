# My notes

#### matplotlib

When qt fails, use

```python
matplotlib.use('Agg')
```

This doesn't support interactive but can save figures



set default configs (for all options see [here](https://matplotlib.org/stable/users/explain/customizing.html#the-default-matplotlibrc-file))

```python
matplotlib.rc('axes', titlesize=22, labelsize=18)
matplotlib.rc('figure', figsize=(10, 6), dpi=300)
```

#### Mac set iTerm2 override system light mode

https://stackoverflow.com/questions/78526264/how-to-set-iterm2-color-to-darkmode-with-powerlevel10k

