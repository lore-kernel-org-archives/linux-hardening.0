Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA1C433E9
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2E365013
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhCEJyK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCEJyC (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 04:54:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E48464E6B;
        Fri,  5 Mar 2021 09:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614938042;
        bh=EDWczzYjws+UwHiOw+guGGb5YTRT6q0FhhbiEi73sYA=;
        h=Date:From:To:Cc:Subject:From;
        b=WGEdAGRuk3ErvLHIAPXCtcYFC26hvLh2O2woRcKq7laRLWLheeQQQas/Y0rbYZT4j
         R9kgxYxXoQ/Vhsc28b27KsHNe76XAN6zGpfzOWxKBJNkYj7ROymtWiS5Z/4AGfVkMX
         cHtf94XdV9JBnSlgbtuDhunZaz5DEHRsYDkmhIofIgxYUISL3g+3CdyFJMiTVGIAKJ
         v20pQo2iwr+isLhatOsFgYoB1tEuM+lf71eDNi46zQicbxK+O3kOn4TnaRE7QVLprJ
         P4BA6/3qIKG2BdKatpAoqNFYP8PXjP25Du1nTkp3hUa0mJ3uFlLeWAsUuFlBtdqv12
         eA91agR2Tl7ww==
Date:   Fri, 5 Mar 2021 03:53:59 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] hwmon: (corsair-cpro) Fix fall-through warnings
 for Clang
Message-ID: <20210305095359.GA141682@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/hwmon/corsair-cpro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 591929ec217a..fa6aa4fc8b52 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -310,6 +310,7 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

