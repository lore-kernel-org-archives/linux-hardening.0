Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD0C433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Mar 2021 23:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E9D64EEE
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Mar 2021 23:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCQXpP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Mar 2021 19:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQXpJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Mar 2021 19:45:09 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Mar 2021 16:45:09 PDT
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 206F6C06174A
        for <linux-hardening@vger.kernel.org>; Wed, 17 Mar 2021 16:45:08 -0700 (PDT)
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0D7F562BA4;
        Thu, 18 Mar 2021 00:37:09 +0100 (CET)
Date:   Thu, 18 Mar 2021 00:37:09 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND][next] netfilter: Fix fall-through warnings for
 Clang
Message-ID: <20210317233709.GA2504@salvia>
References: <20210305084209.GA138063@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305084209.GA138063@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 05, 2021 at 02:42:09AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead of just
> letting the code fall through to the next case.

Applied to nf-next, thanks.
