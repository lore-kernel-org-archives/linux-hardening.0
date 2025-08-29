Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA81FDE31;
	Fri, 29 Aug 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756463333; cv=none; b=YlTrfQ7IMphQLtRPLptyHsRl/tRkBW7sXDjT5yZRYx8uYtIkm8VdUSUmyweuLTIt2cEGXsgVtjcFk8xS+xP3+7b5sZRntdLszyqgzGwD6cBQ3iERpGH7Fn821PdrWKN5djpKmRWdM8iL022cUy04YlYr66QKFmyHpalmxO5b3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756463333; c=relaxed/simple;
	bh=8J1IzMo3NnCzGtvrH5epfwnEdZ4lAO3fgP6owIMX35c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T6ORoH7lhpmv7mItjGlzA/TY/BstPaX+dK2yiTFLcvhMDIJ5dazOzOqyJxi+Dp3weADwtmrVFWbuwh6ALOGlsnipNw5kLHssBhni09qHTOoGEcEOY256EI28gewBYs1jJPnGhXRgbqrKvvz3qImHtPmaPNJgUf4UOf99P51E6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z79bxCEV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z79bxCEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA46C4CEF0;
	Fri, 29 Aug 2025 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756463332;
	bh=8J1IzMo3NnCzGtvrH5epfwnEdZ4lAO3fgP6owIMX35c=;
	h=Date:From:To:Cc:Subject:From;
	b=Z79bxCEVLTByzDhfBQVphj6Rb1CrK7C+hy2bBVYdDqH1ni+tD9fuwYr5Lpc12a/pL
	 dM4D0qraMY/Hi0v0s7Y4tZMu+Rq8pX6DpaVG0lx1nDLXh17GLtBMqFV4raqcFXuM8a
	 NyiLdrGzRPLwnEa/mvSy4729ypPGAHiclCneoJ07bDfUTAl8YD7nGIpWmTyOZsb+jk
	 KuAC5IVdRc0fd2I1Sy3Fgrtra0kr3xhvAGVNacTo4PZHKq+DD7sID+HhBjP9MBeNVY
	 xG/D2tmLiQfViCqQmLbc/DtD45M9l3aqy+60283DP1dS4jOS6AS9Q6QHabko4jaEKR
	 5FVy88QE2TelQ==
Date: Fri, 29 Aug 2025 12:28:45 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/xe: Avoid dozens of -Wflex-array-member-not-at-end
 warnings
Message-ID: <aLGA3RVR2JIEnNhc@kspp>
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

Move the conflicting declaration to the end of the corresponding
structure. Notice that `struct dev_pagemap` is a flexible structure,
this is a structure that contains a flexible-array member.

Fix 56 of the following type of warnings:
drivers/gpu/drm/xe/xe_vram_types.h:69:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/xe/xe_vram_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vram_types.h b/drivers/gpu/drm/xe/xe_vram_types.h
index 83772dcbf1af..183d358da741 100644
--- a/drivers/gpu/drm/xe/xe_vram_types.h
+++ b/drivers/gpu/drm/xe/xe_vram_types.h
@@ -66,8 +66,6 @@ struct xe_vram_region {
 #if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
 	/** @migrate: Back pointer to migrate */
 	struct xe_migrate *migrate;
-	/** @pagemap: Used to remap device memory as ZONE_DEVICE */
-	struct dev_pagemap pagemap;
 	/**
 	 * @dpagemap: The struct drm_pagemap of the ZONE_DEVICE memory
 	 * pages of this tile.
@@ -79,6 +77,8 @@ struct xe_vram_region {
 	 * This is generated when remap device memory as ZONE_DEVICE
 	 */
 	resource_size_t hpa_base;
+	/** @pagemap: Used to remap device memory as ZONE_DEVICE */
+	struct dev_pagemap pagemap;
 #endif
 };
 
-- 
2.43.0

