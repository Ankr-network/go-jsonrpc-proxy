# image for compiling binary
ARG BUILDER_IMAGE

FROM $BUILDER_IMAGE AS builder
### variables
ARG PROJECT_PATH="/go/src/github.com/Ankr-network/go-jsonrpc-proxy"
# disable golang package proxying for such modules
ARG GOPRIVATE="github.com/Ankr-network"
# key for accessing private repos
ARG GITHUB_TOKEN

# configure git to work with private repos
RUN git config --global url."https://$GITHUB_TOKEN@github.com/".insteadOf "https://github.com/"

ENV GO111MODULE on
ENV GOPRIVATE ${GOPRIVATE}

### copying project files
WORKDIR ${PROJECT_PATH}
# copy gomod 
COPY go.mod go.sum ./
# Get dependancies - will also be cached if we won't change mod/sum
RUN go mod download
# COPY the source code as the last step
COPY . .

# creates build/main files
RUN make build

CMD ["./build/go-jsonrpc-proxy"]
