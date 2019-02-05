import numpy as np
x = np.array([[1,0,0], [0,2,0], [1,1,0]])
print(x[np.nonzero(x)])
# but this doesn't quite do what I'd want in the general case.

