Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76310C04A97
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjITPfk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjITPfj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Sep 2023 11:35:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E469DCF
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 08:35:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso52176415ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224132; x=1695828932; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xyzI/2jPC9F6wHKsDS0OSbKd9NXiWoLi1MtJ1z3aLCI=;
        b=VAFZMDSN6/CwBDTs2xJG47Fue9119zfWz9BrL4ojWaZm0BQI25a68Uxo50pG1dtAWD
         KDhflcfOTkcVbUFoP1JEFoZOvWjCWvwuGoUlOHobT/ijJgtP/Nx3Er7HXcehnrJIYI8P
         y2XmEtieVCchqMpRTHRXuzrSqa9yoiD2g1JOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224132; x=1695828932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyzI/2jPC9F6wHKsDS0OSbKd9NXiWoLi1MtJ1z3aLCI=;
        b=ATZxbr5Px+3kRbD8HxC1lj/HOar05f06AMQEP5QDuaIuLH73x3B15b00cOH50/J1KR
         /BlDvoMp3lplz3Q8DsX0bjLqQu8bq2dLj/r4sIHOWVaKc7o9j8+Xk3kkDnA3E6j51f0A
         e/g9Fn/gvfAMxRzwmREI8X+S4ZJBsvbTHvXWFKDIoaV9n7XjZ9djmVPGqSB8+pT58PSr
         s5lSrZLt97cG6XgTPckfIQWfJfsjFcZVpABCBxnJQpswQrHOKIPXmppMEUbhoc9k6hVJ
         ivhrYBxL5pGLMKQVWO3tB2JqMNHwNr5rnuw/bmhyrkBufoVs7DXFq4JmmHyUaS45PZV/
         3dsg==
X-Gm-Message-State: AOJu0Yz5JCjl/8H8IeSZIoJx/NdASs7bhOmwS4GDWJr8UlOc1aX9fRpp
        iEGrTL25X7UsFAmtPjzRb6bk/Q==
X-Google-Smtp-Source: AGHT+IH7KvJYqumVi06xoNHjGmnO9AFf67y1wfKqdTT7KbI311Lof35LTW/3etTQCVyWIhrQe6ZZmA==
X-Received: by 2002:a17:902:d484:b0:1c0:d7a8:a43e with SMTP id c4-20020a170902d48400b001c0d7a8a43emr3020487plg.53.1695224132328;
        Wed, 20 Sep 2023 08:35:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001c44c8d857esm8339926plq.120.2023.09.20.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:35:31 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:35:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Justin Stitt <justinstitt@google.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: refactor deprecated strncpy
Message-ID: <202309200834.2D2F0777@keescook>
References: <20230919-strncpy-drivers-hwmon-acpi_power_meter-c-v2-1-8348432d6442@google.com>
 <987d843b-d451-4f85-85b2-00ec18c75cca@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <987d843b-d451-4f85-85b2-00ec18c75cca@t-8ch.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 19, 2023 at 09:02:49AM +0200, Thomas Weißschuh wrote:
> On 2023-09-19 05:07:55+0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > 
> > A trailing zero is already handled by the kcalloc
> > |	*str = kcalloc(element->string.length + 1, sizeof(u8), GFP_KERNEL);
> > ... which makes memcpy() a suitable replacement to strncpy.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Changes in v2:
> > - use memcpy over strscpy (thanks Kees)
> > - Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-hwmon-acpi_power_meter-c-v1-1-905297479fe8@google.com
> > ---
> >  drivers/hwmon/acpi_power_meter.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> > index fa28d447f0df..82e99aec4a33 100644
> > --- a/drivers/hwmon/acpi_power_meter.c
> > +++ b/drivers/hwmon/acpi_power_meter.c
> > @@ -803,7 +803,7 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
> >  			goto error;
> >  		}
> >  
> > -		strncpy(*str, element->string.pointer, element->string.length);
> > +		memcpy(*str, element->string.pointer, element->string.length);
> 
> Isn't this now essentially the same as kmemdup_nul()?

Ah, yeah, good catch. I should add a note that the reverse of strtomem()
is kmemdup_nul() :)

Justin, can you refactor this to use kmemdup_nul() instead?

-Kees

-- 
Kees Cook
