var float: R; % quarterly repayment
var float: P; % principal initially borrowed
var 0.0 .. 2.0: I; % interest rate

var float: B1; % balance after Q1
var float: B2; % balance after Q2
var float: B3; % balance after Q3
var float: B4; % balance after a year (Q4)

constraint B1 = P * (1.0 + I) - R;
constraint B2 = B1 * (1.0 + I) - R;
constraint B3 = B2 * (1.0 + I) - R;
constraint B4 = B3 * (1.0 + I) - R;

solve satisfy;

output ["total = \(B4)"]