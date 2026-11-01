Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793558058;
	b=An8R8w/80Wd3XUJYDjje3FY1sGimHRJnC2jF7+jlhcrAq6lK487IMwS0Gu8WXxq7tnuv
	 hwZtYfMIHfFs0rJm9PR1HwQBCYvcNBbNt0fPD6lAxhj8qzX8hqSDc0k7R+QFWzAoSqtIs
	 POaDnLfU514ItG2QSFiWg6D5JYTwMO4ZQNQo2W9hUocX3aMQ0Z/35/w7F17N8Nn5YNe/y
	 iHQfw29Mrs4/7+OFxpn3pwXnXFY+8VZGM+auRtxy0awzsTgiHhVQAvc4f15iBuggjBLLh
	 hrLFz4IK2tz1q8XDKxpmwb8n2vYqSNQO/blUP8VbVs6CapTh089N8/1XJuGTl8zLGCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793558058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vmoWTKpodF0sixBD3Bte4QbXRriDHgbk+I5LKRP+ucY=;
	b=C6qyaPcyBelSu81N2t8cXTTT0V+yGyEDK36IAUZ05GYVTzh1MYq8+JiZvrPBvPawElaH
	 ukURYGFq4UTTtgOuUb5l/bQ+IrsqxtPqzjvHrZH4KfW4oevmQ0OlTNpCPq0/BmIAwMYJC
	 yHxky11hJBD3NFGdqydXVYORJUD9RBHnLnTXYXQOxu+ufeN3vFXhe0c9FF3qS3EfJqJu3
	 ked3MDf6n2/rNJdntLuKkOgUZsaRlQzL9ErhoaKzsLmfoyJ34iN8TmD8otycsadl5AbvH
	 rW5cNzx6+5gMlatduF5egwC0SiTTnxitWeVcy5Gg7cO8uxPG8Evsb3JCz2IhtZPw/rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAqonWv4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562CD606A324;
	Sun,  1 Nov 2026 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAqonWv4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1151F0093A;
	Sun,  1 Nov 2026 18:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793558057;
	bh=vmoWTKpodF0sixBD3Bte4QbXRriDHgbk+I5LKRP+ucY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LAqonWv4/N7g4i3hDOfoLq0a6yhIonzlH+Zb8HBsVvhoBSBqQc0BfmHVwJl8U5NvW
	 vwnoXAtWuGRsM8Xw1PSr/CKYtB/5G9nCURN2r3MqtGNwY3e2+Ul158+xhPz+BUlwL2
	 1WIcm6iGrs5GaDSuSclgIo5mScesPMkN6gB1suDAf2gHTG3p3DOv+1V8a9fczc1J1h
	 14NNfc39ZIRovlkXAKnv1cXgdBW0T1Im57YrzAfxGpT03PVwdyj+gC6+2lIS5IUObU
	 9yLGCYakHYWK6SKULeUNa/dY6WWSDbF8cfSTT+XLYZTEqPJNMeWYz6ZN0T43YeSVKn
	 pZzUfr8/Mh7FA==
Date: Sun, 1 Nov 2026 18:34:15 +0000
From: Harry Yoo <harry@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Chris Down <chris@chrisdown.name>, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Marco Elver <elver@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 3/6] mm/slab: Support disabling SLAB_BUCKETS at boot
Message-ID: <aud4gPOUzvHtLYnJ@thinkstation>
References: <cover.1793253633.git.chris@chrisdown.name>
 <9a68a4d95830352ad3821437c2e22c30a673055b.1793253633.git.chris@chrisdown.name>
 <202610302115.8C7AD110@keescook>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202610302115.8C7AD110@keescook>

A gentle ping to Kees to hear his thoughts on having a bit more
coarse grained boot parameter e.g.) `slab_hardening=` to specify
how much performance/memory is worth sacrificing for enhanced security.

Quoting an email from [1], Harry Yoo wrote:
> On Wed, Oct 28, 2026 at 11:27:37PM +0800, Chris Down wrote:
> > Harry Yoo writes:
> > > If we end up supporting boot-time parameters for hardening,
> > > I think it should be all enabled (or disabled) by:
> > > 
> > >  slab_hardening=none|light|full
> > >  # please feel free to suggest bertter names
> > > 
> > > none: "Turn of all of them to maximize performance"
> > > 
> > > light: "I'm willying to sacrifice _some_ memory and CPU for security"
> > > 
> > > full: "I'm willying to sacrifice more overhead for security
> > >
> > > IMHO more fine-grained knob for each feature doesn't make much sense.
> >
> > I think if we did the 4 knobs that is a good idea. Given now it's two, I
> > think it seems reasonable to keep it as two separate knobs unless you
> > object? Otherwise I think given it will only cover the latter two, it
> > should be something like kmalloc_isolation= instead. Let me know what you
> > think.
> 
> There has been constant, steady efforts to add more and more hardening
> features over the last decade. So I'd say slab_hardening= is more
> future proof :-)
> 
> Kees or Marco might have more insights on this.

[1] https://lore.kernel.org/linux-mm/auIVIKxjrdXIaUIY@thinkstation

-- 
Cheers,
Harry / Hyeonggon
