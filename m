Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA96253B41;
	Tue,  8 Apr 2025 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155650; cv=none; b=SorIoVS9ylV8QcTtAe8Vr/ZtEX0PFfFy3KQF1ovbBYoXhjqRMi3WMKDnvGpe2nNj+hubP+nGfUO2IfAAGBBiJoFTsLS62WKl8e16ldBLhqWIBAoBkcb50zBogLA9mJx+1gtUgQdBFe4vnKJVzlc6oMnP28PnPVLHAd1ksBcjcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155650; c=relaxed/simple;
	bh=w8WNLSYZmb9/xLHbug4cdRQyjCqIMSm1ZBujwdhR15g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/ZlsBzEtk0q6AXFHrHM7lxYbLI+ZOzZ3JfwlI3Dv0nI4reB3QkTyw7v0xjCJoye5kCqyEKXu863GnhqEBo0bScIO08ldBCDWSIwJmRtIN5fdFsaP4SjWtInJP+2uKubN4sWcaBqfCoxPBds7B7nInrYolL2vGP+in6PIvg+8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzzrHhUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzzrHhUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED22BC4CEE5;
	Tue,  8 Apr 2025 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744155650;
	bh=w8WNLSYZmb9/xLHbug4cdRQyjCqIMSm1ZBujwdhR15g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzzrHhUSVDtNrOk4VgK7MkDntTVN7+6KnW38r50qRtJV/OTMLA+Nza24pRY+5L7/w
	 86cfH65IT4wUWicYMmVlsN/CXi3edQIW9ygXWJfUCPeEFCT6KM3rBhL2zxmy7o+H3k
	 uHfzvxxs/p0g0NoWV0AiJ0UOrsQoeCz0Zcj1rwOfrxv4RF15YxkEkBXAJBbhvLRyUv
	 NjsLJRX+GaXr1xR1gnB0dQkmQyttwLJC8wMv2WqcvaGiQ7dRVFJyqNqfZmgMMTwltj
	 prpO/NXMo9nvj9zwV6Z3LSqn1ujjR/AHcz+MhUZx/EQQkCAM4umj09K2nlHgaGX9Dz
	 mbEmDLIz6ZWuw==
Date: Tue, 8 Apr 2025 16:40:46 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: chan: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504081637.D17F824CE@keescook>
References: <Z-67Hm9uHEJs0RGw@kspp>
 <202504071227.E8484EB@keescook>
 <d8e63b8a-7a2c-46dc-a15c-9399044a23ee@embeddedor.com>
 <202504071336.0C708FCAB8@keescook>
 <a6dccb66-3f97-443f-85e5-fe089cd93a5e@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6dccb66-3f97-443f-85e5-fe089cd93a5e@embeddedor.com>

On Mon, Apr 07, 2025 at 05:35:47PM -0600, Gustavo A. R. Silva wrote:
> [..]
> 
> > > > > -	struct {
> > > > > -		struct nvif_chan_v0 chan;
> > > > > -		char name[TASK_COMM_LEN+16];
> > > > > -	} args;
> > > > > +	DEFINE_RAW_FLEX(struct nvif_chan_v0, args, name, TASK_COMM_LEN + 16);
> > > > >    	struct nvif_device *device = &cli->device;
> > > > >    	struct nouveau_channel *chan;
> > > > >    	const u64 plength = 0x10000;
> > > > > @@ -298,28 +295,28 @@ nouveau_channel_ctor(struct nouveau_cli *cli, bool priv, u64 runm,
> > > > >    		return ret;
> > > > >    	/* create channel object */
> > > > > -	args.chan.version = 0;
> > > > > -	args.chan.namelen = sizeof(args.name);
> > > > > -	args.chan.runlist = __ffs64(runm);
> > > > > -	args.chan.runq = 0;
> > > > > -	args.chan.priv = priv;
> > > > > -	args.chan.devm = BIT(0);
> > > > > +	args->version = 0;
> > > > > +	args->namelen = __struct_size(args) - sizeof(*args);
> > > > 
> > > > Does __struct_size(args->name) work here (and later)?
> > > 
> > > Why not?
> > 
> > Uhm, I'm genuinely curious. I *think* it will work, but because it's
> > within the struct, not outside of it, I'm unclear if it'll DTRT for
> > finding the size (since __builtin_object_size() can be touchy).
> > 
> > > I mean, this should be equivalent to `TASK_COMM_LEN+16`, I could
> > > use the latter if people prefer it (see my comments below).
> > 
> > Right, it should be the same. I think __struct_size(args->name) would be
> > much more readable ... if it works. :)
> 
> OK, I'll double check this.

Ah-ha, yes, I'm already testing this with KUnit:

struct bar {
        int a;
        u32 counter;
        s16 array[];
};
...
        DEFINE_RAW_FLEX(struct bar, two, array, 2);
	...
        KUNIT_EXPECT_EQ(test, sizeof(*two), sizeof(struct bar));
        KUNIT_EXPECT_EQ(test, __struct_size(two), sizeof(struct bar) + 2 * sizeof(s16));
        KUNIT_EXPECT_EQ(test, __member_size(two), sizeof(struct bar) + 2 * sizeof(s16));
        KUNIT_EXPECT_EQ(test, __struct_size(two->array), 2 * sizeof(s16));
        KUNIT_EXPECT_EQ(test, __member_size(two->array), 2 * sizeof(s16));


> I really don't want to condition -Wflex-array-member-not-at-end patches
> on counted_by patches, for now.

Fair enough. :) One thing at a time is wise!

-- 
Kees Cook
