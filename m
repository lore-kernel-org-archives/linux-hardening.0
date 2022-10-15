Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFC9C433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 15 Oct 2022 04:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJOEhI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 15 Oct 2022 00:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJOEhI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 15 Oct 2022 00:37:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E625723F
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 21:37:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so6472755pjl.3
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 21:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=02Yu8D6dMl/A9JAM6UPD8i75l0IW5SMkTBzFYoJGPrc=;
        b=LSR1ZLG3fzzlJAhubfDX6UyMc8WAS/5nudxz67hWkkXNYv6tWJZr+I1W04OP+Fz4Iy
         r/DTWPuS29Oa3PXnCidfdw6xb2Hb7OBb48olhzv6wohi1pQ7w/Z+oUTrlDBjUqh9fDyu
         kmM4PEwwKL/a40GBrXKaF7c6tURBAzWU5hWUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02Yu8D6dMl/A9JAM6UPD8i75l0IW5SMkTBzFYoJGPrc=;
        b=nej7C5z+JatLYqHP4wv2AWasAzweBQJXc9NXo2Nur7IJ7vWwHL7w7y3Wt4NgfkJnDf
         9q98pt2MqeZIzG6ju0txJ6iqFzJM57+rdGSiPKipc2GVPRhfNQeJsSlpRsicq80mylk8
         sMgUoQ1Zr5nk9rkvoUZU8c3RtoXTqKgfwWivfnOwJSltBCLYY4XUeGdyU2mA7jJlpZPR
         PkXoRDlc84RITSVPxE5i3Grb2rp0IAL1C7DyIkV8PFyl10wVTIe1NyvnNTcyeaoLxii/
         xWoauaywAE3FKL+ocKOoMC0IHNNlGzkfKPYdxRCR/1EUsNfkTNSKEn+Uc/WDNPXS80Ck
         /G9w==
X-Gm-Message-State: ACrzQf0zuiHmUVRlSDOYP5wTqNOiXASc4tQizPPXeHmQj4xeqTbNp+iN
        vvmGLTFvH4c5xFsupLFVmQaqhrOOfoJmiQ==
X-Google-Smtp-Source: AMsMyM5030oVQIMT36WdeTo0w3G3hVxPRdjcaBlgYo/Y/tftGPMDj1DR4i1aUBDlN1jURK8RY86jYQ==
X-Received: by 2002:a17:902:7e8e:b0:182:25d6:e65b with SMTP id z14-20020a1709027e8e00b0018225d6e65bmr1053467pla.9.1665808626869;
        Fri, 14 Oct 2022 21:37:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i34-20020a632222000000b0045913a96837sm2240239pgi.24.2022.10.14.21.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 21:37:05 -0700 (PDT)
Date:   Fri, 14 Oct 2022 21:37:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Simon Brand <simon.brand@postadigitale.de>
Cc:     linux-hardening@vger.kernel.org
Subject: Re: Reconsider possibility to disable icotl TIOCSTI
Message-ID: <202210142135.252DFDF3C8@keescook>
References: <Y0m9l52AKmw6Yxi1@hostpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0m9l52AKmw6Yxi1@hostpad>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 14, 2022 at 07:51:11PM +0000, Simon Brand wrote:
> please reconsider to add a possibility to disable icotl TIOCSTI.

Yeah, please, let's. I always wanted to, and its use case is very
narrow. Even OpenBSD has removed it, somewhat motivated by the attempt
to remove it from Linux in 2017. I've sent this now:

https://lore.kernel.org/linux-hardening/20221015041626.1467372-2-keescook@chromium.org/

-- 
Kees Cook
