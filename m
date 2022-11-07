Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209D9C4332F
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Nov 2022 12:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiKGMiO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiKGMiM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Nov 2022 07:38:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E58183A6
        for <linux-hardening@vger.kernel.org>; Mon,  7 Nov 2022 04:38:11 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so14436668pjc.3
        for <linux-hardening@vger.kernel.org>; Mon, 07 Nov 2022 04:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RafuIk7/aRO254sO5kaFn2eaoukNCiocFq8V/csBLds=;
        b=fDaxMp/f71ZRpbedeyBEnv7t9dZTh+Bqfj5jjvCBHEqpmNj9W3DK4n8Jdn4PbLSea/
         9vJYHS8giWDhWG0Yr0fRbmlXDqWsgG1xVRRS1j+uj/pYFu9d7gSccaBBL/Ek/Yc7AE5q
         /Ybvq2QY+aYa3imrPiyw3qnx04VaBDTf380oHXCtjdahKATee9ko6t7G+0uTozephZQM
         HlUx0HOnXwSgAAtBDeBuUz86rq1KIAhucbhRhP03V+52nw1aSVCkRlN82GdrYVuppupl
         icSP+qQFseuOUA+910AQUqEDaI4hkR5W1VO/7dNuVGuwuUMoxKMeCckkfPMPGks4Bnct
         GDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RafuIk7/aRO254sO5kaFn2eaoukNCiocFq8V/csBLds=;
        b=Uz0yLWexZ0HdoCgILEsTC/p/5flp/0qdqObfwUaxLz05vYVwBbJALlsyPjEbQerD1y
         iS6OZOxqlcLZk4ro71LOCkTh+R8JNEwx7rDzpyxdobuKCDf4MRLh3l5KwfdRKqVexlR7
         lPTsiNvdUd9ItUkNZ0PJkIoH5OrS0AISq+/l/B6ddA3RY+TwFad9Vv8x9R+gMSpFYKpT
         bC16HLELCUopr4+Q3pENTMHSILBjfO/3UoqswCUiSeFXCz2W0hjYLWulaH1DlrSnT9+7
         SRP3bh0uctbC+XWPgXTaAOETpGQVmY5PQLylxfwttyvf5tctUM2jUEybqN/RmEP2vnC5
         /C9Q==
X-Gm-Message-State: ACrzQf3LwL33QBOFQ6Obagxa9QwzJ/bxQKvCZrEfddp9SeEj0xWAltgK
        QsBH9uJqDOyQChgT1x7Ac5c=
X-Google-Smtp-Source: AMsMyM4E1nYQg9Q52dFHfMNwRqKSCd8PT00BBHN0VkZYDe6iWB88CLg5no3nTzgKo/EOO08tgfvpYw==
X-Received: by 2002:a17:902:9b8e:b0:187:30ec:67dd with SMTP id y14-20020a1709029b8e00b0018730ec67ddmr36070211plp.79.1667824691164;
        Mon, 07 Nov 2022 04:38:11 -0800 (PST)
Received: from localhost (203-221-202-134.tpgi.com.au. [203.221.202.134])
        by smtp.gmail.com with ESMTPSA id pi2-20020a17090b1e4200b0020bfd6586c6sm4234991pjb.7.2022.11.07.04.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 04:38:10 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 07 Nov 2022 22:38:06 +1000
Message-Id: <CO62IBK4D7K1.1USN6WO3YDZPY@bobo>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Andrew Donnellan" <ajd@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "cmr@bluescreens.de" <cmr@bluescreens.de>
Subject: Re: [RFC PATCH 2/6] powerpc/64s: Helpers to switch between linear
 and vmapped stack pointers
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.11.0
References: <20221104172737.391978-1-ajd@linux.ibm.com>
 <20221104172737.391978-3-ajd@linux.ibm.com>
 <20c79a09-0b95-bb52-2495-999d2365308d@csgroup.eu>
In-Reply-To: <20c79a09-0b95-bb52-2495-999d2365308d@csgroup.eu>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat Nov 5, 2022 at 6:00 PM AEST, Christophe Leroy wrote:
>
>
> Le 04/11/2022 =C3=A0 18:27, Andrew Donnellan a =C3=A9crit=C2=A0:
> > powerpc unfortunately has too many places where we run stuff in real mo=
de.
> >=20
> > With CONFIG_VMAP_STACK enabled, this means we need to be able to swap t=
he
> > stack pointer to use the linear mapping when we enter a real mode secti=
on,
> > and back afterwards.
> >=20
> > Store the top bits of the stack pointer in both the linear map and the
> > vmalloc space in the PACA, and add some helper macros/functions to swap
> > between them.
>
> That may work when pagesize is 64k because stack is on a single page,=20
> but I doubt is works with 4k pages, because vmalloc may allocate non=20
> contiguous pages.

Yeah. This could be a first-stage though, and depend on 64k page size
and stack size, or !KVM or whatever. When the real-mode code is solved,
that could be relaxed.

Thanks,
Nick
