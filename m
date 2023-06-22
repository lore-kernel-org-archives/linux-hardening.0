Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B114EB64D8
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 17:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjFVRTi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Jun 2023 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFVRTh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Jun 2023 13:19:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7511173F
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 10:19:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b54594ce62so8775ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687454376; x=1690046376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYgiryxMLV4e1wwF96jggBbIc+/HG+JYrCu9TtuVpD0=;
        b=iNT1dDGli5TNqBRoRBJ5UhKB+ATO3qZid68u+wCjQe3Xz6Qv2gjmx16rbguj3TS1Rx
         Zlc6GQiWPjmNoFW5lSYLUFSvxzKaNCLeKaon/VmxXhoZSSmW7orLlwRd8xSsuf4SY5j5
         L6a1IRffxsHURdImMazwbru8hPfBOzxaSwxSlmmEY8mWTJdJB8fR9EDQBltTAHS/2B6U
         s33y2cSeO7ucnxdMJkGdQ/gRL2sFFZlk9btWPxlbo8hST9vEPc1JWx2pApApDxAlZUFE
         4/HzrFL0ZNp10PpoD0fWznEvd1NixhcCQMTSV7KScsRhywO2hdNSJz92ix2TlBFJ+IIy
         gPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454376; x=1690046376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYgiryxMLV4e1wwF96jggBbIc+/HG+JYrCu9TtuVpD0=;
        b=UZQp8zm+EZCYZmG6j2RuyTiNVWS5S1gS4LTSEgUlDy1zPNcJZYweAs2p24DATcALaJ
         RHgFvdy8wjb7pNANFeMHlT8zHKps5P3bTRmgaHHbmKpQXWtChbK1tSukWkDIaYZ4nyt9
         rC7YuO1rM6unNoffJLqtMKHZjj3pS6+jBYNB84qY3nPUeLKmOZL0lku5Brilob4W3UGX
         7ndjaJUV4seKqEkvadIBI3HzGYo/pfmi+oLStHREh1jzVWA32r5r/bgtKokoFM+h39rb
         xepT/OGGeQMxC+l1yz+OdfSmUlWjx59/d7VUMBSQ6oAnQvRBI+dLmBeVXb9P9PO9rOx4
         zfhA==
X-Gm-Message-State: AC+VfDwvwuvTjN8NNmIWUdLRYYdcCtQaNgeuDajovfjbH0wSSVMZx/Nk
        JQW8f2qeOU40c4pp9IbCq5kc4A==
X-Google-Smtp-Source: ACHHUZ7+WdRQmTORhEeJOuI5JscjKUPB317l04qF4yis8TrSO8AkbZesEv3Q3RnUT9FPWt/WLixm4g==
X-Received: by 2002:a17:902:fb44:b0:1af:90ce:5264 with SMTP id lf4-20020a170902fb4400b001af90ce5264mr1415616plb.27.1687454376123;
        Thu, 22 Jun 2023 10:19:36 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:44d3:c215:d3c3:9a46])
        by smtp.gmail.com with ESMTPSA id t11-20020a17090ae50b00b0025be7b69d73sm21684pjy.12.2023.06.22.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 10:19:35 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:19:31 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     John Stultz <jstultz@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated
 ramoops memory regions
Message-ID: <ZJSCox1cJ1U0Qukz@google.com>
References: <20230622005213.458236-1-isaacmanjarres@google.com>
 <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 09:47:26PM -0700, John Stultz wrote:
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

Hi John,

Thanks for reviewing this patch! When you use the "alloc-ranges"
property, you specify a range for the memory region to reside in.
This means that the region will lie somewhere in between the range
you specified, but it is not guaranteed to be in the same location
across reboots.

> > Since ramoops regions are part of the reserved-memory devicetree
> > node, they exist in the reserved_mem array. This means that the
> > of_reserved_mem_lookup() function can be used to retrieve the
> > reserved_mem structure for the ramoops region, and that structure
> > contains the base and size of the region, even if it has been
> > dynamically allocated.
> 
> I think this is answering my question above, but it's a little opaque,
> so I'm not sure.

How about re-wording the end as such?

"...and that structure contains the address of the base of the region
that was allocated at boot anywhere within the range specified by the
"alloc-ranges" devicetree property."


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

Noted! Thanks for the feedback.

> Otherwise the code looks sane, I just suspect the commit message could
> be more clear in explaining the need/utility of the dts entry using
> alloc-ranges.

Got it; please let me know if the edit I suggested earlier clarifies
things.

Thanks,
Isaac
