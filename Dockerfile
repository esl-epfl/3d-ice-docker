FROM ubuntu
ENV HOME=/home

RUN apt-get update && apt-get -y install mc make flex bison libblas-dev liblapack-dev csh wget git g++ doxygen

WORKDIR /home/

RUN git clone https://github.com/esl-epfl/3d-ice.git
WORKDIR /home/3d-ice
RUN git checkout -b devel & git pull origin devel

RUN wget http://crd.lbl.gov/~xiaoye/SuperLU/superlu_4.3.tar.gz -O superlu_4.3.tar.gz; \
tar xvfz superlu_4.3.tar.gz; \
rm -rf superlu_4.3.tar.gz; \
cp SuperLU_4.3/MAKE_INC/make.linux SuperLU_4.3/make.inc; \
sed -i -e '/^SuperLUroot/ s/$(HOME)\/Codes\/SuperLU_4.3/../' SuperLU_4.3/make.inc; \
sed -i -e '/^BLASLIB/ s/-L\/usr\/lib/-L\/usr\/lib\/x86_64-linux-gnu/' SuperLU_4.3/make.inc

RUN cd SuperLU_4.3 && make
RUN make

