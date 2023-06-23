Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F41C0015E
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Jun 2023 13:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjFWNlS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Jun 2023 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFWNlR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Jun 2023 09:41:17 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88B862688;
        Fri, 23 Jun 2023 06:41:16 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E9A1392009C; Fri, 23 Jun 2023 15:41:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E507992009B;
        Fri, 23 Jun 2023 14:41:14 +0100 (BST)
Date:   Fri, 23 Jun 2023 14:41:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] MIPS: dec: prom: Address -Warray-bounds warning
In-Reply-To: <20230623131019.GD11636@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2306231432120.14084@angie.orcam.me.uk>
References: <ZJTcvfpvhvF+OLjc@work> <20230623131019.GD11636@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 23 Jun 2023, Thomas Bogendoerfer wrote:

> > Zero-length arrays are deprecated, and we are replacing them with flexible
> > array members instead. So, replace zero-length array with flexible-array
> > member in struct memmap.

 Technically it is a semantics bug fix actually, as the TURBOchannel 
firmware specification (from Jan 1993) says it's:

typedef struct{ int pagesize; unsigned char bitmap[];}memmap;
int getbitmap(memmap *map);

(formatting preserved as in the document) so it should have always been a 
flexible array member.  Maybe old (2.x) GCC versions had an issue with it 
or something, as otherwise I can't imagine why whoever added our typedef 
did it differently from the spec.

> applied to mips-next.

 Not sure if you can retrofit it, but:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
