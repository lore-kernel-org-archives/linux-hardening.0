Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0B3803C3;
	Tue, 13 Jan 2026 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292890; cv=none; b=LeY3yK4QY2lAO2PhfnaRXfB/WEpyzODX7m2JL2IUKjvTbPtLJ41nvmlt5V3iEWj0K9ai44vbEIA6F5kfo76WflTX3K8pqFdMPB+AselG26dmjf/0gHHV8VpH0+zQ/cHPhK0YhuqHqkT+M6TuJYPcd+eRhGHUT12NPmBPrCPOcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292890; c=relaxed/simple;
	bh=4rwKNCUClCAqHxThqil2XPf3BjWSOecFe0OTRGIbON4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eUfzBXKDXRJTEu+B2i2n9DPcK1fnFyCQ2EqEXI7UprUDRvv+ecFNC8YhKyyruCOQiEgMlAlz02ley160TVLNq6T+On6vThrTzsGbH6TGp27NT11aJjZe/qnY5z6nSz2XWJxDrCWMf4bAokohUQYMcXa1CAqqmHg7eF2ZCRGRHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c4e7f422f05911f0a38c85956e01ac42-20260113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:cbb74efb-63c1-4bb7-a8f0-49e301156545,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:c8f361b3fbd1107a830e3721ae491ec1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c4e7f422f05911f0a38c85956e01ac42-20260113
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1597642201; Tue, 13 Jan 2026 16:27:59 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kees@kernel.org,
	andy@kernel.org,
	akpm@linux-foundation.org,
	jiangfeng@kylinos.cn,
	ebiggers@kernel.org,
	martin.petersen@oracle.com,
	ardb@kernel.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	linus.walleij@linaro.org,
	nathan@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 02/14] lib/string: extract generic strnlen() into __generic_strnlen()
Date: Tue, 13 Jan 2026 16:27:36 +0800
Message-Id: <20260113082748.250916-3-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260113082748.250916-1-jiangfeng@kylinos.cn>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support performance benchmarking in KUnit tests, extract the
generic C implementation of strnlen() into a standalone function
__generic_strnlen(). This allows tests to compare architecture-optimized
versions against the generic baseline without duplicating code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 include/linux/string.h |  1 +
 lib/string.c           | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 961645633b4d..04b5fef7a4ec 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -201,6 +201,7 @@ extern __kernel_size_t __generic_strlen(const char *);
 #ifndef __HAVE_ARCH_STRLEN
 extern __kernel_size_t strlen(const char *);
 #endif
+extern __kernel_size_t __generic_strnlen(const char *, __kernel_size_t);
 #ifndef __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *,__kernel_size_t);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 047ecb38e09b..9dfe7177e290 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -430,8 +430,7 @@ size_t strlen(const char *s)
 EXPORT_SYMBOL(strlen);
 #endif
 
-#ifndef __HAVE_ARCH_STRNLEN
-size_t strnlen(const char *s, size_t count)
+size_t __generic_strnlen(const char *s, size_t count)
 {
 	const char *sc;
 
@@ -439,6 +438,13 @@ size_t strnlen(const char *s, size_t count)
 		/* nothing */;
 	return sc - s;
 }
+EXPORT_SYMBOL(__generic_strnlen);
+
+#ifndef __HAVE_ARCH_STRNLEN
+size_t strnlen(const char *s, size_t count)
+{
+	return __generic_strnlen(s, count);
+}
 EXPORT_SYMBOL(strnlen);
 #endif
 
-- 
2.25.1

