Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB95C4332F
	for <linux-hardening@archiver.kernel.org>; Sat, 15 Oct 2022 06:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJOGqT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 15 Oct 2022 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJOGqC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 15 Oct 2022 02:46:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95CE31EFC
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 23:45:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n7so6619273plp.1
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 23:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DOU2E3unUByn96phGpKZpqAr82NabX0tCC6LdMB20g=;
        b=Il+ZzYSpjn+GiBjN+Yjc7Nq+BuxuM/5/HSxoy4XJkZbm7y27WcbW9u2EaMAYhow3FX
         ejy1XBWtRdc5g53ywZr92iZsHoyT3xrJG/27iIjFjxKmATIZi7jWD+/oi2itWqho3Cnt
         2smSqfyloLyIoPFrK6muxqf4nOy7iuF5APW4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DOU2E3unUByn96phGpKZpqAr82NabX0tCC6LdMB20g=;
        b=r6MKq2ZbNu9vf0hPdr2fTqNZiieIFxyKcdPXsEeNPYoBvFtVJ6i4YOsVD6bKB3eHn3
         F9VT056YmmUVEhsXRA6vtOENFP0J+UJhLd9HQe1mZPdm1CdBaDDbaCx19vn+kRCwuf/R
         2aJBeyxYV0QOwLa1nap3YAuoyqeVJs1tFz2QEE86lnHp8AfNCUzbm9QU62+S8go2WYHY
         ydR61qwEQ/G9DOCWhrxxujq1DBx6TCYy0A4J5Q9spnIwrW9GCJXcN8hmGe+aJ7EYEQeS
         3QWgdMcCc77yIodwBEMfdVELrPOCT57IYLzls/uDPAj2b8rjmLT52R1cRYpuszQElnul
         7fyg==
X-Gm-Message-State: ACrzQf3uDdYKZSJgcLW6nR9a5RazjPoWR9fhDFgJkWQDdXq5ZrvGGDz9
        vJVHRz/pBZ4alF8euMMoIBweAg==
X-Google-Smtp-Source: AMsMyM5Bh/oqn1BpTYlLLPgjIbtZSphY0g0LrDzjXUD38KRZEAHQosO+zIfU6Z5aD56PdEm/LYXbZQ==
X-Received: by 2002:a17:90b:3d85:b0:20c:8f6a:8298 with SMTP id pq5-20020a17090b3d8500b0020c8f6a8298mr22043162pjb.242.1665816354204;
        Fri, 14 Oct 2022 23:45:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b00176ab6a0d5fsm2708210plb.54.2022.10.14.23.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 23:45:53 -0700 (PDT)
Date:   Fri, 14 Oct 2022 23:45:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Simon Brand <simon.brand@postadigitale.de>,
        linux-hardening@vger.kernel.org
Subject: Re: Reconsider possibility to disable icotl TIOCSTI
Message-ID: <202210142345.1101C44@keescook>
References: <Y0m9l52AKmw6Yxi1@hostpad>
 <202210142135.252DFDF3C8@keescook>
 <Y0pIRKpPwqk2Igu/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0pIRKpPwqk2Igu/@kroah.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 15, 2022 at 07:42:28AM +0200, Greg KH wrote:
> On Fri, Oct 14, 2022 at 09:37:04PM -0700, Kees Cook wrote:
> > On Fri, Oct 14, 2022 at 07:51:11PM +0000, Simon Brand wrote:
> > > please reconsider to add a possibility to disable icotl TIOCSTI.
> > 
> > Yeah, please, let's. I always wanted to, and its use case is very
> > narrow. Even OpenBSD has removed it, somewhat motivated by the attempt
> > to remove it from Linux in 2017. I've sent this now:
> > 
> > https://lore.kernel.org/linux-hardening/20221015041626.1467372-2-keescook@chromium.org/
> 
> Looks good to me, I'll queue it up once -rc1 is out.

Thanks! I sent a v2 to fix two small errors.

-- 
Kees Cook
