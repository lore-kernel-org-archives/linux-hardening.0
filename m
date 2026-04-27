Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495034028D
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304138; cv=none; b=aLcBraBGZgYLLqW6lTRU1FXi1i7ubGe796BV+200vqCIl6rL7TxnTWi1o5UeCSbDOfq2AnleNb7RQkDjseu1Ww529Fvg7MNC7I92+wA4TIdhLUNDMr5wAVmSsPZcWcald83DItaq8L/c1OpbPav/nGqNYv2/kKGlxBdDJzD6P6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304138; c=relaxed/simple;
	bh=Sl0OBQBWIK0zh6lHXps5IqXvZm9y+3UkjWufXvijumM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yt8DUYpmmGPPVNnEf8Uc3uQS2e/2RCgIy405Y2sfWDJwd/6xIeRfFaRQu/BJ6Bnwj11mXNLf289DS5EjN+W3PPDXwSAQPQm1CLDZibPMO5gEmZMtJMAIbVXVAoNR7YRbEx8IvVY071k5/DmBgd2T8Qx+6x18VUB/08LHT66RZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NH+E9lRw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NH+E9lRw"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48a55ecc32cso58152205e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304135; x=1777908935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8F3kASMqf5BHYl2gzcA0DgWEOwzoo2uBq3thfdXqJMo=;
        b=NH+E9lRwKjOCEzgfYbeuSSQsUlncTtFpQ7d0aV59HERZvL67lDcVTFkLfgR2PEa6p7
         irdw3W9Xi96W9FufSW0+7SYY/8H5UVcTTYROrkr0fToNQKOZUkaezDPHWgeYHGgpANFz
         z9V1apwiDDMnTFRtCRrVnp4oR+9JqYiw5WRLNiKs96ZLI2qJIcgwXWnJapyKLw4uzgZs
         tvynBFbqWKfJDscJgGEJS+E9RwVeGAu1b5pU3blf6hwj6OtNH3zfvU8KmPEJ5CjPG7qq
         qKzYyLYXY+sC60Qsm/BNDy+qPp52tHWbRkSEvS0Wp4EDknE1rn4w0BPt4Uak4M0FfhEA
         K6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304135; x=1777908935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8F3kASMqf5BHYl2gzcA0DgWEOwzoo2uBq3thfdXqJMo=;
        b=EXBCxaO9TzsMPxYgibVhrRQXab0twKBxtdle5sBupeWeBmNmvqRohvh3yxndMLH8Wj
         ws0cvGnrAt4WDqJewl8qUMLzYF4QeWyh+BdfxFNAC1UBkiiXBHdR4KostAVpjd4t6RZd
         6P2uOJ2ZcusKFB198iZdwHCRt5M+w5Sd/iyIZ9kSFogNjDiEhocPY87LESTSKxp5V7m/
         7V+blpYip/IQ7r+qRfQA0u9t4HUCaphmc4TU47Qw2LUGFtE3ST0QXBwSqyr9XRsmT0B4
         xSYXTN3kD+mXzg4ERjJYYD8/+GXZ6Fsykc499FSux9EWg8ykFvTtl8eXHk1TR5BB6AL+
         qIkg==
X-Forwarded-Encrypted: i=1; AFNElJ+lq4ZNuEJbqhvfdbD7q4XeP5I7PAVAOn4wZ5lIpmM3ymOX8JtQ5+aP0AUaI5B/gMjIOXkP5bp665dgMqjRPE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbHyGd2vcuzVyBvmVaip/dQW9JIDthP549J+ZtFvLp2jzOKKdt
	pO9g6twKSInbnbNolJqK8r5khdRpXBj8CF3/61IGATWz3VYvL33Naya1nZJxcgp/ufvV2AjNug=
	=
X-Received: from wmbh12.prod.google.com ([2002:a05:600c:a10c:b0:489:1946:b592])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e28:b0:483:7903:c3b1
 with SMTP id 5b1f17b1804b1-488fb77fbf3mr626097515e9.20.1777304135240; Mon, 27
 Apr 2026 08:35:35 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:18 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=837; i=ardb@kernel.org;
 h=from:subject; bh=FjvXC4Bvv/morAQPM0ElYAlwegkzMza4j/YwiIL/yF4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN94++NX3ll/ZiXVZap93TO00rsSY3MY/ndJRGotvX3m
 Y9v23Q6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQu/mX4xXRjUvDxfwUKzSeC
 Qp+sfOS5rfhfFteH21tOH9i1KfXn+g6G/9lLOeQeqzgJu68KXXDhuUvujolfrnt0PsxjVi7vjpH 14gcA
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-18-ardb+git@google.com>
Subject: [PATCH v4 01/15] arm64: mm: Map the linear alias of text/rodata as tagged
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Before moving the empty_zero_page into the __ro_after_init section, make
sure it has the memory-tagged type. This is needed to ensure that
cpu_enable_mte() will be able to initialize the tags correctly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dd85e093ffdb..f084993024ab 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1049,7 +1049,7 @@ void __init mark_linear_text_alias_ro(void)
 	 */
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
-			    PAGE_KERNEL_RO);
+			    pgprot_tagged(PAGE_KERNEL_RO));
 }
 
 #ifdef CONFIG_KFENCE
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

