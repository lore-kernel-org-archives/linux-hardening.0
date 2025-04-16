Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAFB21B9F8
	for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826726; cv=none; b=oqALSbvYeNxr9dGIzzgLXt+jRCwANzGgZOBlpfNjifAVzZ8ogTZpavYPU9iKEZVpP2rp8bpw1h+mdGWr3ZXyAuzvH5/9Or1A39F4He2VxvwmqKuFD7YdC1OO6p2B35RoKBgliJ6U/w9XVJ1xNLy2ge7gnpnZnfDfxDZhAeKnaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826726; c=relaxed/simple;
	bh=D/VurCqLb27guso/GqkYusIvZ2SnsZDyUpD9nIbj4iE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GT/hXhMKDZfB/AhzorcuDbVwmrHOB62WvB1lctyUar3Lh4oMNLrc3ILMB15hrZZ7dPnbjOG4o3ygis2u05JbKb+h+5NDgTuCTrn+y3Mng56Q03GN99eZd61H9mkbUgYHrNg4qis2DhGwkYrebndrlbimDj+78AS+C3Q2dvJHg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBpQibhv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBpQibhv"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so43872405e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744826721; x=1745431521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWRjEDjHgnGUTAO1fUxX0nlQ73sblTBfWxiyoAckCmI=;
        b=eBpQibhva8cpm7O70uQni1x6t3Hhh+lUhf574VZhrObwHVPbLaawV8cr1rxZI6JbBE
         TwOgf2skQCgVJhXtESY4LF7O0XzJzHIXBz+zdH9ftXcUr1AwnbzXee6WVa+TT99AV6mc
         eg7/aTvDMFWzVD0UanI/nYn1m1zZd1EydYs8mOwcBKm/1O8QtO0ZD/tFPVZ476s8c2rA
         5cgvA3iaUWfTvhkLdczmHoAkcC2vMXpsJxgB+4AvonfrOs8eFsx8P8o1gqf5aYVeLteB
         8TEDlA4NFdrhuks6bgoYiyrItnKllSQkizAgJW9JaWr7daqVaeQw37d7KoZ93J1hZr+z
         Wy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826721; x=1745431521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWRjEDjHgnGUTAO1fUxX0nlQ73sblTBfWxiyoAckCmI=;
        b=UHlaF+3XBoEF8SiuZkN3o7top+YHdNlrMx/aJsCk1NI1MNDg4TaIpRV4GdiymNQvAp
         ljO+k97CGaGKArJgRxHBZl37PBG7UP3bWURpiv6j2fgeWZNaGbkOnnL+zThZtXBca62E
         bFUXHqgT+oajnHj02ygJphKBHEeewsZC5phVg94ho6a/eQmtpkF8DUyb55a3JuZkLxzN
         Mry+DrFHqX7F3rgNlDDTXirMV7x6OiVUc03OKms0212MGl7zYM57xUbh2NA+7GsCSuAw
         zkGbW2Nwe+nT+31aXVG6h3A/VWntJeI2Pe0jkFuND30PDNRqEI8SDkRMcLM6Vym4LNdj
         pPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUppKQ1vsbcXVdbr4WKxKzl0r88ejVWWZoEEoU0240I2e6kLXe9d7VewQQcjQEEnp4fuAMk1l5K1e0Pq7QdUE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xRPQXQfMaawiUnOjRk52Spv9Hot/13+C2Xqc5MhD7OgkGM4+
	n3XB7pOdLuw53l8uHXgf+cQHAzISv0gzKLdh3u02BiJAJoUo1do52q1YxxUH/IrNKIiNz7GaB89
	zpPKs+QTR9Q==
X-Google-Smtp-Source: AGHT+IGKfernDkJiPcq9aGD5Ngb6rDQ85prFSXMtxNjAKHAqgi+juJeLLNi5fr5EDrdbF7a6RZez8kPLKAZvew==
X-Received: from wmbev17.prod.google.com ([2002:a05:600c:8011:b0:43d:4055:98e3])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3487:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-4405d62a49cmr36178345e9.16.1744826721678;
 Wed, 16 Apr 2025 11:05:21 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:04:32 +0000
In-Reply-To: <20250416180440.231949-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416180440.231949-1-smostafa@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416180440.231949-3-smostafa@google.com>
Subject: [PATCH 2/4] ubsan: Remove regs from report_ubsan_failure()
From: Mostafa Saleh <smostafa@google.com>
To: kvmarm@lists.linux.dev, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	broonie@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kees@kernel.org, elver@google.com, andreyknvl@gmail.com, 
	ryabinin.a.a@gmail.com, akpm@linux-foundation.org, yuzenghui@huawei.com, 
	suzuki.poulose@arm.com, joey.gouly@arm.com, masahiroy@kernel.org, 
	nathan@kernel.org, nicolas.schier@linux.dev, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

report_ubsan_failure() doesn't use argument regs, and soon it will
be called from the hypervisor context were regs are not available.
So, remove the unused argument.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kernel/traps.c | 2 +-
 arch/x86/kernel/traps.c   | 2 +-
 include/linux/ubsan.h     | 4 ++--
 lib/ubsan.c               | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 224f927ac8af..9bfa5c944379 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1118,7 +1118,7 @@ static struct break_hook kasan_break_hook = {
 #ifdef CONFIG_UBSAN_TRAP
 static int ubsan_handler(struct pt_regs *regs, unsigned long esr)
 {
-	die(report_ubsan_failure(regs, esr & UBSAN_BRK_MASK), regs, esr);
+	die(report_ubsan_failure(esr & UBSAN_BRK_MASK), regs, esr);
 	return DBG_HOOK_HANDLED;
 }
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f88b8a78e50..4b5a7a1a8dde 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -351,7 +351,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	case BUG_UD1_UBSAN:
 		if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
 			pr_crit("%s at %pS\n",
-				report_ubsan_failure(regs, ud_imm),
+				report_ubsan_failure(ud_imm),
 				(void *)regs->ip);
 		}
 		break;
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
index d8219cbe09ff..c843816f5f68 100644
--- a/include/linux/ubsan.h
+++ b/include/linux/ubsan.h
@@ -3,9 +3,9 @@
 #define _LINUX_UBSAN_H
 
 #ifdef CONFIG_UBSAN_TRAP
-const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
+const char *report_ubsan_failure(u32 check_type);
 #else
-static inline const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+static inline const char *report_ubsan_failure(u32 check_type)
 {
 	return NULL;
 }
diff --git a/lib/ubsan.c b/lib/ubsan.c
index cdc1d31c3821..17993727fc96 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -25,7 +25,7 @@
  * The mappings of struct SanitizerKind (the -fsanitize=xxx args) to
  * enum SanitizerHandler (the traps) in Clang is in clang/lib/CodeGen/.
  */
-const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+const char *report_ubsan_failure(u32 check_type)
 {
 	switch (check_type) {
 #ifdef CONFIG_UBSAN_BOUNDS
-- 
2.49.0.604.gff1f9ca942-goog

