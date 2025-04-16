Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB222154C
	for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826729; cv=none; b=eq+pycTMT4LjznJF65PYqW1an34FGvXe9hhYFfwTcIiaYHxQcHTRuEJ9wRex+7LwLOSDawO5oeyh3U21XdiExfa4URbyNXE0IHkBXYUppGzZJxxaCk5e3YqYhruSXxLpHxAnm4NZgdci0Tp5o58rrPz8ZuXcNO4xkFLKGLABrSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826729; c=relaxed/simple;
	bh=YF46acwvxQZbvh+RKbVxSqYbt3n7AeN8CBy/samnYi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MOI1pMvisIjrpTpReeFhUUAzuVRt23MqRb8fOC6PHKYbMTMRAviNI15bDZgodm5ta0m75RkdKBWEoII8UTThUFu0pS7tTM8cCl8+kNocYzPvgDgdSI7GUgHtLPrQ1qgD2zj87VdhvIZ+jmp4jv6OUQ3/mELT10vWXrVFqoDmssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cC7883lH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cC7883lH"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso5746565e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744826726; x=1745431526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xO8p3wWnMTFzkHmEwWDOeYMg/xjqFsfP9HNTtGIh/qY=;
        b=cC7883lHchJz5AIkmC44j1rVv/r6Bw0NPOcQ1H5ZyOvmAcWVDQbM5vjbnN56z2QpGt
         cthSuDEUo8FNq26kjHgIzeZRqRlGlnZTnuMM83e0uCjjK4gIsqTW8JUvVqxO2M9i6zA9
         1RR8Kin0REtCRasGEQ7s/OJf65oEmFOh4QW1zuoSmzUHpxPXgvlf/fMg7WWPcjndob1m
         inXL26z767k60cOHd/45GA1WqGDkEdskt+tENXh9rY6DRXVvbqm5MP4lo3VZaV1IL3rs
         kNzImyGxAFZidg1rkTaUkAMMm0CYOXD02MvDBIp/UO/AjG1zBDaJ8JeDqCmgfG1yiOGT
         XhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826726; x=1745431526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xO8p3wWnMTFzkHmEwWDOeYMg/xjqFsfP9HNTtGIh/qY=;
        b=wpEqk2Fz9Gn84uOvNHPYjpYHguT7fn/uRwUd9/puiwrBrf8aekaZMsC2AlbiChmM0+
         DbTTfgUKeKyoJlXPaH+a7IpA7PKx7Soba5uDbIVBjkwZjAC7m6oGJs3Xr70xS+vFJQvq
         m4/IfnZJCjoBkV4++7dM3iVbH+/azLYXhhfhjbzdasNsfUiqtdRjTRXOOLbMqmXEkDqE
         8pSawyXVI1v7yUhYiJMCx8WBIHuJyvMXn4UqC+ICfxyBMfHgFronuiGRiNHKZRCXQ9+D
         AldiKf7AjFBQv36mT9en0vZOKpQv+lE/mTKWCmSDV+WghbvMhsKpmbUENF9sguwxjWC5
         Vk3w==
X-Forwarded-Encrypted: i=1; AJvYcCXGlyDbN71hJUFDJfqjNxdbZxaJSK0Ahik6WaJklS+C5qWp6E79aCSPWoRsudrVIp7YXIPsYqGOKD36wQBkpaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmy1WEctb9dHKa1ViFUGlifKTGF+b04po9M7J2PuQILii7lA1q
	XQjFKLrcgPupVS20Dr2PTFgzF4Bez5TWW06LSyBUMSfLesPr7etg9jbsN5oPO+Oww5KCJIcLUIn
	rfTLqpmVELw==
X-Google-Smtp-Source: AGHT+IFu4srZxpATOjlO2rI6vko1n4XKZtERHwJbfnOezh1jE9LHVVBUHBqm8Y3anm1ST1HCKXtYf3N4xz9VaA==
X-Received: from wmbh25.prod.google.com ([2002:a05:600c:a119:b0:43d:586a:9bcb])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a4b:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-44062421bd7mr3209925e9.6.1744826726256;
 Wed, 16 Apr 2025 11:05:26 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:04:34 +0000
In-Reply-To: <20250416180440.231949-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416180440.231949-1-smostafa@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416180440.231949-5-smostafa@google.com>
Subject: [PATCH 4/4] KVM: arm64: Handle UBSAN faults
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

As now UBSAN can be enabled, handle brk64 exits from UBSAN.
Re-use the decoding code from the kernel, and panic with
UBSAN message.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/handle_exit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index b73dc26bc44b..5c49540883e3 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -10,6 +10,7 @@
 
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/ubsan.h>
 
 #include <asm/esr.h>
 #include <asm/exception.h>
@@ -474,6 +475,11 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 			print_nvhe_hyp_panic("BUG", panic_addr);
 	} else if (IS_ENABLED(CONFIG_CFI_CLANG) && esr_is_cfi_brk(esr)) {
 		kvm_nvhe_report_cfi_failure(panic_addr);
+	} else if (IS_ENABLED(CONFIG_UBSAN_KVM_EL2) &&
+		   ESR_ELx_EC(esr) == ESR_ELx_EC_BRK64 &&
+		   esr_is_ubsan_brk(esr)) {
+		print_nvhe_hyp_panic(report_ubsan_failure(esr & UBSAN_BRK_MASK),
+				     panic_addr);
 	} else {
 		print_nvhe_hyp_panic("panic", panic_addr);
 	}
-- 
2.49.0.604.gff1f9ca942-goog

