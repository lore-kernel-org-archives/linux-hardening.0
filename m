Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF5FA373E
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Oct 2022 18:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiJYSp0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiJYSpY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A262246621
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 11:45:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c2so3533611plz.11
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WObk38kxfIgKog/1ATH5tNC2vqGgDqmgZkfpyrUBpvo=;
        b=m9yCo+8jkneDwjFlot+Xk/u0xGzmnnsfZf1GpYolkK87bbpgbAEyrbXpyDLCst0WPm
         b1OYCHFB+8FpYQVswWSzEYtMCfpQ16lQThMSw0C5Hj5dbneLyRHAyPBLRCkbKRp7Rz0l
         sGfkcdRdiJBHq77QfGhgdtn2xylT+yApJUUO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WObk38kxfIgKog/1ATH5tNC2vqGgDqmgZkfpyrUBpvo=;
        b=RRcgF8+Nd98/fLxBT10txPzSAp+gWs59Ems3cE0RmhdjpDXzEDzbj5FyWm0qSVA9V6
         V23QorBzqFoQhKXtG6Kuf1JXipArRsQIWZi7qs5XITewyD1O0cZU/DCOqXe/tsXUA4Pw
         cZHOOcSqXND0IZ5h5rqJvjqoEceamAZ2UQuv7lfmx6zMjp7vMHeXL4c45H9QawZ2Otwp
         tGzwl7Kp1nQz0gfYwvMNm1WVFmOpx+TnmJDMrzWhD+7Q5u+Zyp+3rjNBnC4XxV6ifnte
         /xemRrDO7pkt0u4yWFz4GiY7ECffV7bZqQ/8VcQvw4cXA1pJ7Rhd1TiSU+HU1wBfWPG6
         DCqw==
X-Gm-Message-State: ACrzQf1tPVBIHYxIsJR8w5085RDnWPtRAqihMY4qY3esuqFc7f9TPMB2
        zKUiNfS75X+C1BzCZq+V5ZOqQ6KS/C09dw==
X-Google-Smtp-Source: AMsMyM6DMJkitWYIoNk4oHP/sEeK9XwJw0zo481hWbMmjr2/4pZeJ/NflzgfNm8hyfyRJw0QQvtxvQ==
X-Received: by 2002:a17:90a:bd01:b0:205:fa9c:1cfc with SMTP id y1-20020a17090abd0100b00205fa9c1cfcmr82823880pjr.116.1666723521191;
        Tue, 25 Oct 2022 11:45:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r10-20020a63d90a000000b00458a0649474sm1570255pgg.11.2022.10.25.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:45:20 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:45:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH] xfs: fix FORTIFY_SOURCE complaints about log item
 memcpy
Message-ID: <202210251140.A25428CB6@keescook>
References: <Y1CQe9FWctRg3OZI@magnolia>
 <202210240937.A1404E5@keescook>
 <20221024223235.GA3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024223235.GA3600936@dread.disaster.area>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 25, 2022 at 09:32:35AM +1100, Dave Chinner wrote:
> On Mon, Oct 24, 2022 at 09:59:08AM -0700, Kees Cook wrote:
> > On Wed, Oct 19, 2022 at 05:04:11PM -0700, Darrick J. Wong wrote:
> > > [...]
> > > -/*
> > > - * Copy an BUI format buffer from the given buf, and into the destination
> > > - * BUI format structure.  The BUI/BUD items were designed not to need any
> > > - * special alignment handling.
> > > - */
> > > -static int
> > > -xfs_bui_copy_format(
> > > -	struct xfs_log_iovec		*buf,
> > > -	struct xfs_bui_log_format	*dst_bui_fmt)
> > > -{
> > > -	struct xfs_bui_log_format	*src_bui_fmt;
> > > -	uint				len;
> > > -
> > > -	src_bui_fmt = buf->i_addr;
> > > -	len = xfs_bui_log_format_sizeof(src_bui_fmt->bui_nextents);
> > > -
> > > -	if (buf->i_len == len) {
> > > -		memcpy(dst_bui_fmt, src_bui_fmt, len);
> > > -		return 0;
> > > -	}
> > > -	XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, NULL);
> > > -	return -EFSCORRUPTED;
> > > -}
> > 
> > This is the place where flex_cpy() could be used:
> > 
> > 	flex_cpy(dst_bui_fmt, src_bui_fmt);
> 
> How does flex_cpy() know how much memory was allocated for
> dst_bui_fmt? Doesn't knowing this imply that we have to set the
> count field in dst_bui_fmt appropriately before flex_cpy() is
> called?

Right -- this is why I had originally sent my API proposal with the *_dup
helpers included as well. The much more common case is allocate/copy
and allocate/deserialize. The case of doing flex-to-flex is odd, because
it implies there was an external allocation step, etc. But, that said,
allocation and bounds recording are usually pretty well tied together.

> Hence I don't see that this flex array copying stuff will make it
> harder to make mistakes, but ISTM that it'll make them harder to spot
> during review and audit...

I think the transition to a fallible routine is an improvement, but
yes, I expect flex_cpy() not to be used much compared to flex_dup(),
or mem_to_flex_dup(), both of which collapse a great many steps and
sanity checks into a single common, internally-consistent, and fallible
operation.

-- 
Kees Cook
