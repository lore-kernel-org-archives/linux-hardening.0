Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393EBC4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 01:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiBJB4B (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:56:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiBJBzn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Feb 2022 20:55:43 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD12B6B3
        for <linux-hardening@vger.kernel.org>; Wed,  9 Feb 2022 17:45:46 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so4604584ooa.11
        for <linux-hardening@vger.kernel.org>; Wed, 09 Feb 2022 17:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFbiXZ661Ew9fjYfgC6u/MqjxislkKWsUWOZlueLXog=;
        b=byGrfDBXU40CMAMH+QnRmZB2hgpnzd4NGTUutUKY82+AwMVd2EJaISHTE/1ECUa4pn
         MUX+upwrE8IMcQhdBgL9c9HMqEiPyB75Gbk2uvK+EAH5RDmJeWfvinBuuZDxPbUpxGSS
         lmdcQLNrhT7C7ORUJn3fReuqyYy4BRYSW1wZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFbiXZ661Ew9fjYfgC6u/MqjxislkKWsUWOZlueLXog=;
        b=wRdfMS+1w0w3qnEM4kIAW8ZBFUwKnqe0VbgNqlxkodDo4TQBwXWjC24e3KEaewv9lY
         eJk01kjpl5eFFQfLtblX6kfOyiCWqC7abmu93i2Snn3eygXwig1YGXBw0XBEz/WgYjGk
         LkLvRvBGVXy7jqvjLWYtQ+f9nxEj7/sA7K9NPsYSTMDxYGGvQkM9vryOGr7tpF4gXv4i
         JdWIt2hvGYcoqnlJVBgISAjHxD0ogFCkJeqEryMvInE/dF5qFTo9rq07z5Bq/QMH9o+y
         f43no0kB/F4K9oXlVV6/LtlBlEPez7pOHcOpkuYDrQf81i0VoplnPEQPeh+j6HPli5aF
         S97g==
X-Gm-Message-State: AOAM5302l4Cur+GBHs/sfTrErR8oP62RXXC2i8A4hfykMNzZI/uLA4Sy
        e8Llcgkhg3+6fSYv3PGGLMF5wwf7g++jGg==
X-Google-Smtp-Source: ABdhPJw+ZghIulP0lt/u5PYX2r5k/dJWK03itV6SCLMJRIfcICpmHfG8aQwsu7+Iq2Lfh3+XNlri9w==
X-Received: by 2002:a17:90b:314d:: with SMTP id ip13mr18418pjb.42.1644453808447;
        Wed, 09 Feb 2022 16:43:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r12sm15047114pgn.6.2022.02.09.16.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:43:28 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] overflow: Provide constant expression struct_size
Date:   Wed,  9 Feb 2022 16:43:26 -0800
Message-Id: <20220210004326.776574-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666; h=from:subject; bh=14Ho7e3+FD8cqq+qkLYHbJIZoGsnOpApzExmvlYtrYc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiBF+tnHoL+rQk6Nngev4Kq+u30muSK0zNRaDjdCOE 1Oj38ieJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgRfrQAKCRCJcvTf3G3AJs6FD/ 9avPoQ7Z4IlMHbSykAxXrGFYSF+wvMgfe0LImCrE+GjGwL4rIgyN23by0prK/cgL3Y8vaggBM7gWub J532rvb1aGcwXl9AX6g4IT1r59xMvTB/+476o42yRpyBWHCkuZ2zdOTPWAmYb7oogKxfjH4pRlbGb0 54LugsOVNG9aiPEM8IvRmpuuNldJUUytI+7gDBxNnpkjBQnNXspdQoAqnu32RJhud1yrkDsi8++eQv afTWFDCZr1aQsThpcScXNOjBwvnVDnecEfuBzLKkLQ2GcETyd2J+qM6hlmHgofPhhof/jW8CE5QkiA VXhBfe6dd3JeSx/YN6Whg/stKHHJav9N/ye42U0uVV5UfjuzLxqLQPQ9OPjL5wu8X42x2tnKtJnRHu aGOtDi8V6JLqU3oDGtq8eVjgbhrjWKvgWOYxm0i7ZkE0qDThvkMKyNwtmv4AeyaAV+F9M3Dlh/s0Zq j60wyEwq82qbLk9v29YGRkbwrkqGmOPy5t1bznogdUjxg1lm3nX7E0SmO/jdkZXITYuRsPsXT5IDFu ZrTu8MlrtTor6sSB6MTu+J3YI+sq++lnl0fSNZ2986hrzFyqFeyCoju2Ckv5U6o2j/IMpeTAVG8fGs B1z8nyvOKcTrHfsPaMmWzWuTx9TQ/tZYcVaWLFI2UTgUeZZyXn9pApEK/Yjw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There have been cases where struct_size() (or flex_array_size()) needs
to be calculated for an initializer, which requires it be a constant
expression. This is possible when the "count" argument is a constant
expression, so provide this ability for the helpers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 10 +++++++---
 lib/test_overflow.c      |  7 +++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 59d7228104d0..f1221d11f8e5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler.h>
 #include <linux/limits.h>
+#include <linux/const.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -221,8 +222,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define flex_array_size(p, member, count)				\
-	size_mul(count,							\
-		 sizeof(*(p)->member) + __must_be_array((p)->member))
+	__builtin_choose_expr(__is_constexpr(count),			\
+		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
+		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
 
 /**
  * struct_size() - Calculate size of structure with trailing flexible array.
@@ -237,6 +239,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define struct_size(p, member, count)					\
-	size_add(sizeof(*(p)), flex_array_size(p, member, count))
+	__builtin_choose_expr(__is_constexpr(count),			\
+		sizeof(*(p)) + flex_array_size(p, member, count),	\
+		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
 
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 712fb2351c27..d488ffaf56be 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -602,11 +602,18 @@ struct __test_flex_array {
 
 static int __init test_overflow_size_helpers(void)
 {
+	/* Make sure struct_size() can be used in a constant expression. */
+	u8 ce_array[struct_size((struct __test_flex_array *)0, data, 55)];
 	struct __test_flex_array *obj;
 	int count = 0;
 	int err = 0;
 	int var;
 
+	/* Verify constant expression against runtime version. */
+	var = 55;
+	OPTIMIZER_HIDE_VAR(var);
+	err |= sizeof(ce_array) != struct_size(obj, data, var);
+
 #define check_one_size_helper(expected, func, args...)	({	\
 	bool __failure = false;					\
 	size_t _r;						\
-- 
2.30.2

