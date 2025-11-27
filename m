Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D959328B5C
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235384; cv=none; b=If2ycDaqKqKDHRW0GW5hGtc5isSD8XG6kY6lGDDd7xIZX68iI6PZKbfjQVCdwUo/Mk8eH2ZapCX3n7H4envqKlTRaJSUmZUGaKztwBdCUurtQlNkkZ3WH/Rb+D+rM2gWVe5xx7TGDXDOu2dGmQx1e3xUTfTUgTYLDya280Ez6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235384; c=relaxed/simple;
	bh=9G3bFsH+JBVhTmjQAmKXBaP5hiXW4+Cp+p5cAJyH2SI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g/+8kHZ+Ylkpwe7yM7AGh2bPA9jHnqc20sBRSt/s33Ac4S5JzTEobjq7Qdc0w+/6UI3cKbwdVSmlY3w9y8ZhY0K9hkBVQ5rXw3M25utjX4caDGMsnMl6drqxOLkJFcxDi9Vt8W903uSD9IdWuAsAtn9u8lW3EzNKn3hhKbMHkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWVZqUsO; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWVZqUsO"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso3382375e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 01:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764235379; x=1764840179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUL0bXq8chbknjAsMuUQFU4e6lGXKM8WYzXlQLV3Sa4=;
        b=NWVZqUsOBszDPPbkTSBUgPoVErlgHtq24SjH36cDGhcgDzJspm0ObX4fipQFprwJ2u
         qmRyXRzd7++ENr+MJGV9FAiO7aPQFvNWw9UPDxijZxFudDO0pPL/LJLL3VX5Q6oTI8dv
         ftxwDDXzhclruHzFIs0ZSNrpfMBax2LgeY6FCjzhKl+v0s8Jw95fgWJaoWyz2t6i+ThP
         TaUXwexS2BvuItkI7q5S4RJ7LLb/DxvB9vbQ9lIo43NLUaDdvP4AUi+XvXtj96xQTF9/
         y/pvDcdCmAJJyfhm+gnCVa2JAlBbv7krSxZw3fw4INVADWmA1aiC70BiKbJGf7aLtqHv
         hVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235379; x=1764840179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUL0bXq8chbknjAsMuUQFU4e6lGXKM8WYzXlQLV3Sa4=;
        b=UxKDoRhFG7uAAkZ1//lY33wQxpa/dIUXC+5bmKYpcTUKKE6CtLcNjsTa9KdYBI1DCE
         ElvehsBnrJLXD8OPhEnV7xE78QQiMgQ+QUJBbZ5DvTRz0BOAMvF2V4tcbUE2tfCVWNWd
         OMN1DTclvtG0w/mbb2YEW9EQOYKGUPKb1OZDa5lByZaPhCDXajw/s5ObFEz9Xwqw4UFR
         gSm+inaONd+tzJEg2LVZ4HXLVdGnFE+jfV4yjSu9Bha+BFAsAqweh7ketpSwIy4Al4ce
         +6C9/E6dKj7oLBC3giDAZywxCi1revzXGV/01WHPpcgEz4vFSMmPfyBzZRCBXADvuC3Z
         4Gvw==
X-Gm-Message-State: AOJu0YwEKAaDnMN+IPs4kWLfY4FuOh//PKNm+3Dl+kNVj+6jahve53ah
	m/cyZHr/PgOeuBKqug8ZIss3roLzWobKfVHzjbjcnbg7VzAwFsw3FKcLI1zwNSY6RV45fSvSatg
	Q1ZPENB2LLJyIzeHEBbqoLhzRqDPCt5jCRw5a3KogLlnNB2fUrfNmeVNnSWRpZsrSLX4iStozoA
	LfUogAxxr1b5Kyg26V1dQ1jiQWyCPxOLviUgH16g==
X-Google-Smtp-Source: AGHT+IEj3dusT3MDvpMgsbHZIfe/XZF/uYEQTBHV/zXh1M/+kIcSqUep12/hQYGAypuqMk42bH+W9Glh
X-Received: from wmri12-n2.prod.google.com ([2002:a05:600c:8a0c:20b0:477:9a28:9ea7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4ed3:b0:477:b734:8c22
 with SMTP id 5b1f17b1804b1-47904ad05bbmr93756915e9.8.1764235379306; Thu, 27
 Nov 2025 01:22:59 -0800 (PST)
Date: Thu, 27 Nov 2025 10:22:33 +0100
In-Reply-To: <20251127092226.1439196-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5832; i=ardb@kernel.org;
 h=from:subject; bh=8GaMUTgdagAMtzY89sbLAS19s1WTGVeC8Lgqk53nbS8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVNDImbL21N8hQ7vpnw54rsvfi1f31pm9QU1E1ScxBx79
 eeeOqXQUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACai6cHwTz1Igemqx8v3z7Zv
 10zom521SvxatNkqR5cSmfPekY8+nmFkOKutlWi8pZ79TQHDv40xK48GnP8TPXNRmZZEU2Ppcpt tHAA=
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251127092226.1439196-14-ardb+git@google.com>
Subject: [RFC/RFT PATCH 6/6] randomize_kstack: Use get_random_u8() at entry
 for entropy
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-hardening@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The randomize kstack code has a couple of sharp edges, which are due to
the fact that a counter was considered more suitable for providing
entropy than the kernel's RNG.

Given that kstack randomization only requires 6-8 bits of entropy,
get_random_u8() is more suitable here, and its fast path has been made
lockless so that there is no overhead beyond a preempt_dis/enable and
a local 64-bit cmpxchg() to update the RNG's internal state.

This means there is no need to defer sampling the counter until syscall
exit, which also removes the need for a per-CPU variable to carry that
value over to the next syscall on the same CPU. That works around some
issues identified by Ryan in [0].

So replace the use of the per-CPU variable in add_random_kstack_offset()
with a direct use of get_random_u8() for all users, and turn
choose_kstack_random_offset() into an empty stub so that each arch can
get rid of it individually.

[0] https://lore.kernel.org/all/dd8c37bc-795f-4c7a-9086-69e584d8ab24@arm.com/

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/Kconfig                     |  9 +++--
 include/linux/randomize_kstack.h | 36 +++-----------------
 init/main.c                      |  1 -
 3 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 61130b88964b..baea154f833e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1520,12 +1520,11 @@ config HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	help
 	  An arch should select this symbol if it can support kernel stack
 	  offset randomization with calls to add_random_kstack_offset()
-	  during syscall entry and choose_random_kstack_offset() during
-	  syscall exit. Careful removal of -fstack-protector-strong and
+	  during syscall entry. Careful removal of -fstack-protector-strong and
 	  -fstack-protector should also be applied to the entry code and
-	  closely examined, as the artificial stack bump looks like an array
-	  to the compiler, so it will attempt to add canary checks regardless
-	  of the static branch state.
+	  closely examined, as the artificial stack bump looks like an array to
+	  the compiler, so it will attempt to add canary checks regardless of
+	  the static branch state.
 
 config RANDOMIZE_KSTACK_OFFSET
 	bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 1d982dbdd0d0..db1f056e61ec 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -9,7 +9,6 @@
 
 DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			 randomize_kstack_offset);
-DECLARE_PER_CPU(u32, kstack_offset);
 
 /*
  * Do not use this anywhere else in the kernel. This is used here because
@@ -50,49 +49,22 @@ DECLARE_PER_CPU(u32, kstack_offset);
  * add_random_kstack_offset - Increase stack utilization by previously
  *			      chosen random offset
  *
- * This should be used in the syscall entry path when interrupts and
- * preempt are disabled, and after user registers have been stored to
- * the stack. For testing the resulting entropy, please see:
+ * This should be used in the syscall entry path after user registers have been
+ * stored to the stack. For testing the resulting entropy, please see:
  * tools/testing/selftests/lkdtm/stack-entropy.sh
  */
 #define add_random_kstack_offset() do {					\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
-		u32 offset = raw_cpu_read(kstack_offset);		\
+		u32 offset = get_random_u8() << 2;			\
 		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));	\
 		/* Keep allocation even after "ptr" loses scope. */	\
 		asm volatile("" :: "r"(ptr) : "memory");		\
 	}								\
 } while (0)
-
-/**
- * choose_random_kstack_offset - Choose the random offset for the next
- *				 add_random_kstack_offset()
- *
- * This should only be used during syscall exit when interrupts and
- * preempt are disabled. This position in the syscall flow is done to
- * frustrate attacks from userspace attempting to learn the next offset:
- * - Maximize the timing uncertainty visible from userspace: if the
- *   offset is chosen at syscall entry, userspace has much more control
- *   over the timing between choosing offsets. "How long will we be in
- *   kernel mode?" tends to be more difficult to predict than "how long
- *   will we be in user mode?"
- * - Reduce the lifetime of the new offset sitting in memory during
- *   kernel mode execution. Exposure of "thread-local" memory content
- *   (e.g. current, percpu, etc) tends to be easier than arbitrary
- *   location memory exposure.
- */
-#define choose_random_kstack_offset(rand) do {				\
-	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
-				&randomize_kstack_offset)) {		\
-		u32 offset = raw_cpu_read(kstack_offset);		\
-		offset = ror32(offset, 5) ^ (rand);			\
-		raw_cpu_write(kstack_offset, offset);			\
-	}								\
-} while (0)
 #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
 #define add_random_kstack_offset()		do { } while (0)
-#define choose_random_kstack_offset(rand)	do { } while (0)
 #endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
+#define choose_random_kstack_offset(rand)	do { } while (0)
 
 #endif
diff --git a/init/main.c b/init/main.c
index 07a3116811c5..048a62538242 100644
--- a/init/main.c
+++ b/init/main.c
@@ -830,7 +830,6 @@ static inline void initcall_debug_enable(void)
 #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
 DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			   randomize_kstack_offset);
-DEFINE_PER_CPU(u32, kstack_offset);
 
 static int __init early_randomize_kstack_offset(char *buf)
 {
-- 
2.52.0.107.ga0afd4fd5b-goog

