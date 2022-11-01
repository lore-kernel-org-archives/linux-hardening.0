Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF4C4167B
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Nov 2022 22:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiKAWeN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiKAWdZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ABCE15
        for <linux-hardening@vger.kernel.org>; Tue,  1 Nov 2022 15:33:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k22so14786194pfd.3
        for <linux-hardening@vger.kernel.org>; Tue, 01 Nov 2022 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR4DpXpArHwTB3Q/Fu/HeOb4zcIBa/dUESXAom+m+r0=;
        b=XR/R95kGIa5eEkN76ZwYFuGmF701nv7uoFFFHP2TDaZ1ZmYYGsHVPdtxhWMxyL/WIi
         nCK6B5wZeapBAY98ZRSshrqH6a9cTH0OVkAfTMWjC1cvjhFcFP4YA0gCgsYYWTHaaWCN
         e1LQ8yAUTs+wD/EXihacl/voB7iSFt12/H44M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR4DpXpArHwTB3Q/Fu/HeOb4zcIBa/dUESXAom+m+r0=;
        b=5ZMPmKZXpNxmHi4PvUkx5h2B9NHoXLkECuPCq54X/2nu32phEkMJfvuIiYACO3FGdI
         aAbZHe1O1/t7Jojw6mp3Adc5wgqSNCtGDppwKg5vY44dOO3hUwd4hSJYEcoCIDVdhqGQ
         E7fj0G6enRkLlJu216w26SPExaa3pxtwIC66ERX3jHTGwbqaROYgk/ylDYCoBzpWZl6L
         5vgN62xk/nPQE5riItongHaoFgsCiy0ZefH+HczPH5b+iYfu2La4sEqgOLnNtCKmWJWV
         qbn14lRQtorAojw0RYJAVOlRT2xUD23MTLfdx6tdePFayRmlbxOcPmhEQWJOS+Ja3/Yu
         S/EA==
X-Gm-Message-State: ACrzQf3u5TukIaFVYGA2POiqt5qsgZL5H0K3heCSvkqENceQQEJWjzin
        9zyME1EhzVScj5X68KIXWkLmNg==
X-Google-Smtp-Source: AMsMyM4g9RheqgMMXT+kdLVomwlfmHmSq5aYyTAxpX3GmEp3SjBAvxDOTWRc3EMBzPy3MDlV+aTaZw==
X-Received: by 2002:a63:ed58:0:b0:439:b3a:4f01 with SMTP id m24-20020a63ed58000000b004390b3a4f01mr18942728pgk.327.1667342002870;
        Tue, 01 Nov 2022 15:33:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6-20020a626306000000b00565c8634e55sm7000554pfb.135.2022.11.01.15.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:33:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        David Gow <davidgow@google.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/6] slab: Clean up SLOB vs kmalloc() definition
Date:   Tue,  1 Nov 2022 15:33:09 -0700
Message-Id: <20221101223321.1326815-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101222520.never.109-kees@kernel.org>
References: <20221101222520.never.109-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026; h=from:subject; bh=qLerDmEzne6lpaq4KVx5bE//rWAPpMJFdcLBFfnifO8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYZ6pLIVN1gPOfxNyEH/PkysO24BYL1rHsOiqB1i7 kWFfzeSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2GeqQAKCRCJcvTf3G3AJrdeD/ 4sAhVz4+NctD5DHBg37o6IgG9K0ySMSyZK6zpStQkAyDq2iJBxfDehPUeOvWXCzi0t1pj4FcJKPKEm rmF3jK6fNN9l/YgIcfA2vsfbpcNlIPSz76g4AsJbeDB2h2+i26p17KgcqvewxqWVF4Q02iW0A0De+I 4oYzPaQ0m9NF1qhJPzxZB9e1GE6j8cUvXDSA9yLbZj0PnLyrlvlul4Tpx/08wQPiAy2Q86mQId55ff /tq9+XQQ5mebvYuakkhQ8FRzgDZNrrHrCvKLbkH5zqkJ3MoF80v8rTPNBDSZW3gaE/GUQPW6TfUgaC mfU+pPrGsMSsz0a89B6UBppmirX9+bt1FanpHkvJtGGLFO2CtoLnQQJKHQXiejPbzpvRidg5bO6kZg HH3p7tMaxy7agCjUaLN9ztuvyRTKe2+kZKOKUteAq4qnEeDqxU3aRvK1APufm4pmniPE0Qn4aJOFxT 76rbAfdpsYv6dmYqpt4eBnuZExBOP6tUTbZIiONbnqnfttx/IAtoqJ4N9LP509HXUoW963HfvoAle+ +DdkpOwzNyjyT+eMv3R7i1ltBDcWj+sUV13ARcRXfpT3ib9UpkLn69A88U3E1PXmlAx6rsGsfIv/Gd OI5HWzey0ZmhYUdvHowXft3iJ8J2zccRoZT2HYEYNpBvBi4hP8I/X6mDxy4Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As already done for kmalloc_node(), clean up the #ifdef usage in the
definition of kmalloc() so that the SLOB-only version is an entirely
separate and much more readable function.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/slab.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 90877fcde70b..e08fe7978b5c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -559,15 +559,15 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
  *	Try really hard to succeed the allocation but fail
  *	eventually.
  */
+#ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
-#ifndef CONFIG_SLOB
 		unsigned int index;
-#endif
+
 		if (size > KMALLOC_MAX_CACHE_SIZE)
 			return kmalloc_large(size, flags);
-#ifndef CONFIG_SLOB
+
 		index = kmalloc_index(size);
 
 		if (!index)
@@ -576,10 +576,18 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 		return kmalloc_trace(
 				kmalloc_caches[kmalloc_type(flags)][index],
 				flags, size);
-#endif
 	}
 	return __kmalloc(size, flags);
 }
+#else
+static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
+{
+	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
+		return kmalloc_large(size, flags);
+
+	return __kmalloc(size, flags);
+}
+#endif
 
 #ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
-- 
2.34.1

