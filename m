Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F81EB194;
	Thu, 27 Feb 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698215; cv=none; b=UcgPq67zy+uUG6PcQC67+l+brxPyPJT0D8gcpGiVGk2cwNMACwkGxEcNdD4jzRXD2qn0p/b45jbSJrzwTI2TVfDLRNckRm5fT2qFIVVwOuQyhNf5LWzGGQNxHRsJNP1yrT/3oy4+Gx00Nzq7Ce06JXC+B3ABou9UOrjVZbo5PNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698215; c=relaxed/simple;
	bh=u7vnqoCjzEN7idDPPXOM4ANAbPQK8hXNdVN74EcTtxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NMPc+K18Dh75MQHA8lkWBqhUeOQuO1uF1WDxOrwp77zdJ8uLnJoJ5guoQbGP+8SDKY929pHZcTcAbKrLRd98SnaRInD7dWSQ/bK3A08nGIayrm5z3LdPyMZMNHxaOijm3PVeWII+szC0jFe9MEfcdQMJPQQArfT1PxKB2uXSTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=svjshTVj; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="svjshTVj"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z3nKS3Hllz9snH;
	Fri, 28 Feb 2025 00:16:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740698204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BB6ILLQuglhKF+aJYfRV6n3Xk95WLF3u3UgdSQLbcw=;
	b=svjshTVjstPuhk0FQR4GMEWQaecqfdw5cVL1UamMUufwa7IxLQ8tjiM3Nsj2C6aNaiOGuZ
	3csvZEEVP1TBdfr6Hm0xcrtCTr4ZEiMtE0pjXK6WdHarYaqmCSTYPIEW0NP5vKFbkjYnHQ
	IIdooM1fgBUAQ8Cht6gOEBbAT+31NUYNEAuGpAA7lqMTRIZueDPPyyDlmHO2fYbRgCOX77
	mH8D3U7fYXiuIzGEWR1iKr/ItEopLJ04wD12AwgsZx4TgECIBiJh787rD9/BbWD0lf8sXe
	1FjPOp+hHav8Bwwxtqtds/AX3F1Z3K4x1iZzvkuAmx14YrnojE4wPMsycawqhw==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Thu, 27 Feb 2025 18:16:21 -0500
Subject: [PATCH 1/4] drm/amd/display: change kzalloc to kcalloc in
 dcn30_validate_bandwidth()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-amd-display-v1-1-52a060a78d08@ethancedwards.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=u7vnqoCjzEN7idDPPXOM4ANAbPQK8hXNdVN74EcTtxU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBCLzRGQlNySlo0Y2UwMnQ3K3pmdWJ0Y0Z1ZWtQVW1kCk44WGg5by8zZDVST3ljZEh1
 OWQxbExJd2lIRXh5SW9wc3Z6UFVVNTdxRGxEWWVkZmx5YVlPYXhNSUVNWXVEZ0YKWUNJei9qTDh
 sWG9XWWI4OTIvKzZXbmUzY2VxODhrTVQ1Vjc5WkphSlhSbFMzU2kxMjBoY2pwRmgwdHJvSlcxcg
 paMFNLZmY2L3dEU3hQMzlkNG1HcDNZNEpDeDZXaCs4NWQvZ2dEd0JQR1U5Zwo9MWZIQwotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows. Here the multiplication is
probably safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 13202ce30d668e0c9e66632a9016a1597e2705b2..f01ced0150726b2efbd123de0084101cfc763ff5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2047,7 +2047,8 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 
 	int vlevel = 0;
 	int pipe_cnt = 0;
-	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	display_e2e_pipe_params_st *pipes = kcalloc(dc->res_pool->pipe_count,
+			sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	BW_VAL_TRACE_COUNT();

-- 
2.48.1

