Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423101C8FD7;
	Fri, 28 Mar 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177141; cv=none; b=IB+iT9K/gQWqQySIQMyaFUzM2ta9+T+NRcQ0Y1IentYcwkJKonobAxZU/oymSNdGMZP89AjTAGmh1EByEBHYXpBpgWNJFAwgO7Lc1Tdj/KjRDOxIxp/zRg2HkDAPRf3YiOfm3G9XXh3c2VKy3OO6wpbs2QeczU4xfggNn3iN9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177141; c=relaxed/simple;
	bh=hWPtfCT2RZ3uXjDp2XjKOX8XZgOg8+h81uSQUsXVRGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RzqDwsijlqnI2eoux0Jzeg3qTfTKqFw2nO1uuLGd74gLk2DeSOU03LUxGmpPDPoPTSxc+aPMNzw8MV6ym2TwpRnkoeCRFgoA9joEx9VJskBWV/Q1iCQGEYr6Q+XrUew7UnAhZ2uqmWDbnGSoKCtY4LR/mvc/mLlh420BNbuLDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGrNwJmA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGrNwJmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAC6C4CEE4;
	Fri, 28 Mar 2025 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743177141;
	bh=hWPtfCT2RZ3uXjDp2XjKOX8XZgOg8+h81uSQUsXVRGM=;
	h=Date:From:To:Cc:Subject:From;
	b=UGrNwJmAL3N4qVVLbKdLXJVyd3sm9Dj7fcV3n4faUx8ckNskXAGYAs4FriaW60Vcy
	 2DUeBlENs/DGKQPywQNNY51KNma1/rMNRHJbDaE79xujwz/Md+vJ3aOlWD/wyB2UwV
	 nLfWQyC4azcHJWT6QeFhpeoVVtRdZEv/bBBaq5hTDQ+n3hiKgPwSPXG/SsVfl0Cp3L
	 Ti/a7JDWsd6QgdYLpJmV5VNyTOfnXxsOe/zS02cMQdI4KUmZKW9dA4MdeLLaMBVujv
	 h96prW5wI/X1C60yA93CM8nhTdT8AJbhZWthlT3y6tg+IuN75qRNebxWlDrthXaQwZ
	 vS24cYZ5RrlwQ==
Date: Fri, 28 Mar 2025 09:52:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] drm/nouveau/outp: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-bFsmWjr5yZy6c6@kspp>
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
Changes in v2:
 - Avoid using magic number in if statement. (Danilo)
 - Use sizeof() instead of __struct_size().

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z-a2DAQmcsHHlyci@kspp/

 drivers/gpu/drm/nouveau/nvif/outp.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
index 6daeb7f0b09b..1ea20b2bdd29 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -195,20 +195,17 @@ nvif_outp_dp_aux_pwr(struct nvif_outp *outp, bool enable)
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
+	if (WARN_ON(size > (__struct_size(mthd) - sizeof(*mthd))))
 		return -EINVAL;
 
-	args.mthd.version = 0;
-	args.mthd.head = head;
+	mthd->version = 0;
+	mthd->head = head;
 
-	memcpy(args.data, data, size);
-	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_HDA_ELD, &args, sizeof(args.mthd) + size);
+	memcpy(mthd->data, data, size);
+	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_HDA_ELD, mthd, sizeof(*mthd) + size);
 	NVIF_ERRON(ret, &outp->object, "[HDA_ELD head:%d size:%d]", head, size);
 	return ret;
 }
-- 
2.43.0

