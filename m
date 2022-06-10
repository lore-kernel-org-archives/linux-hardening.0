Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E95C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Jun 2022 23:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350994AbiFJXga (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350353AbiFJXgJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD1628ABFE
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3135d02968bso6559637b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eypUC8nmG3YT8q5C7uTFJ2I4wzdimzIgtd5eniK3Szg=;
        b=NT94rukK/ENqT6F0xPM3Aj1DW37YL8idTohVFW7YlP6QY7NC9NtuMIKvSSbuklXeE8
         H3FRqhFXc3q9MsQZPtgnLsY8DyD6LJv9BPNASoXwJ8+0pRkqBXzTeWozo2Y8/iM3z+3z
         FSjZIqivcQd8gXXi90mLqnt+9zbzSocGJBB4YxcLPtXwXpY8SkqnsaVmPtckRjwn831V
         EDzZuqEkuiekO9OhcgWqjN5jhG9hM79osNspGRqQ4j5CKysV0QuLSzBoMIFRtsx7GtMj
         bANF9OiYpNqij4DFKYZh0Ocq9NRV3o5FkeP4Rosggd8ZUAy9hGzOvU5dtlsBU9cFLM5A
         ZgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eypUC8nmG3YT8q5C7uTFJ2I4wzdimzIgtd5eniK3Szg=;
        b=HNc357/y3TEqiefCv0Zqu5jVBKua6/GqDu/SlO7g7pRs+0wmoJ9N3sXld4wStUnez0
         mRa9i0iqrV6viKf9A2Uc7ZWUNtbhX+BZ7IHgWUEQzue9kRgXucraZV946bREUeFIIZCV
         /1o9+dF8iUYJNfdDcEQW70X3ZWxJydNsew0dY0lfNHxHPx9RTpoewr2Mcqc9wCnpSF4j
         ZIiPp/YufG3G690MK4aMyo8tztx2hvBWBUmvFZ0TsgctJTnSRjCCC0x0KYToyG2kDDdc
         C7cmXQAuK3TY7CpQwksF2eW8XvKqDtVrbnUAFx2JLUgVeEazClKMWzm013LkhgWbpuva
         hWdw==
X-Gm-Message-State: AOAM531etxUv1iUAPJkrp9xRKh0nq8vsX8/kNeURSwgAelFqfDeCLJnO
        jwWXyiyCxtzGHr/FUPvOMhL+eKdioPW1XahCPOU=
X-Google-Smtp-Source: ABdhPJwM0tA/zVLO12nfnNiPTkE4uUPlt9GHEk6ulsl8fMRqcqwcHxe5VhdB2L6duf5RpopnDg5B/Oks+ImOLQE8jlk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1209:b0:65f:fe1f:ccc5 with
 SMTP id s9-20020a056902120900b0065ffe1fccc5mr50987109ybu.470.1654904142601;
 Fri, 10 Jun 2022 16:35:42 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:04 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; h=from:subject;
 bh=yTF7mBzTmEEqMjI8Eaby9TrzTnV5t5mkewPsQ9aMhDM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UubPFBxpUPffLvY8XGo6RcYbE+L/kncexxBV2G
 Tm2YZi6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLgAKCRBMtfaEi7xW7qSmC/
 4pdjbQn0xIP+w0uxO/LVcNtQi8bbX18SxoBTEsodTMM+qtBOKgl67Hl7st0lgjrIVIJLZfKtdfrFCM
 AqYp5GNXQItjH7Dz4LxFQnN/xEM0/f7SQmc/aTvDUhr9dAKTLrFdWofqL/dWg5CrQtsqQxflGjA5kn
 qbysQ4DmUpQ74U+Ag1IYvBxskA6a9lz/U5CiKP8GFQdTLbgS84SAc3XHmcX5d/jTTSJDO+1+7i+s0J
 tEBxH93Rw7SA6pqbca1/a/xiYsN8Dx5NlR1C6x63HsBoMTLfmEOKYQ8y8C8YgQ3/EwQJgVxPPe8weF
 LjvitSkAvesDpMBt3id6LheIMVrkH5dr7yNKpMH1hwT6QltjQEmhL/bsqm0lGMyHoV7CobVJZv69dH
 aocun1+0o0S2ZnRAZDj0wgJ+7H+Tu7Il7konkB4CnmUg5FUHbcIDLfcj8VI3heqFhovdc0dVZhLENV
 BZYygkr+dc+1FXb5JFcBeRQOX7/PgclKahJNc4JlMrD8M=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 11/20] init: Drop __nocfi from __init
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
2.36.1.476.g0c4daa206d-goog

