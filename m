Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92A5C433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAB36054F
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350186AbhICREV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:04:21 -0400
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:49408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235774AbhICREU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Sep 2021 13:04:20 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9AF37181D861A;
        Fri,  3 Sep 2021 17:03:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id E361C20A296;
        Fri,  3 Sep 2021 17:03:18 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 03 Sep 2021 10:03:18 -0700
From:   Joe Perches <joe@perches.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] EDAC/mc: Prefer strscpy or scnprintf over strcpy
In-Reply-To: <20210903150539.7282-1-len.baker@gmx.com>
References: <20210903150539.7282-1-len.baker@gmx.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <3a035a3ec4571a622ce640e042f9a119@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Stat-Signature: j7xjyr4odatdy7rb6mkgdmxeee87f933
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: E361C20A296
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+E6cAmHeP0H2cTANzNcBy/xjzDpz0K7BE=
X-HE-Tag: 1630688598-308236
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2021-09-03 08:05, Len Baker wrote:
> strcpy() performs no bounds checking on the destination buffer. 
> len.baker@gmx.com/

[]

> @@ -1113,12 +1115,9 @@ void edac_mc_handle_error(const enum
> hw_event_mc_err_type type,
>  			p = e->label;
>  			*p = '\0';
>  		} else {
> -			if (p != e->label) {
> -				strcpy(p, OTHER_LABEL);
> -				p += strlen(OTHER_LABEL);
> -			}
> -			strcpy(p, dimm->label);
> -			p += strlen(p);
> +			n += scnprintf(e->label + n, sizeof(e->label) - n,
> +				       "%s%s", prefix, dimm->label);
> +			prefix = OTHER_LABEL;

OTHER_LABEL is a define specific to this module

IMO: Used once text macros are just obfuscating and should be removed.
