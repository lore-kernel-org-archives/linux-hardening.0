Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3F6C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 28 Sep 2021 23:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F1E613B3
	for <linux-hardening@archiver.kernel.org>; Tue, 28 Sep 2021 23:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbhI1XhO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243285AbhI1XhM (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 28 Sep 2021 19:37:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17C22613A9;
        Tue, 28 Sep 2021 23:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632872132;
        bh=WeCWG1TCJpIf4jK2GsNUwk88KXOzL1Xj07O3kKJpT7I=;
        h=Date:From:To:Cc:Subject:From;
        b=QbYEbURpY8R7orgptJhUvILf8+meC95rMyaDpb6VRbh40i6qhhIJ7iebiOklw6+Ba
         +Feh49oI4LHgjjAhApc1qthcSGydHEvPfDLOy6SEGMO09eGAv9CSqj5RXMe4L1zFNC
         Ywk2390MxWdwa3Zvc8ovh+A9VdWn34M9z0fdpqtFvr+fUipP90YJbURj3J/AYDauX5
         nLc0oxdG5+RysxJlGmhn4fgAwqma7O3hjSWsuQakSawzGKPES8/f9rRMcmo7lf2oj8
         vP1l/Baqj7U9Ogc8NEZ6vI5MV0DpB1PKuogIVLQbB2lGVhD8TAmkLSElot43EPSQNy
         5LuwlhYm/BzbQ==
Date:   Tue, 28 Sep 2021 18:39:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Duncan Sands <duncan.sands@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: atm: Use struct_size() helper
Message-ID: <20210928233935.GA299525@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worse scenario, could lead to heap overflows.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/atm/usbatm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 33ae03ac13a6..da17be1ef64e 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -1015,9 +1015,11 @@ int usbatm_usb_probe(struct usb_interface *intf, const struct usb_device_id *id,
 	int error = -ENOMEM;
 	int i, length;
 	unsigned int maxpacket, num_packets;
+	size_t size;
 
 	/* instance init */
-	instance = kzalloc(sizeof(*instance) + sizeof(struct urb *) * (num_rcv_urbs + num_snd_urbs), GFP_KERNEL);
+	size = struct_size(instance, urbs, num_rcv_urbs + num_snd_urbs);
+	instance = kzalloc(size, GFP_KERNEL);
 	if (!instance)
 		return -ENOMEM;
 
-- 
2.27.0

