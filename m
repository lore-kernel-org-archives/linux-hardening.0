Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA10C433DB
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 13:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A6060249
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 13:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCRNjF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 09:39:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:46483 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230419AbhCRNir (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 09:38:47 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-273-x16uHSOPMHCv6f1vzDCVPQ-1; Thu, 18 Mar 2021 13:38:42 +0000
X-MC-Unique: x16uHSOPMHCv6f1vzDCVPQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 18 Mar 2021 13:38:41 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 18 Mar 2021 13:38:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?windows-1257?Q?=27Valdis_Kl=E7tnieks=27?= 
        <valdis.kletnieks@vt.edu>
CC:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on old
 gcc
Thread-Topic: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on
 old gcc
Thread-Index: AQHXG7xcElVT0YEvr0m/P+UnKynj6KqJn0dQgAAEdYCAABwbwA==
Date:   Thu, 18 Mar 2021 13:38:41 +0000
Message-ID: <602d6d53962c4567bc1363e58b49c757@AcuMS.aculab.com>
References: <279558.1615192821@turing-police> <202103172251.F9D770D@keescook>
 <282490.1616047333@turing-police>
 <279b22592f1e43a48beeecd34e50b385@AcuMS.aculab.com>
 <300176.1616068535@turing-police>
In-Reply-To: <300176.1616068535@turing-police>
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
> Sent: 18 March 2021 11:56
> 
> On Thu, 18 Mar 2021 11:41:29 -0000, David Laight said:
> 
> > That gcc bug just implies you need a space after "xxx".
> > That is easily fixable in the sources.
> 
> It's not quite that simple.
> 
>    In file included from /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/tm.h:27,
>                     from /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/gcc-plugin.h:31,
>                     from /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/plugin.h:23,
>                     from scripts/gcc-plugins/gcc-common.h:9,
>                     from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> >> /usr/lib/gcc/x86_64-linux-gnu/5/plugin/include/config/elfos.h:102:21: warning: invalid suffix on
> literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]
>        fprintf ((FILE), "%s"HOST_WIDE_INT_PRINT_UNSIGNED"\n",\
> 
> The problem isn't in a kernel source file...  
...

Could you pass -Wno-literal-suffix on plugin builds?

Might be less faff than changing the -std=xxx' parameter.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

