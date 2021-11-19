Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7494BC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5FB61B43
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 16:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhKSQpN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhKSQpN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Nov 2021 11:45:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2C0C061574
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 08:42:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so9220063pjb.1
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6usG8MiQSxUWW8t4LIS6CwwnjV4gadMypuBMhJfOTXg=;
        b=SJ/5hd7oOStu335XYv6nQAV6FVZqLIf9hAnFjiCDZVNARjObPclqPpfkPEbcoEKEcw
         UL7tgGQ7+lX1lEDpzzXPu1KfbxDez6M63n1J7dtwKmWViDnGvVnQc++e3Ymsvm2kDgpJ
         Vk6m5PtLG9oteHM0/wRxT6/CxDWmhUxiO3Bjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6usG8MiQSxUWW8t4LIS6CwwnjV4gadMypuBMhJfOTXg=;
        b=w8yhX+9lfK+tmDumgGlAuigy7gqoORXR+Y24evKCWLwb8AYIRoE77qS8XrtP4aaagR
         Sfo3bcdY6apL31UNCPRMF/RTEtMIfFxGc0V3jeX4Dt08L0guvn+T4arsLf6kiX/PnqZy
         O1wF3MBH4NALjkADfY1oNsBrY+0Ls1qR3Od/FeW3/H+Ce+34nISMzlQswyIHpI7qExpw
         ikdby/6iTnp9eSOgzim/+hWdkXE552HPB9Ft/hMGUsXqg8GfeVRr3bymTYYIsjExBFB9
         fG/bMlawL+XaY4+R6dMFRnc7XzgYBHRJvRWXojgzaRgm6EfS1bUXTfhDhyCe1KEtEd3m
         bVeA==
X-Gm-Message-State: AOAM531+bEVSHjgRRxd75CmPmIGeNzDvxi9sdl5q3SqfRDYhrzOfrvEh
        KgNU8gEcIFNee0XZTHvTmPEsNw==
X-Google-Smtp-Source: ABdhPJxJ0yfws7sNNKBoF+QxKvxIZXPDJEJBvkkmJPuM3LXNvCkaPrbM3z7R/EkI+PBoP+BKqrRXXA==
X-Received: by 2002:a17:902:cb8a:b0:141:f601:d5f1 with SMTP id d10-20020a170902cb8a00b00141f601d5f1mr79797842ply.77.1637340131104;
        Fri, 19 Nov 2021 08:42:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm11083635pjo.44.2021.11.19.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:42:10 -0800 (PST)
Date:   Fri, 19 Nov 2021 08:42:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] powerpc/signal32: Use struct_group() to zero spe regs
Message-ID: <202111190839.B6EC699B1@keescook>
References: <20211118203604.1288379-1-keescook@chromium.org>
 <1e312cbd-cd52-ddce-f839-db765173c526@csgroup.eu>
 <202111190824.AEBBE1328@keescook>
 <7f4e7d24-6eb0-5ecf-3497-61c3633046bd@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f4e7d24-6eb0-5ecf-3497-61c3633046bd@csgroup.eu>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 19, 2021 at 05:35:00PM +0100, Christophe Leroy wrote:
> Neither do I. I was just scared by what I saw while reviewing your patch. A
> cleanup is probably required but it can be another patch.

Heh, understood! For my end, my objective with the fortify work is to
either split cross-member memcpy() calls (which is usually undesirable) or
add a struct group so it can be seen as a "single member" memcpy again
(and usually results in 0 differences in binary output). :)

-- 
Kees Cook
