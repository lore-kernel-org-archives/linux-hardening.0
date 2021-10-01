Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1DC433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 02:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BC561A60
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Oct 2021 02:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351763AbhJAC4T (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 22:56:19 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:59690 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230346AbhJAC4S (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 22:56:18 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 064913A7B4;
        Fri,  1 Oct 2021 02:54:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 1DDCBC4178;
        Fri,  1 Oct 2021 02:54:31 +0000 (UTC)
Message-ID: <77c24172a2fea727881ef4c4c901af7f3adecb4f.camel@perches.com>
Subject: Re: [PATCH v2] docs: Explain the desired position of function
 attributes
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Thu, 30 Sep 2021 19:54:30 -0700
In-Reply-To: <202109301530.4BAFDBB1@keescook>
References: <20210930192417.1332877-1-keescook@chromium.org>
         <c273a5d9-ecd7-64fa-bf2c-af0d22c4a68c@infradead.org>
         <202109301530.4BAFDBB1@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q7qaun6o513refy4ey5h1c6eesg85xjt
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1DDCBC4178
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+MCFVHU7V1tbh/ZMSEEIqUz16AlGeZr9w=
X-HE-Tag: 1633056871-605293
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 2021-09-30 at 15:52 -0700, Kees Cook wrote:
> I have read and re-read Linus's emails, and did a frequency count in the
> kernel, and it looks like the preference is [return type] [return type attrs]

Please don't read too much into frequency counts as it really depends
on age of code.

> but I personally agree with you. :)
> 
> # regex I built from __must_check hits...
> $ re='((struct .*|void|char) \* ?|((unsigned )?(long|int)|bool|size_t)($| ))'
> 
> # type before __must_check
> $ git grep -E "$re"'__must_check' | wc -l
> 746
> 
> # type after __must_check
> $ git grep -E '\b(static (__always_)?inline )?__must_check($| '"$re"')' | wc -l
> 297

Hmm.

$ git grep -w __must_check -- '*.[ch]' | wc -l
909


