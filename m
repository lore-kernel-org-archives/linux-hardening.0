Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D149C5519F
	for <linux-hardening@archiver.kernel.org>; Sun, 15 Nov 2020 00:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B3D24073
	for <linux-hardening@archiver.kernel.org>; Sun, 15 Nov 2020 00:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNgzuQLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKOASj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 Nov 2020 19:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgKOASi (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 Nov 2020 19:18:38 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D8424073;
        Sun, 15 Nov 2020 00:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605399518;
        bh=1EWdZ3uqzRI1YtLk3PdljkOSucPzTG6JNmjZxiKAfPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SNgzuQLvn6ZgQJBsGtF2fooM2RDBBLraeOGEyIGSHBnQASwRBPzUlqtORF0dKZgUw
         6qXq5PMdqz6xlwoF94qLom6wztSrwfX0kDmYz1lo2Td71YkT1nMdIQNrzh2abFjrhP
         Ia81ss4TJ0QvtbqCQviyhKMBR/fWl987xpWYdt04=
Date:   Sat, 14 Nov 2020 16:18:37 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     laniel_francis@privacyrequired.com,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH v5 0/3] Fix inefficiences and rename nla_strlcpy
Message-ID: <20201114161837.10f58f95@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202011131054.28BD6A9@keescook>
References: <20201113111133.15011-1-laniel_francis@privacyrequired.com>
        <202011131054.28BD6A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 13 Nov 2020 10:56:26 -0800 Kees Cook wrote:
> Thanks! This looks good to me.
> 
> Jakub, does this look ready to you?

Yup, looks good, sorry!

But it didn't get into patchwork cleanly :/

One more resend please? (assuming we're expected to take this 
into net-next)
