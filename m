Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D352DC63798
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 22:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883B620719
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 22:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdF531+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbgKWWqT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:46:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733246AbgKWWqT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Nov 2020 17:46:19 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF823206D8;
        Mon, 23 Nov 2020 22:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606171578;
        bh=0IxEFALcSEvAO3DV8f+4lhm8YdgaX4ufyOmm2mRkIBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdF531+BykJyb81LmkSQ/NEVl78Y7/GemKCBovEz9wCtNOBFpPynXwSQCJXFEb5mR
         Hor45Hm8bekQS+1XYixbllvuQwCwGTlfyCl22fcPEneTVy3Lno4lMZaTuhF4BkwhLT
         DrVCVkeuxNaRNDoh2w6bQQ48K9t3UVDvifJbMKkE=
Date:   Mon, 23 Nov 2020 16:46:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Igor Russkikh <irusskikh@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        GR-everest-linux-l2 <GR-everest-linux-l2@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [EXT] [PATCH 018/141] qed: Fix fall-through warnings for Clang
Message-ID: <20201123224632.GG21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <35915deb94f9ad166f8984259050cfadd80b2567.1605896059.git.gustavoars@kernel.org>
 <9bcfa09c-dd8d-f879-4762-1b88779fa397@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bcfa09c-dd8d-f879-4762-1b88779fa397@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 09:50:06PM +0300, Igor Russkikh wrote:
> 
> 
> On 20/11/2020 9:26 pm, Gustavo A. R. Silva wrote:
> > External Email
> > 
> > ----------------------------------------------------------------------
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> > warnings by explicitly adding a couple of break statements instead of
> > just letting the code fall through to the next case.
> > 
> > Link:
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_KSPP_linux
> > _issues_115&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=GtqbaEwqFLiM6BiwNMdKmpXb5o
> > up1VLiSIroUNQwbYA&m=6E7IvGvqcEGj8wEOVoN1BySZhGUVECVTBJCmNiRsHUw&s=J1SWrfEL
> > erJOzUlJdD_S5afGaZosmVP8lyKsu9DTULw&e= 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Igor Russkikh <irusskikh@marvell.com>

Thanks, Igor.
--
Gustavo
