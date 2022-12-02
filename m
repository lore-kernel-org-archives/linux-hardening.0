Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFF4C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLBUNw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Dec 2022 15:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLBUNv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Dec 2022 15:13:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812572191
        for <linux-hardening@vger.kernel.org>; Fri,  2 Dec 2022 12:13:50 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z14so1984157pfr.11
        for <linux-hardening@vger.kernel.org>; Fri, 02 Dec 2022 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNEZlNoSAlfJef2s1RQdVmz4/bQBOUK5DuhGxPB7vAk=;
        b=Kcqfmgn+lpfNsKb9spea06UlV2GZhmwN/OS0ktDSzoo4CmrAdoRMRBIvUIb2aluXos
         QInSZOJOqzcEdcgwinOc4F1tqgA2R9yQnZBYcyOk5x+lypWug/4bP88rY6K1ssJNO48r
         ZSeBNKeWf1jpWfPZ3KjPge8KY9ioTstixhupU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNEZlNoSAlfJef2s1RQdVmz4/bQBOUK5DuhGxPB7vAk=;
        b=s9mljxEOQ0KYpqNhL6utPHqT86lF4aGPH0d9kGIQHj2PeDkrFWz3QP7p3UqeacthQ4
         YYTvvTdATHTE9qMCZi5qMnDs72BpCppVfwxIzEfU6KbH5I0Tbl9Bo3n3JNfbUgZ0B76i
         03kmrj31ZGOCmHncBHcAPNCJTzsiq6OZhbgObNuQ2dAa0PKl3cd5f8WE9N9ExAIlZEyr
         K54B7wo62rP0D4tQKN0Fe1kV3LhzD/UBB34GLWxHIdxKULaSuefUk9CttaiFQNdkBSKh
         mdQtc0m8f8vU58A2OYbGYRP45Ad078ydw35CvvFgoZEvvb0MHGdMDUmljkcgSLgWnajW
         Pc0w==
X-Gm-Message-State: ANoB5pmMgeWyLEyELDTOIgEINV+V2sdAVJfWXC9frUY+V8Ed8RyPR3mI
        uYpqNx08tg8G/rWcORgAM9ocpOq+hqSRB/8o
X-Google-Smtp-Source: AA0mqf76st5RS08ATVWFRrBuDwh2jDmMNVtVwNTlAusXAtO3pbdPexLKLCdZJby2GO03QFbCi4R4Ig==
X-Received: by 2002:a63:2226:0:b0:478:54e2:ecb1 with SMTP id i38-20020a632226000000b0047854e2ecb1mr14859655pgi.550.1670012029999;
        Fri, 02 Dec 2022 12:13:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090a430b00b00212e5068e17sm5086582pjg.40.2022.12.02.12.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 12:13:49 -0800 (PST)
Date:   Fri, 2 Dec 2022 12:13:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stefan Bavendiek <stefan.bavendiek@mailbox.org>
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: Reducing runtime complexity
Message-ID: <202212021208.04CE21D1AE@keescook>
References: <Y4kJ4Hw0DVfy7S37@mailbox.org>
 <202212011520.F7FE481@keescook>
 <Y4mbqmsMjTA63SlP@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4mbqmsMjTA63SlP@mailbox.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 02, 2022 at 07:31:06AM +0100, Stefan Bavendiek wrote:
> On Thu, Dec 01, 2022 at 03:21:37PM -0800, Kees Cook wrote:
> > On Thu, Dec 01, 2022 at 09:09:04PM +0100, Stefan Bavendiek wrote:
> > > Some time ago I wrote a thesis about complexity in the Linux kernel and how to reduce it in order to limit the attack surface[1].
> > > While the results are unlikely to bring news to the audience here, it did indicate some possible ways to avoid exposing optional kernel features when they are not needed.
> > > The basic idea would be to either build or configure parts of the kernel after or during the installation on a specific host.
> > > 
> > > Distributions are commonly shipping the kernel as one large binary that includes support for nearly every hardware driver and optional feature, but the end user will normally use very little of this.
> > > In comparison, a custom kernel build for a particular device and use case, would be significantly smaller. While the reduced complexity won't be directly linked with reduction in attack surface, from my understanding the difference would make a relevant impact.
> > > 
> > > The question I keep wondering about is how feasible this is for general purpose distributions to have the kernel "rebuild" in this way when it is installed on a particular machine.
> > 
> > Much of the functionality is modules, so once a system is booted and
> > running the expected workloads, one can set the modules_disabled sysctl
> > and block everything else from being loaded.
> > 
> > -Kees
> > 
> > -- 
> > Kees Cook
> 
> Disableing modules in general will prevent quite a lot of functionality that would still be expected to work, like plugging in a usb device.
> One approach may be to load everything that may possibly be required in the future as well based on the use case of the specific system and then disable loading additional modules, but that does not seem like a good solution either.
> 
> Perhaps exploring embedded device deployments is an idea, but in general the idea is to ship a smaller kernel to something like Linux desktops without limiting functionality that likely to be required.

What I mean is that we already have a good middle-ground. It doesn't
need to be all (general distro) or nothing (embedded build). Once the
workload for the system is known, load the needed modules and block
everything else. i.e. set up a module alias named "disable", and then
fill /etc/modules with whatever you might want that isn't automatically
loaded at boot and end the list with "disable". I wrote this up almost
exactly 10 years ago:

https://outflux.net/blog/archives/2012/11/28/clean-module-disabling/

:)

-Kees

-- 
Kees Cook
