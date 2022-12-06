Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E6C4708C
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Dec 2022 17:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLFRtf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFRte (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Dec 2022 12:49:34 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E68B857
        for <linux-hardening@vger.kernel.org>; Tue,  6 Dec 2022 09:49:33 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r18so14003735pgr.12
        for <linux-hardening@vger.kernel.org>; Tue, 06 Dec 2022 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ICtZNQQIECcoUV2T8DPLv/5CjLxlJxo5ELk63KJMTWM=;
        b=D4UWvQHkPpgWRIW2yCKzG63FY3IVtUaX+fckriYTJL9at6/DIqcow4qEB3G+XDMzA9
         15EMESvE9DUNnWk3bNgQBDV4fp5ii+A6nV+tVNtmFLFJd9AY7Tppx8po2Icy0sMmBHdO
         BzLf6DUFG5CELzKIYP90gz+QdqwyjKpWZWXpBvGqT1AXk+res7180LhmgdJ6o99cdHAE
         9HVJL0Yxb4kkVnjrzcQuQBDKIyu1yn8sCMP/xb1V6VaGb9onh9PDG0dPDj9AcqS9E8Ee
         E6UzfsUrtwoSANqGJOTYJJeX8GHGrdTnhPR7wtn98ekltN3Zxk7DHgMqqgG3O89sGICo
         54tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICtZNQQIECcoUV2T8DPLv/5CjLxlJxo5ELk63KJMTWM=;
        b=uNS51Gffje4hd0/QFihdXtqgGuQFXcD7+uYhqSwPnZe7WoJw/+HRi5QIRXe9qf30Vb
         EnXqdLGRb+LfSCpEEI5n3oxuc0fdBBKKb+TBz6hBdJ8Vc4FVgQY2qBd/uNqbibllTb0I
         XWSdPazmu8EnIE8yVBynJY2fIFjvsn73uOUzvyqKZDuwiVb+zPf7O7HidR+xcaLYG8Ih
         +XI7a3nwBcBXtBMHQ3xAxyzrVhBXsxHKODockJg6C2KXVLcNPzGV/aBHNgzUCYGxm0SP
         VmyfJjVantNbp58k3i/jCrolsW8szRoulRLcF2CoxzXWDIP/AN73VKaUVPQAVwwI7+Lx
         xF/w==
X-Gm-Message-State: ANoB5pmc0hhb60z0NppWlEBtoleCPOtHgKNFgDyuDXcwQV5XSfXwH/H7
        +25yZoHlOHRNjN1boCFweO5Ou9OYtu9DifJncZGsfQ==
X-Google-Smtp-Source: AA0mqf4YG6k4mPXavaI5dFKuiml0xnQbph3dfLNPO/Rr9ysj57G6xzz8+ebmMh09c5Ax9kXsfN/Dd3G5HqA9lDkmRUM=
X-Received: by 2002:a63:f04d:0:b0:470:5d17:a62e with SMTP id
 s13-20020a63f04d000000b004705d17a62emr61433446pgj.620.1670348972272; Tue, 06
 Dec 2022 09:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20221206152358.1966099-1-jeffxu@google.com> <20221206152358.1966099-4-jeffxu@google.com>
 <Y49oIR6/ULTqlcwL@kroah.com> <CALmYWFvaEg84DYtjQtoQqsvaboX7mRS5dOqz8OJ0EYJTOCp4kg@mail.gmail.com>
 <Y49vUQKRVyquazJ2@kroah.com>
In-Reply-To: <Y49vUQKRVyquazJ2@kroah.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 6 Dec 2022 09:48:55 -0800
Message-ID: <CALmYWFvO8kKGusv8_Jwevw5pS4LwbF9G12=RthWZeHYE++ZO3Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 6, 2022 at 8:35 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 06, 2022 at 08:26:30AM -0800, Jeff Xu wrote:
> > On Tue, Dec 6, 2022 at 8:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Dec 06, 2022 at 03:23:55PM +0000, jeffxu@chromium.org wrote:
> > > > --- a/kernel/pid_namespace.c
> > > > +++ b/kernel/pid_namespace.c
> > > > @@ -110,6 +110,11 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
> > > >       ns->ucounts = ucounts;
> > > >       ns->pid_allocated = PIDNS_ADDING;
> > > >
> > > > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > > > +     ns->memfd_noexec_scope =
> > > > +             task_active_pid_ns(current)->memfd_noexec_scope;
> > > > +#endif
> > >
> > > .c files should never have #if in them.  Can't you put this in a .h file
> > > properly so that this does not get really messy over time?
> > >
> > >
> > Thanks for reviewing.
> > It seems to me that checking for CONFIG_XXX is  common in c code in
> > kernel/ path.
>
> Maybe, but please don't make it any worse if at all possible.  It's
> tough to maintain code like that.
>
> > Do you have a sample code pattern (link/function) that I can follow?
>
> Any of the zillions of #if statements in .h files :)
>
Thanks.
I will take the approach of having real/stub implementation in the h
file, and the c file  using it without a compile flag.
Please kindly let me know if this is not right.

Thanks
Jeff

> thanks,
>
> greg k-h
