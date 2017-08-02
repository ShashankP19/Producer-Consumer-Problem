# Producer-Consumer-Problem

### Getting Started

Install Erlang. In the terminal go into the directory where the files are present. Type `erl` to start Erlang. Erlang shell is now ready. Next, compile all the files - master.erl, buffer.erl, producer.erl, consumer.erl and item.erl. To do so type `c(<filename>).` and press enter.
```
> c(master).
{ok,master}
> c(buffer).
{ok,buffer}
> c(producer).
{ok,producer}
> c(consumer).
{ok,consumer}
> c(item).
{ok,item}

```
To run the program type `master:init().`. The program will ask you to input the number of producers and consumers.
```
> master:init().
Input number of producers : 5
Input number of consumers : 4

```
The program then continues indefinitely. To pause the program press Ctrl + C. To quit the program press Ctrl + Z.
