Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6EE1A8F89;
	Sat, 26 Apr 2025 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648077; cv=none; b=FLuCa7+K2U7JlGRi9Ov+2s/tG0hNVQxDn3cslbFJhn+J/WJgipCDVMHZOzyvWkr8GMKFwxIeWshneIVqcfxJMTHScMkjr3Q5hm5RCz+p2LlCS4V77k1UC4JiJTpqFIeRZVnktwHjmcwCKAgNQb+8weAOSbsLfpaiNCe34Lv4OVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648077; c=relaxed/simple;
	bh=2S6FazreNdjnfIYoLguCqFO9oh1E5RA+zvoSpthv3PA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n6jT3dU3AICaawWUjju+eLu02AhN+oavzT4unnQGtlbUtCBBoDPSk6YDJNZq1IoFKNibocUldHeap6TBIA+/gdQpFxPrrJJaVivPl3hSU1QWccLpYAmpcOLFhoMZOnCXJVOcroh4Q5z8ra+J+X42kHmhcdYHShFwcz+SFJqUwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrsqxMkQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrsqxMkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAB9C4CEE2;
	Sat, 26 Apr 2025 06:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648076;
	bh=2S6FazreNdjnfIYoLguCqFO9oh1E5RA+zvoSpthv3PA=;
	h=From:To:Cc:Subject:Date:From;
	b=nrsqxMkQLI8iHlTgxJHpUFqF41aD6CByanLOmURxG4Sr+qv7Zo1QEiHZFBJ6BNsEs
	 yrN2NKnVJsipUJQTDYCXLMpDQfg5z5G+LknEnno/Dvtde19fQun8pK6LtaU74EerYM
	 JV3a2+gFE5weDPL9t3nVvoR1Daxg/5RRodYvScqjaM8/w0QZi7buE+RBuq0Jdp6zBo
	 VDx+d3t9Cge+DBP8A5FJdBqbKgWpc8zNiHbJLzpcrNjdWG4Dl3b+EeXGJqMwwtppgo
	 oUgLB00eotL4RZllkuWEe3rho4rCHKQF18NWqOUtzZgbjB+qfdonyxwktbJiufbi/3
	 Uc2piYQsKxiPw==
From: Kees Cook <kees@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Kees Cook <kees@kernel.org>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] drm/vkms: Adjust vkms_state->active_planes allocation type
Date: Fri, 25 Apr 2025 23:14:32 -0700
Message-Id: <20250426061431.work.304-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=kees@kernel.org; h=from:subject:message-id; bh=2S6FazreNdjnfIYoLguCqFO9oh1E5RA+zvoSpthv3PA=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8lSfu6W4MtPbYf3hzwpalax4WLg559Ob6Wpb5E4rSV it9ik8u6yhlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjICxdGhvUb248ZT+JffLlV tVL/wudGWdXjX6eG8WRGs9qYxhYuZ2P4H5rlLi716ODxDhuv0LKL6nlh8sIdb3Z15xwtVuxSnSH FAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct vkms_plane_state **", but the returned type
will be "struct drm_plane **". These are the same size (pointer size), but
the types don't match. Adjust the allocation type to match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 12034ec12029..8c9898b9055d 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -194,7 +194,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		i++;
 	}
 
-	vkms_state->active_planes = kcalloc(i, sizeof(plane), GFP_KERNEL);
+	vkms_state->active_planes = kcalloc(i, sizeof(*vkms_state->active_planes), GFP_KERNEL);
 	if (!vkms_state->active_planes)
 		return -ENOMEM;
 	vkms_state->num_active_planes = i;
-- 
2.34.1

