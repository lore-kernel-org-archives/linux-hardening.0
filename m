Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705A176FBE
	for <linux-hardening@vger.kernel.org>; Tue, 30 Apr 2024 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498626; cv=none; b=RQrG9PEZeyFq8gLR/++btxW+fmXt0k9/j8jy6iJa+zOneAbAYoYopEfgiCRY8y+N3YUfjkaeNxGdWEsiQYU67zd3XkF4YqXgxeVjddoOQ2fQnOvYszoDTlPlIctIEA4cCT56zY1JVgyDVqCPx2sfIYnFOyMpGEDOURiXbAqQatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498626; c=relaxed/simple;
	bh=HwleHbMmvyClSw2hkCjqzzitfJIFUgKSvCPPJPbOXUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQY+YGL3d4Dppr4qzmabgyzfWQP0dgshlmbakyJNfNElhK/oSoJ1Ff6YxlMtcsUzZU2J9WuDl9aClwtMqWJ+DM4rq6qLnqACXJGZqV3hNMOQBwl+07cdbNxinv53jNRmzIjEwebrwMBKug/D3SqsTFRKpTFybCmPGneDjHjPdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ftHtMFai; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftHtMFai"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eab16dcfd8so51869965ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 30 Apr 2024 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714498624; x=1715103424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7TCEkmJU5v9XbqMkMv7vhbRAU+5JxBsl8E5GjM9uj8=;
        b=ftHtMFaipxj1hya2+OVkgdkd2QSO3ryMoAfBnkywgVaRrfaqGZL08O474COmBBxSWC
         mbqrsACYOo7wb81W8kMSBXyqih1lnGo7UHAR+hJhXVyxTqTtf7E1v9xNUwlMG+XHeYY0
         b7Udlsl8Wzmvg8yzMJs/DckhvgShi1agj9Iw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498624; x=1715103424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7TCEkmJU5v9XbqMkMv7vhbRAU+5JxBsl8E5GjM9uj8=;
        b=cNSKyJC67ouZInSP5R6Bk1B/HZPR1XJAYNMJTz2UKohHGmBtwpzgbhdRFtQS2KZ4Z8
         JZ0BFRwP/hCZLIhXTGlVVBHvHKyQVsHIRseKZf+FNXDfN4vhrcPpIDdfSQ8gyC1J1xiM
         OYPDQ6gMs48PeegbB/CtY/f6EYItU3IvjAU3s/y2Zk4VNRhTpmkpeX5dOodtNeuafD8c
         XnMIwCgQmD4uGaye6hnVBTyutJgHabTyu0RO/FAbYUTY8RAnb5UU4qDmpYZlabHCvxp/
         FiFdCMvgbWTBi8iycC8H71pYEkeU5gCQ/n2lXspSQwK+JS5vmLIOd3FFhI9eMs9JpdJR
         kZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEXVjH37LpD3n2cwqxc+8pfYnmFkeDwmpyWrA3a8MdfDTkbwTdYyeAu/j/ap0zfy+m84hnYeIPA7Ujz86V8R15saXaLrCFuVak1qqGVQdY
X-Gm-Message-State: AOJu0YyNWwobdMG99U5n0ZQLZUJug5QrMe3aTFVqu8I1Kj6hZQbHIl4b
	bWwGIck7xF2D+dN9q7kTpOcb72JrM4qcd6gmG2NaFYPrVr/115uNkLkor6dTTQ==
X-Google-Smtp-Source: AGHT+IEgJyBdK8IaFbZBEcXMW5JQxffHszntW2uwXu4E0cAx4+VHUvWNNAEX/51rVj/TOrVaFr9SYA==
X-Received: by 2002:a17:902:eac4:b0:1ec:76a6:ea9 with SMTP id p4-20020a170902eac400b001ec76a60ea9mr98049pld.26.1714498624229;
        Tue, 30 Apr 2024 10:37:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090320cc00b001eab1258197sm10400741plb.144.2024.04.30.10.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:37:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] hardening: Enable KCFI and some other options
Date: Tue, 30 Apr 2024 10:37:00 -0700
Message-Id: <20240430173657.it.699-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=keescook@chromium.org;
 h=from:subject:message-id; bh=HwleHbMmvyClSw2hkCjqzzitfJIFUgKSvCPPJPbOXUI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmMSw8JAuEaLHzrMs+I0z2zE2/9ONfTrWuUhxfB
 nUIns+oImyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjEsPAAKCRCJcvTf3G3A
 JhTEEACOGEhRbFkij9Hg8wOi94RhI/kWW1frkUHlY6k9hvRUHCG4HdzS1hJHcBlfpZuXkJ8j3ub
 qAINSRxOpsnxez1sFGK5iy91hNbeRGXyJ5znmwbewZssGCdDyRs99mhcp2+zJJgcOGltMW5q44d
 C1e3GA22dEyNX7IKQneeJpm5SaZbKusp72+3dNQcpkQOc4stcvPbT+b28JZdM+gnuryWpkgwhuS
 ozeSggCI0N6FD0P0HXnFp0tQKEDDINxCW0wIyg07WLruf+R5CRt5jLkZFPN46KcygR5668GeDzS
 ToWYc44Tk88mmSaxTKzPN0afz12vfTuPkrf1+Z6QjOagPIWLEvWW0JtqXVjiw3Tc9qphdzOah/k
 /SQY3iG3kgMJ7y8oh4dPMutI5Ustzk8Vj0rmka0bFaM78u+LC9Ha5grFnsvD17eh9mLFPtn8K75
 YJi9wR7tyyCpnFjSUr/5231n8Y9Q9u+K2TalZMppSa1E2QaDg6giY4ZK3LKPsbDCfPkjyggWTR4
 kHXXHnz9MGksi/hKRITQ/Aq3qpVYyKOBChuMppK9xOqjLZRs/gosEDqtYVjN3nsbGcxnKyOgE+L
 wLHf2ApifK8pF64VYy9at8D0ixOjL8IoywKA39+LMBkzyfENJD+IN+4MRqcigX77oUDCIuuYgtI
 ySSnPDH nd/DoKkA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add some stuff that got missed along the way:

- CONFIG_UNWIND_PATCH_PAC_INTO_SCS=y so SCS vs PAC is hardware
  selectable.

- CONFIG_X86_KERNEL_IBT=y while a default, just be sure.

- CONFIG_CFI_CLANG=y globally. (And disable FINEIBT since
  it isn't as secure as straight KCFI.)

- CONFIG_PAGE_TABLE_CHECK=y for userspace mapping sanity.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 v2: move CONFIG_CFI_CLANG=y to global config
 v1: https://lore.kernel.org/all/20240426222940.work.884-kees@kernel.org/
---
 arch/arm64/configs/hardening.config | 1 +
 arch/x86/configs/hardening.config   | 6 ++++++
 kernel/configs/hardening.config     | 8 ++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/configs/hardening.config b/arch/arm64/configs/hardening.config
index b0e795208998..24179722927e 100644
--- a/arch/arm64/configs/hardening.config
+++ b/arch/arm64/configs/hardening.config
@@ -5,6 +5,7 @@ CONFIG_ARM64_SW_TTBR0_PAN=y
 
 # Software Shadow Stack or PAC
 CONFIG_SHADOW_CALL_STACK=y
+CONFIG_UNWIND_PATCH_PAC_INTO_SCS=y
 
 # Pointer authentication (ARMv8.3 and later). If hardware actually supports
 # it, one can turn off CONFIG_STACKPROTECTOR_STRONG with this enabled.
diff --git a/arch/x86/configs/hardening.config b/arch/x86/configs/hardening.config
index 7b497f3b7bc3..bf3d31618e12 100644
--- a/arch/x86/configs/hardening.config
+++ b/arch/x86/configs/hardening.config
@@ -10,5 +10,11 @@ CONFIG_INTEL_IOMMU_DEFAULT_ON=y
 CONFIG_INTEL_IOMMU_SVM=y
 CONFIG_AMD_IOMMU=y
 
+# Enforce CET Indirect Branch Tracking in the kernel.
+CONFIG_X86_KERNEL_IBT=y
+
 # Enable CET Shadow Stack for userspace.
 CONFIG_X86_USER_SHADOW_STACK=y
+
+# When CONFIG_CFI_CLANG is enabled, disable weaker FINEIBT landing pads.
+# CONFIG_FINEIBT is not set
diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 7a5bbfc024b7..47e6564129c3 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -23,6 +23,10 @@ CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
 CONFIG_RANDOM_KMALLOC_CACHES=y
 
+# Sanity check userspace page table mappings.
+CONFIG_PAGE_TABLE_CHECK=y
+CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
+
 # Randomize kernel stack offset on syscall entry.
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 
@@ -81,6 +85,10 @@ CONFIG_SECCOMP_FILTER=y
 # Provides some protections against SYN flooding.
 CONFIG_SYN_COOKIES=y
 
+# Enable Kernel Control Flow Integrity (currently Clang only).
+CONFIG_CFI_CLANG=y
+# CONFIG_CFI_PERMISSIVE is not set
+
 # Attack surface reduction: do not autoload TTY line disciplines.
 # CONFIG_LDISC_AUTOLOAD is not set
 
-- 
2.34.1

