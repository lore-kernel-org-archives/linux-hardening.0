Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6C44C6C;
	Mon,  5 Aug 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871739; cv=none; b=DUjLYx2ptylZO5JwrX2InbPTertz+Bde1u1bbFKc3uVrXsj6Y53Wk5PfHwnJ7I8hrVjlxVixzmkYX1TRtZnS1V+rEUtzo+aa3nfreiw4luwOZQDCqo8uAiG1C+weJ/enCVB3DuUZXabrfrw9IgfMXeC+oVVyitmYPXoB4rcT2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871739; c=relaxed/simple;
	bh=9ceTR3FS3YsE/s7IKyWm602O6C7rxBh8abM34OAH5+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aaUtrfe+sPdJRjZj3Cjuf7M4I6svdDr/unkrYzgDmbJIfBI5qX4Hto5wZSPmGlhuRnGVuMtelgEHQsnbKol0Wn/MrhywhpsIG7y5CC3ft3lK3gbzQgDtGql6ByGrPQjVCfyAX05jRiofP2yVQocMxA4rQr6AbW/U6iPE0jk83f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXyzu3Js; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXyzu3Js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE53FC32782;
	Mon,  5 Aug 2024 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871739;
	bh=9ceTR3FS3YsE/s7IKyWm602O6C7rxBh8abM34OAH5+E=;
	h=Date:From:To:Cc:Subject:From;
	b=pXyzu3JsU4tzt6EEi+BUFNppuNT1yAYgV0M3I61GlrwZqPF2RPlCByNk43gSsem85
	 ZW0AHzZI3U7CyVYyDdrK130kuAJO/xBGOwIz4j7L8/aC5AxzLXkW3PcVpkVUccdf/F
	 emHXm0p0xoA8Q0S5Z8uBtXk3g2w8XPL4Ip3BT4HARSekiiC8KYk6kO4psx6rsCUdE6
	 iIaPzWNJ65mbudc7va3LXVAEkpcLTjW1qezkB0+6cGtvieoutvOBaFW/ghgRnFpmdS
	 teUG/8QY62/xm1Ft/ufys4kcQMWqIC3zOQA9EVa55S3QlNm05mdwdUU61GSNxkq8v3
	 lVB8NZhg7wW5A==
Date: Mon, 5 Aug 2024 09:28:55 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: SOF: sof-audio: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <ZrDvt6eyeFyajq6l@cute>
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

Move the conflicting declaration to the end of the structure. Notice
that `struct snd_sof_pcm` ends in a flexible-array member through
`struct snd_soc_tplg_pcm` -> `struct snd_soc_tplg_private`.

Whith this, fix the following warnings:
sound/soc/sof/sof-audio.h:350:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
./include/trace/events/../../../sound/soc/sof/sof-audio.h:350:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
sound/soc/amd/../sof/amd/../sof-audio.h:350:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
sound/soc/sof/amd/../sof-audio.h:350:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
sound/soc/sof/intel/../sof-audio.h:350:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
sound/soc/sof/mediatek/mt8186/../../sof-audio.h:350:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
sound/soc/sof/mediatek/mt8195/../../sof-audio.h:350:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/sof/sof-audio.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 49be02234fc3..4967dd3cf3f5 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -347,12 +347,14 @@ struct snd_sof_pcm_stream {
 /* ALSA SOF PCM device */
 struct snd_sof_pcm {
 	struct snd_soc_component *scomp;
-	struct snd_soc_tplg_pcm pcm;
 	struct snd_sof_pcm_stream stream[2];
 	struct list_head list;	/* list in sdev pcm list */
 	struct snd_pcm_hw_params params[2];
 	bool prepared[2]; /* PCM_PARAMS set successfully */
 	bool pending_stop[2]; /* only used if (!pcm_ops->platform_stop_during_hw_free) */
+
+	/* Must be last - ends in a flex-array member. */
+	struct snd_soc_tplg_pcm pcm;
 };
 
 struct snd_sof_led_control {
-- 
2.34.1

