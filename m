Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AECC63777
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 13:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E16222BA
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 13:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgKTNfD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 08:35:03 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:34002 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728073AbgKTNfD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 08:35:03 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-307-k68k3iBwMt6esAsLjNMf2g-1; Fri, 20 Nov 2020 13:33:53 +0000
X-MC-Unique: k68k3iBwMt6esAsLjNMf2g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 13:33:53 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 13:33:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>,
        "laniel_francis@privacyrequired.com" 
        <laniel_francis@privacyrequired.com>
CC:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dja@axtens.net" <dja@axtens.net>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: RE: [PATCH v6 0/5] Fortify strscpy()
Thread-Topic: [PATCH v6 0/5] Fortify strscpy()
Thread-Index: AQHWvt28L9KcmdS460uoK5rk/t0ar6nRBYCg
Date:   Fri, 20 Nov 2020 13:33:53 +0000
Message-ID: <824aad3a91254445b0f30359f1606e2a@AcuMS.aculab.com>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com>
 <20201119173543.8821881942022fc4f39c4c73@linux-foundation.org>
In-Reply-To: <20201119173543.8821881942022fc4f39c4c73@linux-foundation.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Andrew Morton
> Sent: 20 November 2020 01:36
...
> Could you please send along a reworked [0/n] cover letter?  Explain in
> your own words, without requiring that readers go off and read web
> pages
> 
> - What problem the patchset solves
> - How it solves it
> - The value of the patchset (to kernel developers or to end-users) so that we
>   can understand why it should be merged.

- How much it slows things down.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

