FROM ubuntu
ENV HOME=/home

COPY . /home/3D-ICE
WORKDIR /home/3D-ICE

RUN apt-get update && apt-get -y install mc make flex bison libblas-dev liblapack-dev csh wget git

RUN wget http://crd.lbl.gov/~xiaoye/SuperLU/superlu_4.3.tar.gz -O superlu_4.3.tar.gz; \
tar xvfz superlu_4.3.tar.gz; \
rm -rf superlu_4.3.tar.gz; \
cp SuperLU_4.3/MAKE_INC/make.linux SuperLU_4.3/make.inc; \
sed -i -e '24 s/$(HOME)\/Codes\/SuperLU_4.3/../' SuperLU_4.3/make.inc; \
sed -i -e '35 s/-L\/usr\/lib/-L\/usr\/lib\/x86_64-linux-gnu/' SuperLU_4.3/make.inc

RUN cd SuperLU_4.3 && make
RUN make

