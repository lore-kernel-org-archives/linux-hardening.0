Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A63C432BE
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 19:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B7E60F39
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 19:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhH0THN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Aug 2021 15:07:13 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:47348 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230405AbhH0THN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Aug 2021 15:07:13 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 18073181FFCD7;
        Fri, 27 Aug 2021 19:06:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id DA7D21E04D8;
        Fri, 27 Aug 2021 19:06:20 +0000 (UTC)
Message-ID: <bd7487c725e15b0c20612a44ecf301637a60c157.camel@perches.com>
Subject: Re: [PATCH] docs: deprecated.rst: Clarify open-coded arithmetic
 with literals
From:   Joe Perches <joe@perches.com>
To:     Len Baker <len.baker@gmx.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Fri, 27 Aug 2021 12:06:18 -0700
In-Reply-To: <20210827171226.2938-1-len.baker@gmx.com>
References: <20210827171226.2938-1-len.baker@gmx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: xbgfsqba9wxwpwxd1pandj15ocaigmbt
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DA7D21E04D8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+BH4zRMi41Wrmm5oI1t237jWH/vS28Tg0=
X-HE-Tag: 1630091180-141653
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 2021-08-27 at 19:12 +0200, Len Baker wrote:
> Although using literals for size calculation in allocator arguments may
> be harmless due to compiler warnings in case of overflows, it is better
> to refactor the code to avoid the use of open-coded math idiom.
> 
> So, clarify the preferred way in these cases.
[]
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
[]
> @@ -60,7 +60,8 @@ smaller allocation being made than the caller was expecting. Using those
>  allocations could lead to linear overflows of heap memory and other
>  misbehaviors. (One exception to this is literal values where the compiler
>  can warn if they might overflow. Though using literals for arguments as
> -suggested below is also harmless.)
> +suggested below is also harmless. So, the preferred way in these cases is
> +to refactor the code to keep the open-coded math idiom out.)

wordsmithing trivia:

'keep <foo> out' is difficult to parse as 'keep' is generally a positive
word but its meaning is later reversed with out.

'avoid <foo>' maybe be better phrasing.


