Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADCC433E0
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 11:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE4664F01
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 11:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCRLr2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhCRLrU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 07:47:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33A9C06174A
        for <linux-hardening@vger.kernel.org>; Thu, 18 Mar 2021 04:47:08 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d20so1623705qkc.2
        for <linux-hardening@vger.kernel.org>; Thu, 18 Mar 2021 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=Xd/+a2wJECnWGpm73LH+F3DCjZXOTUzAsNn6jljBOVo=;
        b=YswBmbZdVUxNJ1nAUXjhf3j4INsf/RmYoYDujnohUbSUgoSygaKKo/EC1SmcMQKB/0
         h0xC/s9oNjQEgFbIbgf1tn4PfF9TnO6weoaDjDrFv+fx1YTk4SaIhE1kubU6mzcLmdzF
         awM1N8VS4PHwli+oy6jujof72sZJ9GC4dtuUbyKB2dI8cYT7dweKuOD+U1isU3b1aT3g
         VMOdM6d2t9VhKbuWN2C6dWw5az96ziHNYPTCijX9ttft2qSJpQjiBX994F2iWkNFVEy3
         cQUxYtvZTIjY5ZH2ihcolY7ujm8v6bnPthudWbFFouU7iOyHXa/HbWUdCnjO3aVq0Xiw
         gdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Xd/+a2wJECnWGpm73LH+F3DCjZXOTUzAsNn6jljBOVo=;
        b=ZcOt/G7JlUD6J6/rk5Ymf4Ccv7NE2un8myzv8uJd0L3kXMv6xEWDGnT6ear2J4Zj8o
         JCJSiMYigbM+lPR9HJBq6NJzyr4JiYvFzCIYldtKs0bO3MWorHgZG2/Jbwds6j822qs1
         0LOLceBjX6RoAorsHdpLJwzuAhTqr8CskoBK6A9bRQVzDx/rTyiI5+TsSw6+STukJcXd
         TkV3MVxeLaTsDZ773SrGt/UnPSv9u3cgl+r3z9Ui4lq2CNPtC6KX4JQuxm9zaqsJE653
         2fQ+YV/ZSHivVo0hkcq/+UVGQlLRZ7AZNk5e2oHNMlRyxkGdsgZVjkmepJaTlI8vkYno
         Gp7Q==
X-Gm-Message-State: AOAM531Bq68IB8Z85MsSKkt9VAucMAVUE2A9qK1oeEluRvouDJM5bQJA
        3z2j+8VVJCVNxQzAGJ5hEPbKpg==
X-Google-Smtp-Source: ABdhPJy2cYcPwTcgduhapJYhM1AEXyAUTeig+OlggUs5JR2SA6Z6PUa51PLJp6xPkr2jicckzs2Fgg==
X-Received: by 2002:a37:a085:: with SMTP id j127mr3688500qke.206.1616068028177;
        Thu, 18 Mar 2021 04:47:08 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id o197sm1543765qka.26.2021.03.18.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:47:07 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on old gcc
In-Reply-To: <CAK7LNAT_hp0PmhWpb2=fScw6Q9DQsBztykis=xN0QCH==AVY6g@mail.gmail.com>
References: <279558.1615192821@turing-police> <202103172251.F9D770D@keescook> <282490.1616047333@turing-police> <CANiq72nyNSgrM6bhmM7ymdtYYKoDLfUXfwgTwLOmhLFc=c0U-w@mail.gmail.com>
 <CAK7LNAT_hp0PmhWpb2=fScw6Q9DQsBztykis=xN0QCH==AVY6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1616068026_248661P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Mar 2021 07:47:06 -0400
Message-ID: <299822.1616068026@turing-police>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--==_Exmh_1616068026_248661P
Content-Type: text/plain; charset=us-ascii

On Thu, 18 Mar 2021 18:07:28 +0900, Masahiro Yamada said:

> We can require GCC 6+ for building GCC plugins.

> +       depends on CC_IS_GCC && GCC_VERSION >= 60000

I'd be OK with that personally, but the question is whether
any gcc 4.9 or 5.x users are using plugins.  That's a bit above
my pay grade.  Kees?  Do we have any data on that? (All I know
is that there is at least one, because they tripped over the GCC bug
that prompted the second patch)

> BTW, the commit message mentions that
> the issues only happen on GCC 4 and 5,
> but the added code was:
>
> GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
>
>   instead of
>
> GCC_FLAVOR = $(call cc-ifversion, -ge, 600, 11, 98)
>
> So, this patch is also requiring to cover two standards:
>
> GCC_VERSION >= 11  :  -std=gnu++11
> GCC_VERSION <  11  : -std=gnu++98

I chose 1100 so that everything from 4.9 to 10 would keep getting
handed gnu++98 the way they had been, and only change it for
gcc11.

--==_Exmh_1616068026_248661P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYFM9ugdmEQWDXROgAQJ0BhAAhLOSziVfqbVLcMdTzxE83OAGHH4JDetz
oUS6F3q25fp7VR0wesEoFWpFOdKrMObHM6Lw20lZmNFltV9BBTK/54FoNivyUAJ9
DXAkm6cPgUIg6w/rxOVYFh0vHs1WUYMfFfa527IhClr3ZyDbky4Xhx6s7z4zZq4I
nU0k3WHupSl8auF5v7/ooOm8JWNM90nI6HLv2L1aLY2mIWVSXWFuUX6dPG5dbEKd
iZ4iUYotm1LoLX3KA82SlhGe8j/JryVicQP/3t3mr8dERoFHPgYky+7vVY6Tdzou
giWTTQOeAxPr16Dq5Ct6aYqeST63QufKSpvVeHVqZpR0GoQxOEf2mhUJLBRmRqr0
AS6yfEybFzqn2fg8LrvKyn/2taMilKKHjdXjvK7/16fq23osmrgvQ0QzrSPzhU9Q
peDaJnivzQKg2MdgTFXMGwBaNPFAA6NDmW5ykOAtkC/rkLBfPwjB2a0g/QwZ/HT3
8Fu6DRTxbFdjZjNHJGnAgdxhOjmaLYL4G2JtEfYDgpzFQvDsWVaWqMtHoKQ/OvRu
S6nyJqalE5I1cKmUx44/Gjg62PX1qCdLLd6SsnmVeVziDy85Q4U4u+mYonZfmD7e
fth3FpjYSHjwVRXyCNp4/Qvnie+xKA2hbUXPTiUibh+x+40XRYjgseejgk8fg3XI
w9zUfcNsqDE=
=kv1K
-----END PGP SIGNATURE-----

--==_Exmh_1616068026_248661P--
