Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05358C0015E
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Aug 2023 23:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjHAXC1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHAXC0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Aug 2023 19:02:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEB21FCB
        for <linux-hardening@vger.kernel.org>; Tue,  1 Aug 2023 16:02:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso28231265e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 01 Aug 2023 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1690930944; x=1691535744;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiGr6RseLN//FLKBr95vV+LBX/ZbUD8quF/4QlFb37Y=;
        b=dsZm6jk7cno+vap3O9XWb4T6aTUIHR5BPs8Yl5G0uuTns5GkM5M9r/xyPKq24OmtqT
         sL0hDjxr86Psu30p+caJWGwnCEe5TlaoRFPCjzIXLYljU0/WkVZpiSttoBddIPLt1r6l
         38ETeBejgcLVYRJKo3Kijzq9WglSr0FK4F9WItQN9sxNxE/TVvOomiqbULu+bWJBrzOm
         dVmpcegdqRjIswEjNpzNN65hjF5NYrKwOinMrsvZNS/sTgsXZTiedOb7AFV+QMMR/0fW
         4/XNVhRuPBwayErpZuS3TFsugis5e+D1tDR4JSJRWGDejW3A4wXpJqSPYVM/8qKSUlz2
         rqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690930944; x=1691535744;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiGr6RseLN//FLKBr95vV+LBX/ZbUD8quF/4QlFb37Y=;
        b=Ec9a0ESMbW1jhJ6mRdnK+nmy9xGV0EJqQ0v0c5KISPXgbQmzFIV2f9FjNi2Hq+jkr4
         X9SFWxYNE/LQnO1OJ+VRUj67BmTJNV3mkGW9DqJX08KUXFR5KFaZ/x2AqWuxsKQSTkll
         1GpapNgEk/XZGJnrIvMHJKWkRV86o3RU3nd4KmhsUDqQo89pTd2HQmTf/FaRHL72F0M9
         kieB2gaY3TGFjtptls+ql43n82VSgkFtgFTMq8k1R5MO9n8+E8XReJsux6u7yYPA1ILK
         e8MCZNk3j+mvabkxTejjKnsaYoDlxUztoLB0kNrnxUyG05rGGxaKu504QAUl0fNfCB+M
         iFeg==
X-Gm-Message-State: ABy/qLb7kQfTVuHRXEeDV60jhLp4PqsqjvOljTkP4DaNq3/+sNEYgsJH
        IiCoFHnqwiuQN4rH3igzrzyoBg==
X-Google-Smtp-Source: APBJJlE1qO/mz5cEVBdCi3bzPv1ACuaaM2Oq9Lj87enYg2180oHHHM3WQBmc1aVGukuCLwKJTbvFyQ==
X-Received: by 2002:a05:6000:11cd:b0:317:59df:a848 with SMTP id i13-20020a05600011cd00b0031759dfa848mr3362765wrx.30.1690930943800;
        Tue, 01 Aug 2023 16:02:23 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bca4d000000b003fa96fe2bd9sm126620wml.22.2023.08.01.16.02.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2023 16:02:23 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH] RISC-V: cpu: refactor deprecated strncpy
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com>
Date:   Wed, 2 Aug 2023 00:02:11 +0100
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <61DD603A-3D86-462F-B795-7EDE3A59ABBE@jrtc27.com>
References: <20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com>
To:     Justin Stitt <justinstitt@google.com>
X-Mailer: Apple Mail (2.3731.600.7)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 1 Aug 2023, at 22:14, Justin Stitt <justinstitt@google.com> wrote:
>=20
> `strncpy` is deprecated for use on NUL-terminated destination strings =
[1].
>=20
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
>=20
> The `sv_type` buffer is declared with a size of 16 which is then
> followed by some `strncpy` calls to populate the buffer with one of:
> "sv32", "sv57", "sv48", "sv39" or "none". Hard-coding the max length =
as 5 is
> error-prone and involves counting the number of characters (and
> hopefully not forgetting to count the NUL-byte) in the raw string.
>=20
> Using a pre-determined max length in combination with `strscpy` =
provides
> a cleaner, less error-prone as well as a less ambiguous =
implementation.
> `strscpy` guarantees that it's destination buffer is NUL-terminated =
even
> if it's source argument exceeds the max length as defined by the third
> argument.

I would imagine you=E2=80=99d want a BUG_ON() rather than silent =
truncation if
that ever happened (well, silent if you ignore it then printing the
truncated string).

Though really you just want a static_strcpy that looks at sizeof* for
source and destination and fails to build if it doesn=E2=80=99t fit; =
there=E2=80=99s no
reason this needs to be found at run time.

(* and __builtin_types_compatible_p(char[], ...))

Jess

