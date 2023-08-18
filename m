Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836E7C71136
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 07:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358115AbjHRHOn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 03:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358101AbjHRHOS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 03:14:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20130DF
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 00:14:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-74-ikIsBU2DMkidrrqivs1qkQ-1; Fri, 18 Aug 2023 08:14:14 +0100
X-MC-Unique: ikIsBU2DMkidrrqivs1qkQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 18 Aug
 2023 08:14:12 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 18 Aug 2023 08:14:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>
CC:     'Przemek Kitszel' <przemyslaw.kitszel@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Steven Zou" <steven.zou@intel.com>
Subject: RE: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Topic: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Index: AQHZ0EteSw2XTdntxkSn8fWObNOCVK/uiVWQgAAd6ICAAP4u4A==
Date:   Fri, 18 Aug 2023 07:14:11 +0000
Message-ID: <e8e109712a1b42288951c958d2f503a5@AcuMS.aculab.com>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
 <202308170957.F511E69@keescook>
In-Reply-To: <202308170957.F511E69@keescook>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook
> Sent: Thursday, August 17, 2023 6:00 PM
> 
> On Thu, Aug 17, 2023 at 02:35:23PM +0000, David Laight wrote:
> > From: Przemek Kitszel
> > > Sent: Wednesday, August 16, 2023 3:06 PM
...
> > > +#define DEFINE_FLEX(type, name, member, count)					\
> > > +	union {									\
> > > +		u8 bytes[struct_size_t(type, member, count)];			\
> > > +		type obj;							\
> > > +	} name##_u __aligned(_Alignof(type)) = {};				\
> >
> > You shouldn't need the _Alignof() it is the default.
> 
> In the sense that since "type" is in the union, it's okay?

The alignment of the union is the larger of the alignments
of all its members.
Which is what you want.

> > I'm not sure you should be forcing the memset() either.
> 
> This already got discussed: better to fail safe.

Perhaps call it DEFINE_FLEX_Z() to make this clear and
give the option for a non-zeroing version later.
Not everyone wants the expense of zeroing everything.

..
> > You might want to add:
> > 	Static_assert(is_constexpr(count), "DEFINE_FLEX: non-constant count " #count);
> 
> That would be nice, though can Static_assert()s live in the middle of
> variable definitions?

I checked and it is fine.
(I double-checked by adding a statement and getting an error.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

