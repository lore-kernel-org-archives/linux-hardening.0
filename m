Return-Path: <SRS0=3XZ1=ID=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8EBC433DB
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 22:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943146509B
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 22:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCEWiL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 17:38:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhCEWhy (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 17:37:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFCA06509B;
        Fri,  5 Mar 2021 22:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614983874;
        bh=aF1Sv5Mz/HlsBB4kICXupI1pEOIhseODh5af/BC4Xks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyqgMgjcHLZE/9d/eXPWAUeshdSQPCCnaRxCz+5X4PmASXmBnHMWi26gyDbtOC9Qs
         ygXooPDhWesEJCk4mh7bsCWu1mPEkfY1ZJpSYayX0SsfLmF24HnErtT2qtqACh66cf
         AGAI9JdPtWeRGSRSDWwV3gOekmjLcBIUd/7g+nvirxLjQS3QSVeRxwXLk5ezJuk6bH
         uHFPYQNQhboZ+9o7WSEqBK9lviZDgfwvEjgEv5Qq2wDBE5HnoBlhYPnETHGA7RZyuV
         fjv2EBg+mrW33Z8wQI9ea6JfBesFJz3agX4vPw3rewj9rhcp86Pfqc4ZVlIETnomWA
         SypHw5snEbBhw==
Date:   Fri, 5 Mar 2021 16:37:52 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, kuba@kernel.org,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: mscc: ocelot: Fix fall-through warnings for
 Clang
Message-ID: <20210305223752.GA156581@embeddedor>
References: <20210305073403.GA122237@embeddedor>
 <20210305.124812.611998680216818380.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305.124812.611998680216818380.davem@davemloft.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 05, 2021 at 12:48:12PM -0800, David Miller wrote:
> 
> Please resubmit these again when net-next opens back up, thank you.

Sure thing.

Thanks
--
Gustavo
