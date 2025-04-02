Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA41E5B81;
	Wed,  2 Apr 2025 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629295; cv=none; b=A4/waHwbH0SuOF/igfXrBoa+xZLH9bb3gXIpg2sqEpqOIlQaYMUP9x6N10ZspyYJi3cbCTLfzVdFPUGSAfJlhXxdKMMPk8msZgxghiqzC5vYhJFrKnoSViaKSfv6CsjDojnl9y4C+FwgKIk7WptgcE4t6G1+nwolQWGml+Lowe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629295; c=relaxed/simple;
	bh=edoE/fK+KmO0AzWK9X+Xgit4xLYc3fFhZlCsJwvyiRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kHWpWiGq4sWVrWI37yUHCUA+g7dQuBr+aIDIlTr6ctP3eTwttZ0f9Z6dplfqA5ClL6cv9kerXG1yreXqhDELB6/9tw3f0zsFl1+rKqoNDQVJaSo7kfRTmpZfLbRPEuyO89i2l4XvW5gTtXxRMR1j6339OxDwNxBhQ2AJlczZ6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9r5rKkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9r5rKkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0FAC4CEDD;
	Wed,  2 Apr 2025 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629295;
	bh=edoE/fK+KmO0AzWK9X+Xgit4xLYc3fFhZlCsJwvyiRU=;
	h=Date:From:To:Cc:Subject:From;
	b=l9r5rKkwKXMDgDonLXJhU/RXDikac5iGeGe6sv1yJU/fqWy0dwFET+1Ia+sbagjUP
	 aSG/ZG9F+plRRsxUQSekXRJYyyw7WwKhtaeqF081yR/BoNjKTygLvwMtOIGdrMEsIu
	 RDcHMLf6IebIlpocFJvcj5ZY2j4k2pQ4hxwkqLe1UMkWEGaHSMC0n6LsIbVd79aZ/h
	 BIajfah/T/vGmBEFINBju4lmthals0IJKs2ExqzQNVbn5lZ05PDMoAA/PhSicoH754
	 MHXobs2hylEx0SE5GzRmGICUoNl9oXECgmlsq+dZB0B+PKA8veIIlURAwg3wJAL47p
	 V9I2HZPNdGlTQ==
Date: Wed, 2 Apr 2025 15:28:10 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau: fence: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-2r6v-Cji7vwOsz@kspp>
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

drivers/gpu/drm/nouveau/nouveau_fence.c:188:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_fence.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index 7cc84472cece..7622587f149e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -184,10 +184,10 @@ nouveau_fence_context_new(struct nouveau_channel *chan, struct nouveau_fence_cha
 	struct nouveau_cli *cli = chan->cli;
 	struct nouveau_drm *drm = cli->drm;
 	struct nouveau_fence_priv *priv = (void*)drm->fence;
-	struct {
-		struct nvif_event_v0 base;
-		struct nvif_chan_event_v0 host;
-	} args;
+	DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
+			sizeof(struct nvif_chan_event_v0));
+	struct nvif_chan_event_v0 *host =
+				(struct nvif_chan_event_v0 *)args->data;
 	int ret;
 
 	INIT_WORK(&fctx->uevent_work, nouveau_fence_uevent_work);
@@ -207,12 +207,12 @@ nouveau_fence_context_new(struct nouveau_channel *chan, struct nouveau_fence_cha
 	if (!priv->uevent)
 		return;
 
-	args.host.version = 0;
-	args.host.type = NVIF_CHAN_EVENT_V0_NON_STALL_INTR;
+	host->version = 0;
+	host->type = NVIF_CHAN_EVENT_V0_NON_STALL_INTR;
 
 	ret = nvif_event_ctor(&chan->user, "fenceNonStallIntr", (chan->runlist << 16) | chan->chid,
 			      nouveau_fence_wait_uevent_handler, false,
-			      &args.base, sizeof(args), &fctx->event);
+			      args, __struct_size(args), &fctx->event);
 
 	WARN_ON(ret);
 }
-- 
2.43.0

