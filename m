Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3D9C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 20:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJKUBY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 16:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJKUBU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 16:01:20 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5DA349B6
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 13:01:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 129so13709778pgc.5
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSIV1nk3h7SQ/RXPN876Pb3Wi0hCcFy6KZHtubVqFRo=;
        b=llKcywZEqGLq7gS8UMnt9MZM3cf7SXmoLFrh04JrtkDHOwDtbzmWJO1B55fx8cxPzz
         q6d7mq1Hecnvjn1pbIlvCry9jn9q6WbmepbGFv8B/FwREszB2Cjp+dUAnwr4L8HeVOcq
         ZoR+kp8qbKdBgYQ4KYTrokhYegFW/ImZrkDYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSIV1nk3h7SQ/RXPN876Pb3Wi0hCcFy6KZHtubVqFRo=;
        b=tisGbfp+TGx3NlwnNnTlULVCQF1Bd6YuaXwUGrLo5tsTc/ke107yButv42dKeXhTlS
         88pyu7SlLGpF33JGCG+aR74tnxadpzsVFXyek0BayvvjyDOvItQspu6mn+T4tNrmStMJ
         1+Ectc4dFKSArbY+CD3U6qO771B0KZnpw4ff95vxjyr91Cz8p8yDCdIqMPozRgLob65C
         WWym2xaxqeU+wO2i2uA+zPNtYZz6VbG9ykrJFQ9LOahHyqga4XSRQLLbeQe+1dDJtaC7
         5zzTombUNjFmXrWKU4CmbXrYmFK92FrzRxZeJhDkyWBQmr1psOzkCbzWxbRJQ7GkjJYd
         DQRQ==
X-Gm-Message-State: ACrzQf0HZcJj8xvR52yUOGhQNgHYm+kKZ2z9yZYkv8cXokk1GmjvIFYT
        +Qf+X9T2Gbz8NEw1rXrFzOTxpg==
X-Google-Smtp-Source: AMsMyM7jNwGSwRBdssXYSzRhlrydcBvOkRBN/WuNAiwZeCcscxQuLbxqPgN3qOF6LLxaMlPW5T1fxg==
X-Received: by 2002:aa7:810d:0:b0:563:1fa6:fecc with SMTP id b13-20020aa7810d000000b005631fa6feccmr16771092pfi.24.1665518479421;
        Tue, 11 Oct 2022 13:01:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b0017828ae6310sm8984454ple.2.2022.10.11.13.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:01:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Move internal definitions out of kernel-wide include
Date:   Tue, 11 Oct 2022 13:01:07 -0700
Message-Id: <20221011200112.731334-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; h=from:subject; bh=udK8umTyveUu15tse1j2pJvhOOKRXcBIx/uJ3RIQygM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjRcuGYbORFLw0Y49r0GSGRNCDJsI2bzhyl3UI+51U NKrxGGeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0XLhgAKCRCJcvTf3G3AJv19EA CYLcWWPJ7VscUs9HrCuiZmg5dj8TZCJM36L5BEP8tJ8Jgf7pqsHdf0fr8D2jsggT7yVHP6SpC1VaA6 cNGfD9oOo9XSnvWJlP1dDksW5cWLgoYfKQ0whjYV8TXiSM8rI+eZR/N6CThc4ZNRhcfPPiSgKZ6XWr KC8e7z3xwmu0YBrYybi79hDx08gf1/nwmTHYlEuEp7ksGR9FwY15vUyDfeJbScHEmv9o2Z1Z6Lpx4/ Ka1/AyWsXAm3BUqbSxYK4D91zskYZKQXbl7jeNgj/4cOLsHRHMrZRrkpaTw8Z9Se58YTlA4K6maQZg Pnou7XVycFYmcaVGa8WgAs9a4AypqO5Ih+GetuFmMyfcZntAJ5eQNF98j7KY5tNVePd4ydTMtiRUCo cYqbeB7Dm+laBGoCnrHjc4Qn422BCiDNTYQUs5IWULMBHSj/W/4XXUwozX9q31v76BPV3ekXCiMFkp Kahqu9M+uGB4w7TCSnqx8LlzDXVqM0nS34U/WUG8gPZ5VcWTARuJJOB/jbtDjZWxfQ6WJ0fBO2iIER hkaBHeu+AjOBgxNvC3+xlqKsoXDchd7qExTkTFWigQllZ4aKSfakTsEw6MlZHY1S+Afb//IUwQ3xT5 IW6LKfgXmjbm7NowH4P3UWIK3C8kAYQ5x+ze0T09RKw1e23WPcQ8tvPuz9Zw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

Here's a set of changes for a few things, inspried by recent discussions
with Guilherme, Ard, and Paramjit.

Thanks!

-Kees

Kees Cook (5):
  pstore/ram: Consolidate kfree() paths
  pstore/ram: Move pmsg init earlier
  pstore/ram: Move internal definitions out of kernel-wide include
  pstore/ram: Set freed addresses to NULL
  MAINTAINERS: Update pstore maintainers

 MAINTAINERS                |  8 +--
 fs/pstore/ram.c            | 42 ++++++++--------
 fs/pstore/ram_core.c       | 14 ++++--
 fs/pstore/ram_internal.h   | 98 +++++++++++++++++++++++++++++++++++++
 include/linux/pstore_ram.h | 99 --------------------------------------
 5 files changed, 136 insertions(+), 125 deletions(-)
 create mode 100644 fs/pstore/ram_internal.h

-- 
2.34.1

