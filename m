Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19651277803;
	Thu, 27 Feb 2025 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698213; cv=none; b=NUtjoBQfaR1QgzQJS5IIhrs1BXegwrDEageNYVVOYXHKsme7j55pT2yEFBlfkpaL6y+1Bn3XiKOg3ilBTme7Sm+cObTQI4fEtm/t1hNYkf6fxm+o72u+C8BQdZnizzrAnmYZYWa9kBe9iCZQgrzp53A8c8XmicryneXSz5ht/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698213; c=relaxed/simple;
	bh=qryNsb6eKMy0Wo+mVn5eYMTnjQFI42YtE83+U+++mzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L02nS06qUX40bU1F3XVwIMfsaLw9guwj0K/k4JcTE3m+gLwBZ4DsWnm7Vxl0u4sPE3KOapXsRqZz4LPv1s2mbGzlQArt5tFi7aUfBrfriAww4tZCgc94AF++t+cAc1jqObSYqfRs35zgqPQr0Um6rxut3ytjG94V6UjldN1Pudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=S2Bymyau; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="S2Bymyau"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z3nKM5dhRz9sqL;
	Fri, 28 Feb 2025 00:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740698200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ELa5D/D34VuKPMdQJYbPumskuGUUaVxi92U53xY248I=;
	b=S2BymyauBHssgWZ987eQDTAWbxsFchlBOYzi9MHvItPAKaITPnSTrmBUqTeC2yh4gKHVGk
	weGNfcdLf0wqWjOY35k985v/3kP0v7XrpEVcOdRG+KfOPpTNeqJcthZvVhMnQZ7h7t2lcA
	WChu78pgAe6yzzhbqPl1gzNUw6DM+couU2iKCltLtz7Ea+SGJeIQ4A4cUBisO5A6mdNepr
	NgEfIGyPmbyaVb8dZuxyvDegJrnrDWxTTzJFSlQ/Qn10dCZAu2bUnBh5NtboMVHURWkGjy
	CCc4tD+k6YkPNf2UdNVo9OcFeb1eWpSbkvxj9kRAC1CCGKd0tfEnGHgWlplB2g==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Subject: [PATCH 0/4] drm/amd/display: move from kzalloc(size * nr, ...) to
 kcalloc(nr, size, ...)
Date: Thu, 27 Feb 2025 18:16:20 -0500
Message-Id: <20250227-amd-display-v1-0-52a060a78d08@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETywGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNz3cTcFN2UzOKCnMRK3UQLYxOjZFPTRMtEAyWgjoKi1LTMCrBp0bG
 1tQDfWN/RXQAAAA==
X-Change-ID: 20250227-amd-display-a8342c55a9a0
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=qryNsb6eKMy0Wo+mVn5eYMTnjQFI42YtE83+U+++mzs=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBCLzRGTFJEM1h0L3h0SVhuTGZMV3MrdFgxUjlXOUk0CmltSDNoSDlmM3Npd0IxN1RD
 azNxS0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VUMnhERXl
 yRFE2dDMxTFhQYmtoL2ZTcGpNdlVSVjQ0cmwxcXJuMm9vdTFvaHZ2dlhzYitvZmhmMHlwNGU5YQ
 oxUXJPTlpOTVVqZmR1RnczZWFyZ01zbnRPbExxNTQ2bWx4N0pZQUVBWEVkUGdBPT0KPS91Ni8KL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows. Here the multiplications are
probably safe, but using kcalloc() is more appropriate and improves
readability. It is also safer. This series contains a few patches
with these fixes.

Part of the Kernel Self Protection Project efforts. Links below have
more details.

Link: https://github.com/KSPP/linux/issues/162
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
Ethan Carter Edwards (4):
      drm/amd/display: change kzalloc to kcalloc in dcn30_validate_bandwidth()
      drm/amd/display: change kzalloc to kcalloc in dcn31_validate_bandwidth()
      drm/amd/display: change kzalloc to kcalloc in dcn314_validate_bandwidth()
      drm/amd/display: change kzalloc to kcalloc in dml1_validate()

 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c   | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: be5c7bbb3a64baf884481a1ba0c2f8fb2f93f7c3
change-id: 20250227-amd-display-a8342c55a9a0

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

