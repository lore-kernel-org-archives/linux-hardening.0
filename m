Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A00EC4320A
	for <linux-hardening@archiver.kernel.org>; Sun, 29 Aug 2021 14:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CBE60F25
	for <linux-hardening@archiver.kernel.org>; Sun, 29 Aug 2021 14:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhH2OdR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 29 Aug 2021 10:33:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:46603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhH2OdP (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 29 Aug 2021 10:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630247534;
        bh=nvs8837RL/FatuUxRpR3LhumAcLvvX9cPIPV4FvwiMY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BjFyeo8JUe3Jw+zYj7BGClvNYAj0E9f+o7JAfMNlQOS4NaNkNdNS8TDnzxpABsSLl
         6Gvxk25GsS0+hxX33+3A2e5xn2w2+8D0tv8RtnGFmnc+PyEUgAtJ4R4YIP1aO6+iAz
         Hs1Q1T+BUjAadhrDUjivdGBtEYiR5P8RCTPOgvdw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5G9n-1n392G41On-011BBk; Sun, 29
 Aug 2021 16:32:14 +0200
Date:   Sun, 29 Aug 2021 16:32:00 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Joe Perches <joe@perches.com>
Cc:     Len Baker <len.baker@gmx.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Clarify open-coded arithmetic with
 literals
Message-ID: <20210829143200.GA2185@titan>
References: <20210827171226.2938-1-len.baker@gmx.com>
 <bd7487c725e15b0c20612a44ecf301637a60c157.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bd7487c725e15b0c20612a44ecf301637a60c157.camel@perches.com>
X-Provags-ID: V03:K1:FeeK8l1PQF76mrGFcok+5fvjCtP8b80O0RczVz9pQCL76eUr90Y
 YOqUfFd9Wu6YV5NK7NhbaEDZ5PsWH+OVf5icznT9kVfiDChGgQsdBnxO6awRVi/BDGKOhzi
 m/5cJjg6xXp56u6Th1uxU9hiUJYX3gn3qU9zU3use1GIkS20PCP8dMEaaKMX9yD9h4Lteyy
 QDQxkKHCLzszbU8IZiTug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BbSC90bemSE=:57FwL7S+I37KEX6nDvpsT/
 MD3jACPRwaJ/PZc7PjI3vpohZjJsmNoD5iVIuz6Y2ivWWPjJMiLBGMpj8h/hDngjxOLUV6Fv6
 vafjv1OjiwSj39j86Zq9iuqm1Q3/8KP3cd+Bzu55Z/s04iIHwP0CXCV8XZ5wHO1+Eq7Udlw5u
 gYfVKNjVtpHDpRTFl/7he8VC8J7ojvNsElkz2xwOb2R9pIttFjeLV40h7E8/+u2KwhJNuv+39
 JDyJNITRWI6yE7cgAtTLAsVw0tAn2+IQvc8FMvernU7ppc5+x4nB7oRTdVqqrCNOh1EtYNPyh
 kOol2cDUJ1g8kILQqAAExUJi7VojOUsFYZCzJeFxz27zMLZ3Ja0vEx0HrdF7hLtONu4NPOgrH
 XU3HGa2mHviFDM0Nlx8ZK28sP1rqQqdO9OPJHA/WoZeNk67oBHD6JRbJWAgBJWAwGYkWrZYEL
 eJfG37FtDYZxM1jseG6ign4jiRkYu0nqNodm9mR7/XZJt3OO6IhZ8GnyUAH0k0PaDhoDvK/tZ
 /sIHrhLrKxbWF9PZDi2mIzmjIMEdf+cUnohEGmRERjWKnVORoXKfvSgQZL/cHJR91fjovMjCa
 u+xaPl4ebv+QIJXW2B1WCqiJBUIUZ1dFYu1dYHapqcohda8+fLWpPoZZYzvCg8PL9846vCW64
 0YNumYeYjdJ3/gbkvvZkZExo3GmnUnKYcTYXbAYt2gF/lsPrXg+bw6pOwbtz/4loK1Z6G1Mju
 lIlXqBUhW18EP4HUFo/rX6dFxz8jDLGiw8W1F6y3hyHYJ6QF9BGiTQjT0//ThCiZ/s2xmYGtI
 nKFUAAZ+yVv7Mko4CO+KC7vX2by0eBJXH/GWaM5X45PUoL9CIP9Z9iDHxVIBS2cBkB7npSltu
 aoezIM8zVqeQ94ZhYEHMX1pNLnu4/HcOc30OM5GNVnFxIKW73XW77HFrZ0Xxh7bH2iZERCm3s
 NjXB2CuttKTOwPAvuBfGraf4i9VhpJmcDyoWYSLEuDwhtSJ0SyxgbXAJ/CVoVvA74kgAVxv3r
 XARAdMC+6TSRag6/cfN4sDVEc7tC7cDqGV8E3HzxQNHbt1fswSxU5tlAa6wHSefFRPwoYs/43
 VqhbVEo2ecCwbc6uY/cm2FXajA74nL/cJHQjp8KED2luLJh9M3VewbvMw==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On Fri, Aug 27, 2021 at 12:06:18PM -0700, Joe Perches wrote:
> On Fri, 2021-08-27 at 19:12 +0200, Len Baker wrote:
> > Although using literals for size calculation in allocator arguments ma=
y
> > be harmless due to compiler warnings in case of overflows, it is bette=
r
> > to refactor the code to avoid the use of open-coded math idiom.
> >
> > So, clarify the preferred way in these cases.
> []
> > diff --git a/Documentation/process/deprecated.rst b/Documentation/proc=
ess/deprecated.rst
> []
> > @@ -60,7 +60,8 @@ smaller allocation being made than the caller was ex=
pecting. Using those
> > =A0allocations could lead to linear overflows of heap memory and other
> > =A0misbehaviors. (One exception to this is literal values where the co=
mpiler
> > =A0can warn if they might overflow. Though using literals for argument=
s as
> > -suggested below is also harmless.)
> > +suggested below is also harmless. So, the preferred way in these case=
s is
> > +to refactor the code to keep the open-coded math idiom out.)
>
> wordsmithing trivia:
>
> 'keep <foo> out' is difficult to parse as 'keep' is generally a positive
> word but its meaning is later reversed with out.
>
> 'avoid <foo>' maybe be better phrasing.
>
Understood. I will do this change and I will send a new version.
Thanks for the review.

Regards,
Len
