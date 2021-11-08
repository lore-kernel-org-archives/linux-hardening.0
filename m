Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94073C433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 08:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780A260FDA
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 08:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhKHItQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 8 Nov 2021 03:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhKHItN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 8 Nov 2021 03:49:13 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C53C061570;
        Mon,  8 Nov 2021 00:46:29 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bk14so3522393oib.7;
        Mon, 08 Nov 2021 00:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b30HFK7segSG78ROYe0qjgc47Uv4h5TuZEe2Pf4e1PE=;
        b=WF4rbaKdRIpZ2F+cts080PySHOq6YpGFE53Vsvh02Vo8WpUndt4qqmm2NQcCLQMC2M
         QQfXZPtMMgI09+hbny5KUGNvpInQhDjWW0mog50Ze29BoxdAJ3hhzrbI2kywMDtLl2r9
         0r1DSm6Y0y4mTz+wxn7w3AYNQg3psxnR021F4ZYKYLNOxlAIYp4a5sIfLx/SNMeEe0bp
         BTsIBMnfPG2SGunTa0YfqADAzVaTjbW/JS3T4pCLe/KM4p8JtNFcg0h+GxG9IgORIkML
         MzSlJ9rR9VOcoQFfbWPs592yFicKQ4C5fzKJyofTzfu4VmrpsavfggV7eC0OG68U3Nle
         Yv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b30HFK7segSG78ROYe0qjgc47Uv4h5TuZEe2Pf4e1PE=;
        b=XgSTpDnjEjx0RDhkt/Xh88lElXT9Wj1G6AlDGTnCe9RUWBjCaVCJp7bsDFtDIX3H7k
         JZILnrOqds3L2wZyH/JMie4W1usM0oky6Bv0bHENivsy5ktDgGC1bzP+6zsaYFjD7V2l
         4mOkTBM4vpX8Qr++Bbe0rctbp7NiU7Kzb745Pekv+3pkNpT9nIBsvJJWj6xrha9F5q0F
         QYiltIeuBue+li9pUiAUo2IoXm40ijuMi6p5WXeW4tjbnla7HtROc9MJoetiXHZLLum4
         t2zLiR1baJ8+xANeNcvCwyPz0y+Gl7KhQHPp4PzS7Gp+8FWl82AZANvxCWwZnvXf5po0
         iG8w==
X-Gm-Message-State: AOAM531iCtEzWrpQ23+5bPS+B7rgZ4AoVBJOLQlssf5qt69M+HCXZ3qN
        Bi/dMph/ELlZfOgWRMKfxNaJWyYbUiiigX4habM=
X-Google-Smtp-Source: ABdhPJwSROyOKeyGFcWpl+YbXz5jIT8aoi8nHVLroXIh06B0ZI0C6JVgK2iMlh+wXGpNzCptMmZvsNkZKmHuZbuzr+Q=
X-Received: by 2002:a54:4499:: with SMTP id v25mr35904645oiv.71.1636361188731;
 Mon, 08 Nov 2021 00:46:28 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
 <CAHp75VcVZ6dDDm-k=Njo-jDq81bL4BTwrtkkAnm24b23qWKB_g@mail.gmail.com>
 <CAHP4M8UK6AYVORHCndpw2ZeRLDN+BMj3enJ-+2SWtbOPSqUe9A@mail.gmail.com> <CAHp75VeSxzDFVAgah=NXk4vzKCr0qPHHiyinKzS4vO_tvDrMsg@mail.gmail.com>
In-Reply-To: <CAHp75VeSxzDFVAgah=NXk4vzKCr0qPHHiyinKzS4vO_tvDrMsg@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 14:16:16 +0530
Message-ID: <CAHP4M8U=0aTHgfREGJpSboV6J4X+E3Y6+H_kb-PvXxDKtV=n-g@mail.gmail.com>
Subject: Re: RFC for a new string-copy function, using mixtures of strlcpy and strscpy
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "andy@kernel.org" <andy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 8, 2021 at 2:04 PM Andy Shevchenko <andy.shevchenko
> >
> > For example, in file fs/kernfs/dir.c, there are methods like
> > "kernfs_name_locked", "kernfs_path_from_node_locked" which simply
> > consume the return-value without any checks.
> >
> > All the above functions have a simple motive : copy as much bytes as
> > possible in the destination buffer, and then consume/return the number
> > of bytes actually copied (minus the null-terminator byte of course).
>
> Nope. Read the comment WRT strscpy().

Seems there is a confusion.

I meant the functions "kernfs_name_locked" and others in
fs/kernfs/dir.c, that use strlcpy and then simply consume/propogate
the return-value without any checks.


>
> > If checks are to be put in-place, it would be too much code/churn,
> > adding if checks all over the place.
>
> Yep, that's why in some cases where we know that there can't be
> overflow the checks are not present. In some cases it's historically
> like this, in some cases checks might be useful and so on. But no, we
> do not need more chaos in the string functions.
>

If the client knows that overflow cannot be there, it is better to use
the simple vanilla strcpy.
Using strlcpy means that the client believes there might be case when
src-buffer might be bigger.

Again, functions like "kernfs_name_locked" and others in
fs/kernfs/dir.c demonstrate that the client cannot be sure whether the
src-buffer is small enough to be fit into the dest-buffer.


Thanks and Regards,
Ajay
