Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D9404BC8
	for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116554; cv=none; b=H9PpQLrfORCUyi+r9VPV4AfDXOTEjkxM46OqiD/q+4rcMvG0ijDAbCVOysZSVtuVlp+u32MUuuDxcd2WcCR1upo2bve0MgqZKc7B2KLqPG98EmMV5kJq6Xe+4NdBpZJw9HU6BIXTvcbLMZqioKndK5le1W11KnG2PsPCCSNhrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116554; c=relaxed/simple;
	bh=ftsPX/fDZ63mdRI0VYix5XzvXzGHoQOQqLssy3pY5d8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YRcyxbXB50eiD/BqwPJo5LQGXz0CVsC8UB2iIzVDsvW/Q8Gu6MLWF0vDRQ9nx2/nhMb5rLrhllMft7vA30tG6k1zFiBy8eXZIOln14XyNwjLSaZktJanxhMcq/9wfMyiLxU90TviqreBEK/xeIcuDsooRd75GhnE/1MbAH4S154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=do96jpRk; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="do96jpRk"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd667770efso15292555ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790116542; x=1790721342; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GRxp3EYFeG4RHE5TRXwDLoJws/VabvUKmMB/dI5TDY=;
        b=do96jpRkvtAMnkEyu4hJx178R6tNsgIIH6XYZDOuqoupyoyoC3Rc0xchEI8yA23l1g
         K8+rv8OyCwHk+IpwrGQcDbwMRsGC5+36Xxmo0dCWsnCPSRXjyaEOXmWAJ9Apo/T31D2r
         uGA93azynXbec/I5GqbL2u8D+leJRWBDMloP5rNksUNRgkzeLX/8QtCQyVTNZU/r3pzU
         Iu4kHXhq6ZUftr6EiFJOqHqD/Ta9GU6wEaszOP6YJpUF3Jqa46ljsaLpk16vXWhXYWpm
         7rLQOB3Lh19oFmAgJwMZQFIyqYG6ciFs93yqW43iEb+4RchWCs4si4bFh0tksh7k5Bu4
         VO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116542; x=1790721342;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8GRxp3EYFeG4RHE5TRXwDLoJws/VabvUKmMB/dI5TDY=;
        b=v8NhdMzXyk7WE8zVaTRHW9AJvbkAl+ujdQtkr+hV5YAAeVr3oQqju32v3/PY+OJP8z
         MteuBN+yz3N72O8+RoUN7tlAlQSlsY0v54mzY/r8NbUhBT4fzSISJdGTWgCvtx/ZPvid
         L0TypWiuKjmcEjvRIuHIz3UzKnXvpO1BhklAdNQHg7u1dH8/Ljw4y7Vt1wmqGzgRi191
         iq+FnBrSYlFSfB8+Gw2F22OX5dOHligdzSNWmFGVtVJswldgPrjHd1VlN08MvKipSZCf
         upQspfKDKaq/tslflRF/433MsiC6aS5AuKyvbv2a0JO24oBm0VGE6AGiX5ACg612WQpZ
         svnw==
X-Forwarded-Encrypted: i=1; AKwUvBwTOve9F7GPkoYA/NmBkJI9Ciwg8Oxu2Jfs1LOQS/qZPiZZ9DDy7i2KozoE3rEFP8+2v0NSMpavPBpIfaUgG5E=@vger.kernel.org
X-Gm-Message-State: AFuF++mVTzPLevadyLHh2gr47qRY6geO2PFZQ4WhE0atVNcqpr87h4Dv
	k7pezUov08D/XaXZiO+JcVzFz1buWP2euWQsa7ISYUTQGXDrR5yM4xqy04WVSUaI2sOhm95JzIs
	H
X-Received: from ploc2.prod.google.com ([2002:a17:902:8482:b0:2dd:53b8:ff02])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ec3:b0:2df:69d4:86bf
 with SMTP id d9443c01a7336-2df69d4884cmr5081645ad.11.1790116541866; Tue, 22
 Sep 2026 15:35:41 -0700 (PDT)
Date: Tue, 22 Sep 2026 22:35:38 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922223538.2287676-1-morbo@google.com>
Subject: [PATCH] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

The GCC and Clang compilers provide the __counted_by_ptr attribute,
which is used by KASAN and compiler bounds-checking to detect
out-of-bounds accesses to pointer fields.

In "struct fsl_mc_io", the "portal_virt_addr" pointer points to the MC
command portal virtual address. The size of this allocated portal in
bytes is tracked by the "portal_size" field within the same structure.

Annotate the "portal_virt_addr" pointer field with
"__counted_by_ptr(portal_size)" to enable compiler bounds-checking and
harden against potential out-of-bounds accesses.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/fsl/mc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index c25f0f7e6dd4..0b2c0eb9b605 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -336,7 +336,7 @@ struct fsl_mc_io {
 	u16 flags;
 	u32 portal_size;
 	phys_addr_t portal_phys_addr;
-	void __iomem *portal_virt_addr;
+	void __iomem *portal_virt_addr __counted_by_ptr(portal_size);
 	struct fsl_mc_device *dpmcp_dev;
 	union {
 		/*
-- 
2.55.0.1082.g2b9226bbc0-goog

