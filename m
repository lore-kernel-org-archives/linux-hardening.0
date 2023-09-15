Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948F2EEEC03
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjIOTAu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbjIOTAo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:00:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930BA270A;
        Fri, 15 Sep 2023 12:00:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF916C4339A;
        Fri, 15 Sep 2023 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694804429;
        bh=MwYH2ME9s5GR5J22JIc9pHMsg8/BLoZqEWB3h/MNKug=;
        h=Date:From:To:Cc:Subject:From;
        b=dc8ehB5SmqvG+DNp8dNDSxMhG6TsX6M2Tx1knthy1ka7AXh1nnnTV+JKs/Ham9X1W
         3md8hC7WO1cITCN5OrswcKVsh5Fy1W7DIf5Ax8oN5FfaBJ5yZWyR3k9tEURxkhX9ZF
         qNGNd+NHhuu+6+i4FytLLtQYvu8N7xtCcLFQFfIWMbuR28NGsHHVMMqeU7Z5M+OjOw
         7HgYmICKCdR35+1RWyxVxRCMOFdSPFz+StmTuRGIBMd2E0SKfLvdGwAL+AtAPECYAo
         kTi27M/ImM9c0gDUg/Q8A+JdhRNsC1gbUNUaw0o3YyuJkPjVDCUotXiTehzBM32kWj
         FeCGvVBwtoKhg==
Date:   Fri, 15 Sep 2023 13:01:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] mlxsw: Use size_mul() in call to struct_size()
Message-ID: <ZQSqA80YyLQsnd1L@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

If, for any reason, the open-coded arithmetic causes a wraparound, the
protection that `struct_size()` adds against potential integer overflows
is defeated. Fix this by hardening call to `struct_size()` with `size_mul()`.

Fixes: 2285ec872d9d ("mlxsw: spectrum_acl_bloom_filter: use struct_size() in kzalloc()")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index e2aced7ab454..95f63fcf4ba1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -496,7 +496,7 @@ mlxsw_sp_acl_bf_init(struct mlxsw_sp *mlxsw_sp, unsigned int num_erp_banks)
 	 * is 2^ACL_MAX_BF_LOG
 	 */
 	bf_bank_size = 1 << MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_BF_LOG);
-	bf = kzalloc(struct_size(bf, refcnt, bf_bank_size * num_erp_banks),
+	bf = kzalloc(struct_size(bf, refcnt, size_mul(bf_bank_size, num_erp_banks)),
 		     GFP_KERNEL);
 	if (!bf)
 		return ERR_PTR(-ENOMEM);
-- 
2.34.1

