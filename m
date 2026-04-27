Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36F374E66;
	Mon, 27 Apr 2026 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334301; cv=none; b=CVL65+GGqqiJfKIFpLOTkSWWqTWHfFYXMGH9Pnm3nQjgCObcVXgoa7aca6+4qS58eba2BS0JZYXnbPBt0s+xDOKBwozHPrkV6iBDOSWuWtE2KH8gyM1J4MKUyHZ8HEkxy6Bo3oOSCOEQM13WIxP9HvJPKj7SepvtwgR5vpEDeBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334301; c=relaxed/simple;
	bh=2uhLD0tH1NwpJiWOQG116+gMkzVllKmTE1oc9AVp0dU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rOzN1g2KmOMw7mtxdmlX7SkC2AlNA3436R4xd7JZah9Bks60DokhKI7JFkUb83I60c3BYHArSDXZUbeXK50yZh6AGYqP7l8KOfUBCbXaEYsnMPjfve81oO9Mm623r25XG9IYNl3b6oDP1aVCl5mTqOXJsqzIE39rgpxwXwVK46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKFfGkJT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKFfGkJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE43C19425;
	Mon, 27 Apr 2026 23:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334301;
	bh=2uhLD0tH1NwpJiWOQG116+gMkzVllKmTE1oc9AVp0dU=;
	h=Date:From:To:Cc:Subject:From;
	b=kKFfGkJTvVWVQxPcyS8d+RRPD4dm4+SnBAnNjyFEcvwbszfa8aDfc+NW+qKHp4MMJ
	 eJgSPVgz/qCv1/DMuR9VFcN8CRnipTllaVPCn9LSe2An4tsnBtVC4XMxsZg9Jjd224
	 k++7MTsodi3NhSke+fkF88y/VZB8LPmtuKnuztisX3iNDBmLSDxijl5nyQxGOFuN4e
	 IYcYPvVhd5F44lhHlCebbIjKjsPPQ8X5D5KyMPCmX7KkvciQWygzVmx3IJ1BBBqcA9
	 5AW1+/L0zS1mllpYvzFvpLFIJZp0O6HkpbZr/7dPFte3zvaTGWwyaIl/SPDytV/MrF
	 w3Fywm4EmjMnw==
Date: Mon, 27 Apr 2026 17:58:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/i915/gvt: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <ae_4GkBsNl_0SYTm@kspp>
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

Use the TRAILING_OVERLAP() helper to fix the following warning:

drivers/gpu/drm/i915/gvt/opregion.c:126:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Lastly, the static_assert() ensures the alignment between the FAM and
struct efp_child_device_config child0; is not inadvertently changed,
and it's intentionally placed inmediately after the related structure
(that is, no blank line in between).

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/gvt/opregion.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index d6e76ba31d60..efe457c02788 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -122,17 +122,21 @@ struct vbt {
 	struct bdb_data_header general_features_header;
 	struct bdb_general_features general_features;
 
-	struct bdb_data_header general_definitions_header;
-	struct bdb_general_definitions general_definitions;
-
-	struct efp_child_device_config child0;
-	struct efp_child_device_config child1;
-	struct efp_child_device_config child2;
-	struct efp_child_device_config child3;
-
 	struct bdb_data_header driver_features_header;
 	struct bdb_driver_features driver_features;
+
+	struct bdb_data_header general_definitions_header;
+
+	/* Must be last as it ends in a flexible-array member. */
+	TRAILING_OVERLAP(struct bdb_general_definitions, general_definitions, devices,
+		struct efp_child_device_config child0;
+		struct efp_child_device_config child1;
+		struct efp_child_device_config child2;
+		struct efp_child_device_config child3;
+	);
 };
+static_assert(offsetof(struct vbt, general_definitions.devices) ==
+	      offsetof(struct vbt, child0));
 
 static void virt_vbt_generation(struct vbt *v)
 {
-- 
2.51.0

