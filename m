Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB91EDA0E;
	Thu, 14 Aug 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151273; cv=none; b=oUADXOxR+RStjgUPIwtnOBg0jxOhdbW9jK+2t6jwq2UZUONJCt2Ckb5/DP44lybe8bHzTAElbEZOYJyCDDPl143B2litzWEoH4t3CIZKUh9YRLyRHwb78qTGP9q1YAvSh7+b5QoIcdeKs6V25et6R55cjdAN+RSVkJwr1Tq3wLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151273; c=relaxed/simple;
	bh=7vPHh6uzcmYyhzSxVfwn2NBujgPJ544BwypiXhxBzzU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GcOlrfLXjF9mApxibxWB0yWaJq6R9n5vPfXw3FhAhIExx/qbKQw8+OyJ5dIGSOBwObnIKcDXOnoXql+ORv1xoQn+/1YSX/PpGNo56HgHH2EvsWbC3SwFy/6eq+ZWihFaadah+3U2cJNj3GZAeZ6aAjFHISrWk33ypy0/7AiP2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCQ7iZsU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCQ7iZsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3EBC4CEEF;
	Thu, 14 Aug 2025 06:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755151273;
	bh=7vPHh6uzcmYyhzSxVfwn2NBujgPJ544BwypiXhxBzzU=;
	h=Date:From:To:Cc:Subject:From;
	b=lCQ7iZsU4vTCi/Qtl/lBCWUVPeGi2GVqLbuwU1FMAsX4xiLF49sU2owGOwyfUQisz
	 CGjLeni5abt+oFdrKw5fS00eMpa4LrQm8T8HxG8t1/2p010Q/w7AlNoKSR8rAhluy7
	 MAYOL4t7Zo8pS/6cBpkdqKo/ivgM2uBe3JUDyKy5Mu54dnC33uo7CmHU3tzfqFuZGt
	 Gvsx1CsiWq602MCK7d7cnv5eYjO0miU/5cbgPbgvWkneISuiUb9FlFUJnx/LSx6Uiq
	 8YKmseoc5Avp7XKAF4xLmMzCRLeYVIt0U9e7KUQ/HJwDcKq6wpVTiC9H7Mr2i53nnQ
	 hERtcjQJgMMjA==
Date: Thu, 14 Aug 2025 15:01:07 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] drm/nouveau: fifo: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aJ17oxJYcqqr3946@kspp>
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

Use the new TRAILING_OVERLAP() helper to fix the following warning:

drivers/gpu/drm/nouveau/nvif/fifo.c:29:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Use the new TRAILING_OVERLAP() helper.

Changes in v2:
 - Adjust heap allocation.

 drivers/gpu/drm/nouveau/nvif/fifo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
index a463289962b2..b0ab80995d98 100644
--- a/drivers/gpu/drm/nouveau/nvif/fifo.c
+++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
@@ -25,13 +25,12 @@ static int
 nvif_fifo_runlists(struct nvif_device *device)
 {
 	struct nvif_object *object = &device->object;
-	struct {
-		struct nv_device_info_v1 m;
+	TRAILING_OVERLAP(struct nv_device_info_v1, m, data,
 		struct {
 			struct nv_device_info_v1_data runlists;
 			struct nv_device_info_v1_data runlist[64];
 		} v;
-	} *a;
+	) *a;
 	int ret, i;
 
 	if (device->runlist)
-- 
2.43.0

