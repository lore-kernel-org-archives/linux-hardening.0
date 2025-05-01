Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425FD210185;
	Thu,  1 May 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129549; cv=none; b=KvKsZQiQ9K7jN0rIng/dlMoQbC3DNGU6rHWRMiVa5/YArqxXCetkvvE5gg6ylh9NDzWivrUQ9fn7nsCqXggN+/01zXrBb1KkLdi79ANa6zrbONtP18jgkszMD69/B7/pC5EMPvK3Nff0skg7tjFJQMc6MuQnApgqGoK8cKqy32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129549; c=relaxed/simple;
	bh=qfTlTJQGG2XSqogUY1DZu7IdChhNVaR9ezmWG9lLMXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EGg7xoTjzLKb2ADQ2iOjRMs1a9sL1eFNl79rwmtdKl7taV2n1ml5OYDN/hlcyxkKM77IsF4xTCX1GZambnLG8vKj1QnJe/Cr646G1RDWvz6uTRRAxLJ6DkIjW5pDN69nloRABN792LO/jAkCBhNDBnXtVpabgUOzKUSVAV4PgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXHMcXJ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXHMcXJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95685C4CEE3;
	Thu,  1 May 2025 19:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746129548;
	bh=qfTlTJQGG2XSqogUY1DZu7IdChhNVaR9ezmWG9lLMXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RXHMcXJ/CVJNpiYSXeH9hd0NhukZQ0YbIfhHUQ9bUf8UsCKCJpw9QUuAsKjM48W+U
	 aKTVg7Mp9xjWsWYoym/QmIqLtlguFtrntMagOnJgUK5vOy1JDmfQfCjr5cG6NwGG3k
	 EmNToIIbK6Gesv+WFft1zF75SZTwRMPvTWKAekHVUtf8ob60xpCiCqadXj/9TAZtxW
	 4IoMdieCq2HH8tN5Z6KGyxwsVVpAB3qJrH1/AlwMlHLcuvfLXwSkk6tB2ZbA4xkB/a
	 OUedXstMfKHkDooG52FX1CjvMeRI+mcFLW48qnKw8dFJr8fSsvk+jNAZor28xk0a90
	 I7lKpnhJLaMOw==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Christian Koenig <christian.koenig@amd.com>,
	Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
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
Subject: [PATCH] drm/ttm: Silence randstruct warning about casting struct file
Date: Thu,  1 May 2025 12:59:03 -0700
Message-Id: <20250501195859.work.107-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=kees@kernel.org; h=from:subject:message-id; bh=qfTlTJQGG2XSqogUY1DZu7IdChhNVaR9ezmWG9lLMXQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnCl9qespsdPX+92CDPwOL8dRlXifu5LYJ3XO+s+pe+0 sJ73aKlHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOJfMHw33PJoX+Kx9lD306x qyqa8eOzsa5h3sVLVzdv1bHSun4muoiRYd/9lVrPStM3WW+KE+Cycfl75eqEKxV3L3/lnuv00tv 4PBsA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Casting through a "void *" isn't sufficient to convince the randstruct
GCC plugin that the result is intentional. Instead operate through an
explicit union to silence the warning:

drivers/gpu/drm/ttm/ttm_backup.c: In function 'ttm_file_to_backup':
drivers/gpu/drm/ttm/ttm_backup.c:21:16: note: randstruct: casting between randomized structure pointer types (ssa): 'struct ttm_backup' and 'struct file'
   21 |         return (void *)file;
      |                ^~~~~~~~~~~~

Fixes: e7b5d23e5d47 ("drm/ttm: Provide a shmem backup implementation")
Signed-off-by: Kees Cook <kees@kernel.org>
---
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
 drivers/gpu/drm/ttm/ttm_backup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 93c007f18855..626af1de562f 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -18,7 +18,13 @@ static struct file *ttm_backup_to_file(struct ttm_backup *backup)
 
 static struct ttm_backup *ttm_file_to_backup(struct file *file)
 {
-	return (void *)file;
+	/* Explicit union instead of a cast to make randstruct ignore us. */
+	union {
+		struct file *file;
+		struct ttm_backup *backup;
+	} u;
+	u.file = file;
+	return u.backup;
 }
 
 /*
-- 
2.34.1

