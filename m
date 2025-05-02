Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF453234;
	Fri,  2 May 2025 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746145485; cv=none; b=J2lSLzOfZgQTJVMVRNiMLr+Ge5Bj8QNmN7OFte/s4yoWjCah7LvV3GUTN8T5npeb2ILMCXcxF6HX2g8X5+rmkpdPcfARc6dC39WnIirko7alfF7D2D316NKcKNuMsev+63PQrNQ4a4C+L2vxHLCZJxNFrctrAL7yfb80b2a1k/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746145485; c=relaxed/simple;
	bh=6FeYoImvtlRRNM4YoESqUYiyq85ZDtoc2RCzztmOpcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d2M34kMfBYIPOJaFX/M8iItZJrxvMAIxZg6XB6tLT3hFzhET4tNtbTtsQsXqW509oDEDfenHHf6V98nEKrYuM6T6CcAGxoO2x7tJNOBElAnsi0LPVvxGt+833v2U3lLvpnPv8rQnqi7BbGV56G9wxE5mpQ3nMzsA8dhGHo6ae78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYPplRKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYPplRKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9D2C4CEE3;
	Fri,  2 May 2025 00:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746145484;
	bh=6FeYoImvtlRRNM4YoESqUYiyq85ZDtoc2RCzztmOpcY=;
	h=From:To:Cc:Subject:Date:From;
	b=HYPplRKQY1aF1RJXH+LDpHGC00zMlBUO748oRhW6OW+9uPXIFH1Qvc4c9+wSHP7QA
	 XlsaUYmaJY8GX++jSCVqdjCSAR5SvFSrMYzV73WxzSWupC10+T63vNA8pXKU8kxbNW
	 5mRkDkxDgHOPO96NYPeqYZ9Osy7wxMFzvI+byRpMvh8d/HXaX+F3okZ1AM6fhNYSke
	 khHDKwF8k1pun+HnZOnrQ7WKmodA4RUPUf9lyoPh9t2bYhTlNh0v4O+KTeZBogKMbo
	 M6tzu7SaG+/WLo64cIWwTKId809m7B1+ifZiOPbCAGCLDtJ17IHMI8oxnGjn5TdAS8
	 EhCrzy3kAlHhQ==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] drm/ttm: Silence randstruct warning about casting struct file
Date: Thu,  1 May 2025 17:24:38 -0700
Message-Id: <20250502002437.it.851-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=kees@kernel.org; h=from:subject:message-id; bh=6FeYoImvtlRRNM4YoESqUYiyq85ZDtoc2RCzztmOpcY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkiAkc5ExuSPvH/Cog4tZ3VTjb98WqR6MUzm+ZMmsv+K upDQKZ5RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQ+/2X47/WwaLNgcHXbvzNJ tcdVU3klsv9Ftc1g2ijPaWbzveGhAMP/cFbe763qS79FVQg8zHlt+ef9xTsqkvrWwnGdinOVePw ZAQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Casting through a "void *" isn't sufficient to convince the randstruct
GCC plugin that the result is intentional. Instead operate through an
explicit union to silence the warning:

drivers/gpu/drm/ttm/ttm_backup.c: In function 'ttm_file_to_backup':
drivers/gpu/drm/ttm/ttm_backup.c:21:16: note: randstruct: casting between randomized structure pointer types (ssa): 'struct ttm_backup' and 'struct file'
   21 |         return (void *)file;
      |                ^~~~~~~~~~~~

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Fixes: e7b5d23e5d47 ("drm/ttm: Provide a shmem backup implementation")
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: use struct and container_of (matthew)
 v1: https://lore.kernel.org/all/20250501195859.work.107-kees@kernel.org/
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/gpu/drm/ttm/ttm_backup.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 93c007f18855..60cff6c60db4 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -9,16 +9,21 @@
 
 /*
  * Casting from randomized struct file * to struct ttm_backup * is fine since
- * struct ttm_backup is never defined nor dereferenced.
+ * struct ttm_backup is never defined nor dereferenced. Use a single-member
+ * struct to avoid cast warnings.
  */
+struct ttm_backup {
+	struct file file;
+};
+
 static struct file *ttm_backup_to_file(struct ttm_backup *backup)
 {
-	return (void *)backup;
+	return &backup->file;
 }
 
 static struct ttm_backup *ttm_file_to_backup(struct file *file)
 {
-	return (void *)file;
+	return container_of(file, struct ttm_backup, file);
 }
 
 /*
-- 
2.34.1

