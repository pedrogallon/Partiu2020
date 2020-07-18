
class User {
    id: number
    tipo: string
    cpf: string
    nome: string
    nascimento: string
    email: string
    telefone: string
    genero: string
    senha: string
    endereco: number

    constructor(id: number, tipo: string, cpf: string, nome: string, nascimento: string, email: string, telefone: string, genero: string, senha: string, endereco: number) {
        this.id = id
        this.tipo = tipo
        this.cpf = cpf
        this.nome = nome
        this.nascimento = nascimento
        this.email = email
        this.telefone = telefone
        this.genero = genero
        this.senha = senha
        this.endereco = endereco
    }
}