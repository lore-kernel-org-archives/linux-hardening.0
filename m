Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D830BB97
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419657; cv=none; b=qBDpfMcU4nk0165158UUEeD3vjwdazqysiqvxrU2QsueE7a2oJUDVpVX33Mn3/h0e9ZlFof7nQUrwjEsHIvqqW7f9orZnAXKYToWczJB/yF4hiH+3BttZgEoRD6kIGvMZ2VojskpwlJXjJQY0NN12/80XQrCWIheWgvnb3aMh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419657; c=relaxed/simple;
	bh=/mS5vrpdZEwApyEGgheVcW1Dk9n+fhKrSotOnCaSkhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+/25faYvUbdPHKy6RaRM6zZjhIpDGJS867qK51U63azou1y6Pj0mNVMSne0lmNHv19w6FjdpUIzufuM66z2QgbAkAOvPNCxPfWXAvCfiUKkegSpIw2OgZUo+sbFkMQtEOsNXSQ87Or1+s3/ItEwi/cayimCcmsT2Z5uQxTsg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZD5Y63PS; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZD5Y63PS"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d4029340aso55824745e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419652; x=1770024452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qZ1xUJ54mMbB8pErA6j09+CFNiU+H8FmdGJP4FuLNw=;
        b=ZD5Y63PSeo3WID4PYJ0iTfsSSlRE2VuKdmqHItt0SFRMc0PhJphJBBUwRP9RXU2XPK
         eZ6YvODxKymNIx2aaoyJVRgNrtpI87PlgRQq49/Hj/+NumwhPm5Av3cxu0pWAVOfY5qw
         lW66zAEYM6MV0cZwRxJUDkE1hZ8rAWj8SDFhpwUx8FJOQLU6j0WFAKiB26e0gOVptfqh
         jcwwYa7RXc5OhNdMG7Kj4y8pRl+dTKlohnhYdHHHQdPrTunA7HFQbOGEBmyhwZfyvczc
         QtsqTo0MlgIj66RNjLO4YOzqx1FA8yfnTtx4MIpLrYG2EpxRX3WiEHzRaQElemNqb501
         hNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419652; x=1770024452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qZ1xUJ54mMbB8pErA6j09+CFNiU+H8FmdGJP4FuLNw=;
        b=vBtgkD8ou6w29AYgt0w09dnyqAfIq/7AdZ+vUGkPaJIk1CP2rSPUwdm4FHqcG5Vvbd
         74KTwUoorCbGcoiY7AS2VB+R537g5uRPFwsTupwSikGhku7/mYkVJDUXmaSY4Qn49jy/
         1BxbDjYOfIxmdWaiuy1wKH1beNENO28YMWbIJRLr8E63e3UfMmQVTFbUubXGP6p/1mR5
         UAzwPcgjTiuicTMiHaP+xsXLr3eP/8ufumQGyPInCzE02t5rC16tMTY/J0jkh+AsX9c2
         b7Ia77yz1MAzXKMHqpDla7IGt22BHHp19qwoOLRxaLCXfkS9E/Y1J7y+PIoIzI6NCbdm
         jheQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmrUtcwVn+GdT3pL+da8P+fgOyiYBmEdn2S8iaG2JUENSqtWW8rEnUvMqERiZyEPKwmu/DSF9No95LaH5b0Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfGahop4pK1TK+x11NyQr5hO8Ycg7NZkIBZWT28szjA3paYwC
	e6JjWJO+HvqKa3Rr0oEuP151nNCJHYoX2gPWCzNMUr9oWFfPDXfsIipL8Tw+4FBiMYvepDMBow=
	=
X-Received: from wmjx21.prod.google.com ([2002:a05:600c:21d5:b0:47d:86c6:ebc9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:530e:b0:47e:de9c:92ec
 with SMTP id 5b1f17b1804b1-4805ce4e568mr62717135e9.14.1769419652622; Mon, 26
 Jan 2026 01:27:32 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:32 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328; i=ardb@kernel.org;
 h=from:subject; bh=yjZnKOVkP/d2XQBthJ6Tfy6lESqeO+RAZPKDjSMcLNk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2P3RrmdrBB/NvJp+yD+g/JFb6zYT/Wk8p612/lZou
 XuN0cWso5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkgyLD//JNB8KNeT646Wy+
 JbN44ZlbW3+dtXz0a8nSTb0s7nvXu3kx/LPunPdhadYT+SmCvVP9ZleuVH52kyW33TX8bkZFm5t YDScA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-13-ardb+git@google.com>
Subject: [PATCH v2 01/10] arm64: Move the zero page to rodata
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The zero page should contain only zero bytes, and so mapping it
read-write is unnecessary. Combine it with reserved_pg_dir, which lives
in the read-only region of the kernel, and already serves a similar
purpose.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 1 +
 arch/arm64/mm/mmu.c             | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index ad6133b89e7a..b2a093f5b3fc 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -229,6 +229,7 @@ SECTIONS
 #endif
 
 	reserved_pg_dir = .;
+	empty_zero_page = .;
 	. += PAGE_SIZE;
 
 	swapper_pg_dir = .;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9ae7ce00a7ef..c36422a3fae2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -66,9 +66,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
 
 /*
  * Empty_zero_page is a special page that is used for zero-initialized data
- * and COW.
+ * and COW. Defined in the linker script.
  */
-unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
-- 
2.52.0.457.g6b5491de43-goog

