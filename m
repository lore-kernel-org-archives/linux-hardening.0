Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6037FF54;
	Tue, 13 Jan 2026 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292885; cv=none; b=MutA8ll3HFpeGGx8BjZLh6CTIWcKPltKtzimz5VylCKp9QalqYoJI8/o7qtSmGZoQ9Xg4R2aIupbP2q4wqBeD9bp0ggsNdcS2V8X1qIcrNMfveFu8NvxsYLwXDe5UD1wIFJNlFRIU5I54wsL4lazkRhMJhGUoNaBW8/dEpWQPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292885; c=relaxed/simple;
	bh=1oxpHVilVK2SqG0Y4rp6MdIJ6tAAy+IiuCUJDNS6QrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMkuxvTDm/R1xqQFttuO1vqmJSdwDtBpP0sgOlQYo6HFT3+P5rLqiF8NAz+3JE2IY/WBK/7HVqdJaQzTTt9Vsr1m5UBb+nKIGeo5BKP5K/+u8moUk/VMzQ/W9cQJGftF/McUESYAY8N/YR0TFeEeQXAkVdMIvoxsk7Z/ZOEoe2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c4320040f05911f0a38c85956e01ac42-20260113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:e346155f-0f91-4c2e-a8a1-5393a154b924,IP:0,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:a9d874c,CLOUDID:1ac8a1be40bd3ada1e363909550e78e0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c4320040f05911f0a38c85956e01ac42-20260113
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 659851752; Tue, 13 Jan 2026 16:27:58 +0800
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
Subject: [PATCH v2 01/14] lib/string: extract generic strlen() into __generic_strlen()
Date: Tue, 13 Jan 2026 16:27:35 +0800
Message-Id: <20260113082748.250916-2-jiangfeng@kylinos.cn>
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
generic C implementation of strlen() into a standalone function
__generic_strlen(). This allows tests to compare architecture-optimized
versions against the generic baseline without duplicating code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 include/linux/string.h |  1 +
 lib/string.c           | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 1b564c36d721..961645633b4d 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -197,6 +197,7 @@ extern char * strstr(const char *, const char *);
 #ifndef __HAVE_ARCH_STRNSTR
 extern char * strnstr(const char *, const char *, size_t);
 #endif
+extern __kernel_size_t __generic_strlen(const char *);
 #ifndef __HAVE_ARCH_STRLEN
 extern __kernel_size_t strlen(const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index b632c71df1a5..047ecb38e09b 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -412,8 +412,7 @@ char *strnchr(const char *s, size_t count, int c)
 EXPORT_SYMBOL(strnchr);
 #endif
 
-#ifndef __HAVE_ARCH_STRLEN
-size_t strlen(const char *s)
+size_t __generic_strlen(const char *s)
 {
 	const char *sc;
 
@@ -421,6 +420,13 @@ size_t strlen(const char *s)
 		/* nothing */;
 	return sc - s;
 }
+EXPORT_SYMBOL(__generic_strlen);
+
+#ifndef __HAVE_ARCH_STRLEN
+size_t strlen(const char *s)
+{
+	return __generic_strlen(s);
+}
 EXPORT_SYMBOL(strlen);
 #endif
 
-- 
2.25.1

