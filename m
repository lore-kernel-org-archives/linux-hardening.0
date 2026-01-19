Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD426205E26
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841783; cv=none; b=IHYTAYU6FllcLXZtWtX8MB1H5zAlZfzy934sMZaCDaVeBmUENVv9PjGaTJM7l6nRnLFA+d4XK+djN9p6y0YR6CA1i75ecowqm+v7KXo7bdQpDOjaYK4H4hjcZCAY9VMVZpmclaXZnL7e21p3aYTmgz81AskiOMmlLq0AguUppC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841783; c=relaxed/simple;
	bh=oSLjBzTnXVDAP/mRF3nvEwY1etD3IWQlp28E/rtnbJE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OtCXy0/P6fiDhgkVvrkgiCAQD+jSdVfGeibDrUW3aYxmbo9RdiDtfIru37JANsXTUGiuCr8yIpPkzdmg3UAEsDBUDE0W0QQbKO8tC4EtMyAxbePCXBkJJRBIs4UFZbzfriof1k+SO8vBBiLguaOrymbutW7qcxO9FxMzeBQWgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAD1hkpd; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAD1hkpd"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d4029340aso42216285e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 08:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768841779; x=1769446579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cqYx/rmicLVCTzWxpJX94exhCZFDVHuQzS79ABnXJGg=;
        b=CAD1hkpdsxk/jqcW0Lb51JdO3Co63PJKo2CEByA+fNb6SapJaCm1h/kHN5kEarF2ig
         hugdd2VFCuZqG+Zv894aumxvq35Acgb5ZyJfrZOgs2FYlloI/4me2lLEkjCwp0we913Z
         sn01FBnsDIZzk/In49CB+B3CfOQ3eaQ220vMYHHMW+zltt6YJPx+YDoMuaMcLpyd3wX8
         fwvStK+rg78Ig1pkosu3kjb5WORQUrCA7+52okUZB61ILG2ZJbtwl1LBhb5rwU6YZLvE
         +hdFHjDlLvrrcf+zG5x0dSyWd+uhGpojEJEnfSSNcO9TJS+o2P5H2rQr9CNfXe+bIclO
         w1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841779; x=1769446579;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqYx/rmicLVCTzWxpJX94exhCZFDVHuQzS79ABnXJGg=;
        b=nB7BlGKYXJMHt+bkbloUSclsjGN5jLuo+3By74UuxZtgD96QxMKCruzXPjUNUeiGk9
         mN06560rJnpJxJb6OhhC3kf5Kb9WuSUtKoFbpXeWNV3siAR5paFQvKthQRfLmnhnXCEt
         TfhAe+IS6fdZxDKjZe2/sIn1hgCCM7NUaxQrqU7BGiWdexKu40o+C+Gx32+8YKfP4eS2
         JXVA7qk8QT13wUYID/lOf+yvnfBysjGzPzx/KnGpzKiXvER9tDiOWdGYrR3pbg/U3xUe
         mawU9BlUTCJZCCGyY0WIc15bbHKKj6ZXhPdB4Wvr+yRrbdOXaWDamnGNM0tpeCUIX+Cy
         C1zg==
X-Forwarded-Encrypted: i=1; AJvYcCUlNdczfu37VJ7HdGfeUYppoEva0hmDWYYW3RUpiBaBwSwaRel1k08u92xH1G869P/k7yZ6zbe4v9UlOe+gSkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYv1yofrVJ9GqjrFzWTQHej5JXD8WGdzHfLKhuk0DoensYSHGK
	A9bD9/5jiDwnj7/eOyIbGIvihLsapMQ8d0p7rPRQ+TQsKmfNWsAnXTdgGBIv+iMH/HFt+CADFA=
	=
X-Received: from wmig10.prod.google.com ([2002:a05:600c:140a:b0:47a:9f70:c329])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4ec7:b0:47d:4fbe:e6cc
 with SMTP id 5b1f17b1804b1-4801e30dc6fmr154183145e9.13.1768841779319; Mon, 19
 Jan 2026 08:56:19 -0800 (PST)
Date: Mon, 19 Jan 2026 17:47:48 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=ardb@kernel.org;
 h=from:subject; bh=aFXAYxFLHefKQqOMkpCoaUbNGK1uxu0eQnnDcJ/NvoE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JITMvweTYbSPzwrLd/e/qIuLfxspVdrHKTL2+/cGLWbINU
 ed+73jdUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyrY6R4f8C0UfLDR6832Q5
 VyOtPjGKTy/0y17zdTfu9Mid3r5p2nJGhuYM00svCnPqyzX1nITWXT15gH2dQ8jJ9fOfe0/ewmu UyAEA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119164747.1402434-6-ardb+git@google.com>
Subject: [PATCH 0/4] arm64: Unmap linear alias of kernel data/bss
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

One of the reasons the lack of randomization of the linear map on arm64
is considered problematic is the fact that bootloaders adhering to the
original arm64 boot protocol may place the kernel at the base of DRAM,
and therefore at the base of the non-randomized linear map. This puts a
writable alias of the kernel's data and bss regions at a predictable
location, removing the need for an attacker to guess where KASLR mapped
the kernel.

Let's unmap this linear, writable alias entirely, so that knowing the
location of the linear alias does not give write access to the kernel's
data and bss regions.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Liz Prucka <lizprucka@google.com>
Cc: Seth Jenkins <sethjenkins@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org

Ard Biesheuvel (4):
  arm64: Move fixmap page tables to end of kernel image
  arm64: Map the kernel data/bss read-only in the linear map
  arm64: Move the zero page to rodata
  arm64: Unmap kernel data/bss entirely from the linear map

 arch/arm64/include/asm/mmu.h    |  2 +-
 arch/arm64/kernel/smp.c         |  2 +-
 arch/arm64/kernel/vmlinux.lds.S |  5 +++
 arch/arm64/mm/fixmap.c          |  7 +--
 arch/arm64/mm/mmu.c             | 46 ++++++++++++++++++--
 5 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog

