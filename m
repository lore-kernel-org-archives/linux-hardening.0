Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBEA274264;
	Thu, 27 Feb 2025 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698222; cv=none; b=AoHszEwoHlWfYJzCI8/2yklLZCIBYfViIZpupqrb0bRXQdAzwUDquA3bRiLtD97AjFHRxAO773CnLk9915lEZVWsnv2O/fXHYs6Lv/nMUZ1IyGyEAo9kK5hT5I1VTGX2V7GTGKk2fJgsWZfaN3c9EsUCMK1nfbZCZfwaRjjP7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698222; c=relaxed/simple;
	bh=lhEkQHSHKxxPjFm3cTGvCg+tLSulTLA3kG/2/zxmN6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9N3uyp6CSxpZ/YcnToqhdpoSgMa1Pk8OiM52LcWfCsldORDh3MWtr33sSlb/fJPRrn5VgFmKITB9wQXRizCxmgXlkA3T9LDblc3mBnC0jxTg2pHvbBTCCbdLV31uphP4WvNPHjg72b1CXe78WqkCoNMKWZwqO1m4eqyZiDOmB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=h7HpFEDg; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="h7HpFEDg"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z3nKb3F7sz9t8B;
	Fri, 28 Feb 2025 00:16:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740698211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dseSSk06wU9SM6m6oJmDceqrN9+4jBBoifE50IN8BVw=;
	b=h7HpFEDgPbMibIp9Oa9ArHCLHqiaIT5s9lHkH1hxekL4XWxgljHuH/qQrD+tzJAVyoEYI4
	G/YvQjJazTAssJ22hSluaoxhUozLSWxHdWmMlntbpRBmGfwsfSNas9COZsKdh5Dy+dsLwn
	VCbfnm3PtaDMppLiyaVx/+PYi6YHPfQPuDJSU8MAqbR3BrfLI0PG0bDa7uanZGdAH7Su8s
	O5zYRc/lWBhzFy27XwFgJW4rgfUYtnFX12tn3OpJgfyjInYLZEn2GmRMHVXHqXdrlGF76o
	n3jLywXfsE6jYIm0U0ljnl0hB4EEirfe/dzSAd6xHoSiExjbIxDBRxbaEdjWHQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Thu, 27 Feb 2025 18:16:23 -0500
Subject: [PATCH 3/4] drm/amd/display: change kzalloc to kcalloc in
 dcn314_validate_bandwidth()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-amd-display-v1-3-52a060a78d08@ethancedwards.com>
References: <20250227-amd-display-v1-0-52a060a78d08@ethancedwards.com>
In-Reply-To: <20250227-amd-display-v1-0-52a060a78d08@ethancedwards.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=lhEkQHSHKxxPjFm3cTGvCg+tLSulTLA3kG/2/zxmN6w=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBCLzRGQlNyWVBPNjZlbGFObGVEekpxdCtmVkdBVEsyClBYYnlMNWdYTGxldnpGM1Bk
 ckNqbElWQmpJdEJWa3lSNVgrT2N0cER6UmtLTy8rNk5NSE1ZV1VDR2NMQXhTa0EKRTlFc1lXUjQ
 rM2JIQ2hrUGhZS1czMWFyb3F3ayswb2R0OW9kTFdTZitNOUc5NXhEd1A4bmpBdzMyYmZGMkV4Vw
 ppRzhPK3Bxbjh0cm1PTS9INGxQN1ArKzludlpUOWVwblAyZFdBRXFpUzdjPQo9dzhQQwotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows. Here the multiplication is
probably safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index e3ba105034f83434c3e77d343ee267069d34d926..26becc4cb80408cb2778f6af62c7a1c497f06505 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1704,7 +1704,8 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	int vlevel = 0;
 	int pipe_cnt = 0;
-	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	display_e2e_pipe_params_st *pipes = kcalloc(dc->res_pool->pipe_count,
+			sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	BW_VAL_TRACE_COUNT();

-- 
2.48.1

