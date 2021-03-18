Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25CBC433DB
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AA864F38
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 11:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCRL4K (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhCRLzi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 07:55:38 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F8C06175F
        for <linux-hardening@vger.kernel.org>; Thu, 18 Mar 2021 04:55:38 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x9so3784857qto.8
        for <linux-hardening@vger.kernel.org>; Thu, 18 Mar 2021 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=YztF6Wd6/VXGWXIG3Em3fyAkrNO59byXKe+h2J63iOk=;
        b=PJk44+VIbX9pxooH9Zfnjp+M2hEhx+JbPhe1fBs6R/o1Hp9FueXxWWZbGqBPF/O9Pp
         5Ec4vwvJM4/JFO5upPKEkC+p2v5Ui79cCIcoLCJkdh0Z7ibAh9eFuO3FpnvtNr8Y+mof
         HsWj5wZUPa5Od9Mq7WMy+O7dzEjRebQ0kR/gPM+c25qbg5emb3598dNndYwbC5a1jbWH
         kNtP2YQP+OJB07tmaCm73biKxR4v2qcoH24+wMu5Ykq8zLz6e1ckmrioyE2e752KChn4
         A8q+OayycpOzoL6VN3ZkO5EWAtSOnpZYVYrjOS3XaAl2LfhCcdxUFDwdRy6uz+hxQNJr
         87kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=YztF6Wd6/VXGWXIG3Em3fyAkrNO59byXKe+h2J63iOk=;
        b=Y0FlSAeAJLVCQXMEVUuDTTN82HrC8ib8lfU1NDEAlNKOYm01S8KlhQiKVU1IOr5kkb
         DgIIlCQJyOSVf3s7+fmN1VqIOjR1sU199hZ6aw/T9RaAIt7tbUmzN9COQl4MM0JIUm9X
         NGAfFKsGpJPu+TZ3aKV0fbhv/EiEtsAfID73Y45zvo3NCSqJwy9qXH+QglW9BL53JUNN
         PLnIGqfq3gG4HOlBJOE43U5mRAjSOiqUmzpGR/u+LlVmGNZ9PfypaiW9/JPrZUAioBqK
         bTY6qniJ1MAalvDuK2qY3wLL3RUI8aEQfup8BIRtNGioMFPsXBmKvDAxmXxd4VEdojv2
         THRA==
X-Gm-Message-State: AOAM530xg5JlzFhEFecHl+3kS0n4/+V5w3szvcH8jEnIHyp/WyFg4Ve1
        C1nYwZ0mvYH4Yno8SN2gNxn1Sg==
X-Google-Smtp-Source: ABdhPJznekp6vfMZ8t9aSgDg7PIovXDYSIBjWo9BdIXFNwgB6It9v6z1kPRs9FJZ1J3Yl49/FrQKjw==
X-Received: by 2002:ac8:519a:: with SMTP id c26mr3296977qtn.342.1616068537708;
        Thu, 18 Mar 2021 04:55:37 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id x36sm1248355qtd.57.2021.03.18.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:55:36 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on old gcc
In-Reply-To: <279b22592f1e43a48beeecd34e50b385@AcuMS.aculab.com>
References: <279558.1615192821@turing-police> <202103172251.F9D770D@keescook> <282490.1616047333@turing-police>
 <279b22592f1e43a48beeecd34e50b385@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1616068535_248661P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Mar 2021 07:55:35 -0400
Message-ID: <300176.1616068535@turing-police>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--==_Exmh_1616068535_248661P
Content-Type: text/plain; charset=us-ascii

On Thu, 18 Mar 2021 11:41:29 -0000, David Laight said:

> That gcc bug just implies you need a space after "xxx".
> That is easily fixable in the sources.

It's not quite that simple.

   In file included from /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/tm.h:27,
                    from /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/gcc-plugin.h:31,
                    from /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/plugin.h:23,
                    from scripts/gcc-plugins/gcc-common.h:9,
                    from scripts/gcc-plugins/latent_entropy_plugin.c:78:
>> /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/config/elfos.h:102:21: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]
       fprintf ((FILE), "%s"HOST_WIDE_INT_PRINT_UNSIGNED"\n",\

The problem isn't in a kernel source file...  To quote an earlier message of mine:

> It looks like it's not a kernel source tree issue, it's a g++ issue fixed in g++ 6 and later.

> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959

> And it looks like there was an intent to backport it to 4.9 and 5.4:
> https://gcc.gnu.org/legacy-ml/gcc-patches/2016-02/msg01409.html

> The bugtracker doesn't show an equivalent for 69959 being closed against 4.9.x or 5.[56],

> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63254 has a patch for one of the
> gcc-supplied files that tosses the warning, but that way lies madness...



--==_Exmh_1616068535_248661P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYFM/twdmEQWDXROgAQIFLw/9Hvpmfb4yKYzbWxvudeHerzDVFv9LVptA
MNx8PG+mbs3n8d1FwdVQ32D3FFCDjsUwgHrzZIGNhoyzOx/l9lKvUBFBtFdaofcd
OR9dxgFzkuMww4hw6Ft49ZlaMSI0KMK/KXxHAF9sD4R3TmWFRDxP7wx2CYvUqZGU
Im62hD+ZqBE+DlZnxCZHwkKL9ZUFzKmR+nquvOdRxlwI1heKP6XFod+6vYDbNb+8
GUxMuirDljIuTfgO2ARflIdhNKSJTLl3xNZN6nGZhe0CeHk68fDNeoqXLJ/JsLk0
PcnJHSswZJAMyU0Yduuj6Dp+qgqr7bVXDQuAunr+bAOXkQnonjjADl7ij6D3k727
hTLObP1bnw7WKVUTFvR6BjLsjJcphWfodrujrVTlm89lW/JpcX/kwALj+WS8JRiM
BS6+iqXhehKipuIW1bkWFox+60/7WPkbuk5fERrZacVcRMF9uces2vrAl9PxyUJw
ib6d1DSRLbIDJNXw1UR28yoprVREeVu7Rco/hk4vdnCM8WsTJK5ax8WOvyIef8om
G1NRDm5l27gJ8FF6v+vtiSKNs3+DvteKACa+s4HcH2MyEoa21+q4Bcd0fgCK6SWf
bv6SlRFF5k4m+URQmq3MzwITuYZ+r773hH9AthJmWqBm3SoRiDXHCxuWSB/yKC/P
xCTWp6Oj2wY=
=GT68
-----END PGP SIGNATURE-----

--==_Exmh_1616068535_248661P--
