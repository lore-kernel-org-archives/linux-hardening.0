Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5DC433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 15 Dec 2021 17:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhLORi5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhLORi4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 15 Dec 2021 12:38:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CBEC061574
        for <linux-hardening@vger.kernel.org>; Wed, 15 Dec 2021 09:38:56 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id k4so20716948pgb.8
        for <linux-hardening@vger.kernel.org>; Wed, 15 Dec 2021 09:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7d470J2+oFZT41mCZ376rK26LqeNBavtRleay07yiuU=;
        b=ShKjENR921vHVi9BK4jRMiwapa1k1KK+vUxc53wDkqYIuBKVCsl4RQNh41pHh9gfN5
         qBefYvjITmGgqIUmdTaO3akklhgd2jqjoY7Sa/qBBt3yNmmox7DCb2eM2/1tgN/DXO6d
         9KqCMg3X2smyr6MIrrwuUnfuQY52i4tM9nxkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7d470J2+oFZT41mCZ376rK26LqeNBavtRleay07yiuU=;
        b=Crh4H2TF/z7guXN33bhazlMexD5mAznK2nmDc0ZyFVUVyUSN1ocITq3Y9CpB6uUtBv
         R8yKLyTD/OJLm5NgMHFFR3m9SUv+U2uI6SFe3aAPD2D3KWIFMczBpqoM5QEMpWjaUOo4
         KZFPbaImZC78cT7MvVaDoSjFhmDubeQEJW9VqGybqa74XSHJji30W/Hvy7h11t2MPrXr
         2dg+76LZ+ASqjFNkNSTin3WRVR6Ta+P+usd3Hx2hFolGUS9nnt/hvA9kWxOBOeSwxqQh
         /LwLjKXT8V3M2gQ9Ua+Jy/9/UtkNZEt+77YwWhEwI/LW2KmUN1sDfysO4v/e9hUEXldk
         ckaw==
X-Gm-Message-State: AOAM5302vV+6tsLWN+vgmTj46GgizZI6/258dU/g6fCy9OQNXOk0KgHP
        Lr6D4MBF1yp+3oItq23GKN+lUw==
X-Google-Smtp-Source: ABdhPJynliM9cHiw8dNrLv4gGNPzE8G4eePKE155CqEwxDkieosnFXcYTf2FunPD85TdO0YqxHJ12Q==
X-Received: by 2002:a63:1f16:: with SMTP id f22mr8437116pgf.259.1639589936105;
        Wed, 15 Dec 2021 09:38:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w37sm2853924pgk.87.2021.12.15.09.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:38:55 -0800 (PST)
Date:   Wed, 15 Dec 2021 09:38:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] media: omap3isp: Use struct_group() for memcpy() region
Message-ID: <202112150937.8E4974D35@keescook>
References: <20211118184352.1284792-1-keescook@chromium.org>
 <20211213232416.GA60133@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213232416.GA60133@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Dec 13, 2021 at 05:24:16PM -0600, Gustavo A. R. Silva wrote:
> On Thu, Nov 18, 2021 at 10:43:52AM -0800, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields. Wrap the target region
> > in struct_group(). This additionally fixes a theoretical misalignment
> > of the copy (since the size of "buf" changes between 64-bit and 32-bit,
> > but this is likely never built for 64-bit).
> > 
> > FWIW, I think this code is totally broken on 64-bit (which appears to
> > not be a "real" build configuration): it would either always fail (with
> > an uninitialized data->buf_size) or would cause corruption in userspace
> > due to the copy_to_user() in the call path against an uninitialized
> > data->buf value:
> > 
> > omap3isp_stat_request_statistics_time32(...)
> >     struct omap3isp_stat_data data64;
> >     ...
> >     omap3isp_stat_request_statistics(stat, &data64);
> > 
> > int omap3isp_stat_request_statistics(struct ispstat *stat,
> >                                      struct omap3isp_stat_data *data)
> >     ...
> >     buf = isp_stat_buf_get(stat, data);
> > 
> > static struct ispstat_buffer *isp_stat_buf_get(struct ispstat *stat,
> >                                                struct omap3isp_stat_data *data)
> > ...
> >     if (buf->buf_size > data->buf_size) {
> >             ...
> >             return ERR_PTR(-EINVAL);
> >     }
> >     ...
> >     rval = copy_to_user(data->buf,
> >                         buf->virt_addr,
> >                         buf->buf_size);
> > 
> > Regardless, additionally initialize data64 to be zero-filled to avoid
> > undefined behavior.
> > 
> > Fixes: 378e3f81cb56 ("media: omap3isp: support 64-bit version of omap3isp_stat_data")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/media/platform/omap3isp/ispstat.c |  5 +++--
> >  include/uapi/linux/omap3isp.h             | 21 +++++++++++++--------
> >  2 files changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/media/platform/omap3isp/ispstat.c b/drivers/media/platform/omap3isp/ispstat.c
> > index 5b9b57f4d9bf..68cf68dbcace 100644
> > --- a/drivers/media/platform/omap3isp/ispstat.c
> > +++ b/drivers/media/platform/omap3isp/ispstat.c
> > @@ -512,7 +512,7 @@ int omap3isp_stat_request_statistics(struct ispstat *stat,
> >  int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
> >  					struct omap3isp_stat_data_time32 *data)
> >  {
> > -	struct omap3isp_stat_data data64;
> > +	struct omap3isp_stat_data data64 = { };
> >  	int ret;
> >  
> >  	ret = omap3isp_stat_request_statistics(stat, &data64);
> > @@ -521,7 +521,8 @@ int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
> >  
> >  	data->ts.tv_sec = data64.ts.tv_sec;
> >  	data->ts.tv_usec = data64.ts.tv_usec;
> > -	memcpy(&data->buf, &data64.buf, sizeof(*data) - sizeof(data->ts));
> > +	data->buf = (uintptr_t)data64.buf;
> 
> Shouldn't this be
> 
> 	data->buf = (uintptr_t)(void *)data64.buf;
> 
> instead?

This is already a void *:

struct omap3isp_stat_data {
	...
        void __user *buf;
};

But I agree, the mix of structures in here is confusing! :)

-Kees

-- 
Kees Cook
