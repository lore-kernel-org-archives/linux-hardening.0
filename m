Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90D3803CF;
	Tue, 13 Jan 2026 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292890; cv=none; b=BdC3LhCExZhsqTGxVocWC83u86c7eU+J1y9+3rqGPOAL83YYkZwf7Rsq/sjtUypVsBs9vvZGBjX3scRSlxQ0rUNNRKTMHlbmMZCNPVJAnofB89u3b4ZpL54LGZYi1+YWCX9JHhNrdCAMENSxxHh75yMAwSEMPZt0juv1N4/HTGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292890; c=relaxed/simple;
	bh=3ZHpmIjN0ZjnHCV57ZC+7ads3azFUMAfVmCYFRN6u5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCpghhr9uQbwkcQFcduYp0eX4edj+qcmJtH54ROoT7FSp4tVpGLG7ls1/j33z3WeweZ2bypBVDuoBJ+Hcjsr4QGTsqYuQKctXx44B+sWTIMjGrGtV1jPJYy2wZEDA/xF07adc2uGZiaxoYfkAE8c4LR7kYjRqb7QxzwQzeETwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c5e11412f05911f0a38c85956e01ac42-20260113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5ab30080-ae50-45b0-aff3-7a6bef4d9733,IP:0,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:a9d874c,CLOUDID:03724828cc3a3bcdb5f4d61e365e7909,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c5e11412f05911f0a38c85956e01ac42-20260113
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1982222664; Tue, 13 Jan 2026 16:28:01 +0800
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
Subject: [PATCH v2 03/14] lib/string: extract generic strchr() into __generic_strchr()
Date: Tue, 13 Jan 2026 16:27:37 +0800
Message-Id: <20260113082748.250916-4-jiangfeng@kylinos.cn>
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
generic C implementation of strchr() into a standalone function
__generic_strchr(). This allows tests to compare architecture-optimized
versions against the generic baseline without duplicating code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 include/linux/string.h |  1 +
 lib/string.c           | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 04b5fef7a4ec..57f8bf543891 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -169,6 +169,7 @@ extern int strcasecmp(const char *s1, const char *s2);
 #ifndef __HAVE_ARCH_STRNCASECMP
 extern int strncasecmp(const char *s1, const char *s2, size_t n);
 #endif
+extern char *__generic_strchr(const char *, int);
 #ifndef __HAVE_ARCH_STRCHR
 extern char * strchr(const char *,int);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 9dfe7177e290..8ad9b73ffe4e 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -317,6 +317,15 @@ int strncmp(const char *cs, const char *ct, size_t count)
 EXPORT_SYMBOL(strncmp);
 #endif
 
+char *__generic_strchr(const char *s, int c)
+{
+	for (; *s != (char)c; ++s)
+		if (*s == '\0')
+			return NULL;
+	return (char *)s;
+}
+EXPORT_SYMBOL(__generic_strchr);
+
 #ifndef __HAVE_ARCH_STRCHR
 /**
  * strchr - Find the first occurrence of a character in a string
@@ -328,10 +337,7 @@ EXPORT_SYMBOL(strncmp);
  */
 char *strchr(const char *s, int c)
 {
-	for (; *s != (char)c; ++s)
-		if (*s == '\0')
-			return NULL;
-	return (char *)s;
+	return __generic_strchr(s, c);
 }
 EXPORT_SYMBOL(strchr);
 #endif
-- 
2.25.1

