Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A13F1AA2
	for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066942; cv=none; b=sVF2c2q/K982EYIabUeHashN6m3tDSxPwibtp6nJ91zTiBjoIQQV2X9kC3A8PIRDI6IVjc9+sENPtwp4P/x7oXuq4aW1x3WiK2kJ7GU58GYgHBTkTktqIYzhdp6+W1KKAsvK3jhLTcdWgIlHUXDYyZbzZq5RuNsI/t5p8ZIDUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066942; c=relaxed/simple;
	bh=rbAH8/myfwRfYXMnjtLL+vO7GYgkLXHy3B4fGS4xjLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dPmQDijQeNi9+myzIckZ2f18JsVqi0nJc6MfBfsYVfqg3r0Y+PNkhRNpkWQd+vjBa+zWAQ7oPr50LmFOJww0glx4Hp9uqNhjFjhVGHZcPxBtK7jE6RxwXUwCSbLJJXdmL2xBlwE/Nrsi4prHZCzwSu0KCt3t+t5G7SA88jpcCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipFcfdj4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipFcfdj4"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-49045243094so101656955e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 29 May 2026 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066938; x=1780671738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADUQ++mlFIW7e7IV4zrfNK16oe25OrryHFNLylPLx9Q=;
        b=ipFcfdj4gWbwrnCyRQtbhIlhTNJUdxk9foalaJsdvONkIc0NW7pT54m6NU/5VixLcr
         r8RYu2w9fwqjegSuyJGnTReQyhTxfRszXWQsmq+98rawFxuAupNL8YQzx62C+E213bAR
         yLcYs9VBlJkSlljXTwylQr/zRGA86yjftBT2PDfCd3TK38IlSaVCiI99Hg1sgEBUPC2P
         yJqTvKHOP9XbMQ1o1hmCxZFvxRa/y1ET0UomQBijVvVdgqB6qhZlqdIVjF+q+6heMKn9
         AgR+zOAet4k6zrfC/fJpAsPT35JTYvgssdCTgPS7pH+QMRscctsh8BsmlbeB1rNzVslg
         NddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066938; x=1780671738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADUQ++mlFIW7e7IV4zrfNK16oe25OrryHFNLylPLx9Q=;
        b=rkj+/FTEBd88Tl41XnmA66hkQoM6PLDRMWI01bmPxkob67GNdYWKLDBaP1zDkIrX7X
         UQou79zUKgUIXYIdOtrnfS8EqRm+V0MPIrOPBxGysM53IT7QtJheEf0lEWYClK6qEggw
         rqTS+KYbFO/b7U/rjOITlZCgdAnNHaiz58XG2sg5sezWjjruybI2tNbXrdfxxgUkdTQ9
         imSsZxaZxyokwYq+Go/6FMPelRY987uajn8T6tQyJXnquOWkMQseAL5Rt8Tt1cSJHGJe
         tbeszpg7slQ0UuW6ABgGdkVWEHVgcV1hWhYlSjD8qG5Rf1qS7eX9PSJWsMcM8BsMFW7t
         JESg==
X-Forwarded-Encrypted: i=1; AFNElJ/R4G5+vDb61rJiljHJn4Kf0gNnBtEGwEoGQdiqucIYebKyqzRmvFgULL4PbHiD2S1DGdfr4Agiv0slN0pgZaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczQ2fitX/m3uhVaE0k/jFKvEyTlmj4+sbU2w8k9evOCB8Av+2
	raX5KfJekxB3UM3JEp5fID7w3IALfuA82RGtAaI28N+6/YR4QMtiwh2fmZB+fgKagWFJi4aVJg=
	=
X-Received: from wmco20.prod.google.com ([2002:a05:600c:a314:b0:48e:9137:b54d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4616:b0:490:8470:31f7
 with SMTP id 5b1f17b1804b1-4909c0b0175mr35812255e9.20.1780066938306; Fri, 29
 May 2026 08:02:18 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:52 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=ardb@kernel.org;
 h=from:subject; bh=xJBQ0hvsJWcxX3OF+aBCCahIM1cYmsTmsethYm+trqI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVcJX97Dz7W+MMlK2LNwkUx18YdWxeHbuRF3RixVzy
 2VZWh91lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIncsWH4K15aydfEzd4bZFBo
 IRJ1wOPhL4sFl+slZr0uKIyeuuzbIoZ/xqFpXiaXjdJOHT9lXb/2g8g/3TdHPNLmFe0v7lp74/s mHgA=
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-18-ardb+git@google.com>
Subject: [PATCH v7 01/15] arm64: mm: Remove bogus stop condition from
 map_mem() loop
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
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
2.54.0.823.g6e5bcc1fc9-goog

