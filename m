Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C423C503
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781128341; cv=none; b=GuGCHMVMwqBB9RXQQa2/L3cp5Zybs5L+9br+5ZOTCwx8SGqfPzHnd8Gy+xtJHPZW3ROS4hJKGwD1XLkAfdGRNlOeeHMpdpEzis6wqTNq+np8CsIV1/icSvL3XC4aaapdctGVEyCoNtdYBBKCUhzzjjuyH+XWUayq+93bE8pEtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781128341; c=relaxed/simple;
	bh=zipjgAzMkalo/Pp3aPEMTis0IPGNah676JG0Rbdr1Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eub4pfj8gN2M9w9Zk1pN1MX+owdAkvHTBT2DcYXpjOWXnmESF0zvGiBDcDWM/0U0JKC49H4jCT1186FedNSWD2MzscotZ6hMr/PaFOR0K4sEc3U7gkNxCGW4R3sOjhHpoXzKUVxOKUjfg3YyYKMFyJx3nofuJ0SEZL/fEin5Ifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWdxJgxm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWdxJgxm"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45fe59255beso3895830f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781128337; x=1781733137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu9xDm8soA90OJqRQivplXBBU0m7fynUgXp21Gt49gw=;
        b=iWdxJgxmJSl41iMKUWNQwH7uxtH+pJcubLpLFRPhIBlBPjFwjdsJen4+dX7KaEZDui
         I+RB7uRhhO3vd7LPDzyxqzx3IdE9TItFrGh0ARFm+qaVrtUmPAz9elVqQSJSrHYaz4s1
         oPcyavXq/w9Hv2yBLC5VFlOAF9DPcid/EQM4uxBEUuCv/IktUB8eiIvNcJEZw8MDMOZT
         I039gT+AQGvLy/9ain8uO0JgVeZ8yqfHKcGlzjW2VFwCccmJM4S8tct9tNRQg8w+5TKa
         auRbgtpHGo1nV0xP/erVAW54qFmH2X2W4Ox9Y6yHSHWBacv1ydSameF2JPFMlDolGyoK
         WJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781128337; x=1781733137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pu9xDm8soA90OJqRQivplXBBU0m7fynUgXp21Gt49gw=;
        b=NeXATYyVQaqgElBGKmg4uVI6OVSP3bCEtQrDF1zW5M2Jk+6i7zRD9OLrEpwOLamBf5
         R+3RJvbTlcdqUK+Kbtfl6EdBstwZdTg1biNkQ9w+rgGtXZcJkNFUB+Z0RnLCJyODrfTP
         JoMNUNBRObBs4uqzUx1jZmcNsBQqEULTCeF56nk2gEKeikmWJwxsAF0ythSvRikrCdOi
         FK193vTFoSw4vOznyR/nXJ0WF0c9gsMX92WJ/JoeFDsW0BxzapLy0jPObUTK9jq0lr/l
         afnPYlBU9ulsOVC5+S0/c1/Royqc5jIUVhbHAzDkZGgGlEXY7vl75zU1PFWlwvMPsRra
         ii8A==
X-Forwarded-Encrypted: i=1; AFNElJ9O8w/2UreylxeyZ/oNGCdG/+q/VgUmqt21ndkU5rZZGQnQGBg99fnbWiUISW2vX8W5X60cr08QGublSgKhnyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnpaWCAeM4a9SZww/oGa5sH7GpE9CxDCrbxLXgzz60lYJZ/4Y
	N3zdNyJKNWAF1EGMrWP9pyM684kxsxru6gG4adB6nQ+1PYee6WsFAWgy
X-Gm-Gg: Acq92OHzcJsFN0TbOnZ15ofAAn27n2ofUR+HFa+8eFCPIjyOZlTYII4iOCAWaYMFLHg
	8CF+dxo21QY4juBtWo5MiHIO/vP0OTY396d5uqJJC37bK+0OFaS69s5o/IV4IdxpTeuHfjREqnS
	ewRWnDIf15fOH+5+YJ1I+Th6gZ4qhycWJqDmrgxWTbmC7a4Y7gf+WX1zemdMTqAB8wrZ1Jufw9K
	d9yNsqL4kg+F1wEkzi4DiKXQSflmNfoWwik2pdyTl7tMpaLXRhF2ZgOmWCa19EIVlBZlP3OLdlv
	+wgDOwn4urHXaU+I8iWy3SKNo9gR8xGo9nHgEwvdHTECESPviCUcz6U6Ro0k19mdzj9qwe3e6TX
	biAhXNOnalaoLpsdogfZH1Dn0e3vVdPweNGe+OHhB6PMJNhz/PMVgTKvlvRf6FT79LPQxkEb9ua
	KbUKXazMAwhwFm6s3gU6j8oSox3yUpOSpjk1DFD6wAsDaU2KWP2GBuRtuFiaV41BG4J1i72Jhcw
	cgztg/RVg==
X-Received: by 2002:a5d:64c5:0:b0:460:2d45:fe8c with SMTP id ffacd0b85a97d-460677b902fmr46333f8f.38.1781128337225;
        Wed, 10 Jun 2026 14:52:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm71699352f8f.18.2026.06.10.14.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 14:52:16 -0700 (PDT)
Date: Wed, 10 Jun 2026 22:52:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Arnd Bergmann
 <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>
Subject: Re: [PATCH net-next] net/devlink: Use strscpy() to copy strings
 into arrays
Message-ID: <20260610225215.6783c5bf@pumpkin>
In-Reply-To: <202606101355.6353D5C1@keescook>
References: <20260608095523.2606-13-david.laight.linux@gmail.com>
	<c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
	<202606101355.6353D5C1@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 13:58:51 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Jun 09, 2026 at 03:39:35PM +0200, Paolo Abeni wrote:
> > On 6/8/26 11:54 AM, david.laight.linux@gmail.com wrote:  
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > Replacing strcpy() with strscpy() ensures that overflow of the target
> > > buffer cannot happen.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > > This is one of a group of patches that remove potentially unbounded
> > > strcpy() calls.
> > > 
> > > They are mostly replaced by strscpy() or, when strlen() has just been
> > > called, with memcpy() (usually including the '\0').
> > > 
> > > Calls with copy string literals into arrays are left unchanged.
> > > They are safe and easily detected as such.
> > > 
> > > The changes were made by getting the compiler to detect the calls and
> > > then fixing the code by hand.
> > > 
> > > Note that all the changes are only compile tested.
> > > 
> > > Some Makefiles were changed to allow files to contain strcpy().
> > > As well as 'difficult to fix' files, this included 'show' functions
> > > as they really need to use sysfs_emit() or seq_printf().
> > > 
> > > All the patches are being sent individually to avoid very long cc lists.
> > > Apologies for the terse commit messages and likely unexpected tags.
> > > (There are about 100 patches in total.)
> > > 
> > >  net/devlink/port.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/devlink/port.c b/net/devlink/port.c
> > > index 485029d43428..108926d3f899 100644
> > > --- a/net/devlink/port.c
> > > +++ b/net/devlink/port.c
> > > @@ -1222,7 +1222,7 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
> > >  			devlink_port->type_eth.ifindex = netdev->ifindex;
> > >  			BUILD_BUG_ON(sizeof(devlink_port->type_eth.ifname) !=
> > >  				     sizeof(netdev->name));
> > > -			strcpy(devlink_port->type_eth.ifname, netdev->name);
> > > +			strscpy(devlink_port->type_eth.ifname, netdev->name);  
> > 
> > Given the above BUILD_BUG, I don't see how this change can help?!?
> > 
> > Generally speaking, I suggest restricting this kind of tool-assisted
> > changes to real problems (if any).  
> 
> How did this patch get generated? This isn't an "unbounded" case: both
> devlink_port->type_eth.ifname and netdev->name have known sizes. I think
> a way to focus these kinds of refactors would be to replace strcpy()
> with a macro wrapper that fails a build when the sizes aren't known, but
> then otherwise calls strscpy instead. With that in place, you can find
> all the actually unbounded cases and work through each of them, and once
> they have all been purged from the kernel, that strcpy macro can land,
> which will keep new unbounded instances from showing up.
> 

My current wrapper (which will allow the above is):
#if !defined(ALLOW_STRCPY)
#define strcpy(dst, src) ({ \ 
        size_t _dst_size, _src_size; \
        char *const _dst = dst; \
        const char *_src = src; \
        bool _use_memcpy = true; \
\
        _dst_size = __is_array(dst) ? sizeof(dst) : __builtin_object_size(dst, 1); \
        BUILD_BUG_ON_MSG(!_dst_size, "strcpy() dst size zero"); \
        BUILD_BUG_ON_MSG(_dst_size == SIZE_MAX, "strcpy() dst size unknown"); \
\
        if (__builtin_constant_p(_src && _src[0])) \
                _src_size = __builtin_strlen(_src) + 1; \
        else { \
                BUILD_BUG_ON_MSG(!__is_array(src), "strcpy() src unbounded"); \
                _src_size = sizeof(src); \
                BUILD_BUG_ON_MSG(!_src_size, "strcpy() src is zero length array"); \
                _use_memcpy = _src_size <= 32; \
        } \
        BUILD_BUG_ON_MSG(!statically_true(_src_size <= _dst_size), "strcpy() src too big"); \
        if (_use_memcpy) \
                __underlying_memcpy(_dst, _src, _src_size); \
        else \
                __underlying_strcpy(_dst, _src); \
        _dst; \
})

__FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
char *(strcpy)(char * const POS p, const char * const POS q)
{
        BUILD_BUG_ON_MSG(1, "Direct call to strcpy");
        return p;
}
#else
...
#endif

The one I was using before required the source be a constant string.

Note that this is just intended to find the unbounded copies at compile time,
rather than being a suggested patch.
The ALLOW_STRCPY is needed for things like the acpi code which are out of tree
(and other files I didn't want to fix).

The acpi code is stunningly bad, it saves the string lengths for the kmalloc()
calls and then uses strcpy() to copy the data.
If anyone manages to gen them out of sync it will overwrite memory.

	David

