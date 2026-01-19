Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723742FE593
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841786; cv=none; b=q3RQv5IRa7UWhVh2p3utQVqIBHwi7+k2SDzLac/O32tcP4P7PDEx/V7xRJbYSsniiQRuKb2duzeq1AebxPbiGQ4O5jFoJNYgXHix0qvuJK3NZ5/e2KD6fZh3yQmpzxTybvzI6I2Ec2ZyF2yoElgID1NXaoP3YGQf7j+H0Dcr35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841786; c=relaxed/simple;
	bh=JeQwVjuVQ0xF1q76mPBesPoJDEbrkYN4EZcEzfje69U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dz8gfZdXIIPeSxkngvJy390fwB01wgcFzzmg3q2x4Z6lvW3EP/OivO6ytxDN+4xr0A+cVGv9Q6OJieA1W7Dh618AVhDBFmixHnnVTeaDgCIFDzdG9XQzDq7fj0iVPTaKmLSow38szQwU9EpsPp2yTWTDGlKTg1pxJd9Ac0y/oS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2oRuGbl; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2oRuGbl"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4801ad6e51cso37436665e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768841783; x=1769446583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4EUsFWvfNG6jYO8IfY/OM++lXiUoY+wEqYUoCpTy24=;
        b=a2oRuGblFgherNdSsiT9DGVW61Csb7mS2eltU5lQ2r8PagPXlWLLgBVyUT4Qj5GY9X
         p0dApmFJKG3i3Zh/xBOT8H/RXQhyKRTDicBjRxxo6qNG4Ahv/pFFVEVnKI4V4oykNiOB
         Ck+3VwQdjUeODBOIQdJ/SmNWrvw0QhKqTKAmSyZiiN+7CwNspI5S3Ex8demKNT0iK32B
         GSXqbtp3o8ep7RfP2YRS/01AJgbEMb3ut6d+14Bv9aTWag5wXG+BoZJf/3X5xmrCkin7
         lxb9DQRIgJWU0KFwNRPmsdiiRR8rOHDcKHl8hof7I+LeNWc39Mb+RClXvpqBSj2JAvyt
         TCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841783; x=1769446583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4EUsFWvfNG6jYO8IfY/OM++lXiUoY+wEqYUoCpTy24=;
        b=ai2Ru//6R65/98LKn6h14TGkDDMMJ6RgwK5+17YpqcdiVf8CmQyCAVg1KWRbJjj6ZU
         p7lHBYmttrZNU/ZFR+pPOAeDL5wmWSPB/QlXHNG9iNE6pg31jyBsx4ga7t//+YFIvQ8P
         R7xxtDglnMc5GzlMRv8f/ZWelV0eK7aSNiFhgrmJcuSwb4h7l5rIySafHxVqpPHfmzOv
         o+TzziCS+rueuDHu5cwTyETETNtyEUqwmf/ptqVXI1BuAbHj2g5q+SNouxpwLUuqTclq
         JAp0sCKltyUTZ8M/IN3FM0mkbSDYfZZ4PKIdBFJkE1DZdsYrDQ1wjNyYcvaGoAxu+Hku
         u7WA==
X-Forwarded-Encrypted: i=1; AJvYcCWkBcvrM7FCSZHTZiDWcsqy0rHPioYVhGEJj9dgfcR9XAasoNtgyThII/6GplopCVb1Wcg7G2qAiy5Rv5thj74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6y+nSsb2L/g2fA73kCKGl0xSDLNQyvRhrdyEGeZAv5v5Qm0dI
	sDZNIu855SitoCC4eiMbnWXEOcjHpBVPVDrkFU2Dd3v917jd0FyPT24z4IgDS44/2m6QJ21BlA=
	=
X-Received: from wmbil25.prod.google.com ([2002:a05:600c:a599:b0:46e:1e57:dbd6])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c4a4:b0:477:7bca:8b2b
 with SMTP id 5b1f17b1804b1-4801e2fef34mr171303545e9.15.1768841782852; Mon, 19
 Jan 2026 08:56:22 -0800 (PST)
Date: Mon, 19 Jan 2026 17:47:52 +0100
In-Reply-To: <20260119164747.1402434-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260119164747.1402434-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890; i=ardb@kernel.org;
 h=from:subject; bh=HeK0fa8eNZm3Eo/TOMdG37o/i93rJtICIBf0MiUiyLQ=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGluYDagcqUCy3hpyhYgUZ3by359BPtdnqvGGIUf1J2q5Ky8V
 4h1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmluYDYACgkQMG4JVi59LVwiAAEAgPny
 UNC2NLOejTSjxWEADXgkQHtHk7sF7wOU/hyIz6sA/3fsOe3Kx6zKyfjmM753VqL6Q0RxK1tUOYJ IOcLB1eEB
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119164747.1402434-10-ardb+git@google.com>
Subject: [PATCH 4/4] arm64: Unmap kernel data/bss entirely from the linear map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The linear aliases of the kernel text and rodata are mapped read-only as
well. Given that the contents of these regions are mostly identical to
the version in the loadable image, mapping them read-only is a
reasonable hardening measure.

Data and bss, however, are now also mapped read-only but the contents of
these regions are more likely to contain data that we'd rather not leak.
So let's unmap these entirely in the linear map when the kernel is
running normally.

Only when going into hibernation or waking up from it do these regions
need to be mapped, so take care of this using a PM notifier.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 35 ++++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d978b07ab7b8..7b3ce9cafe64 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/suspend.h>
 #include <linux/kfence.h>
 #include <linux/pkeys.h>
 #include <linux/mm_inline.h>
@@ -1024,13 +1025,13 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
 				 prot, early_pgtable_alloc, flags);
 }
 
-static void remap_linear_data_alias(void)
+static void remap_linear_data_alias(bool unmap)
 {
 	extern const u8 __pgdir_start[];
 
 	update_mapping_prot(__pa_symbol(__init_end), (unsigned long)lm_alias(__init_end),
 			    (unsigned long)__pgdir_start - (unsigned long)__init_end,
-			    PAGE_KERNEL_RO);
+			    unmap ? __pgprot(0) : PAGE_KERNEL_RO);
 }
 
 void __init remap_linear_kernel_alias(void)
@@ -1041,7 +1042,7 @@ void __init remap_linear_kernel_alias(void)
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
-	remap_linear_data_alias();
+	remap_linear_data_alias(true);
 }
 
 #ifdef CONFIG_KFENCE
@@ -2257,3 +2258,31 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long i
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_HIBERNATION
+static int arm64_hibernate_pm_notify(struct notifier_block *nb,
+				     unsigned long mode, void *unused)
+{
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		remap_linear_data_alias(false);
+		break;
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		remap_linear_data_alias(true);
+		break;
+	}
+	return 0;
+}
+
+static struct notifier_block arm64_hibernate_pm_notifier = {
+	.notifier_call = arm64_hibernate_pm_notify,
+};
+
+static int arm64_hibernate_register_pm_notifier(void)
+{
+	return register_pm_notifier(&arm64_hibernate_pm_notifier);
+}
+late_initcall(arm64_hibernate_register_pm_notifier);
+#endif
-- 
2.52.0.457.g6b5491de43-goog

