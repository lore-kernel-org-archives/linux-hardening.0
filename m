Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9D2C4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E0361242
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhHVH5k (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhHVH5j (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31CCC061575
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n12so8391999plf.4
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mboTeGUKr9yolgqYZyfRuYdmdGDjzaFuP+f8ddDuJQs=;
        b=XBzC31VH8i8YFSRYWUDQDKnfPjacjuEkYZb43tC9vNuaDj/OpZDKardqf1WUo2sasc
         qo24sxFkkBPYPPGcAobqrN/+kT5bHgYaqIdGhfFbyb6oGFWgMYhc3D40ZGex/hK30hr1
         OsgTDmiU+s2z9HboX9Yia271ldfY+LiL633/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mboTeGUKr9yolgqYZyfRuYdmdGDjzaFuP+f8ddDuJQs=;
        b=s6SK/fYJzmZsotMZ2WbSOjJV6jKnQbExIQXobrh4BrKln7DAntAsVuEogFay8KGoR8
         tWdJfvIUJmznAVOYc5SzhqnYvgG3KwHwye8AUuBZMUPwmcY35Go/jrRatzhuVkOnBek6
         QEWVj3iJtCkA5y0WaYSNCQ1uehI+fwUFkxXI6ikA7PpgQGF1S4BZSeR4MgUxf4zgDH4t
         h2gL3Vl2j1ZpqSb+4fX4RW52LCVh3ddxu9DuPC6NsuF2vxO6PijtkPFJrRwjYJSm7/kH
         1QwVOfDHBKTp3Vg9OCOnmY9jBXa8LmADGzmXBcaZMOUZe0v9lQAhIL9qzGimqSOPnxrP
         XKhw==
X-Gm-Message-State: AOAM530jdEI5wxrOSROmoDBhxiSOGJkq+dTTOf1jKLTJrUjEip2ydU2U
        4eGkieteHRD059xvvtWG2KB2/A==
X-Google-Smtp-Source: ABdhPJy70piasRcCiq1N1hSgrYpJdyQ7VNKb16zqOJbn9anqN5BpWkCkqwMAwM30x8WGb1EwEiH3zw==
X-Received: by 2002:a17:902:7282:b029:12c:75a0:faa5 with SMTP id d2-20020a1709027282b029012c75a0faa5mr23697524pll.35.1629619018281;
        Sun, 22 Aug 2021 00:56:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z3sm10510268pjn.43.2021.08.22.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Daniel Axtens <dja@axtens.net>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 17/25] fortify: Fix dropped strcpy() compile-time write overflow check
Date:   Sun, 22 Aug 2021 00:51:14 -0700
Message-Id: <20210822075122.864511-18-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; h=from:subject; bh=sAqjTzTf+mWFy7xD73ZEpzjamgoLfVlMB8Pw3aei0Xc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH4HMEpm10nE/aAHB48K6cSsvZL5sfcJfQj9wD4 87AucWeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+AAKCRCJcvTf3G3AJlWyD/ 43aKzGW6g25weJEJsyQ7zCnEMVGGabRxLFQoGd2ODvAXaG7BEMjTe6KHLFfYgussxYeGPNYMyIFUqK ifxOcEWs0Swau1DhGUkYHxZXaXGgspP22zyTe6AzhaxlbCDY/rrzd1zZTyorgwHOOdVZhI2aPTHdlc 20vpjKyvE7Ca62vG9hu9k/970JL1vPz37iEwCMcNW3gO3l62qI7A+xuf+CIYEtvAO85k8sOwHCPCL+ /ACPHoZvTKubJE/7j8ccUcqmiqRTXSSmOpzWpz3iiv0C2+OlQnZjSsruizTYFTcgBjftFuNWAnfZ89 ktCe3sKEYiELWm4h9bXxcUN+iEomsBMWsRmNZhm3pHBtSenmqFvhIzE5KSUTmgiaHT3eKum6L995xf tY+jrUPWQJ0bNaOSYuNN+EMKPS2QNtM9zNjtijutTMjlZ7EEstt9td94KI9DO/GA2s99IKcTOw4WvC Eg2GKgIAfOkfKa9wTCadBJKiDQn2lDy5XKGYjoGsbbdhhJqjqLiIQDvE8L0FEMEHvZoRykYosNVXZt eBUj6YYoLvPEnpoaKqBUBvLRfgevLlTuZBwzsD3IgpPqgYK42igeCrm6ZYu/Di6WM55WjvAnKfkdat 5uXvPQNcUMMrgXfuYJtJxTEuQyw8V1ZdY/Zh5EaIf2hnmN/+DKeKMaN9MP3Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The implementation for intra-object overflow in str*-family functions
accidentally dropped compile-time write overflow checking in strcpy(),
leaving it entirely to run-time. Add back the intended check.

Fixes: 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fortified string functions")
Cc: Daniel Axtens <dja@axtens.net>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 7e67d02764db..68bc5978d916 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -287,7 +287,10 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __underlying_strcpy(p, q);
 	size = strlen(q) + 1;
-	/* test here to use the more stringent object size */
+	/* Compile-time check for const size overflow. */
+	if (__builtin_constant_p(size) && p_size < size)
+		__write_overflow();
+	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
 		fortify_panic(__func__);
 	memcpy(p, q, size);
-- 
2.30.2

