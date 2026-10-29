Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281322;
	b=tbd2/6jp7S1wr25r2nItj5VCE7kYSQKglb+3FPfEvtIUTSeBvK75MbnPde5hXsuetJEP
	 CTr9n8YG70je4ycpnoz+Uq9yVQd/hzPOWN+YhMqHaynbxijD5ZgMkrS4m4dS+95lFzcpn
	 Mu5Nl/w4AC0ddXMf/sghP3VLarsGVHB7fwo+T8YdclZBEAkfb7uL5uB32QATCP+oEbVLS
	 jza4VNTAzxHaUXkkWQCmxKHRXJPXttAyBkuv7OA5Z13ZPcC7QqBBmzYkavpvpgfS5K2Fq
	 4y1KsAeaxOxrzIBIvNpVFg9C1Ry5HKio+qi+Pop08fso3xjX6dbEq1afbIOKKJBG0NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281322;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=T0U/yjrW+pP9kpqZteywg89QP2lsldPXVcwRlCH/xM4=;
	b=IpMSEex6U6hK8PXgYKFbwUvmBgUyDe3pyPMx7TSqI/mt3WSvrogo494Sk5HpTfv9GeGr
	 ETEJ8WwFDxBdcKwOBEd8E1mVk2hRUHw1BUAf7USfpUYnG4dAi2CAkLyVXu4l1v63FYwV2
	 v1b5S5SrzDTZOHKHFt6TvUtT9nnj3zavsAxPMCdzZ3H9maan2o9vDNIGy5v4fgC8mR9wv
	 e7RAnGpAvDQcqb/1kZm/PG66EfejiJM2KNEViRav+KjGNEOQAcJUmchNNvOO1ueTKmuuJ
	 RW5aXYNqPY8E8q1/1SRBhFBf7FYwZ/WGR3ghiO4GR7UarP084dR3IiF/f07mOziavYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=egEiCdU8;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC9606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 13:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FEC9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=egEiCdU8
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id BA0FC40153;
	Thu, 29 Oct 2026 13:41:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id EA40017;
	Thu, 29 Oct 2026 13:41:57 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:41:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org,
 Nathan Lynch <nathanl@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1] seq_buf: Add seq_buf_create() to implement
 DECLARE_SEQ_BUF()
Message-ID: <20261029094156.141f8c54@gandalf.local.home>
In-Reply-To: <auMtYh5eJKLjrubA@devuan>
References: <9bda534b33f05b90a4b14d343ac70cbbe1d7bd2e.1793229193.git.alx@kernel.org>
	<20261028211227.2b644f2e@fedora>
	<auMtYh5eJKLjrubA@devuan>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: EA40017
X-Stat-Signature: ctygw8xpb6jki616agageidyud37x4f6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18nXVDJxRSkqmjgv4pyBHAb+NPrwSxtikY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=T0U/yjrW+pP9kpqZteywg89QP2lsldPXVcwRlCH/xM4=; b=egEiCdU8YjXs2xRVJLISqq0U3fYSLPrrzc7loxyQMWxf7+6ruVMNk5YuU7LnSRLYXPw6Xpg9DL8r6eMc3w6axRmFXq/zEO0Th+6arNVOztFyvSf8D28JMvXWLqshPZV9pgMwMjM+ph6+K7YqnT39j0zECjjpIESU9MzkbYpzoFs=
X-HE-Tag: 1793281317-734994
X-HE-Meta: U2FsdGVkX18xkh+fpJGt0ra/ABa/ThkKx4h1ikCDpCdnnXeL9pLI2AlglbLbhYMLH+Vtq78vw3w5pOoTOeGF2tWXIYB9c4sPGrgpZqM6VeFMr6PU2H9vW5BwpZ1MAn+9ZKYhD8TbGPyBvl7SiOUbuejHGgsLqNRQTIU09qLJAhBYeKZJC6DDdXPk43CZS+6LJWLrbX8ft3NXz5qRyNKAC5BqCKLF9DxcRkjv4Jf79u4LFlhWt/OzEMel5/VI1uhJ4WFNu+Y+2aaJvob/lGnfQ1zqlTglx9p3oDwuXmUlOmla3od1IIaFYBVFIB/2YDlgCd7sGn0oxpesdd1z1OW8o9MfPgtvHrwg

On Thu, 29 Oct 2026 12:33:19 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> > > diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> > > index 9f2839e73f8a..facc5643c049 100644
> > > --- a/include/linux/seq_buf.h
> > > +++ b/include/linux/seq_buf.h
> > > @@ -25,10 +25,7 @@ struct seq_buf {
> > >  };
> > >  
> > >  #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> > > -	struct seq_buf NAME = {				\
> > > -		.buffer = (char[SIZE]) { 0 },		\
> > > -		.size = SIZE,				\
> > > -	}
> > > +	struct seq_buf NAME = seq_buf_create((char[SIZE]){0}, SIZE)  
> > 
> > It can't use the DECLARE_* name as that is by default something that
> > can be used outside of a function:
> > 
> >   DECLARE_SEQ_BUF(foo, 1024);
> > 
> > Needs to work. Just because nothing does that now, doesn't mean it will
> > not happen in the future. From my understanding, all DECLARE_* macros
> > for other types work this way.  
> 
> Hmmmm, then I would like to remove this macro entirely.  It is not
> possible to implement it for a structure that has '.p' and '.end'
> without a function call.
> 
> It would only be implementable with constexpr (or constinit? C++ has too
> many constsomething things that slightly differ, and I don't know which
> is which) functions that can be called at file scope, but those don't
> exist in C.
> 
> Would it be okay for you to remove this, and perhaps replace it with
> direct calls to seq_buf_create()?  Maybe like this:
> 
> 	#define SEQ_BUF_CREATE(SIZE)  seq_buf_create((char[SIZE]){0}, SIZE)

No.

Honestly, you haven't convinced me that the pointer logic is any better. It
looks to me that it may be just be moving the complexity elsewhere.

Yes, using indexes can be error prone, but if you keep all that abstracted
out to make sure you can validate that it works, it should be fine. Nothing
that uses seq_buf should care about the internals. Using indexes should not
be a point of failure as it's not extended outside the scope of the
internals of seq_buf.

That is, once you prove the internals of seq_buf is correct, then you are done.

-- Steve


> 
> 	...
> 
> 	int
> 	main(void)
> 	{
> 		struct seq_buf foo = SEQ_BUF_CREATE(1024);
> 	}

