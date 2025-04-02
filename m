Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ABF155382;
	Wed,  2 Apr 2025 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743631142; cv=none; b=lbksnjWWcd1KC5nB8BBk+d8qmWpZ2Ek6jDgS/gfxa2JWOktWbKjNDDGzaNMkFX5URUjfPHbxJu8Qhmo42jVUi9N64OrJ1RNYiJMsICxzeHgTKX9GUHhDo8NP9gpCc6lZ4XA3ZevuqNxyOdUc+eYDhLUfQMJD4HMVDm8plTzGtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743631142; c=relaxed/simple;
	bh=0BXP9Sttv9k8REO+ljfXfz32urOtrGdhguS+/WAW0jA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=me7tUOUa9s0ihOjDssAbpffeOIRbH07VcKARtkz+Uo6oVEvyANunE9TzyAbLZooQOvM6Xwj6mFhh6JTgPkkb/Rpv7RlqFAh2Mn+AyatG6pxhZve+rEyOt3+BaCAfcpVVbOA2mSk+BaoHa40l6v9h/Xz90vPvoqGPqDe71BQINEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJJ3Qkza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJJ3Qkza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D46C4CEE7;
	Wed,  2 Apr 2025 21:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743631142;
	bh=0BXP9Sttv9k8REO+ljfXfz32urOtrGdhguS+/WAW0jA=;
	h=Date:From:To:Cc:Subject:From;
	b=hJJ3QkzafMZCUvkyswDqA/xuoQh8r0ItuHa0MzoW9hLNxLeHxMNOLepDMEvRbuFjK
	 dzXruQbPrWwfVhR5i7NbG4yFlAGY5DIPQVgjAHJs53QufguQk3K5e/09zZIAXh8FlH
	 40yg3pn5v2t2640k760GjlbyhPmc9LqTsgkjLb4LzjQUfeb7jJx7w+fpiyvzCIj3To
	 JzDzg+uUg7aNOXzPWwxPqgmYgKCAcQVWmb8D7y2yMBGp5SKFKQwotMloIxi2yCNVr3
	 /4+gxZntVCiUCrgU87AxoAcxtc3aN81LwpQkffEgrkWk7QLx9mdEwmYb9NmbScgw+A
	 m81lgmgcuhN6Q==
Date: Wed, 2 Apr 2025 15:58:59 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] drm/nouveau: disp: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-2zI55Qf88jTfNK@kspp>
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

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

drivers/gpu/drm/nouveau/dispnv50/disp.c:779:47: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Calculate the size of `data[]` using ` __struct_size(args) - sizeof(*args)`.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZsZLFS1CsHkKjw+C@elsanto/

 drivers/gpu/drm/nouveau/dispnv50/disp.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 504cb3f2054b..725331638a15 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -775,10 +775,8 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	union hdmi_infoframe infoframe = { 0 };
 	const u8 rekey = 56; /* binary driver, and tegra, constant */
 	u32 max_ac_packet;
-	struct {
-		struct nvif_outp_infoframe_v0 infoframe;
-		u8 data[17];
-	} args = { 0 };
+	DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, 17);
+	const u8 data_len = __struct_size(args) - sizeof(*args);
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
2.43.0

