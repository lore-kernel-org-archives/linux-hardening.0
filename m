Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E12C433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 15 Oct 2022 05:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJOFlv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 15 Oct 2022 01:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJOFlu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 15 Oct 2022 01:41:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA96F46201
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 22:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9710CB80765
        for <linux-hardening@vger.kernel.org>; Sat, 15 Oct 2022 05:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AFFC433C1;
        Sat, 15 Oct 2022 05:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665812503;
        bh=Pi35j2KN1EpWr0zqHxmFsh3EoZMtxdSY1TFZwcIy1xU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhxluX6RejVF4/Qm4KTL4wcx1NT7+qeCzjIAJSzPJD5+1k66/dSgQhKm+B89HSuGS
         pqiSdH9Ea3UFpDRomP3oT1/jzu9hH3qsdGi7jPF2kpaMrdZp8ARRTtcmvS5Z6qPo6k
         kv0GYlrGe8y9vO89jJdqyVbRMSA2ljPygV1fHAns=
Date:   Sat, 15 Oct 2022 07:42:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Simon Brand <simon.brand@postadigitale.de>,
        linux-hardening@vger.kernel.org
Subject: Re: Reconsider possibility to disable icotl TIOCSTI
Message-ID: <Y0pIRKpPwqk2Igu/@kroah.com>
References: <Y0m9l52AKmw6Yxi1@hostpad>
 <202210142135.252DFDF3C8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210142135.252DFDF3C8@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 14, 2022 at 09:37:04PM -0700, Kees Cook wrote:
> On Fri, Oct 14, 2022 at 07:51:11PM +0000, Simon Brand wrote:
> > please reconsider to add a possibility to disable icotl TIOCSTI.
> 
> Yeah, please, let's. I always wanted to, and its use case is very
> narrow. Even OpenBSD has removed it, somewhat motivated by the attempt
> to remove it from Linux in 2017. I've sent this now:
> 
> https://lore.kernel.org/linux-hardening/20221015041626.1467372-2-keescook@chromium.org/

Looks good to me, I'll queue it up once -rc1 is out.

greg k-h
