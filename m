Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95780C678D4
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Mar 2023 10:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjCFK3P (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Mar 2023 05:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjCFK3A (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Mar 2023 05:29:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2CF241DD
        for <linux-hardening@vger.kernel.org>; Mon,  6 Mar 2023 02:28:18 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q16so8252060wrw.2
        for <linux-hardening@vger.kernel.org>; Mon, 06 Mar 2023 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678098497;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3in9f13xjPJT3kBj1w72UaWNqgeqxz2FwBddyfdkzw=;
        b=E1pI9HLxFWOS1zPEq4c9/bH7mCWZz7sv4HCfgVyK2srFmZPjfEtvVqI8UGGtXykI/U
         ELrmASh3/Jgb6HysFcGq2QLFBQQ+916eixGp07A2f0FDq033qRydj0KuZUs7c4FBIeKD
         pPcnjWvzygOQyx5eidSGf5trUj6OTBd0kcZyzrhf8fN2iDg+8Apb3VZZAK3NYbybZ9An
         qjx6m7JWgSNKyuI+throiVPqus/DMzz7lghB70wI9LS9PfP6JR7WpjMbgAz+lNmCUS2n
         yYJlQBmOMhqUh4w78thmzPk3RhG7MKrnKbcetwgMlEkK+3rZdSNgV3goPZuzoadDxGn4
         43jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098497;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3in9f13xjPJT3kBj1w72UaWNqgeqxz2FwBddyfdkzw=;
        b=yQ1k3nIjahvSruo4hfQEbsszSb1A486G7/hjuL1FfHMbemUUG3rGbubJAiwxQ8P9rQ
         RCF2NBX3en6Y85AaDZatAy+DA0b5NyXsKRpUtcxUc56DQ4b5U1JjNrUcUZXMJx1hGF03
         Kj73bCojTK8nyYyhye4VEk+Jix8yKNkrtcw4ax9dWegTp7BMSh+6Gq+/UQttKlC5ztaO
         FGcLXmvh9v5KC2Tzyb7ncJICH8QxvkC4edG+ZApLSY3Ee+xx3JnCLDtpr1RNIvoKYbdN
         EiccMMGi4KPfuSB8y2WImyYm7NLb+sOJ0s3Bpxs6WCcxhsnighVx82yVWWyEEhP2HCE+
         tCzg==
X-Gm-Message-State: AO0yUKW4ckLKqQOIGJuVtsAhGvholBSDejOU/Ldta18DnkkDQGw1Fw7G
        B52Ez1tDlO0rRnOGQA0NAvCoiVkK2HTD/avXord/EA==
X-Google-Smtp-Source: AK7set/Vh8yXTuqwFKQcFeNxAv2OZHE75dyFNoLp9vbJV5afqFrU117ZU7T59Px7caOaQe6/iqbWWyjBSsdvu5ygoTU=
X-Received: by 2002:adf:db0f:0:b0:2c7:1745:77ec with SMTP id
 s15-20020adfdb0f000000b002c7174577ecmr2221397wri.2.1678098497020; Mon, 06 Mar
 2023 02:28:17 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001d1fb505f605c295@google.com> <64026f89.170a0220.7940.49ff@mx.google.com>
 <20230305175457.kp6b5lmwwdxw4ii6@begin>
In-Reply-To: <20230305175457.kp6b5lmwwdxw4ii6@begin>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 6 Mar 2023 11:28:04 +0100
Message-ID: <CANp29Y4dNRuu1u8Dz+eXhi2NJ=MsN5wfCr1h9sJ73o25Of63Ww@mail.gmail.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in con_font_op
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <keescook@chromium.org>,
        syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Samuel,

On Mon, Mar 6, 2023 at 8:36=E2=80=AFAM Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The patch below should be fixing it, could you check?
>
> I don't know how I am supposed to properly reference the syzbot report
> etc., could somebody used to the process handle submitting the fix?

As Jiri Slaby correctly said above, you just need to add the
`Reported-by` tag from the syzbot bug report to your patch so that the
bot can recognize the fix later.

If you just want syzbot to check whether the reproducer still triggers
the bug after your changes, you can send an email with the `syz test`
command and the raw diff patch. Here are the instructions:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patc=
hes
and here are many examples:
https://groups.google.com/g/syzkaller-bugs/search?q=3D%22%23syz%20test%22

--
Aleksandr
