NAME=hiddify-libcore
BINDIR=bin

TAGS=with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api
GOBUILD=CGO_ENABLED=1 go build -trimpath -tags $(TAGS) -ldflags="-w -s" -buildmode=c-shared

lib_install:
	go get -v -d
	go install -v github.com/sagernet/gomobile/cmd/gomobile@v0.0.0-20230728014906-3de089147f59
	go install -v github.com/sagernet/gomobile/cmd/gobind@v0.0.0-20230728014906-3de089147f59

android:
	gomobile bind -v -androidapi=21 -javapkg=io.nekohasekai -libname=box -tags=$(TAGS) -trimpath -ldflags="-w -s" -target=android -o $(BINDIR)/$(NAME)-$@.aar github.com/sagernet/sing-box/experimental/libbox ./mobile

windows-amd64:
	env GOOS=windows GOARCH=amd64 CC=x86_64-w64-mingw32-gcc $(GOBUILD) -o $(BINDIR)/$(NAME)-$@.dll ./custom

clean:
	rm $(BINDIR)/*