Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6A6C43214
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 16:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BBB560E99
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 16:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhH0Qb0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbhH0QbU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Aug 2021 12:31:20 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF08C0612E7
        for <linux-hardening@vger.kernel.org>; Fri, 27 Aug 2021 09:30:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id t42so6100597pfg.12
        for <linux-hardening@vger.kernel.org>; Fri, 27 Aug 2021 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZ7w9nrQr4P1IWSgKdcY6Z3nzDxlYwk7QATUALf7otg=;
        b=AUaH8LHTxnNOodpzuuYzLiG4/cVeJLWGjI/YM0gDk+lWx8HLU/7/HC6+7N94wjqY2N
         xsCcNuwkJqzizXolSlmfLYnNMGYvoQvcDtFwRKBpMmWb9QxdN5KXZk48E55Qptv4y+Uy
         Z3Q+n9fQ4GVnlimzhoQ0NT71RobVN7+28vk+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZ7w9nrQr4P1IWSgKdcY6Z3nzDxlYwk7QATUALf7otg=;
        b=UoxchSv8QFb7GMtZCXfsAG6bSXi+q68/18cxLHR8VJDc3LQWF8z0QWPoK8dF+Kq215
         epkrCR+n/L0k06sP4wkhSqIRL745Rcp6qDdQpGxec2wDgZA8x+nWs+PIwptRVkrlGIL4
         4fRwW3yxUsGLoP1szPqhg/bCJtJ7FUJojeGA3Zqn+gwbWSTwDttU+6DnHF4EMxQtz03w
         aI89iiWBZapI1HyjDW1kFf9tVa7AvVA6i38KtYjIkK6emH97ZUZssoCgxGslIFt7LBbx
         w3s14jcG6y8dH9FEdMGAjMzp7WRmoq2poH0YyZ0gNxCj/IfM2um/gMW2jAgMsgrnvM+F
         Iahg==
X-Gm-Message-State: AOAM5329yCUMV/tNeXn36ut/8n1GrGXci+HdgJQcHBOkTMuq/99JIAWu
        DUkXAQkonvexX1xR+nID5Wa9zA==
X-Google-Smtp-Source: ABdhPJxF6d2WDm1ndBGxujInBCdm38Attvke2+ydBHtrDX1lH1nSXAJFJ3JLOPRxFjIy2r23FNYNzg==
X-Received: by 2002:a05:6a00:1589:b0:3f2:7075:3746 with SMTP id u9-20020a056a00158900b003f270753746mr6974752pfk.35.1630081829313;
        Fri, 27 Aug 2021 09:30:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a21sm1056797pjo.14.2021.08.27.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 09:30:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/5] stddef: Introduce DECLARE_FLEX_ARRAY() helper
Date:   Fri, 27 Aug 2021 09:30:11 -0700
Message-Id: <20210827163015.3141722-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210827163015.3141722-1-keescook@chromium.org>
References: <20210827163015.3141722-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5572; h=from:subject; bh=8c+U/iZ/gycRs8w0t9BFRRAIIYbu9Tv+SQs3W1gDUds=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhKRMWWOizJLxfxAKDY9M1B0NWYHAQZ0rmE/jQBiGJ xEEM+v2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSkTFgAKCRCJcvTf3G3AJuroD/ 9MopnQF8VZySpYDfNEEXUgKmgmCUX+G9pVEV/h8Cfmb1ViQr1+ykyuvzf/eH7jslS6vj0UyxtTa00o H2MazDMxzHCyXkSHPtmai6DO3aQBKsEKbsDYAhmiIEyFYuzDHs9+/8JQ7p40gssc7KA5dHx7/V9+04 vALrNSUzLoZqfNQY80xOldjifCwn8p7gMA172DMO9kka8QYQVVdkhUZmcpQ8vT4j2zHMRDmu3cFJ3G 5QDUSgLxDa0q95rEhm1E4qytSUjJ9nUBU3i7k5KKElTtSL8yadPyiUwimZJV+Qcf0pten/ip6zCpob eWCHn13w2bGPO8ymxzCuKSd5hCwon3asjJRypNd/7L7aNrK71wN9WQZAV503wOzK/J20aQUHWFcwxU wNMnXbonCLwDYgNOnIyrMD1VwLXGeINhOXu4Z/XOehuiCR2iWjk2YpBPfNVx26OgapNYcRDA/94IOF YrHxed+lWSd9Md+5wCrVHsly28/HnuSE3vaamZ26QRTKrMfdj31tximpc1m3pOYr9Jnsh6GNgHLOEJ 3oT/yJQYfMeeAMOzZQLGf7DVStSgA3MJRWTDjgaAcTV/HyxbFTmXISprCuB9FyOyjE6HYykchs0P/F NIP5ZyVXP9wPP6jWQxH5H2FrM4H8B9JoyBLDyJfujOO5YRetAubwLVDaKGYQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There are many places where kernel code wants to have several different
typed trailing flexible arrays. This would normally be done with multiple
flexible arrays in a union, but since GCC and Clang don't (on the surface)
allow this, there have been many open-coded workarounds, usually involving
neighboring 0-element arrays at the end of a structure. For example,
instead of something like this:

struct thing {
	...
	union {
		struct type1 foo[];
		struct type2 bar[];
	};
};

code works around the compiler with:

struct thing {
	...
	struct type1 foo[0];
	struct type2 bar[];
};

Another case is when a flexible array is wanted as the single member
within a struct (which itself is usually in a union). For example, this
would be worked around as:

union many {
	...
	struct {
		struct type3 baz[0];
	};
};

These kinds of work-arounds cause problems with size checks against such
zero-element arrays (for example when building with -Warray-bounds and
-Wzero-length-bounds, and with the coming FORTIFY_SOURCE improvements),
so they must all be converted to "real" flexible arrays, avoiding warnings
like this:

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

However, it _is_ entirely possible to have one or more flexible arrays
in a struct or union: it just has to be in another struct. And since it
cannot be alone in a struct, such a struct must have at least 1 other
named member -- but that member can be zero sized. Wrap all this nonsense
into the new DECLARE_FLEX_ARRAY() in support of having flexible arrays
in unions (or alone in a struct).

As with struct_group(), since this is needed in UAPI headers as well,
implement the core there, with a non-UAPI wrapper.

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

