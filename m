Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E169C433B4
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Apr 2021 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498AD613E1
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Apr 2021 20:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbhDVUt0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Apr 2021 16:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbhDVUtY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Apr 2021 16:49:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362BC06138C
        for <linux-hardening@vger.kernel.org>; Thu, 22 Apr 2021 13:48:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so59850pja.5
        for <linux-hardening@vger.kernel.org>; Thu, 22 Apr 2021 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QnNd3C1c0U8Cy6rEZLpzrN98hcS02ETdlv0eBYCDY9I=;
        b=GeoZA0yJ0n988purgUs0PCMCU17Bu+L8wQlG66Vo/hzcqPi6v5+YgkLNa1GJuwhePr
         y/Clgwwj3/BJ80VEMHSyciTh4mVzur7v+sbdC+05atTrU0ipVDv+XqNBValvPRGRXklL
         YZtB/1PqwHwRZxThMxEFL2y8s8V9z6isoUmsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QnNd3C1c0U8Cy6rEZLpzrN98hcS02ETdlv0eBYCDY9I=;
        b=MgU/RZR2HvWEsHuGjHNnwWV8Db7+FAMaNj1A0of4sochp9gbppHTN0Ch974/gP3Od9
         9CHVAzyHu+tdL+zMyQHU0USKJXYxvN2Z5wa3HIQ+TauoHr/D2YokTASjhp3fHMX5lD+X
         p9QC3PhM9W0/KUKAJnUnrhGQVQtsybOZ0eFmhtR7NusjvCxEdVFfx0Oh/TBH7GqLsT8m
         2TiHb3+jXLibieygXcJokSzB7IC9XvKMZXNdVrYtrpLhChNeEalgRSONACTTYsnMxlT9
         yx24znXOtkfZcb+BuiYPnaq5o/HVFULyhj2Scn629FvurUGH0D13pV7lUG/ftAaOiXrW
         11Jg==
X-Gm-Message-State: AOAM5308C9QswaP4Vg8FgPKA91p7QnV6ni6qppCyzX7QwIMlQPZ4xbur
        l7B0/wBmfeJwBXMaM7VTrTGTug==
X-Google-Smtp-Source: ABdhPJzMvMOnaFySxstgcJPTR3rLDcb88LTqN6KyPWa+y2YnPhestqVSrc7MYSMJhsj+VL0/EcuDzA==
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr631757pjb.114.1619124527729;
        Thu, 22 Apr 2021 13:48:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm5486640pjs.12.2021.04.22.13.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:48:47 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:48:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wireless: wext-spy: Fix out-of-bounds warning
Message-ID: <202104221346.4FE32C5@keescook>
References: <20210422200032.GA168995@embeddedor>
 <120f5db6566b583cc7050f13e947016f3cb82412.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <120f5db6566b583cc7050f13e947016f3cb82412.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 22, 2021 at 10:04:29PM +0200, Johannes Berg wrote:
> On Thu, 2021-04-22 at 15:00 -0500, Gustavo A. R. Silva wrote:
> > 
> > Changes in v2:
> >  - Use direct struct assignments instead of memcpy().
> >  - Fix one more instance of this same issue in function
> >    iw_handler_get_thrspy().
> >  - Update changelog text.
> 
> Thanks.
> 
> >  - Add Kees' RB tag. 
> 
> He probably won't mind in this case, but you did some pretty substantial
> changes to the patch, so I really wouldn't recommend keeping it there.

Thanks for double-checking! Yeah, I'm fine with it; Gustavo and I had
talked in the past about similar solutions in other places, so he
forwarded the intent from those conversations. (Not that you had any
visibility into that!) But, yes, still:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
