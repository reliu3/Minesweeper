import de.bezier.guido.*;
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>();

void setup ()
{
    size(400, 500);
    textAlign(CENTER,CENTER);
    stroke(134,57,53);
    // make the manager
    Interactive.make( this );
    //your code to initialize buttons goes here
    MSButton [][] buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i<buttons.length;i++){
     for (int j = 0; j<buttons[i].length;j++) {
        buttons[i][j] = new MSButton(i,j);
     }
    }
    
    
    setMines();
}
public void setMines()
{
   int row; 
   int col; 
   
   for(int i = 0; i< 10; i++) {
     row = (int)(Math.random()*NUM_ROWS);
     col =(int)(Math.random()*NUM_COLS);
   
     if(!mines.contains(row) && !mines.contains(col)) {
      mines.add(new MSButton(row,col));
   }
   }
  
}

public void draw ()
{
    background(245,221,220);
    fill(173,115,113);
    text("Mines left: "+String.valueOf(countMines(NUM_ROWS,NUM_COLS)), 200, 450); 
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
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    //your code here
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
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
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
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
        //your code here
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
