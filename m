Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC1C61DA4
	for <linux-hardening@archiver.kernel.org>; Wed, 22 Feb 2023 13:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBVNPG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 22 Feb 2023 08:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBVNPF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 22 Feb 2023 08:15:05 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC0C38EB1
        for <linux-hardening@vger.kernel.org>; Wed, 22 Feb 2023 05:15:00 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s5so8623107plg.0
        for <linux-hardening@vger.kernel.org>; Wed, 22 Feb 2023 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LXwDDYUk3+Q4/nNJtasmLY4w5AET06sCuMInR3j34Fk=;
        b=WVUUpyjOVVsoYXGoEZoyfG1Mdqsy+Exa2PxS+69m0zj35qS5THqNyXOfJtB0m5eCY+
         dGp0oHsLLr2vWjikDNF2/YRZNgBg5aRPV3dpW2KdjaOsK7E7UHpBcaDjWA9JYyJS7YA9
         2kIyhkYv8OqfnXcY2sXz+p/qhUSkiOqKu4jTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXwDDYUk3+Q4/nNJtasmLY4w5AET06sCuMInR3j34Fk=;
        b=G6+bJDe7pw/vaOYxBW0pMv6vb5HMvxKty6QmNI6xWqKQSaBgLSK8REsEDjZLK89kv3
         dXjzV/AUkMjzpYiE/UTDfuEiTZjTwswh5kEqGEH4Sxa//M+oD8kFZk8eNFUv06D3pYSg
         ResU5zkk/mpCdaLRkr1zckNDUStPIPpjLUZGG199vI/LAqP5/KKTNPMJwnPUw2iLfiKV
         oDs5Wt1sfRoobqPEICxt8f7w4akHJ3MPvh5VYFkMXihBiE2qzDjxlaVmXptheL7tFlsQ
         FSw2tGc4rRRr55TpIXNC58qSv8uhtJBfytmbD++uOKCERwNOz/wPJtfWLhWMjifvug+b
         idmA==
X-Gm-Message-State: AO0yUKWcDNYzFjMlPHweihHMtNN49N057VCe29rt3OUKJnTvjOtVxFqM
        SQ8V0JbIldZ/7o00NuJ1iLh8wiQhCUhJc18h
X-Google-Smtp-Source: AK7set+/kAGFeha6fO9xEtDl51OPabKT5NnW64s3FTBI2gKlsNI6jh9nS/daKn10XR5KU851KoqwEA==
X-Received: by 2002:a17:903:18c:b0:199:4934:9d31 with SMTP id z12-20020a170903018c00b0019949349d31mr12023623plg.20.1677071699955;
        Wed, 22 Feb 2023 05:14:59 -0800 (PST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b0019aa7d89f06sm1643494plb.30.2023.02.22.05.14.58
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 05:14:58 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id cb13so4383583pfb.5
        for <linux-hardening@vger.kernel.org>; Wed, 22 Feb 2023 05:14:58 -0800 (PST)
X-Received: by 2002:a62:c143:0:b0:593:d4cb:dba2 with SMTP id
 i64-20020a62c143000000b00593d4cbdba2mr1125866pfg.13.1677071697448; Wed, 22
 Feb 2023 05:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20230106061659.never.817-kees@kernel.org> <CANiDSCtTz4mpTz4RHBzNXL=yBvXNXHBZQ-HYMFegLytoScW4eA@mail.gmail.com>
 <202301061217.816FC0313D@keescook> <Y7jODnbUqCwfwwHI@pendragon.ideasonboard.com>
 <CANiDSCvB8vRp43A1J4BpNZveCvG66XbDmnkKZykbWSFCLX1XUQ@mail.gmail.com> <Y+LLeYF7CtLjeLbt@smile.fi.intel.com>
In-Reply-To: <Y+LLeYF7CtLjeLbt@smile.fi.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Feb 2023 14:14:46 +0100
X-Gmail-Original-Message-ID: <CANiDSCtjX6+xZn=YkSfqY8xTi7e=OZWbUNtuJ_d=OreFbrgaog@mail.gmail.com>
Message-ID: <CANiDSCtjX6+xZn=YkSfqY8xTi7e=OZWbUNtuJ_d=OreFbrgaog@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Silence memcpy() run-time false positive warnings
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <keescook@chromium.org>, ionut_n2001@yahoo.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Andy

On Tue, 7 Feb 2023 at 23:07, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Jan 09, 2023 at 11:46:00AM +0100, Ricardo Ribalda wrote:
> > Hi Laurent
> >
> > I was thinking about something on the line of the attached patch,
> >
> > uvc_frame_header->data could also be replaced with a union.
> >
> > Warning, not tested ;)
>
> ...
>
> > +struct uvc_frame_header {
> > +     u8 length;
> > +     u8 flags;
> > +     u8 data[];
> > +} __packed;
>
> __packed! (See below)
>
> ...
>
> > +             pts = (u32 *) header->data;
>
> Ai-ai-ai.
> Here is just a yellow flag...
>
> ...
>
> >       uvc_dbg(stream->dev, FRAME,
> >               "%s(): t-sys %lluns, SOF %u, len %u, flags 0x%x, PTS %u, STC %u frame SOF %u\n",
> >               __func__, ktime_to_ns(time), meta->sof, meta->length,
> >               meta->flags,
> > +             has_pts ? *pts : 0,
>
> ...and here is a red flag. What you need to have is

Thanks! you are absolutely right :)

Luckily  Laurent merged the original patch not mine.

Regards!

>
>         void *pts;
>         u32 pts_val;
>
>         pts_val = get_unaligned_be32(); // or le32
>
>         ...use pts_val...
>
> > +             has_scr ? scr->scr : 0,
> > +             has_scr ? scr->frame_sof & 0x7ff : 0);
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


-- 
Ricardo Ribalda
