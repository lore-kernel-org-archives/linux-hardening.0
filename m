Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63162C4338F
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A14D61220
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhHVH5h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhHVH5g (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6CDC061575
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y11so12590928pfl.13
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KnlZyUJ4JJDBTHC/dBVt831TglW4q/rmR4rnphw0w8=;
        b=Y+mT4XZsRYnUZT5OLp95OJeCQ/3J4h7jqDHipDXORhXBq3Vr1nwkhUz35awITPj4+r
         aLT3rWcdQiie6oWVLBnFXsov9u9oPK6OPYBdlK+YEIF9BxK1S0k6QoLn0xR6yglMoU8W
         pSzXfMTgkRiBXRPvkHaB95zjLQXMO9r+MKhqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KnlZyUJ4JJDBTHC/dBVt831TglW4q/rmR4rnphw0w8=;
        b=nV5oZMLAnin1UVnPw+WnsR5NgI3k66H6iNy/oDW/ivz9jUbtT7sJjzvZIg3fzcTPXS
         5yu8US3/tQmDlVcd+TkeZtdBVWPXxVvA6aCxPwxZZhyNr+nJfP/J2Eb5v/f0llY/aSDp
         rYi2ad5sbfSlOMxKc/iqq4V+hI+0MN/HJwkf84yIK1giQpL87rlH+VhcsVWSAfhsoUjO
         3gpDWJexqK9TttK1vhh9zzhOtHrkQx1Ej1+M8lVzxUtdgwWVfQDzyf+If2cWhVfAM+/u
         ysN0m7BUl/6xxx7RKasiqjzZj9uq0/jmw7n/0wk3jCKDQFWvB7UOIqbwZAw7lVL0ishK
         6ovA==
X-Gm-Message-State: AOAM530ELB4gC5BFDUQN/MZADqI0hYwww3lmEX1FG9haqCU4aVEiJFVh
        duhGB5gOtngSVbh6sqYw2vxZ9w==
X-Google-Smtp-Source: ABdhPJyQZnraia8jT9jDkEu1F7LS5sG4ORyySxnjNXW9NLxLiGeok6CdnMMM04AXulnUXcwd06VOwQ==
X-Received: by 2002:a05:6a00:1a49:b029:3e0:3b2c:c9c7 with SMTP id h9-20020a056a001a49b02903e03b2cc9c7mr28243759pfv.8.1629619015627;
        Sun, 22 Aug 2021 00:56:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 31sm13965099pgy.26.2021.08.22.00.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 24/25] string.h: Introduce memset_startat() for wiping trailing members and padding
Date:   Sun, 22 Aug 2021 00:51:21 -0700
Message-Id: <20210822075122.864511-25-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; h=from:subject; bh=MIZu0nCxR6KieORNJWhN3qltUR3m4MTuETFcTLC3tSY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH5YaWY/R52rHxtKPpztby55TKg0ehRWRvT+K+I ja0DQ6iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+QAKCRCJcvTf3G3AJu0ND/ 9b6A+AeTKAspoJhIm34uafRRj1V+94SeH/MvXCB9q0DbskDNw57WyI9kT/GkIbWCUJleyzbZRN++i+ +bDJe2xRAPhiofu+4S7lRyRqxwYRUoSAE+DnA6PYJWz0y85VjybzJX28I4vWW1njWrfyTq7akK68qP Cf3KeFQmoeeB/R/qW50eVB+wjN4+KHR1jcr6RcZ9C0ZpXbfCik5gBH9zGR5TE+zpzlTtZ7l+B1/C33 rEXbHWRtf+arRLtfkqLV3OtOoctiNY1nZDKxiO8jV/SCsyiZg9gmKVm1MfGVE9LrUc2OeYF6OxcKRw gtG8h4QI/fFAc1KLnhXrQP+tNflZzqrYQPXAGMfzKu8PvY9/mFeUQbOfmp8qWweBxNPr67znM/TBg2 D3zKxgJW19D4Wm46giezi6of9EoJgGIpaLsnMkoyvUttBe1ycJ9znwzLWB4HB1SaZAO0YBnGVUqBLn uFZ5/qk849G8+x8vZWNNYyOMtq//WryZQBQ3VyL1p4DRezo7cLmLxw+Wuzwl/jk0LFnutkL5JsFYMP hmg+T6IddvJ/aSVlhCojoBGb4IBSWtgMxPbzLivLwM9B3vZC3b7oXPwaoXK7ck72rWEd9EOItygnQz X1hWv17JmRFkE9hXMK1yP7eco8qX4cs6GGCcB0Lnp4EE1zASt6qPboWk3DzA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

A common idiom in kernel code is to wipe the contents of a structure
starting from a given member. These open-coded cases are usually difficult
to read and very sensitive to struct layout changes. Like memset_after(),
introduce a new helper, memset_startat() that takes the target struct
instance, the byte to write, and the member name where zeroing should
start.

Note that this doesn't zero padding preceding the target member. For
those cases, memset_after() should be used on the preceding member.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 18 ++++++++++++++++++
 lib/test_memcpy.c      | 11 +++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index d593de2635ba..38acc436dba2 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -288,6 +288,24 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
 	       sizeof(*(obj)) - offsetofend(typeof(*(obj)), member));	\
 })
 
+/**
+ * memset_startat - Set a value starting at a member to the end of a struct
+ *
+ * @obj: Address of target struct instance
+ * @v: Byte value to repeatedly write
+ * @member: struct member to start writing at
+ *
+ * Note that if there is padding between the prior member and the target
+ * member, memset_after() should be used to clear the prior padding.
+ */
+#define memset_startat(obj, v, member)					\
+({									\
+	u8 *__ptr = (u8 *)(obj);					\
+	typeof(v) __val = (v);						\
+	memset(__ptr + offsetof(typeof(*(obj)), member), __val,		\
+	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
+})
+
 /**
  * str_has_prefix - Test if a string has a given prefix
  * @str: The string to test
diff --git a/lib/test_memcpy.c b/lib/test_memcpy.c
index 3b485de8c885..fb5deaf04418 100644
--- a/lib/test_memcpy.c
+++ b/lib/test_memcpy.c
@@ -222,6 +222,13 @@ static void memset_test(struct kunit *test)
 			  0x72, 0x72, 0x72, 0x72, 0x72, 0x72, 0x72, 0x72,
 			},
 	};
+	struct some_bytes startat = {
+		.data = { 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x79, 0x79, 0x79, 0x79, 0x79, 0x79, 0x79, 0x79,
+			  0x79, 0x79, 0x79, 0x79, 0x79, 0x79, 0x79, 0x79,
+			  0x79, 0x79, 0x79, 0x79, 0x79, 0x79, 0x79, 0x79,
+			},
+	};
 	struct some_bytes dest = { };
 	int count, value;
 	u8 *ptr;
@@ -258,6 +265,10 @@ static void memset_test(struct kunit *test)
 	memset_after(&dest, 0x72, three);
 	compare("memset_after()", dest, after);
 
+	/* Verify memset_startat() */
+	dest = control;
+	memset_startat(&dest, 0x79, four);
+	compare("memset_startat()", dest, startat);
 #undef TEST_OP
 }
 
-- 
2.30.2

