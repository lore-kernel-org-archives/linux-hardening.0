Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08DDC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 09:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B9660F24
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 09:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKBJsL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 05:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhKBJsH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 05:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635846332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYxvqfKyKtI4tu/9sa2DOgaLzeCCe5kytXHcdT7EDvU=;
        b=CPCWVN6fACV1mC3xIu4Uy1VVC7xrOCWoKUYxcVI7XBxY7XpjYlcA2guxLdUIvR0ti0Kjkj
        nJjtcqpNMSSxGMCVVtUCGw2gKKZhzx/E+uWkt2IaBtYAdg8X8oSN/EMBV31X4Wny2XO2BM
        kvVllde/20hF6DUXdRGTQpwgCayZgw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-4x6F5WCcPPyxkNENe6Mihg-1; Tue, 02 Nov 2021 05:45:27 -0400
X-MC-Unique: 4x6F5WCcPPyxkNENe6Mihg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40EBE1006AA2;
        Tue,  2 Nov 2021 09:45:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3F4A60D30;
        Tue,  2 Nov 2021 09:45:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210919094432.30510-1-len.baker@gmx.com>
References: <20210919094432.30510-1-len.baker@gmx.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-afs@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Prefer struct_size over open coded arithmetic
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4028804.1635846297.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 Nov 2021 09:44:57 +0000
Message-ID: <4028805.1635846297@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Len Baker <len.baker@gmx.com> wrote:

> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> =

> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + size * count" in the kzalloc() function.
> =

> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments
> =

> Signed-off-by: Len Baker <len.baker@gmx.com>

Acked-by: David Howells <dhowells@redhat.com>

