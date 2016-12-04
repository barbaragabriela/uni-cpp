# College Scheduling

The goal of this task is to build a weekly schedule for the lectures of a university, taking in care that there exists several courses, several groups per course, one lecturer by lecture  each course has a theory lecture and a lab lecture. There is also the restriction of number of lecturers per course and the number of laboratory and theory rooms. Taking all this in care the model was built and was tested with several instances.

The solution for the given instance was the following:

|       |          Monday          |        Tuesday        |       Wednesday       | Thursday | Friday |
| :---: | :----------------------: | :-------------------: | :-------------------: | :------: | :----: |
| 9:00  | c5g1 Theory, c5g2 Theory |  c5g1 Lab, c5g2 Lab   | c1g1 Lab, c1g2 Theory | c1g2 Lab |        |
| 10:00 | c4g1 Theory, c4g2 Theory | c1g1 Theory, c4g2 Lab |       c2g1 Lab        |          |        |
| 11:00 | c3g1 Theory, c3g2 Theory |  c3g2 Lab, c4g1 Lab   |                       |          |        |
| 12:00 | c2g1 Theory, c2g2 Theory |  c2g2 Lab, c3g1 Lab   |                       |          |        |





And the following schedule is if there was only one lecturer for course (cant overlap two groups of the same course in one slot)

|       |   Monday    |   Tuesday   |  Wednesday  | Thursday |  Friday  |
| :---: | :---------: | :---------: | :---------: | :------: | :------: |
| 9:00  | c5g2 Theory |  c5g2 Lab   | c2g1 Theory | c2g1 Lab | c4g1 Lab |
| 10:00 | c5g1 Theory | c3g2 Theory | c1g2 Theory | c1g2 Lab | c3g2 Lab |
| 11:00 | c4g2 Theory | c3g1 Theory | c1g1 Theory | c1g1 Lab | c3g1 Lab |
| 12:00 | c4g1 Theory | c2g2 Theory |  c5g1 Lab   | c4g2 Lab | c2g2 Lab |



   

The next test were done removing some of the resources from the original instance.

| instance                                 | satisfiable? | time  |
| ---------------------------------------- | ------------ | ----- |
| original instance given                  | Yes          | 271ms |
| one lecturer by course                   | Yes          | 258ms |
| 3 available rooms for theory and labs    | Yes          | 276ms |
| 3 rooms and one professor by course      | Yes          | 262ms |
| 10 courses, 3 rooms, 1 lecturer per course |              | --    |
| original but add one more course         |              | --    |
| original adding one more group per course |              | --    |
| 10 courses, 5 lecturers by course, 2 groups | Yes          | 492ms |

_— means didnt finish in 5 minutes_

It seems that the part where the model struggles is when the number of lecturers and the number of groups is similar, when the number of courses is 5, its ok to have 2 groups and 2 lecturers by course but even changing the courses to 6, it doesnt finish in less than 5 minutes. And if we aument the number of groups, the model finds a solution a bit faster.

## Symmetry breaking

### Groups ordering

For symmetry breaking I contrainted the model to have the groups in order. But because how I wrote the other constrains, the schedule puts the first courses at the end of the week, so the order of groups goes in decreasing order, if its in decreasing order the solver gets the solution in ~50ms less than the original solution without symmetry breaking, 234ms. If I constrain the groups to be in increasing order it even takes more than the original ~282ms.

### Course ourdering

Adding the course ordering the time decreases to 201ms

---

The times reported are the mean of 15 runs of each instance.

