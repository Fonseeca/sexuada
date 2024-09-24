class Sexuada {
    float sexo;
    float[] dna = new float[3];

    Sexuada(float[]mae, float[]pai){
        this.dna[0] = pai[0];
        this.dna[1] = mae[1];
        this.dna[2] = mae[2];

        this.sexo = int(10*(dna[0] + dna[2])) % 2;
    }
    
    Organismo reproducao(PVector posicao){
      
      // mutacao
      for(int k = 0; k < dna.length; k++)
        if(random(1) < 0.001) dna[k] = constrain(dna[k] + random(-0.1, 0.1), 0, 1);
      return new Organismo(posicao, dna, sexo);
    }
}
