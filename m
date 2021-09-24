Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E3FC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 20:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E838611C8
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 20:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348432AbhIXUYt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348433AbhIXUYj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 16:24:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F2CC06161E
        for <linux-hardening@vger.kernel.org>; Fri, 24 Sep 2021 13:23:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c1so9806941pfp.10
        for <linux-hardening@vger.kernel.org>; Fri, 24 Sep 2021 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2XJIyuLuPiwmfllhtQcLNWsdYZDAyHGRwxHWCUSgAk=;
        b=dwet/Cnw4R1aEbpy6KKiP2uMHrE7rz5g45N9sRNoGiAOaoBXG6TiDEF6Z46hZRGCqo
         5zHAHo1WSf7QEhK7bgTj80Tnmu7l6uaSssAKIN8s8Zz1RV2kzaBOGRVUC1XBnWQD+khd
         ysNjOrbrIxqQpk7g+bLr59JFMZKg7phwnjCzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2XJIyuLuPiwmfllhtQcLNWsdYZDAyHGRwxHWCUSgAk=;
        b=f4KSS9zp/OV/L+f53r2JPg6o+EUpsWKsXdl3zjus9wQAUc4Xt0uMECeNUprh9IWyGQ
         gcX1XrrdMK7k5EucJXW6xnfRPVQ+xEEE6CJTD3fKOLx3gFFip1yPAG2hUQ8UfwfXjE3I
         9kw4goG8iW2F3HRWhgfQJS5h454budPGJ8/DGToZXN0gCVroEGDbfd6CF+LfoZVqABcO
         9PQuT//8+pHwOkdAEdFvh60dGIO4o7qdDD/Dw0jU1BjEbK2zzI+lVh4QnkItm8C6fUkZ
         E1gSdK9oR1faUPe0Sj2JfKgVh6y0NTZpOwZCOEiqrECR9Be1P0wLISA2Bsadc24GcRoF
         cvpQ==
X-Gm-Message-State: AOAM533UVGQtkTTRV4jtmEipg5FjkFLC0/6+Ekc2yCzd/8hE9uqff+nZ
        dCuQ9iF/IWU5rC1HGSVrqU1ixTZVEkoEPA==
X-Google-Smtp-Source: ABdhPJzAt6+0yGWLndCymdd2PYackaA3Qavfcu+EpKhxYqBna1Gu7h3RCxZzyC9GOHKS6n5U0If8vg==
X-Received: by 2002:aa7:956a:0:b0:447:96bd:8df5 with SMTP id x10-20020aa7956a000000b0044796bd8df5mr11475407pfq.35.1632514985663;
        Fri, 24 Sep 2021 13:23:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7sm9753023pfb.20.2021.09.24.13.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:23:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] docs: Explain the desired position of function attributes
Date:   Fri, 24 Sep 2021 13:23:02 -0700
Message-Id: <20210924202302.2335542-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128; h=from:subject; bh=QTO9uSZ4HV31mzUIdTms9ofAmY44hmOsdsNfkP2Fupg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhTjOmqdYiF66xBc6cimfQFv5/sM6LDfv9vgQMC9tt aCg0zayJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYU4zpgAKCRCJcvTf3G3AJr/+EA CTKulsHK3K7wnbWaAIa1H/VS/2m0e1fD2UIdiDWcLlUJLBSEr+NVWOdNYsqNX6LHfz+3y5tkZAeqs3 Ckjjt0pnVCsaxGkYysQvJ+WSK0+Vh02+XRqbgAiN0xJOCGu48Iwtueb/wUtBiTDK5gx1gpwfYUpAkh KtqpozuINhMFHJ5WySY5WeK6FTN3nxF4FRV3gsglhsezNlcltWdSKx96DUKP4CRYldXM76KQScX9pT 0IrKxYS3c1rsghNJ/05YRNENK5kI2vKl0Hr18LQLxxHPyiozyiI8BVV5i8hv8T/01Qp0HJU6LtSYvK Mi66ElK5hLZkg6KW5DUc9ncv3mqP2uKb4FInLFMJzSNijpevw0dOyNMYGyBNQqKgNUSVNRWWyTLvDR rfTwjNGeEZP8sVMnDbP/cG6MIoOvq17cLZhVr/PYYjceF1Lt5E8CltzeBrWi2NKEyyLQZJjHSHgj7m Tbmj1KK9QCInrAZXoGowAsUDjfFOlLBnfWr3aiq8QT+vcsS03x4t8qy/uclMP9925SjzYoe7a/Hlmk 5k0VehFk2cX80K8BqHNy2wKKQfiJ3/+pr1QpDXahRKq9H2ErkrAkiZ6LcGOtlO3gqO70a1ULosoCya gsS+h6sSKlMK7KTerVGMKnVtja8h2W3yIHXy/jEMWnuryhWmPxf/oW2l3Wuw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

While discussing how to format the addition of various function
attributes, some "unwritten rules" of ordering surfaced[1]. Capture a
synthesized version of Linus's, Joe's, and Rasmus's recommendations on
this subject for future reference.

[1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/coding-style.rst | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 42969ab37b34..3559c34a9281 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -487,6 +487,33 @@ because it is a simple way to add valuable information for the reader.
 Do not use the ``extern`` keyword with function prototypes as this makes
 lines longer and isn't strictly necessary.
 
+When writing a function prototype, please keep the `order of elements regular
+<https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com>`_. For example::
+
+	__must_check __printf(4, 5) __malloc __init
+	static __always_inline void *action(enum magic value, size_t size,
+					    u8 count, char *fmt, ...)
+	{
+		...
+	}
+
+The preferred order of elements for a function prototype is:
+
+- attributes on the preceding lines
+
+  - return type attributes (here, ``__must_check``)
+  - function parameter attributes (here, ``__printf(4,5)``)
+  - function behavior attributes (here, ``__malloc``)
+  - storage class attributes (here, ``__init``)
+
+- main function prototype on the next lines
+
+  - storage class (here, ``static __always_inline`` -- even though
+    ``__always_inline`` is technically an attribute, it is treated like
+    ``inline``)
+  - return type (here, ``void *``)
+  - function name (here, ``action``)
+  - function parameters (as described earlier: each with type and name)
 
 7) Centralized exiting of functions
 -----------------------------------
-- 
2.30.2

