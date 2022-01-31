Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B506C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Jan 2022 22:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiAaWpb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiAaWpb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 17:45:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9B7C061714
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 14:45:30 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id z131so13566584pgz.12
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YEVdH5Pd0QMwZ+tRa+ReTB79io6b0zv3PIYxkrrJPwo=;
        b=driCj2TV+IWd7B6h4PIEaW+hLtAn8ynHhO94Cvlkg6/xPQnV5E/CHK2p9U6UmNHW2n
         lhHfAOJY8/fA/+kNNJZGKrF1dqMdRMNomYJyEi/W8P8WR1Dxyn06R1iqhaTeOWERFjRn
         WqjtNZMb016oNqPXtSvt09jArPtd9rrq9w0DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YEVdH5Pd0QMwZ+tRa+ReTB79io6b0zv3PIYxkrrJPwo=;
        b=lz9oGmbv2MpJ7NJEMh69z3MLLwtk0Z3Q38bqAa/Rk5hXUyk2yHoVT687u6rqfqAjqZ
         VAd3mERJgNxNsKsJM8DEMHoCq9lhjzkssjco9aNcwtN6iHb6YqeTPovxAOPSZs2uhW8T
         C9DwiTUC1UZPOtvysWha+vStzcp4GpKVxg7Ji38O2fIsnXa0vpow1qRR0Nz+bPj2LN4R
         2uSj0ZrrQvEjimrrfVVjIcqRMaX7L/v7r4jkRFtmvUhmpaN7mcMx830cpuPRAjzD+GIT
         EVcYUuEyDv3ssCGlRbGMlldP2xlhQiBUvL5etlaQ0ElF7Ndb7FQrS+MKaw/9Khaii4RM
         Jm2Q==
X-Gm-Message-State: AOAM533sj35nzlKiYqSvfcDjS/kYmY9oD2rS1Mbn4pTA3bUCqxo467ar
        M522cPJaD9++NJslheZksaerIQ==
X-Google-Smtp-Source: ABdhPJxi2pzgybptOkg3FaU1+cmrlb+iDHVMeCiFcxvrjigKjNie+4w1+AZZC2ve1bAqToutSTDboA==
X-Received: by 2002:a63:2ad6:: with SMTP id q205mr16636510pgq.46.1643669130447;
        Mon, 31 Jan 2022 14:45:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x17sm18991889pfa.105.2022.01.31.14.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:45:30 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>, linaro-kernel@lists.linaro.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] tcwg_kernel-build.sh: Report toolchain versions
Date:   Mon, 31 Jan 2022 14:45:27 -0800
Message-Id: <20220131224527.2391044-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; h=from:subject; bh=D3Kr4EhKRXTkrCc1hf19ixoA7RPVnrrkKW2lG7IfKB4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+GaG322KbI4W3pqXrwWEaywyQj9myi3v/shup83n +eiboiuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfhmhgAKCRCJcvTf3G3AJh1qD/ 4nfQus3HJvOWimdu92elDVdHksa7VlWRUDIVxFQe3pV9WRCYwUSquKIj4dSp6etf6JiieTih686+Kf dHplWwOTIt3MvclMU1yxZhHQjWnOviw6cVlIzKp2U0M7MJwhk9fIuj/GJFgT+Qo0RSdZQEoqN8/tcj hEyA7WN34bJ8OAqI4cHm70yRlCpDbRsQcCebtQlHm9TngUvkGUTUYYTFSmwlR8jJgYvSnkbVOxby9A xjEntws4+TuVUA65YuH0tkk0kfguDfUAzn9SvdK5SYMnA7S8XL5R+0Pn2PdTWR3AqPFMdLbYzaZIkU yh0eYrqloWT/sgc7w1DPxCYc6qAZNv84GRUsacAFz9PFHJTZkMOHR8EZ+XYI7pdmr23eKZb6GRXwK8 qa2JcmL2Isiq8Kczy4yCpCK10B+eAbzq50dbE7+1tyGoZPzmodiHU9EUmILPDJu9hEZ7s7WsOJAoqZ kIMc3k7ESQ+pOruQUS6efrkgh7Lhy7sRw0xDlfmF0T3JLACkyV0NU/+b/pHmZqsMMqyGgA90qYlFU5 lU7MWwFjQDyKGgdskmbTG1KQ85OElF4k4RCneTN5SyhT6Y/BXMzfoU8Youct99euUIxFBbiBIeUPl5 QEh+z1k0/1LzG9M6rtuT38xiLXZexXwErTXyyVbtL8WgOHZNawRnIi3KARtA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Report the toolchain versions after locating them.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Repo: https://git.linaro.org/toolchain/jenkins-scripts.git/
---
 tcwg_kernel-build.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tcwg_kernel-build.sh b/tcwg_kernel-build.sh
index 42ed4a55907c..7f76c4bcce52 100755
--- a/tcwg_kernel-build.sh
+++ b/tcwg_kernel-build.sh
@@ -97,7 +97,7 @@ build_linux_1 ()
     rm -rf "$(pwd)"/bin
     mkdir "$(pwd)"/bin
 
-    local gnu_host abe_bin cc ld_opt=""
+    local gnu_host abe_bin cc ld hostcc ld_opt=""
 
     gnu_host=$(print_gnu_target native)
     abe_bin="$(pwd)/abe/builds/destdir/$gnu_host/bin"
@@ -114,12 +114,19 @@ build_linux_1 ()
 	    export PATH="$llvm_bin:$PATH"
 
 	    cc="$llvm_bin/clang"
-	    ld_opt="LD=$llvm_bin/ld.lld"
+	    ld="$llvm_bin/ld.lld"
+	    hostcc="$cc"
+
+	    ld_opt="LD=$ld"
 	    ;;
 	gnu)
 	    cc="$abe_bin/$(print_gnu_target ${rr[target]})-gcc"
+	    ld="$abe_bin/$(print_gnu_target ${rr[target]})-ld"
+	    hostcc=gcc
 	    ;;
     esac
+    echo -n "Compiler: "; $cc --version | head -n1
+    echo -n "Linker:   "; $ld --version | head -n1
 
     # Use ccache only when bisecting linux or qemu (or preparing to).
     # Otherwise the compiler is new in every build and we would
@@ -142,7 +149,8 @@ EOF
     if [ x"${rr[target]}" != x"$(uname -m)" ]; then
 	opts="$opts ARCH=$(print_kernel_target ${rr[target]})"
 	opts="$opts CROSS_COMPILE=$(print_gnu_target ${rr[target]})-"
-	opts="$opts HOSTCC=gcc"
+	opts="$opts HOSTCC=$hostcc"
+	echo -n "Host cc:  "; $cc --version | head -n1
     fi
 
     cd linux
-- 
2.30.2

