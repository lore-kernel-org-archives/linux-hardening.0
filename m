Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3F23C506
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235706; cv=none; b=nTyiFCCzs+ULLvBEE2iLhLeWufHptx1WRj0hiUJoveY+JXU3JkA7n1zuSmljiiG7s8iLDY0OyG+W4nUMVGQvl0KRyFoyKvTYYXxeou8AtF9CX+zVLI4VXh/LL/cgtJgsOQcjEqEDDrphRoEDi0axHg/+2a58lk62U7hYys9UMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235706; c=relaxed/simple;
	bh=zTb5lU3bOBv3uhvXWPAdHa//auC3GGXQxT6n5kjBQtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/DvGw1cVSn2/h3kbbdkRF63jSxJEQDaLJPCbU6CUqWJBNHNapefWzWFIWVj0A5yqhPgUSuI1v03C5/B86vlNkZtr9DUJlEvIVhYTl8q85amDec8gD6gWGqyBZOtUEkwjz1YHERSQQMwy4DHyytmdXpwlL+EPEj+Bf8GCULAhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZGyPNfyh; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZGyPNfyh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768235692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AV3VJYCb2VS3o9hk7CFRfVKvN3jIf3bw5gdD4CzuZq4=;
	b=ZGyPNfyhhabzWRM/QtJGMuDpTlDWBY6sdekCd1ypPn/6nmu5/GoxdQAx1htE9W+sfRJxuu
	an25oLJ8L3rdmZGax25wxZAgVq7JzVTkQ80oKoZH+uDrdR3vpWeahXCLqoYSCP6XniFTVj
	6y62BvNDzQKqA/cLr+i8gVxJjowMDoI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tyler Hicks <code@tyhicks.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ecryptfs: Annotate struct ecryptfs_message with __counted_by
Date: Mon, 12 Jan 2026 12:53:11 +0100
Message-ID: <20260112115314.739612-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ecryptfs/ecryptfs_kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 62a2ea7f59ed..f58b12be8267 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -359,7 +359,7 @@ struct ecryptfs_message {
 	/* Inherits from msg_ctx->index */
 	u32 index;
 	u32 data_len;
-	u8 data[];
+	u8 data[] __counted_by(data_len);
 };
 
 struct ecryptfs_msg_ctx {
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

