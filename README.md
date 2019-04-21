# Self-organizing-Map
**3. Problem :**
    Diberikan sebuah dataset berisi 600 objek data yang memiliki dua atribut tanpa
label kelas. Bangunlah sebuah model klasterisasi ( _clustering_ ) menggunakan metode _Self
Organizing Map_ (SOM) untuk menghasilkan sejumlah klaster yang paling optimum.

```
Strategi Penyelesaian Masalah :
Strategi yang digunakan dengan mengimplementasikan metode Self Organizing
Map kedalam program sehingga program tersebut dapat menentukan label dari 600 data
yang diberikan. Dalam program yang saya buat, saya membangkitkan neuron sebanyak 10
neuron dengan weight dari masing-masing neuron di random dari -15 sampai 15 di awal
penentuan neuronnya, setelah itu setiap data akan di hitung jaraknya ke masing-masing
neuron dan neuron yang terdekat dari data tersebut akan di pilih menjadi neuron pemenang,
Stelah itu akan di hitung jarak antar neuronnya ke neuron pemenang jika jaraknya lebih
kecil dari 10 maka neuron tersebut akan di pilih menjadi neuron tetangganya, untuk
menghuitng jarak menggunakan Euclidian Distance , Setelah mendapatkan jarak dari antar
neuron maka cari Tnnya dengan rumus EXP(-(Sn^2)/2*sigma), setelah itu akan dicari
wnnya dengan rumus Lr*Tn*(x-n), dimana Lr dan sigma adan selalu berubah di setiap
iterasinya dan terakhir maka mengubah nilai weight dari neuronnya, setelah itu
mengkelompokan data ke neuron terdekatnya.
```
```
Analisis :
Berdasarkan penjelasan yang saya jabarkan maka dapat diketahui bahwa
pembangkitkan berapa banyak neuron sangat penting untuk mendapatkan klaster yang
optimum, dan pengambilan tetangga dari neuron pemenangnya juga sangat berperan
penting.
