Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3C4A13BA
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018034; cv=none; b=nJ1xDexo0x4Qcg66nrK/cOSc3Ql/F5h8FOBF98X6K/r+cIYzAba3PeF3DrdQ3JIuFQnQPQ4dvcqp056SQugzRovngmcgWnwfhxSsUQlGIWi0v2xEQaxzINO4h7wkdEjQfGVzNYsDFfG02mhgLyt4o2JgGz2zOC/RKweDwpx7PnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018034; c=relaxed/simple;
	bh=Tgj2/f5KwE1aGzhSuEmxWHXJ26+0zAS918oxJXslIPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcA3XqMNWIbgmT2MfTcG0/gbfe4Trie2uEmyem2Ba/tR/CWQBk3Z/fciTWSxHO3puheIyIrPNGc8FVw8vUYc6v9Pb1igsddwCHJf66/8sziISEG/urvr6rJLLg66yc65IbxLcAgpIjyJoSGokUcT7vsixpkyiZ3ZU3W6lDLBt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDnmlTR5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDnmlTR5"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso2680985f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018021; x=1781622821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS9BfQsDmesJT0AInGwOXq/X3DAmc3WIA3Pzjrg2pfY=;
        b=eDnmlTR51Qisn8G1HGxRzhpM/4f8MiowQoWhGCv01Ro0aAVP25snMxrWmcSmFcTQa0
         kSqbawpNnq8FhnzmVbETXa0AnDSm4stItKLC4Vb+bMhOUcR10lyMCOcZgmKWbdPWBfGc
         wCLJUWKNTcBfXOrfJtmb0tgKJkPFbwgWf9ORzDuJ3bziClvqziatwyT1BbLOOgzijpzK
         bbX5zZb7b3RpVHqM1qG1Lqn+ZeCKvjm8kQUWqmQE9N609q5oyuTzJX+445Bm1oEnukUz
         0Ojn7+KOKd3Ojcsh8qy6EKtFUukke8gP+aksgI/fnF4vwSMZLx4PEgQMyI7GQEVacC/i
         OkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018021; x=1781622821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LS9BfQsDmesJT0AInGwOXq/X3DAmc3WIA3Pzjrg2pfY=;
        b=AmK96IdqZhJmVdQgACyqYp9dAXTqSEIKxNS9Xa/cE/Op1Z+3gBQmechi/ddCCa3w7j
         N/CiiqDynyGnYXhOl2czICO7tqbyg43mSt+Zmx+Ib0ntaMCIwbog55hCpmPMVf8inlER
         KER+vVZut+0vEAw3tPNts/FqWPK++R+V/8lpZSbZlqpg82Zevm175b+WVp6cSZ77psIk
         hg/hiGNzO3h1fTRN031dQDB3WFCX7wq1JhRvS/8jR9NJpqtH1wPdytaiJXMOXfVSyRBP
         N1Oc4C3mG9PY7Ydm1cAk4iArhlCGorbm9pKd6xW1hL8P6IVjz3mgfHCuASQJ35t5VJtI
         uRNA==
X-Forwarded-Encrypted: i=1; AFNElJ/McrJXcOD5TShtztF86j/MMixBpdPGgvc4zhsAmTV1oCfIqr578t4HrlCCX5AW5IKSnI6Yb7b7E4yNY90LuZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gSMKHtQtuZ4+F9+5e+sEv7+nk1dtMKCli+1GUtzwL8mILXc7
	losTkgy1VZvW5Vwnvcx1YDFZauLppJ3Lb1Ns7rXVp5SSMWxVMcVYqXhn
X-Gm-Gg: Acq92OHjO7qi1sv68HC97lYbx6ZdzBQ4nSs7kW0RRK7vGOrfQOx3F5oxicDxv0GUOb/
	XL9tZPRjpXwzcvRoAlsuK3vS+Pl5RLvmhCi7w6PPwHZ3JDxz8xR1h79aQBuN6L1QOfxPJOfi0Up
	UBhoT5pgbnWUXZwtCKa2X2yd9Hft5atih9ns3djHQp4/Ls380bhqSkCPOPQvJON2zAyxQtTU6Rg
	IUbOxbJqO9woeUGk5EPhYCpE411E+925pfv+ktIbi5xZ7GG9bKIlEkaOInVbdkDR9O1Lyl/pxSd
	tn/Sjb6k2supUv2SVWMbG8YMt1goqJ9wPDP4kOI8diyVFTAF7GU6rXhH881KX9aNIAShMt8ewbd
	KhOoMa7Z+RjDcYbas+1v6AXw/Uc6+vX6r8loXALm5k5jDSro2506xd6ueYUQfnoyBcPCngpK4w8
	lIyKYp7T4W+eVuAaONc+643zHbJu2hrOUVPu9qAL/tFYfxTLCg6QsONMQ+Td4+yIq1tuaVUSs=
X-Received: by 2002:a05:6000:4312:b0:45e:ea9b:edfb with SMTP id ffacd0b85a97d-460566db7d0mr4546819f8f.39.1781018020420;
        Tue, 09 Jun 2026 08:13:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm55897116f8f.30.2026.06.09.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:13:40 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:13:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Arnd Bergmann
 <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>
Subject: Re: [PATCH net-next] net/devlink: Use strscpy() to copy strings
 into arrays
Message-ID: <20260609161338.2222ff26@pumpkin>
In-Reply-To: <c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
References: <20260608095523.2606-13-david.laight.linux@gmail.com>
	<c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 15:39:35 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 6/8/26 11:54 AM, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Replacing strcpy() with strscpy() ensures that overflow of the target
> > buffer cannot happen.
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
> >  net/devlink/port.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/devlink/port.c b/net/devlink/port.c
> > index 485029d43428..108926d3f899 100644
> > --- a/net/devlink/port.c
> > +++ b/net/devlink/port.c
> > @@ -1222,7 +1222,7 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
> >  			devlink_port->type_eth.ifindex = netdev->ifindex;
> >  			BUILD_BUG_ON(sizeof(devlink_port->type_eth.ifname) !=
> >  				     sizeof(netdev->name));
> > -			strcpy(devlink_port->type_eth.ifname, netdev->name);
> > +			strscpy(devlink_port->type_eth.ifname, netdev->name);  
> 
> Given the above BUILD_BUG, I don't see how this change can help?!?
> 
> Generally speaking, I suggest restricting this kind of tool-assisted
> changes to real problems (if any).

My aim is to get to the point where the calling strcpy() is invalid
unless it is used to copy a string literal into an array.
If/when all the .c files are changed the .h file change can be committed
to stop any new potential unbounded copies being added.

I do want to look at the 'fortify' version of strspcy().
The current version can call strnlen() and then real_strscpy(), so
ends up doing the length scan twice.
(Never mind how much gets inlined.)
strscpy() between arrays could be implemented as a memcpy() of the
shorter length and an explicit zero of the final byte.

With the BUILD_BUG_ON() (which I didn't notice) the above could
be e memcpy().

-- David

> 
> Thanks,
> 
> Paolo
> 

