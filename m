Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0602C4708C
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 20:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D441613E3
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 20:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhE1UVY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 May 2021 16:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhE1UVX (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 May 2021 16:21:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D767C61176;
        Fri, 28 May 2021 20:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622233188;
        bh=Y9voMhMz9B9g7rE3mo56opMWRPzgKY/nkyFObrkrKxo=;
        h=Date:From:To:Cc:Subject:From;
        b=KZ2BV87WYsJTtRauCc++r0/aOROQxSs8aVlCe7KzMX1p/whR+2mMXvgH5y+cK/9wJ
         IcxqNOvbuKZoLSyxaHMGFhXOa4MIlF/IZP9U/63BC/6Dy5CZoJTYX/QDvEt/PSGNAK
         tUSdZr2L9iME15oBI3LVfTLXXpb2uCwr2skge90TjuiIsd3W1aM2j05VuE9VtIpD85
         bwWiAAlK/r5MKUHTHLCDrMYE3Wz4wcIXJx3P4hRRk7JD95id1oEHDIFJNr4w1SDi7R
         OGpcGJBx1mS03YPQu/vzadvK6ylJ582u4nh8MZ0/GCXdUhngLmwOyjGGt+1jE/jbjV
         e37pRB+xgjrjg==
Date:   Fri, 28 May 2021 15:20:47 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: ti: davinci-mcasp: Fix fall-through warning for
 Clang
Message-ID: <20210528202047.GA39602@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a goto statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
JFYI: We had thousands of these sorts of warnings and now we are down
      to just 25 in linux-next. This is one of those last remaining
      warnings.

 sound/soc/ti/davinci-mcasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index b94220306d1a..587967720135 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2317,6 +2317,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
+		goto err;
 	case -EPROBE_DEFER:
 		goto err;
 	}
-- 
2.27.0

