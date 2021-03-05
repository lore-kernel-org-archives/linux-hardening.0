Return-Path: <SRS0=3XZ1=ID=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687A6C433E0
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 20:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3582865079
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 20:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCEUsu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 15:48:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33242 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhCEUsT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 15:48:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 89A384D0ECE13;
        Fri,  5 Mar 2021 12:48:16 -0800 (PST)
Date:   Fri, 05 Mar 2021 12:48:12 -0800 (PST)
Message-Id: <20210305.124812.611998680216818380.davem@davemloft.net>
To:     gustavoars@kernel.org
Cc:     vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, kuba@kernel.org,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: mscc: ocelot: Fix fall-through warnings for
 Clang
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210305073403.GA122237@embeddedor>
References: <20210305073403.GA122237@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 05 Mar 2021 12:48:16 -0800 (PST)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


Please resubmit these again when net-next opens back up, thank you.

