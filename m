Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0F1FECA5;
	Fri,  4 Apr 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782288; cv=none; b=Y83N/c+ERdiBUllNIyt1GtHkVpf4w6uZ+lIyVEcfznw5cvBEzqkTto2u1oSNTZXsmKUxyPhuftKjeeFgc2ba/cIJLvEn1sXxe/d/awUga6gmCaYdllkEtEaWvlJHCQWC8+cyc+P//eM7Ef3n9iwkSEuaSoXTxCqjiaakCq4pLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782288; c=relaxed/simple;
	bh=xOiggh8DWpjifRlcJQPZM2ttanlog0Jb00HcwcfkuKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pyth8BBEZjLr2w3j4ldMHwwa1MK45kbcufIyBiGt+dZ5vfYgsfUncV1qdYn0KCu+xMtuV93Xap9JVKpded+1lipODdZpG1VKvLLWPjCIVNH0QTIAR8+HAl/f7tHJ0zQ8XpLEtE8/dqx4EX0iV3O9ku7nXZ2OlxtFxrece+7e7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbqIsOOq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbqIsOOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF8DC4CEDD;
	Fri,  4 Apr 2025 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743782286;
	bh=xOiggh8DWpjifRlcJQPZM2ttanlog0Jb00HcwcfkuKQ=;
	h=Date:From:To:Cc:Subject:From;
	b=CbqIsOOqpmQ9Z1SmXjdz2RLNN5hz7aJF9A+2x68ag3BEg9ieyM3/FBkleHNoMIasZ
	 fcgEnet2tGDkjrCPIv8q/G5h8CajXjp51J66yjl8Q3ebQijcyN6YDoSXQ5HnA3Mp4I
	 8PojdLhL+s2qQPOaAMLVxgzFqy0h+Njj+9I5Uafx0Bobl3318P2F8cnPPVS1zyxD2T
	 X34glHvBgBVftnP2rvBAtqa7y/CrAl4NcNdRn4vfg53ERbwPYYj+ezixshalYvs/1e
	 8EKHKTH8AJhBxuoDO7HuxiPPzyPdKodTDo1crYkEdTvm9QACBOTzKCMP2JNUozjKDI
	 MPoAOfgRWE1SQ==
Date: Fri, 4 Apr 2025 09:58:03 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] drm/nouveau: fifo: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z_ABiwj7hoXR0fJ5@kspp>
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

Adjust heap allocation to account for the flex-array-in-the-middle
issue, and refactor the rest of the code accordingly.

So, with these changes, fix the following warning:

drivers/gpu/drm/nouveau/nvif/fifo.c:29:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Adjust heap allocation instead of using the DEFINE_RAW_FLEX() helper.
 - Link: https://lore.kernel.org/lkml/202504041254.6e26LBdj-lkp@intel.com/

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z-7IQcWNePAMQEM0@kspp/

 drivers/gpu/drm/nouveau/nvif/fifo.c | 35 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
index a463289962b2..2c887dffa45d 100644
--- a/drivers/gpu/drm/nouveau/nvif/fifo.c
+++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
@@ -25,33 +25,34 @@ static int
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
+	struct nv_device_info_v1_data *runlists;
+	struct nv_device_info_v1_data *runlist;
+	struct nv_device_info_v1 *a;
+	const u8 runlist_cnt = 64;
 	int ret, i;
 
 	if (device->runlist)
 		return 0;
 
-	if (!(a = kmalloc(sizeof(*a), GFP_KERNEL)))
+	a = kmalloc(struct_size(a, data, runlist_cnt + 1), GFP_KERNEL);
+	if (!a)
 		return -ENOMEM;
-	a->m.version = 1;
-	a->m.count = sizeof(a->v) / sizeof(a->v.runlists);
-	a->v.runlists.mthd = NV_DEVICE_HOST_RUNLISTS;
-	for (i = 0; i < ARRAY_SIZE(a->v.runlist); i++) {
-		a->v.runlist[i].mthd = NV_DEVICE_HOST_RUNLIST_ENGINES;
-		a->v.runlist[i].data = i;
+
+	runlists = &a->data[0];
+	runlist = &a->data[1];
+	a->version = 1;
+	a->count = runlist_cnt + 1;
+	runlists->mthd = NV_DEVICE_HOST_RUNLISTS;
+	for (i = 0; i < runlist_cnt; i++) {
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
@@ -60,8 +61,8 @@ nvif_fifo_runlists(struct nvif_device *device)
 	}
 
 	for (i = 0; i < device->runlists; i++) {
-		if (a->v.runlist[i].mthd != NV_DEVICE_INFO_INVALID)
-			device->runlist[i].engines = a->v.runlist[i].data;
+		if (runlist[i].mthd != NV_DEVICE_INFO_INVALID)
+			device->runlist[i].engines = runlist[i].data;
 	}
 
 done:
-- 
2.43.0

