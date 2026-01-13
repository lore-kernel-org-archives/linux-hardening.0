Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963B37FF54;
	Tue, 13 Jan 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292890; cv=none; b=ciS8YemwIyjQevKEgnL2Lm6h+eaGcTASpWo5orO05+nnFRmfsbfzq9LII8UhIl+F1GOTd64sctsUkQqvA+3ItlgWtfJaNmUNcKC3ehX/gSo+RPDJiIP2ULjv0N5dzYicZMpy544BkreKPSwejHEarwDFk+ITGUTWBj/yJfQRlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292890; c=relaxed/simple;
	bh=onN357XwpgnJOIWqgd1HTRRX1fgbE0mRqBNoEJ26aos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZX0iugnM4igbFhyfrqbFPaBrPx+APGV5UcHB5TxXWwd2tCkbn3XWFDWBDZJd62xedv8EERs3voUxSXDMWCQJ6MNwc/S8+nZJr9xBwZFM2DMRFveEQ8XOkQOXsx9tYhUS0W2PvLm31vqo4xLTz769zsMAIIBMBtjmw2A2w/Ra6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c676938ef05911f0a38c85956e01ac42-20260113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ab728788-6248-41af-a67e-08eadb41e789,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:eeaa946d4107ed81f13ae713443562e6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c676938ef05911f0a38c85956e01ac42-20260113
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 954323636; Tue, 13 Jan 2026 16:28:02 +0800
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
Subject: [PATCH v2 04/14] lib/string: extract generic strrchr() into __generic_strrchr()
Date: Tue, 13 Jan 2026 16:27:38 +0800
Message-Id: <20260113082748.250916-5-jiangfeng@kylinos.cn>
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
generic C implementation of strrchr() into a standalone function
__generic_strrchr(). This allows tests to compare architecture-optimized
versions against the generic baseline without duplicating code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 include/linux/string.h |  1 +
 lib/string.c           | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 57f8bf543891..2ede3ff0865a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -180,6 +180,7 @@ extern char * strnchrnul(const char *, size_t, int);
 #ifndef __HAVE_ARCH_STRNCHR
 extern char * strnchr(const char *, size_t, int);
 #endif
+extern char *__generic_strrchr(const char *, int);
 #ifndef __HAVE_ARCH_STRRCHR
 extern char * strrchr(const char *,int);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 8ad9b73ffe4e..4405a042eee7 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -377,6 +377,18 @@ char *strnchrnul(const char *s, size_t count, int c)
 	return (char *)s;
 }
 
+char *__generic_strrchr(const char *s, int c)
+{
+	const char *last = NULL;
+
+	do {
+		if (*s == (char)c)
+			last = s;
+	} while (*s++);
+	return (char *)last;
+}
+EXPORT_SYMBOL(__generic_strrchr);
+
 #ifndef __HAVE_ARCH_STRRCHR
 /**
  * strrchr - Find the last occurrence of a character in a string
@@ -385,12 +397,7 @@ char *strnchrnul(const char *s, size_t count, int c)
  */
 char *strrchr(const char *s, int c)
 {
-	const char *last = NULL;
-	do {
-		if (*s == (char)c)
-			last = s;
-	} while (*s++);
-	return (char *)last;
+	return __generic_strrchr(s, c);
 }
 EXPORT_SYMBOL(strrchr);
 #endif
-- 
2.25.1

