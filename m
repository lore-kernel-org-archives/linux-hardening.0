Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A317A314
	for <linux-hardening@vger.kernel.org>; Fri, 25 Apr 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567263; cv=none; b=TaAGo8tcuDIyxSVYCbPnDCEIuTlckU/qiR+71Ny5jQH5myTuOTyHPbiG4WZq3G5I25NKNsX20pjJRAvxDI2lOaU/7lcKVEtH8S0d3qbRBw9LrQLsXoxSPL1FNtEZtHMOrToN0fZx6pAOwNnXL6Ka7OfJ0lZma3GmVL5EyeEgk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567263; c=relaxed/simple;
	bh=A0ORCzzboTptqzQxnn+YddyIWGCseBYrq7mDp61voSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHqKHovPA7IhdZ09nnnDiMO9xJCwJzeZf3uzn/X3mDCSBRnCq8AgXp1EcoTEVQkIrX0Ra76tt/kL7ma5l45z1/uykrTEkesMI78ZBfvEnIpQ/HkUvagtmqgR0oXk4Lpay1liu2tKoe+Tlk3RVTOzKaXvQibeNrh4RZqDnwtVwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pVsKmI6P; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pVsKmI6P"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745567249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gsutiEcM3sDMw4dwuLPrFVKpaX5l9po0YhcNfxpCrc0=;
	b=pVsKmI6PQvc2CIMuM3FvuBZa5/1wsLLzt0h3EHwLBi74bvtR2UHalBmvuPZmDDi7/4wQNo
	c7CHF4a4AKze/MYUcahi7GVXzlBjUlf2KB1XqzNtSRT8b8JXigjYILkBa338gekpRo70Io
	qgFLh8Xb8AlmBriT8Ikz7s5CCjkoKdw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Replace strcpy() with strscpy() in vpe_elfload()
Date: Fri, 25 Apr 2025 09:46:48 +0200
Message-ID: <20250425074651.1362-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/mips/kernel/vpe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 737d0d4fdcd3..2b67c44adab9 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
 #include <linux/seq_file.h>
+#include <linux/string.h>
 #include <linux/syscalls.h>
 #include <linux/moduleloader.h>
 #include <linux/interrupt.h>
@@ -582,7 +583,7 @@ static int vpe_elfload(struct vpe *v)
 	struct module mod; /* so we can re-use the relocations code */
 
 	memset(&mod, 0, sizeof(struct module));
-	strcpy(mod.name, "VPE loader");
+	strscpy(mod.name, "VPE loader");
 
 	hdr = (Elf_Ehdr *) v->pbuffer;
 	len = v->plen;
-- 
2.49.0

