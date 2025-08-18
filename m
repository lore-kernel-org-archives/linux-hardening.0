Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413A2F30
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540827; cv=none; b=lAkmCVCeDnefDuVQugOoeRcEGibvZfeVMxerxrSRUEmtVBUsudTIBkTnaNkq/m73KDM+S7FQwVQZ60xWOLRvT30bT6WQcsRD4vEmuNCyy3NKPlh4OvMv9f29Qrm+eXGCeIVVKNs46gdP1DtGoOd5AKAxGMdI6DCSFHW1J7WElLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540827; c=relaxed/simple;
	bh=Vhlp670jIoJlZ3xHQzXSWtWPJcSriIWz20Lo5ruwtIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ne/9IraSy/rNGReNU2+VXnl24av5aKPYnqkPJ4NL5OwtDkLjdtXytPgY83b7jxofbdeJ5IghD3F+4GHGdtkpiz8dopmWhzva2EaL13LRWaAO+ayP+9Fdv1gWK0TuWTyEgtOUXhJ/E5IPOpMF/nyWm12BZWF3Qfc1QvtHX3Df9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cRMKiFUr; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cRMKiFUr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755540823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zavKxT3WRsPMSCRKqhVeovVHLiznL9SJiEUmezaibh0=;
	b=cRMKiFUrzrwk0xkdc1bJ+8av3chXjVF950LPMwAf1YtF+rPW/1Pb8pq3mVXwElNPjs4qWf
	2gRnF3stPIC6wExoiaI/NGcb4c7fM+X55vzk8zBWVSVaV9KUUufJmN453CBBmzv6J0RdD/
	J+WU3kAFcKDleev5bR9u6ieaG00y/LU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Zhang Heng <zhangheng@kylinos.cn>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] kdb: Replace deprecated strcpy() with memcpy() in kdb_strdup()
Date: Mon, 18 Aug 2025 20:11:41 +0200
Message-ID: <20250818181153.661431-1-thorsten.blum@linux.dev>
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

