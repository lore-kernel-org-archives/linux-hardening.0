Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD77C6FA90
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Sep 2022 19:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiITTWO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiITTWL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Sep 2022 15:22:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33DF36852
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 12:22:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b21so3384380plz.7
        for <linux-hardening@vger.kernel.org>; Tue, 20 Sep 2022 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Y1Vq3TVJb/VWSLfO0Rb19+4XJtG6XYStvEWudetclg0=;
        b=VfqVLJ45y647x0gXwo2gQ+z8ehdPiGmN765iLaQZImjK9/W6CfiT4udXBkZJQS5RWi
         5YUKsiZRaPGTmFqgMg0S6JrUAb3QT+mxnm8vI0rl1t7Uz1P0at2DCiu6MyDDIRqDVqp5
         mkNGp3A0YtuQgcMH37ZLEU/iA03FJATEvCmKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Y1Vq3TVJb/VWSLfO0Rb19+4XJtG6XYStvEWudetclg0=;
        b=oYUrHdfg6c1TOG6H7JYY7zMHJ0iW24J43YL9EvY69BogxjFECPL31uZLRdjcVU55mf
         +RwuxdY3K7HC5nXTMhzS3lnGapcg3g+fOjjlgvUrd04A4Xjo6PAGp48GWcFhDa1psGdL
         bDrgGT1iETMdC03qV5RVaQZJfcj7SZeyzzRExIpoqoMYtMQxRb60Xh8doAOmHkY998/V
         StgB2GDlJokg0Eva6NVJXIlraK7f3rWOPc0xbL063sJjsy+LR9FKdPl2l7uvpReRiwXg
         uw/xJNZVCNfVJT/Ze24WSaprwD3c0Ax1q86I1tJR7zlpmzLLe4B0tCRKETLTVjpTjyxU
         c1OQ==
X-Gm-Message-State: ACrzQf183EbFFQwNLp8dpUTHp+wA9BRv05LLePl4HAdB6kkoVAC1yOgY
        iEKTcjfrWyGB4ij0MBvcirjr2g==
X-Google-Smtp-Source: AMsMyM7UlJUymG96TUt4dcAXXoMYIq3o2jMOjyUAGOo5qGscwQPpXzcr9kpEC2WhUoygo4z9X6EyFg==
X-Received: by 2002:a17:902:8307:b0:172:e611:491f with SMTP id bd7-20020a170902830700b00172e611491fmr1079757plb.111.1663701730500;
        Tue, 20 Sep 2022 12:22:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b00536aa488062sm249174pfp.163.2022.09.20.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:22:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 0/4] fortify: Use __builtin_dynamic_object_size() when available
Date:   Tue, 20 Sep 2022 12:21:58 -0700
Message-Id: <20220920192202.190793-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; h=from:subject; bh=J1jKJHEXW6fuYZp0bwrwLqGsXtJ2fCfxnhbkDPep9j4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjKhLY5BfaUkXVQJ7vCxL3yWuutd9/BjsHihL3Ygj4 bXMlY6aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyoS2AAKCRCJcvTf3G3AJoxoEA CNWvotJduQ1+tj7cnZlwvQosnG4/aa+Tua7+dPMGebxam64/SsgNEoEDE+iYOFec1iIT+TWr8DmBMs EMbqXsh+5rZssPPBiIy/lKv6+nO58viHWBPTOrFOxjJezOdqzX5hdK95NTYC6eyawrsUC7KnHrfVyv 8uBqte82ZYL5hfRgO1u02u8C5Bf6vtyatkJ2a5nZLLcpnur5eQLS1TX6/TsVUqcbNF6RYURASxZYxq lNcTVV+DgbsaId76L8ljOwV7Dz08ykjlIWsJYinvKgJWtHh3Ya/FIg6Fg0wsSnoRpdKL2pEBS+mjw8 scvWa4vMb/CTqwBfYwJRi1l4lScrE/BeIUVBtCu+xcGpc+gp1l4FTKTxoTMk45DT0CXAWU9xxTqc6c gSsZV2A0ZaxVRmLjiXIVZBZyjq6GQ2v89cwHB25GBATaN7EksK82VcoD9hAPrZcOauqYKDNVOXZqcv PpO5iSx1rbRkKKc25kGoYIrCrM5qRXyBEQK/TJcmBLXtaqCGukGx0OBRVuBhi/+PKBc1unOPjp5s39 fBtan6hdZ+J2bxFNBlDxauaECtMUzhFuGY+UDK278LYJq5ucd/NRTst6+Tn32tg7T5c+nM37eKAa/C y46/iBV/2fCPGMCZHrv1f27M6fd0S4sj9JrAy2oCimhN5Gm+bmpFdDiS46lw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This adjusts CONFIG_FORTIFY_SOURCE's coverage to include greater runtime
size checking from GCC and Clang's __builtin_dynamic_object_size(), which
the compilers can track either via code flow or from __alloc_size() hints.

Thanks,

-Kees

Kees Cook (4):
  x86/entry: Work around Clang __bdos() bug
  fortify: Explicitly check bounds are compile-time constants
  fortify: Convert to struct vs member helpers
  fortify: Use __builtin_dynamic_object_size() when available

 arch/x86/xen/enlighten_pv.c         |   3 +-
 drivers/misc/lkdtm/heap.c           |   1 +
 include/linux/compiler_attributes.h |   5 ++
 include/linux/fortify-string.h      | 125 ++++++++++++++++------------
 4 files changed, 81 insertions(+), 53 deletions(-)

-- 
2.34.1

