// Parâmetros da Simulação
int tamanhoDaPopulacao = 100;    // Tamanho da população
int geracao = 0;                // Contador de gerações
ArrayList<Organismo> populacao; // Lista de organismos
ArrayList<PVector> comida;      // Lista de recursos
int quantidadeRecursos = 10;   // Número de recursos no ambiente
int tempoDeVida = 100;          // Duração de cada geração em frames
int contadorDeFrames = 0;       // Contador de frames
float sexo;

void setup() {
  size(800, 600);
  populacao = new ArrayList<Organismo>();
  comida = new ArrayList<PVector>();
  
  // Inicializa a população
  for (int i = 0; i < tamanhoDaPopulacao; i++) {
    float[] dna = new float[3];
    for(int k = 0; k < dna.length; k++) dna[k] = random(1);
    
    sexo =  int(10*(dna[0] + dna[2])) % 2;
    populacao.add(new Organismo(new PVector(random(width), random(height)), dna, sexo));
  }
  
  // Inicializa os recursos
  for (int i = 0; i < quantidadeRecursos; i++) {
    comida.add(new PVector(random(width), random(height)));
  }
}

void draw() {
  background(255);
  
  // Atualiza e desenha os recursos
  for (PVector r : comida) {
    fill(0);
    ellipse(r.x, r.y, 10, 10);
  }
  
  // Atualiza e desenha os organismos
  int x = populacao.size();
  for (int i = x - 1; i >= 0; i--) {
    Organismo o = populacao.get(i); //<>//
    o.procuraComida();
    o.atualiza();
    o.mostra();
    
    // Verifica se está morto
    if (o.morreu()) {
      populacao.remove(i);
    } else {
      // Tentativa de reprodução
      if(random(1)<0.999) continue;
      
      x = populacao.size();
      for(int j = 0; j < x - 1; j++){
        Organismo outro = populacao.get(j);
         if (o.posicao.dist(outro.posicao) < (outro.tamanho + o.tamanho) && o.sexo != outro.sexo){
           Sexuada aux = new Sexuada(outro.dna, o.dna);
           Organismo filho = aux.reproducao(outro.posicao);
           o.vida -= 10;
           outro.vida -= 10;
            if (filho != null) {
              populacao.add(filho);
            }
         }
      }
      
    }
  }
  
  // Contador de frames para controlar as gerações
  contadorDeFrames++;
  if (contadorDeFrames >= tempoDeVida) {
    novaGeracao();
    contadorDeFrames = 0;
    geracao++;
  }
    
  surface.setTitle("Geração: " + geracao + " | " + "População: " + populacao.size() + " | " + "Recursos: " + comida.size());
}

void novaGeracao() {
  // Reabastece os recursos
  comida.clear();
  for (int i = 0; i < quantidadeRecursos; i++) {
    comida.add(new PVector(random(width), random(height)));
  }
  
  // Se a população estiver muito pequena, adiciona novos organismos
  if (populacao.size() < 10) {
    for (int i = 0; i < 10; i++) {
      float[] dna = new float[3];
      for(int k = 0; k < dna.length; k++) dna[k] = random(1);
          sexo =  int(10*(dna[0] + dna[2])) % 2;

      //populacao.add(new Organismo(new PVector(random(width), random(height)), dna, sexo));
    }
  } 
}
