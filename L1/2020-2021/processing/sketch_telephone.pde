// ==============================================================================
// ==============================================================================

int[] numbers = new int[10];
int nchiffres = 0;
int v1 = 255;
int v2 = 0;
int v3 = 0;
boolean estDecroche = false;
boolean appelSortant = false;
boolean appelEntrant = false;
boolean sonnerie = false;

// ------------------------------------------------------------------------------
void setup() {
  size(300, 300);
  noStroke();
  background(0);
}

// ==============================================================================
void draw() { 
  
  fill(v1,v2,v3);
  rect(25, 25, 50, 50);
  
  // Verifie si le cornet du telephone est decroche (true) ou racroche (false)
  estDecroche = positionCornet();
  
  if (estDecroche==true)
  {
    // cornet decroche -> signalisation en affichant un carre vert
    v1=0; v2=255; v3=0;
    
    // verifie si un appel est en attente d'acceptation
    if (sonnerie==true)
    {
      // appel pris 
      sonnerie=false;
      appelEntrant = true;
      println("En communication (entrante)");
    }
    
    // pret pour appeler?
    if (isNumeroComplet() && appelSortant==false && appelEntrant==false)
    {
      // appelle le numero composé
      GSMappelleNumero();
      appelSortant = true;
      println("En communication (sortante)");
    }
    
    if (appelSortant==true)
    {
      // communication etablie; en conversation
      estDecroche = positionCornet();
    }
  }
  else
  {
    // affiche carre vert
    v1=255; v2=0; v3=0;    
    nchiffres = 0;
    sonnerie = GSMrecoitAppel();
  }
  
}

// ==============================================================================
// ==============================================================================
boolean positionCornet()
{
  return estDecroche;
}

// ==============================================================================
boolean isNumeroComplet()
{
  return (nchiffres==10); //numeroComplet;
}

// ==============================================================================
void GSMappelleNumero()
{
  print("Appelle le : ");
  for (int i=0; i < 10; i++) { 
    print(numbers[i]);
  }
  println();
}

// ==============================================================================
boolean GSMrecoitAppel()
{
  return sonnerie;
}


// ==============================================================================
// Evenements

void keyPressed() 
{
  int keyIndex = -1;
  if (estDecroche==true && appelSortant==false)
   if (key >= '0' && key <= '9') 
   {
     keyIndex = key - '0';
     println(keyIndex);
     numbers[nchiffres] = keyIndex; 
     nchiffres++;
   } 
   
   if (estDecroche==false && appelSortant==false && appelEntrant==false && sonnerie==false)
    if (key == 'A' || key == 'a') 
    {
      sonnerie=true;
      println("dring");
    } 
 
}


void mouseClicked() {
  if (estDecroche==false)
  {
    estDecroche=true;
    println("Décroché!");
  }
  else
  {
    estDecroche=false;
    println("Raccroché!");
    appelEntrant=false;
    appelSortant=false;
  }
}
