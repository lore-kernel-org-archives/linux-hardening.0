Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7A3C6379D
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 22:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B462071E
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 22:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwumpbTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbgKWW5f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:57:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387435AbgKWW5e (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Nov 2020 17:57:34 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75452206D8;
        Mon, 23 Nov 2020 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606172253;
        bh=85UQxxhOYcaC1aVFet5PQGMG0Q+y+uLnQYPGD/LRlgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwumpbTU+MvLcm7gOtTh6zIqqnhtuT7umn02WKYTFeQAD95f42UeUi+Wg6SuBNdxt
         JEGN20yqbSo6s56p/u9FB3UyEHD+3jM10DqVIwzwNbg82lmdWkVU8U8adudo7xYPTz
         TWlFgunDW9mvfeKbpexXuRy4J5SockPfDraDYjgE=
Date:   Mon, 23 Nov 2020 16:57:47 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 079/141] drm: Fix fall-through warnings for Clang
Message-ID: <20201123225747.GU21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <111e9d3d55c686892357aa5269022024b4d48330.1605896059.git.gustavoars@kernel.org>
 <20201122220322.GA566387@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122220322.GA566387@ravnborg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Nov 22, 2020 at 11:03:22PM +0100, Sam Ravnborg wrote:
> Hi Gustavo,
> On Fri, Nov 20, 2020 at 12:35:17PM -0600, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> thanks, applied to drm-misc-next.

Thanks, Sam.
--
Gustavo
