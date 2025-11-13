Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F08322C63
	for <linux-hardening@vger.kernel.org>; Thu, 13 Nov 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070996; cv=none; b=RcREZ26jQfwqsztv3yGD8gdcqxsfrC6wi0Pja075I4Mjs3+d9e3Kg5K3HzBF6xHNaELzbX/1/5fehXozROV5JXsTkH3MKeQqjX5fiXdxYoX2rkgYLfTPn/qEy+3crZH67tgf+OvpRvCbIPMPjqN3odJTK4y02tZL+38t87Gg9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070996; c=relaxed/simple;
	bh=Hj/vGHJkGTDEUCDpd6JRPpsho1dl2+jAEyv7pA6d87E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYLdTliIblqml4LYpLBIXhxwgRL2CzYbTyZFogHlHId/p+QzcSmZeGEIXA7p2ZpXCeednnlQhIgE8qQ4366VnPenr8/xrtaz8agwbSACeLf+HlCvzQyawZ7yfGkCu3prLEYpbt8o+kllRoeqcRNYOPlqdyboC/FtjnvVA8iy5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hxtL6MJm; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hxtL6MJm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763070972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HqcCOeVHkjMug9T3azqzq6UC1S5Mba8UPr7MVprreyE=;
	b=hxtL6MJmKMt9lIBsmDsAkAdKqG70sSThtNAGYQqC+f+fQHG0MtYgI5r1se925VckiEK+BS
	wZhX2F5Yy97M1YPcTizFSw7THeNhUoyfDXOBN6cGJ0a+mMapVP9KHiQRGLcpfkB95vEUjU
	CkIUYspqSEvGKNe6zY1T+r5qSRjOQ4A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] KEYS: encrypted: Replace deprecated strcpy and improve get_derived_key
Date: Thu, 13 Nov 2025 22:55:45 +0100
Message-ID: <20251113215546.136145-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use the safer strscpy() and use its return
value, the number of bytes copied, instead of calling strlen() on the
destination buffer again. String truncation can be ignored since
'derived_buf' is guaranteed to be large enough.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Revert some changes to include the trailing '\0' even if key_type == 0
  since this would change the bytes passed to sha256() (Eric Biggers)
- Use strscpy() and its return value instead
- Link to v1: https://lore.kernel.org/lkml/20251113135831.98587-1-thorsten.blum@linux.dev/
---
 security/keys/encrypted-keys/encrypted.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 15841466b5d4..94408909f1dd 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/uaccess.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -330,23 +331,17 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 			   const u8 *master_key, size_t master_keylen)
 {
 	u8 *derived_buf;
-	unsigned int derived_buf_len;
-
-	derived_buf_len = strlen("AUTH_KEY") + 1 + master_keylen;
-	if (derived_buf_len < HASH_SIZE)
-		derived_buf_len = HASH_SIZE;
+	size_t derived_buf_len;
+	const char *key_name;
+	ssize_t len;
 
+	derived_buf_len = max(strlen("AUTH_KEY") + 1 + master_keylen, HASH_SIZE);
 	derived_buf = kzalloc(derived_buf_len, GFP_KERNEL);
 	if (!derived_buf)
 		return -ENOMEM;
-
-	if (key_type)
-		strcpy(derived_buf, "AUTH_KEY");
-	else
-		strcpy(derived_buf, "ENC_KEY");
-
-	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
-	       master_keylen);
+	key_name = key_type ? "AUTH_KEY" : "ENC_KEY";
+	len = strscpy(derived_buf, key_name, derived_buf_len);
+	memcpy(derived_buf + len + 1, master_key, master_keylen);
 	sha256(derived_buf, derived_buf_len, derived_key);
 	kfree_sensitive(derived_buf);
 	return 0;
-- 
2.51.1

