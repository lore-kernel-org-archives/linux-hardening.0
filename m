Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199982;
	b=kOJnotXaOIXeZ0T4bgWDCDrxsdnAbvOZ62rvlmVrddGFRawLLGKUWZYZWsjnhrL5ri+j
	 gKOWAYEV3z2Rq9mIWravZUZ8Qwlq0GyI06gjLqjvy+Szh9Q0C06xSn5XWKsyjlr85oOOo
	 63xuxCDPzR15qR4CkZ66YcM2PU5YR1gzx1l0synyvET+JQlAQJwWGD0QTXOVyf6sA4rV6
	 TffzGNVP3QmzmusHq33oCXbVj0Wx6J0DbC7iyT2mEGenhKtzKQ+xE3MIK7JU434X1I8aU
	 Jw6bNXlxXB/YaNOcArZYjqJ9xnIbqg0g0RLdeiWbs8bND6xF5n2JTv8UFU2wv2Z4F+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199982;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jc1NHj5NVrt4/jNwGZiFo0SWS3JKZ9BEwEfYFaPbfCE=;
	b=oUu5UfEy+kMfcNjffPhOX6/NrDRLO0b9tDwaE1aQNEp6IDQu9BIlQPdTtdOxp+A4MpSC
	 GFAhyRH3yxISjcw25d7lqbT/uYH8mcRfINdMIwEqPCQv0EHeVoMOyXti8IP99wzzxVJCN
	 ZD79rR/s3HjSLreIuVo8yKUsyJhZsOnc+RrHx1J/s4Jrrg/mtw/ZYH54POo35q/RgjseL
	 eIdxtu6EFC8cqkmBqy/nyggFvRmywyDRK8InROBo2QNqU/6TcPG0PV/QHSMs95zGcnTfn
	 wZxqtRPOYBUGOufpLL6QCWguxs76VYGmWGRTt2nMCEq1F+azmyeIFCpw8SsTe6+Vsgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSMN0kNU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74D606A337;
	Wed, 28 Oct 2026 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSMN0kNU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D741F01825;
	Wed, 28 Oct 2026 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199981;
	bh=jc1NHj5NVrt4/jNwGZiFo0SWS3JKZ9BEwEfYFaPbfCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nSMN0kNUmbsSHdv9awMBVCH6qjwWaKvcGUVUjLsuOukkXyE8GaNWdnrlzGSOWPUxx
	 nIsSj6zS3F7QsXpgAgCtNpKWs3qPXOfWQaHXjI7q8Xy8+AoZLdOW+kb2R2ariJ14KF
	 kh39GIVq+tFgQWcEXC77GFJzfx3q8MIhkGL8UJIK+0HbuqXpIEj0zsOIpanmvlIs+I
	 XY1CLvSbmqKiZpQM9NT3GWGDqEiJMlgHH68ERZ6/KUve1IBluVECVEYyQ6usMhvjLF
	 1k28ca39gz7anWHNTGkRQgyVUEHbN5YlUmHfrgIOGLQXh3xkTgFAB5SyTFIhCpCTuz
	 s2VKrE5jIpz0Q==
Date: Wed, 28 Oct 2026 15:06:19 +0000
From: Harry Yoo <harry@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH 0/8] mm/slab: Support selecting slab hardening features
 at boot
Message-ID: <auIN44CnAyzvR_Ll@thinkstation>
References: <cover.1793086056.git.chris@chrisdown.name>
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
In-Reply-To: <cover.1793086056.git.chris@chrisdown.name>

Hi Chris!

On Tue, Oct 27, 2026 at 03:35:16PM +0800, Chris Down wrote:
> Slab hardening settings are currently all build time choices. This means
> that, unfortunately, hosts with different requirements end up needing
> separate kernel images. Let's allow those hosts to use one image and
> select each policy at boot instead.
> 
> This series adds four new boot parameters that default to their values
> from CONFIG_*:
> 
>   slab_freelist_hardened=
>   slab_freelist_random=
>   slab_buckets=
>   kmalloc_partition=

If we end up supporting boot-time parameters for hardening,
I think it should be all enabled (or disabled) by:

  slab_hardening=none|light|full
  # please feel free to suggest bertter names

none: "Turn of all of them to maximize performance"

light: "I'm willying to sacrifice _some_ memory and CPU for security"

full: "I'm willying to sacrifice more overhead for security

IMHO more fine-grained knob for each feature doesn't make much sense.

-- 
Cheers,
Harry / Hyeonggon
