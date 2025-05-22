# Proxies_DSP
Proof of concepts and experimentations for the article : "Standardize Data Synchronization Policies for Distributed Agent-Based Simulations Using Proxies" for EUMAS2024 (https://euramas.github.io/eumas2024/)

# Requirements  
Java 17

mpirun (Open MPI) 4.1.4 (https://www.open-mpi.org/software/ompi/v4.1/)

Apache Maven 3.8.6

Java Binding for Open MPI (https://www.open-mpi.org/faq/?category=java)

# Compile the project

cd gama

./travis/build.sh # compile the project (can take some time)

# How to start examples : (in Proxies_DSP/ directory)

./startMpiModel Article_example/GhostMode.xml 2

./startMpiModel Article_example/HardSync.xml 2

./startMpiModel Article_example/DSP.xml 2

# Results 
All the results (png) of these examples can be found in /output.log/snapshot/0 or /output.log/snapshot/1 after the execution of the models.

Results of GhostMode execution will be located in /output.log/snapshot/1 as GhostModeX.png where X represente the cycle number

Results of HardSync execution will be located in /output.log/snapshot/0 as HardSyncX.png where X represente the cycle number

Results of DSP execution will be located in /output.log/snapshot/0 as DSPX.png where X represente the cycle number


# Disclaimer
As these models are just proof of concepts, some exception may emerge and you will have to stop the execution when they reach end (especially HardSync.xml).

Some SIGSEGV error happen at the end of some execution due to the disposal of shared ressources between processors.

As a result of these SIGSEGV will generate hs_err_pid report, please ignore them or delete them.

You might need to start some model a couple of time to get them running properly (especially DSP.xml).

