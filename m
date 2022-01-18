Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E229C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Jan 2022 23:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350299AbiARXd4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Jan 2022 18:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350293AbiARXd4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Jan 2022 18:33:56 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8EC06173E
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jan 2022 15:33:56 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id bb9so644018qtb.5
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jan 2022 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+S41aLkIpofGd7A0yy9q0Ab7HtB9JJVBC8F1jt0b6c=;
        b=clXDUcIffYjfb/7+GCLMpj70X6Kklr2CvyZNAkDfKeordPqgZ7dr9uCnFSrH0Z8fNs
         nmu5FARUH6TejAfwX1Fo1rkfkvv8bHFh1+lKS0R1ZwnoUYhfYHagawuBgwKHXbDdVc3m
         4Db6OhnkKoyHGtNaFJBJ5564aHLLpnUzY4xMIUvW8eAGLf/GJSLVcLBise9Zd80I64/K
         RIBYXpNrGLn8HYX1HYAz4w7JMc+dJ3cWNwnZf6IkPxz+nGqHNtZ3Q2ioa2U0Wlqj6mz1
         djYy1SByRU3VgMqUewD00DzXvQRjSABtx5QUsawfNM0EneTw0gUpbM3B5vw/hBes8ns9
         v1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+S41aLkIpofGd7A0yy9q0Ab7HtB9JJVBC8F1jt0b6c=;
        b=YztQ0/+iyyVmYyra5QQOfCnLd2IYKCfp6gxqOL5beb6ia8vIG3qk9yD8ABRJDIvV15
         OSXiriLWEyoAadOf3qusYaQGUY/dsL+3+FdZ/iVJGM6j+A3DA+BweyXoMcPgX0p9y9Oa
         RA73Nb4TdyQeaqCXi+wgTkd0B2/3yJcSPB5qt37IE0Aj8ctWrPpdEmlM+0Oo33ZZHO57
         5Eqj77SPolepqsIt9zr4JbpV1cwPt41LI9oqGMSs4uBIt1gUF821zjouZcB5Zk0q/1et
         cqWJxXsX/w/eQLDqBKi1go+UbyOY3n/3qW+BYQiQ9HjxT4j58m5STgX8v1KeH8ghTXwr
         GCbQ==
X-Gm-Message-State: AOAM5315007JvAzjktVqC5KKiQxG1V54pw3tXm5pr8g2tSzkQAjR8yDb
        dHV+8kztzgkv8kLHZTr4C6somg==
X-Google-Smtp-Source: ABdhPJwOjbDopS98863TEW7dj+SfAWZdlKugbYoHHCkjP2gsnGQo+88ZrJWCdi88DSmGi6fc93r3ZA==
X-Received: by 2002:a05:622a:587:: with SMTP id c7mr22863235qtb.354.1642548835231;
        Tue, 18 Jan 2022 15:33:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w85sm8204142qkb.3.2022.01.18.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:33:54 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9xz7-0016WR-P2; Tue, 18 Jan 2022 19:33:53 -0400
Date:   Tue, 18 Jan 2022 19:33:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tpm: vtpm_proxy: Double-check to avoid buffer overflow
Message-ID: <20220118233353.GI8034@ziepe.ca>
References: <20220118183650.3386989-1-keescook@chromium.org>
 <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
 <20220118193931.GH8034@ziepe.ca>
 <202201181255.DB5D38F6AA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201181255.DB5D38F6AA@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 18, 2022 at 01:20:40PM -0800, Kees Cook wrote:

> I haven't been able to reproduce the specific cause of why GCC decided to
> do the bounds checking, but it's not an unreasonable thing to check for,
> just for robustness.

Well, the commit message should explain this is to silence a compiler
bug and maybe put some colour on what version(s) are actually buggy..

Jason
