Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFA7C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Feb 2022 18:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiBKS5V (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Feb 2022 13:57:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiBKS5U (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Feb 2022 13:57:20 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E4CE7
        for <linux-hardening@vger.kernel.org>; Fri, 11 Feb 2022 10:57:13 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so11453703oot.4
        for <linux-hardening@vger.kernel.org>; Fri, 11 Feb 2022 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QMVVkjMchB0s/a3beZw7NTzCf3sxBDL51mOIwpD203k=;
        b=GL0LgTUPusm/gXkWe5cb3RI71yed94r1V7/qjDQ2WB6QNQIkXk8wGM/c2r+tDbObeS
         yoYbBNf4fLZcJ7ByIgwTdWh+ACR0LlvA5ZPobiyqBjhSWZUUA5MIUr+RDFjfz17N3Scn
         l2GOKYbrL6ySj2J6Hk9571DTGIx3PDMLrB8Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QMVVkjMchB0s/a3beZw7NTzCf3sxBDL51mOIwpD203k=;
        b=3FhIq8KCf+SOJHrU3DFoxW1pa8X5+Ke36Mvb7CzKbsHpWNm6ZcUewu7LyuC3d/Oll2
         LKY+4VWfVQ6SIjW4FjICT+gtFOZqb5Hrm+38Xv+PTCAmSG/XLo2qe/a4DqTXOWIH3vQR
         2dKmUbsOn3VuKTSMtKeLZe8EWe/KGVv2gHDxBOdLJ057aUvmdMqM4V7EqVMXEk2PlpkI
         ue7N49T7asg2cVQyPeyV/WKA23fLO1y9SGfDDuI7ymqoMDvihPhbLx/cnuKk8oUGJ0jH
         0tUkJnXDZl9vZGejwb4A0gWg+IsHNR9KxiOzwvXu145+JGZcu4NLjxK4/3h3ANuU10Tk
         rmRA==
X-Gm-Message-State: AOAM530kF1sI3+wxfXRPHRvGpNM0Vur4+Hv7UD4M3TCmkNqzdEp5gdZp
        RCbWmHhslb3mRQzyF5H45hPABcj2q96SOo+IllPNeg==
X-Google-Smtp-Source: ABdhPJyeJ0HVhp1BgrMDOgkHBZ7gDWNotH68ktkbcwoEd65AcEAuS2movuRDZXQrAsACs06cFH4u+eku+T90vkCEqN0=
X-Received: by 2002:a05:6870:3906:: with SMTP id b6mr581232oap.83.1644605833197;
 Fri, 11 Feb 2022 10:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20220210025321.787113-1-keescook@chromium.org>
 <871r0a8u29.fsf@email.froward.int.ebiederm.org> <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org> <202202101137.B48D02138@keescook>
 <87k0e249tt.fsf@email.froward.int.ebiederm.org> <202202101710.668EDCDC@keescook>
 <875ypm41kb.fsf@email.froward.int.ebiederm.org> <202202101827.4B16DF54@keescook>
 <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com> <87a6ex1ek2.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87a6ex1ek2.fsf@email.froward.int.ebiederm.org>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Fri, 11 Feb 2022 19:57:02 +0100
Message-ID: <CAP145pii+zCyoQBw778P-Jw9YSOWhQEgB7OTHUaRwfGy7BYWCA@mail.gmail.com>
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

pt., 11 lut 2022 o 18:47 Eric W. Biederman <ebiederm@xmission.com> napisa=
=C5=82(a):

> > I think it'd be good to have some way of doing it from the perspective
> > of a parent process - it'd simplify development of sandboxing managers
> > (eg nsjail, minijail, firejail), and creation of good seccomp
> > policies.
>
> By development do you mean debugging sandbox managers?  Or do you mean
> something that sandbox managers can use on a routine basis?

On a routine basis for 2 purposes

a). development of seccomp policies - the manager (regular parent of
sandboxed process) can tell which syscall (and arguments) failed and
it can be then added to policy (though, 'strace -f -c' might be a
better option here)
b). in case of actual seccomp SIGSYS kill, it could then inform users
about what exactly and where happened (syscall no, cpu arch,
arguments, maybe also eip + stack ptr)

But, I don't want to derail the current bug fixing effort, so I just
wanted to mention all of this quickly, and maybe we can follow up on
this in the future.
