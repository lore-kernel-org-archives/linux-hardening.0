Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE8EC433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 13:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9903B6124D
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 13:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhKHNW0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbhKHNWZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 8 Nov 2021 08:22:25 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E71C061570;
        Mon,  8 Nov 2021 05:19:41 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id n66so3877639oia.9;
        Mon, 08 Nov 2021 05:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0flhI2IM+75LV5iWxTzJ9NkGeHTlkhb7YQc5I+AiWc=;
        b=UxJB5HXIF/EnmCBPgYEmjZJU+JrBB0o5LgzD0rbcRUzrkQYfCsQO/0YsuzcZPZk+k3
         1T6GR6n4r6lm3WZyhH+JVUtyCLw4mhKsBKqytmbTZ6hlgMmWufGXmcjKo+lE7tNHEgMp
         Y/Wz5m4vWt1nxoqMzPAHnFZURe2ux3SBbeyShVm/HrVKtNrX3AzilFPQEcyY1XkXyhB7
         GUYLZ3U/h6JK8zDgeW+GkvnP68Z1tchq4LzsG2Nh361BAsiwqHJpunfcfjJoGQXtnxVx
         jR3yDaw/0Q//We89RkeVe8gQFHyseXIdutxPXblrty7ayZA3WCsIXbh5Iok4PZS9Q40G
         8EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0flhI2IM+75LV5iWxTzJ9NkGeHTlkhb7YQc5I+AiWc=;
        b=W0mQqR9wtiY6noPpO/R8bLYQg5yAU5jRwNrP8eXW/cUp0DllIzIifU9GCriee5IBjW
         Ypm1aPtn8Cp51HbneyGEt3vFPtd6SuZVL307F7nzEGNlVfzN2HAAgDzM2hW1IxoSv06x
         o9/KHjv6L2eb6pXKL+9GrO8J9DAmiovqybKXRMncozsduSZjfgQkoVWPl3dgYtfnnkq+
         +HmVelZziATaOJL4YOY75M8lUWEU5J7hkiLcjbZCaGb1wAVCYw6zZWj2eOgnSuxU/b8e
         iR7jVPRhkAxYkTsqZLwVV+ekQ4LZGp+pNd7eLyu0Ff0T91WoeEpNCbFdyxbMhcCyos8Q
         Vwog==
X-Gm-Message-State: AOAM533e35ElP7PshzPCwdhFB3zWn4QZrD4PX6p4Er+LNXLjddY+5UzT
        QVZlYLdirArdOjY0y1yFnZwv/qvbaZc3rcblsIU=
X-Google-Smtp-Source: ABdhPJz3ZBqmpiFWJOlzVmrCIbQd4Uj5roInmoXt9EOGM5CXYkk/QNEj0qVukX8dSCoOJSzJbXJgzqOut67ZTCagrQQ=
X-Received: by 2002:a05:6808:2108:: with SMTP id r8mr23111720oiw.118.1636377580948;
 Mon, 08 Nov 2021 05:19:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
 <YYkWb4GQAAtZJNsT@kroah.com> <CAHP4M8W2H4V=qgAeVp76GwfVUBzR3erZxJiuhm6jnyMo+gvknQ@mail.gmail.com>
 <YYkfqH5wK3K/XaGQ@kroah.com>
In-Reply-To: <YYkfqH5wK3K/XaGQ@kroah.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 18:49:29 +0530
Message-ID: <CAHP4M8UE1DLXfwm8mYMwux_b+_v8F9SF=QE8KVDNheyR9nT6Ww@mail.gmail.com>
Subject: Re: RFC for a new string-copy function, using mixtures of strlcpy and strscpy
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     andy@kernel.org, Kees Cook <keescook@chromium.org>,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 8, 2021 at 6:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 08, 2021 at 06:15:54PM +0530, Ajay Garg wrote:
> > Hi Greg,
> >
> > Thanks for your time.
> >
> > >
> > > Wait, why?  We have recently added new string copy functions to resolve
> > > the type of issues you have pointed out.  The kernel is not yet
> > > converted to use them, so why add yet-another-function that also is not
> > > used?
> >
> > Greg, would request your couple of minutes more, in suggesting a
> > concrete way forward, by working through an example as below.
> >
> >
> > In the file fs/kernfs/dir.c, there is a statement
> >
> >         return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
> >
> > Here, there is no information of how long kn->name might be, so there
> > is a definite chance of overflow happening. Thus, accordingly, strlcpy
> > is used, to bound copying of upto buflen bytes. Of course, buf
> > (destination-buffer) is safe from any overflow now.
>
> We "know" that kn->name will not overflow here based on the callers of
> this function, right?  I can not find any caller that passes in a buffer
> that would overflow, or am I missing a callpath somewhere?
>
> > However, iffff strlen(kn->name) is greater than (buflen - 1), then
> > strlcpy would return a different value than the number of bytes
> > actually copied. Since there is no check, this (wrong) return value
> > will be propagated to the clients down the stack.
>
> But in the existing kernel, can that happen today?  I can't find any
> caller that would be using this in that manner.
>
> And that's what matters.  Not the theoretical callers in the possible
> future, but the in-kernel users of the functions today.
>
> If these calls are wrong, then they should be fixed, but adding another
> string function to the heap of ones we have should only be done after
> considering the ones that we currently have, why they were added, and
> why existing code has not yet been converted to use them.
>

Got it, thanks Greg !


Thanks and Regards,
Ajay
