Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EA7241C8C
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062364; cv=none; b=gRq1ez3fsYN3LDNtHgADFiIJPew5TTJA/PyDpFmdBatvDp+NIFlKe0CYsqk9etCv19y2d3evUbrkRmneh8/XuE4wbucVGpPBHSqptxzFODNux1ltB+e+ITKU+Bn7PKMmnWbxrDMgUfIIbTAc9HjrSJj5oJpRV8+bYNXpcy1qFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062364; c=relaxed/simple;
	bh=qzHxEWTQUowU9JyBpIleSksX3kOfPSpORtiEeE9vrLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CM/xTaUxaKu4lR1BHbBHr1y+n7/RE5ZFjuUnlrdw1WTSFdb+2XGr8v/I3hYa90VFgeamnbjdc/uINPbedTLdanC6u94m/sIImEEN4SnQZW0TV/H6sd4AFtYku5plrM+xXcMsDldjcjWiLMJ5vrIUQWyGF9U+hilNzB/yHLYivYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JNpG2ISg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JNpG2ISg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7A7419F0;
	Tue, 18 Aug 2026 07:12:37 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DD243F85F;
	Tue, 18 Aug 2026 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787062361; bh=qzHxEWTQUowU9JyBpIleSksX3kOfPSpORtiEeE9vrLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JNpG2ISgeXbDU6EHIpC4+0vrtGwt76HzvdOMWRTJAj6NAn7AdafCVjI4bRyLdR7jT
	 k0/aB9/MNBOsf6E2gupjWaYFBzzW+O89e7lXJGf/Vb9TfdYxpuKtLVnJZvWZKkn3nZ
	 iJXjQ8INUF17DzLw/BKXa+K2MQVeJX1Puvb4yHLQ=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 18 Aug 2026 15:08:58 +0100
Subject: [PATCH RFC v9 16/25] arm64: kpkeys: Implement
 arch_supports_kpkeys_early()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-kpkeys-v9-16-743ad31b2c8f@arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
In-Reply-To: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787062276; l=1895;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=qzHxEWTQUowU9JyBpIleSksX3kOfPSpORtiEeE9vrLo=;
 b=1nVIMH/i6iHZpxUI1TCtH+LBvwdmacwViJE9z2ALy5M+p9gUos6coUDPLFQlFXAV0qE9Z2b7Y
 PCCxFd0xpn0BsMdhASbsERLqg0Gj0WrHKqUQ04TKHxLK06yo1rCDmho
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

We need to check if the kpkeys_hardened_pgtables feature is going to
be enabled very early during boot, to decide how to set up the
linear map and how to allocate early page tables. This happens even
before boot CPU features are detected.

Implement the arch_supports_kpkeys_early() helper by directly
checking if the boot CPU supports POE, if it is called before boot
CPU features are detected. It may also be called later, in which
case we simply check the POE feature.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 12 ++++++++++++
 arch/arm64/include/asm/kpkeys.h     |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a57870fa96db..37aae60c2d7f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -1085,6 +1085,18 @@ static inline bool cpu_has_lpa2(void)
 #endif
 }
 
+static inline bool cpu_has_poe(void)
+{
+	u64 mmfr3;
+
+	if (!IS_ENABLED(CONFIG_ARM64_POE))
+		return false;
+
+	mmfr3 = read_sysreg_s(SYS_ID_AA64MMFR3_EL1);
+	return cpuid_feature_extract_unsigned_field(mmfr3,
+						    ID_AA64MMFR3_EL1_S1POE_SHIFT);
+}
+
 #endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 09fd5a849cb0..284039e9a244 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -21,6 +21,13 @@ static inline bool arch_supports_kpkeys(void)
 	return system_supports_poe();
 }
 
+static inline bool arch_supports_kpkeys_early(void)
+{
+	/* POE is a boot feature */
+	return boot_capabilities_finalized() ?
+		system_supports_poe() : cpu_has_poe();
+}
+
 #ifdef CONFIG_ARM64_POE
 
 static inline u64 por_set_kpkeys_context(u64 por, enum kpkeys_ctx ctx)

-- 
2.51.2

