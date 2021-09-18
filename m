Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0DBC433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 18 Sep 2021 09:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BB16124B
	for <linux-hardening@archiver.kernel.org>; Sat, 18 Sep 2021 09:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhIRJMm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 18 Sep 2021 05:12:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:52151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235575AbhIRJMl (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 18 Sep 2021 05:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631956269;
        bh=6lHVqi2oAFRgu31JzplJx3TGWSkqTLjIaeLQgF6ecoI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LgeENGbNsutmTokAbwcWLikRAWA9im4VR59qUC2PoHk9IErmBVj8EA7ol0JX2atuI
         qsJA66Zq6mth3/fsJtdT2dEVnyq86CQKz86dLkbFcSi2uCAt+eY88/ZCSiWwYMlkbD
         VNlfLvGl9GUGaOHRRo76hUobDGeHw3l8ICrp73BQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel3n-1mzCZ60Wvt-00ao6q; Sat, 18
 Sep 2021 11:11:09 +0200
Date:   Sat, 18 Sep 2021 11:10:57 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>, Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] docs: deprecated.rst: Clarify open-coded arithmetic
 with literals
Message-ID: <20210918091057.GA2941@titan>
References: <20210829144716.2931-1-len.baker@gmx.com>
 <87r1dqdfyj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1dqdfyj.fsf@meer.lwn.net>
X-Provags-ID: V03:K1:+rzmVjyumADpwk6ze8EV6Asf3Yjw5vSPudcQosQUPxoZxe/DZAZ
 fd0xuk608Ry2zuEFF+HkMxfOeLR9OMc9gTqVyZ9/6I+PlfBsDkslt3aRueSgPrquZig0f8I
 GXVXWDuEr0LfZfK1bp+kZ5DvaXJbLinfzsrfOnocv1mWIj3zh9D6QLVDWqpqVnZah2AkVux
 OphmbzKU+NIM5214SCl5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/CXm4Xg46iY=:1M0YfzRb9DL+6kpqhW35Z0
 Gjrbw4prYP0ScyduDM1/ZOwnnChTfrKqaaBA7sbIjYTJY7h/EJvAC4zhZbIKwpbo3XP3pSHsN
 HsGMJbv+PkjofuAu0GOSak6IOxMtrNIEyo10nRroQZ/K7ufsgkxoJC3xChFpMcCeezd66kg5f
 MpmRGUrEif82wZR0APv/Hd/3ellsA8q7/dGwLGhArp+s5j2iVElFXa+N7kLg3feta/x7E2uHJ
 Xmhn728r7lJzGQ7bvaTIZC1WrcQMOAcylQ+UDtqCZFe3CUCBFZbZY/m1BEgEoDaRma5/rEuqR
 E8T/qRZYU5YwxzlvsFAUw/SXIGQO/BbohjZ6wS1IVFlbtMvGvQ7XhxGGFeXexQV785BM3NwpJ
 IUkhpr2ophYFfohqocqQV3lZfD02x2aznfRTCOkN3dHMzLEw4dgk6VA9EEzeetiM4rAchEIWR
 g1z2Fz6pOtDE1/4hG5h1T8dwhsdt49reasm6DL1T5J+FTN2irWsyrKecB8Kh4r4o6yaq5I5iD
 Fm0paUelZiV3QkUWpnWSaODsjrdtOHjsaWRSy+KXblwQoiXUGprhT2BJji/k4dqUyYIFWOi6x
 qJUiEw5j/jjkoa6tD0oTRgwFVgY/aSuiHYKu3Yrveq+ZfC8pHFsUHjlMMZgjvNLbr79kKzCPO
 kgKeDMKFSHrRMN5PM9sHwD0TyIWHJ5ZuA9UGEbV3BwfKY19Xp1Th6c3UqZrQILednm6TWU6vs
 Onv4uZ9o72EYHv9UATbYiA8epvQe7kgPvFKIApG8K1Kh8Zc64CdPdXYWPQK7pTylqqbV+t/lG
 /KqEMWbwwLHznmzvW810yP55ElauBVbmqx9U8eti8Aq0ZYJPGTyV6CzZty6gTEJFr8LRQpACx
 p+3yxhW7EXvkHwbMrgSOVhq5oXDzZ2CuHNKNRO3lONMpSpJ0mUTAaFRi2M+67hAELk4xG6nnd
 TXJRQrUOcClkvX0oY6Xx65Ewlvy9jZ1+5gz0Iy73flAWl2cyVO+TUrW0jrlb9mCRig8M8sAyF
 RWF4pAe9TmGfIuPX9pUDA3YoV/Hktpbiz9XrDiKi5PxU3/IZPHjyGilQwiKgRUdkB24O9YSDn
 qQSftDwP8edRTc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On Tue, Sep 14, 2021 at 03:07:00PM -0600, Jonathan Corbet wrote:
> Len Baker <len.baker@gmx.com> writes:
>
> > Although using literals for size calculation in allocator arguments ma=
y
> > be harmless due to compiler warnings in case of overflows, it is bette=
r
> > to refactor the code to avoid the use of open-coded math idiom.
> >
> > So, clarify the preferred way in these cases.
> >
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> > ---
> > Changelog v1 -> v2
> >  - Clarify the sentence by changing "keep <foo> out" with "avoid <foo>=
"
> >    (Joe Perches).
> >
> >  Documentation/process/deprecated.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/process/deprecated.rst b/Documentation/proc=
ess/deprecated.rst
> > index 9d83b8db8874..b5a8be914178 100644
> > --- a/Documentation/process/deprecated.rst
> > +++ b/Documentation/process/deprecated.rst
> > @@ -60,7 +60,8 @@ smaller allocation being made than the caller was ex=
pecting. Using those
> >  allocations could lead to linear overflows of heap memory and other
> >  misbehaviors. (One exception to this is literal values where the comp=
iler
> >  can warn if they might overflow. Though using literals for arguments =
as
> > -suggested below is also harmless.)
> > +suggested below is also harmless. So, the preferred way in these case=
s is
> > +to refactor the code to avoid the open-coded math idiom.)
>
> Sorry for being so slow to get to this...

Don't worry.

> honestly, though, I've been
> staring at it for a bit and cannot figure out what you are trying to
> communicate.  What does "math idiom" mean here?  If you are trying to
> say that using literals is *not* harmless, then perhaps the first part
> of the parenthetical should be taken out?
>
> Confused...

The "open-coded arithmetic in allocator arguments" section in the document=
ation
explains that dynamic syze calculations should not be performed in memory
allocator function arguments. Then, the text in parenthesis explains an
exception to this rule: when the calculus is made using literals for all t=
he
operands. However, the text in parenthesis also tells that using the same
literals in the recommended helpers or purpose specific functions is harml=
ess.

So, there are two options for size calculations using literals:

1.- Leave it as is.
2.- Refactor the code to use purpose specific functions or helpers.

What I try to explain with this patch is that when the calculus is done us=
ing
only literals, the preferred way is the second option. In this manner the
open-coded calulation (multiplication, addition, ...) is avoided.

The "math idiom" refers to the open-coded arithmetic.

I hope this clarify things a bit.

Regards,
Len
