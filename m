Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883A3F5BDC;
	Thu, 17 Sep 2026 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679446; cv=none; b=IsTw0WS1a/YT4U5Mu2xbrDeGEbB7/DnLwEouRb4RLHQT9E7tw/mOi8EpQtzdzCk6k6xtdbIFklHmV1LJ2pI/il2MTNA2eQLbMgMODyElZ0Sts4YI00OBHxJ5IAOjgOx/fOiITaG8+E+RtC1Ym0731o72myYnv9qeLA1lfn/i9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679446; c=relaxed/simple;
	bh=nN6/o3fIznxE1gGsURsgvA3CbuI+A9A9axTFzQ2O0/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kxnq8HLJkKHEpDcR+e/FzlSUqF5M6Uz/jOusz8HN5vrtdoN/UOjgkwoBHwMibTFDG9uc2hxc9cHJkj1jfltwe3ypGUZr0RvqDwG9yXW9YpPSBxM6mZk7gaO+AVUmHqMfPlWaer0EQ1MmpoBAKpCHlEVxkM7IOCUkwHUhzIcj91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SClpKFvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SClpKFvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C781E1F000FF;
	Thu, 17 Sep 2026 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679444;
	bh=LMqiWas2FUBqY7GmG57gKbyoisDsrqZzljM8FINN47U=;
	h=From:To:Cc:Subject:Date;
	b=SClpKFvFxknSP1tXneCc7boQiUsCGbDtmt+XoziYwvb2/JY4KjsVpuEam/xnBLHHA
	 BRDf/Kj1XF2YUpPB0iS94Wibvw4bnnLTJ5LuSk/5zyYwW3jSnyFFqXhuJ87DKaQmhv
	 hbp9z7XoZ4zmgZYw7RKO+l797yU64IrRpcMdF43dhH59ikw3Em0jdCB3a2CiFMwnhV
	 nlNX22Mh6CofvYwFkcWEdD37QXmX/TjJj0Afy3TbqxMvxK/MMc6GjBbFZ/X1OXt6mW
	 5dP49BUTdCRd4feUQWqGlFIBRj9MfnBKFhIXpMhi6uJ9K4xt+uTUlQqn3pCDxQYIXK
	 kTM4C5EEWEM+w==
From: Kees Cook <kees@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andrew Davis <afd@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wm8904: Add const to drc_texts allocation type
Date: Thu, 17 Sep 2026 14:10:43 -0700
Message-Id: <20260917211042.i.810-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=kees@kernel.org; h=from:subject:message-id; bh=UgRqW7dwHQDycwpFoo63KSiZiHKwk0ULmp8DSDALwtQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwoMaZyrsrv9pJL8tY5dwcCmD25+90ewRDTeFOrkWF N9+PN2io5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCK/fjEyPMrjnjPDNfPpnaWP p0w1u/9IIvto2sRMoem9EYqZM92MnzD8TymZcGSvgaxK0fn94R48T+9IsxeEMnd27V+asXPjy/Y 5vAA=
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
sound/soc/codecs/wm8904.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Andrew Davis <afd@ti.com>
Cc: <patches@opensource.cirrus.com>
Cc: <linux-sound@vger.kernel.org>
---
 sound/soc/codecs/wm8904.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 9e5782e50f47..f6c31f2f5f1f 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2186,7 +2186,7 @@ static void wm8904_handle_pdata(struct snd_soc_component *component)
 
 		/* We need an array of texts for the enum API */
 		wm8904->drc_texts = kmalloc_array(pdata->num_drc_cfgs,
-						  sizeof(char *),
+						  sizeof(*wm8904->drc_texts),
 						  GFP_KERNEL);
 		if (!wm8904->drc_texts)
 			return;
-- 
2.34.1

