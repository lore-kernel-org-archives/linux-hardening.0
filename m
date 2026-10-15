Received: from mail-vs2-f0.google.com (mail-vs2-f0.google.com [74.125.227.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AD3E16A5
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041819; cv=pass; b=kWbTkeNIQWEMBzc7c8pr9xdnzyvRgMeAnMTWM0crT5h1prRkIJaBqArmF2dPPNXXeZHVeubaVZ83dQMyuvbMjIjld1XBtsmqMq6wOIjqvPRonWwv3C4RD21HRZfhHrLfK1j+J/6QOm7u15o5KUUjRpjzIjlgqnY6yX0gX2cSWfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041819; c=relaxed/simple;
	bh=wT0s5EB9ctm1xuUw4zYNpW2sr7V/a+FHygJ9Zzmu2oA=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Rzwll8CcYtFkYN9tiv8bp1Dyv7FfstMbbtWEkiubYSnj9rKTL4iy0nZsnwbax/XMZI9xZnj86mjtk78KMnPjj5ecCVamXPvnbeIlH6w4E0H9mrFndrwi4Gq9rYIW/OeTHOs9TWP5c32yQrxj5wdCfXHofIQQT9WLQFu3XXX6FHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com; spf=pass smtp.mailfrom=trukhin.com; dkim=fail (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b=TTzVEVVz reason="key not found in DNS"; arc=pass smtp.client-ip=74.125.227.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trukhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b="TTzVEVVz"
Received: by mail-vs2-f0.google.com with SMTP id ada2fe7eead31-7565f2f85c5so1179742137.0
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 22:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792041816; cv=none;
        d=google.com; s=arc-20260327;
        b=VSHAQR9vTXiBBMyODUq2tM8plP+7JTyi700O0XO/BTCty8PKinzdhcCpo50xleTIKe
         4DNZu1p818h6ne+hOMANZZnPKNphquSBA0UhxmBa5bWlvi0r3umKaVPw1HukFmkTYNms
         xQ/aYVcde38vTAm3nLHRJcl8oHcyTjecT7Ee2ZsDIGIzQ3lXYIZsP1OxNV0MfUazzUlm
         6ILrI0I7JrfQrmTelZXlQybFLZTy733zR4V+OpFU71uKYuoKY2i+cEmkzXNR/cEcla5I
         E7BcitGWpzRurJhdMqVcAJme40eqmpgPEo08viD+ta1b5ot47Be1QL8z7Lvz1WC7Wcpa
         QxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=SrK6FyhBTZnEQlLogJ3NQ2zWDChbZG9raJxAdO0+bRA=;
        fh=sOfn9r3NFwyBXH8MDsE17Ulno0lO+zW3ibeKratNk2s=;
        b=BQpgj8f4dT3n1RlfgLLCdAOKjaIaasCuJEVSPGG4IsslJMvrR2XsI241IWD7jallk+
         EbOJ43K9x8dWNV4ILeAqRscynjW6rqHaKe52FQ7/kPbemeXqYxBRIeH0Yto0gKEk7vgr
         XfaVcBeaKsPdKjvFKbPVjBpnh/86sl8WqeHjc1Rcy0y+ALraYmZrbS8k7WdEXeh4XKpH
         xyXy4Z9G3aLqZs4GnRoZUzgCDq+mH1giZH09JllrbkeQ1GY613yOS4L5yyjrzazyIJu7
         PuSVTckbVBg1o6183jcoj1BZkdE1BwOVt35ojEhowts5EOBdphC4Z4j3D1EgASyshZ1E
         28kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trukhin.com; s=google; t=1792041816; x=1792646616; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SrK6FyhBTZnEQlLogJ3NQ2zWDChbZG9raJxAdO0+bRA=;
        b=TTzVEVVz7CCwHCsnQnrJb/QG0wXgiVTR+P/R5OATRyo0kS91ljPygoINKfSTP3Di18
         jHIDsl1gOhJ4HVVnEWdMjQxcVzolsL2tl/4wooxz8hMmDDZT5JcgB8msjQ5J5IZTMssc
         rIPcMDSFpssT/HI0/ShHvUyG86ki/n0+ywji22uqWgC87vWuY5Ji0PmAVn0e1Y2kdzwA
         scjtKG0t4tYQN1d4JLZi2utnG+6x5lNG6TMDwKNngjjlbjqBVIIUp/XqsJh/mO06ZUx8
         4lFsk2BWriwsTfkGykJSLrZHKRFAKU5M1ygo7+QoBYbcbdBSogyDfYs203x8zDEHP21T
         80ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041816; x=1792646616;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SrK6FyhBTZnEQlLogJ3NQ2zWDChbZG9raJxAdO0+bRA=;
        b=kruPjEvhxyCXy/NbNppnT+V9uOHNFx72dYpAZzd5aiXYbm0Ch8ATRaKdf+exI3JGRa
         xFxM4Ekugxr8D+zbxfQuB12ob+IGAnbUM3eZevLFLmndaNj9JS+fFEQ+0Zs8qkdyU4nj
         zVaRAgRRLsrsrbN12dWAhkignRmXnX6j67jjp0VIRU7hDZ87GoIbdwTq0n6TmYo5pbNx
         JqbVVmn+iufkTrQnw6f4U16LKRXSSuDYa/K2a07yBLnwQ08r3soY3nxfnVzAN67WbNsd
         pYtH9tTxLpMJHg4DgDRaKcBHKAnVz8VXKNt39vG/DBNBW5lH2V2txxOR5ZTJWfB2zKsd
         DC9Q==
X-Forwarded-Encrypted: i=1; AKwUvBx1pQVeSvbum5X5y7pov8ZsfVmYEsI+oPkGQKibD82tV0ZErxAYJFYUDXc1Tc9/4FYJoXDDFWUgQlrsD0mDg2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqYdkvCbo8V9MKHBheqhi6ydJv559etDv9RWbARJggJlTgJ1q8
	h8g90UYix1Vg0vtUAEDCYA5qHf7B1GRLDQruf/TTXl6iNSzwDBZLkj3W1IYxJKIcyCFvTHqRkMA
	MOjjuG086jogrtiSY+UFYLD2TpmOT/zsABxq/YF+13g==
X-Gm-Gg: AYBFou1SJlHPYLz2p2ZfrSLC2kqWO7keq4fBXzmPv337aBuVDoaTMdv2itE7Ex7yzUK
	OUVS3ToHeOq77p3d8hCsXz7SuCmxOgDCZtb11DLlyyo+kfgVzn3EZxtPnbGsdjXlWI2wrKMRk0i
	vkmudxSoiclaA6+ZMnj5Fwx7u3wtZ2Pfk5X2Kczt3fcW7UDP4adwfbwdIqabUKxvVC0u7IcJ69+
	N8mc2Y6F7WSCnN5kl4zruivqfQxE/3SXJ/H3ckOvmQQ0NVcIsXBnUhqBnhKeoI6O5Pd0M6g5S3L
	EXnsKKypTb4BFMlSNDWitMasznY2xbmlwH+cj8MjV6mm1/QpvhXR6d9FE6EhoJz6DS+I9DwPYzk
	86LiG0pgHOM4KDIGdXXWpHirQ0mCF5sDrYw==
X-Received: by 2002:a05:6102:370d:b0:7c3:9464:efaa with SMTP id
 ada2fe7eead31-7cb36590225mr4707868137.2.1792041816136; Wed, 14 Oct 2026
 22:23:36 -0700 (PDT)
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 22:23:35 -0700
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 22:23:35 -0700
From: Iurii Trukhin <yuri@trukhin.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 22:23:35 -0700
X-Gm-Features: AclHuK_YYfxnldX7Bh0B9i3Tow6J5A6qSw_Ioe7q5Yt1rETlptfRJUA_JUSnfjQ
Message-ID: <CAOx7e9K5sgNcWNj4CemyZd0Ar1ZjR4o44B4nryohq-Ue6TNdKA@mail.gmail.com>
Subject: [PATCH v2] arm64: raise default ARCH_MMAP_RND_BITS for 48-bit and
 52-bit VA
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <kees@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
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
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
---
Changes in v2:
- Add a comment above ARCH_MMAP_RND_BITS explaining the 1 TiB default
  for 48/52-bit VA and the fallback to ARCH_MMAP_RND_BITS_MIN in
  arch/Kconfig for smaller VA sizes (Anshuman Khandual).
- Collect Reviewed-by from Kees Cook.
- Link to v1: https://lore.kernel.org/r/CAOx7e9Jm0N9O_ndL1UApMPrXUN=P4RiptSNibdDP+9prUsNPOw@mail.gmail.com
 arch/arm64/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cab741a695f5..7bca47269dd5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -313,6 +313,14 @@ config ARCH_MMAP_RND_BITS_MAX
 	default 16 if ARM64_16K_PAGES
 	default 18

+# default to 1 TiB (5 bits below ARCH_MMAP_RND_BITS_MAX) on 48-bit and
+# 52-bit VA; smaller VA sizes fall back to ARCH_MMAP_RND_BITS_MIN in
+# arch/Kconfig
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
