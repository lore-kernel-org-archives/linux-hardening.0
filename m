Return-Path: <SRS0=lGhV=DQ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237A4C433DF
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Oct 2020 14:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE01E222B9
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Oct 2020 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602254063;
	bh=NI5DLF6uPJ5jya9JuzI9Ra3gtpgV9aB2BH0rzTb6zPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MCK+dqc43MRLQIieElz9W035TLZYb7KRKMGA0zWDyP5bpZKZLR1csrQlxTuhmgonW
	 WCOMS1ypB91SoGHrZbAdb1BuylNWDlMTy6OFxZLDg90CFTfQ0VEGFrnKfM1229AkD5
	 dSdB1HmbBbYJ5t5LoIETUMpLE4DNdCEMoeu1IbTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbgJIOeX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 9 Oct 2020 10:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbgJIOeX (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 9 Oct 2020 10:34:23 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 262C02226B;
        Fri,  9 Oct 2020 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602254063;
        bh=NI5DLF6uPJ5jya9JuzI9Ra3gtpgV9aB2BH0rzTb6zPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJrRD065RVWZjHBQeufYQpcmp+VhiPjAiFyotfN37ETJ9AvJBbpjGfFgucwPeHHbD
         Pz1H92kmLDZnIkdkG0Hhg7YMQnRWRzye+bxbKlsBaJ3Ob5KT7cMRQeK9WmBYZ9L+Ca
         /OX1TyVGfVNQm9EwZ56xQvA/nf/yG65ezRlm+bT8=
Date:   Fri, 9 Oct 2020 09:39:47 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] amd/amdgpu_ctx: Use struct_size() helper and
 kmalloc()
Message-ID: <20201009143947.GA32493@embeddedor>
References: <20201008143450.GA23077@embeddedor>
 <4fe00048-2612-39f3-29bb-c9424000f836@amd.com>
 <20201009135430.GA31347@embeddedor>
 <de2282e7-7eb9-db79-1082-36d6508b05dd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de2282e7-7eb9-db79-1082-36d6508b05dd@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 09, 2020 at 04:29:55PM +0200, Christian König wrote:
> > > > -	entity = kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_jobs]),
> > > > +	entity = kmalloc(struct_size(entity, fences, amdgpu_sched_jobs),
> > > NAK. You could use kzalloc() here, but kmalloc won't zero initialize the
> > > memory which could result in unforeseen consequences.
> > Oh I see.. I certainly didn't take that into account.
> > 
> > I'll fix that up and respin.
> 
> Shit happens, we already have a fix for this. Alex merged it and it
> immediately broke our testing systems.

:/

> So one of our engineers came up with a fix which should already have been
> applied.

Great. Good to know it's already fixed! :)

Thanks
--
Gustavo
