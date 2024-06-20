enum Duracion {
    15_MINUTOS(15), 30_MINUTOS(30), 1_HORA(60);

    // Duracion en minutos
    final int duracion;
    Duracion(this.duracion);

    @override
    String toString(){
        return this.name.replace('_', ' ').toBeginningOfSentenceCase();
    }
}