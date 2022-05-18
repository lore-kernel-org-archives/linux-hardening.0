Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA7C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 18 May 2022 10:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiERKBf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 May 2022 06:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiERKBe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 May 2022 06:01:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A9DD5DA1E
        for <linux-hardening@vger.kernel.org>; Wed, 18 May 2022 03:01:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-106-mgP8CKeKN82qIoHot0Di4g-1; Wed, 18 May 2022 11:01:28 +0100
X-MC-Unique: mgP8CKeKN82qIoHot0Di4g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 18 May 2022 11:01:28 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 18 May 2022 11:01:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] netfs: Use container_of() for offset casting
Thread-Topic: [PATCH] netfs: Use container_of() for offset casting
Thread-Index: AQHYao4oLXT4l68gEEWJLPYHyfOk2K0kZt+Q
Date:   Wed, 18 May 2022 10:01:27 +0000
Message-ID: <aa9e13f50be440a192b6acbce422db96@AcuMS.aculab.com>
References: <20220517210230.864239-1-keescook@chromium.org>
 <2692904.1652861114@warthog.procyon.org.uk>
In-Reply-To: <2692904.1652861114@warthog.procyon.org.uk>
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

From: David Howells 
> Sent: 18 May 2022 09:05
> 
> I wonder if it would be worth making this explicit in the inode wrappers of
> the users of netfslib.  In afs, for instance, there is:
> 
> 	struct afs_vnode {
> 		struct {
> 			/* These must be contiguous */
> 			struct inode	vfs_inode;
> 			struct netfs_i_context netfs_ctx;
> 		};
> 		...
> 	};
> 
> would it be worth making that:
> 
> 	struct afs_vnode {
> 		union {
> 			struct netfs_i_c_pair netfs_inode;
> 			struct {
> 				/* These must be contiguous */
> 				struct inode	vfs_inode;
> 				struct netfs_i_context netfs_ctx;
> 			};
> 		};
> 		...
> 	};
> 

Can't you just name the structure so it is:

	struct afs_vnode {
 		struct netfs_i_c_pair {
 			/* These must be contiguous */
 			struct inode	vfs_inode;
 			struct netfs_i_context netfs_ctx;
 		};
 		...
 	};

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

