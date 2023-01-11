Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC8FC5479D
	for <linux-hardening@archiver.kernel.org>; Wed, 11 Jan 2023 16:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjAKQ3G (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbjAKQ2S (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 Jan 2023 11:28:18 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCE326EC
        for <linux-hardening@vger.kernel.org>; Wed, 11 Jan 2023 08:27:12 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f3so10904355pgc.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Jan 2023 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IH2yuuwU4K+b8QqfSa8/esHme8z0VlstiVn2HJGNgJI=;
        b=LJ+Vb96GYiQtHpZOcoGttAbGzM+a438XickMQQp8VwKLCYPYeg8EjIiTfHVvr/Aq71
         DQxl4NEJbOzWdB4HcsQXWwleY7eo65oprUzQy48Uwdz2NJO197bmP2MC4Mjmdyq6hVsZ
         3LgJjKY0TDLLpaLRsg5GpsKHvzNubxE7X3lX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IH2yuuwU4K+b8QqfSa8/esHme8z0VlstiVn2HJGNgJI=;
        b=RqbiO/HuQVPFeiWToEPIUyjzRMzQAIgkVhrN8800CDuAIh3U7fZCdDd2cQoTDPZlWy
         iBQc3281rxWoIaOu72W6092K2Irebmaa7NiHiCMb91OdDu/FdgmHpFXgJsGcTEHetw5j
         yBFxb9LjAL4VISX3KdHUlugdBdWALa1hA16e1ioL+F4kTz2048vrn7xLnfA9tjKzUBm6
         tSdctKa4t4FyQnc9PPgUouZxrKGrXyurzKJ0Il94pwuueKKxgXFMkAxck9MuaZQhrTL+
         /s0mObJGqfIU5jnW3TPRXpyRvrvwmMesNvBLLNwSOoaywj0J0IqLoHbVeCOuF9oUWUuy
         vXsA==
X-Gm-Message-State: AFqh2koyDuz24/3GXvirrr47ve1JtPCr3H7ffrBAnUQY1cFjz16EHM/Y
        9TQFVaLJ4ObG0VUrG3qRETOWrx2MuNFDFuQV
X-Google-Smtp-Source: AMrXdXsSAB4Ujw6cFjtIaYu/b5qwOROb9RAZF0Ues29b3jkeotWm//ZzHw7VL9O2VIaW/BkU+gj38g==
X-Received: by 2002:a05:6a00:1485:b0:57f:c170:dc6 with SMTP id v5-20020a056a00148500b0057fc1700dc6mr79675555pfu.14.1673454431878;
        Wed, 11 Jan 2023 08:27:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d63-20020a623642000000b0057691fb0d37sm10116977pfa.193.2023.01.11.08.27.02
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 08:27:11 -0800 (PST)
Date:   Wed, 11 Jan 2023 08:27:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Subject: Re: Kernel Self-Protection Project meeting
Message-ID: <202301110826.20083483E@keescook>
References: <202301110820.C6020B71EA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301110820.C6020B71EA@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jan 11, 2023 at 08:23:39AM -0800, Kees Cook wrote:
> Hi!
> 
> This is rather short notice; I'll send out a reminder further in advance
> next time, but if anyone would like to join our every-2-weeks project
> video conference, please drop in:
> 
> 	https://meet.google.com/cuu-hqcm-ggg

*cough* at 10am US Pacific today...

> 
> We'll be going over status updates and a little bit of planning for
> 2023. If you're working on any security things, come tell us about it.
> :)
> 
> See you there!
> 
> -Kees
> 
> -- 
> Kees Cook

-- 
Kees Cook
