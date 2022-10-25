Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC43AECDFA1
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Oct 2022 23:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJYXRC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiJYXRB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Oct 2022 19:17:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D273726B4
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 16:17:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h14so12330692pjv.4
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsADfAFq9TK5UcRj962QpG64UBItidHRoIZXT+jjNI0=;
        b=EadsoGPR6HyPwrBeOgAEKduevptWsfT+BfNPAxvGYrSVo10HfQDW9WWGTi15Rn+cM7
         7uu8tgS1WGFFYvtejcBJ5izBfGlucAyHeP6/2u0y1Ffi5daX+pTRzkGAbaYVjnb2camD
         +gF18GvsJW697oZ4CYo6fOOgiv5si2TwZoiUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsADfAFq9TK5UcRj962QpG64UBItidHRoIZXT+jjNI0=;
        b=O3QVkCSKfAN0qoKst1RQab4TSaJUAa5ZYLxVj7EtfEpnCPtt8WfaDgqhjHsBUvO9dP
         o8gBX/lz89PJcgxBB5N79LvR7RwxiSwEuxR7SqJwLYC10b9KqHlnq/VAGLUlROV8VJnW
         fHwRie4tshDVmaxfw+40iNj7//gONXVwB9nEsihxHU5eNjsUl7kZMCrNu2/PqdYS7zqV
         CfslVY1jbbeL4ZEM1I+7Emgr2aUtkWy3X/hGf/PB7S7S/Dt7IWCKsj1iRKEXj5CTRl4e
         gRcD5ih3/7Vs/iJSnr10G4z5zhgk2SL23j3XdQWjLNm4BYz82pLFyS8M5DfrhtYmcuVi
         rFIw==
X-Gm-Message-State: ACrzQf13a4qadmqcNezVUG6cptciWyEPLbw2/c1r6xXUV9BuhDb0xaXK
        kXR5oORLvLPB6KTQK/SlfyVYag==
X-Google-Smtp-Source: AMsMyM5X/y2JqLN9OZsWk0fqAzQmVMhBkmDmr+xO/+YfhO25w4RdZr9/wkpQ4JkBhZmS4bFcimPcQA==
X-Received: by 2002:a17:902:e952:b0:17c:2eee:c0ce with SMTP id b18-20020a170902e95200b0017c2eeec0cemr40672958pll.145.1666739819841;
        Tue, 25 Oct 2022 16:16:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79e41000000b0056c396f7539sm874135pfq.157.2022.10.25.16.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:16:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Do not cast to "unsigned char"
Date:   Tue, 25 Oct 2022 16:16:54 -0700
Message-Id: <20221025231627.never.000-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; h=from:subject:message-id; bh=ongZMPsGsunOFE/Aw5TzydU9CY4BM9qng6Hx1S8Irz8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjWG5l+dmLqCoH6aNAlHtePjkBADhow7KrQzlCgdrQ HSi+1SmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1huZQAKCRCJcvTf3G3AJjJHEA CC/SsAc9o3xNnq0WhQdMGC96YHBixwqDtDjXN1hC0XFI4c6lQs5Ql0nzaSVRWwuTTzstOR+7Ui9axU YQGPgMt+ZytoL4sjQXR8PPqFLgCRUovDFxQoyOpIQjs+TOtPeW1NYyq/+2ES7eg9gkFnHVSPHGSC3+ Y3vgCZhHa7KTYYogOMb4TDewMU28GLHIXVGVGQe9Rf/M/Y0mpx4id6/OwFxp6oUq5IhfcMnASKYwDl 1QLGVPazvgNFG9QGDNXst6va9CPs+UfJEHOoZi9G+/kdjgIpXQv0aN94tBEIRMBQYhsSnnivYgaY/r aQWcu8M5nSMa3E7GLH1AajOdUTEmIq9TfasF/NVyrRCXkPoclC5SEcYvb5YR4RoWPUL/8QVWskWNIe DM352tS6CxMo2KqRYeuqXpMaPKOWbfgB6yW0uQ36d+CO95d1/8MM8P/U5YN02+Wxq5i0spGzmgiqeP juMSarxV/yko5p5qSfcIG7/VLHnFn/sEfRNtauLNTFcjYQNOczbbGvSbdznS06KEvYe7ovrlb232eG 1MTGX6+o6jRvYjpJpENRpx+nRq3vkLxW3lQ/OIOhlL8uk1rN0QyzcnevnuLc+huCIEDuqIAQDtjQsT pC6GVekHdywZjhSYToC/yprRGiusYEJzggpI8BaPGcM8Nm/chsAz2DBO6pkg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Do not cast to "unsigned char", as this needlessly creates type problems
when attempting builds without -Wno-pointer-sign[1]. The intent of the
cast is to drop possible "const" types.

[1] https://lore.kernel.org/lkml/CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 3009f891bb9f ("fortify: Allow strlen() and strnlen() to pass compile-time known lengths")
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index f3dd5d1a6a25..09a032f6ce6b 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -18,7 +18,7 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
 
 #define __compiletime_strlen(p)					\
 ({								\
-	unsigned char *__p = (unsigned char *)(p);		\
+	char *__p = (char *)(p);				\
 	size_t __ret = SIZE_MAX;				\
 	size_t __p_size = __member_size(p);			\
 	if (__p_size != SIZE_MAX &&				\
-- 
2.34.1

