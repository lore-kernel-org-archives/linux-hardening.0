Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E02C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 18:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2516F61037
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 18:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbhJFSF5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238578AbhJFSF5 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 14:05:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 691E361027;
        Wed,  6 Oct 2021 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633543445;
        bh=1FyjDYtY1nrzviDRJTdzIW4wlmccaijK3EkJ3j2dzGk=;
        h=Date:From:To:Cc:Subject:From;
        b=Es9hat8WQPRbkGVuBWDHipR6d/RJPHE3loWTi00iznH96AFcjPchhKHbfRwyDDeij
         FMuTslzUG6UsKxn04+aAHddbTbpZxXGlonir4r4Q4TqznkKEGMQ1NSAJulb8Vj3E/l
         npbZM81SmMnl1RQPsLKuymsJxXrezk+euW9CmxoqT6U+GJKIZRQriWO2DbYf13DRvB
         Ir19EAuxro5489dJiOknQYr1akOiB6y1nW5T0ctKnP8OgDJEyYDHkfdfeAaqrTag00
         3bCBrB2zW15BnG9ilfWE23ezvH9SbyU4i18GqtwD3uXNd+wn1N1YalnDhOIveDh1+M
         Uhf1yruccC4gA==
Date:   Wed, 6 Oct 2021 13:08:10 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: q6asm: use kcalloc() instead of kzalloc()
Message-ID: <20211006180810.GA913370@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Use 2-factor multiplication argument form kcalloc() instead
of kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 9251d8548965..195780f75d05 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -513,7 +513,7 @@ int q6asm_map_memory_regions(unsigned int dir, struct audio_client *ac,
 		return 0;
 	}
 
-	buf = kzalloc(((sizeof(struct audio_buffer)) * periods), GFP_ATOMIC);
+	buf = kcalloc(periods, sizeof(*buf), GFP_ATOMIC);
 	if (!buf) {
 		spin_unlock_irqrestore(&ac->lock, flags);
 		return -ENOMEM;
-- 
2.27.0

