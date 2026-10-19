Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1718347BA9
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375148; cv=none; b=KQv7yIWpR64dLNU3qAhGCIqjYUZi6ENh+G2yMKw2v0LQp2bXhOnzkUh06hez33jpjSDqgBumTjWOzjA3JFmRDKkhexBzyufdxgUPVeMoiTvkLx9h3R6gsJwp7eanHHVZe+WdNk0gJTy7i+9ina31RVSJYd4etOJ4N2JMO0UZe3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375148; c=relaxed/simple;
	bh=vQ7Rq9dIEUKGE4TLNxaJn+WTiiQI1Xpb5z7OLgBgEiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=texv3OoKw0rM8p09zD6zqOumwLhYPXgcmnmDoRocE77VRKCh7jCuppqvxhWTHjJMiuUfB7rfxKuUWezCWt/EfbBfvDx2cEOWbHPtJx1QLQmWpSZsMwmm6ps+JojKHuut7r8ZsxJeM54+q0MdERZ8O5xYMOD5yGWChKPq1IIaETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMzTuZbN; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMzTuZbN"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso709582eec.0
        for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 18:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375146; x=1792979946; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CGuNTdEG2B3jP21wBHfoCXg9dp+LdJHVpN39Arwz/Dk=;
        b=pMzTuZbNktb2BzY1Zh5+rwVjifYf+B+oAxAsydxRW+evwIUFjl26rqnSPrXFHlNZLa
         VSP915UH9nooxViUPjsgcWwsdozrujyobhq4GdI1G3vsWZUSaVauKKcj7Yrv6nbBO8YZ
         bqjR7r9ynfEdxj25Guobo3zkMIlxxh35PR/QSsZ7dBRz5WUZg4PhsBQswvOQY/XcGIdn
         vfvft6lKzQxZT1tLV4o9J1NWgUtBCgE66ByzNePLCvtgVgqMwa20aUKllq4ZTKDxBNSn
         Q25xg7u8818eQrP+iZKYIqCk9Xr+nMqGUA9gTdmNxvbVYo9Z42KU9Q5RXD6gRk1MLEtY
         zYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375146; x=1792979946;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CGuNTdEG2B3jP21wBHfoCXg9dp+LdJHVpN39Arwz/Dk=;
        b=i6mZ21XdOM5QFY7PsSXRJmAtxqvJzYR+KBEMOXwcljE7DxSR2Yq7P5OmCRZuYiMdYs
         rObJluOgLB46tUvSL2EywBW3txPHo0Cx0beGTcvSSaQ4uB/EaOhxlIg/sjajrg1bKdA9
         InFUZ2qDDJ33SLxuwJAXS3hqmiSCIyl47GExiyTbiYv0IMMV/v/FGKN+a4qeu7ffeIBZ
         p58EPLNJlyDQxEFHgRllId43+3Kj/4261ZqEJYWAFyFrqG6Tf8TzBJ1JBYi5GauS9fAk
         5jD+iv3bGpUAPfjedCTxjQVSZWDf8nfUy800EB0Glz71REx7kIHL/kUQs1F2Kjq6/ZK2
         YU+w==
X-Forwarded-Encrypted: i=1; AKwUvBzvz3OIU5OYMrpOmFA+IuAsDgb6hMXv1Xa5aU0vKQvDHoGsibfomkd0rcKCW7SrwEF0wGwLSuTuihOicnzT7jU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQ6svBrHmFBhb4lEYZbMY6JWfNR0Mk5UbIjSuyIbH8mofeOqxf
	OYcu/C6dVnIuUFj1/fb0NPAonRgBKS/v5WdgVsq/lXOBGWJc3kHvyfjJ
X-Gm-Gg: AYBFou3Mca2EsrZKvnspvGqXs0jclFT/T5Eq8iCI2GqQncJLBQFlvvZDfSFvDzUrIBb
	BDmafq2twR+m+bnKTyCVci+LQwMsLOcQ7jCEbp/mFR8ydpBPpXPlf2PUZi1gA32b6z8YVKSpMTr
	YIpLjZpZDafaL1eFwJ4OhtdS7XYV39Q8otsTVEXszP40gw4zmx37si8NHxua8bBKCs6oKjfSVgn
	FdkZHTJCA9kwtxZ24n8x4qRZnWCpNDY8Zr6+rZNUt1COmszUPlC/WsXh0ijel521ZyZTq65MzCw
	fxmm0+n2Ue0LfqWKADt/KJ9pBF+U2d17IdydbAI5OlNtYPaJuKDrgEr9Esom9NKWSbqKgF5cX8q
	BNF/YF42pB8b8cbtxGpy2/z0OOvDb1CxAAKKeiPJjHyHYsiu2hNUHTy0d+EtSueILNZkXiBpXFh
	NGbASIuKOdjg8+AOvWWxGqHQPwMXegIKEe6kD3WupL5dYVCL5urqzzRKR3dJuSyvTn7g==
X-Received: by 2002:a05:701a:c951:b0:156:3684:96db with SMTP id a92af1059eb24-18515e402d1mr10796118c88.45.1792375145676;
        Sun, 18 Oct 2026 18:59:05 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm30505313c88.6.2026.10.18.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:59:05 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 09:59:01 +0800
Subject: [PATCH v2] string: copy byte by byte in sized_strscpy() under
 KASAN
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-bug-string-strscpy-kasan-first-byte-v2-1-c93073250e6b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGR51WoC/42NQQ6CMBBFr0K6dgxtLTauvIdhUcoAE7WQTiUSw
 t2tJO5d/by/eG8VjJGQxaVYRcSZmMaQQR0K4QcXegRqMwtVqkqWsoLm1QOnSGEf9tMCd8cuQEe
 REzRLQtDaGGs8qlK3IpumiB2998qtzjwQpzEue3SW3/fnt3/5ZwkS9Nk45U9Va2137Z+OHkc/P
 kW9bdsH32lrENYAAAA=
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Peter Collingbourne <peter@pcc.me.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 kasan-dev@googlegroups.com, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

sized_strscpy() copies a word at a time. The loads go through
read_word_at_a_time(), which checks the first byte of each word with
KASAN, or through load_unaligned_zeropad() on architectures with
CONFIG_DCACHE_WORD_ACCESS. Under KMSAN it copies byte by byte instead.

load_unaligned_zeropad() is inline assembly that the compiler does not
instrument. Since sized_strscpy() switched to it, generic and software
tag-based KASAN no longer report strscpy() reading from a freed or
out-of-bounds source on x86_64, arm64 and the other architectures that
select CONFIG_DCACHE_WORD_ACCESS. On x86_64 the kasan_strings KUnit
case, which expects a report when the first source byte is out of
bounds, fails as a result:

  KASAN and string KUnit suites      failures
  on x86_64, generic KASAN        before    after
  CONFIG_FORTIFY_SOURCE=n              1        0
  CONFIG_FORTIFY_SOURCE=y              1        0

Copy byte by byte under generic and software tag-based KASAN too, as
under KMSAN, so that every byte strscpy() reads is checked. Hardware
tag-based KASAN keeps the word loop that load_unaligned_zeropad() was
brought in for.

Fixes: d94c12bd97d5 ("string: Add load_unaligned_zeropad() code path to sized_strscpy()")
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Copy byte by byte under generic and software tag-based KASAN instead
  of checking the first byte of each word (Andrew Morton)
- Rebase onto v7.3

v1: https://lore.kernel.org/r/20261018-bug-string-strscpy-kasan-first-byte-v1-1-375a2c46d88f@gmail.com

The other callers of load_unaligned_zeropad() are covered by a separate
series (Peter Collingbourne):
https://lore.kernel.org/r/20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com
---
 lib/string.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index a3778d5aab4af..d14e42ae3903b 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -124,8 +124,14 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	 * uninitialized bytes after the trailing zero and use them in
 	 * comparisons. Disable this optimization under KMSAN to prevent
 	 * false positive reports.
+	 *
+	 * KASAN does not see load_unaligned_zeropad() at all, and
+	 * read_word_at_a_time() only checks the first byte of each word.
+	 * Disable it under software KASAN as well, so that every byte read
+	 * is checked.
 	 */
-	if (IS_ENABLED(CONFIG_KMSAN))
+	if (IS_ENABLED(CONFIG_KMSAN) || IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
 		max = 0;
 
 	while (max >= sizeof(unsigned long)) {

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261016-bug-string-strscpy-kasan-first-byte-335585ce203d

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

