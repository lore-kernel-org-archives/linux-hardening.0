Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1862D24BA;
	Fri, 29 Aug 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461509; cv=none; b=Asf8YSMVLUIu2YrcMzlbu7OVUhkquLHIJr/3Sil2jVikNssY2CqJa7sKJVzcDWfCzMktBhDutAqxI3dRZknd7tR21hIyh17cX5FycUEnfxRo5ZZyuNoFbK2wxTFQxCIDPA7zo0xYfNz3qMABAcAFSTQJH3pEiTvmJl/hAD1nHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461509; c=relaxed/simple;
	bh=KDoth+kAYRavO4Qft6ekvmhD5j99ml0dSojmfq8vU8E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=flD1u24KpL71vHori+MsOG2nrtxBiYE1db1rIRmaxbvnlHQU2nsEE7UqZgjk5+3gdkJ5BrDK1WvuVX36CuFnPzBSi7jLgC9AAVVLb8faWBsZC/pZhJq01pDeaw8B+K20HWLaFo5G1aOFKP0k1W9cFW6PIvy9QKRhPS0MAhWTPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTSidfGI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTSidfGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2367C4CEF4;
	Fri, 29 Aug 2025 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756461508;
	bh=KDoth+kAYRavO4Qft6ekvmhD5j99ml0dSojmfq8vU8E=;
	h=Date:From:To:Cc:Subject:From;
	b=BTSidfGIfGEaKs845+2g1h/e9KQwEYEK4MCB9j9nLwkIiRXFkrPIAjdxvDE3gpAG1
	 AM8v7XeOg+dwMb/oYM4edixNCUdRXv86BVnGy7QKFdJPW75tdeQqxd79mRUdVSsVM+
	 Xn+AJalHJKqPaHCKLF4A8pY7vigaoMs8aqK4nCJFSGK4R5llkIU6uCOYyMGCpNouHY
	 PUOrgGVS/3Lqoti7i5ah9Ftut27MqyL+k4wQxnSUjW9dhlcKvvFc8i18V/7fKZJUSG
	 YOklE++ycqz4qQ5c2+pzyWaIe+j1Ukcubmae8bvdiWSJLIdaCD1Xgz6TZ+qp0tfpan
	 V0ATO8b+2N0AQ==
Date: Fri, 29 Aug 2025 11:58:21 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu/amdkfd: Avoid a couple hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <aLF5vQv9P_vp0R6_@kspp>
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

Move the conflicting declarations to the end of the corresponding
structures. Notice that `struct dev_pagemap` is a flexible structure,
this is a structure that contains a flexible-array member.

Fix 283 of the following type of warnings:
    283 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h:111:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..24f3e5cfbe5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1155,9 +1155,6 @@ struct amdgpu_device {
 	/* for userq and VM fences */
 	struct amdgpu_seq64		seq64;
 
-	/* KFD */
-	struct amdgpu_kfd_dev		kfd;
-
 	/* UMC */
 	struct amdgpu_umc		umc;
 
@@ -1320,6 +1317,11 @@ struct amdgpu_device {
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
 	struct amdgpu_uid *uid_info;
+
+	/* KFD
+	 * Must be last --ends in a flexible-array member.
+	 */
+	struct amdgpu_kfd_dev		kfd;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 33eb4826b58b..127927b16ee2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -107,11 +107,13 @@ struct amdgpu_kfd_dev {
 	bool init_complete;
 	struct work_struct reset_work;
 
-	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
-	struct dev_pagemap pgmap;
-
 	/* Client for KFD BO GEM handle allocations */
 	struct drm_client_dev client;
+
+	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping
+	 * Must be last --ends in a flexible-array member.
+	 */
+	struct dev_pagemap pgmap;
 };
 
 enum kgd_engine_type {
-- 
2.43.0

