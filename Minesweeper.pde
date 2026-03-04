import de.bezier.guido.*;
private int NUM_ROWS;
private int NUM_COLS;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>();
private int nmines; 
private int numClicked;

void setup ()
{
    background(245,221,220);
    size(300, 400);
    textAlign(CENTER,CENTER);
    stroke(134,57,53);
    // make the manager
    Interactive.make( this );
    //your code to initialize buttons goes here
    levelButtons();
    
}

public void mouseClicked() {
  if(numClicked != 1) {
    textAlign(CENTER,CENTER);
    if(mouseX>=20&&mouseX<=80&&mouseY>=200&&mouseY<=220) {
      NUM_ROWS = 10;
      NUM_COLS = 10;
      nmines = 5;
      numClicked++;
      initializeMines();
      setMines();
      fill(173,115,113);
      //text("Mines left: "+String.valueOf(, 150, 350); 
    } else if(mouseX>=120&&mouseX<=180&&mouseY>=200&&mouseY<=220) {
      NUM_ROWS = 15;
      NUM_COLS = 15;
      nmines = 10;
      numClicked++;
      initializeMines();
      setMines();
      fill(173,115,113);
      //text("Mines left: "+String.valueOf(, 150, 350);
    } else if(mouseX>=220&&mouseX<=280&&mouseY>=200&&mouseY<=220) {
      NUM_ROWS = 20;
      NUM_COLS = 20;
      nmines = 15;
      numClicked++;
      initializeMines();
      setMines();
      fill(173,115,113);
      //text("Mines left: "+String.valueOf(, 150, 350);
    } else {
      text("please choose a level", 150,250); 
    }
  } 
  
}
public void initializeMines() {
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i<buttons.length;i++){
     for (int j = 0; j<buttons[i].length;j++) {
        buttons[i][j] = new MSButton(i,j);
     }
    }
}

public void levelButtons() {
    textAlign(CENTER,CENTER);
    fill(245,205,205);
    rect(20,200,60,20);
    rect(120,200,60,20);
    rect(220,200,60,20);
    fill(170,118,118);
    text("Level 1", 50, 210);
    text("Level 2", 150, 210);
    text("Level 3", 250, 210);
}

public void setMines()
{
   int row; 
   int col; 
   
   for(int i = 0; i< nmines; i++) {
     row = (int)(Math.random()*NUM_ROWS);
     col =(int)(Math.random()*NUM_COLS);
   
     if(!mines.contains(buttons[row][col])) {
        mines.add(buttons[row][col]);
     }
   }
  
}

public void draw ()
{
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
  fill(173,115,113);  
  text("Game Over, Reload to Play Again", 150, 350);
}
public void displayWinningMessage()
{
    //your code here
}

public boolean isValid(int r, int c)
{
    if(r<0||c<0||r>=NUM_ROWS||c>=NUM_COLS) { return false; }
    else { return true; }
}

public int countMines(int row, int col)
{
    int numMines = 0;
    for(int i = row-1; i<=row+1; i++) {
      for(int j = col-1; j<=col+1; j++) {
        if(isValid(i,j)==true && mines.contains(buttons[i][j])) {
          numMines++;
        }
      }
    }
  if(mines.contains(buttons[row][col])) {
    numMines--;
  }
  return numMines;
}





public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 300/NUM_COLS;
        height = 300/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mousePressed && mouseButton == RIGHT) {
          if(flagged == true) {
           flagged = false;
           clicked = false;
          } else if(flagged == false) {
            flagged = true;
          } 
        } else if(mines.contains(this)) {
            displayLosingMessage();
        } else if(countMines(this.myRow,this.myCol)>0) {
            setLabel(countMines(this.myRow,this.myCol));
        } else {
          if(isValid(this.myRow,this.myCol-1)&&buttons[this.myRow][this.myCol-1].clicked == false) {
            buttons[this.myRow][this.myCol-1].mousePressed();
          } if(isValid(this.myRow,this.myCol+1)&&buttons[this.myRow][this.myCol+1].clicked == false) {
            buttons[this.myRow][this.myCol+1].mousePressed();
          }if(isValid(this.myRow-1,this.myCol-1)&&buttons[this.myRow-1][this.myCol-1].clicked == false) {
            buttons[this.myRow-1][this.myCol-1].mousePressed();
          } if(isValid(this.myRow-1,this.myCol+1)&&buttons[this.myRow-1][this.myCol+1].clicked == false) {
            buttons[this.myRow-1][this.myCol+1].mousePressed();
          }if(isValid(this.myRow-1,this.myCol)&&buttons[this.myRow-1][this.myCol].clicked == false) {
            buttons[this.myRow-1][this.myCol].mousePressed();
          } if(isValid(this.myRow+1,this.myCol)&&buttons[this.myRow+1][this.myCol].clicked == false) {
            buttons[this.myRow+1][this.myCol].mousePressed();
          } if(isValid(this.myRow+1,this.myCol-1)&&buttons[this.myRow+1][this.myCol-1].clicked == false) {
            buttons[this.myRow+1][this.myCol-1].mousePressed();
          } if(isValid(this.myRow+1,this.myCol+1)&&buttons[this.myRow+1][this.myCol+1].clicked == false) {
            buttons[this.myRow+1][this.myCol+1].mousePressed();
          }
        }
        
    }
    public void draw () 
    {    
        if (flagged)
            fill(188,123,70);
        else if( clicked && mines.contains(this) ) 
             fill(170,52,48);
        else if(clicked)
            fill( 203,162,136 );
        else 
            fill( 198,179,166 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
