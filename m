Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE2CCA47B
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Jun 2022 23:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350938AbiFJXh2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350921AbiFJXgS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5AF29567D
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c1d90587dso5898017b3.14
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Abw/XDnhYlMJRytVgbcavHSrRaNhWfsqM6nsq3SHmFg=;
        b=Mnnye5t4POMrfEpeBRChdzdv18aFspHy5HlM6NfSpwhux+r6eCkKz/CmmHrxQQeCWV
         RgJGiEkRoD1OaYq8rMIqfp1N2ypTETVzlRqxrHwZa0Z9ta9eBQC1rIXTeWIISvIcBpub
         M3lnsw2v+10gfThy3UMUH4dl4b3hrX3oPWHMZ9NW+ZwP1Imhog1YfSDsPVTtecIvLPkW
         4R0WANwpcc7Nd+JRbXUFzaofbyufCWMO0bfhIjqEeRsg8sp6P0jepNMhqNXj3RY1F6x0
         ZZwg8qoQHMF0Ola1aKnYqVXItmuXveuiv/3LLndaCwrfctJXvhm1P3poKmCAN540UvKQ
         nmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Abw/XDnhYlMJRytVgbcavHSrRaNhWfsqM6nsq3SHmFg=;
        b=YAZNgLPl+7ZuHfaoRqIjOojseRkxt13BZctGmAC4AEk16yIC7ritZmICJXBz63ydUH
         W9BvKjNQ7uji+q8iNMDv83InrOuvHy/+WkRIly9YocnCxM2R2hrG228iASWaUM2NX3sj
         3ze6o/rZux0XZ8ugG7yuKZR1J2zJZJAOanFQgb39Zu0QpeMl28X21meCTw/2B8gj9sRe
         CebcJn1kVReNhrlfsqYrG8QA/D99ZKHw1BNGn79qdPnZmb0FmnH520u9dymlQT/1YGty
         hM1jXJ5WYwIrgO3yles6YmFCUV6fvQGg/IsPe44dYv8RKLrpMf9FzoFx6zlEpyhL0zMv
         eXnA==
X-Gm-Message-State: AOAM531/y1RkgKFs563lHPQkXGPeJW4qcRsUdjV1DIcJMd/ATL3uOiFS
        bOPSNJBxHyyPore9A3a8KlBxb+8ow7/IDFShQoo=
X-Google-Smtp-Source: ABdhPJzJ87O/ZB10aiSAIIKJiMs0MPiyPEQarDqtT48IEOt/gPSVrIVwSFGcxEs9HTqQeRN0QnK9rA77lXNWGat4Mv0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a25:8c87:0:b0:64f:cb1c:e7a9 with SMTP
 id m7-20020a258c87000000b0064fcb1ce7a9mr48335685ybl.519.1654904157125; Fri,
 10 Jun 2022 16:35:57 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:10 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; h=from:subject;
 bh=G+/tIVkjbHjJrRoQokWdmBYkussKEDPQYIpl3t53Wn4=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UvtHsK8AYBPSr7kbT2Y9kpNJwMx+Z9LWGdloaR
 HXF8kpWJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLwAKCRBMtfaEi7xW7t6PC/
 9zhJyKm3u3v9fGIjM6e9ahbA219jnvLDpBo2cs+R9u/TWb47Tub2gBZHDBGPScub4OKy8PJ+YNAQMA
 M+/V2RJ4gjmG4gZFohXpDaBWp3M7nMxoz1nc3xIVusNtGSxPd2GJza4O8Xc6O7eaQT4XqJdk1rlR2/
 g3fGK1oNaXUorSwjz8l05prq7Y/bQoLkUX8Q7q0oVyxSaFtSUjgfpficBEFT2hQjW+01ShJtRwk0Qi
 5heRxHXU3QRAskcjJy6Ye/Cb43uBxK1ZSx54LcCGwVIQUv8kkc0t1yCXooZjGOG3laP8xaHAXm3wLg
 p1mvtsekpf/xym2aEY+dhkXQd1on8J8rop1grTyFq0vvHngkgtLySNXW5AsNDUoF7niwATqwUdXnjs
 kqFsIcZ3/B6iaN+njChbFmCxjgXc8JR4fyEVWBOA1pGi9sQpF1ds54CRDdyhEEMWBN0ui6QjUxFuSD
 uSuguO5x80Ez6ipWJBhFeFikp4wjbuDGIPmOub86kyDug=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 17/20] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The compiler generates __kcfi_typeid_ symbols for annotating assembly
functions with type information. These are constants that can be
referenced in assembly code and are resolved by the linker. Ignore
them in relocs.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e2c5b296120d..2925074b9a58 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -56,6 +56,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__kcfi_typeid_|"
 	"__crc_)",
 
 /*
-- 
2.36.1.476.g0c4daa206d-goog

