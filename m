Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E893203B5
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597598; cv=none; b=BhivPOw6x+2p8pWoBjdkXv3TfnWPRuIOfDWNYSPp9KNKt/Zcq0IcmeL/+qSgLHZt/8Vm1WwXUr89DhAXFmcB+8rvZYSPxPST9i2hMnY0Rftxw/YngEOMy1sv+ObvEkIQfYK60RfSpeuu3+FA0cs/OcNZyciCrq738sae0z7FHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597598; c=relaxed/simple;
	bh=Vhlp670jIoJlZ3xHQzXSWtWPJcSriIWz20Lo5ruwtIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbVsZk2w4Z6uxucTxlmtG7wdLx3HBNC+fDutg1E8owO6icbn1XivV2fUyOBHXOOFflKlXiOq8527Iva0XsjNwFTKytrF6LEdIBYuPbjrzew5r4ozbH3/Xsn/lQSezSwK4sKQogUNc1nuaUZhtxnE6iERbNsi+W32SMFr1p/MoNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B3ERXQtg; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B3ERXQtg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755597585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zavKxT3WRsPMSCRKqhVeovVHLiznL9SJiEUmezaibh0=;
	b=B3ERXQtgR9QaHzPZK4L85kMoLc23fmV36yK6hRwbj9VtRdbf4YgDx3+3a+VuJQEgexq9Rd
	1q8XNQ3aF3q/dquGQZxrcxiDZS4tUjS2GWUmQFrDh2913AEBVrkyMA+N8eMuqJvQcmRMSM
	g+hZKcCi5f3We9MVdA7cXnkWc+Sp5OA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zhang Heng <zhangheng@kylinos.cn>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] kdb: Replace deprecated strcpy() with memcpy() in kdb_strdup()
Date: Tue, 19 Aug 2025 11:59:03 +0200
Message-ID: <20250819095915.711085-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use memcpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/debug/kdb/kdb_support.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 05b137e7dcb9..d36281142fa1 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 #include <linux/kdb.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/ctype.h>
 #include "kdb_private.h"
 
@@ -246,11 +247,12 @@ void kdb_symbol_print(unsigned long addr, const kdb_symtab_t *symtab_p,
  */
 char *kdb_strdup(const char *str, gfp_t type)
 {
-	int n = strlen(str)+1;
+	size_t n = strlen(str) + 1;
 	char *s = kmalloc(n, type);
 	if (!s)
 		return NULL;
-	return strcpy(s, str);
+	memcpy(s, str, n);
+	return s;
 }
 
 /*
-- 
2.50.1

