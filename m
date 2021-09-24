Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53424C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 10:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCE260EE2
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 10:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbhIXKzP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244742AbhIXKzO (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 06:55:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D53B61107;
        Fri, 24 Sep 2021 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632480821;
        bh=X3iFV4UPkFtW/wAMFdMZ6F4j16STunkrtRPHPmEE4hw=;
        h=Date:From:To:Cc:Subject:From;
        b=DEF/0Z0fl+rhizpmcrV8fQndAuSJVFtWcDBbyz3agsDkUVTpX5mrVOvgIiKtk81QQ
         5/yz5R8BRCnEqio5PxV537tlhy0QQnbqptdIIfsRia03uPC6xidB0QNBdzdsKHyEwJ
         ZmQFreX+O3Rg29MKwimIHG7VssqMuc0Aceh7OZ6eFHhGQ5utEagBwSXDTbff3oG3xW
         lbJNj/dQEOwARNAQu6yvU6tsOBcSuDw5qld+dZJYHvP4mbgz/IhQYoTQH/aq2Aa1G1
         mouf30CAefETXVu7SypcQ/v3Uj1cqBNXO72HQaj/fg/PHlRbSexOS6HukeT10Yr16u
         cEvSYJ6SdY45g==
Date:   Fri, 24 Sep 2021 05:57:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] firewire: cdev: Fix function cast error
Message-ID: <20210924105733.GA78013@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Fix the following function cast error when building with
-Wcast-function-type:

drivers/firewire/core-cdev.c: In function ‘ioctl_create_iso_context’:
drivers/firewire/core-cdev.c:985:8: error: cast between incompatible function types from ‘void (*)(struct fw_iso_context *, dma_addr_t,  void *)’ {aka ‘void (*)(struct fw_iso_context *, long long unsigned int,  void *)’} to ‘void (*)(struct fw_iso_context *, u32,  size_t,  void *, void *)’ {aka ‘void (*)(struct fw_iso_context *, unsigned int,  long unsigned int,  void *, void *)’} [-Werror=cast-function-type]
  985 |   cb = (fw_iso_callback_t)iso_mc_callback;
      |        ^
cc1: all warnings being treated as errors

This helps with the ongoing efforts to globally enable -Wcast-function-type,
so when Control Flow Integrity checking lands in the kernel, incompatible
function type casting doesn't interfere with it.

Link: https://github.com/KSPP/linux/issues/20
Link: https://github.com/KSPP/linux/issues/102
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/firewire/core-cdev.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index fb6c651214f3..fd2923599667 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -957,7 +957,10 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 {
 	struct fw_cdev_create_iso_context *a = &arg->create_iso_context;
 	struct fw_iso_context *context;
-	fw_iso_callback_t cb;
+	union callback {
+		fw_iso_callback_t sc;
+		fw_iso_mc_callback_t mc;
+	} cb;
 	int ret;
 
 	BUILD_BUG_ON(FW_CDEV_ISO_CONTEXT_TRANSMIT != FW_ISO_CONTEXT_TRANSMIT ||
@@ -970,7 +973,7 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 		if (a->speed > SCODE_3200 || a->channel > 63)
 			return -EINVAL;
 
-		cb = iso_callback;
+		cb.sc = iso_callback;
 		break;
 
 	case FW_ISO_CONTEXT_RECEIVE:
@@ -978,11 +981,11 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 		    a->channel > 63)
 			return -EINVAL;
 
-		cb = iso_callback;
+		cb.sc = iso_callback;
 		break;
 
 	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
-		cb = (fw_iso_callback_t)iso_mc_callback;
+		cb.mc = iso_mc_callback;
 		break;
 
 	default:
@@ -990,7 +993,7 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 	}
 
 	context = fw_iso_context_create(client->device->card, a->type,
-			a->channel, a->speed, a->header_size, cb, client);
+			a->channel, a->speed, a->header_size, cb.sc, client);
 	if (IS_ERR(context))
 		return PTR_ERR(context);
 	if (client->version < FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW)
-- 
2.27.0

