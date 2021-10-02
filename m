Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA679C433F5
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 16:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9B561425
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 16:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhJBQ3A (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 2 Oct 2021 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhJBQ3A (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 2 Oct 2021 12:29:00 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC55C0613EC;
        Sat,  2 Oct 2021 09:27:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r75so15277575iod.7;
        Sat, 02 Oct 2021 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vd+gTZwolgcCYNprrURY6Og3fy+5eYa5b4XVVJG/2QE=;
        b=o5fhWcKmht8xoMVSBgIwpxCx+YGRwbIeOsXFkbCWKiy10keg2Cu43Mh7aYr7Cn8rus
         WER83mWeztZiqvVzGW9R21HLAX2gYFJulGrY9sPoWz6lWKzebHEpxr9lI84nzhTKrK/O
         3UDvZHwjjDClG4aALZsMaKFNETlm8uCvkIp+QiDSQ5jSJf6m9mGErrbRD2J+Czcs/TSM
         zDr24oK4v7Jg2kFWUSX2eoKddf7l6X8RqbhqGTQbAuhW3nFDYM56zVliAnFXSI4SihL/
         IxTvF5NFWeRcf3YaLmLu8UiFWwFV5xsulgMPjAsGx7C17647T5Y1Q87P3/M2xXeNJjLU
         CoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vd+gTZwolgcCYNprrURY6Og3fy+5eYa5b4XVVJG/2QE=;
        b=UxLfpMuLmm9ynHC61OHODJHVxMhE0k9xvT61lD6q12bPcQi9kXL3XejY5zqzVLXqIN
         MvVXsDyw5DorbidetE5A2rXXXauHzuTkqYvWSdaWOhHrLfg6EYk3RdAqrufMfUV0TKwI
         hhNbezB6RyRKpRgCIvIULPZAC6rFHDd2SZj9EpX4MB/S2I/wgwJ0IQ+gjHMfZpRioIkQ
         cANUQIMnrSwsz7MY8xs3Ah/sOcxLHnwGE0OEFCqC4KPc9JzM4a5yy7P863kxIRarbYe1
         7TQQrtw242BWIAeWOGKp1HZUum+06q3m7wXR9zRGe/YaTN/SeBKdcgAK2UA+Q1+c9cK/
         cjmw==
X-Gm-Message-State: AOAM532+MgLuCxJ1s8eezuJIhzgxkZ5R6FLZfApZ8LY2zJMo5xbK9e7i
        OM1o4jPXheDycudkhm+JAMZPHDlx0P5TOqi3IoJK2VXJ3jpvl8P6ilk=
X-Google-Smtp-Source: ABdhPJzyRUDP3QBgjDmsYwv+5cTa+DybnD8O7sIBKNMVWYP7phxkZm32TpmnOh1j9vJ23XqGKaeaxBw5e1WkQe8Q0Ho=
X-Received: by 2002:a05:6638:14d0:: with SMTP id l16mr3382380jak.142.1633192033477;
 Sat, 02 Oct 2021 09:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210930235754.2635912-1-keescook@chromium.org>
 <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
 <YVf80rXg8Yd19Hmw@kroah.com> <9f262a81acffffb6e267d5832b29d8596d8046e2.camel@perches.com>
In-Reply-To: <9f262a81acffffb6e267d5832b29d8596d8046e2.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 2 Oct 2021 18:27:02 +0200
Message-ID: <CANiq72m7gRxNmHUJb9jJ+JMiYHyMuNf6Yc1+7N87yz_RLc3atA@mail.gmail.com>
Subject: Re: [PATCH v4] docs: Explain the desired position of function attributes
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 2, 2021 at 5:22 PM Joe Perches <joe@perches.com> wrote:
>
> If automated scripts exist to change all the code to that new
> 'one true way', it wouldn't be applied.

I think nobody is saying we should reformat all code at once, just
that agreeing on a given style allows us to eventually automate it (it
also makes humans more likely to be consistent).

> Try writing a regex for the proposal and make sure to separate out
> all the various __<foo> attributes into their proper locations...

It does not need to be a regex...

Cheers,
Miguel
