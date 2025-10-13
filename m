Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27821E8332
	for <linux-hardening@vger.kernel.org>; Mon, 13 Oct 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363845; cv=none; b=LQTcAeFVxjpDxPKLJkd2+ufX78IQ2MAPQJMYiubraOBvKEhNcJaayzxDD0UGqiyZQ4BPJhmtJgKkRPjzoba/ndgo2eJ6uClTG2Mzs+ph63rxGKP8zVef8FrmoJTyRgFodHvE7x0shnCvKYHbg3q2lnEUuE7mw8S1wLdSAKgg98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363845; c=relaxed/simple;
	bh=Nqtn3oYMgYTCKsNSeGudcz9aSt5la9Fx3p9eDXXA4ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWSt+DgC0/+jM2T5aE8DXl1QSGAPwPvSX2MyzWDUb2RXSE6OEvIKZD4CPeuBDKmXodnyuqimzG4T4wVHLoKhJIh1TpuriAogGUN0ueyIdlz+kWYq9OK7szzkJtTTR/Cz6JO14gannEVV79q30JdJZw8M5xKb+YWs6qaWO6Iy89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FywpRp8N; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FywpRp8N"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760363840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uKCeVoplcSeU8bHZlk1TaSw0Kbvlf2fYQNyEbPJVu1Q=;
	b=FywpRp8NBqUYnNzKAOFOcnOnhX1b4P2C5vwMnLxu+2RmWGmmRRP/NGEXHeHbnjLUSNGKeZ
	z134yp+cqInNjJV9A4+pmcO2poKGw80v0v8pGT6u9VGlR5rfitm+UlFclLQnqWCf4NTB+I
	++mpvlPEZ8Wa0fA4uMtrhAEuCooXnXQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries/lparcfg: Replace deprecated strcpy in parse_system_parameter_string
Date: Mon, 13 Oct 2025 15:57:02 +0200
Message-ID: <20251013135703.97260-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead. Use the return value of
strscpy() instead of calling strlen() again, and ignore any potential
string truncation since both strings are much shorter than the buffer
size SPLPAR_MAXLENGTH.

Change both if conditions to silence the following checkpatch warnings:

  Comparisons should place the constant on the right side of the test

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index cc22924f159f..533a6edf2e03 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -22,6 +22,7 @@
 #include <asm/papr-sysparm.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
 #include <asm/lppaca.h>
@@ -420,17 +421,18 @@ static void parse_system_parameter_string(struct seq_file *m)
 				w_idx = 0;
 			} else if (local_buffer[idx] == '=') {
 				/* code here to replace workbuffer contents
-				   with different keyword strings */
-				if (0 == strcmp(workbuffer, "MaxEntCap")) {
-					strcpy(workbuffer,
-					       "partition_max_entitled_capacity");
-					w_idx = strlen(workbuffer);
-				}
-				if (0 == strcmp(workbuffer, "MaxPlatProcs")) {
-					strcpy(workbuffer,
-					       "system_potential_processors");
-					w_idx = strlen(workbuffer);
-				}
+				 * with different keyword strings. Truncation
+				 * by strscpy is deliberately ignored because
+				 * SPLPAR_MAXLENGTH >= maximum string size.
+				 */
+				if (!strcmp(workbuffer, "MaxEntCap"))
+					w_idx = strscpy(workbuffer,
+							"partition_max_entitled_capacity",
+							SPLPAR_MAXLENGTH);
+				if (!strcmp(workbuffer, "MaxPlatProcs"))
+					w_idx = strscpy(workbuffer,
+							"system_potential_processors",
+							SPLPAR_MAXLENGTH);
 			}
 		}
 		kfree(workbuffer);
-- 
2.51.0

