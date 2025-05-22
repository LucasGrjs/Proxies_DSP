# Proxies_DSP
Proof of concepts and experimentations for the article : "Standardize Data Synchronization Policies for Distributed Agent-Based Simulations Using Proxies" for EUMAS2024 (https://euramas.github.io/eumas2024/)

# Requirements  
Java 17

mpirun (Open MPI) 4.1.4 (https://www.open-mpi.org/software/ompi/v4.1/)

Apache Maven 3.8.6

Java Binding for Open MPI (https://www.open-mpi.org/faq/?category=java)

# Compile the project

cd Gama_distribution/

cd gama

./travis/build.sh # compile the project (can take some time)

cd ../gama.experimental/gama.experimental.proxy/models/proxy/models # where to start the model execution

# How to start examples : 

./startMpiModel Article_example/GhostMode.xml 2

./startMpiModel Article_example/HardSync.xml 2

./startMpiModel Article_example/DSP.xml 2

# Results 
All the results (png) of these examples can be found in /output.log/snapshot/0 or /output.log/snapshot/1 after the execution of the models.


# Disclaimer
As these models are just proof of concepts, some exception may emerge and you will have to stop the execution when they reach end.
Some SIGSEGV error happen at the end of some execution due to the disposal of shared ressources between processors.
As a result of these SIGSEGV will generate hs_err_pid report, please ignore them or delete them.

