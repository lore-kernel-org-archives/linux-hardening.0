Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2E3A1695
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954824; cv=none; b=o3KUnKCTZ3q0JrMKZS/w+DlUl/xDlq0HLefC150lgju1uhCzYtWY+nrenEo3wUWKbfygXe13ZslrzLahbRQtnD9hF45kqOSmfAGpGn600Qv80LyMLkIwcLFkYOB9ebOx9hCaSJqI41SYXmD4rSc0KizQt8sEW8CQcfG+CAAc0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954824; c=relaxed/simple;
	bh=Lg9ZwlOcOfhAbvTch0Cv1dTb9CKT+F4yPbV9CbfRLb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ye4+oB4XqLOBtRFMtJxapgne6C1OR63+AaAouV2qV1CCeR/P1ipHC0u3Vuk4Nvpdd3qaLpYmGJvRC4YVJZ5hb4fHV8tpZol+egzn8O0XIxFhTyD7A6WHVHQcXM2QodeScsN0mGFxJ6XiqoniObn8diCQjTAA8rYfRhN/1RBrOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcTvx/1M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcTvx/1M"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so52863455e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780954822; x=1781559622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvsRWfpYyHjr9YubPvj8KeAz5AQDd/usJgEm/sviL6k=;
        b=jcTvx/1MgQk0j6Luz/zNpyiOs5Z1qaIuKgDStRzwnYO//0OKCPMvv0+vMZE4npeCAb
         +5zL8iFWve2esBYSF5pifZjrhjkIe4Pv7Tr1uBjYfI/tr+D0JsuP8HYpAWbL4+xZJF5l
         K6UiZHZ0VUpdDcZ+63KlhQ2gU9Gtt/v7LO7odRuCSYQVMy+ehohditiGMUXphaMERx1I
         s7GZvvYzgMeRowAhSf2TwCPuFzo3RH46gg2KNxhF1umF9OGL3LJzeUB2jPPY/mQOF5cL
         mIAeJDGbWG5xSCLBp+UBr1Fk0Tri9OTJ1leJMAkbeFkRfvFpnwq5QFzxxTmink8UwfNR
         oziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780954822; x=1781559622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jvsRWfpYyHjr9YubPvj8KeAz5AQDd/usJgEm/sviL6k=;
        b=eQnrhsNFjeKJf61brKKibQ1NcU9vskOV2kFbDwNBeex5ansrE4WDGoeSQxBaHvXKi2
         /QcWArlgoTzj/GgaLgjyAWJuGjIyOhR4PT0ZoQc3ZRYj0sdwMASPFXmwv18ZDHvcz/4s
         N9AfBHyOlpef2NXQOJPWxCTLKA5gGjkuaafxGxG/pYIdA/bGeqZY7wrrt5Hh8UoMRNK1
         5MoF+Q2AMJRrhDZtJTPlD7g7YrboEfdE5wCXI1lDBpknhLb4fWXBXIuTE7jrmmS9wEAQ
         YAuqZ6Q3otRMk2/xUJAf5Qvf/KVDWz/KZbfgRg3G/L9J/Dtsxds+zpHuZQXr35vsVPHT
         +2SA==
X-Forwarded-Encrypted: i=1; AFNElJ8OQHymSUfaukcZ1TjJWgorKj2exfGoO/Twbo7FZspzzhhWF5xcrHyniayEwPaZV/k+QEXmqqZendf/CM9MZS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+1hr/LRFd8Ql5V6oDOOH5iFRIxjx4PEiNEviaFgmUEhJRCMX
	1xMHqCmGT3c1nZhZ2ZNT+SP3gpks8NCnK34gOslRK2EAncCaHkghIlTP
X-Gm-Gg: Acq92OGv8Wcdo+ZWOY1f+AL6uXMq19pVjAnPem6N8hJ+S7xfdORIuaEX3dVE7FuVf0Y
	4mEWDaxAvRK8/REduSnm3DKcGQSgAXjdEIV1+4+mU1+aJ9e4c6RE5H2GLby3sZnrLOsrhmK7v7o
	T1+SVWUkk9u/HE0hQh4tdL+qbgSXQ7hySGJHmIGYpXmWfDZLgxQqbuYDmF24TCa/Td9Dqx6kV+C
	aHClkckytyhhBaZe+xS8DfiqiyKRvqTnNzuWVODMPYRG8fL5CT3mNiNEDL9QtqgnJlsqI8ODJTU
	42ZTFsejYfULBRKe0oM4Y3aVw+l+l57wFZC5tb9A5DDJ0/cKtBakjHEkDc20z7x0WXLBpSMqCHh
	NklrKS4WL+AO58ZQ7LXOal1ESEWGqknKt9wPHTF4l6QaaDrzWTdU01Mc+pttrHUMn198F24/rRW
	jkXCr0VPCq2cjJzwPmJYHN4iXbu/+AS6kvv0Pl9m6mB0cknAaepYWvYj4NRUw89Ht2JgX72xc=
X-Received: by 2002:a05:600c:529b:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-490c2625f9bmr257945945e9.31.1780954821893;
        Mon, 08 Jun 2026 14:40:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm48816172f8f.30.2026.06.08.14.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:40:21 -0700 (PDT)
Date: Mon, 8 Jun 2026 22:40:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260608224020.6a9bcb53@pumpkin>
In-Reply-To: <20260608141822.780fb5c5@kernel.org>
References: <20260606202633.5018-13-david.laight.linux@gmail.com>
	<20260608132311.0fb69fed@kernel.org>
	<20260608220710.7499931d@pumpkin>
	<20260608141822.780fb5c5@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 14:18:22 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 8 Jun 2026 22:07:10 +0100 David Laight wrote:
> > On Mon, 8 Jun 2026 13:23:11 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >   
> > > On Sat,  6 Jun 2026 21:26:07 +0100 david.laight.linux@gmail.com wrote:    
> > > > From: David Laight <david.laight.linux@gmail.com>      
> > > 
> > > Could you be so very kind to read the automated message you received
> > > when you posted this?    
> > 
> > Looks like I managed to send two patches for files in the same directory
> > that contained equivalent fixes.
> > 
> > I think I should be able to merge the patch emails into one and send
> > as a single V2 patch that contains both changes.  
> 
> Not what I asked you.
> 
> You seem to be following the ML yet you excreted a bunch of incorrectly
> formatted and likely useless patches. Read the email. Start with one
> or two submissions at a time.

I got an email containing:

	It looks like you reposted this series less than 24 hours after
	the previous version. Please allow at least 24 hours between
	versions so that reviewers across all time zones have a chance
	to look at the previous version.

That happened because patches 0013 and 0014 (of 0089) ended up with the
same subject line when I generated one patch for each affected file.

Pretty much all the patches replace strcpy() with either strscpy()
or (when strlen() has already been done) memcpy().

-- David
