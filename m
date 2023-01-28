Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EE2C54EAA
	for <linux-hardening@archiver.kernel.org>; Sat, 28 Jan 2023 00:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjA1A1L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjA1A1J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 19:27:09 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC952A9B5
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 16:26:31 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id 88so6142593pjo.3
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 16:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeH8pABTUU3a0xVRTCMZvbgUglNp9bFLSOXGO6BnE7g=;
        b=BECD3XNIWMyGoO2pR3j/pX0MZD4uav4Bzx9OtUdfE75udvtV/lOWKkjTFbRM2sloLc
         ejhPX+xaRVLru/x35gtmNrlbT2PxkyPt59fIfVceGze3V2TV45OtLHqKvysIzYQJXtBR
         4NfM+qgitcY4aK6I2UI65eE6pFQ4iEHj/fbIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeH8pABTUU3a0xVRTCMZvbgUglNp9bFLSOXGO6BnE7g=;
        b=iPZaaFnyUV7VD4Vy0CFRO5IICv49++1Lsh4/5vypTryGzrUnKUZ+FlANxTSoazsbSr
         QzEce464ewM1Ye7lSY1e7sRxM4PJYNmzQ1POSBRvBPAmupghV2xw2Xm94Jl0kq/GoCQX
         kRKcp8DHdBT+MkCpR5Gmws3yMvzgMqfM2mseyg0fNS6QBw0VIZmJ7tOpINq35gE5yvN/
         c04ZGprarZ1027boDJF/qRkVDwpsm2v3vIPh7HBFUi8qGZHEetizp7E6oODx0l6kY8ap
         wU3RLS6bjbwf9mp0yLbSbvJ5OfSlX2yIcVwgQM/Juqp+UxYqj6fjOkMsRWXmQWSgVyrG
         KJKA==
X-Gm-Message-State: AFqh2kq7+o+ebIdEo/cYXFHAgETE5tF7MCjD3vENgByDiX6DxDWrju3y
        rcT5uXAn9T9ww2f0LFSu25/sdg==
X-Google-Smtp-Source: AMrXdXsExg1wzuhHvjjRvAqAzd/gB3gJtdoQdxyb9q20M/sCxt1Uqj01DxRY4/bB23t24AwIZoSeug==
X-Received: by 2002:a17:902:e891:b0:194:de51:9ad with SMTP id w17-20020a170902e89100b00194de5109admr37556027plg.22.1674865459091;
        Fri, 27 Jan 2023 16:24:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b001947c22185bsm3393193plg.184.2023.01.27.16.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:24:18 -0800 (PST)
Date:   Fri, 27 Jan 2023 16:24:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scripts/dtc: Replace 0-length arrays with flexible arrays
Message-ID: <202301271624.01B4A55D3C@keescook>
References: <20230127224101.never.746-kees@kernel.org>
 <CAL_JsqKVp57NtR11JV-eXktMU9_dQ+8sF8YSPe7KyazrvJB-eQ@mail.gmail.com>
 <202301271609.15F0E5EB15@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301271609.15F0E5EB15@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 27, 2023 at 04:12:21PM -0800, Kees Cook wrote:
> On Fri, Jan 27, 2023 at 05:44:13PM -0600, Rob Herring wrote:
> > On Fri, Jan 27, 2023 at 4:41 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Replace the 0-length array with a C99 flexible array. Seen with GCC 13
> > > under -fstrict-flex-arrays:
> > >
> > > In file included from ../lib/fdt_ro.c:2:
> > > ../lib/../scripts/dtc/libfdt/fdt_ro.c: In function 'fdt_get_name':
> > > ../lib/../scripts/dtc/libfdt/fdt_ro.c:319:24: warning: 'strrchr' reading 1 or more bytes from a region of size 0 [-Wstringop-overread]
> > >   319 |                 leaf = strrchr(nameptr, '/');
> > >       |                        ^~~~~~~~~~~~~~~~~~~~~
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  scripts/dtc/libfdt/fdt.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Changes to dtc/libfdt go to upstream dtc first and then we sync them back.
> 
> Ah-ha, I've found it: https://github.com/dgibson/dtc

Sent upstream: https://github.com/dgibson/dtc/pull/76

-- 
Kees Cook
