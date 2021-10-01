Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D802BC433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 20:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B585661165
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 20:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355003AbhJAUZQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:25:16 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:38578 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229888AbhJAUZP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 1 Oct 2021 16:25:15 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5DD4D837F253;
        Fri,  1 Oct 2021 20:23:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id BCFCE17275;
        Fri,  1 Oct 2021 20:23:12 +0000 (UTC)
Message-ID: <605ae631bccba303aac01edd6702cb28d8940fef.camel@perches.com>
Subject: Re: [PATCH v4] docs: Explain the desired position of function
 attributes
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Fri, 01 Oct 2021 13:23:03 -0700
In-Reply-To: <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
References: <20210930235754.2635912-1-keescook@chromium.org>
         <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BCFCE17275
X-Stat-Signature: 4if55k4tcta9e5bown1wphntxuab5oh3
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19m1dGEi+rBCxpurAezNaeZmaBSEaNh+GI=
X-HE-Tag: 1633119792-417192
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 2021-10-01 at 12:05 -0700, Nick Desaulniers wrote:
> On Thu, Sep 30, 2021 at 4:58 PM Kees Cook <keescook@chromium.org> wrote:
> > 
> > While discussing how to format the addition of various function
> > attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
> > close as possible to Linus's preferences for future reference.
> > 
> > (Though I note the dissent voiced by Joe Perches, Alexey Dobriyan, and
> > others that would prefer all attributes live on a separate leading line.)
> > 
> > [1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> While I appreciate you getting the ball across the finish line (having
> _any_ documentation to point to in future bikesheds), I can't help but
> shake the feeling that the chosen policy will harm the ability of
> existing automated code formatting tools from being able to automate
> code formatting on the kernel.

yup.


