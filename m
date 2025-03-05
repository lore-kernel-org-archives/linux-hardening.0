Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A612770FE
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137102; cv=none; b=d4ExKlfvbvMFvKWT8rVKgv/hxsd+ysuoNRQS0VaRL9yu5fW+1McTcfDevchjSJXYkybQhy85tCKRsPwkmev2QTuvk7HW74ijImsDaAnmJNmq4T5ga9kc+Cc7w0veCsiTnFosdC15CDLsm834njE9ccPmQWa+xBqe11Fvay1JIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137102; c=relaxed/simple;
	bh=FNxvJ4i5f2XwuDmA6j1Sa8aqNIwlPZW0fGf9vRBkM4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4ND51WOhrK+G3h27TfjmCMOa2f12XaXze1fcfzNFjmscFxmC67wQgrjyASa7RERfrmNg/MzwEp5u4kWSP4xNOTOm3WPpD6vfV0TvlmNHX4B4+lnJQM1kfrU+VrIob5yO5KnASkTJc86/QMQAd5nRVv2MEDwo/FMi2FAas6LyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJIJu1+P; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJIJu1+P"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741137088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RHS2qHcb2Sj4DUzb5BVeKI8CQswnw3nvUmflGuif8EA=;
	b=FJIJu1+P8A8CQmcUZXFpmID4+e+gh6xjVKgrXKKcfy+WtH5yRGaPIoGI/jkXx8unO6kmSj
	Dvmhg/O+yBBrp7NiEQ0zuYcDe9aT+XwCCDQVw1p3et/i+z1Hzt/5M0DPjVi/wFaRJ5Rpcr
	lmON1K4IAmZj6oRUnC2niGXM47rYIRg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: Replace deprecated strncpy() with strscpy()
Date: Wed,  5 Mar 2025 02:10:21 +0100
Message-ID: <20250305011020.160220-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/xfs/xfs_xattr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 0f641a9091ec..9f9a866ab803 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -243,9 +243,7 @@ __xfs_xattr_put_listent(
 	offset = context->buffer + context->count;
 	memcpy(offset, prefix, prefix_len);
 	offset += prefix_len;
-	strncpy(offset, (char *)name, namelen);			/* real name */
-	offset += namelen;
-	*offset = '\0';
+	strscpy(offset, (char *)name, namelen + 1);		/* real name */
 
 compute_size:
 	context->count += prefix_len + namelen + 1;
-- 
2.48.1

