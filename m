Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBD5C47095
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB551215A4
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602086248;
	bh=G0lgH6he/DahzFqP5FRpqz/WY6rYK4qxxqp6/q4ygxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hc0x01C6rCHxUUuXzXqBENbSjadD9D9tTcDg6W0oTnWgefzhudOasnpmyMjBXa7xi
	 zY1GwzSlr5LFRpto6Xd+nhs/qgZwAACG87f5UA6BlzV4evp8dHlG5dBZmE/eWytWno
	 eOoA1rYPDwfpUmV7ACxCCJboT2ZkYO121TWi0WN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgJGP51 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJGP51 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 11:57:27 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02FE520789;
        Wed,  7 Oct 2020 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602086247;
        bh=G0lgH6he/DahzFqP5FRpqz/WY6rYK4qxxqp6/q4ygxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLK1rIEQ31Dxq3kj3L07dUw6bF7o4F6aLSLq8v7grzY4RqA2P9ZAZZaGETC41vSRC
         /IUbAntDwdlho+44fbct2gXqcEyfaPFy+g8H5qjYqB5eUp+JxZKyjIvJ1dLPiLPkDP
         aL1TkMNAYUDAmqTujHdh9EGn/mt87necPjCVlJRY=
Date:   Wed, 7 Oct 2020 11:03:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 02/14] drm/amd/pm: Replace one-element array with
 flexible-array member in struct vi_dpm_table
Message-ID: <d8308a38b7ea35db027f7e2099360d06baa85bbb.1602020074.git.gustavoars@kernel.org>
References: <cover.1602020074.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1602020074.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Use a flexible-array member in struct vi_dpm_table instead of a
one-element array.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f7c433c.TTk9rnA+F58kyDUy%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/inc/hwmgr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index a1dbfd5636e6..d68b547743e6 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -60,7 +60,7 @@ struct vi_dpm_level {
 
 struct vi_dpm_table {
 	uint32_t count;
-	struct vi_dpm_level dpm_level[1];
+	struct vi_dpm_level dpm_level[];
 };
 
 #define PCIE_PERF_REQ_REMOVE_REGISTRY   0
-- 
2.27.0

