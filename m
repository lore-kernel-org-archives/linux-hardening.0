Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63645C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BC260F92
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 17:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhJZRDS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 13:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237690AbhJZRDP (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 13:03:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1FB260F56;
        Tue, 26 Oct 2021 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635267651;
        bh=N6mR0nlTyP972P3SDjcUELwCXA7yQW09NYrXCt3cNP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9cJElx7TbZRVKmslx3nX/2j52TV7RP0OzseU83Aa//zyUqdfPhyvvp2G6siUmNDr
         uONKV6BqBwe9EmAPDX6enH3cD7c6fz09eaJY8za/FOdWp6jOB7VUrbCfu2lGlc0WLl
         /wn9T914dIdDshexgKmKmBETBG9xY1KJ1YQ76Y4Oxw9cxD+zVv68hHsLxlSFeGGDmZ
         rl6pMFIwKAPtAgo4Qqs63e6LRgDDfTpTcMIdEEd27W+mAS5OkjdMLCBfIpWsWhCCUm
         jtaMP4ux8I0SB0IqjFCfPgTIgfgCh42BSakDcINgNfn3nbnB/IqH8raHN5kvP1mTNo
         WQA2yfYjl+HeQ==
Date:   Tue, 26 Oct 2021 12:05:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] docs: deprecated.rst: Clarify open-coded arithmetic
 with literals
Message-ID: <20211026170544.GA1457721@embeddedor>
References: <20210925143455.21221-1-len.baker@gmx.com>
 <871r47g59t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r47g59t.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 26, 2021 at 09:44:14AM -0600, Jonathan Corbet wrote:
[..]
> >  - Reword the sentence to comunicate better (Jonathan Corbet).
> >
> > The previous version can be found here [1].
> >
> > [1] https://lore.kernel.org/linux-hardening/20210829144716.2931-1-len.baker@gmx.com/
> 
> Applied, thanks.

Thanks, Jonathan.
--
Gustavo
