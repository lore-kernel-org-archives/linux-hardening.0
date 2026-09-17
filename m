Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E7495AEA;
	Thu, 17 Sep 2026 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679467; cv=none; b=teYGkc3d8bEC4WTa8zhAIpKa7KaFWiQdV4w74qDF9R+uUpiCoIIcAvT1GqvTQCQbi8ERyes1UgUpG0Y2BUdh+31taCzi8Zw1w+QH7llyLnF1eEYbj8Yqo0U/DaL1c1n2Nvp6t2J4mNuM86HG22ISqTBWEvyhb7W2rvSA0nvLNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679467; c=relaxed/simple;
	bh=yIFMA4tfVgtZpjJqBTFzysUj7c4JJevWpmcI0cJdTvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tvu1hoDpBn0msF/cSRrjYQqURGto3lQuAJTkVyfY1lO3r0UsoX6wphE/F4aLtTAIPn3iV5piAqLO8IJKOpxMNakle8AsD+KiVBkDdSQkvLSPNE1JIx+V3cU5yDwGjSiw/SBSud+wqdB8Fe6WP8uOcDueL9UZX91bJiTPYyfissY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs8wN69h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs8wN69h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2141F000FF;
	Thu, 17 Sep 2026 21:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679466;
	bh=8QL3LBNW69EuTVGMqlSRCkiF4zv46vAKpJTuUygOhY8=;
	h=From:To:Cc:Subject:Date;
	b=Hs8wN69hn1c6byucZh1W7Y9n7xUenM9u3Tt4fHvdHRFY5/zG+k3es+9vrfBE5mUeH
	 MhJQ6CbPXPVLfrdICANUM++2kheTZUVPzsaWKMNVNSDSjKpjE/+y4W8TtediL8W439
	 Ftf5pp3VzpLIICrReJURvsnQwlBGDnJvX9dSg8RncwX9ZFXnoJD8H+RrORlNOLlLJ5
	 3PCfm8e/HzeWcP2u94ZP/y0MZRaS9iRS1HiaNw7bb7AgKMdvEhT8J+WpthBI5ETe4q
	 sfp3JWBIKi9Rc9M0P3bF4VtW6D0NVMhagX+OCf5XDM3KI8nO7hl+TDKvyzRsoco/l1
	 ZS+j/t4vywVHA==
From: Kees Cook <kees@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wm8958: Add const to enum texts allocation types
Date: Thu, 17 Sep 2026 14:11:03 -0700
Message-Id: <20260917211102.i.029-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=kees@kernel.org; h=from:subject:message-id; bh=fIXFMzTVSZ9lw5Z7TZglcgF9i0Xblf8kyDDGLg68N6c=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwtNZedK8ZaV4Pl8OTQ/2lWIsvr1n6sIrgb+rOXpie trkDBU6SlkYxLgYZMUUWYLs3ONcPN62h7vPVYSZw8oEMoSBi1MAJrLnEyPDp1Plh6Lyr6afW9Z+ hyHs0q1teakHP6ee2Zy51etpkMHTAIb/Ef8SJ4c/tLrh46nhnNQa8Nt6/xHx6q/5aUmrlsl82CP ICgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for converting the kmalloc family of allocators to the
type-aware kmalloc_obj family, we need to make sure that the returned
type from the allocation matches the type of the variable being
assigned. (The kmalloc family returns "void *", which can be implicitly
cast to any pointer type.)

The assigned types of mbc_texts, vss_texts, vss_hpf_texts, and
enh_eq_texts are "const char **", but the converted allocation types
would be "char **", which is the same type without the const qualifier.
As there is no general way to safely add const qualifiers, take the
sizes from the assignment targets instead. No change in allocation size
results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
sound/soc/codecs/wm8958-dsp2.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: bui duc phuc <phucduc.bui@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: <patches@opensource.cirrus.com>
Cc: <linux-sound@vger.kernel.org>
---
 sound/soc/codecs/wm8958-dsp2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index f75a6dc9d2bb..b26c36ca8249 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -928,7 +928,7 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 
 		/* We need an array of texts for the enum API */
 		wm8994->mbc_texts = kmalloc_array(pdata->num_mbc_cfgs,
-						  sizeof(char *),
+						  sizeof(*wm8994->mbc_texts),
 						  GFP_KERNEL);
 		if (!wm8994->mbc_texts)
 			return;
@@ -954,7 +954,7 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 
 		/* We need an array of texts for the enum API */
 		wm8994->vss_texts = kmalloc_array(pdata->num_vss_cfgs,
-						  sizeof(char *),
+						  sizeof(*wm8994->vss_texts),
 						  GFP_KERNEL);
 		if (!wm8994->vss_texts)
 			return;
@@ -981,7 +981,7 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 
 		/* We need an array of texts for the enum API */
 		wm8994->vss_hpf_texts = kmalloc_array(pdata->num_vss_hpf_cfgs,
-						      sizeof(char *),
+						      sizeof(*wm8994->vss_hpf_texts),
 						      GFP_KERNEL);
 		if (!wm8994->vss_hpf_texts)
 			return;
@@ -1009,7 +1009,7 @@ void wm8958_dsp2_init(struct snd_soc_component *component)
 
 		/* We need an array of texts for the enum API */
 		wm8994->enh_eq_texts = kmalloc_array(pdata->num_enh_eq_cfgs,
-						     sizeof(char *),
+						     sizeof(*wm8994->enh_eq_texts),
 						     GFP_KERNEL);
 		if (!wm8994->enh_eq_texts)
 			return;
-- 
2.34.1

