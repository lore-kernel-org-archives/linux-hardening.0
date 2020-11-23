Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DB6C2D0E4
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 22:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B263E20708
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 22:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvoQhlt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgKWWqz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387419AbgKWWqz (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Nov 2020 17:46:55 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3679206D8;
        Mon, 23 Nov 2020 22:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606171614;
        bh=/WEVdieGBFCx4qZKD2FUBdtDNT2T0D1Sm+x85x7P1ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvoQhlt+pCN08nREhEj9uDSnMNJLM2KHWqC6HIbPbDHSSayMveWmpf3MKWmHkBbCC
         xQKZcciv7WP6mbXcdAdzFbLc77LfTvq8Btxvwe1kW4uKtMvRLfFFyv2UmfXTi3VcPM
         XK3oegEtQhNcFNpvl+MIeRf2bAuUBA48tWazPxh0=
Date:   Mon, 23 Nov 2020 16:47:08 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-hardening@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 028/141] drm/amd/display: Fix fall-through warnings for
 Clang
Message-ID: <20201123224708.GH21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <9ac81a4aab74e0b3317172e66a985fe6d1ae4e1b.1605896059.git.gustavoars@kernel.org>
 <CADnq5_Ow_b35AuCGO=LncniDDcwSeS9fSpUiJd+vZYfc29TM0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_Ow_b35AuCGO=LncniDDcwSeS9fSpUiJd+vZYfc29TM0g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 05:45:07PM -0500, Alex Deucher wrote:
> On Fri, Nov 20, 2020 at 1:28 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> > warnings by explicitly adding multiple break statements instead of just
> > letting the code fall through to the next case.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied.  Thanks!

Thanks, Alex.
--
Gustavo
