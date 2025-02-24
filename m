Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D6207DFF
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437571; cv=none; b=VKKCUFlShlA11ZxeIvfsBdpLfJeEwic8/5PQWWAelLklIDYkFCEkZWxElWAG2AZjzAIzn4yVa4eR5pfjrMj1iGLzjnrHNjMdvBVcFFxbAuyfRaT2hcu/0oSmHcVnWviffblVap06AI3QcFKwlHqWO2L6Vl3I3dIDiQPaTL5c6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437571; c=relaxed/simple;
	bh=ZnS1NHCFx7r4xILLYVXzHRj4d38PK3W5IrV0vHOLCR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2GhFak0AnwdkDB9ZbO0wWVuP1LLpfLH46Iy81VofZb+RklIhLDbmLV2eI+No4NJOsl/bmGeQ2rvcpNu3Fif2WyMSpwD8inFpOE1zrgGSSFJ8ZgZIlVj0C1Gc+MuKfLHRioqwRA8Ne55ijs7h72wF0rgs2feb5rxwIM4H1DP7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SKNJVXYc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SKNJVXYc"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2217ea6d8daso12818255ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 14:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437568; x=1741042368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXpe5H0HYKIhNOHQN5JiS3xHvAhirtYzR6Noo4in+5s=;
        b=SKNJVXYca0GNbjawg8fWFuUqWsM7D1Q6PgWAAHVf9oiUh7BzjO0ltfgVfCsqdq2Y8z
         DHj7VGpGLREhLzUqj2GZvvaAhDo56gpgQJkg5/gV80m5Xutuuu5ietO7KQcTO/qVNee6
         qcF9sLDaeFldYqD+FngTNQLGqZNcTRdlNwk0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437568; x=1741042368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXpe5H0HYKIhNOHQN5JiS3xHvAhirtYzR6Noo4in+5s=;
        b=SrU6WYh4ZEEYDJXJ/uzE5p4p6GTiw2McPxEmYdn5FdXwg7nOBFlfVJoDXa+szWk/MO
         tDbzDJEtZhFKeV5jhFCFDP3Hho1hp+2TsGvgbMh/tCURFK3r05FUP0BNWzuh/SpvQNAE
         C7+WeTNEH4lEf+qx8uIOEfx6yEpFBWyERzRUNJgA+68oCf0fNTpAPrg+X23fMFLVL7xS
         lVUhq86xGoJK8qT1xwXzIv1vhDbagO8aA5BeehMsVzP0aRFjXAAMhbPeg31oUxHNWw4l
         NBsnV5yZyU7e2CqZ2OnuK/tVtGCkdxTnen4YWerq9mRdS0V2GaYTI6ELg10kJw0YXgr/
         QuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV395dI1XqCh+n4OOjtmqIZyqrHbsSEjYYPD7ajJLTpVWV/Ckrsboi6hWhKvrpeQi58BNgsaGMoo8VSh5K0q7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUn8Dq8WPYAf+DxqriRa+c0ukp1ldHT7nhZPwLrLsmbJ7fRBff
	2ACUih2uDIMsfyUxBBm9sV3xJVUk9kbl647q+27zElEBmtL5+YhsaWa94hEYPQ==
X-Gm-Gg: ASbGnctc/wNlm8QyTmMn59pp+CwbXjEHiQ3X4JE6AC/pi7by41+U1J7t+ypMbP9b/uy
	zC6IYY9+rNu2CIjq8hmNS6OqpOKShB70E9iQaRqxvReEyMBnDKsyqq75dfqhhS7wVLcb5EAJhej
	91zWpygDTw9v/uBiL5Ku3TJt6aAcsTHSec81GD9Mg+DANUT7bHTQQpWpaYa1VfrmPpe7mhFJkHD
	HMHVAJdrgcbhbR1TaPqvsYSaGrQlIU4EQ6plCX0NYYUSGSfaIAIPc6SNbr1Ci70yBDjC+eWGGTR
	zG9ELmamQFBM3LJrrCrAfKSsVQCfzlf9gmF5iinP4S3/sgEPXhsGLi79lFw4
X-Google-Smtp-Source: AGHT+IEHa9T2X9sLxY9oVUNah712hKbuLVNF6n68F2r7XX8GrvVHGwGDQiEDAKEWHbny+TNT2twy6Q==
X-Received: by 2002:a17:903:40c9:b0:215:b8b6:d2c4 with SMTP id d9443c01a7336-2219ff4f24fmr94100455ad.4.1740437567432;
        Mon, 24 Feb 2025 14:52:47 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a00a9e3sm1392335ad.60.2025.02.24.14.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:46 -0800 (PST)
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
Subject: [PATCH v7 0/7]  mseal system mappings
Date: Mon, 24 Feb 2025 22:52:39 +0000
Message-ID: <20250224225246.3712295-1-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This is V7 version, addressing comments from V6, without code logic
change.

--------------------------------------------------

History:
V7:
 - Remove cover letter from the first patch (Liam R. Howlett)
 - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
 - logging and fclose() in selftest (Liam R. Howlett)

V6:
  https://lore.kernel.org/all/20250224174513.3600914-1-jeffxu@google.com/

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

--------------------------------------------------
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

 Documentation/userspace-api/mseal.rst         |  7 +++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/vdso.c                      | 22 +++++++---
 arch/um/Kconfig                               |  1 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/vdso/vma.c                     | 16 ++++---
 arch/x86/um/vdso/vma.c                        |  6 ++-
 include/linux/mm.h                            | 10 +++++
 init/Kconfig                                  | 18 ++++++++
 kernel/events/uprobes.c                       |  5 ++-
 security/Kconfig                              | 18 ++++++++
 .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
 12 files changed, 132 insertions(+), 16 deletions(-)

-- 
2.48.1.658.g4767266eb4-goog

