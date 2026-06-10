Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC437AA7D;
	Wed, 10 Jun 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125133; cv=none; b=kIe+GtXnJDYjk+M3dt9FccopMWxZuKP55gfYb74EEnE66IIdE7+bUtvGJG5H4oREEFPKxkvgShRk6UgvqllkMCYqWaV3dz/2ymbjikLDydgv3rQHx0t22AiGiAnMAGQk8OvbuTNSYQBKSgpLDmgpit45kOG8Ic0LiOv81P3pEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125133; c=relaxed/simple;
	bh=QxNu4YFu6CnijUriuIXCJQEb9X2HN48ZnLzebuUZMcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px/GEP/WDAGJUBx6umuqLuzbGVvGnlDoItKb+21TcmVZITxla3GuG6eoCzSiP57+y4WJ2vBvRjg2ykjYBBFZjOQNtp9SEd3N9vSyXuX+PHTYMrpxuD3cgvy3/zYlRpeLdPoDMhL1XMy7z4X6c76j/w4kmCCQk/Y/o545EXTply8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmMirFLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmMirFLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5FC1F00893;
	Wed, 10 Jun 2026 20:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781125131;
	bh=mIaWXTuH6fPBlBjINebxoDPv6vXkZMaIqY0PtpxocFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KmMirFLftmYljm/2mvmb1G7dHnxKxX2OYzruHxSbEcQ90Z0Z0ckh0l7rB4k45uGVY
	 tzL3+mqCUhFm9PRQTKv9Az/FpGFHh6IIiYgs5n9DdKB5xeRm6XB7L8WXgq3b5hTE46
	 x4vS0y7ud7DnQIAF2Qs7lR+c19lDq4LjKGz8ty4rytJzTZlmlLpiev/Xc2H66Fsbs2
	 OuqRa9qTuAjB1+3GHjyY5TZLwU6k0VGpKL2ysEB1RSP29wsWEMsech2SY/Y4ZhfMSP
	 9DvwYRgNZpi5mfm9MUDG15LdjK+ue/MO7eUhKMl6I0ali+zH7C2bfqqb30FRpl11x4
	 WpTjzH/YsevEQ==
Date: Wed, 10 Jun 2026 13:58:51 -0700
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: david.laight.linux@gmail.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next] net/devlink: Use strscpy() to copy strings into
 arrays
Message-ID: <202606101355.6353D5C1@keescook>
References: <20260608095523.2606-13-david.laight.linux@gmail.com>
 <c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>

On Tue, Jun 09, 2026 at 03:39:35PM +0200, Paolo Abeni wrote:
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

How did this patch get generated? This isn't an "unbounded" case: both
devlink_port->type_eth.ifname and netdev->name have known sizes. I think
a way to focus these kinds of refactors would be to replace strcpy()
with a macro wrapper that fails a build when the sizes aren't known, but
then otherwise calls strscpy instead. With that in place, you can find
all the actually unbounded cases and work through each of them, and once
they have all been purged from the kernel, that strcpy macro can land,
which will keep new unbounded instances from showing up.

-- 
Kees Cook
