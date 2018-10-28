#This is a basic genetic algorithm that prompts the user to enter a target, and the computer
#creates populations of guesses whose fitnesses are then determined, and the program loops
#until the maximum fitness is found, and displays how many generations AND the time elapsed
#that the program has went through to find the peak efficiency.



#importing python modules
import random
import datetime 
geneSet = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!'£$%^&().1234567890<>[]{}" #defines the gene set for the algorithm to use
target = input(str("What string would you like the algorithm to guess?:  ")) # asks the user for the target -- **NB**Limitations are that the target cannot be of greater length than the geneSet


def generate_primary_generation(length):#generates initial population (parents)
    genes_primary_generation = []
    while len(genes_primary_generation) < length:#loops until the length of the parent genes is equal to the length of the target.
        genes_primary_generation.extend(random.sample(geneSet, len(target)))#adds random characters from geneSet whose length is equal to extractSize
    return ''.join(genes_primary_generation)


def calculate_fitness(guess):#this method calculates how many times (total) a string in [guess] is present in [target]. In effect, the higher the total, the higher the fitness.
    str(guess)
    str(target)
    total = 0
    for i in range(len(target)):#goes through every character in the guess, and compares it to the character in the same position of the target. If the character is in the same place, then total is incremented.
        if guess[i] == target[i]:
            total = total +1
    return total
   
    
            
def mutate(primary_generation):#mutates (or changes) the primary generation into a secondary generation(improvement from primary generation comes after function declarations)
    index_random = random.randrange(0, len(primary_generation)) #chooses a random number in the range of 0=>the length of the genes of the primary generation
    genes_secondary_generation = list(primary_generation)
    new_genes, different = random.sample(geneSet, 2)
    if new_genes == genes_secondary_generation[index_random]:#checking that the new values of the new genes don't equal the same string as the old genes, improving efficiency
        genes_secondary_generation[index_random] = different
    else:
        genes_secondary_generation[index_random] = new_genes
    return ''.join(genes_secondary_generation)


def display(guess):#displays time elapsed, and all data about every generation
    time_elapsed = datetime.datetime.now() - start_time
    fitness = calculate_fitness(guess)
    print("{0}\t---GENERATION {1}---\t{2}".format(guess, fitness, str(time_elapsed)))


#defining key variables
random.seed()
start_time = datetime.datetime.now()
best_pg = generate_primary_generation(len(target))#calls the function that creates initial population.
best_fitness_pg = calculate_fitness(best_pg)
display(best_pg)



while True:
    secondary_g = mutate(best_pg)#creating the next generation from the primary generation
    fitness_sg = calculate_fitness(secondary_g) #calculating the fitness of the secondary generation using calculate_fitness

    if best_fitness_pg >= fitness_sg:#checking that the fitness is not at the maximum potential, and if it is, stopping the loop.
        continue
    display(secondary_g)
    if fitness_sg >= len(best_pg):
        break
    best_fitness_pg = fitness_sg#setting new values to be compared against in the next iteration
    best_pg = secondary_g    
input()#fixes bug of program closing immediately after enter is pressed.
