Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F415AC7618E
	for <linux-hardening@archiver.kernel.org>; Fri, 21 Apr 2023 13:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjDUNJl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 21 Apr 2023 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjDUNJk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 21 Apr 2023 09:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DD9527B
        for <linux-hardening@vger.kernel.org>; Fri, 21 Apr 2023 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682082537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eQnsBmjQDpvOsMgDQVzEiSuWLeqhHCBZpx3k6XC3WWA=;
        b=KADKbyJSjU9G3ZmSoCTgTeI9/yD00VH0IizUq8CgSjLG7gDszBlgtsKmh5++6u6WS/jLqk
        TxNRUNpPRkmFtZjpwBRS5FL/tJbj1wXdnjW7yRCpHIKUy8yY8iEmYdh/PHkDPac961H0Kj
        SzJP1nTt/VW3kwURJxsmSI7REcjGOOI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-HzUmGbAsM_OAGhC59McdgQ-1; Fri, 21 Apr 2023 09:08:56 -0400
X-MC-Unique: HzUmGbAsM_OAGhC59McdgQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFCF438123D2;
        Fri, 21 Apr 2023 13:08:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45749492C3E;
        Fri, 21 Apr 2023 13:08:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
cc:     dhowells@redhat.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rxrpc: Replace fake flex-array with flexible-array member
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 21 Apr 2023 14:08:53 +0100
Message-ID: <84871.1682082533@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


From: Gustavo A. R. Silva <gustavoars@kernel.org>

Zero-length arrays as fake flexible arrays are deprecated and we are
moving towards adopting C99 flexible-array members instead.

Transform zero-length array into flexible-array member in struct
rxrpc_ackpacket.

Address the following warnings found with GCC-13 and
-fstrict-flex-arrays=3D3 enabled:
net/rxrpc/call_event.c:149:38: warning: array subscript i is outside array =
bounds of =E2=80=98uint8_t[0]=E2=80=99 {aka =E2=80=98unsigned char[]=E2=80=
=99} [-Warray-bounds=3D]

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3D3 [1].

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/263
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: linux-hardening@vger.kernel.org
Link: https://lore.kernel.org/r/ZAZT11n4q5bBttW0@work/
---
 net/rxrpc/protocol.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/protocol.h b/net/rxrpc/protocol.h
index 6760cb99c6d6..e8ee4af43ca8 100644
--- a/net/rxrpc/protocol.h
+++ b/net/rxrpc/protocol.h
@@ -126,7 +126,7 @@ struct rxrpc_ackpacket {
 	uint8_t		nAcks;		/* number of ACKs */
 #define RXRPC_MAXACKS	255
=20
-	uint8_t		acks[0];	/* list of ACK/NAKs */
+	uint8_t		acks[];		/* list of ACK/NAKs */
 #define RXRPC_ACK_TYPE_NACK		0
 #define RXRPC_ACK_TYPE_ACK		1
=20

