Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CB4C6379D
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF6524178
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="haJl77EV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgKTSf7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:35:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730245AbgKTSf7 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:35:59 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE70246E4;
        Fri, 20 Nov 2020 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897358;
        bh=raVbo+PJSkUCViBmjpxCjDapLZZygMc9w4aW7f/hD2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haJl77EVDsvR+Bpe+p+ZiuuOsT0tJ5HYcZgG0ByzJz6RuMeb3J89cFTEca92DXubB
         QaCer/VmScOas9G4VE209t+/+ECqpX2LdqvFE9/ysJOVqWWPioBNisHgAdLPhdBC+g
         AiGZxQsQ49sTZ/wPG4P6NbJHmdFgwCdiXShfv/wE=
Date:   Fri, 20 Nov 2020 12:36:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 086/141] hwmon: (corsair-cpro) Fix fall-through warnings for
 Clang
Message-ID: <be5c59f9bc4bac8c968bbd7443d08eaaf8a28ef8.1605896060.git.gustavoars@kernel.org>
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

