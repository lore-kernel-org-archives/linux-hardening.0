Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1677C433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFFF61002
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 08:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbhKHIhZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 8 Nov 2021 03:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbhKHIhZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 8 Nov 2021 03:37:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEF9C061570;
        Mon,  8 Nov 2021 00:34:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ee33so59475367edb.8;
        Mon, 08 Nov 2021 00:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHnkd35me93FuEtLXvwLwI6ioK1S2/Q5OTvTYZxAMTI=;
        b=TVAjSTl6IurKWBgjfvUjG0wMA/lsQteX7/pKolPuBvk5yguPjvmoQAx7CUCBFV6f7J
         9lHSWCFpMrH0mUzCowJ7k0e6cV6REhONzjXmuC51JA9d9gE/VNLcPHatb+chEiP8/bIY
         sDkczqoUjRV/ACrlnya8+GLFDJlxWNk++yHhS1PGaVIUDYLNOIyOfiHfvMAfdHDmDTxA
         /tpwjGUYzdGKuPUICtiE1hKZyqQym13NefF7+e2xlvC4nIuFM/TowLb1HZxG9bGb74M9
         oHxr+CzpA5Qk6XUh0aDUSEvZaoRB/iyIyu9v1FWrAVq5YSOrpYUUQhP9mB2OdNi4UeGX
         mnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHnkd35me93FuEtLXvwLwI6ioK1S2/Q5OTvTYZxAMTI=;
        b=C8d8kWTs3MwhXYmABDwMDRPYkjtNa4mX3BAT8/znM+tfHqfx9X/Fx7ry/kFtFC7FfQ
         nVGusNoRLoIGEMnzBad12jaIDzQ8dxtd1afdEZBT29PD96jDX4zH7QzcJDGjUxTIVpkx
         KMWakiNwXSHso3Fin7/6O4isT219xIyzhL0U6J2jKAaZCpq7fJu3bVFd2ljS8FbNnZoN
         Bkmw0gjxx8Ztd2tlYc6jVd9no3tOT4U349wPQwRn4CVvZf6AlztiDxoecDL0gm+ev90k
         JLTMvDWnPjszA1QlUj18Nas+V6p8qNM+YxUCTMIKYh136BHBiSgkzSU/H2ZJ5cukpFVR
         iUPA==
X-Gm-Message-State: AOAM531T75PIIiWPI63bcemX0er1ryQneuX/PFg1l99vhJfS2IRpEMEN
        DrPUZqhGlFd3zpx2TC7LjtL4fdrTgMge0ghb9FI=
X-Google-Smtp-Source: ABdhPJwW/C+XMPPMxdkbARixwVvUYYY1A1r+GWqu+oAetdoJrkcN7iqry3e4+4itEtjqQ/FimnvBaTnzZFJ45i6HEuc=
X-Received: by 2002:aa7:cb09:: with SMTP id s9mr107198741edt.359.1636360479858;
 Mon, 08 Nov 2021 00:34:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
 <CAHp75VcVZ6dDDm-k=Njo-jDq81bL4BTwrtkkAnm24b23qWKB_g@mail.gmail.com> <CAHP4M8UK6AYVORHCndpw2ZeRLDN+BMj3enJ-+2SWtbOPSqUe9A@mail.gmail.com>
In-Reply-To: <CAHP4M8UK6AYVORHCndpw2ZeRLDN+BMj3enJ-+2SWtbOPSqUe9A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Nov 2021 10:33:54 +0200
Message-ID: <CAHp75VeSxzDFVAgah=NXk4vzKCr0qPHHiyinKzS4vO_tvDrMsg@mail.gmail.com>
Subject: Re: RFC for a new string-copy function, using mixtures of strlcpy and strscpy
To:     Ajay Garg <ajaygargnsit@gmail.com>
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

On Mon, Nov 8, 2021 at 9:42 AM Ajay Garg <ajaygargnsit@gmail.com> wrote:

...

> >> len = [-7]
> >> a = [123456789]
> >
> > My gosh, this is error code that you must check. We do not need more string copy functions.
>
> Hmm, having the additional function would make things a lot easier.
>
> For example, in file fs/kernfs/dir.c, there are methods like
> "kernfs_name_locked", "kernfs_path_from_node_locked" which simply
> consume the return-value without any checks.
>
> All the above functions have a simple motive : copy as much bytes as
> possible in the destination buffer, and then consume/return the number
> of bytes actually copied (minus the null-terminator byte of course).

Nope. Read the comment WRT strscpy().

> If checks are to be put in-place, it would be too much code/churn,
> adding if checks all over the place.

Yep, that's why in some cases where we know that there can't be
overflow the checks are not present. In some cases it's historically
like this, in some cases checks might be useful and so on. But no, we
do not need more chaos in the string functions.

> If, instead we do a simple replace of "strlcpy" with "strlscpy" at
> these places, we would be good to go (while *really* meeting the
> requirements of these clients at the same time).

-- 
With Best Regards,
Andy Shevchenko
