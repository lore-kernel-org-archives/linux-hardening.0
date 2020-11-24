Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2EAC2D0E4
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Nov 2020 13:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5ED2076E
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Nov 2020 13:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWQJtGPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgKXNVi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:21:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387814AbgKXNVh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Nov 2020 08:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606224095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MY+7jcCufiMBlnAlm49EA25ZRhXVO7Dk5xiZ2I4LXFQ=;
        b=YWQJtGPnlfh2nw8Genp0Jqk99fwiyVw0ZNkXnk04kJRQ5KFuE7GEbdNFPUSatvjXc5w/Fe
        bVCnKYLzh607/Uipeet7NkFjavnlCKLv951doOGNN31YyFeF9EO6jQKmvzfMiwb++XnkEq
        oIZ6irfdizv4DJrfUinrJbsqjkY8OGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-wqreApeXPZqstMgo0BABzg-1; Tue, 24 Nov 2020 08:21:33 -0500
X-MC-Unique: wqreApeXPZqstMgo0BABzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2A831087D60;
        Tue, 24 Nov 2020 13:21:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76EE75D9CC;
        Tue, 24 Nov 2020 13:21:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <276a532e28d290abaaf9cd5969cbacecd51cabc9.camel@perches.com>
References: <276a532e28d290abaaf9cd5969cbacecd51cabc9.camel@perches.com> <5e9c1d953c6b6254a3288f1e797064666e82a79d.camel@perches.com> <cover.1605896059.git.gustavoars@kernel.org> <51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org> <748935.1606147853@warthog.procyon.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     dhowells@redhat.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 001/141] afs: Fix fall-through warnings for Clang
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1277741.1606224090.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 24 Nov 2020 13:21:30 +0000
Message-ID: <1277742.1606224090@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Joe Perches <joe@perches.com> wrote:

> > My preference would be to fall through.  The case number is the state =
machine
> > state, as indexed by call->unmarshall.
> =

> Then ideally the state machine states should be enums and not numbers
> and the compiler should use a default block for unhandled states right?
> =

> Is code like call->marshall++ a common style for kernel state machines?
> Perhaps not.

How the value is interpreted is unique to each delivery function, of which
there are a number, since it counts out the separate parts of the xdr enco=
ding
for that particular RPC request or reply block.

Maybe "state machine" isn't the right term.

David

