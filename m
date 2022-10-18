Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5688CC433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 07:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJRHe4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 03:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiJRHew (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 03:34:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A0220C5
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 00:34:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u71so12620354pgd.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LlsuHZmleDlGS7hXnmTuG4KQrPThOgrPcWg+CPNzZ2Y=;
        b=lbc5UKDbqNoCtYKP519m1+Nh5+thrYMQcy0LlJI8WQVPOOebBqFmQNzsq92hnwGkzn
         3PVd6AetOnLncoxE4j0FqlexwwNWGZLQj+FUIopGxBZeb8O7t7RXlORIhxxP6rjDxd6P
         VNi2rPCGtNrRgaRJ9balyeEtPKBM0VeQKnexM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlsuHZmleDlGS7hXnmTuG4KQrPThOgrPcWg+CPNzZ2Y=;
        b=DywYFVllOOZEHWsXkcyBjAG7x0VHYyhBpAQXnjM3Lo565G2bU/Aoiw1RDetZSkPgdm
         H+1gB9LWztUlxLorrNyFyhnodNYuwtXWdLnZ7uyun0i0kHliFK1MKA4jSOBjRTefqaJz
         sLkvFcapuVY/ayBZoDOEJswKNw1WXW5A5xjyAWHTCQTZrQCGLwINl7pNHrPcf636jwmC
         5qz68DE8AVPzsEd9oU38WYFwEeodlsJte0Y2ekvlnm/n5xPqi4Fdj5lewsGpfkUtnvLR
         +OLd0aQ+rSiajLNTFEZj8WVgemDeMy4LKiY4v4dFsha6kLBUsDc6pEVmIW0LhybTP5xd
         hadg==
X-Gm-Message-State: ACrzQf2UnvPNhVsHD+ZH5KGabEWcNq32s+n2gXcWxVpj2zqCkCFVkK/x
        q02UDSVnjRB2rlD4HhJk52gnZg==
X-Google-Smtp-Source: AMsMyM78EuSXkDC01QK0wX7MgEhcw+6IbE7/bRqAaJhG7eThBIWHw0pu//3whOpPr9NHeVGABU9tsw==
X-Received: by 2002:a63:2221:0:b0:43b:f4a3:80cc with SMTP id i33-20020a632221000000b0043bf4a380ccmr1543022pgi.367.1666078491096;
        Tue, 18 Oct 2022 00:34:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o63-20020a62cd42000000b0056258a3606csm8378759pfg.215.2022.10.18.00.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 00:34:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] driver core: Add __alloc_size hint to devm allocators
Date:   Tue, 18 Oct 2022 00:34:47 -0700
Message-Id: <20221018073430.never.551-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; h=from:subject:message-id; bh=bz9s+ekJyLE4FWcnomuQSloLzhEk4e+5O8t5nTvLkPw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTlcWPmKRYJExrJMYBfXkIFPZXjLaDn+MpfMNiKR0 Y3SacTyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05XFgAKCRCJcvTf3G3AJk2HD/ 91RjYQfqDb06XAma88pJqfLxntl+ZmLIK6HoEa9cpfJlpOb0VrM2NUsth9NuPqSYxrE43QWZ+oATUG yBItJ7YVQPmJHbWjdn/S04rMjB1lcbjft1TPm4HGV7eMXPfWIR6mTgv4cNEUrfGn5f30hgT7BFUMvg OEQtVKyRigOonq/AaAZqIkAPfctm1mTr3LBpmBraQKrezwe6qQRRizPCHAQRY7msd0EO9KSn9q8+s9 TFh1a4n7Zwa06deQ2wVZaD53WXpc9er+c5HNplcin9+NJFz2pMCc79aNkRIFvs09jGnllzdtQ3zX+K MW53U0n3s/4mr2/HSYOor1f2TkA0ysz+dpj69VzeoRkKJnVXNZ8BDzXbmKFvndsao0AA+Y0CfZoBw7 04KoMRC/b9tzyBJW7lfmM46WXaPgsMGXBLlMH9NHBazXIepofyWFd4uJAZwNDBJcerVU1LhMjdGNKB vzKH31svHifUgUStFk08b0gALDpawNjMq2NdyqO9DL1upbWU+HM8P/djAwVifovATK6I7Q65R3mcli lz+qKxw4rPIH7HrpgAYapQ31rRZCHhdiqyg7U8LES8ZSU8jtUau1L7bI4a95w8+sN6Aq7NMkWleB2W jL2jOaI3BbLbea62IROIE8Ox5s4FKOG4jBbsLw1ppYTGb8QOCWO72DCnXHLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Mark the devm_*alloc()-family of allocations with appropriate
__alloc_size() hints so the compiler can attempt to reason about buffer
lengths from allocations.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nishanth Menon <nm@ti.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Won Chung <wonchung@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/device.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..a1cbbab9a57a 100644
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
+	__alloc_size(3);
 
 unsigned long devm_get_free_pages(struct device *dev,
 				  gfp_t gfp_mask, unsigned int order);
-- 
2.34.1

