Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB152755F6;
	Thu, 27 Feb 2025 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698226; cv=none; b=sVk66x3HDf6FOsEGxWlB6OLLCrcUVM/t7LWf/crranHMB5Czv/Xsx+sC66Nwa32XjiuS1SXk1ORWL3fnwjdtCGN79umxoZaTlg5kCmQwn8bYyrDV8s+LAKKxPzgClRlz67Nksr7bMqDXEa4hId1EefdIxuLfGOXwhTKDT5GOWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698226; c=relaxed/simple;
	bh=24YShaBC0pMX9hWdPx8iIgoaysi2N4zb0byElG8tKlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJXd05z5zAKjrjQgTlUBHwyF4WmMKb2kzgO7HRVjtcXc8bcOUMZmcccZkijYUVfQW9cu5SfN7UPpfzZWvVIKijoMNpeCPrz8EgSz+sPYCb3yqGZ22a2YS6FtK/sAImqEb+hUNU+GX2SguB6xPeshL6RrBO0aMVCMr3tK8sXy2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=A5LMf7DH; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="A5LMf7DH"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z3nKg0cKkz9t9M;
	Fri, 28 Feb 2025 00:16:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740698215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBDZiW19X5cn3cuHGveHbiMlwS0ltwOdMSwNVeMLsVU=;
	b=A5LMf7DHg2J3Jqs6X+r3H3RrTVzijiBxOWa/Sb7yVRo3duj4dObBr9F+BVxg8agsOn030D
	/mqVCxZUkv8QhPj3m17QvSsAFiAEX7uLPBVfABHYxOxr4dNXn/R9La0NQI1CbaCYcM8wAW
	Bx/0Z5wmyS/TU72iT9DDBAjI6epQ+KJhLyqzo2p8b3iNEhjn5GsLL1OC3CWofozBp/l44o
	CCQqU9C01Kv7gFtXthRK8hhFyGdOrUiTgKzOhrE28fWtVeSsqsRKc3x3C4LMhAZ50tFlwx
	cZZ4K/2s6Z534/Yrn9lXspUE5mcLcF3XKPtIoiIWRiSp0uTnuTW25TR5QvvaTQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Thu, 27 Feb 2025 18:16:24 -0500
Subject: [PATCH 4/4] drm/amd/display: change kzalloc to kcalloc in
 dml1_validate()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-amd-display-v1-4-52a060a78d08@ethancedwards.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=24YShaBC0pMX9hWdPx8iIgoaysi2N4zb0byElG8tKlw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBCLzRGSlQ1SWVuUytaSnpxOFBUT3laM3Jab2g2RlZVCkVCT1k5L0REd2VXdjcwV3Z2
 cit5bzVTRlFZeUxRVlpNa2VWL2puTGFRODBaQ2p2L3VqVEJ6R0ZsQWhuQ3dNVXAKQUJOWjZjWHd
 UKzJ4VUgvVDJZUVpKUm5sdlh2NDcyaElIWHpGZVV2bm5VL0t5Z1kzNTJzNlVZd01mU2UyUE5xNg
 o4K1F6Z2RDdkMyZk0wakQ3L01oUzZpNkx3M0YrZjJVOXhiZXJ1QUNXTmxFSgo9ZXlXZQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows. Here the multiplication is
probably safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 664302876019072a77b9330229f7fe8545787396..2a59cc61ed8c918a4b5beb1d90bf3a8f77fcdeb9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1749,7 +1749,8 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, bool fast_val
 
 	int vlevel = 0;
 	int pipe_cnt = 0;
-	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	display_e2e_pipe_params_st *pipes = kcalloc(dc->res_pool->pipe_count,
+			sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
 
 	/* To handle Freesync properly, setting FreeSync DML parameters
 	 * to its default state for the first stage of validation

-- 
2.48.1

