Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21891257ACF
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024013; cv=pass; b=G2SZCam5xB83eDuOWVgqCVIcS+MBKA8RXgyVgpziHzW6dvLvZU+tgYw7mcntKDWJPLzqGyptOrmFV5ff/KshG06J9iYx45AZlPxzPwUwvzWjXOhp2UvHTBV4EESK44ZgIMfR/lmEt7aNDRlJA6fzn5u3l+d1ocQNR4fi7u9lMG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024013; c=relaxed/simple;
	bh=H++n+6X9C5VvpyroWHO6KdmIePZMRt4kP7lXJi1S608=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=lL8OL4WbmI5AGDOxx21b6OR/vDAPinlcC37naV+asaLcAQiNzyxPIXzA5h7ZeVTYGb+iSqkEjInaDM/l7iRNsW73Vohcgd4i4ofN2bdNBgVtPgobeo92VQBQzgONA6q0BrEbuuN4senXifqXYYz0VtNO20yae/X32XI7ZTOWUu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com; spf=pass smtp.mailfrom=trukhin.com; dkim=fail (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b=QJ4eocK4 reason="key not found in DNS"; arc=pass smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trukhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b="QJ4eocK4"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-49dfaa16190so4918170fac.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 17:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792024010; cv=none;
        d=google.com; s=arc-20260327;
        b=QxoqiJ/zpdNyAlR/KZ3QbvR7RYs/Etkp5B8EIFQCXz8mrBNOEbJQwLabad2ZzKusCX
         +fR/+u1roPO/BjG9tQYbavu6K0DHm4FJ6WO6J8k3+NAV7HhdOlUxRljFzs5EeSWmPrN1
         /a2O2QVnOe1f6qAY/lbQk+M4VubTs0gtwRXkuZ4sEKqxbCU2ay7XZlR+mkCmwaKkc7rh
         j/mvA8GpMbIeKkLpjHwb/d1TdEfymfF53Xp1wCoQwjzvaAWJEsHvryGyWrzBgs9Kofus
         v6mnJAEutCnipzjtwXY3Kr9Sjw2/nqGEeIbKS5GqUcK3E9J0KUQgVcIdeUNU/78V8v0t
         6EzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=EYnWTiTFyQXGC6BI11nfHmwSHAXOSjJcKpSLcmRA1K0=;
        fh=DequvhVhaLGuCxZVsUy9gR7lWCi4EOJWuDImbzw4/II=;
        b=dDOs0O34Uw0FrxuJPqpz60tjo1lyxoszHSNAqLc4OITw3nnrxyCatywdIM7ZJ2CDkJ
         wDWiFkxGqWI14zq4+w3ejng+6wSm5pZqTaAvost/qVH9pmpo7ZDDxhHF/DgBL4ZpI4qH
         qPyezeEB7bJ99xEOtVWP1QkuRO+NJ0cCNIIIe6wmUleZk4flCcdYgfer6wfKd6kq5Ltr
         BUQtmg8sxjFF2qtrmJrGSAOLqlPlxlOOrpTorvjnSfBcXm9zUh9YQiefFoPTolMust4S
         M2/qvBiQhlKxTnHKY3wOYbvZOzWwGFGD2htzDuZYRxpdLNhHQ8148f144GB8+Nu4prVD
         LpLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trukhin.com; s=google; t=1792024010; x=1792628810; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYnWTiTFyQXGC6BI11nfHmwSHAXOSjJcKpSLcmRA1K0=;
        b=QJ4eocK4Pzb2wyrib5eyQts6umMjbZh1ZqjObUkiEukyt9mfkRpewqgSxHuhenDdpi
         XLsWT47x8TpRHgaIQNQwvxMiMHHvkfj9W3q088qCGugSuR7DBHquV0CSADy3hzL1wfPz
         +88EeySq7wdi2/vSarAdvxwrZk2yTxoN7A29A1YsQjoOozIXQAckI60VfjV4jYcUn7qS
         kHMe/aEvln/qxJ2jKIJ5kGrfZkR4v+bPoEvqc2TVF/kj8jpxjbHfU9ve/T1eGW7v+5gr
         F2CPvlVXIsy3rRAhsQSz9VlWkJfQGgB75w4mBEcT+4qnuwyCn0GCRx/zEbwuTDvoAf7u
         YCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792024010; x=1792628810;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EYnWTiTFyQXGC6BI11nfHmwSHAXOSjJcKpSLcmRA1K0=;
        b=xN8/kKftIJOW/W/8drHrtw0eKr0qkTStdZ0uTEtfEruh/pZBxjMxBbNudM1Kj3B7Xm
         3463jWheoEVrB0vgRVrc+uYvfEg2tPUyJ5lQcXGJdj8LOSMxeX6MH9+0+zbKE2jGoLpv
         bNVQEHBuWcohPAqYtW4OA3MGiQcSdBndw9Dr9nxzFOdzaz72iyUy5GCE5jP8QEDJWUKC
         mKa6tCzKnCnz6IjfKVsCDnYKOVcfLmkoglJxcbwWu/V9Z3CMHfZUeS44hsIgtutSLloB
         K3rXxXZlOF+UltonQcvFMDXWXhJyos3P99On/C/oj7MPSsVMZgOnrFoc6qo8K4DWAdDw
         eqiA==
X-Forwarded-Encrypted: i=1; AKwUvByNU3ZTQTLj+LD/SLFKmn35fvjNp47qw9Hrzn5g91P8J0TW/b9jzT7yTNpyP0yjDndx2LoVh+N7YyPHDk/FRZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0JoSpzLmjwuvmnrtJeCl8i/0nd7UheH3c2YNjX0oAz9qh5iYr
	pyBq1EMorZChr3RvXGW7AEZ/+bxlPqU1WsbCbD9H7QRLZc/jI7KCOTIJVe0wlCiFvcE+0Gsagd1
	lik+/KAfWwEeLnp+sjeKmbqsgnsvLefHzn3ZAM+kVAA==
X-Gm-Gg: AYBFou3xnn1XndKAl6ti1Yst/QEIjEKI+2BVtRqmOgDnzag2OeorLl2FIWqsnqIEbSH
	A1iSvSa/oFGeKKN5XYIE9CTROHYbGMUEMNzvZWQsBxvEVExj7GuzX+u6sMishCfkhk3Gud78XpP
	uuL9EaH6wZLKz2WOl8q6pezfi8RA6IgkvJhO/K1wMe/TvoFKt2YaHkADRTHLmtC2B07hVTgDfNq
	LsJtLPheWH7n+4Re9x7S9mwJnQA2VPAtxXXjUO4RqmMEn87nJZmYf32XZ0dADnkC9u0/epEb2Gb
	MWsxzOjCubvh9/3Fmy5PMPBcVassZNvoEp1AfeUqvE09a8UgRmjG50taVjTiJ1yQ7wVSx0W8jm0
	HGvVTbtnovzgOYlvuVQg0cEumJhgbfNhHjg==
X-Received: by 2002:a05:6808:221f:b0:4b2:8e26:bdd2 with SMTP id
 5614622812f47-50b5c4ecebemr13933676b6e.16.1792024009676; Wed, 14 Oct 2026
 17:26:49 -0700 (PDT)
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 19:26:48 -0500
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 19:26:48 -0500
From: Iurii Trukhin <yuri@trukhin.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 19:26:48 -0500
X-Gm-Features: AclHuK91BdsMHJVbU4wd9iqYKa580uSZ-OhEQncSjljqKAdBVeh9GoyP5sy8tOU
Message-ID: <CAOx7e9Jm0N9O_ndL1UApMPrXUN=P4RiptSNibdDP+9prUsNPOw@mail.gmail.com>
Subject: [PATCH] arm64: raise default ARCH_MMAP_RND_BITS for 48-bit and 52-bit VA
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <kees@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Iurii Trukhin <yuri@trukhin.com>
Content-Type: text/plain; charset="UTF-8"

Since commit f101c5644771 ("arm64: Support ARM64_VA_BITS=52 when
setting ARCH_MMAP_RND_BITS_MAX"), arm64 supports up to 33, 31, and 29
bits of mmap ASLR entropy on 48-bit and 52-bit virtual address spaces
for 4K, 16K, and 64K pages respectively. However, ARCH_MMAP_RND_BITS
still defaults to ARCH_MMAP_RND_BITS_MIN (18, 16, and 14 bits), which
was set in commit 8f0d3aa9de57 ("arm64: mm: support ARCH_MMAP_RND_BITS")
when 39-bit VA was the 4K default.

Set the default ARCH_MMAP_RND_BITS for 48-bit and 52-bit VA to 28 (4K
pages), 26 (16K pages), and 24 (64K pages), matching x86_64's 1 TiB
randomization range (5 bits below ARCH_MMAP_RND_BITS_MAX) while keeping
ARCH_MMAP_RND_BITS_MIN unchanged for smaller VA configurations.

Closes: https://github.com/KSPP/linux/issues/371
Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
---
 arch/arm64/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cab741a695f5..59a53d7a75c5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -313,6 +313,11 @@ config ARCH_MMAP_RND_BITS_MAX
 	default 16 if ARM64_16K_PAGES
 	default 18

+config ARCH_MMAP_RND_BITS
+	default 24 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_64K_PAGES
+	default 26 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_16K_PAGES
+	default 28 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52)
+
 config ARCH_MMAP_RND_COMPAT_BITS_MIN
 	default 7 if ARM64_64K_PAGES
 	default 9 if ARM64_16K_PAGES
-- 
2.56.0
