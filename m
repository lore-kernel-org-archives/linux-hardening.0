Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469449AA47;
	Thu, 17 Sep 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679480; cv=none; b=lbS4NbanRysdvETF5bRQPRCWLsXrFCzXYCDGGr5mqM3UKq4AQGZySNa/Eb7RDzYL2uuGwPlnfPxSdq3puG87P+tMK1GjRaHRoTz0Vc8gPwPDHEczUcgIOL5mtcOWR7hMJJPyahnmpH6xc2E3Y2b2WnZ1V+JYHgRfSrS7IOq+ZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679480; c=relaxed/simple;
	bh=eUxRmespgWLKrYlTz/sxYsBdtVhmaTF2Z9wtqFFly44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=de4d9mlpHMAzWY///ghNp2Viqdu1XoS1RMPwDA9hmdw6tCyGO0JBU3434EGWWazRUVfiMNDKJglwrP9Q10lzbcj7Fzf5qUBPRHkMBDqeWUplOQmiWMZjqSc4T0OKY0ay/trtsUK8d4xClUznXOUy5j9HCD1JF8d5qTFciTSB6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZlskvZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZlskvZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBEA1F000FF;
	Thu, 17 Sep 2026 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679478;
	bh=o2f6ofe9RVUjtVmR6yTawOUgE2Y1TI9IaIzpGF9B6G4=;
	h=From:To:Cc:Subject:Date;
	b=HZlskvZJ7DRreTTAxKxrGfeXZ0whq98U6Zc18yWY9WMW3gPMRFXbv4EC+8W41/ACy
	 9mXKtc5CMEWBOxFQsoEGsxY45MDR5MUK/K33YWV0KupoV7ZtNpUkAx1JOxtqav8tX7
	 4b88aWQtS/beRLTZchwAsIwKcnTrIExjCPG3jKAv3xqFMliugXKttNMWrnk6ppyFi0
	 90sYqS1aD89VU1kFKNrvyGkYD/eXdU7XSI8lPeTQcJMOoSs/1PCync6iz5749AARGW
	 hAba3FUuroqXTTz+joVx+wSqoGqBfywhrfQpwZ2j/YIk/P3/Iw/XXWfFUwmL8oi2oT
	 y2eQNiDSK0qIw==
From: Kees Cook <kees@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ASoC: SOF: topology: Add const to tplg_files allocation type
Date: Thu, 17 Sep 2026 14:11:18 -0700
Message-Id: <20260917211117.i.991-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1925; i=kees@kernel.org; h=from:subject:message-id; bh=3krwtb8WAYATfpTi1iNtXjadDT06f+YgXEDQn89xwgk=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwku/RCWlzvIP//niYrJzOQPf3p0CW7meKGZsMT31I zb2YOGdjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkozWD473xbaZl4MbvTBQsT PsdNX25fOGTp1Ssn/8Sxds9WubdGyxgZ7jSE9rukPeLwSE51qzlwTv21nU3ILgGt85vUij6436x mBAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for converting the kmalloc family of allocators to the
type-aware kmalloc_obj family, we need to make sure that the returned
type from the allocation matches the type of the variable being
assigned. (The kmalloc family returns "void *", which can be implicitly
cast to any pointer type.)

The assigned type is "const char **", but the converted allocation type
would be "char **", which is the same type without the const qualifier.
As there is no general way to safely add const qualifiers, take the size
from the assignment target instead. No change in allocation size
results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
sound/soc/sof/topology.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: <sound-open-firmware@alsa-project.org>
Cc: <linux-sound@vger.kernel.org>
---
 sound/soc/sof/topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 8338133899ab..145bad472118 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2517,7 +2517,8 @@ int snd_sof_load_topology(struct snd_soc_component *scomp, const char *file)
 	int i;
 
 	const char **tplg_files __free(kfree) =
-		kcalloc(scomp->card->num_links, sizeof(char *), GFP_KERNEL);
+		kcalloc(scomp->card->num_links, sizeof(*tplg_files),
+			GFP_KERNEL);
 	if (!tplg_files)
 		return -ENOMEM;
 
-- 
2.34.1

