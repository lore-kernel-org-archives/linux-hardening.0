Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9B3A16B0
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905108; cv=none; b=sKmhf6vVm2O/J5kOW751MB9Ch7f5CTND3CqcXhFBgdyxaRMNQvUQYIDlT+owmFb4LAdgaHIfp4h/E9Yjc8hT2Iw/uibP6KqPwrtQUb4sX9/2NHZ1wRdw51aLFjSFxJzfK1hZKJEJEB6f0QZD6hLlWv3MXKfwAUMbPpsbVYfZGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905108; c=relaxed/simple;
	bh=6srCrUIunOESXdde9Lcj4hv+k+VDJuR+qMStPX5yZE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3IM4QjasICuNFt5wZ6axFl1Z1ErZx5WBZvBVO9tUKqKfYwn5YWpbVBxRYL8HHOTF6D9flc6Fem45a3OpW72hTrJBaqgE7h8vYuSQMEO9oPOgYGcEESUgC+K2mYNVUS9QtVQLWA0IzpdkDLwWm1UvEPhpUW+e18OOFLsOiLIx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyvQsICV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyvQsICV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358ed696623so2235928a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905107; x=1775509907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEFkVMqVEgbf9JZ2fPYwngkknCV8f3b0OBCU5bCk5wc=;
        b=WyvQsICVhBz2bM+xo9DmlcWba0+frcevY/kEZ5RJE8orzF/fGVbW6m/u8I4SpP17at
         piSWoVd/DN1Ln6dZspqJwaDyWqP6f7SDX6/JGH2sDJPOtufR//twSliCXlg/WqJas/mP
         wV2ePpy2XPhHY2j820yjy4H2fYdlX3WfTxwCibOKiovgB25/SCR721u7bF1g5LXL958z
         gURUR/oyKGvzHebXuqMz4qtg14gLhIhK/G1k5pbt72UpmrFxAdNQqOyYaRGZSTthY6k4
         IR1sUSlIXE6i05huirrOtE91DRU2TABY/rXfNkYgnX+y5aV4SW+F38V0PISFfQ8A9VFD
         ltUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905107; x=1775509907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEFkVMqVEgbf9JZ2fPYwngkknCV8f3b0OBCU5bCk5wc=;
        b=h0/PeImr2hMbCX4/LTXsAAzsFJdY6eXsHGWMJio3VHWuB7w6UlTxnNx23BJrkGkPxg
         SZ6Mo1tRVm6ZXQhKONNiXFegyFP2TlNZk8teQCNV1YDZCLqZ4ZRCjsLNm8DrnSXg1GLU
         MPEy2RZUJeedwU8aUiNCxOj5UG3YHncieLGzywYJZWXNXRpgwRfbqnItLzxv/N0Nbd+t
         KR5YDVG4jrnlB8uyy4JoeSavW8l38qjO95RvinLnZOXrVaNa6FFScYq9rlTEqDFKAokw
         MYttg4lJQceGkH5UbMatlCkgZ1MnIcdh8L9LxujQBIJbZg0qIw/RzRbE95v+2pfimQhJ
         LAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbd1bCKRoVmBpW1Ib7w4h3izCkCL8oTv0j2ppGD4a58bath6uWKsox1YJKLHoXbiNICSYrRXT2OztZcRjDopo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF/0PIb8uGb6J+Woqx/1ZHXVBBYq1qnFKw1OoxabMHgGPFXVsh
	KpL2GjIdODPvrwSKqKvPZXRFzgIE0Zcr4AqI8PIPwUxt8y0k2kbLSpzz
X-Gm-Gg: ATEYQzyrZlSJlCkiSahXupPPwSCW7ssEjOgTGWYyyfBkaZAP48pQZNaNwwW0mO0fS0z
	3JJnuWCODm5oXXuE/sOIF9VSM3F0lAj8rgVf6U9AHm/5vQsw+Si6sEWRSxu2ex+tIWEgXMN4gnl
	bpovx6z/5GgONsan27TqzEXPoH7B68jaXF5hS422eoUl5vGRZDO/pb6TGVV0ZtxdFVrztU+kwcu
	B2Tg/wI97t2f1gBqoDsna0D63mUu//qTjR6YSHyTj5aUpsTqjRluCXRY8RIGqrijLCLFMWqbcau
	T2UYe2fiLZFdMUHAHks83kZzAQziC4NWKhJyJuFFeZlLODy4QQ2vHm7zEixIp8IQbt/qCmzyt+D
	1SJW4cDnkCWwsCwQGKFJiC/KYr5Jwq6KLUd4DCO0zOqdoiytWMq5GKHmG+GikkmP7nKGAkatbkY
	wShxvK0rdGN1aJgfO7VkEtFKsIwVTo7+9qcsLjL2jWdFMGYT0GV/35+/RDLSOJ3wBNIw==
X-Received: by 2002:a17:90b:1dc9:b0:35d:a8d9:3a8 with SMTP id 98e67ed59e1d1-35da8d9096bmr4974583a91.16.1774905106962;
        Mon, 30 Mar 2026 14:11:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm17632936a91.3.2026.03.30.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:11:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: dw-axi-dmac: simplify allocation
Date: Mon, 30 Mar 2026 14:11:28 -0700
Message-ID: <20260330211128.12319-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member with kzalloc_flex to combine allocations.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 +-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 4 ++--
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4d53f077e9d2..d3ca202dc478 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -294,15 +294,10 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
 {
 	struct axi_dma_desc *desc;
 
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
+	desc = kzalloc_flex(*desc, hw_desc, num, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-	desc->hw_desc = kzalloc_objs(*desc->hw_desc, num, GFP_NOWAIT);
-	if (!desc->hw_desc) {
-		kfree(desc);
-		return NULL;
-	}
 	desc->nr_hw_descs = num;
 
 	return desc;
@@ -339,7 +334,6 @@ static void axi_desc_put(struct axi_dma_desc *desc)
 		dma_pool_free(chan->desc_pool, hw_desc->lli, hw_desc->llp);
 	}
 
-	kfree(desc->hw_desc);
 	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
 	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 67cc199e24d1..a04a4e03eb3d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -98,14 +98,14 @@ struct axi_dma_hw_desc {
 };
 
 struct axi_dma_desc {
-	struct axi_dma_hw_desc	*hw_desc;
-
 	struct virt_dma_desc		vd;
 	struct axi_dma_chan		*chan;
 	u32				completed_blocks;
 	u32				length;
 	u32				period_len;
 	u32				nr_hw_descs;
+
+	struct axi_dma_hw_desc		hw_desc[] __counted_by(nr_hw_descs);
 };
 
 struct axi_dma_chan_config {
-- 
2.53.0

