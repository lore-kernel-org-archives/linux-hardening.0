Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E3263F3A
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419117; cv=none; b=HXnYWS1Qry7+BHxFxYzYHvRDUCqgWip4DT3gcfRFsO3qziTSb3dtkfnzpTFpA+bN4lZRNzoxeGNhhluPhVZdhRT35mrByXK1F4KLuwMvivquT+H2SZb4Y7mYyxoKDw+F35f0nbWAlXc1gdh5OAqwo9bk9G81AVkuHugugx43zM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419117; c=relaxed/simple;
	bh=gu/wlPkEa9mQgoMthKANU0ZDCM7tCdynkNJLVCB9fDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqqRpti+w5EKXubUMTYRzxMApkwdew7sW/YU4nDHDOM9B6NloH4UEaD0z0iiWhtA2ioudLt+KNi0H80tg4zwNldkm6WgJJtaI2JeWAT3hIQttEFoPtVQcXUo0MBcwGXfnRPMFDdww3kNNFGhTZbYaaVOZgkfW/IDwNn7QZWaS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kWTyMLTb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kWTyMLTb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2217875d103so10767865ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 09:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419115; x=1741023915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RcuzKtFPPtst6WZXsPXBZwCkXSRuweXNYzPclr2Anaw=;
        b=kWTyMLTbzRzyJRQlPrHUKPxSPvoD0G3AJ6wMFVomglQcdiT3adPXdEwe39h1CtLsxU
         qL1IAqz5Ixgk1mFPg35II7zDW8uzdeaC73AATHDfPC7WFQ6Kyts5qDdIPUOFwi6Lqauz
         s/GmdnbEZJUTA+ZgiVDTp3y3LMVNE8eY985ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419115; x=1741023915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcuzKtFPPtst6WZXsPXBZwCkXSRuweXNYzPclr2Anaw=;
        b=f6q74aoXY2Q9lFhnrU+4BkzqpAy1rsRLfjQnEbnQR/LxHHHXljbVFnsKjVdevjn3YE
         UgDkwECumi08wfNSg0+gkkrB2OMTS8+Ruwb2V1BbWgQBa38mNkNFG0hN2S7xpU/z+/Se
         otL6bMOb1mFf2KobO40xLuFegIrCVJgsGX0Cp8wNIqD7mgSYoB2cDgJ41prRYuYKan1x
         17jbm1aL2oqtfrXKiQHiKTQvBLVn/dyjY43LX+TNYBSmHuiGN+gFonsen1m1BrUUZMRd
         lV3wp/LLEX7YWimonYyFq30tfUOSBpeCPywyAPGa0f/7PushRq47y3ml+oWyJQ8ABveH
         ELKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjV9EnKW1UJUUJzF0dUe1EyC4WQsob8sYJVWJ0G9Q3Of4WWH0Wl4sPO/umdMHp9qRjcFMBdRgqu7pRuzqkeuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8as9hZV2rnwplGevt/Z6641GUIWZpusPsEiaFZ2GhbXMnptez
	u1bXcZLLjKnerzb9/YyNpRs/4FHyk4Aio3jKTHnQuU0sQUiFmHWchn33iX/4fQ==
X-Gm-Gg: ASbGncs1GlLOQ3WYIezdPivKZMRnbcq4ECbXYt/2cOMR45NcYpLg3FwR8ICdFXKsn88
	yni61lRrx5n95tpCdN74qratWZGcEtC7a+QMABBxYtn4ZqIZnsb0Rr1q/J8c7nhg7oJo6UUL/MB
	nUvXowDBaOKsf1WYZ2LcCjdz3NYG1oHvnjayGN/VFifnfkrcB6w/uUMRIEZCfp8L5dTZ/IDTCIG
	L9H+Vj9t8TzV9k3f/sDY4wEWEo96yqCMZcT0zfM0V+tbZ4TB0Zzy2PtTvvWCGDzyhYwCj2urMSl
	slu0sfgu1aoPh5FceSJbKytOlawcdBRfcdrODgl+RS3vZPBGeP90QUJMgxgc
X-Google-Smtp-Source: AGHT+IFSLRh6SHQWvPSx2gIUkQXGWRiXe2mxqOjv3oqPRMC739LlRyLpyZpC4QGjTaVVt5mEnutt1A==
X-Received: by 2002:a05:6a00:987:b0:730:8526:5dbc with SMTP id d2e1a72fcca58-73426d77d7bmr9320754b3a.3.1740419114668;
        Mon, 24 Feb 2025 09:45:14 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732771a01bbsm15361992b3a.78.2025.02.24.09.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:14 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v6 0/7] mseal system mappings
Date: Mon, 24 Feb 2025 17:45:06 +0000
Message-ID: <20250224174513.3600914-1-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This is V6 version, addressing comments from V5, without code logic
change.

History:
-------
V6:
  - mseal.rst: fix a typo (Randy Dunlap)
  - security/Kconfig: add rr into note (Liam R. Howlett)
  - remove mseal_system_mappings() and use macro instead (Liam R. Howlett)
  - mseal.rst: add incompatible userland software (Lorenzo Stoakes)
  - remove RFC from title (Kees Cook)

V5
  https://lore.kernel.org/all/20250212032155.1276806-1-jeffxu@google.com/

V4:
  https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.com/

V3:
  https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/

V2:
  https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/

V1:
  https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/

------------------------------------------------------------------------
Provide infrastructure to mseal system mappings. Establish
two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and MSEAL_SYSTEM_MAPPINGS_VM_FLAG
macro for future patches.

As discussed during mseal() upstream process [1], mseal() protects
the VMAs of a given virtual memory range against modifications, such
as the read/write (RW) and no-execute (NX) bits. For complete
descriptions of memory sealing, please see mseal.rst [2].

The mseal() is useful to mitigate memory corruption issues where a
corrupted pointer is passed to a memory management system. For
example, such an attacker primitive can break control-flow integrity
guarantees since read-only memory that is supposed to be trusted can
become writable or .text pages can get remapped.

The system mappings are readonly only, memory sealing can protect
them from ever changing to writable or unmmap/remapped as different
attributes.

System mappings such as vdso, vvar, and sigpage (arm), vectors (arm)
are created by the kernel during program initialization, and could
be sealed after creation.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [3]. It could be sealed from creation.

The vsyscall on x86-64 uses a special address (0xffffffffff600000),
which is outside the mm managed range. This means mprotect, munmap, and
mremap won't work on the vsyscall. Since sealing doesn't enhance
the vsyscall's security, it is skipped in this patch. If we ever seal
the vsyscall, it is probably only for decorative purpose, i.e. showing
the 'sl' flag in the /proc/pid/smaps. For this patch, it is ignored.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the system mappings during restore operations. UML(User Mode Linux)
and gVisor, rr are also known to change the vdso/vvar mappings.
Consequently, this feature cannot be universally enabled across all
systems. As such, CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.

To support mseal of system mappings, architectures must define
CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS and update their special mappings
calls to pass mseal flag. Additionally, architectures must confirm they
do not unmap/remap system mappings during the process lifetime.

In this version, we've improved the handling of system mapping sealing from
previous versions, instead of modifying the _install_special_mapping
function itself, which would affect all architectures, we now call
_install_special_mapping with a sealing flag only within the specific
architecture that requires it. This targeted approach offers two key
advantages: 1) It limits the code change's impact to the necessary
architectures, and 2) It aligns with the software architecture by keeping
the core memory management within the mm layer, while delegating the
decision of sealing system mappings to the individual architecture, which
is particularly relevant since 32-bit architectures never require sealing.

Prior to this patch series, we explored sealing special mappings from
userspace using glibc's dynamic linker. This approach revealed several
issues:
- The PT_LOAD header may report an incorrect length for vdso, (smaller
  than its actual size). The dynamic linker, which relies on PT_LOAD
  information to determine mapping size, would then split and partially
  seal the vdso mapping. Since each architecture has its own vdso/vvar
  code, fixing this in the kernel would require going through each
  archiecture. Our initial goal was to enable sealing readonly mappings,
  e.g. .text, across all architectures, sealing vdso from kernel since
  creation appears to be simpler than sealing vdso at glibc.
- The [vvar] mapping header only contains address information, not length
  information. Similar issues might exist for other special mappings.
- Mappings like uprobe are not covered by the dynamic linker,
  and there is no effective solution for them.

This feature's security enhancements will benefit ChromeOS, Android,
and other high security systems.

Testing:
This feature was tested on ChromeOS and Android for both x86-64 and ARM64.
- Enable sealing and verify vdso/vvar, sigpage, vector are sealed properly,
  i.e. "sl" shown in the smaps for those mappings, and mremap is blocked.
- Passing various automation tests (e.g. pre-checkin) on ChromeOS and
  Android to ensure the sealing doesn't affect the functionality of
  Chromebook and Android phone.

I also tested the feature on Ubuntu on x86-64:
- With config disabled, vdso/vvar is not sealed,
- with config enabled, vdso/vvar is sealed, and booting up Ubuntu is OK,
  normal operations such as browsing the web, open/edit doc are OK.

In addition, Benjamin Berg tested this on UML.

Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/ [1]
Link: Documentation/userspace-api/mseal.rst [2]
Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/ [3]



Jeff Xu (7):
  mseal, system mappings: kernel config and header change
  selftests: x86: test_mremap_vdso: skip if vdso is msealed
  mseal, system mappings: enable x86-64
  mseal, system mappings: enable arm64
  mseal, system mappings: enable uml architecture
  mseal, system mappings: uprobe mapping
  mseal, system mappings: update mseal.rst

 Documentation/userspace-api/mseal.rst         |  7 ++++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/vdso.c                      | 22 +++++++----
 arch/um/Kconfig                               |  1 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/vdso/vma.c                     | 16 +++++---
 arch/x86/um/vdso/vma.c                        |  6 ++-
 include/linux/mm.h                            | 10 +++++
 init/Kconfig                                  | 18 +++++++++
 kernel/events/uprobes.c                       |  5 ++-
 security/Kconfig                              | 18 +++++++++
 .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
 12 files changed, 127 insertions(+), 16 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog

