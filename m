Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC1C63697
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 16:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EAAB221F8
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 16:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgKWQvS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:51:18 -0500
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:56200 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729474AbgKWQvS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Nov 2020 11:51:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0CE22180064DA;
        Mon, 23 Nov 2020 16:51:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: offer33_340137427367
X-Filterd-Recvd-Size: 2459
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Nov 2020 16:51:15 +0000 (UTC)
Message-ID: <276a532e28d290abaaf9cd5969cbacecd51cabc9.camel@perches.com>
Subject: Re: [PATCH 001/141] afs: Fix fall-through warnings for Clang
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Mon, 23 Nov 2020 08:51:14 -0800
In-Reply-To: <748935.1606147853@warthog.procyon.org.uk>
References: <5e9c1d953c6b6254a3288f1e797064666e82a79d.camel@perches.com>
         <cover.1605896059.git.gustavoars@kernel.org>
         <51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org>
         <748935.1606147853@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 2020-11-23 at 16:10 +0000, David Howells wrote:
> Joe Perches <joe@perches.com> wrote:
> 
> > >  		call->unmarshall++;
> > > +
> > > +		fallthrough;
> > 
> > My preference would be to change these to break and not fallthrough;
> > 
> > >  	case 5:
> > >  		break;
> > >  	}
> 
> My preference would be to fall through.  The case number is the state machine
> state, as indexed by call->unmarshall.

Then ideally the state machine states should be enums and not numbers
and the compiler should use a default block for unhandled states right?

Is code like call->marshall++ a common style for kernel state machines?
Perhaps not.

Does it work?
Sure.

Is it obvious what the transitions are?
No.

> All the other cases in the switch fall through.
> 
> I would also generally prefer that the fallthrough statement occur before the
> blank line, not after it, since it belongs with the previous clause, and not
> between a comment about a case statement and its associated case statement,
> i.e.:
> 
> 		afs_extract_to_tmp(call);
> 		call->unmarshall++;
> 
> 		/* extract the callback array and its count in two steps */
> 		fallthrough;
> 	case 3:
> 
> would be better written as:
> 
> 		afs_extract_to_tmp(call);
> 		call->unmarshall++;
> 		fallthrough;
> 
> 		/* extract the callback array and its count in two steps */
> 	case 3:

I agree completely.


