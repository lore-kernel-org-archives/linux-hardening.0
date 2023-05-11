Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3615C77B7C
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 21:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEKVNO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbjEKVNN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 17:13:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A1330C2
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 14:13:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so1142803b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683839588; x=1686431588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0iPvtK8eE4YcejseVQBaIQEVfSENwYG96qP/AvtPv+Y=;
        b=UBgIMvYRcCeSNbo0PAw8RzF3Hd53WQNccP/U6vfXz2w7A88C13gDLVFIE1h+OPigJn
         24afD1MaMaPhvbwilNjeva2PZjatXjEJpCrun1mbLI0hX/ut84DUM6jzvlMuPXndlD4F
         m0nvbbicXYeuCWVBuqAC6+vmF9SmXUo8C2JUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839588; x=1686431588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iPvtK8eE4YcejseVQBaIQEVfSENwYG96qP/AvtPv+Y=;
        b=cPO1OvfMXuq4HpGM3hQd9nRG19d2uaI0razHeuSCSD1mPBbJoNEi52dA0vq0ur6+rA
         pYV/vegfvjCMyGcR3xM0CFn5N9mVPISfxIU/yytVuWXOnFfUOK3v29qqL98D9PPfE4Ek
         EPtLa5N9HZdojyYrw3nC1vYPDYlGe0P/dsLp82TDGahTbZDZbGsv6SUSsXCFiuhXS+oI
         tQFnl7pax7Zhq+9kBFoSMFfa0jxo+Hezo/J+J1cDSSdOFgD2O0FgsbjwqCjBI5ayn8sH
         oI9Qn/ZKGXB432uIEUoAVIvOJr126pGu7hJadNEGFrAGSBeI84aXH7VCRR3N/rFQpGdz
         8U4w==
X-Gm-Message-State: AC+VfDyZWOPv8D1w6ocCh3X/VI23ap8TO+FmAEH9mttm0idDj4prAG21
        vxLIZp+KQDBv25VwaQkSqvplRWdr0mkrqjupr5z77Q==
X-Google-Smtp-Source: ACHHUZ5dO5qa4+mnTcA59fwH9hAengKmF5rUNjLuEBqwS/HtHeokRXUFfw9ThbqW5lmW/PNuPPLviw==
X-Received: by 2002:a17:90b:198f:b0:246:5787:6f5d with SMTP id mv15-20020a17090b198f00b0024657876f5dmr31482866pjb.10.1683839587703;
        Thu, 11 May 2023 14:13:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ei18-20020a17090ae55200b00252a7b73486sm418617pjb.29.2023.05.11.14.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:13:07 -0700 (PDT)
Date:   Thu, 11 May 2023 14:13:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>, GCC <gcc@gcc.gnu.org>,
        Alejandro Colomar <alx@nginx.com>,
        Andrew Clayton <a.clayton@nginx.com>,
        Andrew Clayton <andrew@digital-domain.net>,
        linux-hardening@vger.kernel.org
Subject: Re: [wish] Flexible array members in unions
Message-ID: <202305111410.CFE0875F@keescook>
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com>
 <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com>
 <202305111158.C78642624@keescook>
 <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 11, 2023 at 08:53:52PM +0000, Joseph Myers wrote:
> On Thu, 11 May 2023, Kees Cook via Gcc wrote:
> 
> > On Thu, May 11, 2023 at 06:29:10PM +0200, Alejandro Colomar wrote:
> > > On 5/11/23 18:07, Alejandro Colomar wrote:
> > > [...]
> > > > Would you allow flexible array members in unions?  Is there any
> > > > strong reason to disallow them?
> > 
> > Yes please!! And alone in a struct, too.
> > 
> > AFAICT, there is no mechanical/architectural reason to disallow them
> > (especially since they _can_ be constructed with some fancy tricks,
> > and they behave as expected.) My understanding is that it's disallowed
> > due to an overly strict reading of the very terse language that created
> > flexible arrays in C99.
> 
> Standard C has no such thing as a zero-size object or type, which would 
> lead to problems with a struct or union that only contains a flexible 
> array member there.

Ah-ha, okay. That root cause makes sense now.

Why are zero-sized objects missing in Standard C? Or, perhaps, the better
question is: what's needed to support the idea of a zero-sized object?

-- 
Kees Cook
