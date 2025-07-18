Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD410957
	for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752871107; cv=none; b=d3Fb7LT9W1agaExSgxrRtFXrVCGngInUQkd8bQ0XYllXO35ED8oXaEyKr41j6DFz7uxztmUxAlW589U1uS2bde3ral8LDGrIMgpqMnuskJli5GY7Y+E38mlgoZGqq4xGOZAdJQ+45vfTtNIwmf7yUH1rAu+O3DFhbXI9/JBxNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752871107; c=relaxed/simple;
	bh=AlSsbH4kX1OcQbvP9Y1wqo3dCVOQoo2TxQ9akrFfIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQKMowvbs4hdDZiEnCnHCjOF+hUIbq94aaW/c/AyxRYA4j42d9xEwGmfJ5tu0XLoMGjq6aSvsp7+n215GtLW0zdeeRcNd8Azwb7n3UXgcxujbPqYoa1ee/ugKZhmlC2/HSwoC/j5Fdwd+ZXTpjRAl+1l3obxot3vv0605gXkWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cHfjIPne; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cHfjIPne"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752871093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=50pMAbyQnwdgTZJ9btJV+F/njGuW6C2RnKWeUz9kqlA=;
	b=cHfjIPnelcGPMwyHpn7fAW+3yO9rm+BYezUNfIMp9/0tTfvK2IBBVgHNm66GWYrUu15jdp
	AplKmxmUNpeUu2T6/INAbaqsKG3GXK+yo0wLIwZdrDkqms7qU8L3z5urv+rnMZtCsbnXw0
	XPiT96dfTJvaC1xi6TeaUIfGYpuDhdE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] audit: Replace deprecated strcpy() with strscpy()
Date: Fri, 18 Jul 2025 22:37:34 +0200
Message-ID: <20250718203734.347091-2-thorsten.blum@linux.dev>
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
 kernel/audit_tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index b0eae2a3c895..1605df0a171e 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -93,8 +93,10 @@ static struct kmem_cache *audit_tree_mark_cachep __ro_after_init;
 static struct audit_tree *alloc_tree(const char *s)
 {
 	struct audit_tree *tree;
+	size_t sz;
 
-	tree = kmalloc(struct_size(tree, pathname, strlen(s) + 1), GFP_KERNEL);
+	sz = strlen(s) + 1;
+	tree = kmalloc(struct_size(tree, pathname, sz), GFP_KERNEL);
 	if (tree) {
 		refcount_set(&tree->count, 1);
 		tree->goner = 0;
@@ -103,7 +105,7 @@ static struct audit_tree *alloc_tree(const char *s)
 		INIT_LIST_HEAD(&tree->list);
 		INIT_LIST_HEAD(&tree->same_root);
 		tree->root = NULL;
-		strcpy(tree->pathname, s);
+		strscpy(tree->pathname, s, sz);
 	}
 	return tree;
 }
-- 
2.50.1

