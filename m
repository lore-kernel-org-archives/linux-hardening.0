Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35831BD9CE;
	Fri, 28 Mar 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171911; cv=none; b=bs8g83jRFn59wvDq4bSxsJ7UzdVZlZY88p1gA/94ZsMnRReUdIxe/eryuaT9emoZeJQnhp32IPfSjwGUMZwT/bH2H72+0FqY3b1FyaoV2dQzFDCUpOInkCCrWHLpbzqjPmnvTCTb/L6887FJjKuF4TmA1feCTQ1gZOTg0DIxiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171911; c=relaxed/simple;
	bh=NF/NsSaGzQgrMigKCwS79D/GaMkgDB1dF0QZBIL8yIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O2tjvxUPO4W62YdMLpgjKvHC7g9MGdov+SutBfaxTVP7W4bBS2pKK+LhPa03ePVO31DjQsxxotL8CC5YhaCvK03vGRFDBCun9pz0VV+3hpTizz/si8iYOKaUgegCuNVzfhDpQz6a8b6L01+hJ8iSNSwdudk1TuHKp28ClmeE+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssWLEUdC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssWLEUdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2C3C4CEE5;
	Fri, 28 Mar 2025 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743171911;
	bh=NF/NsSaGzQgrMigKCwS79D/GaMkgDB1dF0QZBIL8yIY=;
	h=Date:From:To:Cc:Subject:From;
	b=ssWLEUdC5GNsvoMJw38U3qhtmJvRq8N1dBTq7LkgnL8xO0IlrsTkgpZumRr0pG3AX
	 aFzuIbON/gO2TowE6260ADpKUebYVtEPYQ27EbonDBXNKWVpUvLKv7mamMzORYOUGi
	 MhY41QxstEx5GV51XPMYOS5dMwzekAgNGWvmSBvigv44abzCnlgAtr3sLfVCRepwsS
	 J9e+G6gOPwWnm4BINDcgUofRaVzpRImDNHLMCr6xVjZgXPB/0SJPkzdhrvSYf+IdJJ
	 fJ6sRdSKD1TDKKF/IT5l2oeaZcKjdTKp5ePxPCLOmbzwxrkDgM0azke3y1GsV6qcow
	 R7DZCpwq7wKmA==
Date: Fri, 28 Mar 2025 08:25:08 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <Z-axRObjXYjIHGQC@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct nvme_loop_iod` is a flexible structure --a structure
that contains a flexible-array member.

Fix the following warning:

drivers/nvme/target/loop.c:36:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nvme/target/loop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index a5c41144667c..d02b80803278 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -33,10 +33,12 @@ struct nvme_loop_ctrl {
 
 	struct list_head	list;
 	struct blk_mq_tag_set	tag_set;
-	struct nvme_loop_iod	async_event_iod;
 	struct nvme_ctrl	ctrl;
 
 	struct nvmet_port	*port;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct nvme_loop_iod	async_event_iod;
 };
 
 static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)
-- 
2.43.0

