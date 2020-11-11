# Error Detection Codes

While data is being transmited or stored in any device it may be corrupted due to noise caused by the medium of transmision or by physical damage to the storage devices. Error detection codes are used to, sort of travel back in time and get back the original data from the corrupted one. Most of the error detection codes use some additional space as a kind of redundancy to somehow encode the whole message. Some computation is also required to set this redundant bits at the transmiter end and also to figure out if any error had occured during transmision using this additional data at the receiver end. I have implemented 2 of such codes here...

## - Parity Codes
Parity Codes are used to detect one bit errors (odd number of errors) but they can't be corrected. The scheme uses a single bit to store the parity of the entire message. If the number of 1's in the message is odd then the parity bit is set making the parity of the entire message even. Else if the parity of the original message is even, parity bit is set to 0. Parity bit is sent along with the message to the receiver where it's correctness can be verified.
This is helpful in detecting odd number of bit flips but can't detect even number of bit flips.

## - Hamming Codes
Hamming codes are a great tool for detecting and correcting errors that occur while transferring data across various devices (transfer to different storage space) or for storage of data (transfer from present to future). Unlike simple parity check which uses a single bit to store the parity of the complete data block, hamming codes use multiple selected bits as a kind of redundancy to encode the actual data block. Hamming codes can detect and correct one bit errors. This idea can be extended to something called extended hamming codes which can additionally be used to detect two bit errors though they can't be corrected. Hamming codes were originally invented by Richard W. Hamming at bell labs in 1950's as a way of correcting errors in punched card readers. This project implements Hamming(15,11), a kind of hamming code which uses 15 bits for storage of which 11 are used to store actual data and 4 bits are used as redundant bits to somehow encode the actual data.
The intuation here, is by dividing the actual data block into smaller groups and by adding a parity bit to each group, error can be detected by asking a finite number of true or false questions regarding our actual data. The position of these special bits that we choose to hold the encoded data is important. Positions which are an integral power of 2, within the actual data are used to store these special bits such that each of them is part of one and only one group. The bit at zeroth power of 2 (position-1) encodes the parity of the group of data which has a 1 at the least significant bit (0th bit) in its position (address) eg: 0001, 0011 etc. Similarly, the special bit at next power of 2 (position-2) encodes parity of the group which has a 1 at it's second LSB eg: 0010, 0110 etc. and so on…. Therefore by checking the parity of individual groups, the exact position of the error can be traced down. This allows all the bits to be encoded except the 0th position since it doesn't have any 1's in it. We make use of this bit in another scheme called the extended hamming codes where the bit at 0th position is used to carry the parity of the entire message (actual data and special bits). This allows us to detect 2 bit errors though they can't be corrected.

## Implementation:
The project uses sender and a receiver scheme. Sender has his actual data along with an encoder used to encode the data before transmitting it. Similarly at the receiver end we have got a decoder which scans through the received data to detect any errors that might have crept in. The message is transmitted in a synchronous serial manner. Actual data is sent to the encoder from the board module. The encoder calculates and sets the respective special bits. Once it's done, it starts to send data out in sync with a clock. The data then passes through a noise module which can be used to induce errors and finally to the decoder.

## Building from source:
 This project is built and developed using [Icarus verilog](http://iverilog.icarus.com/) and [gtkwave](http://gtkwave.sourceforge.net/), an open source verilog interpreter and waveform viewer. If iverilog is installed in the system, program files can be compiled using:
```
iverilog -o <output_file.out> <input_file.v>
```
then it can be executed using:
```
vvp <output_file.out>
```
All the test benches written here, generates a dump file named "vars.vcd" by default which can be used to view output waveform with gtkwave using:
```
gtkwave vars.vcd
```
The code is intended to study error correction at hardware level and is not synthesized or tested on a ASIC chip or an FPGA board. Some changes may be required to synthesize the design.
