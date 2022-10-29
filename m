Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2739AC433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 29 Oct 2022 07:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJ2Hrn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 29 Oct 2022 03:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2Hri (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 29 Oct 2022 03:47:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA47BE2E7
        for <linux-hardening@vger.kernel.org>; Sat, 29 Oct 2022 00:47:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso11872476pjc.0
        for <linux-hardening@vger.kernel.org>; Sat, 29 Oct 2022 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iET1MgkbhbQrIxry/f1xQYIkFRrGZlUGPdYAoIr26co=;
        b=mZ3+TLyyf+YAKB6grPKR4XJ64ryv/j+QR/P6vbHxeyyDqxta8DzxJBAT0AaWaRcsxN
         nzKNfDzZQD3pOYizxknWM7Oc2ip1Ate6WKBBLygfgNdP6vxdJ1fhIB39b3y0VafFUmri
         O4rrz8qlJ3p0Y7v2a8Jj6ZXoFXIjk3cJCQqac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iET1MgkbhbQrIxry/f1xQYIkFRrGZlUGPdYAoIr26co=;
        b=CX643FU+5FG3Huzb5OVyJriQyNCIIyk3ba42rST4Tn47lIjlz5CNP41BQ7HKU6vGYN
         d+clWgM1NgP0jsePomIjOUxbW3/CKGq47BuzO4PD6hruGb9u5uuuNrCOZe8Sj3hckmnu
         BWj/eDHEy1ql6/A7ot3FXXRn2+k2wGYetcEnY6nPyzV4MDKc+NL+E/LIk7ifsWwAtQ8e
         RmTrccg9eMUpLGIz9e67tK99e6GAgDGqRz2stv7BX6wxqtYajlaHpqOsl4uAceUXuxsm
         nzB79w5vwpBjZ18HL5qGlmnolXGR1gf8XD0GygmYkScLKhWb3/sbC+hsc5gjZy1KrFsP
         /8eA==
X-Gm-Message-State: ACrzQf058DmfHWdxJqVwQiSIFhx9DoMgKDHeLvTu47PKxSz8NnSQV2CN
        9vlm5k+f9KW0bDcrYVsEd8w7Vg==
X-Google-Smtp-Source: AMsMyM6EQFHolbOhV4RL/gqEjO0/bGgmWqy0y9idJlsq+LxGSpsMRetUiPmZAXkaNByP2MTtjVUYog==
X-Received: by 2002:a17:90b:38d2:b0:20d:8f2a:c4ba with SMTP id nn18-20020a17090b38d200b0020d8f2ac4bamr3487572pjb.209.1667029657664;
        Sat, 29 Oct 2022 00:47:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f19-20020aa79693000000b0056c003f9169sm622842pfk.196.2022.10.29.00.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:47:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] driver core: Add __alloc_size hint to devm allocators
Date:   Sat, 29 Oct 2022 00:47:34 -0700
Message-Id: <20221029074734.gonna.276-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; h=from:subject:message-id; bh=bl4eK7ug971gaAZ+iCba/RVpEILgA2NDbUfm+iHo2MU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjXNqWRHPJAx2S72TjRZFwkW12qVeTilB6z4pIHrNa c/9Aig2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1zalgAKCRCJcvTf3G3AJlwLD/ 0Y6tYgGRaOz6Lukqw+GWNHimgdpRgR4fATDqodCPbi6IY5H8g6UW5BNhVD3q2vuACKCPD8w6LANjvM pTRi3hZMQ1UV+USbzrVVM//6gq0A0t2wy56J5gM3tSu4FvPSdXS9URKPyciGhZmi02k0fOc4OZ8QjK sAJD8M5AiKkiKAQPBuYR6f7tkz8SoXqn3NKVoLiroDdFYdeC/HZMzNNVcku1xi8WA90FoZvUedLsxa 8ajzgWmyIxN3Kqw/5J6I4Lo+wJ/yyrG/wnZCHVYOgD9B+LPe/TlY+4yASZ+ceNJbxL0ffP/69QSRlR vv65snxCu2GVhUVENXo8/psgXq0xFs2Z+GWJS3t5s1+5qebWRSgCy/UofykafWYWcwyRVXLHfSxQtd LpjzN8FTXLQ20gE2+dk5jWtoz2WTCIJh5t6u/LJfPotnL3XEyzTdFfaBMOtMgAGnxFHJlqGYZ6qrsS Dqh1U1Ou03qiNw1PYwawc0W5zfRKs3fJPC7IatsrANWKhRKreEiyOWAnG4DLiW2lyewq5sU6wofRNs GjjH+WNE2ueP2aB25LRTCd/IER775Vq+1Ez5N4NkjiVfrQd/aHsCL6ND49qHGlvSyzEhirTfMponQv BdMn73gkuVKNWTCxfhP7/JC9MZTNoBfHbI5Co81CvaGs8Ts0ohYrrFZ38lZA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Mark the devm_*alloc()-family of allocations with appropriate
__alloc_size()/__realloc_size() hints so the compiler can attempt to
reason about buffer lengths from allocations.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nishanth Menon <nm@ti.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Won Chung <wonchung@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'm hoping to carry this via the hardening tree so I can add a
KUnit test that depends on it...
v2: use __realloc_size instead of __alloc_size
v1: https://lore.kernel.org/linux-hardening/20221018073430.never.551-kees@kernel.org/
---
 include/linux/device.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..5e4cd857e74f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -197,9 +197,9 @@ void devres_remove_group(struct device *dev, void *id);
 int devres_release_group(struct device *dev, void *id);
 
 /* managed devm_k.alloc/kfree for device drivers */
-void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
+void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __alloc_size(2);
 void *devm_krealloc(struct device *dev, void *ptr, size_t size,
-		    gfp_t gfp) __must_check;
+		    gfp_t gfp) __must_check __realloc_size(3);
 __printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
 				     const char *fmt, va_list ap) __malloc;
 __printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
@@ -226,7 +226,8 @@ static inline void *devm_kcalloc(struct device *dev,
 void devm_kfree(struct device *dev, const void *p);
 char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
 const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
-void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
+void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
+	__realloc_size(3);
 
 unsigned long devm_get_free_pages(struct device *dev,
 				  gfp_t gfp_mask, unsigned int order);
-- 
2.34.1

