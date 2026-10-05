Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0E46AF08
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195929; cv=none; b=j8cKTS09sW76HNmBV2ci0w3Bo0EyVo8ymheZZ18/roLJdrnwxKlkiibZC86dOYwBP6ehOdyGKJGMuMNJMUJ2dMmtgWQUirZW+2LtWmYogKFV7MW9mwdxrA2tqn7bGaPptQBb51jPE6QXielLMk7B2Zghdt8wlV5AyMZZPHgk5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195929; c=relaxed/simple;
	bh=Io3fIF9BNss8Km6M0FV2tc7qcoWBH3l03OVkWOHzz8I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JuwZAWoqNlEsczADFq7XKqpaD3hNxHZSHlORfzFrhAeTgHqkIKAr/8B2HTZR1v25eCNg4H2iXga/gwXyMQ0rXeHpbzey5Uxw3MJOmB/pEFnJmjF09sjFihbzB5UkvFtUgnDFjuLGtB5VxFnP1jTd1X5oX0m/wj/YzxFd4UX7Ojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sq/a5y0f; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sq/a5y0f"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dc7337e2a7so17371605ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791195926; x=1791800726; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cbnu3lsAhceXKSk5PsEBfDmDotO3raLGAh2+zkflZSo=;
        b=sq/a5y0f86taLZTqvpADYouctDr1I8Rl3jBINU2i03vtVJHFuUnCARhl1+k1BLpEYj
         rk7+fdOFMS9knxBArMQuOkJ3G0nde/9yzaw9hSyRXauYqkh2nEX8QEdA7xgldwepul8D
         HUrZLaKC4I/Yb3NjOREBV3xI5Ve74RcdWUjQCpbUg9llf3irnat9fmwGQg5eAL8LZikU
         tQyxOeHAgqxPsOn3djm0fTIsALJjmSvQco/xYZkkOr9okn5wcWVd/mYhFAtz6QHzakYU
         fuWFb0eA+xZ0+ltGPhNs0xxQMF7SQPnDvkU1ZnOrdBG3qPmda+Fw73U865oMSLzbCyA/
         5I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791195926; x=1791800726;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cbnu3lsAhceXKSk5PsEBfDmDotO3raLGAh2+zkflZSo=;
        b=img25emKSEHuXCIFSAZGvzP/8tvEJmgLQllSDnPRyqJP4ke2dQvqnlbWeIPHaUWdG8
         5MvQg286BnBNDfN6AfFPORbsBD5g80lCgP28zWsRr+YZCF4PXOXWqaMz/lCdSr7J5M0u
         Fb0uWOB3Sj8gzPjKGiCefag0cXgO/BZlP0a5OsHr87Xj7I5JFFvYe+TU611bTSXdBc0R
         ar0QGXQKgD8PreUHovlNB+5ds1bJY6WAfynmeMmHlCecsVRV+9vzKBb6LHzQGzhDJULQ
         uljfxlMmtrwwRaISDBTppKWe77G1rJV9/1hc1tjnTt+MbDDjkHntsQzJit3GOwmhpkSI
         JflA==
X-Forwarded-Encrypted: i=1; AKwUvBxHrz5FHC8MU6mJ33/aUK2Yt09/27YLvm3UoIJCLe3lgIvaDY8ci73ine0PCi0pG6RMcehpX6ijSABIstVObhM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmUG0t/CrsifD1vOZZ0Xx/2SPeKL3sNP2W6WVKeFWeNQ4wQ4LD
	pP8OLbQ+zLEak4ZqcUYe5rVm8xRDpa/7xEP/v/bP2Pf4Giaa1rZeXQnQ3U5Zg36thcTvoWQcuwl
	a
X-Received: from plxb1.prod.google.com ([2002:a17:902:bd41:b0:2e5:64b0:3c92])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef09:b0:2db:2376:6e8a
 with SMTP id d9443c01a7336-2e510528670mr70048085ad.9.1791195926259; Mon, 05
 Oct 2026 03:25:26 -0700 (PDT)
Date: Mon,  5 Oct 2026 10:25:18 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005102518.2400984-1-morbo@google.com>
Subject: [PATCH] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: Kees Cook <kees@kernel.org>, ardb@kernel.org
Cc: gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	justinstitt@google.com, broonie@kernel.org, elver@google.com, 
	alan.maguire@oracle.com, namjain@linux.microsoft.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"

Code that runs outside the kernel proper, such as the EFI stub, gets
nothing out of the counted_by annotations: the bounds checks they feed
(FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.

The annotations can also break the build. A __counted_by_ptr() that
names a member declared after the pointer needs Clang's
'-fexperimental-late-parse-attributes', which the top-level Makefile
adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and does
not get that flag, so it fails as soon as such a struct is pulled in
through a common header.

Overriding the macros from a Makefile doesn't work:
'compiler_types.h' is pulled in with '-include', which is processed
after all -D/-U options, so it re-establishes the definitions. Follow
the '__NO_FORTIFY' precedent instead: let a build define
'__NO_COUNTED_BY' or '__NO_COUNTED_BY_PTR' to turn the corresponding
annotation into a no-op.  The two are kept separate but parallel so they
can be folded together once all supported compilers handle
'__counted_by' on pointers.

Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/compiler_types.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..916a946f623c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -371,8 +371,14 @@ struct ftrace_likely_data {
  *
  * __bdos on clang < 19.1.3 can be off by 4:
  * https://github.com/llvm/llvm-project/pull/112636
+ *
+ * Code that runs outside the kernel proper (e.g. the EFI stub) can define
+ * __NO_COUNTED_BY to drop the annotation, since it gains nothing from the
+ * bounds checks. Kept in step with __NO_COUNTED_BY_PTR below so the two can
+ * be folded together once __counted_by covers pointers on all supported
+ * compilers.
  */
-#ifdef CONFIG_CC_HAS_COUNTED_BY
+#if defined(CONFIG_CC_HAS_COUNTED_BY) && !defined(__NO_COUNTED_BY)
 # define __counted_by(member)		__attribute__((__counted_by__(member)))
 #else
 # define __counted_by(member)
@@ -387,8 +393,13 @@ struct ftrace_likely_data {
  *
  *   gcc: https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
  * clang: https://clang.llvm.org/docs/AttributeReference.html#counted-by-counted-by-or-null-sized-by-sized-by-or-null
+ *
+ * Code that runs outside the kernel proper (e.g. the EFI stub) can define
+ * __NO_COUNTED_BY_PTR to drop the annotation, as with __NO_COUNTED_BY. Such
+ * code may also lack the flag Clang needs to parse a reference to a
+ * later-declared member (-fexperimental-late-parse-attributes).
  */
-#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+#if defined(CONFIG_CC_HAS_COUNTED_BY_PTR) && !defined(__NO_COUNTED_BY_PTR)
 #define __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
 #else
 #define __counted_by_ptr(member)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

