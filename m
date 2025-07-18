Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D416FB9
	for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874856; cv=none; b=ZadC1+bVjDZ/rIYoy/5Exm1tu6k6BmHhMfGmcF9vK3RccpL1C8JGp/69J7pHWPiH2wNa7RH/7V8ufjQd1tZ+SfPNJgKZEHAlJpdvXDKHglhgvHDgbGlzhe4Y0FVu1UuI6R9PXXJk19LDuA1sL91d5vlLeE3qzjGN5o3e3g/hpCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874856; c=relaxed/simple;
	bh=9gJN4BCqjjG8aHuP8cz+e/BgvZIZ8eMco3DyItys3J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUC5iB6Udg/1yC8kcQkLW+GXqcbSt8yF+Xf+d0skS8qcgsXdyKw4zjSBNnnt9GjFn5TE4a0fgIYcBSmMq3diTfa0qpFceU8+qsrXd9u0QlGRKJjaVO752Vz5hc+dfq6IpJVjd/Kk6Nf9+eyaoaIkbVVL5qGjyQBL4p/uPwq/dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WnUUOWvI; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WnUUOWvI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752874850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QW4XK89RatdkYPZUcwlE29jtrnSLNj8LxMNSgYJVlUE=;
	b=WnUUOWvIiqT79DilmC/4FeC66HxD8L2uIH6N5+l5Au73TYHMtJ3hIpETNvOZqcjRpETe2e
	uezxaGT8ul4ttAhLabiOvBDDH00pL2RoginFofQvqKAyo3DauvCH2iYruBDTI0xwwgDJ2R
	e+5Z1zGCYsT9+HFw5iNlvlPtCHQeBdc=
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
Subject: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
Date: Fri, 18 Jul 2025 23:37:23 +0200
Message-ID: <20250718213725.348363-2-thorsten.blum@linux.dev>
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
 kernel/debug/kdb/kdb_support.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 05b137e7dcb9..158430a890b6 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 #include <linux/kdb.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/ctype.h>
 #include "kdb_private.h"
 
@@ -250,7 +251,8 @@ char *kdb_strdup(const char *str, gfp_t type)
 	char *s = kmalloc(n, type);
 	if (!s)
 		return NULL;
-	return strcpy(s, str);
+	strscpy(s, str, n);
+	return s;
 }
 
 /*
-- 
2.50.1

