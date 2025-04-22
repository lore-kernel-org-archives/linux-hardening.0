Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A402A1C9;
	Tue, 22 Apr 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336743; cv=none; b=dTOLTxVvBTZqmOeFaLm7E6MGccrc+Bxcyy+lCJem4rwXqt+feUvuV8gewXR+Q0LCXwTIiP890hlLRQqJuAMyzXnK5csagcomw6+My834hfG6ysYUnDFLP5tmBV3RIelXkrlqRqAeJjew2V74fCzG9YXMtAZhgPXiFVq61po2mOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336743; c=relaxed/simple;
	bh=AQ3QsuJzqsXDOuPwebgmAuhLJTmlqdcm16p+q8/eKg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e3ZVzBYbtuykA+88xiKYjssG0igD65TcBbmdJtowxvyqg8v3kvQwe2KVP9QArB7YrRGSipeCGY1yfO/22Ky1o6gKP+utlm69W0Hp3xAlgXeyAiJxZvMyuuwspu/B5vHto8A/K/yqAFihGWukfEmSYGUMzOBFSfNucmW7pkLKtqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdFvTKkL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdFvTKkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01E4C4CEE9;
	Tue, 22 Apr 2025 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745336742;
	bh=AQ3QsuJzqsXDOuPwebgmAuhLJTmlqdcm16p+q8/eKg0=;
	h=Date:From:To:Cc:Subject:From;
	b=mdFvTKkLX518afKh11/wv6csLYyBhnDcBQb9sprOcGKVtA+O045c2Kp65JFVAJk25
	 ptAv+/YLZ+CxGqqBtdmZXyiXVZdG0EjstnvM/uUyTujF7jai3IPQkAvtQm1mAfI4XJ
	 NPD22rjlX7TlfRJN3F6MteVfn5WaKAEnmufyilXVUIVmwxW58z9c2MBE9kGZ4spMMr
	 BDkI0soAoP4+B7r3czp+a6Rm+plGPk9asPhRYHPDBy4yJjfOaeXwQmk6I25RedZL7r
	 LrgBznndeFW4qcTlvabEPPPk6dsth0Um1pWPca1JIdigb22W6VUpHTBsviLrLb6ZtT
	 3ID3PNKq+825A==
Date: Tue, 22 Apr 2025 09:45:39 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau: outp: Use __member_size() helper
Message-ID: <aAe5o_-f5OYSTXjZ@kspp>
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
 drivers/gpu/drm/nouveau/nvif/outp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
index 1ea20b2bdd29..32f6c5eb92af 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -198,7 +198,7 @@ nvif_outp_hda_eld(struct nvif_outp *outp, int head, void *data, u32 size)
 	DEFINE_RAW_FLEX(struct nvif_outp_hda_eld_v0, mthd, data, 128);
 	int ret;
 
-	if (WARN_ON(size > (__struct_size(mthd) - sizeof(*mthd))))
+	if (WARN_ON(size > __member_size(mthd->data)))
 		return -EINVAL;
 
 	mthd->version = 0;
-- 
2.43.0

