Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE07264F99
	for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030452; cv=none; b=DuRnaaL0gKVZAaTbmCJNsW4wDccERkWSGl6MSEgPE0mMJgx65IR7uRZQS8VN+meogL8UArXbR+8Exb/UxOOe5TDFpLrmmmfplIv6K2OGYi/hlgkgeuOx9Jnt9MOarVTC+d1DiLT40o2xiylEl/C5/6QlblUT98ERSyvD5NnkSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030452; c=relaxed/simple;
	bh=GTOg1ysfEG4bdpGS4A571FfqA9HLp7EmYpGHSBXrIcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MpkCO5KtGBe+vWXmEz8F73TQmbYINH6vs2NOPX26jGwCmhGCctJTus1VPyggisweLPUt2mGoe9ufy4PwugDPVwSHTKfbKGzSAJnbFJSTHpRK3bkvw1aRH31H1JJ6DSdCSDB7Cu9WS5DVmj1LawAWSs4pnE9UYOrt5OKSgBvf+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKLphjPp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKLphjPp"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so3258224f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746030448; x=1746635248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=003i/GX+SMhbEk8JM6zOLdGB+5OhPHak3AuWaDpYHh0=;
        b=vKLphjPpkJwmvyo6uVzwsAZvNYttTXkLB+3D/sdywk0oVYVLfDJyypfL9qAFNda8AR
         wWxD53uC3XuHuFH2rOD3xoEci56Rka7JDR/CLvPnkYYF7wvyp65rBWzcu2LZx/nGhaZt
         FcoXoEevE+4tXgn0YWDyRG5cG2AbcxgB3d00bC26Pyctk6avGljZHG4ahP28owfFS6XX
         35csbwwQMRUXTz5oBG7NOUzEDIABeMiIqZjG1XgHHjYUJXVCcglUfhHu2NkSd+Y8/lNp
         galwgB8BTFhGIGFZ85TDBXu8hzDPX79Kf++AWVrYz2XQ2zcSD5xKomBuv/GhSV9/pIlR
         CJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746030448; x=1746635248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=003i/GX+SMhbEk8JM6zOLdGB+5OhPHak3AuWaDpYHh0=;
        b=JFm9k/RgFj2GAP2p4N96pEdS1ulZd3OkSHg9MSdXsGZvdEZLa//6RoHy6nooJmRWyM
         srE6DQEEoASEJ8hp9hMO2AKAoPDowMV1MQglJ1pneDi09RpBzkWeaSkr4GbPxMN6FTVb
         9GkAx04WCPNb2gAZMYsNVfsMmxTopBJUiq7M+qwSYjwOQY9k9PfqKYPeqfU+DS3YX94z
         Vg+xuRuTKtaDPo32AS8Ipn+4xcYWDZtPGnynuy/iBPsozkLTLmu523UcFvvElBVxStiO
         SyiJWJSmpMkLJntSDgAVRiiw44RpbIHU1HNNRKISfltz5fdWPQk8OnWUU2LQa3hO+4cd
         W3jg==
X-Forwarded-Encrypted: i=1; AJvYcCXkojIp4zDP8beMLSUnHNUDm33Dzz+MZspn8abw0USfFDylnsnD3gzG5Uazz03X75pOgIvscFkmZKjwN+WxDZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQGln/Gm3rfXzhU6alZu3KatuHCy9H5fe64vCEmwalhIqq103
	zc6B2xO+sDsxnY44+n4Ne0VgQkDe3AtQqTerDxjCwUGhH1Mm/vZejONX8abWyH5X4+GW3gzu7iQ
	bAPWaxgRXuw==
X-Google-Smtp-Source: AGHT+IFmvlkwLxNmZ9CSFJVW5lMLHM9FQhYVBrEhGonj9gK38XYoJ6Wzk9kIHfgZWiH30GqYlq6Z8FTj6W6gdg==
X-Received: from wryv6.prod.google.com ([2002:a5d:59c6:0:b0:391:4999:778e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:3107:b0:3a0:7af3:843f with SMTP id ffacd0b85a97d-3a08f761185mr3815578f8f.19.1746030448153;
 Wed, 30 Apr 2025 09:27:28 -0700 (PDT)
Date: Wed, 30 Apr 2025 16:27:09 +0000
In-Reply-To: <20250430162713.1997569-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430162713.1997569-1-smostafa@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250430162713.1997569-3-smostafa@google.com>
Subject: [PATCH v2 2/4] ubsan: Remove regs from report_ubsan_failure()
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

report_ubsan_failure() doesn't use argument regs, and soon it will
be called from the hypervisor context were regs are not available.
So, remove the unused argument.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Acked-by: Kees Cook <kees@kernel.org>
---
 arch/arm64/kernel/traps.c | 2 +-
 arch/x86/kernel/traps.c   | 2 +-
 include/linux/ubsan.h     | 4 ++--
 lib/ubsan.c               | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 224f927ac8af..9bfa5c944379 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1118,7 +1118,7 @@ static struct break_hook kasan_break_hook = {
 #ifdef CONFIG_UBSAN_TRAP
 static int ubsan_handler(struct pt_regs *regs, unsigned long esr)
 {
-	die(report_ubsan_failure(regs, esr & UBSAN_BRK_MASK), regs, esr);
+	die(report_ubsan_failure(esr & UBSAN_BRK_MASK), regs, esr);
 	return DBG_HOOK_HANDLED;
 }
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f88b8a78e50..4b5a7a1a8dde 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -351,7 +351,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	case BUG_UD1_UBSAN:
 		if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
 			pr_crit("%s at %pS\n",
-				report_ubsan_failure(regs, ud_imm),
+				report_ubsan_failure(ud_imm),
 				(void *)regs->ip);
 		}
 		break;
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
index d8219cbe09ff..c843816f5f68 100644
--- a/include/linux/ubsan.h
+++ b/include/linux/ubsan.h
@@ -3,9 +3,9 @@
 #define _LINUX_UBSAN_H
 
 #ifdef CONFIG_UBSAN_TRAP
-const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
+const char *report_ubsan_failure(u32 check_type);
 #else
-static inline const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+static inline const char *report_ubsan_failure(u32 check_type)
 {
 	return NULL;
 }
diff --git a/lib/ubsan.c b/lib/ubsan.c
index cdc1d31c3821..17993727fc96 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -25,7 +25,7 @@
  * The mappings of struct SanitizerKind (the -fsanitize=xxx args) to
  * enum SanitizerHandler (the traps) in Clang is in clang/lib/CodeGen/.
  */
-const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
+const char *report_ubsan_failure(u32 check_type)
 {
 	switch (check_type) {
 #ifdef CONFIG_UBSAN_BOUNDS
-- 
2.49.0.967.g6a0df3ecc3-goog

