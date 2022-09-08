Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB92C6FA83
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIHV4q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIHV4C (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:56:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5063E4DC1
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:55:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-345753b152fso86729537b3.7
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=l/P3ICq7gexrMqe8SVvEbDdbAWpxQuadkoKvFylJkqo=;
        b=UD1ccXbRxz7Xi9ICwlivWXurmIf1Xil1VOXbXD+17fH0lgPb4/B2u8dw9zKCKXtt/3
         sukLBKdMi754n+cnRVt7aJ6aF2qiIdjb7Tn7iFTED/shpoGeLxWfI2tpJd6IXSfGZ8t2
         e9TK8HrAKj1NqLMpBNiEuvmWbQDwZFxQ8L1xUiyXgQTP5i1G1q5VBEgqHvYsdib61Gcp
         Of/JLPj0u8QieOMW6PDwecAc7/Y1Va52p7dY25pE3xpJSyiWqYAm5/hSkdGclfIJiuZL
         C2UHCzXvpzIyy/qrOKHG9tJWSZNaAoTKvJvr+avmfT1psQpkThKEw3GhAPdmJa4D/bV7
         Hr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=l/P3ICq7gexrMqe8SVvEbDdbAWpxQuadkoKvFylJkqo=;
        b=QOrt3f0irZu5nvQsesOFAkw9OKf5yISjHqA/IHh0zcolwHmTp4aEpsXPO+tbMBtFaG
         jTrLAbCh6xsSS46xz0xuEyAmVHgJdqHs5re1UcbHLiIb9k4kDzeuX50lbvQJQwO9DsHz
         nm3Whjye4q5EggVN9wojDMk+TGzfm+WmsJMJf2rhI5z88YQt0EwA+RDgLbCBDmUa6OiH
         1Rdr+qcsaXVuqNjm3x+SefQ26k2AtzxqJJcIXyVJW2liyb6Wm05oxGqCc+yrzLYCG9AF
         lgsvmF1Y0W76tnCKeW0J9I42165K5lDElEGsnseM3nNZ58iJhuJPpImYiehoH33K9W6R
         Fjxw==
X-Gm-Message-State: ACgBeo2IldDs77rMMESp4KlkfNkchyuJna/+PxQgcKWToNRR8mdAyFKO
        6Otwjxt1id9tAHypUMhIoS7fn3InQRgaQ7lrvaM=
X-Google-Smtp-Source: AA6agR5a0urzcgqtiNi5U9w+rnOkqDqa5tT2drcbxAab7k4RS46CA4kYqncx6Fwz1a0FDqqjBnC3YLNEgfnP18OQ3Tc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a25:fe0e:0:b0:69e:7884:5006 with SMTP
 id k14-20020a25fe0e000000b0069e78845006mr9202550ybe.579.1662674138614; Thu,
 08 Sep 2022 14:55:38 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:54 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029; i=samitolvanen@google.com;
 h=from:subject; bh=w1Y02HzgeI7knEEHZIsxDg9VMOLQptocTxv/oc51D5c=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS16oHvirVLE2hytnBruHp3nBLqOD6x/WQZ2qt4
 k4D51yOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktQAKCRBMtfaEi7xW7rtWDA
 CXo6kB5HgNU1fcH0EhWUjrQsIumv8nz+i3x4vs5z30oE5HTRA51x2U2Nj4SgyDDY+V7G3AvUwJPgJg
 +kh0h/5jfijyYIrOTp2uo2EwB7HGCftq2TsfHjHbWza75F8VwBo3dDZrkPSaYvyKB7YRRlPNZeaUZU
 mIa31uMuqI6xdH5hSQC6zE6Q2yRZgDmPlNhZjiS/bm5AQQI6TS7I2Jj22NX6XTDphP6IsaZV0Rfh84
 pd/NRoIzlZ2qsoyx8ywRjV0rtvE0GZvGKXazpkxzM9JAdR1ClstW9ayMVYXZsFK4RGZr3NXn9ZX5xY
 VTbTQvixgrAiEeQxvNoNp1SPMqoWWbiE2irbxsBcWQLaQorjCc961X61Z+oexGMcZveQgMIlx5F3d8
 5kK17TKdfDnyFXi23EhOL8a8FIHs2t01MVbt+2yu9FluH26SdZ79Fq2C4aUCaIZYwXl32I0fLjzDr6
 HDN9J7SFmEbYwlMfsxgEGsmu1LWGTJCDCgZARrqumu0hw=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 12/22] init: Drop __nocfi from __init
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

It's no longer necessary to disable CFI checking for all __init
functions. Drop the __nocfi attribute from __init.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index baf0b29a7010..88f2964097f5 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -47,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(".init.text") __cold  __latent_entropy __noinitretpoline __nocfi
+#define __init		__section(".init.text") __cold  __latent_entropy __noinitretpoline
 #define __initdata	__section(".init.data")
 #define __initconst	__section(".init.rodata")
 #define __exitdata	__section(".exit.data")
-- 
2.37.2.789.g6183377224-goog

