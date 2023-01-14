Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCA0C3DA78
	for <linux-hardening@archiver.kernel.org>; Sat, 14 Jan 2023 00:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjANAkv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 19:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjANAke (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 19:40:34 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6262FA25CA
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 16:36:46 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i1so2284876pfk.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkscZjiG5WUuzKu+M9F1fzoM7dY8ycxLG6ntzC7h3IU=;
        b=MXoEKhI9v4WAsnnvcnnf3R19Hy6QB1yiReFR3S3+mq3V5aeOlAR0v0GNAveHRE+ovA
         AqRmTd+LaSj0yhdSAiuQ++4GODyCFm7nCIJQQDN+qFyGAJaJzhM17t9MKHulPb+o1TRS
         cq6LouUalCaXxLSNmoMcWPfFQYy4sjP9ccaYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkscZjiG5WUuzKu+M9F1fzoM7dY8ycxLG6ntzC7h3IU=;
        b=Sq5n6b5MfL7S+WlXuc4ZEGsepMmlArfEuaArVmFSCrSsG+OUgFD5wu34jukp/VeINu
         xRBJxk+BIbevriO2RDIR61Uay6LW4SopzRXoFSWQoTSHtO49II54WmCgSwbiby2NOrFl
         yImJzR5pJaaOpy0955AFEPQYY3E3Nakg1m8oV9JHcdWM6UrxPXQ9pUF7mA5ejsN9Jcwk
         8gqKtonQEyyIkd2luWSAjWfkKmpVeZf+re+WozRCM4x5nMxrHJffVjWLSBXY9zxXddS+
         yO37mU04l7y5LcRsLgCEgth7jvd6oeAAbRRObFxlLHNG+6EKOgbh168hq9NHpXXMCe5G
         bVOQ==
X-Gm-Message-State: AFqh2ko5nzA/dbf3/5DzgjxCwOD3t05/y///bClVdTCpvv6Q1UV/ppwB
        J/R+D1Ejs0z12BE8agLTewpGuA==
X-Google-Smtp-Source: AMrXdXtVFzhbRPJCxeF4n/dT5hdEAVbiZpzEDQrBW3TKbkCRlfUfDGJWksOy1HjrJ7TwyS5qbBb5Fg==
X-Received: by 2002:aa7:914e:0:b0:574:35fd:379e with SMTP id 14-20020aa7914e000000b0057435fd379emr79188785pfi.2.1673656586262;
        Fri, 13 Jan 2023 16:36:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 18-20020a621712000000b0058b9c9def36sm4350187pfx.139.2023.01.13.16.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 16:36:25 -0800 (PST)
Date:   Fri, 13 Jan 2023 16:36:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     gregkh@linuxfoundation.org, kees@kernel.org, linux@roeck-us.net,
        vbabka@suse.cz, stable-commits@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: Patch "gcc: disable -Warray-bounds for gcc-11 too" has been
 added to the 6.1-stable tree
Message-ID: <202301131634.37E3F802@keescook>
References: <167352819915167@kroah.com>
 <202301121346.D33FD799E7@keescook>
 <CAHk-=wjq1jd4ht7RvB8HYDJFAH=dRQ+43-mj3LWMJReF4yu34Q@mail.gmail.com>
 <202301121559.AE5064D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301121559.AE5064D@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 12, 2023 at 04:10:08PM -0800, Kees Cook wrote:
> The powerpc issue hasn't been reported yet. It's my intention to do so
> once I can get it minimized.

I've reproduced the powerpc issue on GCC 11.2+. I don't see it on GCC
12.2+ (with -Warray-bounds forced on). So I've got that going for me,
which is nice.

Anyway, I have high hopes for GCC 13. :)

-Kees

-- 
Kees Cook
