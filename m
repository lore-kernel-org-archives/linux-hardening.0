Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD169C2D0E4
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A22223B0
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 23:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgKTXlV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:41:21 -0500
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:36208 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbgKTXlV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 18:41:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id CAC311DE0;
        Fri, 20 Nov 2020 23:41:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: light89_501494f2734f
X-Filterd-Recvd-Size: 1739
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Nov 2020 23:41:18 +0000 (UTC)
Message-ID: <97e87baf1dae54e56655d1034886f19bba06d13f.camel@perches.com>
Subject: Re: [PATCH 001/141] afs: Fix fall-through warnings for Clang
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date:   Fri, 20 Nov 2020 15:41:17 -0800
In-Reply-To: <83d2d50c-1708-f4a7-0e2f-c3c5a6b9e736@embeddedor.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
         <51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org>
         <5e9c1d953c6b6254a3288f1e797064666e82a79d.camel@perches.com>
         <83d2d50c-1708-f4a7-0e2f-c3c5a6b9e736@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 2020-11-20 at 17:28 -0600, Gustavo A. R. Silva wrote:
> On 11/20/20 17:18, Joe Perches wrote:
> 
> > My preference would be to change these to break and not fallthrough;
> 
> And my preference is fallthrough.

If so, that's an unusual choice here as it seems most or all of
the other patches you submitted use break in the same situation
where the next case is a single line break;

see: patches 2, 3, 4, 8, 9, etc...

> Joe, please, let the maintainer share their opinion on this first.

Why?
My preferences are my preferences and I don't mind announcing them.

