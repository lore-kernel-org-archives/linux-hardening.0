Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43F28DCB;
	Wed, 21 Aug 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271384; cv=none; b=ZTQghS2uFeRWa2CvfU/alv6DUBq3sSxCYVb5hyTWssX/0ToY1rexl9nchXc83W6CWvGUfSOq0/32RTXR1w3jDZvvn4H4Hs286NncEp51UoT06pyZFr6UQpLQTLYR06NVExiNpLfMgVpXytk+sNkuz1IN5nzHWz1NOKm808alQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271384; c=relaxed/simple;
	bh=u4IEyRI7AbwbX+N5Tu/Kt1Y5We5BuarQCzy6U7tDZlU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hhfhJuPl28lxHld6ZlwSTFRIZjk5sTcpu6iP4CsHjfZD8I4i6az4w0Zv/5OpikYk1w4JdyLDqG7HJVi1vAvsVMtjimNi0t19F1J+fqZq+W1d2ZIRMulo11h7vGfeQl5Rmsyw0fU9orH5uXSrsdl5SWXQg7Qgx23VE9C86AyguBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRVO8IqT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRVO8IqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62604C32781;
	Wed, 21 Aug 2024 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724271384;
	bh=u4IEyRI7AbwbX+N5Tu/Kt1Y5We5BuarQCzy6U7tDZlU=;
	h=Date:From:To:Cc:Subject:From;
	b=qRVO8IqTr732AA7WyRGGblJ8wkdCOHVdBDiamiZsqxPYHiqfcqRqC4lSbsiuvGB72
	 8YdcipZn9BnJV5bOuQkCLbIaKsWV7YeeFgiIv3Nha9eQDfEjY7JHalhyCTHw8y5C3m
	 ByBR1zqAQLyrQ7H5OvQjyV7shw4X7xHfIP3NxxlsOTJgSQcxQgn2PjA2rJFhyi5YIA
	 Nesg4bxsqMJN4BUJDpVdyhIj+NbDHsjHb4BsYCWOnhk7POsYzEuM4PiL1DO7pCSXDr
	 DPLBMrRtTLeJtclKCDccYEDCDcG3y1azWRlfpOF3lub3yda2EntJZfwGhd4cB40Ek+
	 veCze51ImXt3w==
Date: Wed, 21 Aug 2024 14:16:21 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <ZsZLFS1CsHkKjw+C@elsanto>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with this, fix the following warning:

drivers/gpu/drm/nouveau/dispnv50/disp.c:779:47: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index eed579a6c858..ddddc69640be 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -774,11 +774,9 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	struct drm_hdmi_info *hdmi = &nv_connector->base.display_info.hdmi;
 	union hdmi_infoframe infoframe = { 0 };
 	const u8 rekey = 56; /* binary driver, and tegra, constant */
+	DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, 17);
+	const u8 data_len = 17; /* same length as in DEFINE_RAW_FLEX above. */
 	u32 max_ac_packet;
-	struct {
-		struct nvif_outp_infoframe_v0 infoframe;
-		u8 data[17];
-	} args = { 0 };
 	int ret, size;
 
 	max_ac_packet  = mode->htotal - mode->hdisplay;
@@ -815,29 +813,29 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 		return;
 
 	/* AVI InfoFrame. */
-	args.infoframe.version = 0;
-	args.infoframe.head = nv_crtc->index;
+	args->version = 0;
+	args->head = nv_crtc->index;
 
 	if (!drm_hdmi_avi_infoframe_from_display_mode(&infoframe.avi, &nv_connector->base, mode)) {
 		drm_hdmi_avi_infoframe_quant_range(&infoframe.avi, &nv_connector->base, mode,
 						   HDMI_QUANTIZATION_RANGE_FULL);
 
-		size = hdmi_infoframe_pack(&infoframe, args.data, ARRAY_SIZE(args.data));
+		size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
 	} else {
 		size = 0;
 	}
 
-	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_AVI, &args.infoframe, size);
+	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_AVI, args, size);
 
 	/* Vendor InfoFrame. */
-	memset(&args.data, 0, sizeof(args.data));
+	memset(args->data, 0, data_len);
 	if (!drm_hdmi_vendor_infoframe_from_display_mode(&infoframe.vendor.hdmi,
 							 &nv_connector->base, mode))
-		size = hdmi_infoframe_pack(&infoframe, args.data, ARRAY_SIZE(args.data));
+		size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
 	else
 		size = 0;
 
-	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, &args.infoframe, size);
+	nvif_outp_infoframe(&nv_encoder->outp, NVIF_OUTP_INFOFRAME_V0_VSI, args, size);
 
 	nv_encoder->hdmi.enabled = true;
 }
-- 
2.34.1

