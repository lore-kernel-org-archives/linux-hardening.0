Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB771DFE24
	for <linux-hardening@vger.kernel.org>; Thu,  7 Nov 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976522; cv=none; b=DwrZBAcBI6p8TX70xvwsrbpRYKeJsriZknZgSnNDBxMVpEtsOW3x8EWP20iV4Pcdls1SdW+LfKCwEuMMQdpZJ71j8oiq/y3AuVrFiBcPqYUZXmpe1HHGoJk2XGjcdbacjgRTvx6REECEF4xqLfZ7/RO81DvIjdUW4mN5nUZ34Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976522; c=relaxed/simple;
	bh=Sdy3ffOIi7k8Sjn9zIVT7VcbkCSMRxGWs0fyYz9MKkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suing1+bkXXoWx2mYEO2SzMgx/7i+NwD54WtLLsUZGrJVOvf6ad/oppTBRNNWse1iLI3BtpBYhTXIXlSaVhtZCrVUdOXeolieqQUu3+IeXL2KIQ8F0hOwTEB9e7oL0n8GdBoNX3xWFM78PcU7zTFY56XMYe+HuwWcdDp61zclHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9RoF566; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9RoF566"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730976518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KFE8a5vA6V3Hg5gG1lNgnbGvgCy1xfGED61Xl0i9E8U=;
	b=i9RoF566EevHPQ7Z5ZbY3TBkMmoYawiVDMxzkPXpz/+dPFy+pn7nU1hs3G8N+Xp8jCFcat
	gfexKSDIw5p8L65qEeppbmR1DXtdHmF5OQslaWg8ePjEtqsQUDhszGLhF84j0Zor2bBZo+
	CYliTOZ2wGAqW3cv8chvmFo5TVckdfE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH] nfs: Annotate struct pnfs_commit_array with __counted_by()
Date: Thu,  7 Nov 2024 11:48:20 +0100
Message-ID: <20241107104820.1620-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
buckets to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/nfs_xdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 12d8e47bc5a3..559273a0f16d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1336,7 +1336,7 @@ struct pnfs_commit_array {
 	struct rcu_head rcu;
 	refcount_t refcount;
 	unsigned int nbuckets;
-	struct pnfs_commit_bucket buckets[];
+	struct pnfs_commit_bucket buckets[] __counted_by(nbuckets);
 };
 
 struct pnfs_ds_commit_info {
-- 
2.47.0

