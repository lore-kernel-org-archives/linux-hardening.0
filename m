Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F37355F54;
	Wed, 29 Apr 2026 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504792; cv=none; b=nTDmghU3IoucYYiUuz4BgqukVhS24GIoyqyYL3FGf8dlNXMyutiaapxyEZHzkYzPQ/pNGD0/l3RezxcaeOkqVEB3kqGBJbbpYbIEvH2HoKohg1t8U2R2qtbUU8yp1xldnlvcZZ5uXpmprd1Pzzp9AIlelWH4v5YvYPKrjHcpgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504792; c=relaxed/simple;
	bh=XqiVdwLtQFthu7nh0kBQRc3auy5Ysg/jY1GPAXlIAfI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nOeD2+iMUIdSShKhW7rq2CH1P59+eOaJeFFuBBHMJBOXgPa+zu+6TYx8VJjiNYFdRAxvrndFx/Ys/EbFD+0+/nPSY4ASbnZA/01gH18n5YmI6XxU0RM6WfLt684Kv7g7OQXZTW85lefqQcr24JJC8X+3N1NVCpCGQtdGTs+Hk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkeuhTi8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkeuhTi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACB7C19425;
	Wed, 29 Apr 2026 23:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777504792;
	bh=XqiVdwLtQFthu7nh0kBQRc3auy5Ysg/jY1GPAXlIAfI=;
	h=Date:From:To:Cc:Subject:From;
	b=hkeuhTi8H/29ki9H0sr9MxGKwDQmRwIwY6dseeQK7KMPmWol4RVIAsTitJ4UNJjP+
	 nQc15zYDZVd2aXamISQfDVqEEZKRvm68eM2I7C8q+mIov0hIdhLsHEMoODW88Q6Aan
	 UjDkwBm1ME17LvYoJ4A2QV3xX37u36cFlyfZGKX3vCc43Xq4FPPbkkIFuQox6Qi90F
	 nYvjdKXKejzH3XIOqelNMcYF6DWQC88MZ5/Lsq35YLKxlPbRLBp+1vdWuAH7Px40zb
	 iy5X347swtAVbhTRoSc1fKrUL7+w03ntlY0bw+fHoX1U3txR4gMYJhimJD/72kbwC7
	 8ZRGZRBi56IPw==
Date: Wed, 29 Apr 2026 17:19:49 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: soc-topology: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <afKSFY3qrlSOJ0EJ@kspp>
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

Use the __TRAILING_OVERLAP() helper to fix the following warning:

sound/soc/soc-topology-test.c:136:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Lastly, the static_assert() ensures the alignment between the FAM
and struct snd_soc_tplg_hdr pcm_header; is not inadvertently changed,
and it's intentionally placed immediately after the related structure
(that is, no blank line in between).

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/soc-topology-test.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology-test.c b/sound/soc/soc-topology-test.c
index c8f2ec29e970..ef6725613b01 100644
--- a/sound/soc/soc-topology-test.c
+++ b/sound/soc/soc-topology-test.c
@@ -133,10 +133,15 @@ static struct tplg_tmpl_001 tplg_tmpl_empty = {
 
 struct tplg_tmpl_002 {
 	struct snd_soc_tplg_hdr header;
-	struct snd_soc_tplg_manifest manifest;
-	struct snd_soc_tplg_hdr pcm_header;
-	struct snd_soc_tplg_pcm pcm;
+
+	/* Must be last as it ends in a flexible-array member. */
+	__TRAILING_OVERLAP(struct snd_soc_tplg_manifest, manifest, priv.data, __packed,
+		struct snd_soc_tplg_hdr pcm_header;
+		struct snd_soc_tplg_pcm pcm;
+	);
 } __packed;
+static_assert(offsetof(struct tplg_tmpl_002, manifest.priv.data) ==
+	      offsetof(struct tplg_tmpl_002, pcm_header));
 
 static struct tplg_tmpl_002 tplg_tmpl_with_pcm = {
 	.header = {
-- 
2.51.0

