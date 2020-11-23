Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE46BC2D0E4
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96ACA2076E
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 16:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PICnlhJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbgKWQLC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732681AbgKWQLC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Nov 2020 11:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606147861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/D/w3/Beq3jPbWwSJqZ+76GekUp50AARCEuAVbF/pa8=;
        b=PICnlhJjV/oJvVISCHI1XwtYbA0K55/CIww1/psBp4qx5f/h3yoiQ3L2dZ2FXAlh5yKOAr
        pEv42VT286q+P6o3RxIJetzUYuzT42TxdLYG19JZl3LIBrKQxCWe2Bd3OwneFN9wAw5uhA
        fE0eLKSGjg2EBcfJrMZ2R0sb3GlnGi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-LJ_CPGnSPw6aiicjtAC1Pg-1; Mon, 23 Nov 2020 11:10:58 -0500
X-MC-Unique: LJ_CPGnSPw6aiicjtAC1Pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEC98805BE0;
        Mon, 23 Nov 2020 16:10:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4A93620DE;
        Mon, 23 Nov 2020 16:10:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5e9c1d953c6b6254a3288f1e797064666e82a79d.camel@perches.com>
References: <5e9c1d953c6b6254a3288f1e797064666e82a79d.camel@perches.com> <cover.1605896059.git.gustavoars@kernel.org> <51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     dhowells@redhat.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 001/141] afs: Fix fall-through warnings for Clang
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 23 Nov 2020 16:10:53 +0000
Message-ID: <748935.1606147853@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Joe Perches <joe@perches.com> wrote:

> > =C2=A0		call->unmarshall++;
> > +
> > +		fallthrough;
>=20
> My preference would be to change these to break and not fallthrough;
>=20
> > =C2=A0	case 5:
> > =C2=A0		break;
> > =C2=A0	}

My preference would be to fall through.  The case number is the state machi=
ne
state, as indexed by call->unmarshall.  All the other cases in the switch f=
all
through.

I would also generally prefer that the fallthrough statement occur before t=
he
blank line, not after it, since it belongs with the previous clause, and not
between a comment about a case statement and its associated case statement,
i.e.:

		afs_extract_to_tmp(call);
		call->unmarshall++;

		/* extract the callback array and its count in two steps */
		fallthrough;
	case 3:

would be better written as:

		afs_extract_to_tmp(call);
		call->unmarshall++;
		fallthrough;

		/* extract the callback array and its count in two steps */
	case 3:

David

