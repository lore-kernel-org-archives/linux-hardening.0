Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3402CA6C;
	Sat, 23 Sep 2023 09:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A854C433C9;
	Sat, 23 Sep 2023 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695459723;
	bh=1wubkG7ScgzJloOTfB6qo/zH9IOKqKxVD813hWAMOMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVwSdE+tm0lpxlsWqXhaGtF2ducIVr9x3cxZz3wj1JpSqVnElQJ2JluT7yRQq72qC
	 In/LR+xCLTgdJ7GVOXWdq0pPVjp4DmxNLYW1wQ8rXMY+aBQfN8EHTTBo6pENBRU24u
	 IyT8bUspR70T26/FHiAbnuSW7wRsQoOE1/CfjUbuMhSmuH+xwLZWpzjX7NB37uIkuI
	 29zgjWACFqp9ruPRugwyqA882HiME30/Payb0oZ0dyImZg2xupSPlOA5UAhg6iot38
	 m/uoO6xmxETVcYUx9nEywcM4pX1yGrx7+XVj1kP9dIhweVDWLxmYmab/kS+E8y8Pts
	 6nsleciA65S8g==
Date: Sat, 23 Sep 2023 11:03:04 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
	Yu Zhao <yuzhao@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: Annotate struct mem_cgroup_threshold_ary with
 __counted_by
Message-ID: <ZQ8aSNgBiJI7Jr+T@work>
References: <20230922175327.work.985-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175327.work.985-kees@kernel.org>

On Fri, Sep 22, 2023 at 10:53:28AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mem_cgroup_threshold_ary.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 45d0c10e86cc..e0cfab58ab71 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -143,7 +143,7 @@ struct mem_cgroup_threshold_ary {
>  	/* Size of entries[] */
>  	unsigned int size;
>  	/* Array of thresholds */
> -	struct mem_cgroup_threshold entries[];
> +	struct mem_cgroup_threshold entries[] __counted_by(size);
>  };
>  
>  struct mem_cgroup_thresholds {
> -- 
> 2.34.1
> 
> 
