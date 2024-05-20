int generation = 1;
int num_of_cell = 300;
int edge = 5;
int[][] matrix = new int[num_of_cell][num_of_cell];
int[][] next_gen_matrix = new int[num_of_cell][num_of_cell];

void setup() {
  
  size(1500, 1500);
  initializeMatrix();
}

void initializeMatrix() {
  // set custom logic here
 for (int i = 0; i < num_of_cell; i++) {
    for (int k = 0; k < num_of_cell; k++) {
      int[] array = {0, 1, 2};
      java.util.Random r = new java.util.Random();
      int a = array[r.nextInt(array.length)];
      if(a == 0){
        matrix[i][k] = 255;
      }else{
        matrix[i][k] = 0;
      }
    }
  }
}

void draw() {
  System.out.println("Gen:" + generation);
  //clear background with white;
  background(255); 
  nextGenMatrix();
  drawMatrix();
  count_up_generation();
}

void nextGenMatrix(){
  for(int i=0;i<num_of_cell;i++){
    for(int j=0;j<num_of_cell;j++){
      int cell_status = scan_sell(matrix, i,j);
      next_gen_matrix[i][j] = cell_status;
    }
  }

  //copy to next gen to current matirx
    for(int i=0;i<num_of_cell;i++){
      for(int j=0;j<num_of_cell;j++){
        matrix[i][j] = next_gen_matrix[i][j];
    }
  }
}

void count_up_generation(){
  generation++;
}

void drawMatrix(){
  stroke(0);

  for (int i = 0; i < num_of_cell; i++) {    
    for (int j = 0; j < num_of_cell; j++) {
      fill(matrix[i][j]);
      rect(j * edge, i * edge, edge, edge);  
    }
  }
}

int scan_sell(int[][] matrix, int i, int j) {
  // definition of adjacent of the cells 
  // left above above right above 
  // left  self right
  // left below below right below
  int[][] adjacent_cell = {
    {-1, 1}, {0, 1}, {1, 1}, 
    {-1, 0}, {1, 0}, 
    {-1, -1}, {0, -1}, {1, -1}
  };

  int counter = 0;
  for (int k = 0; k < adjacent_cell.length; k++) {
    // use exception. cut corner.
    try {
      // 
      int x_axis = adjacent_cell[k][0];
      int y_axis = adjacent_cell[k][1];
      if (matrix[i + x_axis][j + y_axis] == 255) {
        counter++;
      }
    } catch (ArrayIndexOutOfBoundsException e) {
      // Ignore when out of bounds
    }
  }

  // 
  if (counter <= 1) {
    return 0; 
  } else if (counter == 2) {
    return matrix[i][j]; 
  } else if (counter == 3) {
    return 255; 
  } else {
    return 0; 
  }
}


 