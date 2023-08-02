Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BE1C04A6A
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Aug 2023 05:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjHBFEd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Aug 2023 01:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjHBFEb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Aug 2023 01:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BA5268E;
        Tue,  1 Aug 2023 22:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49D43617E2;
        Wed,  2 Aug 2023 05:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F79BC433C7;
        Wed,  2 Aug 2023 05:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690952667;
        bh=roMvJpb+EzYKwtQeG0++SvhEzIg74QW7AkwQyMIYc/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIR3DAN3rPp40JJ80ZHvkLqrCjGI4pSRFKCrEkL1vHVjBNGUvz3xOLHhxuwLauIXl
         2w3Hi13EWZBk9l75KXdGL6arb1bAYS7vRLZvWif0lYIFruJuRKXWZW1imPdW/bQRQE
         HLH311XABoSVxhP3HRVme9J+NCojqdyrqGM5/2dsSPZfZnaWPpJolWQNNsN40YA50T
         XTSgR+6axNJjZpTIE5xji6Pg1woOTWvU6UFD3M3+enuWUkQuYpfc8bcbEbeTfiNRQv
         CtdfFKEfbdRGpccfrBCQ5avkgYsXGxT+36SJkAGGGt+V2rYcBvzr4fvAYxpjs4NhEf
         +M3pG5cOlt9EQ==
Date:   Tue, 1 Aug 2023 23:05:31 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/4][next] i40e: Replace one-element array with flex-array
 member in struct i40e_package_header
Message-ID: <768db2c3764a490118f6850d24f6e49998494b6c.1690938732.git.gustavoars@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct i40e_package_header with flexible-array
member.

The `+ sizeof(u32)` adjustments ensure that there are no differences
in binary output.

Link: https://github.com/KSPP/linux/issues/335
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ddp.c  | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 7e8183762fd9..0db6f5e3cfcc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -220,7 +220,7 @@ static bool i40e_ddp_is_pkg_hdr_valid(struct net_device *netdev,
 		netdev_err(netdev, "Invalid DDP profile - size is bigger than 4G");
 		return false;
 	}
-	if (size < (sizeof(struct i40e_package_header) +
+	if (size < (sizeof(struct i40e_package_header) + sizeof(u32) +
 		sizeof(struct i40e_metadata_segment) + sizeof(u32) * 2)) {
 		netdev_err(netdev, "Invalid DDP profile - size is too small.");
 		return false;
@@ -281,7 +281,7 @@ int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
 	if (!i40e_ddp_is_pkg_hdr_valid(netdev, pkg_hdr, size))
 		return -EINVAL;
 
-	if (size < (sizeof(struct i40e_package_header) +
+	if (size < (sizeof(struct i40e_package_header) + sizeof(u32) +
 		    sizeof(struct i40e_metadata_segment) + sizeof(u32) * 2)) {
 		netdev_err(netdev, "Invalid DDP recipe size.");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 388c3d36d96a..c3d5fe12059a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1456,7 +1456,7 @@ struct i40e_ddp_version {
 struct i40e_package_header {
 	struct i40e_ddp_version version;
 	u32 segment_count;
-	u32 segment_offset[1];
+	u32 segment_offset[];
 };
 
 /* Generic segment header */
-- 
2.34.1

