Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338A32D433
	for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230284; cv=none; b=GZY0VhrbjtSM/sXGbamEzYZfPCq0WFUBQOQDxrA+PcwN+XCRDeNJzW1I+6ImGfkAAkyjcID1cOFTYoiiDAirDEZXtLQ3hw9MCYD9pYBjUqkhBJpUUjYitNGhP0s/yP1DMPrMy0FZfMklVYj7vLb5Kg+fPzOagtuwpthrhhjRnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230284; c=relaxed/simple;
	bh=HWuLcpUwgmWBZl5oCwfRlBmKOMsRnsJvFkzA/wPWtCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkkSpvhcSsyCWsxBWjvd6zaSnHgPiAaMiwmPyqGLpfeuybT0AcLx6qyWCIe6BFc/C6f3cH7kTFobqt06B+aqNuqWwDmlk+b5OUV/infaXR6MmXUceNoinhcN3EbHdri7KwcOddRMjotl6lUHZazZH0mWL5jG44YuXIqTMWjmfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDoOzV5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDoOzV5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F75C4CEE7;
	Thu, 23 Oct 2025 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761230284;
	bh=HWuLcpUwgmWBZl5oCwfRlBmKOMsRnsJvFkzA/wPWtCs=;
	h=From:To:Cc:Subject:Date:From;
	b=BDoOzV5GEgtCGA8hJTYmZRSdMlrRdEWe7whcJMziJT0i7tit1kpx6Mw+DufqSHGKC
	 ak6/KKQz0zuTl1prbU58PbtKmtUZRxjdeN653rY+xpMs4tAv1FH6mDpN7agwcuEJEw
	 ILdXOunpT3LFwYqUmxtUDmHRfUBLVzWlytf5CaQxRbyCO4aLa1x5e1onkb6YU+VtZ1
	 tYM86xmqk6+U6duEBVG2xSSKHfD0mLwQvvietXW0b4jtsIm1j0hbbgamyzuU63YLEQ
	 KlwzUAX59rqAtdKpdoAEbCgu+kaNPxEf8BDl3CiuID9sv5EtDUM2IptVfLBin9z3ag
	 AdhvDO72MK/pw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli " <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	tzungbi@kernel.org
Subject: [RESEND PATCH] pstore/ram: Update module parameters from platform data
Date: Thu, 23 Oct 2025 22:37:55 +0800
Message-ID: <20251023143755.26204-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update module parameters `mem_type` and `ramoops_ecc` from platform data
so that they are available through /sys/module/ramoops/parameters/.

`ramoops_dump_oops` isn't included as it has been deprecated.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 fs/pstore/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index bc68b4de5287..39936d6da0dd 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -864,6 +864,8 @@ static int ramoops_probe(struct platform_device *pdev)
 	ramoops_console_size = pdata->console_size;
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
+	mem_type = pdata->mem_type;
+	ramoops_ecc = pdata->ecc_info.ecc_size;
 
 	pr_info("using 0x%lx@0x%llx, ecc: %d\n",
 		cxt->size, (unsigned long long)cxt->phys_addr,
-- 
2.48.1

