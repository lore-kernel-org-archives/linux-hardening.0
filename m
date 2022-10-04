Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D5C4332F
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Oct 2022 13:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJDNAx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJDNAE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Oct 2022 09:00:04 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B9161D74
        for <linux-hardening@vger.kernel.org>; Tue,  4 Oct 2022 05:57:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso9026244iob.20
        for <linux-hardening@vger.kernel.org>; Tue, 04 Oct 2022 05:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZaaERZiNeWPg1VEtskzRzem7azoo+jAPc6Nm8v1Mjr0=;
        b=sLjGi4YLs5ZMGSGJqrDAPcLBnuwy+AhKj20J/CtHkh+oAsN6x82f+KDFrj+lZ12oc6
         dakI+2yKY2/d9Fmf7LCPUc+7U2TXZ/iuHQgUUobErnnmpdTrh2bqk+ZF/Z/VDd+ydRK7
         IfTP4Z2IdhiuPCc5cN+aXarw/8OAXlTdkrn3AV0OcoxmDkwurSxJBNxrlAHZauJNQ9rj
         aoI/9gQwjeOg81Whj2mz1ilGVrGnqHLnUvcMGOh/qbY5mmobEewh1+H6F62knfLOAmYI
         b9qFxgUdWuLww0jm28BeXT/4CKQlYtlYIg2BECC0t6Yg7SyhhBxgIkHGwq5mEuoU0xHQ
         miAA==
X-Gm-Message-State: ACrzQf2uA8HLqeUnIiV0m2fddoRKse3j2YclqtMupbJHdhAQ+RNZ3BJn
        FdrsF5qfTDB/lSjGl/rPzs6o7HDl+JkkgJ1lJOaR7w7SgwNF
X-Google-Smtp-Source: AMsMyM4kteE+NL4GAcjpCLq1LwFAhSOn3ZAssS5MrlayLf6b/No6LrtmBBCgIgSa0qYCffeg++X/hyr53V5k5Q4P1mQiqhP4JPvH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168b:b0:6a2:c6d1:d4e4 with SMTP id
 s11-20020a056602168b00b006a2c6d1d4e4mr11282718iow.190.1664888241655; Tue, 04
 Oct 2022 05:57:21 -0700 (PDT)
Date:   Tue, 04 Oct 2022 05:57:21 -0700
In-Reply-To: <PH8PR10MB6290511E9C0A3D20E1C222EEC25A9@PH8PR10MB6290.namprd10.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c183505ea350059@google.com>
Subject: Re: [syzbot] upstream boot error: WARNING in netlink_ack
From:   syzbot <syzbot+3a080099974c271cd7e9@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, fw@strlen.de,
        harshit.m.mogalapalli@oracle.com, keescook@chromium.org,
        kuba@kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        vegard.nossum@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

asset storage also requires dashboard client

syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build46036865=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at feb563518
nothing to commit, working tree clean


go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=feb5635181eb12a6e3516172a3f5af06a3bc93e1 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220930-160315'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=feb5635181eb12a6e3516172a3f5af06a3bc93e1 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220930-160315'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=feb5635181eb12a6e3516172a3f5af06a3bc93e1 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220930-160315'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"feb5635181eb12a6e3516172a3f5af06a3bc93e1\"



Tested on:

commit:         725737e7 Merge tag 'statx-dioalign-for-linus' of git:/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=36e3ab6ff9643877
dashboard link: https://syzkaller.appspot.com/bug?extid=3a080099974c271cd7e9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12302bb8880000

