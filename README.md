# WiFi RSS based trilateration with MATLAB
MATLAB code that enables position estimation using trilateration technique based on the observed WiFi RSS.

## Example of Use
Let's assume that the test room is a 10 by 10 meters room (100 square meters) with a WiFi AP (Access Point) in each corner, so 4 APs in total.
First a distance estimation is necessary for all the WiFi APs. 
In order to get these distances you need to have the observed RSS (Received Signal Strength) vector containing all the WiFi RSS values for all WiFi APs.

Example of an input vector.
If you are in position (3, 4.5):
```
-53.6   %from AP1
-53.2   %from AP2
-55     %from AP3
-65.2   %from AP4
```
Then, this vector should be used as input to estimate_distance.m function:
```
>> estimate_distance(RSS)
```

The function will return a vector with estimated distances (d) between the current position and the APs. You should then create a matrix with the APs position. In this example case:
```
>> X = [0, 0; 0,10; 10,0; 10,10]
```
Now you should be ready to estimate a position based on these values:
```
>> trilateration_estimation( X, d, 3, 4.5, 0, 10, 0, 10 )
```
