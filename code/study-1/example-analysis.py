from statistics import fmean

def mean_score(values):
    """Return the mean of a non-empty sequence."""
    if not values:
        raise ValueError("values must not be empty")
    return fmean(values)

def normalise(values):
    """Scale values by their largest absolute magnitude."""
    scale = max(abs(value) for value in values)
    return [value / scale for value in values]
