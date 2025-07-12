Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854D28A3F2
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348260; cv=none; b=tcykAxKv92/QOXiGq/BYvphDzV1yqumbs1eE/QOyJplxAwfa/9F1++Ov4rAGdgeP1bUsoPmTFC8GJBjoHKUlks0EWMoDRb15U+0bwH6yqpV0fvtiHGQjl/YgJRDtr5+dxuorF5Pt44OeZivj2oK4FKwEifX5z2LqVWqkWgMbirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348260; c=relaxed/simple;
	bh=wCgbaKJ61ACWeC0QmnkCLseUhsMC8L7+wxeXnIWlnJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3eN+dFFN91sYNXH8XRfQpIqikltNzwupeKeuClcsgb/HTqRWNMdfWpEPI898V7fPT7M0llf55fVl8NTKaLGwx/khrTK6ZbIIthiJ8/BSKx1OtcFebCrkBuSdIjp1VsYZGx8iCKuQRUJKOMLgyeWgOP+m61tIpZjBkJGjeLy2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5ARnh8n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5ARnh8n"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235e1d710d8so40645535ad.1
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348258; x=1752953058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC13D4sVHiNNxZjAR/OxV6IVQp2YTvGeWMTVnWX84fY=;
        b=F5ARnh8n2NHIVz0NkSgrgaZGt0vpeO81GR1+jXCJ3PRaQDtSbIHDwbIRC9mdx+8TOv
         /nvmNCwuCSdnyKLG9ayApk5oLfS0U96I4Dv9uvkSw3ZGMSMzjKprTTVlochvRJjSqYq7
         BYq+19FVFkNZWvdA7UoPY8DIHUM9sPvT73J5l5zwv5vEigVo/2Kz2GpILhaEIo38ME/A
         1Zw673ezOGmaOiHO1xmEKjCi3XwZ4QZDF6UwuHG1bWqxY92jsJrK0ngMots6ZcMMOVIY
         FqVK2iVtBaS5ZXGQm1x1Uw2oO6F4jKevJ5R5nHBAtPIvod377cArvEoQu+5kIgk8m1kq
         Y3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348258; x=1752953058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FC13D4sVHiNNxZjAR/OxV6IVQp2YTvGeWMTVnWX84fY=;
        b=KMFrDMSYmnvJ+2YvNl0gWdkO8jPj4d8lTxVUG0RTJa3FY2hsuydR3R8I5+rE4l5vTO
         ekBnLwnl4uy50/TLdn76HPLXvKlDWPg057kAxZozKBCrEBZboJKiTNY2KgJy7VwgPNhr
         JggU6Tjou9XotuBnNdEgcdQQtfJmtULyXK/UIjqoftyzUKRXs7Rvsqiq8rYAjU4LDEC0
         +9RzOalOT+rhHyP0PpZxa9AND84qLR5ruJLbcxPfWrLnbiKg/Mb/sqA0WJTm/aqGPyod
         cWg+Z8mlnsSqpd2YKzV3GF3fE8+tK8xijnt6p2vwiv16ccxGElR64QqEndmcJLKnnF5/
         8k+Q==
X-Gm-Message-State: AOJu0YxKCHh5vUewI+EneLjt9xIz5ElM7DVzvT4ifj3Abocvbi4VYkG1
	r1YjYo1MJxO88esexcVYPNrw17vs9j0uqlEeZkanZhwAdsLIQRZCXFPFKNv0O6wR
X-Gm-Gg: ASbGncvv3dvUORq2cjfghFDa9Out9kRW4g9oz/G3BVhxZw/gEAmh4Y9JrERILYzjNcC
	O82/IFUYH7UIaK1JhE6rGADrHdWw+NM6I5FejXJHihhyx5PPIekKfKv1oNa3ugXa8sxD6nB6Jge
	vnG3lVzAEGFTkUiU76cd5eX7XUfWVQ+S5TKUbU8xoC+J062dAhdJs/o5kkZxL3X6nMVe1hEETV/
	SsewBFtN1rUKPPy72EG6YKP+3Mkhhngo4eNm6KuEGQpmvdlq9HyavyEBBt5BYrOgBtbwpywYPdg
	gZSH23+A4HFOLc6zCnhhdPsC51HUg1squ7ty1Mu2ezZfEEeALnxiwFrMHreUilC2U5uS8R3lFNt
	9ebHPhUeqc3DrhNYWRF4DpLJm413lCUUE5if43UErYiyR
X-Google-Smtp-Source: AGHT+IHyrQ+T0izEYQhQ6UUmRmYI5EFooovG79rz0iAFqcpm/xISXuWyVKAYeppq74ZVEDR8kCWAlQ==
X-Received: by 2002:a17:903:287:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23dede81dd3mr135860015ad.32.1752348258419;
        Sat, 12 Jul 2025 12:24:18 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:18 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 07/17] gup: add non-caching get_user call to fault_in_readable()
Date: Sat, 12 Jul 2025 19:21:52 +0000
Message-Id: <20250712192202.707192-8-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Adds non-caching call to fault_in_readable() for configurations with
SafeFetch enabled and disabled readable pages.
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 3c39cbbeebef..69d2d110da3f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2224,7 +2224,11 @@ size_t fault_in_readable(const char __user *uaddr, size_t size)
 
 	/* Stop once we overflow to 0. */
 	for (cur = start; cur && cur < end; cur = PAGE_ALIGN_DOWN(cur + PAGE_SIZE))
+#if defined(CONFIG_SAFEFETCH) && !defined(SAFEFETCH_PROTECT_PAGES_READABLE)
+		unsafe_get_user_no_dfcache(c, (const char __user *)cur, out);
+#else
 		unsafe_get_user(c, (const char __user *)cur, out);
+#endif
 out:
 	user_read_access_end();
 	(void)c;
-- 
2.25.1

