Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE2C4338F
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Jul 2021 12:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848D561050
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Jul 2021 12:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhG3MEf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Jul 2021 08:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238878AbhG3MEc (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Jul 2021 08:04:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BB7F61050;
        Fri, 30 Jul 2021 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627646668;
        bh=I+xXFURVvAptYJKMr5PgQPz3hcAQV3Y/2tYQl3FYyKQ=;
        h=Date:From:To:Cc:Subject:From;
        b=JHfwB6FwLpGQ9drtWZThGhtUg4RQ51WAwy+ZhCt3CGNpnKVgbnxpU9ZqQZX/olY4w
         hCDIqH1lQW+FgN+mlwEczWMIFMI/0M9Wg/TWwTnEdsXowaUsid+pVlv5eUOGE87E+m
         QeQC41QVj9NfXLgVaqQ9dy5YgiQs2lFTiRaqoJA2hLnElWan+6k4MUI8cg/jekpXXa
         Lkr4Tqljzmv17u1RHoKEqoM2MJ431kUG+il+kQ/Bmm4FPFdZ9W/8yfniV80oGqlqiZ
         bhw/5outBA439yrBPj8WwDa3GhByz5miL8PKgoGd/RJJDbZim5SfNufUnh8iatfZSS
         mYyUH2HBLLz8g==
Date:   Fri, 30 Jul 2021 07:07:00 -0500
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
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 0/2] Fix size comparison bug and use flexible array
Message-ID: <cover.1627646101.git.gustavoars@kernel.org>
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

Changes in v2:
 - Use flexible array and adjust relational operator in patch 1.

Gustavo A. R. Silva (2):
  media: staging/intel-ipu3: css: Fix wrong size comparison
  media: staging/intel-ipu3: css: Use the struct_size() helper

 drivers/staging/media/ipu3/ipu3-css-fw.c | 7 +++----
 drivers/staging/media/ipu3/ipu3-css-fw.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.27.0

