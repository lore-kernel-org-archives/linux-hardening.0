Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADF6C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 12 Feb 2022 11:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiBLLYL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 12 Feb 2022 06:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiBLLYK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 12 Feb 2022 06:24:10 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588026553
        for <linux-hardening@vger.kernel.org>; Sat, 12 Feb 2022 03:24:07 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t199so12360755oie.10
        for <linux-hardening@vger.kernel.org>; Sat, 12 Feb 2022 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gxid+VMOks+Z278B3ciU0dNskRK6ktKfaLZmB1Olmd4=;
        b=Qb939wlv4CKlAJ6xVeF8t1o3QQMoZ897DgNU2HRBmPOLq3lYk4thq8Mo0xjNEWQ5Rl
         xYE0rfcoBeo4i1vKD6mlDF9NhgT9O2ZladUn8mf7uRzEGWKCecJ5Hm6YgEZCl+MtMOXx
         5AlWl0A/TKfY6dlLWgFGqNbbc3q5gZm26MNm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gxid+VMOks+Z278B3ciU0dNskRK6ktKfaLZmB1Olmd4=;
        b=wRLpCqsqJ5SmV6y5hoi+nrHlgX598vlM9tznPdAUExPFztWZBx1AUlmlPXdFo/yd/f
         YU+q1unifY3mssnXDjwww6Lue8NA1OIRZKVDYA1aNtKglgBrnrQvm5jhIxv6Ly1XO4l1
         xFn0OrJ8cIo7w4153vEpZkSvhmm/Xn5+gjjJjy54Rqa5JTo93IcIIf/qzHIR4exYWA/L
         ofcT8aP/7D5f89Ah1b9DcfPCCb0rT8/u7BenZeDGSNI9IUnhvBn2MjgEJyu8G2orwCEY
         Cfb3bm/7FCD9K0O9ZkFqvLLJr6+V3g/px84Q1oM1CnGIcl2ZB+6+JQAb7ihg68zr/mJH
         5DAQ==
X-Gm-Message-State: AOAM532KHKha+08GRQZ5qwJ4xqIFUTmiXGoxa/F7v2IY/Hks3r3t6z8X
        +OaYz7tmTGJ6LM1poajcKkTooYZSp7a1vaa4B6VlEA==
X-Google-Smtp-Source: ABdhPJzGrnzJadnmXKM7XSlQ5XNFMUGbUZMnE1w9kzaG+mj8orByLRg8I4TFVFeTU5GnD9nwXyi5zQ8pinUTzLRQXmk=
X-Received: by 2002:a05:6808:19a5:: with SMTP id bj37mr2189889oib.243.1644665046278;
 Sat, 12 Feb 2022 03:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20220212042843.2993537-1-keescook@chromium.org>
In-Reply-To: <20220212042843.2993537-1-keescook@chromium.org>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Sat, 12 Feb 2022 12:23:55 +0100
Message-ID: <CAP145phC6S6Zda-ZWLH1s4ZfDPh79rtf_7vzs-yvt1vykUCP4A@mail.gmail.com>
Subject: Re: [RFC] Get siginfo from unreaped task
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

sob., 12 lut 2022 o 05:28 Kees Cook <keescook@chromium.org> napisa=C5=82(a)=
:
>
> Make siginfo available through PTRACE_GETSIGINFO after process death,
> without needing to have already used PTRACE_ATTACH. Uses 48 more bytes
> in task_struct, though I bet there might be somewhere else we could
> stash a copy of it?

An alternative way of accessing this info could be abusing the
waitid() interface, with some additional, custom to Linux, flag

waitid(P_ALL, 0, &si, __WCHILDSIGINFO);

which would change what is put into si.

But maybe ptrace() is better, because it's mostly incompatible with
other OSes anyway on the behavior/flag level, while waitd() seems to
be POSIX/BSD standard, even if Linux specifies some additional flags.

--=20
Robert =C5=9Awi=C4=99cki
