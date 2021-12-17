Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D5C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 17 Dec 2021 13:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhLQNHU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhLQNHU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 17 Dec 2021 08:07:20 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC1BC061574
        for <linux-hardening@vger.kernel.org>; Fri, 17 Dec 2021 05:07:20 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id p2so4128941uad.11
        for <linux-hardening@vger.kernel.org>; Fri, 17 Dec 2021 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WyqG449HouzDrScaDmK4P0UvJlEZr892cvhoYjqoY2E=;
        b=hvGxrBVo4h1TtoF26FhhGuoXXzZPdyShcCUytRzlM0Plw/HIyV9EWBK9uuEcCUBaiA
         FjSfTgV5upRko9I/ISHfWOBIEZn/7Bj4xRj3+Uk61XJYehFUldayfuLrW1vzSwNBJ1mb
         aLrCzQFvchmaEFjJ/+lqwZoxMEput4J49+4bz3biqvjrTiCa8r0mucECwYnH3S0HFWgg
         Jfai72cAdPDr17AvYdISwKUUeWv9xyWTPGb0yVWHWV9zqb5p9cYB9esRs/z+DT+9bVHU
         g7M4eYBe3Wph3hx5iaIC3C9TQX0bXpYVQ8jfX9MwG20INdBHiOrvWr+n6v49NIZVs5Hm
         DFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WyqG449HouzDrScaDmK4P0UvJlEZr892cvhoYjqoY2E=;
        b=PRS+Y6pwarCq2DoD4Egc9HKszC6K9hVr72RP2svnYHnuUcFl6H+eCuVi5RAeFir1CS
         y5eWlnUoJr+dwcq/wkEiA4CtSZSZTZCoq5ctcZlKxv6YaRgkx75G4lbge/wYgt1dTjf8
         D7B9/Ycx2rItF1ePxv3nsiNy4KDqCqBYs/wohSNZ/84yDXvzKL+D6zmupCxvjnWdrZdZ
         /liKXfxSHrDerMMPu2Wn5wQn0WPlZGPcJfeoxTlz1cR6iHoZWHYGrSnm3caim0BUF2r8
         KyKXWMzBpLUcZmt64hl+hcwUZ1Lw5BcUbB5KsqlH6XjF7c88CUpyFKtiG9mdNwt4PShf
         pzkA==
X-Gm-Message-State: AOAM533v9mg/SLieY5EYUE92vSbmo0qcHIsVBjrxutZvKO88SztqfZi6
        onYXTDts0RiTpGJH4MKgf5iD1E8QcHCjQl7eK/tL30gn
X-Google-Smtp-Source: ABdhPJxNr69laEuDs+e3NnuABtF1GjS2Z66JFSpWl632oLphdf/8tC8oOYcybPOSrok5yqD2RzqH6uIgEkl6lkc0XxI=
X-Received: by 2002:a05:6102:1613:: with SMTP id cu19mr852254vsb.25.1639746438811;
 Fri, 17 Dec 2021 05:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20211216215351.3811471-1-willy@infradead.org> <20211216215351.3811471-3-willy@infradead.org>
In-Reply-To: <20211216215351.3811471-3-willy@infradead.org>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Fri, 17 Dec 2021 13:07:07 +0000
Message-ID: <CANe_+Uj6cU3k5Xu9o43H7PosmS0ptXQOVkhgLB3OJCwFBnkCiA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] mm/usercopy: Detect vmalloc overruns
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 16 Dec 2021 at 21:55, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> If you have a vmalloc() allocation, or an address from calling vmap(),
> you cannot overrun the vm_area which describes it, regardless of the
> size of the underlying allocation.  This probably doesn't do much for
> security because vmalloc comes with guard pages these days, but it
> prevents usercopy aborts when copying to a vmap() of smaller pages.
...
> +               offset = ptr - vm->addr;
> +               if (offset + n > vm->size)
> +                       usercopy_abort("vmalloc", NULL, to_user, offset, n);
> +               return;
> +       }

Instead of vm->size, call get_vm_area_size() so any guard page is
trimmed from the length.

Mark
