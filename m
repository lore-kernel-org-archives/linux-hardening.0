Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F7AC30627
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 14:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351958AbjHQOgB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352002AbjHQOfd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 10:35:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E52D76
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 07:35:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-6-t1ZLIpC4P7uCuSrIMZoxRA-1; Thu, 17 Aug 2023 15:35:27 +0100
X-MC-Unique: t1ZLIpC4P7uCuSrIMZoxRA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 15:35:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 17 Aug 2023 15:35:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Przemek Kitszel' <przemyslaw.kitszel@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Steven Zou" <steven.zou@intel.com>
Subject: RE: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Topic: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Index: AQHZ0EteSw2XTdntxkSn8fWObNOCVK/uiVWQ
Date:   Thu, 17 Aug 2023 14:35:23 +0000
Message-ID: <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
In-Reply-To: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
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

From: Przemek Kitszel
> Sent: Wednesday, August 16, 2023 3:06 PM
> 
> Using underlying array for on-stack storage lets us to declare
> known-at-compile-time structures without kzalloc().

Isn't DEFINE_FLEX() a bit misleading?
One thing it isn't is 'flexible' since it has a fixed size.

> +#define DEFINE_FLEX(type, name, member, count)					\
> +	union {									\
> +		u8 bytes[struct_size_t(type, member, count)];			\
> +		type obj;							\
> +	} name##_u __aligned(_Alignof(type)) = {};				\

You shouldn't need the _Alignof() it is the default.
I'm not sure you should be forcing the memset() either.

> +	type *name = (type *)&name##_u

How about?
	type *const name = &name_##_u.obj;

You might want to add:
	Static_assert(is_constexpr(count), "DEFINE_FLEX: non-constant count " #count);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

