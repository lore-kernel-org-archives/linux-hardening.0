Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576FEC433E0
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 06:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1729864F30
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 06:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCRGC2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 02:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhCRGCQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 02:02:16 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D8C06174A
        for <linux-hardening@vger.kernel.org>; Wed, 17 Mar 2021 23:02:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d20so971631qkc.2
        for <linux-hardening@vger.kernel.org>; Wed, 17 Mar 2021 23:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=cZxll8/fJ4Oy1p943ypDLscoyBEeL7OmqWMRyol9tis=;
        b=A1JHzrXfEVj1zB/tU3B/OoCoPdW/CpZ9WqFQngKEtSKHYzaAvpvF0tPfw6BZ/Gib9U
         caJQCJ4DQbdMPBXy/nD+YkUClygdrNOIzuHYMSb38AjLUSuRWKNbjfkzMjyY7BTF4hkV
         wYHWv1+gg1qJhdecYBsrYD7NUfjUPqFJsrHAPYZH5V/HvbsxywT1LNLDOsTXYprRscUD
         bXlVOEDkQqIDleyGXA4hvHe+D4vI3FDmP5X6j+OnXctjKpeGd7Yo/wx4OdU8CG9042ji
         TGTunvpEc0JocM7LPELiyLoUY+U2ZtKhkL59W6TAn/MB03ojSTjQKoOPIVkNJRJBiEa4
         UE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=cZxll8/fJ4Oy1p943ypDLscoyBEeL7OmqWMRyol9tis=;
        b=mmMDTEccGW4t6wZIFcVSoA36Ymhbsgy2lOrJ5PhBXX8+gUOZGSi2/EVHCxMf0nCxuf
         Tst9UBJgCato3JMlMGtJt5qHiz5Bbky1p8EPaYj4ldZ13TJkVa92ICgyH4RtNURZOn+C
         xuZ7gQ+0oKfMQCbtKJs9es1HMVnqP+OKeDv50te8dq778hN37ewTIkM+QczvilK7NIIC
         3LTDu0PzNF1j7blK73XuZ5y+SzQmut2Qg/WGITuKfB0rm05bcS0pfYbVwGFGImgmWvPA
         hcs8qmsjPZvSdfM+H+13mQeImA+bF0cdkA4mcZhZGh7Z9Tg+flt54F5a8lUYNT4nLuae
         MMFQ==
X-Gm-Message-State: AOAM53040HZPC80ts/BtoVnrFx/GUDpXi4DNyDkcZzD8R6QVt3ac2H4h
        Z18qLkLYt5xTBgjz3+TTl25l0UH8P4A8QA==
X-Google-Smtp-Source: ABdhPJz/MppPYoV2YBAzTex9Hn9hJQHVTGuxWu4aNo8HUJz6gmKjNvPUjTFqLRX9uF9HcrDz69Tu6g==
X-Received: by 2002:a37:a282:: with SMTP id l124mr2788200qke.37.1616047334652;
        Wed, 17 Mar 2021 23:02:14 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id a20sm1056538qkg.61.2021.03.17.23.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:02:14 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on old gcc
In-Reply-To: <202103172251.F9D770D@keescook>
References: <279558.1615192821@turing-police>
 <202103172251.F9D770D@keescook>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1616047332_248661P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Mar 2021 02:02:13 -0400
Message-ID: <282490.1616047333@turing-police>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--==_Exmh_1616047332_248661P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 Mar 2021 22:52:56 -0700, Kees Cook said:
> On Mon, Mar 08, 2021 at 03:40:21AM -0500, Valdis Klētnieks wrote:
> > It turns out that older gcc (4.9 and 5.4) have gnu++11 support, but
> > due to a gcc bug fixed in gcc6, throw errors during the build.
> > The relevant gcc bug is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959
> >
> > Version the option based on what gcc we're using.
>
> Is there a better way to detect this than with version checking?

Not really.  gcc 11 needs --std=gnu++11 to build it.  And although
gcc4 and gcc5 *claim* to support it, there's a known bug, so we *can't*
feed gnu++11 to them.  We can check versions..

Or heave gcc-plugins over the side entirely..
Or declare that gcc6 is the minimum for building the kernel.

But if we support gcc4/5 *and* gcc11 to build gcc-plugins, we have to version-check.

(Unrelated - the patch has grown a merge conflict since I sent it, let me
know if you want an updated one, or if it's OK as is....

--==_Exmh_1616047332_248661P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYFLs5AdmEQWDXROgAQJkwxAAlL9tOkTegj/kX3t/R1Jo6/u/IATKUOfa
xVDQ3vOO3VFhsTlT/WbBOaGpxIq6gqtSDmIQa6VnFd24smNOkytmze6PESJSCOwi
Xqj1DRYTPa8EHeJ6JBFT1qBYNklYcv+7gMoJoen82fp4EoIXAQ8ueufUWsA1lZoa
aeWdn/tfmNVaKeoGh4KkDJs+bX9lshV5I3/FNSeXEbPg9qjj/IGFgmei80n9lO3s
T0qIaGuZ9qNFP1SLYiZn4lVnixcCPG5is/7YChk/I9WC6raGIxIIXwILM7qHEWYW
jfMrOU6c5Iw3CLNGMrdxuTTIxHhfanEMY2hCO7qyDwQQyCKOCDweBaIvffFfVXul
EDj1KUXc7lr9CKszMwUXlB3iXRsrJAZOhE1sblqSIy6lP5Hxe4Acwwz4cSVZ5RKq
fAQo+s9HsdxGF4vuxE/QJ16ycBGKlk+wNhCPEYGZgJd/aOXNUKTtPnA8K59U8S50
NUEPXRkS4e5bzzdNuAie5/YbRAabAlRRDiS2EUOVCAqxZ250XgW6+KTWFT9R0ZBh
j+VBzSKdJJipRvXOgatdQYpml1DkhStRoszC3a5nOp62bcLHM+/jCrkzM/Q/F6+O
JE2S2MnvfSiRwiKbWwP6EItTkYI9jkPhhEAX+D4TNSLmm+r24N4FqG+9gybLcwZR
lBaFmEYTegw=
=DU9U
-----END PGP SIGNATURE-----

--==_Exmh_1616047332_248661P--
