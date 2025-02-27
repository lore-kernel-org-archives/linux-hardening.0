Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A823E345;
	Thu, 27 Feb 2025 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698219; cv=none; b=GUOqpHqrYx2AUY0z6G8MuFaLHdaRAAzMl8HCZrN2VAtv820Z4lCxFAS8+VJXG7gcrPS98IObevszcAke+ssQlXwhscamgshgRTVXh5BHz4DwylFpXJC8A0uqenRojcAtmroUQldaQONx2IJTa5VgFxoFd79U9yPvIBDaKbvv4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698219; c=relaxed/simple;
	bh=cAV7WBwuMNIg8mUstqxd2CG6goEQdSkmSbHl1v/E+LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOe9socfOt1LBeqci4FbFMn878Sualy8ZAFJO0sx9pij74HMOOMMKpy1rGhDfZ05KNjq6ThYLuJr86y0wp6HnkAgTqUWBkGO31CMOtN2gqDW/rw4ANr0onwvIyi1ITMxzie9FbVeaV9MydV4KMg+bObPyP91KN78gQNTWwVQnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=tJ6hnfQL; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="tJ6hnfQL"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z3nKX23KVz9scS;
	Fri, 28 Feb 2025 00:16:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740698208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfrIERDSLZU397qOA/JWnUat3PPhKFnmrvFYp1l2KP0=;
	b=tJ6hnfQLISYQEdd8MyptdSleD2L7nLHcIH+WmU9+75rNs6cmweOwCE+C8Gt7hfdUDfuRcb
	/Jq6t7nijBqfK+cWm95AY9kiv7UMV8076202zFlTl5fWOhvhsZ6C7/GQJtONEBDKFWPld8
	XhkGtk7kpCSbWfvbR45NPzyf4zRHrAn7vVAZ7crJcWEyj6wZ/D5jzUhDre8RBMOi2KR+Hp
	gOAhY0vidViwuPCskr7PgzArpH3dYyqklgXGNreTFiGNHt7sD/Y3aRxlm04Lzd7zqzzjVp
	7e9ednbaNwq+1Ylkr1DNQJW/71TTEuWSBAu49T6furLB46WSzcgalbuXPqbptA==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Thu, 27 Feb 2025 18:16:22 -0500
Subject: [PATCH 2/4] drm/amd/display: change kzalloc to kcalloc in
 dcn31_validate_bandwidth()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-amd-display-v1-2-52a060a78d08@ethancedwards.com>
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
 bh=cAV7WBwuMNIg8mUstqxd2CG6goEQdSkmSbHl1v/E+LM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBCLzRGUFRwdnFQMnRmaHpSeFk1TVcwdzdWMjUvV0JzCnlqYysrZTFacXU5V2JWajJ4
 SEo3UnlrTGd4Z1hnNnlZSXN2L0hPVzBoNW96RkhiK2RXbUNtY1BLQkRLRWdZdFQKQUNZaU9ZR1I
 0ZGZXbzk3VmJHcS85Z3VXbXo0WE9WRy8vK0p0eWN6eis4K0hDVGszM3BVOGRKZmhyMGl6NHZIMw
 oweTEwV2xvVG1jcGNObVJrK1p5ZDFzYmJJUDNWUUYvUVZQQW5Hd0MwMmszZAo9TFU0MgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows. Here the multiplication is
probably safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 3c42ba8566cf8b79106de25c9e0aad4a70898ea6..dddddbfef85f8f65a6f76c86cbb6db59d608a74b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1768,7 +1768,8 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 
 	int vlevel = 0;
 	int pipe_cnt = 0;
-	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	display_e2e_pipe_params_st *pipes = kcalloc(dc->res_pool->pipe_count,
+			sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	BW_VAL_TRACE_COUNT();

-- 
2.48.1

