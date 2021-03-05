Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA44C433E0
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 07:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098A865011
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 07:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhCEHm1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEHm1 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 02:42:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 506DC64F44;
        Fri,  5 Mar 2021 07:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614930147;
        bh=uTFqnv6qmEoQwDoOMs90+0OH/pwEDX4h2tr5/bq6uGo=;
        h=Date:From:To:Cc:Subject:From;
        b=SWFzHV5i5pQ/GvRpen6FZgdRQhi5jcuZssly8nU0K+h9elbOz0NjOhC7j7+g3QWAS
         ZBUqUvaOZ6cq791A7TtWGqKkoOxCjhE3pMcicYe/VpNouxljqJxT/ifw4ifYocfy5V
         0cgnB35f3OJxeGICkHuKzKNxrHSsmRILo2/gJKi0zm7GSrOx0MA38ThmWs4hoEeHW6
         P9+hh8aX7t7X1tFRE5qS0luM0Q27HlC0JZWyF1FhcEEN5Q8pHCf1apzGO2gXQcM6vS
         Mtw6mz0gXamM1n8hzYWiKYBT1REs5dmBoJjtcwWvqtAgMldvQ3hvGtpTwzJgfmcqQH
         6Yy29atjh7j7A==
Date:   Fri, 5 Mar 2021 01:42:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] firewire: core: Fix fall-through warnings for Clang
Message-ID: <20210305074223.GA123031@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a fallthrough pseudo-keyword.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/firewire/core-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index ec68ed27b0a5..b63d55f5ebd3 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -58,6 +58,7 @@ static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
 		case SELFID_PORT_PARENT:
 		case SELFID_PORT_NCONN:
 			(*total_port_count)++;
+			fallthrough;
 		case SELFID_PORT_NONE:
 			break;
 		}
-- 
2.27.0

