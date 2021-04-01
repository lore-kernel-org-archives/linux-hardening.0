Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B238C433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 23:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2EA061105
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 23:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbhDAXdy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhDAXdh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 19:33:37 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F41C0617AB
        for <linux-hardening@vger.kernel.org>; Thu,  1 Apr 2021 16:32:50 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y16so4254485pfm.11
        for <linux-hardening@vger.kernel.org>; Thu, 01 Apr 2021 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UnGCKexXdTyI7Eiqrpiu9/A3gEqTseA/WgHOqsa1uKs=;
        b=Y6zfeKMJZ/0smJ+JE3FMI+/MMd/ZXHcogVJQP02BVRavDHQc2Edoxb8O9UMVaoGWhY
         9M7E77BUjYKqGqhxNg2Ko45u1WpKF8gpGXMiV7k/Tc1x//nVTn29FLsuyQQgeT3V8din
         SROVjqBNbPfeHTigsIDGDSOViR6QN9BzqkYAwyvaBD4SA5L9n9oHfj14K7uLGlt9J08o
         mKGxub1wSpYG2Y+5GS3JqQ4O0M0C5WJF9Q77BaDZaElF6rrR+h+xp7Ff9VOWJ+6vYTF6
         /Wx+GGqcw4dH75WEKap9ddzI2quiNytHhOyUqj2yLAD5J+cNXqEslF8JyxBMuvId9p8q
         rGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UnGCKexXdTyI7Eiqrpiu9/A3gEqTseA/WgHOqsa1uKs=;
        b=FC5OB/PMKlosEmoSNyosODc3BaLE/ia1Y77ssn/lVgzIb4n6evBzeVbz4G1MKnE+9E
         h4psydyafFzAyOMo2Ax9aTz270jtqG3WtIYL0ghwuj+lGRM3+sMKjedJd+zsvNHcr+jx
         mv2KKS9NoiN8LqlfpUK55uG9HJP0EdxA6yRT1CPgQrI4Rs29meWAWm5JbBSfjy4hqJB6
         YvxkWVjmJPGD3Ij6KpPLSoPg5rN1YzQewSyEvUEzEmN3y53aLH2oAotGNF4rj8T+44JC
         JlX28wIeBP/P3FJoP1iqU6sVXRJniKA5Z+mTfLim+k8BRDehKQKSGDIDOk8KscdBU/PF
         hMIw==
X-Gm-Message-State: AOAM532wfLBTaY4p3A5X0zdnbp8FNIB2qIoekL5GMX5usHuVZMSaxn39
        jLbAeuifYK3TMWeXACLaaZvKQ91ehUcj/G6z8Ec=
X-Google-Smtp-Source: ABdhPJyBRWK1tySqgHsv5VTyvnh7AhzpICkyfxDBUbSBurGBw1+GMJMgKtJy/KlOFY96rLBaJQLLx0AfoI3De6kZmhg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a62:e805:0:b029:1f8:16ba:4518 with
 SMTP id c5-20020a62e8050000b02901f816ba4518mr9437095pfi.37.1617319970406;
 Thu, 01 Apr 2021 16:32:50 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:13 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 15/18] arm64: add __nocfi to __apply_alternatives
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

__apply_alternatives makes indirect calls to functions whose address
is taken in assembly code using the alternative_cb macro. With
non-canonical CFI, the compiler won't replace these function
references with the jump table addresses, which trips CFI. Disable CFI
checking in the function to work around the issue.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 1184c44ea2c7..abc84636af07 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,8 +133,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(void *alt_region,  bool is_module,
-				 unsigned long *feature_mask)
+static void __nocfi __apply_alternatives(void *alt_region,  bool is_module,
+					 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-- 
2.31.0.208.g409f899ff0-goog

