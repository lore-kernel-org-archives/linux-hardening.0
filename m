Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B2B1D5CD1;
	Tue, 11 Feb 2025 04:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739246922; cv=none; b=Zvu1lwk0u8mazjO6PIw22F/ffIV098vE15zmsMdLHYS9zzGjAndcGWmLLk1x9ya3+LWnDGyN2zo9VaHiXsejitPS9zAKskE0mg1fI/v87orBYxdJXkBSqOq9/iBNaNqsCWMv6WH8DwWlHQ3EcL2oHPhuPZFLtVHHolla2CHu+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739246922; c=relaxed/simple;
	bh=RIdLjh0gInw/I9blWel0UlToC5xdW4xXT3livZR0rJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UQJQlgpUkoR8w3jfKlUpHfl0zVpKZJl5AZm4OoyBGXwpW0+wfIzzmh5mpanzDpKngsjsqyFuiQa9+kj6hfJBhdQbEEgcESeeogWU/F+Ya2Bmgli9xPOmdGrEado5xVVT6+zu5uOV46IqbioOQBGcZVttqCmQM11AH6BYq3Cv7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=FMLvhbTY; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="FMLvhbTY"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YsSc36PQNz9t0N;
	Tue, 11 Feb 2025 05:08:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1739246916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y0neZiz0fLVNbrblskOmdm8UUdxdooce3vHdNB+7YLA=;
	b=FMLvhbTY6AfyMGu5f5YG7nHM0Ysya9bCSvxSxF9LQiAV5EPqTchMCL2AuMo/8atJyg63vL
	jB4lOVOmCWJNdCCVZkQssUCTdK3QdUVzvGprScKMyo27GAMrYmBoI65h7LDFe571VfNxUY
	du6RgUt0d8IMsmFxMWtPvBtoH8DfqDPgXyhTGtjrg/lXxrAIBOCqFoo1TGrXLDVD0v9cyN
	eKnsrb1M/8iBQHlwZl1gqzglbqVuZINraYZJCblpZQ2T81i5HpdKiFpCLx99Gb/0deP1Jo
	GI1XIN6r5HKIu7zXTS0ze1aMcQ2zbq7sQdymmG8R2/XPMlzSCOHak2ZBU7hbrA==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Mon, 10 Feb 2025 23:08:27 -0500
Subject: [PATCH] ASoC: Intel: sof_sdw: initialize ret in
 asoc_sdw_rt_amp_spk_rtd_init()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-soc_sdw_rt_amp-v1-1-1ee1afcd8941@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIADvNqmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MD3eL85PjilPL4opL4xNwC3VTLZHMD49SkVJOUZCWgpoKi1LTMCrC
 B0bG1tQBe6DfAYAAAAA==
X-Change-ID: 20250210-soc_sdw_rt_amp-e9c703ebe4dc
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=RIdLjh0gInw/I9blWel0UlToC5xdW4xXT3livZR0rJc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBLODZhLy9ZTGV2NHY1bi92MytVeWZlS09sRWpjZDR4CjMvOTY1dnNGRzNQNmcrYjR1
 cWwxbExJd2lIRXh5SW9wc3Z6UFVVNTdxRGxEWWVkZmx5YVlPYXhNSUVNWXVEZ0YKWUNLZTN4Z1p
 qano2OHUxS3R1KzB5TmZQWlNWQ3ZwNmRQMi83MHRwTFFXZXVkOG5xbG5Wc1ZXYjRaM2FnOUhQMg
 oxYnpRNDh2MGRWOFoxcys5K21SOTlOVGJ4dmJ6NTM4NnV0dDJMajhBVnJWVVR3PT0KPUpjZE8KL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

There is a possibility for an uninitialized *ret* variable to be
returned in some code paths.

Setting to 0 prevents a random value from being returned.

Closes: https://scan5.scan.coverity.com/#/project-view/63873/10063?selectedIssue=1627120
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
Would it potentially be better to remove ret entirely and just return 0
explicitly at the end of the function and directly return in the if
statements? I'm not sure.
---
 sound/soc/sdw_utils/soc_sdw_rt_amp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_rt_amp.c b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
index 0538c252ba69b1f5a24ba2de2a610b22d0c0665f..61a00a3548d85689c13e2d2a301da17a572e4a0e 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt_amp.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
@@ -190,7 +190,7 @@ int asoc_sdw_rt_amp_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc
 	const struct snd_soc_dapm_route *rt_amp_map;
 	char codec_name[CODEC_NAME_SIZE];
 	struct snd_soc_dai *codec_dai;
-	int ret;
+	int ret = 0;
 	int i;
 
 	rt_amp_map = get_codec_name_and_route(dai, codec_name);

---
base-commit: febbc555cf0fff895546ddb8ba2c9a523692fb55
change-id: 20250210-soc_sdw_rt_amp-e9c703ebe4dc

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

