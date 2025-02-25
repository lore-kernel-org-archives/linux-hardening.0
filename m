Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9421ABC6
	for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511631; cv=none; b=OVWqTEqH4O2p3ErHaZ1eYjM0Jz6C7UgjCI93dG2LjD/hMgCOzYwkgO9uQbq0UsAuvHlIdCiCVuqJDOC4woEqtv3I3coohsCFaC5vb2fclzIok8GwPj4FOwU7ScbvHm0SJH1T0r2TOrhNgM+9KI0xXkpCqbEu3BRXNd/CVu3te+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511631; c=relaxed/simple;
	bh=7rgzTj8hndkVmcmioNXrt79hnJiv5zKhBjTWJstLBLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqWdDc1rpMlrnMofKVq1zk3AhEWqGDG8UOofWd49Cugc+vRkmsiz/7whxDzyb+C6fVm5h7WCfd9sIkb012/xwb61aUglAlE2d9G7gs8/AtbOM+GwSbzA5Vq42LR7hbwqfSKtLFsPAjPpk61wIEgJaSR/TawiSpws1o4FWc18GQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SmE+VvgZ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SmE+VvgZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740511624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4k9CEs7wAsBYpq0KmQyOgglOrKZ8NjXAyBCDpKKsOio=;
	b=SmE+VvgZoUK+JeGMgYviCM06haJdXl4bZ0OrTYnM6DWfpBKFKr8M9fRqLS36y3J2+d2u5R
	RPxs1Tt6zfQ6YFiAFHRLY+6Q3XmwPDOfe8pbiUT9Ht3QciIu6j6uwPGhh65VusHtnz5VLO
	zSvOMZlDI4FPpOscU3HhgaUscbdBPTc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: Replace deprecated strncpy() with strscpy()
Date: Tue, 25 Feb 2025 20:26:14 +0100
Message-ID: <20250225192613.330409-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and don't zero-initialize the param array.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use strscpy() instead of strscpy_pad() as suggested by David Sterba
- Link to v1: https://lore.kernel.org/r/20250225092949.287300-2-thorsten.blum@linux.dev/
---
 fs/btrfs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 53b846d99ece..14f53f757555 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1330,13 +1330,13 @@ MODULE_PARM_DESC(read_policy,
 
 int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
 {
-	char param[32] = { 0 };
+	char param[32];
 	char __maybe_unused *value_str;
 
 	if (!str || strlen(str) == 0)
 		return 0;
 
-	strncpy(param, str, sizeof(param) - 1);
+	strscpy(param, str);
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Separate value from input in policy:value format. */
-- 
2.48.1

