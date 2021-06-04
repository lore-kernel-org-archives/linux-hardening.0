Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E433EC4709A
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 07:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D197560230
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 07:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhFDHyy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Jun 2021 03:54:54 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:54800 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230135AbhFDHyx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Jun 2021 03:54:53 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 50185100E7B45;
        Fri,  4 Jun 2021 07:53:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id E7B5F13D95;
        Fri,  4 Jun 2021 07:53:05 +0000 (UTC)
Message-ID: <a0452dc7da2c46e3e764bdd5fd9b94dc96d96912.camel@perches.com>
Subject: Re: [PATCH v2][next] ASoC: ti: davinci-mcasp: Fix fall-through
 warning for Clang
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Fri, 04 Jun 2021 00:53:04 -0700
In-Reply-To: <20210604072714.GA244640@embeddedor>
References: <20210604072714.GA244640@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: wnokseunpwwmwmz5szxdzhpi4q1ds8kd
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E7B5F13D95
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19tZSFvwatUPABPDfgJt6R0uDBPN0xZpRo=
X-HE-Tag: 1622793185-488135
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 2021-06-04 at 02:27 -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a fallthrough; statement.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Use fallthrough; instead of break;
>  - Update changelog text.
>  Link: https://lore.kernel.org/linux-hardening/25941c37-6e38-88ae-3afe-4f5af44380d3@gmail.com/
[]
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
[]
> @@ -2317,6 +2317,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  		break;
>  	default:
>  		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
> +		fallthrough;
>  	case -EPROBE_DEFER:
>  		goto err;
>  	}

While this is OK, perhaps the below would be clearer and a more common style
as it doesn't intermix default: with logging output and a case label.
---
 sound/soc/ti/davinci-mcasp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index b94220306d1a8..1059a696ff90e 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2305,6 +2305,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err;
 
 	ret = davinci_mcasp_get_dma_type(mcasp);
+	if (ret == -EPROBE_DEFER)
+		goto err;
+
 	switch (ret) {
 	case PCM_EDMA:
 		ret = edma_pcm_platform_register(&pdev->dev);
@@ -2317,7 +2320,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
-	case -EPROBE_DEFER:
 		goto err;
 	}
 

