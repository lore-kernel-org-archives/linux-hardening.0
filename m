Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D253B19D4;
	Mon, 27 Apr 2026 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331709; cv=none; b=pZ0qXcV8EJskpzuLDGLMbT0Q9xSUrPLR9UR4Y6ZiS4NC1T4pBvx76Wvprr2hHegBgGRafx7XlvSL6q9pUiipdgdh1AGbtvbcRtodHlDO3yOY644nwdc4zt3/bctefXgt1GHmEQNdDP/p6t3NFepDQMJxqeh/aOvo3Z7xddZVb3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331709; c=relaxed/simple;
	bh=UZm8itTuqte324ypWLZllEeciHe5OEJKjyiMosMVzQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i/HXhL7gw+j2zg7+7vhX1S9OD2wCnenezpOKXQleTP/OkO7KKoQci/Km4+i+g7OiRg5sPGks2YkgbySRAa9OmMzJce5IBCuzZvZnOxmJm9TZVoq10bTiM8QHwYBc/L+UEO/StU22aco0xQuKz50p0P+qFL7S0ACLW9k++6KxQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT2KNs3a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT2KNs3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685A5C19425;
	Mon, 27 Apr 2026 23:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777331708;
	bh=UZm8itTuqte324ypWLZllEeciHe5OEJKjyiMosMVzQo=;
	h=Date:From:To:Cc:Subject:From;
	b=GT2KNs3aaq3OuFlS873NyVfL3dR00Jw4QHuvWS5ycYswwK3sUybz09CjXH1zARbvl
	 dl25TAv8b7r7a4G6uPmjGr3PavoT2lTb59hK2KX+JLmMCNNtdwYADv0a8zUKB6QfOL
	 oXDvrw8qFTIULszXmGuSKe3H689nOHNaspWs3BcllyMQGcm5thlaBZm63GwpJPzFS8
	 S6oaC44YVpO09EEW/sO856MVvv12HK5oUTXZCpP+RQSNbNZa70GzVH1ukuqCbaD2db
	 oeF59+888nOYxafF1YrJmbqwvmukVY8UsRS2xnARcOEU7gMd4gjPc1xZI91Xd62y0V
	 KZA0CMXBGQcNA==
Date: Mon, 27 Apr 2026 17:15:05 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm: xlnx: zynqmp_disp: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <ae_t-fkryL-qw4eN@kspp>
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

drivers/gpu/drm/xlnx/zynqmp_disp.c:102:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Lastly, the static_assert() ensures the alignment between the FAM and
struct data_chunk sgl; is not inadvertently changed, and it's
intentionally placed inmediately after the related structure (that is,
no blank line in between),

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 9a8f38230cb4..05807c7a93d7 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -99,9 +99,14 @@ struct zynqmp_disp_format {
  */
 struct zynqmp_disp_layer_dma {
 	struct dma_chan *chan;
-	struct dma_interleaved_template xt;
-	struct data_chunk sgl;
+
+	/* Must be last as it ends in a flexible-array member. */
+	TRAILING_OVERLAP(struct dma_interleaved_template, xt, sgl,
+		struct data_chunk sgl;
+	);
 };
+static_assert(offsetof(struct zynqmp_disp_layer_dma, xt.sgl) ==
+	      offsetof(struct zynqmp_disp_layer_dma, sgl));
 
 /**
  * struct zynqmp_disp_layer_info - Static layer information
-- 
2.51.0

