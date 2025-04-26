Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C8481B6;
	Sat, 26 Apr 2025 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648010; cv=none; b=SwV1aS/Y12o1X+T4Vh+GSJQeZPTv8GgVUHo0uvh0x7htGHO2vRO97G7tTpbGaEYngV6x+pZsxvUiYO5zVTJTI68ZpMHjVbxoXyVLs6bdSifXCPuqPNgn1XrPhhDx8xbjmWHfTKlwWhtXlaUtdYgeeK8MItxlclNWHlWfVdkv/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648010; c=relaxed/simple;
	bh=b/DByUu/J9hyxQtq5Q/daVnBO4Txp/CsRF+oklwCXj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/opVr8PP60K59H2j7BZNoRVQJQ6/QXVGceE13idEC698tFBX0KTlfnMO1wWaEtetBSR2EXZtVx+n25GB5NNGT/Twy8wEUI4DfbdywaX7oGnHjs2nAXUIlMXvRK+JUJ8wsr3AO8tTQJfzM80JmRzt3bn7e++JmXsQofQsWW+PpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqaD1P0d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqaD1P0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9188C4CEE2;
	Sat, 26 Apr 2025 06:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648009;
	bh=b/DByUu/J9hyxQtq5Q/daVnBO4Txp/CsRF+oklwCXj8=;
	h=From:To:Cc:Subject:Date:From;
	b=oqaD1P0dAVGKNtVDCtWp9bEFA7kFfaxQevNJ64Yc4jGDdTPzFehhtcU1/Q0aM71OB
	 RWKxFg0Rd/31tyDfOwY43rATEEsD2tYIybSCsAhP1EOTj7vdB+uiO7kaHmF08/6AHp
	 SjCa3OWtrr2wJqDvEiRxbK4MSzzJX7vc42vtBMm9+Qn/TrCKHJr0WN0vuXU1FlxIHT
	 oOq4U4Bmc2UkxY3THYq3vH76RRjEs+xwBft6dOiaNuAwEPanmyTDgslwnm1MOKwM3c
	 FxBDH09QS8mrjIYiBfQBd4oePLloP2tgQxfA0DNt27w1DdHymPBtazfI2Q7BjPStPB
	 DqpY4aq0ft1TQ==
From: Kees Cook <kees@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] drm/plane: Remove const qualifier from plane->modifiers allocation type
Date: Fri, 25 Apr 2025 23:13:26 -0700
Message-Id: <20250426061325.work.665-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=kees@kernel.org; h=from:subject:message-id; bh=b/DByUu/J9hyxQtq5Q/daVnBO4Txp/CsRF+oklwCXj8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8la36K7XvyrY7l/oVlZ1MyFRiVpqnUTJlVslCZbsW/ /YfcyM7SlkYxLgYZMUUWYLs3ONcPN62h7vPVYSZw8oEMoSBi1MAJtLizPC/9uWeEpvjRWfPeOq2 vfr2pfhmgHmOkMdajcs1FswaxXy/GBnW+s3f+2W6GueCssQC/z1GHIxKEmp/JnLM39Ic8+r71kQ GAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "uint64_t *", but the returned type, while matching,
will be const qualified. As there is no general way to remove const
qualifiers, adjust the allocation type to match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/gpu/drm/drm_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index a28b22fdd7a4..a9f5c361780d 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -414,7 +414,7 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 
 	plane->modifier_count = format_modifier_count;
 	plane->modifiers = kmalloc_array(format_modifier_count,
-					 sizeof(format_modifiers[0]),
+					 sizeof(*plane->modifiers),
 					 GFP_KERNEL);
 
 	if (format_modifier_count && !plane->modifiers) {
-- 
2.34.1

