Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78DBC433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13FA61279
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 10:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhIYKmo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 25 Sep 2021 06:42:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:39603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244055AbhIYKmo (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 25 Sep 2021 06:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632566447;
        bh=+E0Zsq8vQdVnH1eVHRqXyVRKa4tlva4ZQhYIJQrKt+w=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GZHHpNUJYrx4VaO8KPRbmVdzfttlqYI/J08++RiqNSlCnMS+vSLLiIxT9vxX77AhE
         DxL9BQ+mORbpYhFl1MzJ13croYE7zfB3QcydtfejFNPozBmAhbT/i+wUKl73BSriuB
         GuwFAu1p1VAO0/ZkcSysBXM5YwMiUcMrSytBj8tw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5fMY-1mVhwK2n9u-007FqA; Sat, 25
 Sep 2021 12:40:46 +0200
Date:   Sat, 25 Sep 2021 12:40:44 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg KH <greg@kroah.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Len Baker <len.baker@gmx.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Prefer struct_size over
 open coded arithmetic
Message-ID: <20210925081856.GD1660@titan>
References: <20210918150500.21530-1-len.baker@gmx.com>
 <202109192246.B438B42EF@keescook>
 <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
 <YUn3F9HtgrpN9sSM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUn3F9HtgrpN9sSM@kroah.com>
X-Provags-ID: V03:K1:cMUjCKsXj7H0+OydE/f6KgPKNk/NK2+qEgrewaFjdLCxdnzKEbF
 82Wiu0vKa3gonbuRiRNxGW+ma563qTWEuZwaNEV4262tEvG5lUf0B1m8KmR30bQM9IOUbQo
 ampAm+CC6bTlFs0iREdmVWx/pHMsrv4j1816diYgSlFVZdnXY40vY3nuyx3gX3vdc/Op3Nq
 kqvmdfVO6GnrPdJ1js75Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jatRWMgvDVU=:0eypWfk3zdwajPsfyFuDOv
 j9MQvf9uHneK75carU4gQf6y+PwuC0DfjjAA1p5zCHpBZWJvAQ7tWQQOWva5qvWiIoXV9oYlj
 veQMMCXZOOJm3nlVB1LM+ZxuoCu7ikfxEx4kXcGtSPKDd8z3SDqpwEUC7LS0hjKpStt3gdZOy
 lb2S9HE/bOTRfYpk+RL0QJS3bLpzA1fZFJCN6dPLyagOl4tysK8wmGkKyQWMHTo+Vch5fYlLH
 KTXHuPKuSX8sY+fFuM2vfhOPEYJ3ZzhStpoDYXyCIQtJAzo2bIpDAm+y8qqH4IFr5WakQ2qZI
 +Zq4kls9/u+z8xN0y0ab70r1q25zJHDgAb8u4aViLJnShMk8VWnawbHubTKV+5hHwXFiGC+J1
 JeDpMLBxgOYeL0JAKdUhfdLpD6u7TuORJGQI5buMZDoA7oNAT85uUZzLLapZlRK93/gg2hokg
 iwAfANY2kVZrD4jB2jsSBmN5pCVjGTdcYtN3YilSSYgfQGWWe2RAzzth84LvZh1rszGkzjDAE
 Msff2fHASOF/1nytU+HHJLqG+9RA3LjGpcplU9TWFnB624X9KzCQR37KCdSv4NN9Jez/e8UlA
 057NtB13wJuJOkh9ClvhxV1YV2CepW8/meTc6PxRzQeM1IOFz5zDLcA9VB2mpFEip+UI0y2yD
 xSIjHDiURF4AeWY5O4k3antB/iLrt4ebqdGv4efxFpKmKtdONIv+wFxrLNbDW3aK6LX6kYCm5
 MVwtpR1yfzSfKAVazvF5xxWsyWVjBLHsW+DTUkuwwJq3qOjgmYVYZ6OVM+bJR6bFvEUA2xNVy
 2nTUa2ZGmRJW0a8a0VCcNm9MudDXA1lfo8/CV64jSlAVqyiHbkbpQhQz5xf3ZqBrr6PzNtYP7
 8FFN4siAOj5i1rr8Z8SVj3iAscRXtjY0liml9xn+hCN1jVifEmroUYc3mNWeCHKaCfJdj3mSB
 3cINpgVLPQKpeWUF0dK9MNZErx7V50PAkMKm74dXV/9FuurW6e3UotE+Sa7qzA27ai6VoKFMr
 s6zV47YGyYAA7ckjtdpr136wCQgAjZyrdKlGioGIL/ohNEEnwtzNuqKptpWsc6/NsIJpYVL02
 SrAhIcdYa8gE/I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On Tue, Sep 21, 2021 at 05:15:35PM +0200, Greg KH wrote:
>
> First off, why is a single driver doing so many odd things with
> attribute groups?  Why not just use them the way that the rest of the
> kernel does?  Why does this driver need this special handling and no one
> else does?

Is [1] the correct way to deal with devices attributes? I think so.

[1] https://www.kernel.org/doc/html/latest/driver-api/driver-model/driver.=
html#attributes

>
> I think the default way of handling if an attribute is enabled or not,
> should suffice here, and make things much simpler overall as all of this
> crazy attribute handling can just be removed.

Sorry but what is the default way? Would it be correct to check if the
file exists?

>
> Bonus would also be that I think it would fix the race conditions that
> happen when trying to create attributes after the device is bound to the
> driver that I think the existing driver has today.
>
> > > (I see the caller uses +2? Why? It seems to be using each of hotkey_=
attributes,
> > > plus 1 more attr, plus a final NULL?)
> >
> > The +2 is actually for 2 extra attributes (making the total number
> > of extra attributes +3 because the sizeof(struct attribute_set_obj)
> > already includes 1 extra).
> >
> > FWIW these 2 extra attributes are for devices with a
> > a physical rfkill on/off switch and for the device being
> > a convertible capable of reporting laptop- vs tablet-mode.
>
> Again, using the default way to show (or not show) attributes should
> solve this issue.  Why not just use that instead?

What is the default way? Would it be correct to use device_create_file()
and device_remove_file()?

Sorry if it is a trivial question but I am a kernel newbie :) I have
a lot to learn. Any suggestion or a good driver to look at would be
greatly appreciated.

Thanks,
Len
