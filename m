Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731682EDD41
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841785; cv=none; b=mLEYq2EuSHuPV7to+HZRBUpXF6+YdYMtw7JRxt4YDxKggY48MlGqpOLpag9Uesk2J60KafoTM1J50rvPu6vVyqcHPOklF45RZeLWnRlXkKHZFuq7D9/zlPnLVa4tHs6N+nJ/xG58lYevxLrqGZ4Yd0478fD9HVnj16hnaelbZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841785; c=relaxed/simple;
	bh=anxADXLWdSABqbbyohzfwVkWZclF+8wtk9Iwyd0TOu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ATpJc56egvCWX9Amfpxi3v50ao4cKEKq7punGfp1/9b7qXCdVyVduQ9EGSHyQUGzxc47hZVPY8aXwkqBmziW6Vh6OSHGrRIbUntP0CZQ0uprZld13y/M0MDQ3y8edcQGZC0Rj1ZI2bht2U2JaQG+4B2aSKOc66PKpuNpXaQ+DKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcrZh60/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcrZh60/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee432070aso25713255e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 08:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768841782; x=1769446582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=STJgeRyQ9rhOeIpgNqhbFckDIyyYMzqEc78U5iILh00=;
        b=ZcrZh60/lGFoCz45hdlPtEKBYYM2Pyj2RHbXZAx9tMyqU+ITQFkgqZvtGBg0+otXXP
         JP9p8/vKDbpojWQKmFlHzodr0wVJaqrpbjJu13UfgvDxQouhD1FfmGGsD7PjSJvF6BKt
         ja5LSR9S74tMW1pJGDQbZQkIwFkKkmGRDUGElOSzut2UJU6toRtQL6xD4K1YuJ7AQc6T
         9wnG6eCWrlfOZeJwyXrobF9nGEMCf2Fa57e4EI/itpSV8R4oIkvz2GLYDFf3+QAPmN9L
         zpWkUD0XBvE3yhevfm70Ucogd3yVI2991J0hT66JpyWmxeZs1CQpMvoqoUjejZ/ZY3Wg
         MtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841782; x=1769446582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STJgeRyQ9rhOeIpgNqhbFckDIyyYMzqEc78U5iILh00=;
        b=wpchUwQO7lKeiUTOW8GL7cZpSSdFmCYmv4n/jpLwnTpmCM675DPtShFQC6EKQheJpk
         kKEaDGgU6YpwuxsFa0HQN4n4UI4MYvqFPXuQbBf6nwPN/nlKFC+ncwDNTW+KUYxqsaCR
         0rt1NSZWQrO4Jsa0kbWN0Hp08GdOtLIsJN7eIcFKwRlPjY+kNkE9oN2wmuX44R13UiIf
         141zca9yr8hlScwOAiCnmBDyfA/hx+Agig4/wlqXQUKQdo7etg4yX7vVHI77O0rmB1mk
         geFgu3GCm+//1TmlCaKgcyQ+6sosJ1PB35ibCucMVNKn3ltfbMDfd6BmgATffFt/VFJc
         qAMw==
X-Forwarded-Encrypted: i=1; AJvYcCUUNis+Q7kcoUcHtS4Vis+TpMlRmB8zhWXydPvDODAItkeMfcm6ZRuqkmyG+vjalCl948VLXBECNKPL1At/b+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe54oZK03sb48xoKyL5tRVJYutdXUqDwIhcMUjM3PuWKvSyzOl
	oJ5KRXXzq99XblAiaenKp+K747LsfZIFskRsHJEAqAl3QG1NepLxEyJHlb349Xin/p4VGdbwcA=
	=
X-Received: from wmpl26.prod.google.com ([2002:a05:600c:89a:b0:47e:dc0c:276f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c28:b0:45d:f81d:eae7
 with SMTP id 5b1f17b1804b1-4801eb109e0mr143811185e9.28.1768841782028; Mon, 19
 Jan 2026 08:56:22 -0800 (PST)
Date: Mon, 19 Jan 2026 17:47:51 +0100
In-Reply-To: <20260119164747.1402434-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260119164747.1402434-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=ardb@kernel.org;
 h=from:subject; bh=ntHgf/B5rJ53w9Bpw1t4lvz9osH4/R661+iGUCVVrMg=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGluYDWjUrFAokWqtXDSeMp+fXT75fRWyZSWbI99Ms6WNd75g
 4h1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmluYDUACgkQMG4JVi59LVxCrgD/Z9M5
 i4NwfvsUUSXv+UZafROf6v5ISFsyVqAdG/yUKToBAI84KHD/NB176E35kaZByGlx6nYy+/owAfj bvWNO+8YO
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119164747.1402434-9-ardb+git@google.com>
Subject: [PATCH 3/4] arm64: Move the zero page to rodata
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The zero page should contain only zero bytes, and so mapping it
read-write is unnecessary. Move it to __ro_after_init instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2a18637ecc15..d978b07ab7b8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -68,7 +68,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
  * Empty_zero_page is a special page that is used for zero-initialized data
  * and COW.
  */
-unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
+					__ro_after_init __aligned(PAGE_SIZE);
 EXPORT_SYMBOL(empty_zero_page);
 
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
-- 
2.52.0.457.g6b5491de43-goog

