Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68FBC433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jan 2021 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F0820E65
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jan 2021 16:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406196AbhARQE7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406352AbhARQEs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Jan 2021 11:04:48 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D467C061574
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jan 2021 08:04:06 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id m13so18708389ljo.11
        for <linux-hardening@vger.kernel.org>; Mon, 18 Jan 2021 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CRVjXKKrBcqwznGwkqTzMqru1Q83Wf5kKWHY7eqB8zM=;
        b=lbWZcFrp2/xw+8YB57Zf263+bZpNgoZ7EoISNDLdIhXY1lIpJ3pER18lYziEAhGzZt
         k3Vy+kuDQ52eFj2/nSBqgI1Dzl/17VaiB072NC5dPTgG5h+DniV+PC/ASDYnAGnZdixj
         m9l3MdV3f/QuJS67asRhuBCF82FyEAw2vfbo5w94pdSc4pwxaMSfXD9C3dd5IY7WXNR5
         Vt41zbAu78xzxub//34cHf+ASxBcrXUjYu11iy/unGV0P/R3W15JKXODhM6o0iOGh3GY
         Fm9Ier+d+Gx93110sQLSgc1L5RT0LGqEB7uEP4gXzBmdWf7Eds+qBBubBvXZ7kJS3I8q
         5yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CRVjXKKrBcqwznGwkqTzMqru1Q83Wf5kKWHY7eqB8zM=;
        b=JgzRqSxCAtrvRjg/94YwFuJuiF3m4cj4PB9TaJrcCPVL/Wxw+2h4sXzF10aFicjyNl
         GpQg8vH66wk7xKq3kZYSXjWADPppSYPWAlKQBRM3HouaP4WkX9G29dnY8Nksp/juIMoW
         AJSVmQ8Iudz9fRaWxm+UQebQl/7napc2ubpzzSfuwPBDGPWINcX7lhHrvOwVASiXQZIE
         mb9AMhRNFzBjbff82wl+aiH+uS6tLM0EQaPAS/pJYYD7V+2H4Yi9jP9wpL8lXUJT3OI7
         w8rutGF7jmOJZ0t7GBsgV0jwyMeAYpsTvK8/BXld6WMt1+COi3DTq19xuM3lFmE+WYqI
         vQKA==
X-Gm-Message-State: AOAM532FEpLA8kHXmR9H+MSVrqF/b9GS84kQ2rGmYqvi2+r7ZY3jtELT
        ER0lBwVaG/vxfBaHc+Uj9mVh
X-Google-Smtp-Source: ABdhPJyhoURVwyFMMZQYjFq/YzVLjesKUyS4L8Y3IIHImbFP5hN46ZurI3143j9QemFLDSa+xuFSiw==
X-Received: by 2002:a2e:898c:: with SMTP id c12mr147949lji.193.1610985844464;
        Mon, 18 Jan 2021 08:04:04 -0800 (PST)
Received: from ?IPv6:2a00:1370:8117:3ba7:1569:a6db:ab8:291f? ([2a00:1370:8117:3ba7:1569:a6db:ab8:291f])
        by smtp.gmail.com with ESMTPSA id j17sm1946104lfb.145.2021.01.18.08.04.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 08:04:03 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Compilation issue with Linaro ARM toolchain
From:   Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
In-Reply-To: <20210118155921.GA462671@xps15>
Date:   Mon, 18 Jan 2021 19:04:02 +0300
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linaro Toolchain Working Group 
        <linaro-toolchain@lists.linaro.org>, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <061303A4-51F3-42E0-BCE3-BFAF416D7609@linaro.org>
References: <70249918-0081-aef4-0605-85db700aadc5@orpaltech.com>
 <20210118155921.GA462671@xps15>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sergey Suloev <ssuloev@orpaltech.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

> On 18 Jan 2021, at 18:59, Mathieu Poirier <mathieu.poirier@linaro.org> =
wrote:
>=20
> Adding the Linaro toolchain group mailing list.
>=20
> On Mon, Jan 18, 2021 at 05:49:39PM +0300, Sergey Suloev wrote:
>> Hi, guys,
>>=20
>> I am having an issue builduing kernel 5.11 (rc4) with Linaro ARM =
toolchain.
>> The issue seems to be related to CC plugins sources.
>> Here is my build log: https://pastebin.com/DTn7Szax. I have never =
seen this
>> before with versions 5.10 and below.

Thanks, Mathieu.

Hi Sergey,

MPC (along with GMP and MPFR) are libraries that GCC and its plugins =
depend on.  I think, installing libmpc-dev or equivalent should fix the =
problem; installing an equivalent of =E2=80=9Capt build-dep gcc=E2=80=9D =
might be more robust.

Linux kernel has recently relaxed the way it detects support for =
compiler plugins, so it=E2=80=99s now enabling them more often than =
before.

Hope this helps,

--
Maxim Kuvyrkov
https://www.linaro.org

