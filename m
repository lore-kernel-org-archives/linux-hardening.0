Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F177C4338F
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Jul 2021 23:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E6160F46
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Jul 2021 23:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhG2XRC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Jul 2021 19:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhG2XRC (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Jul 2021 19:17:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E48160C40;
        Thu, 29 Jul 2021 23:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627600618;
        bh=AeJb8ws1+grV1uclZOuKoENMD/aorVJeTxf9oyZxFKI=;
        h=Date:From:To:Cc:Subject:From;
        b=MJqXKhFKb3k+knDvn6pMgb1ZZ+8VMtnVmAE37b9xYGv0JWmOyU+03dcLtjdMp86Qk
         jqjgUF3ysvJg00VmQfk0HACBYrLduuh5gEOeTTiC2crYFimYkpENTD5k7o/MWkwKtW
         pqhirs1uq9uVpeeCUvnUWYbrCWNOQVxWGGd1FtWa3nLGsrm8M552kzrtKZObhraIsO
         RNzQTJIs97LfHYuWHSYUm62SW+Y0NI9Tt5AZqktqKzVHctquzFzwMfyMMML4NM9F4q
         hJ1lAt3RRj9bP+H1XuBorNybiuYySgpj49KoMMt23UreKj4XuP0REp1aBy+OyUkp1q
         SET81GeLZ8p8g==
Date:   Thu, 29 Jul 2021 18:19:30 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/2][next] Fix size comparison bug and use flexible array
Message-ID: <cover.1627600430.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi all,

This small series aims to fix a size comparison bug and replace a
one-element array with a flexible-array member.

Thanks

Gustavo A. R. Silva (2):
  media: staging/intel-ipu3: css: Fix wrong size comparison
  media: staging/intel-ipu3: css: Replace one-element array and use
    struct_size() helper

 drivers/staging/media/ipu3/ipu3-css-fw.c | 7 +++----
 drivers/staging/media/ipu3/ipu3-css-fw.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.27.0

