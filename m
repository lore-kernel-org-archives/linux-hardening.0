Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2482900BF;
	Tue, 22 Apr 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336700; cv=none; b=m/W//uNEs70fEUYa/llhsElHssVX6UJxcpIdj0agp9oVYct40fpsDoovFGHOz2O6d8PChpaj/o1u3+ykzoj+MhMcHxE1PmLQcuI7Ot3/b7zCk8g73k+vKn3lFkwa3rD8+N+XoXRpLB2lsFfHjt5mvs8L3QTEOAPFQfxP1/5I9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336700; c=relaxed/simple;
	bh=BbtwK2smXn0Op0m1KEOnNdTqhkRUWhYr3xZpX7mRyNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i43mpsMQDh2Z7aHROW0al8OHdQk+nMM/bpWTxjRUlEXNNhGS29t482LmCjTH3A14fg5xYYlafq1VvZkne87F4AK+mdH2sOS8dnptNOayYnU+T+bWKPVHmT26l+h7fa9eb3X73eDuq2o/YQzcKSlIyfO+4I7Lu9ShI1oTuo8yAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrYwLEmN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrYwLEmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6DAC4CEE9;
	Tue, 22 Apr 2025 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745336699;
	bh=BbtwK2smXn0Op0m1KEOnNdTqhkRUWhYr3xZpX7mRyNc=;
	h=Date:From:To:Cc:Subject:From;
	b=FrYwLEmNiG6+bWdHnb47cgV6A6v8/yVyaKvcFT8LkzBrmT20VrlRVND8yFW5fGLma
	 c6NY9IGNVWmqNofE8u/Ykbfeku+fcKYuY3lflMaVySJUCmcX4oeLHLRJtDvnj0XaJ7
	 TyzkHod0S2u0d51M4nvjGni+0RBiSMHyyWm/Vg5eGmLrgh0dfEV+xbUkDDJ9dmOSkD
	 dXp5uY73cVjS+noZxxoum00SyJSMQcjdidj/WqgHKshhixOnIQDIQMdiEjMC+/pO+W
	 A7RZtw60P7lJQXlE44mDbROjHe4x/eKqhRdkI+CQV8ywkRTbsowmb6UVIdgCo+SXZg
	 VP/SukavonrQw==
Date: Tue, 22 Apr 2025 09:44:56 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau: disp: Use __member_size() helper
Message-ID: <aAe5eNDnRyGnxLMX@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use __member_size() to get the size of the flex-array member at compile
time, instead of the convoluted expression `__struct_size(p) - sizeof(*p)`

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 725331638a15..9bed728cb00e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -776,7 +776,7 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	const u8 rekey = 56; /* binary driver, and tegra, constant */
 	u32 max_ac_packet;
 	DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, 17);
-	const u8 data_len = __struct_size(args) - sizeof(*args);
+	const u8 data_len = __member_size(args->data);
 	int ret, size;
 
 	max_ac_packet  = mode->htotal - mode->hdisplay;
-- 
2.43.0

