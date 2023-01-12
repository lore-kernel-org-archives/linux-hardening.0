Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65878C63797
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjALVnz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 16:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjALVnd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 16:43:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0416635927
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 13:36:09 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso25050617pjt.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 13:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YYu+aCdiKwj9iNU36bpnOoIdRebqjw4OvN+SDw/4uEo=;
        b=VPEXk5zKBAwAuw1kxsoTOFlemc5Gi1jRC/6WdMvgtZH5YqUQ6aPCduJ+KKy2DCaXIu
         1i/Nk0ggOrXJ0kPeSNycF/gQqdPVK03YGxcfT4mUJ/5+x3NfLDhlCHqKX95QWew7PopY
         WCJNm5xDWOVAiT7UX/1W/in0AXoM4VCrTJR0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYu+aCdiKwj9iNU36bpnOoIdRebqjw4OvN+SDw/4uEo=;
        b=MZ47kCF41ZGqqUdYJNxpMXkADRt+cR7JDL0QvyOaot+MVODwri5Sftp9CZk3D/xsNW
         qiCpHfSmAr/T39WjL6QLvlZbGJZ2MMEBErjWjPxWBAtNcBo5OGWoMbTbT9yCS7jkkc/h
         6PK1+CjlYMPgJnE/ZIsFy350q5ODozgdM0bQKYUQlvZyyG0NDSnIssT2mfd4LWZxVO+l
         roMS1ewOQWdUzVjAqKDRJXkOUd/ezjs/Gf4cZay+hTsaAJZLo65i7AlRjJo6Svg28u62
         eejs8pNGLC+wgWcW59dQgderLUB0obqD0t9aa2Sg8+3A3Utvj8XBWo7a6Xn+sxLRUYo0
         4dMw==
X-Gm-Message-State: AFqh2kpIZSrjpVr/qpQWCQ4nnE8jnL8L9jhRYg/QkzIYUp0bpJ3WtuW9
        HDHup/Hqnvfac+YQ0YJO9DcLt/+pau4+i9Uq
X-Google-Smtp-Source: AMrXdXsRAsEdog7NaavOYefh0QcHHB2Wm9pducYrAdYL9mGRt+weUVR1SQoPleZylrdYO3Jz5ySy/w==
X-Received: by 2002:a17:902:a3c1:b0:193:2a8c:28cb with SMTP id q1-20020a170902a3c100b001932a8c28cbmr15649658plb.21.1673559368478;
        Thu, 12 Jan 2023 13:36:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00178143a728esm12605918plm.275.2023.01.12.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:36:07 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:36:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     linux-hardening@vger.kernel.org
Subject: Re: Kernel Self-Protection Project meeting
Message-ID: <202301121333.D4395FE3@keescook>
References: <202301110820.C6020B71EA@keescook>
 <202301110826.20083483E@keescook>
 <5af2c54b767e2d314041dc77378c492ed44eaacf.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5af2c54b767e2d314041dc77378c492ed44eaacf.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 12, 2023 at 04:44:26PM +1100, Andrew Donnellan wrote:
> Hi Kees,
> 
> On Wed, 2023-01-11 at 08:27 -0800, Kees Cook wrote:
> > On Wed, Jan 11, 2023 at 08:23:39AM -0800, Kees Cook wrote:
> > > Hi!
> > > 
> > > This is rather short notice; I'll send out a reminder further in
> > > advance
> > > next time, but if anyone would like to join our every-2-weeks
> > > project
> > > video conference, please drop in:
> > > 
> > >         https://meet.google.com/cuu-hqcm-ggg
> 
> This is a great idea!
> 
> Were there any notes taken from today's call?

Yes, I kept some limited notes, but tried to include URLs for stuff that
got talked about. I'm building a place to keep them that is more
change-control friendly besides a google doc. :) I'll finish getting
that built and get it published soon.

> > *cough* at 10am US Pacific today...
> 
> Is it anticipated that the meetings will consistently be at 10am
> PST/PDT or will that move around a bit?

That's the current plan for now (but see below), every 2 weeks at 10am
US Pacific. If there's a good reason to move it around, we can certainly
do that.

> (I realise I'm a very quiet lurker on this list, but I am interested in
> occasionally dropping in when I can; 10am PST is a bit tricky here in
> +1100 territory but I'll still try.)

Yeah, once we've gotten the hang of it, I'd like to maybe shift it
around so it's more AU friendly with some regularlity.

-- 
Kees Cook
