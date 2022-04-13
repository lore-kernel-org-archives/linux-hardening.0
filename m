Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AFCC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Apr 2022 00:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiDMATV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Apr 2022 20:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiDMATT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Apr 2022 20:19:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CD52CC80
        for <linux-hardening@vger.kernel.org>; Tue, 12 Apr 2022 17:16:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so4616990pjb.4
        for <linux-hardening@vger.kernel.org>; Tue, 12 Apr 2022 17:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ra1hyrM7dwc+HV+WV1/rwukQPah2FvcX8EqBZ0W48RQ=;
        b=JPfUYGrDJ9dMferliAZeeTe3JyohCqjUHCUtuGWdlz2D+4eu9s7+2mSoyG/fxPXp8a
         ZMRItjzELwfA31xbYO50TmFSqamawHAYHalHJQe/9Gi9ao/jIsPn0k0WxFLeSDTvBmmg
         Yg6VolMRO4tyILYAAFA4c89HhaoEBBQ7Ke7gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ra1hyrM7dwc+HV+WV1/rwukQPah2FvcX8EqBZ0W48RQ=;
        b=Bgr1EcuU5b3+Yz1fH4spsbVxllk5bS7wOJeywICycudCZ0jfXBu0ySiqJ3z2PXD0Mo
         ar8yi4ajB4pYJU4LKKKG7BLRMOLo2RMvGWWk7Q3Eb2MWwIyGErT3ycbkoILdx+W/4c8T
         6cbEtJBB4OczXGFlArGGKD+9MXc12dcErkUHed2fx0MqoJABvaPG2Bf8MedYAr0yDRuH
         8CzaZrAVVuc/fSG65BvHHA5MNKcBpqdUfUhIVW5G5DScY3T4wf6AUMxgSWq4hJaBK1Sk
         ZXP5qKgFMDJwfZstbrRyzVQZswB7ma4PMS3urU2ttIM29pDmqC+2FbZyHsqW+C7ZflKd
         kYCw==
X-Gm-Message-State: AOAM531rhPAZ+cbEyTQkrywDTQT6RtVQ07FEwlYFAbPl91icv1qHWBBy
        hBGbKw9eihJrcFAcDKan31Fs9dTl4RZTWQ==
X-Google-Smtp-Source: ABdhPJynCJDS+RMZ1E+iWKwEnlqFSP81aNU3xTq4xQBQUu6mRlg8ddPevixz/SWhb1DNXv7jHuHW+A==
X-Received: by 2002:a17:90b:384b:b0:1c7:41fd:9991 with SMTP id nl11-20020a17090b384b00b001c741fd9991mr7849938pjb.199.1649809017140;
        Tue, 12 Apr 2022 17:16:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r31-20020a63205f000000b0039db0514016sm280137pgm.29.2022.04.12.17.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 17:16:56 -0700 (PDT)
Date:   Tue, 12 Apr 2022 17:16:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Gerber <peter@arbtirary.ch>
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: Kernel Self Protection Project: slub_debug=ZF
Message-ID: <202204121715.11B2CA80@keescook>
References: <6b039403-b46e-e186-63d0-91362dfe18a1@arbtirary.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b039403-b46e-e186-63d0-91362dfe18a1@arbtirary.ch>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Apr 10, 2022 at 09:34:17PM +0200, Peter Gerber wrote:
> Hello,
> 
> The Kernel Self Protection Project, on their Recommended Settings [1] page,
> suggests the following:
> 
> # Enable SLUB redzoning and sanity checking (slow; requires
> CONFIG_SLUB_DEBUG=y above).
> slub_debug=ZF
> 
> On recent kernels, I see the following in dmesg when this option is set:
> 
> **********************************************************
> **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> **                                                      **
> ** This system shows unhashed kernel memory addresses   **
> ** via the console, logs, and other interfaces. This    **
> ** might reduce the security of your system.            **
> **                                                      **
> ** If you see this message and you are not debugging    **
> ** the kernel, report this immediately to your system   **
> ** administrator!                                       **
> **                                                      **
> **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> **********************************************************
> 
> A bit of digging tells me that this is caused by "slub: force on
> no_hash_pointers when slub_debug is enabled" [2]. Assuming the performance
> impact is acceptable, is this option still recommend? Should there perhaps
> be a way to explicitly disable no_hash_pointers (e.g. via
> no_hash_pointers=off)?

Eww, that's not good at all. Would you be willing to write a patch to
decouple this again?

I think the primary issue is that these "debug" modes aren't exclusively
used for debugging, and exposing the unhashed pointer is directly in
conflict with the non-debug use case. :P

-Kees

> 
> Regards,
> 
> Peter
> 
> [1]: https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=792702911f581f7793962fbeb99d5c3a1b28f4c3

-- 
Kees Cook
