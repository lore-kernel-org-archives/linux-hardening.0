Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8524570F9
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294323; cv=none; b=hyvyeuHJxqeU0CzrmcnokyaEPKXoJ9vg6g7EpjlTPEdZluS1h6XICGXQkbKjTBi+E+M6Wbv6yjrRR2G0w0Q7fAvBP6o9c9S9JHLZxGSISxap+jsGS3OeYHdfmcD//66xBfXogRKGG1QUo1NAlI1ftRchm2HoeijzKOtgtteJ3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294323; c=relaxed/simple;
	bh=IZ1KgkZ9HhibMzlDJkfocT5UZkP1G/dkdYUxLrk2pEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lRq/o/PMxgL1j626yibLK/w4BTPgk7a+uSOiZHAn6ZCQujOOf25ls+B6ofez4XoS8vKmmjErDNfizGFzxIrqag2wsVWs0/pT8EwutaV3OdEnXq8lFWOWLFrvqGLfWh/R26/MbI8eCERgWyYPHPaHFk4wOlcBV5PEeP/5RzljAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/iaQMei; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/iaQMei"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1a439db36so1971944a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 06 Oct 2026 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791294322; x=1791899122; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0cBA/5+tptwkOGCjlxa+cIEqx0sO9oAIjy8KYCtfpQ=;
        b=q/iaQMeiz5TB64+RTOw7p7r/WptuRLN6Tr4NOs3kOPg1P5LfIeqp/q4qz2QaNs60KS
         ZXygNkbPNXkZBvm3cy4ir8Na9N6LJOpRIgsVsROh1O88u0Nk8KDnPwbwRyQdh9H+v4hz
         F6pMSBsRfCd3e/x8NP++3+QV8gNTm8HQx43eQwSWGnuyw5rl44x5SR51owQqixAJ/ta0
         qMMEwRk1KAcNHybzLiCAzNpm1jUQ3Pz3Ogse4zhG/piQSfDny7TfAm6lCjxsGtrlx1vi
         W058ooDmoGlYQNHJ9hEAOyo84BBbY6/wrEGBdj0x2j7QMpK4Vz+zy/OpfxbikQqVwXGy
         8SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791294322; x=1791899122;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C0cBA/5+tptwkOGCjlxa+cIEqx0sO9oAIjy8KYCtfpQ=;
        b=XMH4ErqVCg5WW4JlXgYoaKF6m4S8zWezfiY1Hgssdc3cCi5+xaR6ephmHpE0asB3Zr
         LlVf8HbNv3vsooR4ivUS03nTgDUAV2dh3fGe8dUchrNUy0LZYACoRJf2B72ev29HhDgU
         dZZ0yVDx3RAVbtxasLjw7WRW58GRFG3gpFfliwzZD/h2lV1sr9u5X1t+fccstwGguH8Y
         NeOPeJTsWgEGD+w19jxTbReM4BMXb1QV3ZGaFQ9Q70/uqWzlkZ/fV4xSPvVY0U7TIx2s
         Ix8IgtLh2abOg8oa5vRehF6X6byDgrx4j8YPxT04g4F17Oa4WpR3KiGbPA/RSF2DnrUV
         CgYA==
X-Forwarded-Encrypted: i=1; AKwUvBy8/HiUJ3C+myvEDk7miFYNivoQl88cAepZ625Rugkp7Bvtcxyy9c+j7APBL02o/8QuQHUYCgJg/M1HPHA/ynA=@vger.kernel.org
X-Gm-Message-State: AFuF++nAwUQB3+UBFKg8hqkWGmDVKxKDjNwmqRy3oWBhF4r1mCWFEZiW
	z08+eWvJZhbSkifAVNp8ROx+cu2lw0UlKxJ678skf2vTvwDP0WHRrxrudoQzFOoEE3PjWiEJ2Dt
	1
X-Received: from pgby20-n2.prod.google.com ([2002:a05:6a02:6514:20b0:cc7:8224:dcaa])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:138c:b0:3de:60c1:fee7
 with SMTP id adf61e73a8af0-3e124890bb3mr1103292637.44.1791294321320; Tue, 06
 Oct 2026 06:45:21 -0700 (PDT)
Date: Tue,  6 Oct 2026 13:45:19 +0000
In-Reply-To: <20261005102518.2400984-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006134519.3033941-1-morbo@google.com>
Subject: [PATCH v5] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
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
'__NO_COUNTED_BY' to turn the corresponding annotation into a no-op.

Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2: Only specify __NO_COUNTED_BY_PTR. Leave __NO_COUNTED_BY until we need it.
v3: Add the version to the Subject line.
v4: Use __NO_COUNTED_BY to reduce churn later on.
v5: Probably good to add the logic in the correct place.
---
 include/linux/compiler_types.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..932e81e7630d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -371,8 +371,13 @@ struct ftrace_likely_data {
  *
  * __bdos on clang < 19.1.3 can be off by 4:
  * https://github.com/llvm/llvm-project/pull/112636
+ *
+ * Code that runs outside the kernel proper (e.g. the EFI stub) can define
+ * __NO_COUNTED_BY to drop the annotation, since it gains nothing from the
+ * bounds checks. __NO_COUNTED_BY should be used sparingly, because there are
+ * better options for opting out of bounds checking.
  */
-#ifdef CONFIG_CC_HAS_COUNTED_BY
+#if defined(CONFIG_CC_HAS_COUNTED_BY) && !defined(__NO_COUNTED_BY)
 # define __counted_by(member)		__attribute__((__counted_by__(member)))
 #else
 # define __counted_by(member)
@@ -388,7 +393,7 @@ struct ftrace_likely_data {
  *   gcc: https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
  * clang: https://clang.llvm.org/docs/AttributeReference.html#counted-by-counted-by-or-null-sized-by-sized-by-or-null
  */
-#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+#if defined(CONFIG_CC_HAS_COUNTED_BY_PTR) && !defined(__NO_COUNTED_BY)
 #define __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
 #else
 #define __counted_by_ptr(member)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

