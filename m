Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D83ECBF7;
	Fri, 20 Mar 2026 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774032540; cv=none; b=r0sabspy7TtCm7ClAM7DvMopfqxRBfyPHpfQQSN1FKt46xUxQuyrWjEquBYgRdpg7tW1a7aWXgXXFJHHyHO/94PrVK7rauij7iOKfbhgM6FNDwnD8f3sXrWsive9yMGLZE4GGxibTu+gUnSwSluLcVXiibRGO5uH3un5BDk5V5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774032540; c=relaxed/simple;
	bh=kvhJFikB4qm6IeSum+YAi9JNygLzgCLbcoY27tuUADc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXsmD6iCHbveZc8KIdCD3HMDnJeVVi12lPV/Su0LAu/lYM76ECs7HVppGZwH137zXQHiPTE7YFAuW/gz4tvZIREK5CTZgp5LPni+aNlEcq5IKYLmMkpKaSOQ7i9QFWYYDvavQlpYGwV43UspMAvRtdYKKZs+LglgCpHeMqGfAFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmn+Zd5J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmn+Zd5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BCDC4CEF7;
	Fri, 20 Mar 2026 18:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774032539;
	bh=kvhJFikB4qm6IeSum+YAi9JNygLzgCLbcoY27tuUADc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmn+Zd5JOVcAlRKdRZCqffSlcjHmlhn2M2dZcjItEjj0LrqiYUI0ojSsz3hHlIe5I
	 +NOjIcgD913HVnENw4Xceh/KaY4MyL4u4DbrMHGjy1dM122pc32w8iJvBtzNrB9mOY
	 N7YSwhckZQ8DH6bN96/YyoML7T1QI8SZnPXG0wqO3BuTUr61jcGiA9HZJoDjozVFRt
	 CLSIOZR92ewFlqp3CVuVXQJdp4ecJV5O19T+ZOh8C0fZbarIDbJYnYpmJJLWOlK0W3
	 SWTIa22h00OfHEYkCJ96FBPuqpXSpV9KwDPp2DeGgeB9Pv6RY93Lz5ZJZQ47XhyoSU
	 9zQU8LWPbGPuA==
Date: Fri, 20 Mar 2026 11:48:59 -0700
From: Kees Cook <kees@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] thunderbolt: use kzalloc_flex
Message-ID: <202603201148.DAE09FC@keescook>
References: <20260318185237.4742-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318185237.4742-1-rosenp@gmail.com>

On Wed, Mar 18, 2026 at 11:52:37AM -0700, Rosen Penev wrote:
> Simplifies allocation by using a flexible arraay member.
> 
> Added __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

I don't see struct tb_path composed anywhere else; looks good to me.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> ---
>  v3: fix kdoc
>  v2: remove extra kfree to fix kernel test bot.
>  drivers/thunderbolt/path.c | 28 +++++++---------------------
>  drivers/thunderbolt/tb.h   |  5 +++--
>  2 files changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
> index 22fb4a1e1acd..8713ea0f47c1 100644
> --- a/drivers/thunderbolt/path.c
> +++ b/drivers/thunderbolt/path.c
> @@ -150,22 +150,17 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
>  		num_hops++;
>  	}
> 
> -	path = kzalloc_obj(*path);
> +	path = kzalloc_flex(*path, hops, num_hops);
>  	if (!path)
>  		return NULL;
> 
> +	path->path_length = num_hops;
> +
>  	path->name = name;
>  	path->tb = src->sw->tb;
> -	path->path_length = num_hops;
>  	path->activated = true;
>  	path->alloc_hopid = alloc_hopid;
> 
> -	path->hops = kzalloc_objs(*path->hops, num_hops);
> -	if (!path->hops) {
> -		kfree(path);
> -		return NULL;
> -	}
> -
>  	tb_dbg(path->tb, "discovering %s path starting from %llx:%u\n",
>  	       path->name, tb_route(src->sw), src->port);
> 
> @@ -245,10 +240,6 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
>  	size_t num_hops;
>  	int i, ret;
> 
> -	path = kzalloc_obj(*path);
> -	if (!path)
> -		return NULL;
> -
>  	first_port = last_port = NULL;
>  	i = 0;
>  	tb_for_each_port_on_path(src, dst, in_port) {
> @@ -259,20 +250,17 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
>  	}
> 
>  	/* Check that src and dst are reachable */
> -	if (first_port != src || last_port != dst) {
> -		kfree(path);
> +	if (first_port != src || last_port != dst)
>  		return NULL;
> -	}
> 
>  	/* Each hop takes two ports */
>  	num_hops = i / 2;
> 
> -	path->hops = kzalloc_objs(*path->hops, num_hops);
> -	if (!path->hops) {
> -		kfree(path);
> +	path = kzalloc_flex(*path, hops, num_hops);
> +	if (!path)
>  		return NULL;
> -	}
> 
> +	path->path_length = num_hops;
>  	path->alloc_hopid = true;
> 
>  	in_hopid = src_hopid;
> @@ -339,7 +327,6 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
>  	}
> 
>  	path->tb = tb;
> -	path->path_length = num_hops;
>  	path->name = name;
> 
>  	return path;
> @@ -372,7 +359,6 @@ void tb_path_free(struct tb_path *path)
>  		}
>  	}
> 
> -	kfree(path->hops);
>  	kfree(path);
>  }
> 
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index e96474f17067..217c3114bec8 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -419,9 +419,9 @@ enum tb_path_port {
>   * @activated: Is the path active
>   * @clear_fc: Clear all flow control from the path config space entries
>   *	      when deactivating this path
> - * @hops: Path hops
>   * @path_length: How many hops the path uses
>   * @alloc_hopid: Does this path consume port HopID
> + * @hops: Path hops
>   *
>   * A path consists of a number of hops (see &struct tb_path_hop). To
>   * establish a PCIe tunnel two paths have to be created between the two
> @@ -440,9 +440,10 @@ struct tb_path {
>  	bool drop_packages;
>  	bool activated;
>  	bool clear_fc;
> -	struct tb_path_hop *hops;
>  	int path_length;
>  	bool alloc_hopid;
> +
> +	struct tb_path_hop hops[] __counted_by(path_length);
>  };
> 
>  /* HopIDs 0-7 are reserved by the Thunderbolt protocol */
> --
> 2.53.0
> 

-- 
Kees Cook
