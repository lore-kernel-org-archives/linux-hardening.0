Return-Path: <SRS0=3XZ1=ID=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A07EC433E0
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 19:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36A36502A
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 19:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhCET0q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCET0U (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 14:26:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AACEB64EE1;
        Fri,  5 Mar 2021 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614972380;
        bh=kzXYKMiq9Kkvuj6hwxwweKjjTNV2kJilH9HJ4zHWnII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhjy/umtZMGPHhww/Toccm83mrAVBcsEC6FjiUGG8RyIGnrlIpxIG2lDDjtPap7T2
         xHray4YZm9AXCC9ISMPa7+arUPGPB52+IZyMYQAj/k2bg3iU6m3BmFfRCT5OuuF725
         EWTA6MdhMWh/e+OZBIUaeUOcq9zvINyKyOugSMkslEnqr8wwd1L9ttRkuaUCeg2Ywp
         6o844vPD9q7Ow8b6cIWVtUbg2z0sw9ppKigy9BZMwPYPcv/r6hMlSwcN6eFn+qlWX+
         7ooRMGVipKLvZ4/A7mVIqIXkV/L5+r7YIdyhlH1Vw7CorhDfX9e8q32LE6kjXrvFt2
         KAqToyS7hzrIw==
Date:   Fri, 5 Mar 2021 13:26:17 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-hardening@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] drm/radeon/si_dpm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE
Message-ID: <20210305192617.GA152661@embeddedor>
References: <20210303190458.GA16321@embeddedor>
 <CADnq5_M3dSMnKQMRv3SVaK6-w5ebJxX6w2-oy8v7+2muw3S3vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_M3dSMnKQMRv3SVaK6-w5ebJxX6w2-oy8v7+2muw3S3vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 05, 2021 at 02:10:44PM -0500, Alex Deucher wrote:
> Applied.  Thanks!

Awesome. :)

Thanks, Alex.
--
Gustavo
