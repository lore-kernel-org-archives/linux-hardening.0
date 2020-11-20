Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E937C56201
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D72224C
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6tSotYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgKTSXr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgKTSXr (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:23:47 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613082224C;
        Fri, 20 Nov 2020 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896626;
        bh=+9m9Tix3zo1E+IN4qSy2H96Ab04qH4lP0hi/QiPNlOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6tSotYJpZgWbzq48qaqRAORcfUfVn9vocPCYTAYOmX1DE+C4k6SRT6eFYLkaMZIF
         Y8f4oTl7w7n7lOl9ddWkJq6fXrohIbqNp3kfTNnxtg8Ps8tcbFOR5/w/im1qWTj5oU
         zSWCOsHliwzBpmzYJlEWabsFX1jV3WDCLKf4AmBo=
Date:   Fri, 20 Nov 2020 12:23:50 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 002/141] ASoC: codecs: Fix fall-through warnings for Clang
Message-ID: <d17b4d8300dbb6aff0d055b06b487c96ca264757.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple break statements instead of just
letting the code fall through, and also add fallthrough pseudo-keywords
in places where the code is intended to fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/codecs/adav80x.c | 1 +
 sound/soc/codecs/arizona.c | 1 +
 sound/soc/codecs/cs42l52.c | 1 +
 sound/soc/codecs/cs42l56.c | 1 +
 sound/soc/codecs/cs47l92.c | 1 +
 sound/soc/codecs/wm8962.c  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 4fd99280d7db..75a649108106 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -373,6 +373,7 @@ static int adav80x_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_CBM_CFM:
 		capture |= ADAV80X_CAPTURE_MODE_MASTER;
 		playback |= ADAV80X_PLAYBACK_MODE_MASTER;
+		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
 	default:
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 1228f2de0297..e32871b3f68a 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1034,6 +1034,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 				priv->out_down_delay++;
 				break;
 			}
+			break;
 		default:
 			break;
 		}
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index f772628f233e..796b894c390f 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -944,6 +944,7 @@ static int cs42l52_beep_event(struct input_dev *dev, unsigned int type,
 	case SND_BELL:
 		if (hz)
 			hz = 261;
+		break;
 	case SND_TONE:
 		break;
 	default:
diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 97024a6ac96d..bb9599cc832b 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1008,6 +1008,7 @@ static int cs42l56_beep_event(struct input_dev *dev, unsigned int type,
 	case SND_BELL:
 		if (hz)
 			hz = 261;
+		break;
 	case SND_TONE:
 		break;
 	default:
diff --git a/sound/soc/codecs/cs47l92.c b/sound/soc/codecs/cs47l92.c
index 6e34106c268f..52dc29942ec2 100644
--- a/sound/soc/codecs/cs47l92.c
+++ b/sound/soc/codecs/cs47l92.c
@@ -201,6 +201,7 @@ static int cs47l92_outclk_ev(struct snd_soc_dapm_widget *w,
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 0bd3bbc2aacf..3af456010b9c 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3203,6 +3203,7 @@ static int wm8962_beep_event(struct input_dev *dev, unsigned int type,
 	case SND_BELL:
 		if (hz)
 			hz = 1000;
+		fallthrough;
 	case SND_TONE:
 		break;
 	default:
-- 
2.27.0

