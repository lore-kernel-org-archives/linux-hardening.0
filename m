Return-Path: <SRS0=kTaS=D7=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5063BC2D0A3
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9B0207BB
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzmyyaMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761920AbgJXOMs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Oct 2020 10:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759741AbgJXOMs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Oct 2020 10:12:48 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1757C0613CE;
        Sat, 24 Oct 2020 07:12:47 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z2so4132841ilh.11;
        Sat, 24 Oct 2020 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgJfeca/4s0satLk61+xOaVoEfLF7ds/Hi2JJEDziWU=;
        b=IzmyyaMKU2FOSHtQEv29DmMZ//m10onETt/WtXiLJiW/9Niiew7CKHOfdD0QD+iq0r
         g8ZU06WwFvjWtyJQhXFsnF/6x0Gm/ir3FAprI+07pbGtdb+FeM7MmjKdUOrn/ta+hCNz
         bELE3uPLlHqPSdnAfUdnmX6qg+RIoMep0UXSZZxA8ysv+nAeLrtlgclER3WEPFILvFpK
         nAvM6vXz4BVY0iErk77oeVia6Uo8SaaH0O7ljraTkjq0j/LMPpiKgvtBDxCYJ2xBOvsr
         lta/5kNNzxFL4BTXBv86WYLJt6KSo/Rki35Gkyce0gLg8q7gCcWN/7Xk8s9pROJmjw0C
         j2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgJfeca/4s0satLk61+xOaVoEfLF7ds/Hi2JJEDziWU=;
        b=h6Mnb00TalYWmkLjYuTfTBOy6nTqZ59FNkUkXtbWrrCio++eGUKgK0OCVDW6DyDy/z
         rDpZBqccYqcyOcs9sDSd+LMIofHp9GPjlOnRM7K7LV0pKxxvL5iYbAamCV3Ff2cDHzYX
         6hkjtqkxeQc9JigO1XqsmzzpCAXSSCesZIgxb46rtuxbUQ+h6Fx7OJRPqHp7G7U5ZX1U
         BYmLuphzYP1vMXva058KgJNOEAu4zL6uEOfEf/Vt6hcsXlbKCDsMWBp+D62i8l3XLZJD
         qTOIlyJM+8ZBHHFdHnQ90cLAkzUwuQXL8zhoCODVnIEcVZnoUqcAPBDuYt+vVRd+EeDR
         v1TQ==
X-Gm-Message-State: AOAM5327aqNlE43vLR4iRBsGEIupwKW0mNMqqBpKq/BUAmiUEpcKOLmF
        GDINdwnAqxYXa50R4EKBsuEEd55/hM67YiGjxZA=
X-Google-Smtp-Source: ABdhPJxALtvx3WMpnAnGGl1WqPBhdzP0ukYGoUEMsX7+QBgav0+412nekJGtwDyIlYZt5kvFXudvUAnQw7PTyzqFPh4=
X-Received: by 2002:a05:6e02:d01:: with SMTP id g1mr4895628ilj.246.1603548767191;
 Sat, 24 Oct 2020 07:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com> <20201022075447.GO3819@arm.com>
 <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com> <202010221256.A4F95FD11@keescook>
 <180cd894-d42d-2bdb-093c-b5360b0ecb1e@gmail.com> <CAJHCu1Jrtx=OVEiTVwPJg7CxRkV83tS=HsYeLoAGRf_tgYq_iQ@mail.gmail.com>
 <3cb894d4-049f-aa25-4450-d1df36a1b92e@gmail.com>
In-Reply-To: <3cb894d4-049f-aa25-4450-d1df36a1b92e@gmail.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sat, 24 Oct 2020 15:12:36 +0100
Message-ID: <CAJHCu1JskXZTvSsspQD-wk4L59FxesvVJdjMSX=jiHg-R2zCuQ@mail.gmail.com>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 24 Oct 2020 at 12:34, Topi Miettinen <toiwoton@gmail.com> wrote:
>
> On 23.10.2020 20.52, Salvatore Mesoraca wrote:
> > Hi,
> >
> > On Thu, 22 Oct 2020 at 23:24, Topi Miettinen <toiwoton@gmail.com> wrote:
> >> SARA looks interesting. What is missing is a prctl() to enable all W^X
> >> protections irrevocably for the current process, then systemd could
> >> enable it for services with MemoryDenyWriteExecute=yes.
> >
> > SARA actually has a procattr[0] interface to do just that.
> > There is also a library[1] to help using it.
>
> That means that /proc has to be available and writable at that point, so
> setting up procattrs has to be done before mount namespaces are set up.
> In general, it would be nice for sandboxing facilities in kernel if
> there would be a way to start enforcing restrictions only at next
> execve(), like setexeccon() for SELinux and aa_change_onexec() for
> AppArmor. Otherwise the exact order of setting up various sandboxing
> options can be very tricky to arrange correctly, since each option may
> have a subtle effect to the sandboxing features enabled later. In case
> of SARA, the operations done between shuffling the mount namespace and
> before execve() shouldn't be affected so it isn't important. Even if it
> did (a new sandboxing feature in the future would need trampolines or
> JIT code generation), maybe the procattr file could be opened early but
> it could be written closer to execve().

A new "apply on exec" procattr file seems reasonable and relatively easy to add.
As Kees pointed out, the main obstacle here is the fact that SARA is
not upstream :(

Salvatore
