Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA434D4CE
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304142; cv=none; b=AT9Lsk/BkwEbVwBmbgNdNBDDGToJTF2fiPfcrGAFYKpBg8uPITV2b9LThNzgOtyqYFjonO85U+QGZom3sl2Bdr6EK5fBiD1v5FKcDCHzCdHa81fXJB0vqHRv0Pz2vCpHEV+g4b7I7ngWUJyat4NdBBuuIMMTUSZ/g3Nnzllv2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304142; c=relaxed/simple;
	bh=iOBV/ragVWNZA9cpwk/m5In9oe0bnruniT9MVmdSMu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aKFFT12/Sy0Y2iCD7wzWVWqe8T7zyb2bbdldzuY+ff5aeki15ByHwPe3FmOpTLN1D+rBZf3RO1sNOKjJNkBCcLRVjN+qPS8rYOAUFowsmZk+Obk8yRwMu7ECrUTWLdMyp2URdaS0vb73zy6H0HbXsNxQ/AVmvYtlzmF9wDEgpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZelkoK8; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZelkoK8"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48a55ecc32cso58152675e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304139; x=1777908939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fih3i4e18PfvVXsOqO+51UGmMLaCoh2lR+Igb4mepcc=;
        b=AZelkoK8lV4B6imC/9IdUO0WNNoVWz8A7iy1WwR8OPBjBRaf7qpBiAiGhRhKSJU/CR
         +7MfgYWJ0dr1RsQJJOsKpSthlG/8ygEV/xPiTscuTesFW2W7Zm2kxD5fLGpjB3C6ket7
         A6bcKjMvWhpa5Wai25MmKUwuoc8ajl3Q2zWbdWiAha153RGh8E4r72kVkjUkqHf4fJPL
         qaruTFeSuhwliUd9OPSKSqdZq94IjAs9rbhVJ+cmpw3n9zKsL5N53Lx4MMiTn2cARAJu
         dvwzn+RpXrI1j+26SIySvpuggTKR02Hd1WDSQiD+RHRKr0fNOz3rZcYbSQsI1sGqoT6L
         usDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304139; x=1777908939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fih3i4e18PfvVXsOqO+51UGmMLaCoh2lR+Igb4mepcc=;
        b=khRw/p0J0WsPbQh+JScrRZKgjPrXy3IcBSbkNjbvunuqV0FJUp1cnQf9t3ItBUFBB9
         WsbP/6jY2YCYya0hd0q/8rVVDwdXI1xlqRIfbCf2V7YXIo8d/wtjN/Tp6QrEuLbwAc8l
         S+HdAO05L45H0UJcpNRalXs14PaNDz2PpqLMLLv5KJViMo4eqOjp046gGODqBZdU3YrT
         CbbQ0+RFc+W7buOvUaEyg2bL5AG6NUBcdV6GpJTQkX8pNTGvtTpv0e9HyoTN+uLlIqB0
         OueMLuOuKAw1X4uHml5qZseJSXf6HcI/CgUs+9StS0rXX+uhJGLyBbYEEK6OqxEw30fM
         38DA==
X-Forwarded-Encrypted: i=1; AFNElJ+GfL3MdEQ1iegOiKAtGkTOlQ4hu9O/R4kkxRJc2p27QtDs00robbl2BJH/16VbOKVPg9ryEMhl8ojH7+SqFf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZEK7oDGdze1cJCXD7MJ7P0N4ze7BzkkmhNgY55yArfpPEqfs
	6AA0oJINAREmsZ9iu1c5u6H2ow4K//jQrgG8MDXpj+rqUaVl9/br9GFv7sGjuXjx6sNskPpcUA=
	=
X-Received: from wmok24.prod.google.com ([2002:a05:600c:4798:b0:485:3a48:d6c5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a30b:b0:487:4eb:d125
 with SMTP id 5b1f17b1804b1-488fb74dff1mr437765065e9.9.1777304139320; Mon, 27
 Apr 2026 08:35:39 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:22 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; i=ardb@kernel.org;
 h=from:subject; bh=h7ZYPXsk7x8qiYN5Bb4ArPGJm788B+DXEeUwDjC4Hlg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E2OMr//DSScOyewrtDKSTj2pNjs54uXG3/nW1/QLW
 jXW+t/rKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPxecnwP+a5BK/ZucVOeU81
 7jYvnbjm7Q/9FoVaDcW+23MP86w91sLwi+mK+4lU2YQl89dJGK4S/TllWwHHxeqs1PkRZyUC700 14gQA
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-22-ardb+git@google.com>
Subject: [PATCH v4 05/15] arm64: mm: Remove bogus stop condition from
 map_mem() loop
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

The memblock API guarantees that start is not greater than or equal to
end, so there is no need to test it. And if it were, it is doubtful that
breaking out of the loop would be a reasonable course of action here
(rather than attempting to map the remaining regions)

So let's drop this check.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 005844e521bd..bfbf3fe0d1be 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1177,8 +1177,6 @@ static void __init map_mem(pgd_t *pgdp)
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
-		if (start >= end)
-			break;
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

