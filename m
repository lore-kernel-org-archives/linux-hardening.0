Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DC7C388F9
	for <linux-hardening@archiver.kernel.org>; Sat, 21 Nov 2020 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6B422226
	for <linux-hardening@archiver.kernel.org>; Sat, 21 Nov 2020 12:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDWVGPy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgKUMew (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 21 Nov 2020 07:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgKUMev (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 21 Nov 2020 07:34:51 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2619CC0613CF;
        Sat, 21 Nov 2020 04:34:51 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y24so5897464otk.3;
        Sat, 21 Nov 2020 04:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFs8DcA7BTn3eJDn4alHdT9ItsgYx3VRwqAdzyG6ZGA=;
        b=HDWVGPy2VqZkxVV49/4NQN9UjguuJiGyUtIxgH7WlZce2gZc7ooKmy2j6b/wvCW59N
         36tnj1slQC/GC+SghyD8XqlGXEXRRrkOWS/uf6qWl5w8aloPMjl8B2fvqm14cltfEWdP
         U0YP7coKv+rl11jXaWy3SmmzYDZ+TkDo8BWEOevSooVUyP6mnAVflUwRhN8Pd7B8AS5b
         3fvllXlhZg5Di8pETTeMDfJf99gVicCPiOgJqhE9WL2wTsO/Z/yKbtWgutkgFVUEIVMe
         oGQKkGDoDMTrh+ohzcoz8XYnQQ3OoqPNTscfRJQ/Q+cUYBk+uSGf9Pwip0oz1iUI0+Zy
         m4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFs8DcA7BTn3eJDn4alHdT9ItsgYx3VRwqAdzyG6ZGA=;
        b=iG6jZFgQk9GRf2HQEMPtgapkNiRNCGKLNpjsohKqlQ/RATh2Og/tGD+n238YtzvWKa
         KGnFSjZs4WGoaqU0cU/Tu/pc7LTTeahJRVvnCHMSWpZwGhKTjMly9TE5OhbJcrPyqaye
         8bKCSd7zITCJT8KKWqj3dy18igs12LS7ScFtt7jms1oLIcCkiiUhQLq9dTvnF1C3Nfvu
         NxBZfz7OgeKxLoLg07CYlPpzf6BWaDg9OWNBTpE68BSWBtZHe93sVvIxv+6eTqHxf5jT
         49W+GVFajLcMxEh4hu9Daz4a8sb+0a+UDXHxTVrf6rE1JCSBYGcqT3nALQtuIZMgyESo
         hYTg==
X-Gm-Message-State: AOAM533AUOU6aSlfCPNG/vmJYi+4hfEGI/PK+nwL789qiQvPLaLPJu0s
        yyo/cH2XQeTSU9ncVuPpgvNUuY6vh3ioC43TJF4=
X-Google-Smtp-Source: ABdhPJziLUYNIi2uSYeBHOd3YCYahQTUik2qV+et/tVjQ9fRLGw2nFaGV4kqX+GJ1O/d43MdbKy94GVOR62L1CFFRxU=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr16845585otc.145.1605962090469;
 Sat, 21 Nov 2020 04:34:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <34c177585dfd5c6dc3e101ec8f11e4733b7fd11a.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <34c177585dfd5c6dc3e101ec8f11e4733b7fd11a.1605896059.git.gustavoars@kernel.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 21 Nov 2020 14:34:23 +0200
Message-ID: <CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com>
Subject: Re: [PATCH 060/141] habanalabs: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 8:33 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a fallthrough pseudo-keyword instead of letting the
> code fall through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 2519a34e25b7..eab4c0dc65c5 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -5436,6 +5436,7 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
>                 params.num_memories = 33;
>                 params.derr = true;
>                 params.disable_clock_gating = true;
> +               fallthrough;
>         default:
>                 return;
>         }
> --
> 2.27.0
>
Hi Gustavo,
So this is actually an error in the code, there shouldn't be a
fallthrough there.
So NAK for this patch, I'll have to send a fix for that.
Thanks for catching this :)

Oded
