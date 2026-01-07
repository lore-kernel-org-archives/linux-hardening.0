Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228F7FBAC;
	Wed,  7 Jan 2026 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767753341; cv=none; b=Gfg90oYJBij6wYNVMF/iMegnDAKNCtEQwXfja+vL08FWxRS6eet+fVhPBQ87av+IMhX/gLhViYlN1uUSgmsaTfroPyKR8RdrlVKZayu2/wKWnUE8/eed1lTifSLusjvLS8Frme4vOzRclJ7WyjI6fxEJldl2GlODuYwQ5ZEcuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767753341; c=relaxed/simple;
	bh=y/acc20L45vWZZc5pMNhS0dODT2+H19rn8Ir6S129nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oygV5KduUuPMO0NQ9ajId7+/pzhySiolC3V6iBLW1NF2eKtI6QDY+gFozuxOAqpQlhR7T+mq1ys1hhLcSYBclAKT9z7yteZnQiH3NoON6LGgqo6jXHncr378snVTAUkhw0gCDztCHPusH3MudDlgjBqkDaoyqHU87DAFOV37LEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8914bed6eb7111f0a38c85956e01ac42-20260107
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b31f22fb-db5c-43ab-9dc1-e6ceed6df590,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:81179816ae89821601ad50a8f3b60a69,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8914bed6eb7111f0a38c85956e01ac42-20260107
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1792954441; Wed, 07 Jan 2026 10:35:31 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kees@kernel.org,
	andy@kernel.org,
	jiangfeng@kylinos.cn,
	ebiggers@kernel.org,
	martin.petersen@oracle.com,
	Jason@zx2c4.com,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	charlie@rivosinc.com,
	ajones@ventanamicro.com,
	nathan@kernel.org,
	linus.walleij@linaro.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/5] riscv: optimize string functions and add kunit tests
Date: Wed,  7 Jan 2026 10:35:12 +0800
Message-Id: <20260107023517.46840-1-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces optimized assembly implementations for several 
string functions on the RISC-V architecture (strnlen, strchr, and strrchr). 
To ensure correctness and prevent regressions, it also extends the 
string_kunit test suite with new cases.

The patchset is organized as follows:
- Patches 1-2: Enhance lib/string_kunit.c with new test cases for 
  strlen and strnlen to establish a baseline for verification.
- Patches 3-5: Provide the RISC-V specific optimized implementations 
  for strnlen, strchr, and strrchr.

Testing:
All patches have been verified using the KUnit framework on QEMU 
virt machine (riscv64). All string-related tests passed.

Changes:
- v1: Initial submission.

---

Feng Jiang (5):
  lib/string_kunit: add test case for strlen
  lib/string_kunit: add test case for strnlen
  riscv: lib: add strnlen implementation
  riscv: lib: add strchr implementation
  riscv: lib: add strrchr implementation

 arch/riscv/include/asm/string.h |   9 ++
 arch/riscv/lib/Makefile         |   3 +
 arch/riscv/lib/strchr.S         |  35 +++++++
 arch/riscv/lib/strnlen.S        | 164 ++++++++++++++++++++++++++++++++
 arch/riscv/lib/strrchr.S        |  37 +++++++
 arch/riscv/purgatory/Makefile   |  11 ++-
 lib/tests/string_kunit.c        |  53 +++++++++++
 7 files changed, 311 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/strchr.S
 create mode 100644 arch/riscv/lib/strnlen.S
 create mode 100644 arch/riscv/lib/strrchr.S

-- 
2.25.1

