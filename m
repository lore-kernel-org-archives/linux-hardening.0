Return-Path: <SRS0=ee44=DL=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A235C41604
	for <linux-hardening@archiver.kernel.org>; Sun,  4 Oct 2020 00:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D42D206A2
	for <linux-hardening@archiver.kernel.org>; Sun,  4 Oct 2020 00:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgJDAdk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 3 Oct 2020 20:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgJDAdk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 3 Oct 2020 20:33:40 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D8C0613D0;
        Sat,  3 Oct 2020 17:33:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C5A4711E3E4CB;
        Sat,  3 Oct 2020 17:16:51 -0700 (PDT)
Date:   Sat, 03 Oct 2020 17:33:38 -0700 (PDT)
Message-Id: <20201003.173338.2245433774593882221.davem@davemloft.net>
To:     gustavoars@kernel.org
Cc:     rmody@marvell.com, skalluru@marvell.com, kuba@kernel.org,
        GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: bna: Use fallthrough pseudo-keyword
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20201002230001.GA3320@embeddedor>
References: <20201002230001.GA3320@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Sat, 03 Oct 2020 17:16:52 -0700 (PDT)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Fri, 2 Oct 2020 18:00:01 -0500

> Replace /* !!! fall through !!! */ comments with the new pseudo-keyword
> macro fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied.
