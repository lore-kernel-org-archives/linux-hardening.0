Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E83B83FE
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818364; cv=none; b=AeL2yG3owWxQfGxP3S8pvb7CWYrCQSS1wwhS6nciR5z93r47bKHZ6hXmxKrgu0iapEeo8daALglwl0FsshBwcV9Mf+krjWZajjnZTadzuYSoBcGQxzt1QR+ZXCZY6qcaQ28e11rzwZiP3/7t5p9ww+rXIlWlM3uJ1xIwXBAIPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818364; c=relaxed/simple;
	bh=FcYdFUFDbYIAdFyZlCTNmSVC8QDMBmfYYdOjNopJ730=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lJOgX2rBLYGH1WTmNiUsktOwTqf9rFfMY3Ga/pCGmen9STHwOAOeM1cwNoklFbKQhZ5Rt65+EW9ae9UVVIWQ13aH0Vgc+XLDNYivyK6Dnw2mrlFwL+VE2tFyZYG8SVmOV931C3Q5M7hCGfT0shDy7ojxZb+sd1dKmjjtQ2m8Vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ek+RZk/S; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ek+RZk/S"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490402ae2c1so46918265e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818361; x=1780423161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RFflol+bsWEcr4KlK98zfj4SqOIgycSAYTOMgzlgw0=;
        b=ek+RZk/SvuyLoWh2fNp249lo3CeBqrG6tOgGVPX9BuzLKKLnkuDxAsEWZr0SLGKklb
         XJ21kUwz24VbHPEZIi1haVholViaa3Xwa7am1knB2UqPwTsJ97bdZJP2sTM7uQQ/ljvF
         70qBdqbYnI2fcHhUdD070oCjtKIgrGpFYGU5s7R0qg1SRCuv/O/iWfU4heeZepJx9VNn
         MTxWpyGahRE5tQoMv8emS5xukNc74UIb0mtZhonqQZPo70ifGA6vQz9EG4kEeuvp0fiO
         NLol9Dw4Unt3hBoODHQNxIQwqMgMi8qzm6uo0jZijDodwFahDSjTYIBkK3aCuIP/3Vyb
         gDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818361; x=1780423161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RFflol+bsWEcr4KlK98zfj4SqOIgycSAYTOMgzlgw0=;
        b=U9U9NjTg5YvOz/73846txdoBoDxtiQySczy4klV8kO23EkAUneUVvwQ8g3dFVFyT9r
         EPNwjUbY+pduwEOh+xzYX2lCq9gsL2/Q3E687eLORCotl8gl1GAlyGELaJVKrU1/jLgL
         WWru4u2yyF0vWcIwE3n2sTImLNeoYlHkgAAHEtlcd9HLMF7ABNGAKEineJV9pv+gxE1V
         kDVbSUhN7uJ0oxScXlmkBKfzaL2qGSUhDxBYnnNTsXOYw73bS5h/z7tIjzb9006GabBR
         UpdoJVrAV3N/49mWdJxJ4++ysQBOC5j3xbafhy3N323k8Z/XvAM8597lIpR4+FyVKA4x
         Srdw==
X-Forwarded-Encrypted: i=1; AFNElJ9QcrURRwQWJTOlZOHiTLKEBRkDGV5ZTzpEowdk/DPwapYKcci81DfPgZnw7LdazB9DFYzRi2VDPf4xm3PXsrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+u91cNmshVgwdiexNsi1ICXrAcNh3Xr13WHJ/PHICRn8lGtr
	7qeQuxN8baLBAhEJKmAJYd0gLu3jmdE/lSZWCVNsYJeptkz6d5JX2zCaSw/IwkRSaZpkCWCQ2g=
	=
X-Received: from wmgb20.prod.google.com ([2002:a05:600c:1514:b0:48f:de5b:469b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8599:b0:48f:e230:29f4
 with SMTP id 5b1f17b1804b1-490426ade02mr205371775e9.15.1779818361151; Tue, 26
 May 2026 10:59:21 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:48 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=ardb@kernel.org;
 h=from:subject; bh=Kh7cxWXkNrSTDvznUsNThby14Lf6cpInZSVAIOoSUVU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fsQvk8viPq9V2vx6dMWennJ+dkQqIjT+cV/VLZF1b
 R7nhSZ2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImsLWZk2HK0ii1yonQZe7ZV
 +ApXXrWOD0eLlqwV53zN/y7vkpHmYUaGZx8+meyLTM/2WSaWZW95P1zc+UOGxrXah+2Pw7MWVjW xAgA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-18-ardb+git@google.com>
Subject: [PATCH v6 01/15] arm64: mm: Remove bogus stop condition from
 map_mem() loop
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The memblock API guarantees that start is not greater than or equal to
end, so there is no need to test it. And if it were, it is doubtful that
breaking out of the loop would be a reasonable course of action here
(rather than attempting to map the remaining regions)

So let's drop this check.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dd85e093ffdb..112fa4a3b0eb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1173,8 +1173,6 @@ static void __init map_mem(pgd_t *pgdp)
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
-		if (start >= end)
-			break;
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
-- 
2.54.0.794.g4f17f83d09-goog

