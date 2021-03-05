Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC990C433E9
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF1365017
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 09:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCEJxG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhCEJxB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 04:53:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B31264FE9;
        Fri,  5 Mar 2021 09:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614937980;
        bh=AQkQVnVFWVRfrhHzYaVpWwDXLniWq/KwNuU/2JTjAYY=;
        h=Date:From:To:Cc:Subject:From;
        b=iqNNkl+XHv8aY7VPk/6k81fIjyJtp6YhO6A2g+MjsujC0oOp+s8+iY5r2rJ7SeNTI
         kLlhwqxY6dC6hKKYMhY+7LYL7fE2VGdNNDP0ezbuHcsEK8geuQcxbbAfxmp3kKmFC1
         +/oVDCy3xDfNe5a5Y78rz/1OIwiVkQezLeNgrABgbdou+VOr+6fEU/rTgLPfgGOJ0i
         XKKqYucfJH5QY1zgt8j/M5MWGWCqaPBqqa/mV8AFrDt71Bh4aB8pAquMmPnL8gTsYW
         mS6dcGrj75fwgeBBItL1lKJU7PA+3Yfml1l5/lOdt/xCUnQXKq9hUo3Z3oxnk6DaAv
         QjX8FzC/CULrg==
Date:   Fri, 5 Mar 2021 03:52:58 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] hwmon: (max6621) Fix fall-through warnings for
 Clang
Message-ID: <20210305095258.GA141583@embeddedor>
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
 drivers/hwmon/max6621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
index 367855d5edae..7821132e17fa 100644
--- a/drivers/hwmon/max6621.c
+++ b/drivers/hwmon/max6621.c
@@ -156,7 +156,7 @@ max6621_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
 		default:
 			break;
 		}
-
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

