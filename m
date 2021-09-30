Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB6C4321E
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 22:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513C46128C
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 22:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348322AbhI3W25 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245667AbhI3W2y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 18:28:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E688C061771
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 15:27:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 66so7222214pgc.9
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dXnvTeLUCigPMMnfClviJlp/0W0l8ED7JBU+sWSCTQ=;
        b=bMZ24ZC9xNEa42Gpp5q0OztRhWlyR/ZPd/+MgSdXTcvZCQG7O0+Wdx+raEdQ/4tzNy
         gQaJq/poDZ3jwv+wiaGs/Td1V8f6U4K6bVJiyR+Rz5hJdDKQY54CKdGwZBd2hCyceMxX
         ZTVawkl8i/WKLzQSXc3qNgvt1NrL4Lw5chYf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dXnvTeLUCigPMMnfClviJlp/0W0l8ED7JBU+sWSCTQ=;
        b=5fK6GQqcwShNvBt0C1aFAznVadf8/8K+IEtmQ7+ydgp90h6BA7l0F0iOOd6ngaF7ei
         Twmbr9TfTq0yOkmCLRgUJWxJ7GZKXLuUD2CSSWAq1iDebvYa5gsXIR3bMUu9B9UA8eU9
         timkwLY5ckFb2EeTiButXzBRXTJmcyob+NT/2G0212ZwQOfz42H7FLSQYdLdYUO4TvnN
         kMGdsmgG0tIhiyi1rNc/snbGzBFegxtNnz/xuNpjuOzA9oPj2jWHLys9fafRdqwIB92T
         goDEaaWahalwyI2fa8Scw58gDo3gY7ebu1q1qZpQNNXkCLITzo3OHNvsIdkhMSTrgOI7
         L8uw==
X-Gm-Message-State: AOAM530KpYMTUXIbZT2kd5PkvyqMQWh3IMbWnzQJSrkO080yIkFmktTP
        5SUsR3SwQPGxPz78sOCTczJaFQ==
X-Google-Smtp-Source: ABdhPJyrj4NqgodUUPoi2IgyK2epGmWmMuNVscNW84sxyOH9pkrPwIMAtF1vD9v9H9UnFzvcAhJSxA==
X-Received: by 2002:a05:6a00:2355:b0:44c:86c:49f4 with SMTP id j21-20020a056a00235500b0044c086c49f4mr2934102pfj.58.1633040831209;
        Thu, 30 Sep 2021 15:27:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11sm4343540pff.144.2021.09.30.15.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 15:27:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 5/8] mm/kvmalloc: Add __alloc_size attributes for better bounds checking
Date:   Thu, 30 Sep 2021 15:27:01 -0700
Message-Id: <20210930222704.2631604-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930222704.2631604-1-keescook@chromium.org>
References: <20210930222704.2631604-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; h=from:subject; bh=SyAqtHelf0a2iaKyecEWVo/GxwzRnhHwreNN0BUqqAM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVjm34uKneQvmJxQTing9NsARvbB4YKVUTexQ0P2y 4HvehcGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVY5twAKCRCJcvTf3G3AJsMKD/ 9B9MOpTz9EJCrfrNonEyW3Gcj0s3yDYKmzoBbslhRxx5a0fa99XtVE+I2QWPrCjRokk1liutNYQLoo yLJglYmUbLAFF3WWNXOokAxVRQq8fdfavcfOtP/bRUGwY/F5T1hq2GLFPf8Pb9CYi5x6t/xmJhA67j +xXO5cmxVNE3sx3rIfq1SlyI6mmWvUthEwPSh7eresXvI8dGbuowLNZeO2RM8rj0ztdJxOZwCwojE3 3Nh0gLgYdo9dhmk/n0ZSkivI/4ngDHgEKhWqtPGPB9huz6hMX/SLF43qOm2yp0TwGrbG3z8ttQI8LP Dn7M0W254iTtwkG14RIzU6p7JuSjCfka1aYXPm37kCNv05P7qGr4W9bt89PJCHQCNa65eGirF14Ar4 lswTo3DH3SrXOZYViivXsbrYJmqlvorKH9Qi2sc6wnYb3JPmm6L157vJb3nZrJp7h9vpntHisy9ntI wELx7fONPE9NZHbruTuE6ONgalaoV7d3pxMPeGlKvFvhywPhHBW+GIxJ0ngBMLXTBE5//Ox1Yx/pJ3 VVRY6wlDwRQ/ZGk11cdhPFYF8qRhC1VU3fdZQsEEXaWXNBY//nG3Jm91tU4CTuU3FVuWHlWxyjucol zE7IVVEcgE/wXQAoREtVO7sm2dQSi9j/6da9yKArFV5nlaE7fduEFEigworA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As already done in GrapheneOS, add the __alloc_size attribute for regular
kvmalloc interfaces, to provide additional hinting for better bounds
checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
optimizations.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Co-developed-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/mm.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 73a52aba448f..03dfb466d4f5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -799,21 +799,21 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 }
 #endif
 
-extern void *kvmalloc_node(size_t size, gfp_t flags, int node);
-static inline void *kvmalloc(size_t size, gfp_t flags)
+extern void *kvmalloc_node(size_t size, gfp_t flags, int node) __alloc_size(1);
+static inline __alloc_size(1) void *kvmalloc(size_t size, gfp_t flags)
 {
 	return kvmalloc_node(size, flags, NUMA_NO_NODE);
 }
-static inline void *kvzalloc_node(size_t size, gfp_t flags, int node)
+static inline __alloc_size(1) void *kvzalloc_node(size_t size, gfp_t flags, int node)
 {
 	return kvmalloc_node(size, flags | __GFP_ZERO, node);
 }
-static inline void *kvzalloc(size_t size, gfp_t flags)
+static inline __alloc_size(1) void *kvzalloc(size_t size, gfp_t flags)
 {
 	return kvmalloc(size, flags | __GFP_ZERO);
 }
 
-static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
 {
 	size_t bytes;
 
@@ -823,13 +823,13 @@ static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
 	return kvmalloc(bytes, flags);
 }
 
-static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t flags)
 {
 	return kvmalloc_array(n, size, flags | __GFP_ZERO);
 }
 
-extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize,
-		gfp_t flags);
+extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
+		      __alloc_size(3);
 extern void kvfree(const void *addr);
 extern void kvfree_sensitive(const void *addr, size_t len);
 
-- 
2.30.2

