import de.bezier.guido.*;
private int NUM_ROWS;
private int NUM_COLS;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>();
private int nmines; 
public int flags;
private int numClicked;
private boolean initialized;
private boolean canWin = true;
private boolean canClick = true;
private PFont font;

void setup ()
{
    background(245,221,220);
    size(300, 400);
    font = createFont("UD デジタル 教科書体 N", 12);
    textFont(font);
    textAlign(CENTER,CENTER);
    stroke(134,57,53);
    // make the manager
    Interactive.make( this );
    //your code to initialize buttons goes here
    levelButtons();
    //String[] fontList = PFont.list();
    //printArray(fontList);
    
}

public void mouseClicked() {
  if(numClicked != 1) {
    textAlign(CENTER,CENTER);
    if(mouseX>=(width/7)&&mouseX<=(2*width/7)&&mouseY>=((height/2)-8)&&mouseY<=((height/2)+28)) {
      NUM_ROWS = 10;
      NUM_COLS = 10;
      nmines = 5;
      flags = nmines;
      numClicked++;
      initializeMines();
      setMines();
      fill(173,115,113);
      //text("Mines left: "+String.valueOf(, 150, 350); 
    } else if(mouseX>=120&&mouseX<=180&&mouseY>=200&&mouseY<=220) {
      NUM_ROWS = 15;
      NUM_COLS = 15;
      nmines = 10;
      flags = nmines;
      numClicked++;
      initializeMines();
      setMines();
      fill(173,115,113);
      //text("Mines left: "+String.valueOf(, 150, 350);
    } else if(mouseX>=220&&mouseX<=280&&mouseY>=200&&mouseY<=220) {
      NUM_ROWS = 20;
      NUM_COLS = 20;
      nmines = 15;
      flags = nmines;
      numClicked++;
      initializeMines();
      setMines();
      fill(173,115,113);
      
    } else {
      noStroke();
      fill(245,221,220);
      rect(-1,225,400,200);
      stroke(134,57,53);
      fill(173,115,113);
      text("please choose a level", width/2,250); 
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
    initialized = true;
}


public void levelButtons() {
    textAlign(CENTER,CENTER);
    fill(245,205,205);
    rect(20,200,60,20);
    rect(120,200,60,20);
    rect(220,200,60,20);
    fill(170,118,118);
    textSize(24);
    text("Choose a Difficulty", width/2, height/4); 
    textSize(12);

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
  if(initialized == true) {
    noStroke();
    fill(245,221,220);
    rect(0,300,400,40);
    stroke(134,57,53);
    fill(173,115,113);
    text("Flags Left: " + String.valueOf(flags), 150, 330);
    if(flags <= 0) {
      noStroke();
      fill(245,221,220);
      rect(0,340,400,50);
      stroke(134,57,53);
      fill(173,115,113);
      text("No Flags Remaining", 150, 350);
      text("Left-Click on flagged tiles to Unflag", 150, 365);
    }
    if(isWon() == true && canWin == true){
       noStroke();
       fill(245,221,220);
       rect(0,300,400,200);
       stroke(134,57,53);
       displayWinningMessage();
    }
  }
}
public boolean isWon()
{
  int count = 0;  
  for(int i = 0; i<buttons.length; i++){
      for(int j = 0; j<buttons[i].length; j++) {
        if(buttons[i][j].clicked == true && !mines.contains(buttons[i][j])) {
          count++;
        }
      }
    }
    if(count == ((NUM_ROWS*NUM_COLS)-nmines)) {
      return true;
    }else {
      return false;
    }
}
public void displayLosingMessage()
{
  
  
  for(int i = 0; i<buttons.length; i++) {
    for(int j = 0; j<buttons[i].length; j++) {
      if(buttons[i][j].clicked == false) {
        buttons[i][j].clicked = true;  
      }
    }
  }
  canWin = false;
  fill(173,115,113);  
  textAlign(CENTER,CENTER);
  text("Game Over, Reload to Play Again", width/2, 350);
}
public void displayWinningMessage()
{
  fill(173,115,113);  
  textAlign(CENTER,CENTER);
  text("You've uncovered all unmined land", width/2, 345);
  text("To play again, reload the page", width/2, 355); 
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
        if(canClick == true) {
          if(mousePressed && mouseButton == LEFT) {
            clicked = true;
          }
          if(mousePressed && mouseButton == RIGHT&&flags>0) {
            if(flagged == true) {
             flagged = false;
             flags++;
             clicked = false;
            } else if(flagged == false) {
              flagged = true;
              flags--;
            } 
          } else if(mousePressed && mouseButton == RIGHT && flags<=0) { 
            if(flagged == true) {
             flagged = false;
             flags++;
             clicked = false;
             noStroke();
             fill(245,221,220);
             rect(0,300,400,200);
             stroke(173,115,113);
            } 
          }else if(mines.contains(this)) {
              displayLosingMessage();
              canClick = false;
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
        fill(134,57,53);  
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
