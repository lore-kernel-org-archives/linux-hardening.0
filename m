Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9380CC433E0
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 11:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB9B64F4D
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 11:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCRLmE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:42:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35867 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbhCRLld (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 07:41:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-3-7h7ICMGPN3-qVP8vMIq3hg-1; Thu, 18 Mar 2021 11:41:30 +0000
X-MC-Unique: 7h7ICMGPN3-qVP8vMIq3hg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 18 Mar 2021 11:41:29 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 18 Mar 2021 11:41:29 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?windows-1257?Q?=27Valdis_Kl=E7tnieks=27?= 
        <valdis.kletnieks@vt.edu>, Kees Cook <keescook@chromium.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on old
 gcc
Thread-Topic: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on
 old gcc
Thread-Index: AQHXG7xcElVT0YEvr0m/P+UnKynj6KqJn0dQ
Date:   Thu, 18 Mar 2021 11:41:29 +0000
Message-ID: <279b22592f1e43a48beeecd34e50b385@AcuMS.aculab.com>
References: <279558.1615192821@turing-police> <202103172251.F9D770D@keescook>
 <282490.1616047333@turing-police>
In-Reply-To: <282490.1616047333@turing-police>
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

From: Valdis Kletnieks
> Sent: 18 March 2021 06:02
> 
> On Wed, 17 Mar 2021 22:52:56 -0700, Kees Cook said:
> > On Mon, Mar 08, 2021 at 03:40:21AM -0500, Valdis KlDtnieks wrote:
> > > It turns out that older gcc (4.9 and 5.4) have gnu++11 support, but
> > > due to a gcc bug fixed in gcc6, throw errors during the build.
> > > The relevant gcc bug is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959
> > >
> > > Version the option based on what gcc we're using.
> >
> > Is there a better way to detect this than with version checking?
> 
> Not really.  gcc 11 needs --std=gnu++11 to build it.  And although
> gcc4 and gcc5 *claim* to support it, there's a known bug, so we *can't*
> feed gnu++11 to them.  We can check versions..

That gcc bug just implies you need a space after "xxx".
That is easily fixable in the sources.
Is there another problem?

(Apart from the standards committee breaking everything again.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

