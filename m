Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150822FE0E
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781876083; cv=none; b=FWbYn7yf14/a97AOEV1LHa6UXFPyXD+xm/jl8wa2BgPmR6r1GBYZmwIjURby9peqULmRcQOC93TM0LhqWdSphhyPgEaJ0HjF4EktFfT2bdqfIKa64rgM8MHZ81iphJZn3HFoJjObcI55Z8OpdA9Rvhlir0m9vYUKnJIbkFeW8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781876083; c=relaxed/simple;
	bh=dbBz2QieHmEToMmtKT7zB1JATLkArtfoHDVG6WZmdCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuOYLobEcKXUhXUsGz5qYdWNs3GecmAcZeRpNSnYF3c5bawl/7axsZ85jff23q+yrqBD2FgGCAJYeF6VDubmVg4GwzS3bXrWDXBj66SgWSZl/gv8NXtzMygzXkyNDBZFx4GZklZivN7rdBRzf4SiPConDs0wP4IMoSViKlZPv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7G1+kbd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7G1+kbd"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b9318997so14863905e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781876080; x=1782480880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR4uagHJu24Y9sOS9k5mT4IkwyewV3rykHLez0Jnrds=;
        b=s7G1+kbd4dhFGzPyuiOo5JtUHGfsDcAiOBgYYFYBQppT0dAPtmClEZi5rKEAePVKsG
         D2bpbJ3WuFbWBv0rVPljsIHcCz1V0RxtB1L4bQMLDEqWII/adjL8Gq2HLlYWFD1gE5DV
         bthYLuuL3n4VYjr8RJk2Gjk54LorRQH0eWqt0EtPs3oc2eLknic6Ukk3fKfofGqQJkiW
         RGzeYyeTU9xX2Q/0MybNmBYOX7cLJMkbbtnTHAbLkK0GLdvBQgzptl2mMUkRQnct5oqe
         tN9kAGP6DkzV0EdYNrrq7lTs0c99o/vFWLm5fy7ltXtQumbCYyYdWA2zivMl1/cwJIZr
         B4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781876080; x=1782480880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qR4uagHJu24Y9sOS9k5mT4IkwyewV3rykHLez0Jnrds=;
        b=mePhjApvXTNDzFZjGwH1lyg+3TYrYeeYdnwS+82U6MFrFPlYZOPqhUWY1GAbUT2217
         0zed28Tr9djdTCpQxsCDGqDSICIZGv1+pnSSOhci2SKqNkP0ADkYXeCJ6+rqF1FL7TnQ
         rCYGpqFpVjX32CHikNXgAW8dfLiB8divJs7296oSqzSsYaQaODei2KvYXH+p+7rTKh9i
         C5BiiSPTqE1wTrwsBL/Ds78SwFXwAfN96+GvlDfjS1L2z8AhAirvTOZNfI5e5PHiMcyz
         t4IuVivxlspG97qiHv9KzE+dGhUCGRFNmN7fV/Fqt+S5zi60l2yu1b+UJapKq6x6c5Nj
         WgCw==
X-Forwarded-Encrypted: i=1; AFNElJ9fM80FZYrYEvr4SRLJFbGfkxIUwh+A9AH08vKZU1YSNRBkriX+NloT8zbGg3YmKsbtZOsOSn8mIeFal+NnTxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0EKNTfb0GA8DdsxR/liSm1J6r9X6N/VOwy1m9MjE7NZ4wfjse
	FjAX4JrqicsEC9e/bHpfnsps7BeOfKNmg0TBxDU8u//5f8dVygw52gZa
X-Gm-Gg: AfdE7ckHcG0imnCJAxGjvW3qT0MmFwzcIM2CcJ+5DKxFB53sl0LG2pSfvCtv/Rb/Q/b
	7yY14IZgZEp7ykItN1FuPrrxMp7FKkNMAXPKDTTm7+cQmHUfmrCw71J8VPlKURpnKMdc7k6yfnG
	+6gkQF3tGG02mrjb2fAdlnsGkkndmE/l+evuERQ/ZKNr33pJ+0XP5y6sIf7vTIrpdD9Ef97XPd3
	YyjN39ImCyn1wlGWhJpiI3zBqO990LVdy6cuL2sB2+uSAsst7FLsqDmEfTio4CO/vFYpJqtLk/M
	KUw+JajPfbV+SG3n+w3E2Dk1xjWz0cpPDobpY3zVKEPULS+x/ZWZSZFeylnPULXQHxU5gp+Fxok
	pp9sI/eFV1HnOevhHEN7VigZ/ol03MCIfUuobYE/C78BUU07pZoF6tK4A+KMKcPgWdPbSGH3Rhy
	dt4d4MIkzo4naLwgmSLOo7sOOfS0JauEG0FGN/pSH+SlGI6PtQRw==
X-Received: by 2002:a05:600c:5286:b0:492:454c:347c with SMTP id 5b1f17b1804b1-492454c37aemr28611295e9.7.1781876079542;
        Fri, 19 Jun 2026 06:34:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd01fecsm63720865e9.8.2026.06.19.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:34:39 -0700 (PDT)
Date: Fri, 19 Jun 2026 14:34:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH next] fs: Replace strcpy(s, "../") with memcpy(s, "../",
 4)
Message-ID: <20260619143438.495c1780@pumpkin>
In-Reply-To: <874iiyg5kj.fsf@t14s.mail-host-address-is-not-set>
References: <CnPdNyUGjsYpAP8JdysfUf4wkBkm2a923cQ1hE4-mg0sUnJIm4Uj-cAkdVHswEsuZ3d6vhmX5eil2zLmrkfl3A==@protonmail.internalid>
	<20260606202633.5018-5-david.laight.linux@gmail.com>
	<874iiyg5kj.fsf@t14s.mail-host-address-is-not-set>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 12:58:20 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> <david.laight.linux@gmail.com> writes:
> 
> > From: David Laight <david.laight.linux@gmail.com>
> >
> > The code has already checked there is enough room.
> > Use memcpy() to avoid compiler warnings from possibly unbounded strcpy().
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > This is one of a group of patches that remove potentially unbounded
> > strcpy() calls.
> >
> > They are mostly replaced by strscpy() or, when strlen() has just been
> > called, with memcpy() (usually including the '\0').
> >
> > Calls with copy string literals into arrays are left unchanged.
> > They are safe and easily detected as such.
> >
> > The changes were made by getting the compiler to detect the calls and
> > then fixing the code by hand.
> >
> > Note that all the changes are only compile tested.
> >
> > Some Makefiles were changed to allow files to contain strcpy().
> > As well as 'difficult to fix' files, this included 'show' functions
> > as they really need to use sysfs_emit() or seq_printf().
> >
> > All the patches are being sent individually to avoid very long cc lists.
> > Apologies for the terse commit messages and likely unexpected tags.
> > (There are about 100 patches in total.)
> >
> >  fs/configfs/symlink.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> > index f3f79c67add5..9f36699e5922 100644
> > --- a/fs/configfs/symlink.c
> > +++ b/fs/configfs/symlink.c
> > @@ -67,7 +67,7 @@ static int configfs_get_target_path(struct config_item *item,
> >  	pr_debug("%s: depth = %d, size = %d\n", __func__, depth, size);
> >
> >  	for (s = path; depth--; s += 3)
> > -		strcpy(s,"../");
> > +		memcpy(s, "../", 4);  
> 
> I don't think this transform makes sense when copying string literals.
> The post transform code has one more foot gun than the original code.

They are actually identical, the compiler converts the former to the latter.

I was trying to remove all the strcpy() where the target isn't an array.
The initial check also only allowed string literals - but I relaxed that
a bit to reduce the number of false positives.
Were a similar check for calls to strcpy() be committed this code would
need changing, but you want something that ends up being a (misaligned)
32bit write of a constant on most architectures.  

I just looked at the code again, the final '- 1' on the 'size = ...'
line looks very odd.

I wonder if it would be simpler to merge all three functions into
something with a single loop that builds the name/name part backwards
from the end of the buffer while adding "../" on the front and then
calling memmove() to put the two together.

	David

> 
> Best regards,
> Andreas Hindborg
> 
> 
> 

