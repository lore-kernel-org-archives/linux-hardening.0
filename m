Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4452E3B15;
	Wed, 25 Feb 2026 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042807; cv=none; b=Y6/5SBAiV8Xq/O9iR+qYY5QEBqHyQ1xggDBtoUgGvcZ11kOIMjJlAmONNnJQgUrOPJLbXKVEcnWXyXzoWBTRfrQ8R0xyzjuFzkkh5r9U1IOuVBs1Gq7n0UFPvD+L7SAM1hGai1Alh9J8ksfn9+QxFNBsjgfxkl4O0LSv9SLLQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042807; c=relaxed/simple;
	bh=5jecAdD5KllNmzOg7FRaWKsueClWFJm4QGj8F4ug58M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHxDr4TR9eDPiUP3QkxSRmqx1tvEb/u03/hd8n3HqnIPYLyBnTEvzIROxyaw8VmmLmzmD2YA2VFSVqsyoXS36fph3eYCTXeHZlWxaYZVWLnA+BaYTm7WDjOt0fFvNasxYLIX9W9/zMvQgaGac0t0rxuOhV461OCyzRHh4xu0EVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uk4hmUPH; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uk4hmUPH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772042804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tlpzGUTFPW3cLO7x8OT4LkM8/WzI/eOUKAvfgyaDTQM=;
	b=Uk4hmUPHXW6BA5UJqYcUKjTbxA8LwtQXJmT/YlLTYSKaMjQnG8H4OEt5oGHygby0jiRNgc
	O7YGbDcJCdsb4p4kIxu7TnJ+boHJRYi62U45cg+Ct30k+eGMS22qeWKoaJ7Q7HM96tHdWQ
	ytea5FrCFZR3oUvMaFTb+X9NyiIDkXE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] most: usb: Use kzalloc_objs for endpoint address array
Date: Wed, 25 Feb 2026 19:03:29 +0100
Message-ID: <20260225180329.712101-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kcalloc() with kzalloc_objs() when allocating the endpoint
address array to keep the size type-safe and match nearby allocations.
Reformat ->busy_urbs allocation to a single line. No functional change.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/most/most_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index d2c0875727a3..6437733afee0 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -1009,13 +1009,11 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 		goto err_free_conf;
 
 	mdev->iface.channel_vector = mdev->cap;
-	mdev->ep_address =
-		kcalloc(num_endpoints, sizeof(*mdev->ep_address), GFP_KERNEL);
+	mdev->ep_address = kzalloc_objs(*mdev->ep_address, num_endpoints);
 	if (!mdev->ep_address)
 		goto err_free_cap;
 
-	mdev->busy_urbs =
-		kzalloc_objs(*mdev->busy_urbs, num_endpoints);
+	mdev->busy_urbs = kzalloc_objs(*mdev->busy_urbs, num_endpoints);
 	if (!mdev->busy_urbs)
 		goto err_free_ep_address;
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

