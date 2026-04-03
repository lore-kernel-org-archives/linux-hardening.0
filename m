Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D116258ED5
	for <linux-hardening@vger.kernel.org>; Fri,  3 Apr 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206212; cv=none; b=XfsDuhtFne4MRcPIwum7j69RJQWl1ap8zesI8cb6jkOfvLjPrKn+IIuwhrrIj5riAmYnPRW34IBr2zVrrzqjG+07nnUqwZmpKvVy/xsmCh60492MTkJsE8AvZAQsvZMejQGK+4Y2+e34eOWKbkpvT8rVPWGXuf0v0taKE9bTRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206212; c=relaxed/simple;
	bh=hy2zUWeMdJ1K/kIi6HKf3axkCNQJZGK0oFl8TkvORNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kK7C+ZzslKkpCP0jBfMW2mXt+5Mt7nVxPkjoIp/fVL5ujUMqC2K+AceppzmDeK0ttOpO/AvQXw7DH0zlhnCwX00rrZYu+6vMiSiN+kRu/80qTKiSQLpYfIc18aOjAN1hOljKo27FA5T9KctDAyKIZSB04uHqecvbeahHlzJFcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLhhFGwX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLhhFGwX"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so1457430f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 Apr 2026 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775206210; x=1775811010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/Umu3SxI4DFSety103HcrpvKbCjXU4zAVEmvlKEgUI=;
        b=pLhhFGwXSW9JIRWrWoIRhtlf0VJZwBPcw6MOC3vt5ff4ggkCUASmg6WmzQ8abXTTDL
         JngRKpwGq39mNBL0NWvNFgnbjErXe6RR2H+uoRtoaN9NoyZtrNWtmEziLo0iN2FxfgC2
         ujc0trEwruLhe4TkEoSe69XnUmXhq8tg14N3rDQMR+90TQkI+d4+WVShZlNc+0155boi
         N65kTxtIVBSQUcFkquL9gKO/vDq/iz9VLp3ZCL+xc2Z8vWiVsrvu/6kjotLSSh9IT/bc
         HtmjVyPTQnqeVkRvZ7WzZOAsFeWbIxou+0kP6/Y0vTO0MoJtjgAaP8Y1vCL09XxWJT/Y
         nEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775206210; x=1775811010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/Umu3SxI4DFSety103HcrpvKbCjXU4zAVEmvlKEgUI=;
        b=INPW1Ue7KlSsWiAMPUSkE5EMzYuWKZNSWke+9HJ8L7QHPbD2qlvsAFS+JEQDQC1+K6
         A73NVEI11aseTt5kGGITC/pK1gqk3kFOWbSN4RddYyrODp0vfp+wL7r05tt5SR0vPW0i
         LqRqyJeb+Ok+cgcJej9jh29UzovxSFHD994gkL7cDsetuCldmsT2ketSgYPe5iCbT1dP
         2bYRDbuH7rj67xCb8AE/W1EbWjfDt5HEXaw8x4JCrbja5PUuYLUkhABI4QGm4KTatRJ1
         URkXits37ssu0qg9SgphCc2fTeTwKr2TBoTvo1MPtI+y1gGr0OfYJyHiHBLT3wRsrXVf
         k7KA==
X-Gm-Message-State: AOJu0YyleMDsb7HZgXEO4Dt+14GmSto2get9Xtomdt8F2j+sgY20LBm9
	e3A2paYg2T2+u9rCM/yHtfzLiSKHdpN8vlVxepXV/H5XbwuT9nYQsmUe
X-Gm-Gg: AeBDieu6M6sB8Y3OCn1TjPeki6sqJBP1dZsU3jiioj5vHUSADDHfXX0rZfkHwZtpJMh
	ZYDT+RCdGoscclWmstYEav+sDSNm+kV4xUGgl9+8zmJ5xxeAhqB0giT8dQYCtDEvLlTeq758DO4
	egRNetHhGLgUcJpCyBBxQworfygYkfq06Wg+qdQeyhlkQAp7eGcvt52CUgRvwviOJUTr1sqj0KF
	mxF2DvLI2OEyJsVPnKGQLTuASigyj3Ogm6XvUwJVWUOmplhxKXO/fW5KFnMc4wURoHqIQUB49tM
	nQ6AHRSZJTQ49P/t8aaUy1/FsM5d3mCzcBZ3Y5EIgRlZMzMHEAdk7QFktnk4KDrC531monCPMW5
	MkLxDuJ/lgQ2+jqvF8dmP++xdwVUSoKtaBIAjRMDNloeHIcpsjDcIqnURFG7hfe8acAvLCjmBD1
	Z6OGwUtcdXWLTRxkTihqQE3xPPZeyBfYP8//0UmtzyGtYz7pz6gaVmqDC7XTtm
X-Received: by 2002:a05:6000:240b:b0:439:ccd7:cdb6 with SMTP id ffacd0b85a97d-43d29276590mr3514350f8f.14.1775206209702;
        Fri, 03 Apr 2026 01:50:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e56fesm14512578f8f.27.2026.04.03.01.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:50:09 -0700 (PDT)
Date: Fri, 3 Apr 2026 09:50:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <20260403095008.6efbaf11@pumpkin>
In-Reply-To: <202603311650.A59396A@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
	<20260330132003.3379-3-david.laight.linux@gmail.com>
	<202603301650.E7C1536632@keescook>
	<20260331230914.43698e74@pumpkin>
	<202603311650.A59396A@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 16:51:26 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Mar 31, 2026 at 11:09:14PM +0100, David Laight wrote:
> > Any uses should be replaced by __builtin_strlen().  
> 
> When I looked at this before, __builtin_strlen() flip to run-time strlen
> on non-constant strings, which is why I had to jump through all the
> hoops to avoid calling it in those cases.
> 

Thinks further.
Can you remember anywhere where:
	len = __builtin_strlen(x);
	if (__builtin_constant_p(len))
		...
actually called strlen() for a non-constant string.
I did do some tests and it was always optimised away.

I might try getting all this code to use a renamed strlen() and
then scan the entire kernel for references to strlen() itself.
There might be a small number of valid ones, but I'd expect most
would come from the compiler.
(Or get the compiler to generate 'rep scasb' and look for that.)

I suspect it might be enough to check that both str and str[0]
are constant before calling __builtin_strlen() and then check
the returned length is constant.
All the checks might be needed for:
	str = cond ? "four" : "f\0ur";
since the compile might realise that str[0] is always 'f' and
str[4] always 0 - but strlen differs.

However I suspect that __builtin_constant_p(array[index]) currently
requires that both the array and index are constant.
So testing array[0] is equivalent.

Given it needs all the separate paths, writing strscpy with:
	if (__builtin_constant_p(src[0]) {
		len = __builtin_strlen(src);
		if (__builtin_constant_p(len)) {
			/* code for constant length */
			return xxx;
		}
	}
	/* code for non-constant length */

One thing I did notice is that for:
char src[32];
char dst[32];

void func(void)
{
	strscpy(dst, src, 32);
}

it seems to generate a call to strnlen() followed by a call to
strscpy_sized().
That seems wrong, since all three lengths are 32 it should be
safe to just call strscpy_sized().
And having done the strnlen() it ought to use memcpy().
But, really most of that ought to be moved into the called function.
So you want:
int strcpy_sized(char *dst, const char *src, size_t dst_len, size_t src_len);
where the wrapper fills in src_len.

	David


			
