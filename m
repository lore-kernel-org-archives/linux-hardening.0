Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3379C433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  7 Oct 2021 03:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76636109F
	for <linux-hardening@archiver.kernel.org>; Thu,  7 Oct 2021 03:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbhJGDCV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 23:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbhJGDCU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 23:02:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0F4C061753
        for <linux-hardening@vger.kernel.org>; Wed,  6 Oct 2021 20:00:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r201so4288216pgr.4
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KX2Q0lHoAsJVnsh9KJXVIuZ0VMI5Go27/7nTsHPMfLk=;
        b=PqVR4dmagl9jS7IZoU87ODLrxRwcBfy3hwmMRWed24WQoFRfgcobTTWQCY09t9MpHL
         62p5aEVbRUfx++7u3ga9q7iXInm6NGS0OrPsrcb5tTBNrWQ5TWXZTWqk6RN2gzrp+64Z
         hN3uUBwcJHa+gIqJMkXUYChFgf3+1Pdcm9wx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KX2Q0lHoAsJVnsh9KJXVIuZ0VMI5Go27/7nTsHPMfLk=;
        b=dUBOXCrmzFJWCsq9qSleh7hEQvVw7m7lrLOw37SBOSlfAT17ulRZViO+nhG057Ol2b
         +cbMfja69Mg5j/lUvXzRgW75jPIQmFyaCWGqIUfde40YbpKqPbmC4YdoHJQA8MgDiZ1Q
         cs4sgcWuL7//9ojVDVQ3a0i1xcQLjD0HW3nXp/lsaAydQVqNrKHNHxTKXfesxMYWNvgo
         9WnYBSnHQialhZbB9WLLTicZ7myMpDvcqURFS6b36chJyw9LII/0l5p9gdbjSzycP8R4
         N7loqgr3JFiLZ6Ei+C91FK5zNbYi3vMrlVVoPEPuCE7XnexDo/35ccAz85sFFct5hnXL
         P6RA==
X-Gm-Message-State: AOAM533TExMigkmAMEjR6r1eYDi2w+clDGi/Yz8TcqepqWnQ6YNVVXE3
        KpZhxNJWS9w/8pSOP/U816RYrA==
X-Google-Smtp-Source: ABdhPJxPeUWLXsYsjmo6rWjk+k8tKHN85TV0XaFpxFOYtUEQkyDsdAppe5A42Ek+E640+/jowUf4uQ==
X-Received: by 2002:a62:3802:0:b0:44c:776b:f555 with SMTP id f2-20020a623802000000b0044c776bf555mr1858667pfa.82.1633575627544;
        Wed, 06 Oct 2021 20:00:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m1sm22766182pfc.183.2021.10.06.20.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:00:27 -0700 (PDT)
Date:   Wed, 6 Oct 2021 20:00:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add "exec & binfmt" section with myself and
 Eric
Message-ID: <202110061959.04748F6C@keescook>
References: <20211006180200.1178142-1-keescook@chromium.org>
 <20211006180033.e31809540ed053192b423419@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006180033.e31809540ed053192b423419@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 06, 2021 at 06:00:33PM -0700, Andrew Morton wrote:
> On Wed,  6 Oct 2021 11:02:00 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > I'd like more continuity of review for the exec and binfmt (and ELF)
> > stuff. Eric and I have been the most active lately, so list us as
> > reviewers.
> 
> Could add myself sometime as well, I guess.  For some reason I am
> suspiciously absent from MAINTAINERS.
> 
> 	switch (subsystem) {
> 		...
> 	default:
> 		akpm;
> 	}

Heh, well, I always assumed you didn't want to be explicitly listed
there. :)

-- 
Kees Cook
