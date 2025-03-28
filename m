Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BD157E6B;
	Fri, 28 Mar 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173136; cv=none; b=sBYS8td6jwn0sVlJze4qXWTtCEHGKxsq0o1QfIVonzEJ1juwGd0hfLuan3TNh7vJSbg3uuq8jpgEhCr2/oIKaqeeUyIsBePk9oSyB7E11wzaymukCQjNkEuWUf2y6k0DIVVMlHagrS3Y8pi38fOQBXf0+VIkg3DgnotkGge5hQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173136; c=relaxed/simple;
	bh=7qGrXEoUERdDE37I+v3l/CeEtOIhffhKARqqG2bFKTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bz0jlJ3Eu4omiaqlU89LDWYx3NM6v8YcrtyScCnhFJSB5huUhkpaI+O1Na13vYSLDeSYI0pjkafqLb97vaI2CIeUjB97ivAljA2Z1qvSgYIOuLuNi10G7Y3tUcVXAMV/bKTCu2TdBn00g21CWEgODTq3xNyrAK+C4wKVG2fExPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGHjYwng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGHjYwng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B64C4CEE4;
	Fri, 28 Mar 2025 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743173135;
	bh=7qGrXEoUERdDE37I+v3l/CeEtOIhffhKARqqG2bFKTg=;
	h=Date:From:To:Cc:Subject:From;
	b=YGHjYwngkfoyxnQor0tqAGGqzrL1qZP6Y8DipI/P3wXV0okkGj+rV1pBOJ4y0uslY
	 EPUGbFfFqqqFgVv56h+ztrJZ+5Mq9Vksy5ZPLfXFtfTpFveGDGi4hU8zFqynvxpnpL
	 MWL/zLNmUu4or5WkVj3NuFr842EYQUm6tXZDRbZ7bDwGjqM2T7cVYbMyzdhekaa9b1
	 /uVS7eiK51z71h/RkRrEdhqNvebahTxhRgI02Me6Q5BSMv3+knSro6ef3qHTM1tan6
	 RG3rJ8tm33elXoTdvYPhoA72WtxIrvs64QG+qmx9jdw2rgUk6p2bMGl0XiDgF+e22N
	 Y37qbE260PYSw==
Date: Fri, 28 Mar 2025 08:45:32 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau/outp: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z-a2DAQmcsHHlyci@kspp>
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

drivers/gpu/drm/nouveau/nvif/outp.c:199:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nvif/outp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
index 6daeb7f0b09b..403cf16d5e84 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -195,20 +195,18 @@ nvif_outp_dp_aux_pwr(struct nvif_outp *outp, bool enable)
 int
 nvif_outp_hda_eld(struct nvif_outp *outp, int head, void *data, u32 size)
 {
-	struct {
-		struct nvif_outp_hda_eld_v0 mthd;
-		u8 data[128];
-	} args;
+	DEFINE_RAW_FLEX(struct nvif_outp_hda_eld_v0, mthd, data, 128);
 	int ret;
 
-	if (WARN_ON(size > ARRAY_SIZE(args.data)))
+	if (WARN_ON(size > 128))
 		return -EINVAL;
 
-	args.mthd.version = 0;
-	args.mthd.head = head;
+	mthd->version = 0;
+	mthd->head = head;
 
-	memcpy(args.data, data, size);
-	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_HDA_ELD, &args, sizeof(args.mthd) + size);
+	memcpy(mthd->data, data, size);
+	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_HDA_ELD, mthd,
+			__struct_size(mthd) + size);
 	NVIF_ERRON(ret, &outp->object, "[HDA_ELD head:%d size:%d]", head, size);
 	return ret;
 }
-- 
2.43.0

