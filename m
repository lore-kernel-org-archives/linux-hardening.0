Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958B2528E2;
	Thu,  3 Apr 2025 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702084; cv=none; b=h4QAwtiHcm75v8UyOilfRoyMa1M/MD6/RRqn89NuqDAEMpLLqA2tiCGZ/NiKTjOvdj5eLWHg5s7ArRKSH4SBRZgf2M65KzyDbiNvgV61e/tyTT7EZTG7E5uXtVN7GrwclIqsWoD/48L/0bib1kEm7Opp6e6aukV5qZ3RYDbB3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702084; c=relaxed/simple;
	bh=8lR9ylBsfo7PBLZHWh9qmMylsgZ+XsmxjxGaNWbQYxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jx9I5ZCXLyy8YhA8X6T2QKBjxLWav9e96c0KMfMiwp1MIrmceY5O1OVOTd7VAriztyrPFhS0fPF1lbcCi6XhVqERMSQfKkNNMzFEkcRPyj4VtxB5PytgLp0MKLQUs8SC5MmiG2GTiSMPNQ1TTmUl/sSaCI3DkKek0Pm3crq97Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPoLcU6S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPoLcU6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED42C4CEE7;
	Thu,  3 Apr 2025 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743702083;
	bh=8lR9ylBsfo7PBLZHWh9qmMylsgZ+XsmxjxGaNWbQYxA=;
	h=Date:From:To:Cc:Subject:From;
	b=dPoLcU6SLa7ZgTJZaHaiRDW64dPYRH3R0/kUgslJwP6Oc8Zk4UilUUJ+wx4HPhgf9
	 PC+5aY3fNv3g0VpN+shYeyJMpiajZZ9sQ6nHWfFRDICVfbvbozCbJklIdl3GnJ/ZIK
	 SZg7VIarvzNTFY7QwvkgrbUmcKhqG/uKyKWh3eDD15JnnIRBGDC24gcPTPpieWO0H8
	 kcHvzqm9K4M2vSSmwdthaiiWzgKgJBBrfJtdU88EiN1ljDnX3iTgMgaFJdckCJ8y90
	 YoNkIDTPGC9a1uk13aXXd0386xbs0TBu/Yw0XNJ/21lWmDmQco7jptuqkA8IhCPArs
	 nCKRo+DLE/qUA==
Date: Thu, 3 Apr 2025 11:41:21 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau: fifo: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-7IQcWNePAMQEM0@kspp>
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

drivers/gpu/drm/nouveau/nvif/fifo.c:29:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nvif/fifo.c | 32 ++++++++++++-----------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
index a463289962b2..f8772340fec4 100644
--- a/drivers/gpu/drm/nouveau/nvif/fifo.c
+++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
@@ -25,33 +25,28 @@ static int
 nvif_fifo_runlists(struct nvif_device *device)
 {
 	struct nvif_object *object = &device->object;
-	struct {
-		struct nv_device_info_v1 m;
-		struct {
-			struct nv_device_info_v1_data runlists;
-			struct nv_device_info_v1_data runlist[64];
-		} v;
-	} *a;
+	DEFINE_RAW_FLEX(struct nv_device_info_v1, a, data, 65);
+	struct nv_device_info_v1_data *runlists = &a->data[0];
+	struct nv_device_info_v1_data *runlist = &a->data[1];
+	const u8 rl_cnt = (__struct_size(a) - sizeof(*a)) / sizeof(*a->data) - 1;
 	int ret, i;
 
 	if (device->runlist)
 		return 0;
 
-	if (!(a = kmalloc(sizeof(*a), GFP_KERNEL)))
-		return -ENOMEM;
-	a->m.version = 1;
-	a->m.count = sizeof(a->v) / sizeof(a->v.runlists);
-	a->v.runlists.mthd = NV_DEVICE_HOST_RUNLISTS;
-	for (i = 0; i < ARRAY_SIZE(a->v.runlist); i++) {
-		a->v.runlist[i].mthd = NV_DEVICE_HOST_RUNLIST_ENGINES;
-		a->v.runlist[i].data = i;
+	a->version = 1;
+	a->count = (__struct_size(a) - sizeof(*a)) / sizeof(*a->data);
+	runlists->mthd = NV_DEVICE_HOST_RUNLISTS;
+	for (i = 0; i < rl_cnt; i++) {
+		runlist[i].mthd = NV_DEVICE_HOST_RUNLIST_ENGINES;
+		runlist[i].data = i;
 	}
 
 	ret = nvif_object_mthd(object, NV_DEVICE_V0_INFO, a, sizeof(*a));
 	if (ret)
 		goto done;
 
-	device->runlists = fls64(a->v.runlists.data);
+	device->runlists = fls64(runlists->data);
 	device->runlist = kcalloc(device->runlists, sizeof(*device->runlist),
 				  GFP_KERNEL);
 	if (!device->runlist) {
@@ -60,12 +55,11 @@ nvif_fifo_runlists(struct nvif_device *device)
 	}
 
 	for (i = 0; i < device->runlists; i++) {
-		if (a->v.runlist[i].mthd != NV_DEVICE_INFO_INVALID)
-			device->runlist[i].engines = a->v.runlist[i].data;
+		if (runlist[i].mthd != NV_DEVICE_INFO_INVALID)
+			device->runlist[i].engines = runlist[i].data;
 	}
 
 done:
-	kfree(a);
 	return ret;
 }
 
-- 
2.43.0

