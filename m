Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C953E714E
	for <linux-hardening@vger.kernel.org>; Tue,  3 Mar 2026 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573491; cv=none; b=XhIYYOjRUA/cIddibfP9odKSiZOFdXXcScqKbEmDTmD/afpR2R2tdHi1pecVkRsHdwk6ViYBPNl5ep0sdBTSJxEkz9+KD/VLFc4+vzLOxX8W1DqeeNCbEH370P0+XjakKOqDTh4EScVUrdCSvwETOVLoMrqwlj7XyWo7YMnlXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573491; c=relaxed/simple;
	bh=PwTwwqktZ3gW1Jqj92nq+R6/p4rm2Yr9+ncbAvRhLzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STSCoPz0GJPwIc6WIVlFGRa5SWps71Tosjusonu/yqdiBJ9QHvbgyx6B1bRd79Kc/L8bRU71uHmA6soODxTuUqTPTLr/TNaQ4hd98sAKRCGjpJlvn7gf5/IJRKk3qc65FgZX6cnJPhrQzIqeuv07RV9Gu1a+bsWPOWG4lOPiUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MnMyrbvZ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MnMyrbvZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772573477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BhfXApBIUsq6uQNF+gadNYk7qtXOqeeNSnRgXkrVeXU=;
	b=MnMyrbvZuGBJJwVLHFvHJZ2IBLRTxOZpR7SBwmcJIJSl+KnpVaQvVKg3rrtg8fNLyYeNIx
	lMFm+9h2SGIX/KBBQm7dNX+syPiGkfm1Y2aWvIP5USnCL29OgbABLq4ItUQKas1xhkpN2L
	V5vMVbO2CAtkBozPFWaQXYaUGsCLDqg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] nvme: Annotate struct nvme_dhchap_key with __counted_by
Date: Tue,  3 Mar 2026 22:31:01 +0100
Message-ID: <20260303213102.86585-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'key' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/nvme-auth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 60e069a6757f..e75c29c51464 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -11,7 +11,7 @@
 struct nvme_dhchap_key {
 	size_t len;
 	u8 hash;
-	u8 key[];
+	u8 key[] __counted_by(len);
 };
 
 u32 nvme_auth_get_seqnum(void);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

