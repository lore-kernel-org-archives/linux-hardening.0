Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854026D4C3;
	Wed, 29 Apr 2026 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459149; cv=none; b=T8Gk6bkCXh/qHoNabnXKOpKJOwubd2sC1jVVy3Su+Hm78zdIKCTcj382C31DtsYvySwOTVFTA8FO9ac4c+aYJuJytsd9eavYt61iXvPvAg0KS16ejGMM6kr7vtkMTWP+6XOtvXdXlCpkwyiD+Y4+u81nYqkoZJY2mG+xoQF02QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459149; c=relaxed/simple;
	bh=1uTp2m3hRyqw2vgEzaJvoRJiP6wDxwtKbsGX6NG8d1A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=f15MGQYvwuYegPlxfYyCGHy6kOzoZtXaFPXj2dcdKRyB/Rhl9eBfroapjLS8iP3NtKUye7fKCOiNeBpbffTCy4Xmz/uxazcK4cO+tnOHhBMPX/Ayy1u1eKB8Yy5adCOtE01+MqDImrV+mBFH9t0D9ALGTIXxPXkjXCAjR8NSv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IA/BnTJ4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IA/BnTJ4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DC3CFC5EF22;
	Wed, 29 Apr 2026 10:39:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BC049601DF;
	Wed, 29 Apr 2026 10:39:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6B3310729B78;
	Wed, 29 Apr 2026 12:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777459144; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=F46FXIWxuy64BJjl6FJEP9svjx1JZ3C/wAGuF07+1LQ=;
	b=IA/BnTJ4B1LhojnHq3PSzm7UGR6KJ5zO8VOtksAELVl9hEXjiOzN9W3AH3rm8ozaJBkgxc
	pbs1Knb6a4fusWUxDRZiIWNRdfUoZTwB2kmf0Y7vrF5Z93dUrSAxEfxixykfRaBFWME+Qc
	RS1Oo3qYhAAME5IqnzsIQ1Fr7GoS65Oe4TEkldN27Q/fOZj6OsWmhf6gWIPEYeqJ5eO7jx
	9vzmdNaO7rNSsNSgjNIcvriqbzQrS7BbI7FbZzbGLr7qJre3pzmkwFSCotPa/+dmBNYUYF
	LMcYPvENaVqVRXHKvObhxg5Ws8RW9a+dPSmjdK165fCUWe/GAqxGY26Xh1rhAQ==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 12:39:00 +0200
Message-Id: <DI5KOGI4TE9X.20PGGVLRJCJHF@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] i2c: atr: annotate i2c_atr_adap_desc->aliases with
 __counted_by_ptr
Cc: "Thorsten Blum" <thorsten.blum@linux.dev>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>, "Romain
 Gantois" <romain.gantois@bootlin.com>
To: "Rosen Penev" <rosenp@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260427172817.417614-3-thorsten.blum@linux.dev>
 <DI4OKZA3428E.5TJAYEV50JH2@bootlin.com>
 <CAKxU2N8OUcsTxG4XDH=cbROz4954-V5ximN-XHQ5RrPagTfUjQ@mail.gmail.com>
In-Reply-To: <CAKxU2N8OUcsTxG4XDH=cbROz4954-V5ximN-XHQ5RrPagTfUjQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Apr 28, 2026 at 10:27 PM CEST, Rosen Penev wrote:
> On Tue, Apr 28, 2026 at 2:30=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
>>
>> Hello Thorsten,
>>
>> +Cc Romain, author of the involved code
>> +Cc Rosen, author of a similar patch elsewhere in i2c-atr [0]
>>
>> [0] https://lore.kernel.org/linux-i2c/20260327030310.8502-1-rosenp@gmail=
.com/
>>
>> On Mon Apr 27, 2026 at 7:28 PM CEST, Thorsten Blum wrote:
>> > Add the __counted_by_ptr() compiler attribute to ->aliases to improve
>> > bounds checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
>> >
>> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> > ---
>> >  include/linux/i2c-atr.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/i2c-atr.h b/include/linux/i2c-atr.h
>> > index 2bb54dc87c8e..b52a7b9ec536 100644
>> > --- a/include/linux/i2c-atr.h
>> > +++ b/include/linux/i2c-atr.h
>> > @@ -71,7 +71,7 @@ struct i2c_atr_adap_desc {
>> >       struct device *parent;
>> >       struct fwnode_handle *bus_handle;
>> >       size_t num_aliases;
>> > -     u16 *aliases;
>> > +     u16 *aliases __counted_by_ptr(num_aliases);
>>
>> I'm not fully proficient about all counted_by things, but the patch look=
s
>> OK to me, and definitely @num_aliases is the number of items @aliases mu=
st
>> have, so:
> I prefer my patch.
>
> __counted_by is supported by more versions of GCC/Clang than __counted_by=
_ptr.

At a quick grep check, they seem to be different things: __counted_by for
arrays embedded in structs, __counted_by_ptr for pointers in structs for
dynamically allocated arrays. I wish this were documented, though,
especially as their implementation is currently identical. :-/

Based on this, I think both Rosen's and Thorsten's changes are OK, using
different macros for different members.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
