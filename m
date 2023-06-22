Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF29EB64DB
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 05:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjFVFPt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Jun 2023 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjFVFPt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Jun 2023 01:15:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C37DE9
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 22:15:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6687096c6ddso2734559b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 22:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687410947; x=1690002947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9soCak5raKcjZvJvMtE+uNsH2FPMIxS+OErwqzv9v8=;
        b=Hc6c/JC6Js4sO/XgQOqhO+zupd9oBK1lS7N42qvtzAoPwy5z2C6gqP6sV0sgsLOole
         KUQ0YwS58O6QJE7p5+R69qSEgsSh0eTXij5BFmO963NHp+VZw30Kl4ByiMLI8DrCcvdY
         8isFvVhXZG6tFqTaaZIHZLj7PnfGQIaWeMK6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410947; x=1690002947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9soCak5raKcjZvJvMtE+uNsH2FPMIxS+OErwqzv9v8=;
        b=GDXvliDM6/9dMZHDCFNITyXQ04vRjLq4ALL5YvwYnRRGTOR+Oyc7YrXkwOfYgHHioW
         4UCFKqdH8N/uTymOYMUnIGoDS5VvPfEtdsfExIf02vFGrc0Hf2fqnQA+qCGpP9HRT8tP
         xNCkDIaXo6A9V7G7/pp8+DBrKasUEcJJCOplBR6Xngaln3p8ZnRN4qZK/KkKKa3bySxP
         YRL6khpL3j6sjdTiIDUd6woAboJT3FDVW5U2OvRVvq9bBZ2Byl6uvTVqGPHLAvG4CLzf
         BCOgLa55x3zzrv/d7LNqK9w1EYM/vMYLnY7fX5o1Y4j7Y5GcM/a8Dzqt7ey1V65RWv3g
         5GMw==
X-Gm-Message-State: AC+VfDxu4yiw2AKjmfvR1VEaU/CR7DcprpF4Wsqq2qZGfZdZL0HSoeBi
        vwyeWsT3oaCBbI0PTHKhhyb+3A==
X-Google-Smtp-Source: ACHHUZ4kxeAPlCYHMJ4z3pJKW/cHTMxNWmyYnjBc+EHck+ckiyMvuhkwiIr3wXI65RbsSnDZYFW9Wg==
X-Received: by 2002:a05:6a20:a11f:b0:122:fa7e:85b5 with SMTP id q31-20020a056a20a11f00b00122fa7e85b5mr4717354pzk.42.1687410946941;
        Wed, 21 Jun 2023 22:15:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ba6-20020a170902720600b001a285269b70sm4319201plb.280.2023.06.21.22.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 22:15:46 -0700 (PDT)
Date:   Wed, 21 Jun 2023 22:15:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Stultz <jstultz@google.com>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated
 ramoops memory regions
Message-ID: <202306212212.5E53607@keescook>
References: <20230622005213.458236-1-isaacmanjarres@google.com>
 <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 09:47:26PM -0700, John Stultz wrote:
> On Wed, Jun 21, 2023 at 5:52 PM 'Isaac J. Manjarres' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
> >
> > The reserved memory region for ramoops is assumed to be at a fixed
> > and known location when read from the devicetree. This is not desirable
> > in environments where it is preferred for the region to be dynamically
> > allocated early during boot (i.e. the memory region is defined with
> > the "alloc-ranges" property instead of the "reg" property).
> >
> 
> Thanks for sending this out, Isaac!
> 
> Apologies, I've forgotten much of the details around dt bindings here,
> so forgive my questions:
> If the memory is dynamically allocated from a specific range, is it
> guaranteed to be consistently the same address boot to boot?
> 
> > Since ramoops regions are part of the reserved-memory devicetree
> > node, they exist in the reserved_mem array. This means that the
> > of_reserved_mem_lookup() function can be used to retrieve the
> > reserved_mem structure for the ramoops region, and that structure
> > contains the base and size of the region, even if it has been
> > dynamically allocated.
> 
> I think this is answering my question above, but it's a little opaque,
> so I'm not sure.

Yeah, I had exactly the same question: will this be the same
boot-to-boot?

> 
> > Thus invoke of_reserved_mem_lookup() in case the call to
> > platform_get_resource() fails in order to support dynamically
> > allocated ramoops memory regions.
> >
> > Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> > Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> > Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

I think this should have "Co-developed-by:"s for each person, since this
isn't explicitly a S-o-B chain...

> > ---
> >  fs/pstore/ram.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> > index ade66dbe5f39..e4bbba187011 100644
> > --- a/fs/pstore/ram.c
> > +++ b/fs/pstore/ram.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_reserved_mem.h>
> >
> >  #include "internal.h"
> >  #include "ram_internal.h"
> > @@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >  {
> >         struct device_node *of_node = pdev->dev.of_node;
> >         struct device_node *parent_node;
> > +       struct reserved_mem *rmem;
> >         struct resource *res;
> >         u32 value;
> >         int ret;
> > @@ -651,13 +653,20 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         if (!res) {
> > -               dev_err(&pdev->dev,
> > -                       "failed to locate DT /reserved-memory resource\n");
> > -               return -EINVAL;
> > +               rmem = of_reserved_mem_lookup(of_node);
> 
> Nit: you could keep rmem scoped locally here.
> 
> Otherwise the code looks sane, I just suspect the commit message could
> be more clear in explaining the need/utility of the dts entry using
> alloc-ranges.

I haven't looked closely at the API here, but does this need a "put"
like the "get" stuff? (I assume not, given the "lookup" is on a node...)

-Kees

-- 
Kees Cook
