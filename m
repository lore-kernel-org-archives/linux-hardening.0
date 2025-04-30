Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E1262800
	for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030449; cv=none; b=fn/TFsVy+YNws4YlHgbu0t2shlVMHdsni6fVy02rOU+X75m4mxvb8qaD/BJRJei8IzuoVsanCmPFhylKu25rGZpu4zmP9SLIh/AQmKwHVODGmYnNNuvAnSmF5ypAg3juiZzRTrnYP3G2IFNZrXsDs36YhgUg4iOfKqHNlvs90Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030449; c=relaxed/simple;
	bh=nrCPdU0q/z+UhkgAcPbUE7M11/Gu6PDUNNKarNUhmLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGnNwtBDKH3BpdfOc8KHL75flTe7YxxSjJHn4VdQ1D2ifKXTSqN+vBurwCFODwluTH9Qw1//cpOQk/3jZ1BnIdDlnPaBITwyqce1/zOOCj5iPfcgKmR1fIUt99BKk/gGHeM59NQeZyyAjR8qasiBAlzLQPwtRgFSFcfLRvLPIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FptyM7F4; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FptyM7F4"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a07a867a4dso2494657f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746030446; x=1746635246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Cc1UFbHiSntYShVPXAcoplaHQWwRkP8Qvo8LnShWWI=;
        b=FptyM7F4xhy7vDjwYbcoDCzbSjUWJ5ShzjEhPu/pEYOanJD5k1YS2DLzlESU9GarUx
         s/KD3v1Od4U88xZWX1DSpmkO9rO5jffRhqYxWxGPdK95AhDvg4HdqnzV0Pz5pB0pwGpx
         M6yZTFC2NChL+yskF20JyS9WmQRc64gqIZhSRgtyX+ysGeKLPotf1uIJ7xd1De15LpSk
         OolYk6weiM6XNnQbzbIhJfhoM55dHGJJQYKgebW5pVjJby0OX+eXTs/dIDfA2bkqkXB1
         aLq+Gk6gy6W7oMY7LH9B4wLMC9aBkHO1uIGzpKzYawWMr8ZtRHAkWBQXVxp5c7rZtiUo
         Gwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746030446; x=1746635246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Cc1UFbHiSntYShVPXAcoplaHQWwRkP8Qvo8LnShWWI=;
        b=dDv/yJSev4kJej+30JOUj621FiH9EP9Fb1FgbloeFVV+YS3cFspnZFlIsSlu8IEHKo
         41oRVOzIYsHEAuh/rWhZ7hTT7xOjFfSg38qHXrx1qxwABUuCQGYnD0R761meGf3O1jgh
         rAqUbDdKADpFA67XLpO22OttJCqr4StYdT5x+Rcqs87jN8GECLxpAzpAz8gyFT/Tb36s
         ZQV1Rk22VEsZRxpwYi6BXyrSpiYSARJAhlfLhCErYn+5qq6jYalSlJ+8VgG2HMdTZQ4s
         /AJYeGGMv2Ild6FluTfjzRbP4TOEIQfm3pCYWhw/VSSwXbraiI6UJMaeWpy26jhxzUkA
         pLdA==
X-Forwarded-Encrypted: i=1; AJvYcCUox2eVEWpRoaJVwGeAIa7aGWpQxga9/QTl3jKB9aNwZSxoNSxW71wonVDJ29YGThtO+mB3NlD64gLXyMONoDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3lMWYAOwqQp/20wHMK906HAeCR+dNhnNY7NNYxh5vinUruMe
	V/rHkS4PgOTzn3SMHiCwfwmkgQGIzrQTT79fCNeqrmZvSoJiDM7YbRDvu8YvB3lY4yPSkdwfCP0
	iDSbgD8SexA==
X-Google-Smtp-Source: AGHT+IHDzYZhWgLNGxcyelrM4O2AAV3CEZWXJdSJ7SeEaiIFmtJryw2vi0tu8g2u+0VnUpRP7QxKQEtc5Ig7EQ==
X-Received: from wrbfu6.prod.google.com ([2002:a05:6000:25e6:b0:39a:bcee:e7a1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:420e:b0:3a0:847d:8326 with SMTP id ffacd0b85a97d-3a08f777d82mr3895576f8f.25.1746030445844;
 Wed, 30 Apr 2025 09:27:25 -0700 (PDT)
Date: Wed, 30 Apr 2025 16:27:08 +0000
In-Reply-To: <20250430162713.1997569-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430162713.1997569-1-smostafa@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250430162713.1997569-2-smostafa@google.com>
Subject: [PATCH v2 1/4] arm64: Introduce esr_is_ubsan_brk()
From: Mostafa Saleh <smostafa@google.com>
To: kvmarm@lists.linux.dev, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	broonie@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kees@kernel.org, elver@google.com, andreyknvl@gmail.com, 
	ryabinin.a.a@gmail.com, akpm@linux-foundation.org, yuzenghui@huawei.com, 
	suzuki.poulose@arm.com, joey.gouly@arm.com, masahiroy@kernel.org, 
	nathan@kernel.org, nicolas.schier@linux.dev, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Soon, KVM is going to use this logic for hypervisor panics,
so add it in a wrapper that can be used by the hypervisor exit
handler to decode hyp panics.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/esr.h | 5 +++++
 arch/arm64/kernel/traps.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index e4f77757937e..350f02bf437d 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -440,6 +440,11 @@ static inline bool esr_is_cfi_brk(unsigned long esr)
 	       (esr_brk_comment(esr) & ~CFI_BRK_IMM_MASK) == CFI_BRK_IMM_BASE;
 }
 
+static inline bool esr_is_ubsan_brk(unsigned long esr)
+{
+	return (esr_brk_comment(esr) & ~UBSAN_BRK_MASK) == UBSAN_BRK_IMM;
+}
+
 static inline bool esr_fsc_is_translation_fault(unsigned long esr)
 {
 	esr = esr & ESR_ELx_FSC;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 529cff825531..224f927ac8af 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1145,7 +1145,7 @@ int __init early_brk64(unsigned long addr, unsigned long esr,
 		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
 #endif
 #ifdef CONFIG_UBSAN_TRAP
-	if ((esr_brk_comment(esr) & ~UBSAN_BRK_MASK) == UBSAN_BRK_IMM)
+	if (esr_is_ubsan_brk(esr))
 		return ubsan_handler(regs, esr) != DBG_HOOK_HANDLED;
 #endif
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
-- 
2.49.0.967.g6a0df3ecc3-goog

