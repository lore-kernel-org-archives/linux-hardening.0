Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A224BC13;
	Mon, 24 Feb 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391217; cv=none; b=ehVOq1gEmuNYoG39Use/e0gkLtnTnAM+hJMWyYd5AlrrRmzHcWhEdzTLWXhvp2k6KzCCtzwstBz6xs/b7qCX7EuD/fmWpfUNHGuoLWd7pFTlLbM1LxS03qJxEJhEUpBUOgxeD/VZEA+jdI62ITVmuZ+6F2zJ59De0nIqgUgpsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391217; c=relaxed/simple;
	bh=A9uQN4pgxmAPTKbOEg1GKq42g3z8N6rW3R0Aq49Zw20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKAmEnuZjBdVmTQMq6MkPJlUljoizkE5YmAypqO+XN1tv7xTK1Z9UBegzHisRAZr9Ua3d+1dwcuzSFCjjKBT+dE9Y2TppuMostP3hZwZJpxxWDK0u8oFm7+R+AVHPt1YywFmS7i59uod9tykJYBfV+wzw/hRcBee1yoGg9zYkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kviluAb3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kviluAb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EFCC4CEE6;
	Mon, 24 Feb 2025 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740391215;
	bh=A9uQN4pgxmAPTKbOEg1GKq42g3z8N6rW3R0Aq49Zw20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kviluAb3twh1PVkiWcvpyCDARNe8MqrrYLW2h9yUrUrTn0pZuxFzbRasUoA7YNfA+
	 4NcigM7MZHIHxgohf/pvmh8bTMswk+qy+cOjP+09JtX31wZJkMQ8kMLtOZSYgVb5YE
	 yZpKlXTIPXdd/x02BnXhFBbk3h1dGL+4kFp02pRiWpnUKOOerGvOt5QOjAe77KMWEn
	 beuBiIkJcxm+hsnXQfArXZv46IR/pOLedE/n26LtuWcQ+cvBDssv6gQR9xy3NuVCYw
	 jUrfb/X/mdPaEXSPtWPfweAz/V0LFd636YsbjCo2Rs3g8ng5NW/j9fe2FoB7ULeX3x
	 7Msv0TPr4OQfw==
Date: Mon, 24 Feb 2025 20:30:10 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 6/8][next] nvme: target: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ef7a6920384ab2f8f83c0f630f94edc73cd65997.1739957534.git.gustavoars@kernel.org>
References: <cover.1739957534.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739957534.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Change the type of the middle struct members currently causing trouble
from `struct bio` to `struct bio_hdr`.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure `struct bio`, through which we can access the
flexible-array member in it, if necessary.

With these changes fix 38 of the following warnings:

drivers/nvme/target/nvmet.h:455:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/nvme/target/nvmet.h:462:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nvme/target/nvmet.h    | 4 ++--
 drivers/nvme/target/passthru.c | 2 +-
 drivers/nvme/target/zns.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4be8d22d2d8d..13ee8026d3d8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -452,14 +452,14 @@ struct nvmet_req {
 			struct work_struct      work;
 		} f;
 		struct {
-			struct bio		inline_bio;
+			struct bio_hdr		inline_bio;
 			struct request		*rq;
 			struct work_struct      work;
 			bool			use_workqueue;
 		} p;
 #ifdef CONFIG_BLK_DEV_ZONED
 		struct {
-			struct bio		inline_bio;
+			struct bio_hdr		inline_bio;
 			struct work_struct	zmgmt_work;
 		} z;
 #endif /* CONFIG_BLK_DEV_ZONED */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 26e2907ce8bb..bff52252ffb9 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -268,7 +268,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 		return -EINVAL;
 
 	if (nvmet_use_inline_bvec(req)) {
-		bio = &req->p.inline_bio;
+		bio = container_of(&req->p.inline_bio, struct bio, __hdr);
 		bio_init(bio, NULL, req->inline_bvec,
 			 ARRAY_SIZE(req->inline_bvec), req_op(rq));
 	} else {
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 29a60fabfcc8..afedbd984d39 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -570,7 +570,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	}
 
 	if (nvmet_use_inline_bvec(req)) {
-		bio = &req->z.inline_bio;
+		bio = container_of(&req->z.inline_bio, struct bio, __hdr);
 		bio_init(bio, req->ns->bdev, req->inline_bvec,
 			 ARRAY_SIZE(req->inline_bvec), opf);
 	} else {
-- 
2.43.0

