Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B51E503C;
	Mon, 10 Mar 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645440; cv=none; b=m4shIH4Di1nZua/GS64Tzo/P6n5+CZIGmrOqZiCCvWc5UT4maOPjIKiVjYQDZNPChN8Mj1xNTws+d9cZmgxlUoHpixOBfJk9JiWPl/Vs0efIkMEENT64O+AC1QOtt2ZP5R1QSFDR52oswJUwc8GtgIIhi+AOAEStEe/UP4aZd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645440; c=relaxed/simple;
	bh=CTv6x1iwe7lNlBx7Ev52FAfLLDsbcv7enQTrxI7zsyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUl37K1kCzC2Ov8+E5mTZmUxWD3L1HMBR//tNSH2erRKChUDOLFttUTgtb2huz5Y0rRzwtnu2dVGrvGaKoV0MU3QIuGTql8OJGaYb5g4EAm5BOtEeUpc4HubG+DpzeTbzB/hu2gcC7Avb4lbbIT94CN8gR8MLoCGjqslCqfNVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE6W90Jw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE6W90Jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA8AC4CEE5;
	Mon, 10 Mar 2025 22:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645440;
	bh=CTv6x1iwe7lNlBx7Ev52FAfLLDsbcv7enQTrxI7zsyo=;
	h=From:To:Cc:Subject:Date:From;
	b=dE6W90JwOo6aVDSFYATuN8T0XBAFnZHt2qM3uwGDsKfNoDN4uaxGne8JYEVQPNRqS
	 9lHrAgwG+XkDZNsLNfMvrOBewxc7Nv7M04JJkX/VdIGLVdDjTf2jgdvAiKiVOq9t6T
	 lKji9oROUTDf5D2z/W8G9y2qnbShoKuESVejF1FlGoZCvO8XAe5KcmZ4UTPitWuccb
	 tC2QD0d3Ce9Bd3piBI5trgHv/xxhbNomEDoTyMnWhis/TkHpqtP/nK2dRhhIzVMjt4
	 DuiHj06xiqAFUqhILrPfPrgOEQkju4ceAR1ui6yWHIcNQ26QCyI1zj5/VHlCbrdLyL
	 F+TQ/taWgOU6Q==
From: Kees Cook <kees@kernel.org>
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] drm/i915/gvt: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:23:56 -0700
Message-Id: <20250310222355.work.417-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=kees@kernel.org; h=from:subject:message-id; bh=CTv6x1iwe7lNlBx7Ev52FAfLLDsbcv7enQTrxI7zsyo=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn06qZjaSni/V38P2dmxCtJXbfUFFs/iOzbZunHhYqZ DvGPaOno5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJZZxgZelmUT+/S4yirMam0 8Vur2ylbJH50ZlRwfeGly9OP8bRPZvhfWSbEu0dt9enTP9bU1fPe5FKS3c/t27JwwYqVa80ZhVw ZAQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.wang.linux@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: intel-gvt-dev@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/gpu/drm/i915/gvt/opregion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 509f9ccae3a9..f701638d3145 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -43,7 +43,7 @@
 #define DEVICE_TYPE_EFP4   0x10
 
 struct opregion_header {
-	u8 signature[16];
+	u8 signature[16] __nonstring;
 	u32 size;
 	u32 opregion_ver;
 	u8 bios_ver[32];
@@ -222,7 +222,7 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	u8 *buf;
 	struct opregion_header *header;
 	struct vbt v;
-	const char opregion_signature[16] = OPREGION_SIGNATURE;
+	const char opregion_signature[16] __nonstring = OPREGION_SIGNATURE;
 
 	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
 	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
-- 
2.34.1

