# Proxies_DSP
Proof of concepts and experimentations for the article : "Introducing data synchronisation policies for distributed agent-based model using proxies" for SCAI2024 (https://ju.se/en-GB/16/1304254.html)

# Requirements  
mpirun (Open MPI) 4.1.4

# How to start examples : 
./startMpiModel Article_example/HardSync.xml 2
./startMpiModel Article_example/GhosMode.xml 2
./startMpiModel Article_example/DSP.xml 2

# Results 
All the results of these examples can be found in /output.log/snapshot/0 or /output.log/snapshot/1 after the execution of above model.


# Disclaimer
As these models are just proof of concepts, you will have to stop the execution when they reach end.
Some SIGSEGV error happen at the end of some execution due to the disposal of shared ressources between processors.
As a result of these SIGSEGV will generate hs_err_pid report, please ignore them or delete them.

