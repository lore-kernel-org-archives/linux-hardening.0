Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AF4C433ED
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Apr 2021 23:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A469C61404
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Apr 2021 23:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbhDUXJd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343639AbhDUXJc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Apr 2021 19:09:32 -0400
X-Greylist: delayed 298 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Apr 2021 16:08:58 PDT
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.secure-endpoints.com [IPv6:2001:470:1f07:f77:70f5:c082:a96a:5685])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8617C06174A
        for <linux-hardening@vger.kernel.org>; Wed, 21 Apr 2021 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
        d=auristor.com; s=MDaemon; r=y; t=1619046237; x=1619651037;
        i=jaltman@auristor.com; q=dns/txt; h=Subject:To:Cc:References:
        From:Organization:Message-ID:Date:User-Agent:MIME-Version:
        In-Reply-To:Content-Type; bh=svaA56JyCVBMA4sH8+QhPKmyZQzC30F8uYq
        c8IJtzS4=; b=twFeLca/2kdXVieHYAGoPhLu2xtqdOhAmqbT4Av+ppVP1t2jVtY
        /tXlcPxOOJJ+nG/SvV2arzIfubt3QYSIVXRlxRfvB4tpdfUYS0qiClalvid/UHvU
        mhCk5J9vCttua5HpMJYDkQqCTJR8cSk4hPm3fvCdlEGn0f0hnC5lHeWQ=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 21 Apr 2021 19:03:57 -0400
Received: from [IPv6:2603:7000:73d:4f22:a130:f9e2:913b:3942] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v21.0.1) 
        with ESMTPSA id md5001002923289.msg; Wed, 21 Apr 2021 19:03:56 -0400
X-MDRemoteIP: 2603:7000:73d:4f22:a130:f9e2:913b:3942
X-MDHelo: [IPv6:2603:7000:73d:4f22:a130:f9e2:913b:3942]
X-MDArrival-Date: Wed, 21 Apr 2021 19:03:56 -0400
X-MDOrigin-Country: United States, North America
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1745ad0e69=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] afs: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva (gustavoars@kernel.org)" <gustavoars@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210420211615.GA51432@embeddedor>
From:   Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Message-ID: <45926d81-cfae-8465-84e6-af76d668c1ef@auristor.com>
Date:   Wed, 21 Apr 2021 19:03:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210420211615.GA51432@embeddedor>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X0jWOGGYxsMP3iN5tfoIEdjkPxZix9kpE"
X-MDCFSigsAdded: auristor.com
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X0jWOGGYxsMP3iN5tfoIEdjkPxZix9kpE
Content-Type: multipart/mixed; boundary="gRcyHZ2wmjW9ayFyvkpfEJhKRdynUjywo";
 protected-headers="v1"
From: Jeffrey E Altman <jaltman@auristor.com>
To: "Gustavo A. R. Silva (gustavoars@kernel.org)" <gustavoars@kernel.org>,
 David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Message-ID: <45926d81-cfae-8465-84e6-af76d668c1ef@auristor.com>
Subject: Re: [PATCH v2][next] afs: Fix fall-through warnings for Clang
References: <20210420211615.GA51432@embeddedor>
In-Reply-To: <20210420211615.GA51432@embeddedor>

--gRcyHZ2wmjW9ayFyvkpfEJhKRdynUjywo
Content-Type: multipart/mixed;
 boundary="------------92303E2F8BC9BFB02BE72ECD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------92303E2F8BC9BFB02BE72ECD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 4/20/2021 5:16 PM, Gustavo A. R. Silva (gustavoars@kernel.org) wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple=

> warnings by explicitly adding multiple fallthrough pseudo-keywords
> in places where the code is intended to fall through to the next
> case.
>=20
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>   - Place blank line after the fallthrough markings, not before.
>     Link: https://lore.kernel.org/linux-hardening/748935.1606147853@war=
thog.procyon.org.uk/

This change looks good to me.

Reviewed-by: Jeffrey Altman <jaltman@auristor.com>



--------------92303E2F8BC9BFB02BE72ECD
Content-Type: text/x-vcard; charset=utf-8;
 name="jaltman.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="jaltman.vcf"

begin:vcard
fn:Jeffrey Altman
n:Altman;Jeffrey
org:AuriStor, Inc.
adr:;;255 W 94TH ST STE 6B;New York;NY;10025-6985;United States
email;internet:jaltman@auristor.com
title:CEO
tel;work:+1-212-769-9018
url:https://www.linkedin.com/in/jeffreyaltman/
version:2.1
end:vcard


--------------92303E2F8BC9BFB02BE72ECD--

--gRcyHZ2wmjW9ayFyvkpfEJhKRdynUjywo--

--X0jWOGGYxsMP3iN5tfoIEdjkPxZix9kpE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+kRK8Zf0SbJM8+aZ93pzVZK2mgQFAmCAr1MFAwAAAAAACgkQ93pzVZK2mgRB
Jw/9EWFZCGZiOd3lYfyWJL2CYtAJTNp62QgG7NLp6zgMsDGPDRc8GzE54EcvhdKoCJSRm069RaC8
kSRxs8gQ0+pbdb26a8jkKSCIU1sOAqXXXju/aRLGHmFyRx5DkAj2gZW5cpV6KopnWky19B9LwuOV
O15ZY2iANiPlee/iRva4fSBkhFXVYLaFDhYxgP3zGn10U9U88NSZ/OVqGoEicBkeqyRY8V99Ahy2
u00Y5kSNURTRlQvZonw7qqASPIX+R/30weOY5OklrP2VDcm2G9S9VEqqlWb6k/LI4XaHgijR1t4A
ZEHQKc65LVO7IMS4ufwCmf0TYtAdjLFwoBQPGU/QSJCJcg63rjtYi4nSMwyFW5m0JUfON7fGgze7
IzN6YnU95yTSei2Nbq1t3zJ0QCjqANH1BDmpSWOS8x1+rzuSik7BaF7nSF32+xpa4LyOfbfy3vkH
Dqbk7v0H0XRbG5cKOt9cADakcDT/vjauMR3Yuwu6oE0yG6KymaazOD+nHmJA5zPYpX++0memWV7v
00CQai0opoJKKREXN9ttDhDDKFJMxvER6prP5U+QZ/mSFaKaPRy8SHlZFwIx/4v3DX8dbARp6/MT
U0aokm1ILIatLoxkanB4jrzGOsVbiDSR7DmkWZx6xtnFGpv7J8rCyHA1zY6nQTUiVgcpeyZT9net
TGc=
=4w1V
-----END PGP SIGNATURE-----

--X0jWOGGYxsMP3iN5tfoIEdjkPxZix9kpE--

