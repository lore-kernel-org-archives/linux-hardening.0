Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE2FC433B4
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Apr 2021 03:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1393961405
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Apr 2021 03:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhDUDLi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 23:11:38 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:58010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233982AbhDUDLi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 23:11:38 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E606A180A4C06;
        Wed, 21 Apr 2021 03:11:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id E390A1727B;
        Wed, 21 Apr 2021 03:11:03 +0000 (UTC)
Message-ID: <0d799df884ec9088501d6699c6ed97728eebad53.camel@perches.com>
Subject: Re: [PATCH][next] xfs: Fix fall-through warnings for Clang
From:   Joe Perches <joe@perches.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Tue, 20 Apr 2021 20:11:02 -0700
In-Reply-To: <20210420233850.GQ3122264@magnolia>
References: <20210420230652.GA70650@embeddedor>
         <20210420233850.GQ3122264@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n8q5t1jinm7iudrkas9iyu5kh5yn19cp
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E390A1727B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18TDD6CZMrsoSDQXol/66jarNtjAfzvFAs=
X-HE-Tag: 1618974663-505523
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 2021-04-20 at 16:38 -0700, Darrick J. Wong wrote:
> On Tue, Apr 20, 2021 at 06:06:52PM -0500, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix
> > the following warnings by replacing /* fall through */ comments,
> > and its variants, with the new pseudo-keyword macro fallthrough:
[]
> > Notice that Clang doesn't recognize /* fall through */ comments as
> > implicit fall-through markings, so in order to globally enable
> > -Wimplicit-fallthrough for Clang, these comments need to be
> > replaced with fallthrough; in the whole codebase.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> I've already NAKd this twice, so I guess I'll NAK it a third time.

Sorry, I've must have missed it before.  Why did you NAK this?

