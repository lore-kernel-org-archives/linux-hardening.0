Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4A8477
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 07:09:55 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC097B8;
	Mon, 25 Sep 2023 00:09:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1725E1F38D;
	Mon, 25 Sep 2023 07:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1695625792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0eOHy9J8tI0vJNwEUSpg51HLaOtlpzHMu3rel1MtGE=;
	b=dfrA12Qk77EK4VOjtFBeRlPf/2/rO0dIzJRbTm53kCKiKkjrhOAXyYwngWRjkdlWCKBy8L
	4AlVHiKsDtPu7BeIozfsj7njYHSEkD3ibMDK3h4t71wMs5A28f/+Jysbs7EEhdTZ0h6DGy
	Kea5T6Zci15TAOzOFfZOntd5PKGozr0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E57C61358F;
	Mon, 25 Sep 2023 07:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Hyz/ND8yEWWbMQAAMHmgww
	(envelope-from <mhocko@suse.com>); Mon, 25 Sep 2023 07:09:51 +0000
Date: Mon, 25 Sep 2023 09:09:51 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <ZREyPxSXgjmikITj@dhcp22.suse.cz>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri 22-09-23 10:53:28, Kees Cook wrote:
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

Acked-by: Michal Hocko <mhocko@suse.com>

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

-- 
Michal Hocko
SUSE Labs
