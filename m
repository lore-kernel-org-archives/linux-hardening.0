Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C767C43214
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 05:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF06610A6
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 05:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbhHZFFu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 01:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbhHZFFt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 01:05:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7525DC0617A8
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 22:05:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 2so1705651pfo.8
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 22:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bjf8zsEWLFO7/Ib/h44uO3Tc/LDuVPPKXDL5B0YH1P0=;
        b=ItBe2AmTFmlXnGgM3OXUjArQz/pCBHNTNWhADCdTfqmaG8j+pYR40cFoN7g6S5apQk
         FNFLKMlswwBFSNCIbS6RmR1uVnEvSz0vhN79BTeVXwbV5Nxbq7XNCuvs5tGBoS4MhiSF
         k7IWXgpuvgsaqASj1sTThqkJIjZV3l2XAWqaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bjf8zsEWLFO7/Ib/h44uO3Tc/LDuVPPKXDL5B0YH1P0=;
        b=evHXY3WOEvJYUsyXtJOYmzBCtILafrXBaKdQ709m2/ZG1Dk7UJlCzMYcZsfMxCgVUp
         ZjINW+iccmaRiIlA0urPyGThD7DqcdiPXuDt6lkOFmZj4jTeAaaRn4gaKbnNqkMRyu/E
         oscYnn8t6HgEJsiBOAkIzC0Fgqc+kyveYhmR/tX+HrjJB5YUr5XLXr351cfX0RfbioJh
         K6PflmsLnLHmZR0HjqGV62Wpsmvv7oq1MgTlMxu3Ks6z4JiwrTJOZLHUEg2wMMis1X8y
         qn48dNm74WQMwhD+CQzWkRR7KdNaTSsnPQoZHj9KXh2lAcdQ4FCEemtDjrdi2AkKEfqz
         LeJg==
X-Gm-Message-State: AOAM533wDCXjYGJud0vNrkvoE3a9k5z8BR1qWgP/c6Wlw4aLgePfdxHi
        X6KcvtrDPhFjiFb/UBxUotBf/g==
X-Google-Smtp-Source: ABdhPJz4LBDrbVN7Ty8j/rAw8gzm8IOhqHlWLFmMHx1byZkgYYg5mEnfXIAcUmAQkmY2pVy2dtPAfg==
X-Received: by 2002:a63:4c0e:: with SMTP id z14mr1746894pga.427.1629954301987;
        Wed, 25 Aug 2021 22:05:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1sm1778585pga.50.2021.08.25.22.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 22:05:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/5] stddef: Add flexible array union helper
Date:   Wed, 25 Aug 2021 22:04:54 -0700
Message-Id: <20210826050458.1540622-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826050458.1540622-1-keescook@chromium.org>
References: <20210826050458.1540622-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4937; h=from:subject; bh=OYtDID8J7StNizowp5Wg1fLuDBrb5WfNy3bIGlN/Sf4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhJyD42tPXbGA6YjavUogqBy5DKEOesnsgInMjhgiJ j6k5fzqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYScg+AAKCRCJcvTf3G3AJuIxD/ 9qTo5HJzehOCezWOZekXVh6mKrVwKgNXzFv5hZI6nedbnrqDmEMIEClEBxjakuCACEvA0US6AOe0De /opDL8nhnKWhEndjyrbPcrFCWeO2F2LoPTftJq0vMU76vP3yhWvbs+BkWKRr+O1jKMIzJQcW6QN8vY sEuELPbfhnMfoPyWDlMRdDqt0zRazB/CeRpKtDDivmaHCuoWWLFD/47DYVRvEqS3aFHpI3yYdu1/lo WUDvWxocyX3m2qyi0vB8dLUlBfmoVKpZms/lBfWbbNe855cXI+QY9hl+mE2oNiRCsQmu2VWVJUORfL VeYitMEmXTmt+F9N5smVQLHUFbA1kSFcWRyY3w5z0EVotZu/9bu8HG7W2WtcZIOc3SRtZCv6DewNu1 KOdWDO6JJeZSKBBr8zcPAGmvDFB2rkq8vHqCCfvx/BJArPwETQXNURT9p+1wKQ07yOp1cOP1TP86PG +zVpTF1nvUTYe3Xwb2Lw+hifIekUyuqCErFLT4LRg3E853rbENNkZHX8R6/TXcRmROw8g28vEsWFwG xIVLqjX9CvYp3imX0nIGCZBPUhudrqgDIllOmlnugQtvWrqYWf+i0IZ8oLh0Knnx8fLokFXflc6Udw eChuEIt5f9zz1Ae8qHrsBcua4cmXIm0nMh64wvZWU8/+dyC6v4HuXA3XekXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Many places in the kernel want to use a flexible array in a union. This
is especially common when wanting several different typed trailing
flexible arrays. Since GCC and Clang don't (on the surface) allow this,
such structs have traditionally used combinations of zero-element arrays
instead. This is usually in the form:

struct thing {
	...
	struct type1 foo[0];
	struct type2 bar[];
};

This causes problems with size checks against such zero-element arrays
(for example with -Warray-bounds and -Wzero-length-bounds), so they must
all be converted to "real" flexible arrays, avoiding warnings like this:

fs/hpfs/anode.c: In function 'hpfs_add_sector_to_btree':
fs/hpfs/anode.c:209:27: warning: array subscript 0 is outside the bounds of an interior zero-length array 'struct bplus_internal_node[0]' [-Wzero-length-bounds]
  209 |    anode->btree.u.internal[0].down = cpu_to_le32(a);
      |    ~~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from fs/hpfs/hpfs_fn.h:26,
                 from fs/hpfs/anode.c:10:
fs/hpfs/hpfs.h:412:32: note: while referencing 'internal'
  412 |     struct bplus_internal_node internal[0]; /* (internal) 2-word entries giving
      |                                ^~~~~~~~

drivers/net/can/usb/etas_es58x/es58x_fd.c: In function 'es58x_fd_tx_can_msg':
drivers/net/can/usb/etas_es58x/es58x_fd.c:360:35: warning: array subscript 65535 is outside the bounds of an interior zero-length array 'u8[0]' {aka 'unsigned char[]'} [-Wzero-length-bounds]
  360 |  tx_can_msg = (typeof(tx_can_msg))&es58x_fd_urb_cmd->raw_msg[msg_len];
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/net/can/usb/etas_es58x/es58x_core.h:22,
                 from drivers/net/can/usb/etas_es58x/es58x_fd.c:17:
drivers/net/can/usb/etas_es58x/es58x_fd.h:231:6: note: while referencing 'raw_msg'
  231 |   u8 raw_msg[0];
      |      ^~~~~~~

Introduce DECLARE_FLEX_ARRAY() in support of flexible arrays in unions. It
is entirely possible to have a flexible array in a union: it just has to
be in a struct. And since it cannot be alone in a struct, such a struct
must have at least 1 other named member but that member can be zero sized.

As with struct_group(), this is needed in UAPI headers as well, so
implement the core there, with non-UAPI wrapper.

Additionally update kernel-doc to understand its existence.

https://github.com/KSPP/linux/issues/137

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/stddef.h      | 13 +++++++++++++
 include/uapi/linux/stddef.h | 16 ++++++++++++++++
 scripts/kernel-doc          |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 8b103a53b000..ca507bd5f808 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -84,4 +84,17 @@ enum {
 #define struct_group_tagged(TAG, NAME, MEMBERS...) \
 	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
 
+/**
+ * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
+	__DECLARE_FLEX_ARRAY(TYPE, NAME)
+
 #endif
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 610204f7c275..3021ea25a284 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -25,3 +25,19 @@
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
 	}
+
+/**
+ * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+	struct { \
+		struct { } __empty_ ## NAME; \
+		TYPE NAME[]; \
+	}
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index d9715efbe0b7..65088b512d14 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1263,6 +1263,8 @@ sub dump_struct($$) {
 	$members =~ s/DECLARE_KFIFO\s*\($args,\s*$args,\s*$args\)/$2 \*$1/gos;
 	# replace DECLARE_KFIFO_PTR
 	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
+	# replace DECLARE_FLEX_ARRAY
+	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
 	my $declaration = $members;
 
 	# Split nested struct/union elements as newer ones
-- 
2.30.2

