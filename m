Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD33C552F
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304146; cv=none; b=oSKTtCqS0fqiUxy3CSSHj3CRSgRWqSPGbfcL5PlR4THqBFzlhFkCG1LXULk8YpQWUMLZ0WOkweGzM8OgeQc/G64a8faqPBceJKuU0NkU4JBpNxXl6EE0328rkrUzpOVQdMSJuVa9Q20iXVlrFGJDmtM3tp46++ooj0SM0+/bLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304146; c=relaxed/simple;
	bh=BDMt9Te/HD4/FmFEC5d4cBAlbQOmsC59W6/7DsC1lyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TuY9w4arjrj9qytfhrYPbP7MXjPfB9WMQX47YBwc3UU4TIm9ChByDRt+P1Hnt/GUiHGvlGSPX0XeiENTUeWjXM2bxWaARqYAr/YMLlHR9cJ/ndTb0gd8xXgJt9bySFkRcF2Ww+CzfXGiOaw/opT5cfldy3UiZEXKnYhgc+pGv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H27q7tRL; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H27q7tRL"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-440d0c4401aso7646392f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304143; x=1777908943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WwzihijZssqSOtMqDRFEFZS96kFccDT7AOSNModvwc=;
        b=H27q7tRLEwsD9zPKmUgJ8C4TPh92e2mfUenSroNfKL7ISmRNRDIn1fmVVFNGLqiUVa
         IHUJGUXPPteAFFj22Rk69k7ayQ26dkX2AgaFPY33mhjvtNEHglVFtCbKGA5dx3VBVZ4G
         +uB3HDQhL4nsoX4Fe8rNtFiNwIvaJzNx+4Fh0db5LnAdJYJZFiomck96/FR2TdUF1UxB
         zF08Pg2NQyHI65kkei4Qjmw3wMZpvf/Whrj04XBlvRtTgNwXUc0sLBljBz4D9wLEYaak
         T5FjXGNV4KIk+BRTB2cJCf9LQBPQ0/C+k9NtD0kbaRLKO9kmSibJoMw9O0LfYpFQc6VJ
         llgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304143; x=1777908943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WwzihijZssqSOtMqDRFEFZS96kFccDT7AOSNModvwc=;
        b=dQgQCmVKOLoaEW285WuHzniOUJfIeBGdwhjXSl6UO6rCBw2m2tgudLbNlQkZia+8JQ
         F7jES6Y6TLzZvd+PABDfmi5PHfR/QWtxzyJzxoJVQ0Rd2/rUpllHqFmR/ZQGSgYm9dCA
         cpjP5izwZnNB1to4xzfMuA0Ri9XnHlXi/ZSUl9mUKpTOr3owLuyEnSyaqxJYHz7L8vLy
         x4hHSLMhniH34OSx/Ju8yT75F9O6LSwqngwq3hk1poon5SHSB5DVHbAhWaUHwp2++l70
         H2Qcrot2OIPBfdVgX0oCKFc/NJQqP38xJRJRSxkFO9aNzN3uMEJ5SvcXrv7ltoPk2P3/
         ++OA==
X-Forwarded-Encrypted: i=1; AFNElJ+0g/KcfZy9WzGjmTfCfCn3Ay83yHsgdy/idfb+b6/sF99YB11Hd4lbEz/y7JEsM4fx/rJxg9SrrmPeddylwbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+7p88iKyVoMB3+K3TlyU1AzD+A0OgZNH58You6SMkXF3hpva
	uRWLqPOTYtxJuyKPsT0XC5AtbnPif8/fPwj++sYxMrR2QhdqcpsQ9U9ylh3Y4Ja1kpB3oeH9pw=
	=
X-Received: from wrbdy16.prod.google.com ([2002:a05:6000:e50:b0:43d:729a:b525])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5d05:0:b0:441:247a:e98e
 with SMTP id ffacd0b85a97d-441247ae9ebmr36895346f8f.24.1777304141472; Mon, 27
 Apr 2026 08:35:41 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:24 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=ardb@kernel.org;
 h=from:subject; bh=2M+2R/xfGuHti5Wurk6r5E9xqbGluJyDsIl7VYMOsyI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E8tUw49az8LPeSafvHDx3bajk3bfqxCf4/ElO9n+i
 EqbmadXRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIxHGGf2rT5kc6JZw8EfTc
 dtq0B6b/C6uZdnxyULeaKj/79Ou3L1gZGd7fr5d6L8ZyoL7vypL3Bx1P/wzxNdu7JOz5R5H7c65 9f80EAA==
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-24-ardb+git@google.com>
Subject: [PATCH v4 07/15] arm64: mm: Permit contiguous descriptors to be rewritten
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

Currently, pgattr_change_is_safe() is overly pedantic when it comes to
descriptors with the contiguous hint attribute set, as it rejects
assignments even if the old and the new value are the same.

So relax the check to allow that.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9610dd2d7bd9..bfb2f1cae724 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -134,10 +134,6 @@ bool pgattr_change_is_safe(pteval_t old, pteval_t new)
 	if (pte_pfn(__pte(old)) != pte_pfn(__pte(new)))
 		return false;
 
-	/* live contiguous mappings may not be manipulated at all */
-	if ((old | new) & PTE_CONT)
-		return false;
-
 	/* Transitioning from Non-Global to Global is unsafe */
 	if (old & ~new & PTE_NG)
 		return false;
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

