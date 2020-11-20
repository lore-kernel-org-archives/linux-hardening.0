Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B29C64E69
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462322416E
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxYLyx0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgKTShF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731147AbgKTShD (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:37:03 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0455624181;
        Fri, 20 Nov 2020 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897422;
        bh=udADudDkChcMOUmnZIGrdCb9+vn9Qn+OTPsqWB7CIuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxYLyx0ZzX0o17QnUqeSP/HNMQaVMLMiwDXjr44TUHtiSLSzuNzkWjeV8aupmSbt4
         4HqG5B2x3fXVK4us9pYGhjoF+SWwguYzi+OIQ+3tODutBdKApaj/Qg2KRJCDfEsBzP
         /Rwh4hY0pbO/TOzr3HjxWw847YwvzhtBlFYDVdus=
Date:   Fri, 20 Nov 2020 12:37:08 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 097/141] media: saa7134: Fix fall-through warnings for Clang
Message-ID: <cc5053e144f9ff5901e9cf894c72aa933cf480f3.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/pci/saa7134/saa7134-tvaudio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/saa7134/saa7134-tvaudio.c b/drivers/media/pci/saa7134/saa7134-tvaudio.c
index 5cc4ef21f9d3..5dc97990fa0e 100644
--- a/drivers/media/pci/saa7134/saa7134-tvaudio.c
+++ b/drivers/media/pci/saa7134/saa7134-tvaudio.c
@@ -885,6 +885,7 @@ void saa7134_enable_i2s(struct saa7134_dev *dev)
 	    saa_writeb(SAA7134_I2S_OUTPUT_FORMAT, i2s_format);
 	    saa_writeb(SAA7134_I2S_OUTPUT_LEVEL,  0x0F);
 	    saa_writeb(SAA7134_I2S_AUDIO_OUTPUT,  0x01);
+	    break;
 
 	default:
 	    break;
-- 
2.27.0

