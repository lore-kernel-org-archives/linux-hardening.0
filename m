Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138062;
	b=kpeu7sHcy0uQ/jPnMfz4LnNRHHGLbyhPSXMi3Fn84I154jVoWDMMLbs04wixnT1G0Lkf
	 SqnqlhAz+24CnZkqAAk6he3Sr/8fnLWY3EaJUJA1c490Qs+OTmgQgzZHmVOQgWGmQqoPS
	 t58wld9yzckWSWmFarOq9Wm9jd+2I441y0z0ZZ+2BOp5olYoyOtRRqxLisal5lO5eFV3f
	 9FeUvwpMh4f1a6yCEgG+dZApsu6NOAdAkwgNwAov85C/t5I0H5YK1SRCPfXzDO81AIGVj
	 OmV1CHhOIv03kqNizAuWwO3Ix9nQkucLIylf6hTITdB8HFG9GeLiQPCTk3M8N6rKvsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EF5wU7SnLkB3Z7MFnGG8YsbHorP52SZH7LAJX4UAF2Q=;
	b=ey4xSI6Dnlfj8Kzm/oAEzm3epmfyXF1Q4OZV65mvcHSPqhZyCks6aYHSL8bDIAsdwrmW
	 VlEyYOfBSqkba6tZAlKzm+ovz5c+Sp+Haqfafes7XGg7i3Q6cHTD5fZblwxEUwx/BI6wm
	 JPmyzR0620h6lsGRyf2uufMui1czBx3ZS0z4QJU4IJblYzD/llToruro6GZ0EyYyqqrJ8
	 JxT+wm7X7+c45mBIEWJ03klrAhDvovMtdMZ5huh5gbSPLhBiUDjWQV3zrORlUCdgLcb+K
	 tACqZmKV2ajQ6Vbfz9Hu5PaNB3BL8E3hZRKzv87gehe41bEARCtpSFRMRjgoCc6jIpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8adbuBz;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAC2606A31A
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 21:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAAC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8adbuBz
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso221109f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793138060; x=1793742860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF5wU7SnLkB3Z7MFnGG8YsbHorP52SZH7LAJX4UAF2Q=;
        b=m8adbuBzOgK4r0QFNkLUTl6069rJPOpQJVDZnYSMLCMYY3YGgOut4Ijs6oUuje6DGK
         xdc2u7a6xuG3E+r0Y4cf+3D/71o38BnN9hDZJyivOTCIwfC6SrfUext6bHxYMuLP7GrL
         pnsoI6rqnWC1E994RF5qq5DKB0UMsV+zS57d4eAESaq7eq+YMvFpTqtcaMdrUEHNAUcr
         yyhF4d251NaGb9EcSyPsEKsUrE4rc4TjowrI9r0ZADK4XtMdOHC6XzRy76I73gJCgUIS
         aW134zdH9H8DUyhADMr7GB9VzRe39TygFInPJNe7HDIHxMAgJ9yOkbV5Avr+U5qwLpqm
         8toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138060; x=1793742860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF5wU7SnLkB3Z7MFnGG8YsbHorP52SZH7LAJX4UAF2Q=;
        b=iaI7CbGFWbTdJwsCgEDWscMw+Hp2Fj5QqvB3boH9dJPiCap8rRhwm31REHngGpSCZt
         EWFqbq9nJS1UXJvyUKeTSORl23uIQDAzNBYBqfv8w5aBF0V7SEJEZvQ5QPBWsCDHBBne
         GOCvmQvo/meo70uJfg2deO4CZUks3YrMrgo72Sby/amdj/eRdU31vGBJxyldP4ZJ+mfF
         G8Z8fxMt4iUk1Sk6m1+OGqXmaHKHKDzuPAwZea5y5OyPAsVSbHiagFh2NWXqKRgQpIUq
         RFvEsXFS1bvfYUOaB7Iv7E9Xk7wJg7Tr7btNrF7+JeCnspQZ7iCfZF3+xfj1373jpY+d
         jARA==
X-Forwarded-Encrypted: i=1; AKwUvBwIQXXg/y6YPZiWWfKeaepYC3km1kCZoeFoHZmy1V0lFBPQcgeE66gu6ZYiscyN/fbjjbLkiMTryeP/I52EMQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiV8mlJpBW/5K9NakQTc40fzHaFHTgLwCKjouc6pWFJ6ZgASzV
	Lz/KfJ1GpULqN2iEZoJnwJb3hvbFmCYg/K0HLNSmc2x5uQbIuDfzYXzJ
X-Gm-Gg: AYBFou3zdIvCsgo7NMLXUrtz8HfYcFHSP27+EeRZ3h5DivSOfb0q7HGZzlMppmH1cKs
	TksYxRuTdHWE7QALHiGeIXimH++d9c2u+l8ZIYk3traWVDdAxVncXhSYXTzauyNgdn9brh/b5Ov
	tCXXxe+6fiqDHThXV+w6Ssd3lsh7b/dk/RDfSCXUtAwfVvz0Ei7RUeVbDOgBo3NO9ZSy0HnW/1N
	b1Wf3ZI5Tdc7rXNvS2eXPgxLCHbz6z4O7LOz5S9t/n0OQGwtusYSw/Uj71GmrppfZ5ERwDcegyA
	VqMDOc1Up6AogndNfqc8KnIB05wwjRkK9yxFRFMgVmhYZudxS3yHZiG7isHgSe+c5xRurQd2ajQ
	hPfM4zfLIIU1DNjUhFcqwki7gbBhYW9mLj3CQrxoLT7s3B+FKQQOm/HNMWawCYtGtbEHYb/hh9W
	7/ayq0pGnEUhuwCoVITtHNVZOyE3QVTrSDc8y8JQGv7gvYIa/W5gYw/AlrOp0esIrBjwytHCPqb
	hVh6X6yayF4iUhYsArB+HyryMeALrHEm+bWE37e5OeisPTknp1obWKp
X-Received: by 2002:adf:f784:0:b0:48b:677:f80d with SMTP id ffacd0b85a97d-48e5d5c8686mr1199161f8f.26.1793138059897;
        Tue, 27 Oct 2026 14:54:19 -0700 (PDT)
Received: from thinkpad ([2a00:1370:81ac:50e7:d3c8:c903:5898:874a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3da7sm26333532f8f.20.2026.10.27.14.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:54:19 -0700 (PDT)
From: Andrey Zakharov <dedemorow@gmail.com>
To: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	hpa@zytor.com,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Zakharov <dedemorow@gmail.com>
Subject: [PATCH] x86/entry/32: Harden return-to-user
Date: Wed, 28 Oct 2026 00:52:51 +0300
Message-ID: <20261027215251.15275-1-dedemorow@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1e4d3001f59f ("x86/entry: Harden return-to-user") made the
check that the IRET frame returns to user mode unconditional on
x86-64. The 32-bit entry code has no equivalent: restore_all_switch_stack
executes IRET with whatever CS is in the frame. The exception return
path tests CS to choose between returning to the kernel and to user
mode, but the system call return paths (int $0x80, the SYSENTER
fallback and ret_from_fork) do not test it before reaching
restore_all_switch_stack.

Add an unconditional check to restore_all_switch_stack, after the
registers are restored. It requires that CS in the IRET frame has a
user RPL, or that EFLAGS.VM is set for vm86, and traps with UD2
otherwise. It is placed before CLEAR_CPU_BUFFERS so that the buffer
clearing stays directly in front of the IRET. The exception return
path to the kernel jumps straight to .Lirq_return and does not go
through the new check.

Testing: built i386_defconfig plus CONFIG_X86_LEGACY_VM86=y with
gcc 16.2.1; the build reported no warnings. Booted it under
QEMU (TCG, -cpu max) with a minimal initramfs running the
entry_from_vm86, sigreturn, single_step_syscall and syscall_nt
selftests. The results match the unpatched kernel, ignoring the FLAGS
values printed by entry_from_vm86, which also differ between two runs
of the unpatched kernel. entry_from_vm86 reports a UMIP failure on both
kernels. As negative controls, making the RPL test always fail kills
init with UD2 at the first return to user space, and removing the
EFLAGS.VM exception makes entry_from_vm86 hit the UD2.

Not tested: real hardware, performance, the NMI and double fault exits,
builds with PTI enabled, and builds with CONFIG_X86_LEGACY_VM86
disabled.

Link: https://github.com/KSPP/linux/issues/41
Signed-off-by: Andrey Zakharov <dedemorow@gmail.com>
---
 arch/x86/entry/entry_32.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 92c0b4a94e0a..69f754e5657c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -952,6 +952,14 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+
+	/* Assert that the IRET frame returns to user mode or vm86. */
+	testb	$USER_SEGMENT_RPL_MASK, 4(%esp)
+	jnz	.Lreturn_to_user_ok
+	testl	$X86_EFLAGS_VM, 8(%esp)
+	jnz	.Lreturn_to_user_ok
+	ud2
+.Lreturn_to_user_ok:
 	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
-- 
2.56.0

