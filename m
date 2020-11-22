Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12785C56201
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 16:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF3B20789
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 16:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="X1SYgsJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgKVQZH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Nov 2020 11:25:07 -0500
Received: from devianza.investici.org ([198.167.222.108]:43127 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgKVQZG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Nov 2020 11:25:06 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CfFxX6R1Rz6vN7;
        Sun, 22 Nov 2020 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1606062304;
        bh=KEfxgWGtuzlNUjXPpcrxQhwpe6zIu48XqS9kmcKM0Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1SYgsJFuKCakrQIYXjgToPptU7EXqDE1WofK8NClNDRn0OLtQKCqeZ9RUDQZQXgb
         xDoN2KgeM334rA++mjcZvQUlKxBPx+a6Kl6wQIiqZtOINF9G5tTRusmO02iHx8yYN+
         unXu/baRs61FaG+h0KzBh2VmoT014/oEtAhYBmNA=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CfFxX2hv4z6vMg;
        Sun, 22 Nov 2020 16:25:04 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     akpm@linux-foundation.org
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org, Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v7 1/5] string.h: detect intra-object overflow in fortified string functions
Date:   Sun, 22 Nov 2020 17:24:47 +0100
Message-Id: <20201122162451.27551-2-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201122162451.27551-1-laniel_francis@privacyrequired.com>
References: <20201122162451.27551-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Daniel Axtens <dja@axtens.net>

When the fortify feature was first introduced in commit 6974f0c4555e
("include/linux/string.h: add the option of fortified string.h functions"),
Daniel Micay observed:

  * It should be possible to optionally use __builtin_object_size(x, 1) for
    some functions (C strings) to detect intra-object overflows (like
    glibc's _FORTIFY_SOURCE=2), but for now this takes the conservative
    approach to avoid likely compatibility issues.

This is a case that often cannot be caught by KASAN. Consider:

struct foo {
    char a[10];
    char b[10];
}

void test() {
    char *msg;
    struct foo foo;

    msg = kmalloc(16, GFP_KERNEL);
    strcpy(msg, "Hello world!!");
    // this copy overwrites foo.b
    strcpy(foo.a, msg);
}

The questionable copy overflows foo.a and writes to foo.b as well. It
cannot be detected by KASAN. Currently it is also not detected by fortify,
because strcpy considers __builtin_object_size(x, 0), which considers the
size of the surrounding object (here, struct foo). However, if we switch
the string functions over to use __builtin_object_size(x, 1), the compiler
will measure the size of the closest surrounding subobject (here, foo.a),
rather than the size of the surrounding object as a whole. See
https://gcc.gnu.org/onlinedocs/gcc/Object-Size-Checking.html for more info.

Only do this for string functions: we cannot use it on things like
memcpy, memmove, memcmp and memchr_inv due to code like this which
purposefully operates on multiple structure members:
(arch/x86/kernel/traps.c)

	/*
	 * regs->sp points to the failing IRET frame on the
	 * ESPFIX64 stack.  Copy it to the entry stack.  This fills
	 * in gpregs->ss through gpregs->ip.
	 *
	 */
	memmove(&gpregs->ip, (void *)regs->sp, 5*8);

This change passes an allyesconfig on powerpc and x86, and an x86 kernel
built with it survives running with syz-stress from syzkaller, so it seems
safe so far.

Cc: Daniel Micay <danielmicay@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 include/linux/string.h | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b1f3894a0a3e..46e91d684c47 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -292,7 +292,7 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 
 __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __builtin_object_size(p, 1);
 	if (__builtin_constant_p(size) && p_size < size)
 		__write_overflow();
 	if (p_size < size)
@@ -302,7 +302,7 @@ __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
 
 __FORTIFY_INLINE char *strcat(char *p, const char *q)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __builtin_object_size(p, 1);
 	if (p_size == (size_t)-1)
 		return __underlying_strcat(p, q);
 	if (strlcat(p, q, p_size) >= p_size)
@@ -313,7 +313,7 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
 __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 {
 	__kernel_size_t ret;
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __builtin_object_size(p, 1);
 
 	/* Work around gcc excess stack consumption issue */
 	if (p_size == (size_t)-1 ||
@@ -328,7 +328,7 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
 __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __builtin_object_size(p, 1);
 	__kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
 		fortify_panic(__func__);
@@ -340,8 +340,8 @@ extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
 __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 {
 	size_t ret;
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __real_strlcpy(p, q, size);
 	ret = strlen(q);
@@ -361,8 +361,8 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
 __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
 {
 	size_t p_len, copy_len;
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __underlying_strncat(p, q, count);
 	p_len = strlen(p);
@@ -475,11 +475,16 @@ __FORTIFY_INLINE void *kmemdup(const void *p, size_t size, gfp_t gfp)
 /* defined after fortified strlen and memcpy to reuse them */
 __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 {
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
+	size_t p_size = __builtin_object_size(p, 1);
+	size_t q_size = __builtin_object_size(q, 1);
+	size_t size;
 	if (p_size == (size_t)-1 && q_size == (size_t)-1)
 		return __underlying_strcpy(p, q);
-	memcpy(p, q, strlen(q) + 1);
+	size = strlen(q) + 1;
+	/* test here to use the more stringent object size */
+	if (p_size < size)
+		fortify_panic(__func__);
+	memcpy(p, q, size);
 	return p;
 }
 
-- 
2.20.1

