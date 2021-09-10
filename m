Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EF3C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 20:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E1460F11
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 20:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhIJUMt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJUMs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 16:12:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925CBC061574
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 13:11:37 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k24so2825565pgh.8
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7HIFtoBlyG0EOkfv+tc91slZfebBpcNpI5ghV1QQ6i4=;
        b=myLr1veux4KcLuSyt0YHMY6RvzfOK6FkfNfwPIJNPaPxPs6IZ6H6NpcA+58n4vSIfj
         UBcAPbxUWFzFjqucNORWxrwp2nyB4tJfqB0snHTKJn5fNnR2Pl2GJuv0JEW5NClJt5j2
         QlnIz+snvHYXaktUyND9/IaBArqmXLfWD90Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7HIFtoBlyG0EOkfv+tc91slZfebBpcNpI5ghV1QQ6i4=;
        b=dDRWHzgJ8K4wV3JQ56hPNGM0FSjdanr5F4XjScFRIihGclBH+iP9HyEPSLm5r7NroO
         u81llxuYGYocxU7wzq3wh+Rr788Op614Xzpo4cz6mq6oBWFvEbZKb++++9gTC9xxbv3b
         A10CyC36dbDQVaHcKHKWKBrNd9SC84AWLEwIKgP6Mtz1bxOKRybPT+xGTU5OQRircjVr
         3nOukVfYR0K+FxoZeFqEAm2GXBOF0OHp4C6ommZ5PmOC0j+uZvne9rF5clmo6gzBjtvX
         sa7QBN4UwDqnDNHaH6oZ9CF+E+iDsJcI7e6R1sBAbcPCORaRps6PA185177jiMS4n87s
         XR6w==
X-Gm-Message-State: AOAM532LY+RJEc7WXxI8zMIloagDX+axzdykwm6wXxZdlxzUfDZpfII6
        DKLiIAqe8yJM1YC72EW10KiWiA==
X-Google-Smtp-Source: ABdhPJw2yq74AR1u2wFLX0iItQ/ESSi+V/uhF4Lo21d7fhS0OXUod16ZxgLPWHlH6Yz0Do0EwvQxLA==
X-Received: by 2002:aa7:88cc:0:b0:431:c124:52ba with SMTP id k12-20020aa788cc000000b00431c12452bamr5865875pff.63.1631304697033;
        Fri, 10 Sep 2021 13:11:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x189sm5734501pfc.52.2021.09.10.13.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:11:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] Compiler Attributes: Check GCC version for __alloc_size attribute
Date:   Fri, 10 Sep 2021 13:11:32 -0700
Message-Id: <20210910201132.3809437-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4636; h=from:subject; bh=KHAXFJo5dkuN6zHwJcwy1LKLIIvBjiceufXY9UFOeO0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhO7v03n7ozNynlrI0mCOhXsO0I+PQ0vfI4kDl2YMW wkZlObqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTu79AAKCRCJcvTf3G3AJq8ED/ 96g5XnovCzaeqJkRR1ejeyT3mRdQdQzHR2TRH8ZwZEHdyXtgnkBowyVl0GoySzhBe58Zs+clOugJ76 ASF8/cLd1KuiQT0rwr61be5n904OGPy/HY8RS19CidCDu+PlP8eXuN/ZwkSnLUaI5bcj/GlZPE7CnP N7cpQ+tHAWJSlaqds3ogMxOczy13ziGgxsJgfCXXr5v55QttaNxgsS7TbYLPMxoZp8aQ9qq0D9wFOT UQFpdIBiGkngp8K2OTsGpmWskcxb5NufKWcAVz+nGQlX0OBTTIqTpg+c6Xx7/IDTgN4wcZ6RNC31LV PijOsdv1tcOukUJc+6LXL1BCy1/gthbt2hfnhS6Wu8jwEP3pEvvee3lTjLetSgUKhicPVUo9UdYJvM tRn2b1FG2QzWlq3zSuRuLTJIHVd7OGBFfXSqZ8s6ypqWO18XtwFXXnKLvyTJCzm2Ntfjr17nxVm37l /fTZj7YgcWT7enVUCANU4Ru5RUHIzDiDG1emZtj7qSAz/37lEPE+/qVQc9qQEnZ55hccq7maDZF2WF KxQ2pWML9ONwOxuBIoGiJUPa0q+vbzW56gqefWfvTdHIb4tsiEojNKPQ0Va/itkGXLICe21SIy5+oj 6XE5caYK0a2T+td8HpqVcLn/nOmpEkxRjbcgMvD+mYR2w73/j4MaCsknFr3w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Unfortunately, just version checking the use of -Wno-alloc-size-larger-than
is not sufficient to make the __alloc_size attribute behave correctly
under older GCC versions. The attribute itself must be disabled in those
situations too, as there appears to be no way to reliably silence the
SIZE_MAX constant expression cases for GCC versions less than 9.1:

In file included from ./include/linux/resource_ext.h:11,
                 from ./include/linux/pci.h:40,
                 from drivers/net/ethernet/intel/ixgbe/ixgbe.h:9,
                 from drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c:4:
In function 'kmalloc_node',
    inlined from 'ixgbe_alloc_q_vector' at ./include/linux/slab.h:743:9:
./include/linux/slab.h:618:9: error: argument 1 value '18446744073709551615' exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
  return __kmalloc_node(size, flags, node);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/slab.h: In function 'ixgbe_alloc_q_vector':
./include/linux/slab.h:455:7: note: in a call to allocation function '__kmalloc_node' declared here
 void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_slab_alignment __malloc;
       ^~~~~~~~~~~~~~

Specifically:
-Wno-alloc-size-larger-than is not correctly handled by GCC < 9.1
  https://godbolt.org/z/hqsfG7q84 (doesn't disable)
  https://godbolt.org/z/P9jdrPTYh (doesn't admit to not knowing about option)
  https://godbolt.org/z/465TPMWKb (only warns when other warnings appear)

-Walloc-size-larger-than=18446744073709551615 is not handled by GCC < 8.2
  https://godbolt.org/z/73hh1EPxz (ignores numeric value)

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: llvm@lists.linux.dev
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
And now I've added GCC 4.9, 5, and 6 to my build configs... 4.9 is so
old I have to turn off RETPOLIN in defconfig. :P

v2:
- fix lack of VARARGS in fall-back macro
- add reviewed-by
---
 include/linux/compiler-gcc.h        | 9 +++++++++
 include/linux/compiler_attributes.h | 6 ------
 include/linux/compiler_types.h      | 5 +++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 01985821944b..3f3efbb651e0 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -151,3 +151,12 @@
 #else
 #define __diag_GCC_8(s)
 #endif
+
+/*
+ * https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
+ * However, prior to 9.1, -Wno-alloc-size-larger-than does not work,
+ * making this attribute unusable.
+ */
+#if GCC_VERSION < 90100
+#define __alloc_size(x, ...)	/**/
+#endif
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 19f178e20e61..2487be0e7199 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -53,12 +53,6 @@
 #define __aligned(x)                    __attribute__((__aligned__(x)))
 #define __aligned_largest               __attribute__((__aligned__))
 
-/*
- *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
- * clang: https://clang.llvm.org/docs/AttributeReference.html#alloc-size
- */
-#define __alloc_size(x, ...)		__attribute__((__alloc_size__(x, ## __VA_ARGS__)))
-
 /*
  * Note: users of __always_inline currently do not write "inline" themselves,
  * which seems to be required by gcc to apply the attribute according
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c43308b0a9a9..91de9bead40d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -254,6 +254,11 @@ struct ftrace_likely_data {
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
 
+/* If not specifically disabled, allow the use of __alloc_size attribute. */
+#ifndef __alloc_size
+# define __alloc_size(x, ...)		__attribute__((__alloc_size__(x, ## __VA_ARGS__)))
+#endif
+
 #ifdef CONFIG_CC_HAS_ASM_INLINE
 #define asm_inline asm __inline
 #else
-- 
2.30.2

