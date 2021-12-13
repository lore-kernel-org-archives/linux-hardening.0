Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED6EC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 13:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbhLMNyT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 08:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhLMNyT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 08:54:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46686C061574
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 05:54:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0AF9B80EC1
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 13:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93027C34602
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639403656;
        bh=UaGChbXAvxs5XfH4yX3u3Nh9h6RmDa0yGal7bOYVp+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M3cm9TzQreAXNjwp+g5N14Dd4OSTKPhMe9MmF+mPvPAyWLkTC7ggc1Km7SabJ7627
         gj1g3BqWX8lK6NYiRlRTEsdoleyH8zqQYIynEUuCBG6ctZJPZ7jps369eBu1l/eQ9c
         8AqbnZiYBoquYsTgBrQktI5Gc2BiAsMbNg0ZIqr9FMgRu/6r5J3mI9uNhkqlw8Ju0I
         XsLivcFXEPewVC0PTC/PrxMcVF7Dezdq5Y+lLZNUevipS6Ex3rVwB/33u26P6MVTbD
         nT/Rv8oU8b5BA3brSUJBW+qFD0057fzJKyH8W515fZWRUkmL315ZXXev4gNv7w+V+T
         7xj/gipmKXplg==
Received: by mail-ot1-f51.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so17472093otj.7
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 05:54:16 -0800 (PST)
X-Gm-Message-State: AOAM530lQvrxpy1tvcJ2qV3J3KXmUPmJJXAYTqKE1XPJHadv2d8eYreN
        wnvhUwnScNpujjJ0RaLb9oB8linOz5qpjjK1m28=
X-Google-Smtp-Source: ABdhPJyiRlXYrxvlL1OZsFzm5NzrQs4xQE/QJja7avhQwE5HkZcYZiWoJqw3mJoZ5pU/fRvw/eaVUbts10GHGsSKSF8=
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr24538052otp.147.1639403655843;
 Mon, 13 Dec 2021 05:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20211028112703.1120709-1-ardb@kernel.org> <20211028112703.1120709-2-ardb@kernel.org>
 <B1E5C5B0-C135-4518-80B2-CB4544C246F0@oracle.com> <CAMj1kXEkcTzhvUG0Y7XQoeny+WFcANt6KwZPmziRT4SoY6F2XQ@mail.gmail.com>
 <PAXPR08MB7172910A0629F9A7CC0DB8A7819A9@PAXPR08MB7172.eurprd08.prod.outlook.com>
In-Reply-To: <PAXPR08MB7172910A0629F9A7CC0DB8A7819A9@PAXPR08MB7172.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Dec 2021 14:54:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHX0C8d_FYDTZ4biCpEyvn-Z33B6vx2DmH6ePa-R5N72w@mail.gmail.com>
Message-ID: <CAMj1kXHX0C8d_FYDTZ4biCpEyvn-Z33B6vx2DmH6ePa-R5N72w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] [ARM] Add support for TLS register based stack
 protector canary access
To:     Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>
Cc:     Qing Zhao <qing.zhao@oracle.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        kees Cook <keescook@chromium.org>,
        Keith Packard <keithpac@amazon.com>,
        "thomas.preudhomme@celest.fr" <thomas.preudhomme@celest.fr>,
        "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
        Richard Sandiford <Richard.Sandiford@arm.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 17 Nov 2021 at 10:09, Ramana Radhakrishnan
<Ramana.Radhakrishnan@arm.com> wrote:
>
> Thanks Ard and Qing.
>
>
>
> I have been busy with other things in the last few weeks and I don=E2=80=
=99t work on GCC as part of my day job : however I=E2=80=99ll try to find s=
ome time to review this patch set in the coming days.
>
>

Hello Ramana,

Please let us know if you will be able to spend time on this. I fully
understand if not, as you moved on quite a while ago, but in that
case, let's just own up to it, and I will go and badger someone else
to get this reviewed :-)

--=20
Ard.
