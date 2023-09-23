Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523BCA6C;
	Sat, 23 Sep 2023 09:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36134C433C8;
	Sat, 23 Sep 2023 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695459636;
	bh=DPfUyGQ+6dasfkt1FqaaCPH41eNMxz10SUv3MLrlYVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6fk7HK2ymgxdtYzNoQl3+kJbplm/i0YMV2jLQAf6N09dSy1rwcrEhuqEr5DgjJUr
	 5sO9yfGmRCDHT8LvyCqZNZCoUzYeljDz2xvPICUBX6VF9Mp8KoEiKyasE4mGcRAY+2
	 0k5Jo9TFSvu6rU4VpsqC8+yGmcrkHPOu559FrUz5AfOA1EiG+acjGScC83M1PCzH4w
	 VsXUVHuN6g/siIUWDaFlnwi/6abym6GyXFrDhIxclPrdbCOrnctQOYgHJfCBJ1LNoO
	 gH9mXlnIrwfPAyBMm4wpqhu2w81P32P0yZ0zWUBRPcfGxkybXLwmNk5eKlrQHAEdjX
	 6qdId6HZC/DwA==
Date: Sat, 23 Sep 2023 11:01:39 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] module: Annotate struct module_notes_attrs with
 __counted_by
Message-ID: <ZQ8Z80fUaQO/oPWt@work>
References: <20230922175253.work.237-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175253.work.237-kees@kernel.org>

On Fri, Sep 22, 2023 at 10:52:53AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct module_notes_attrs.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  kernel/module/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
> index c921bf044050..d964167c6658 100644
> --- a/kernel/module/sysfs.c
> +++ b/kernel/module/sysfs.c
> @@ -143,7 +143,7 @@ static void remove_sect_attrs(struct module *mod)
>  struct module_notes_attrs {
>  	struct kobject *dir;
>  	unsigned int notes;
> -	struct bin_attribute attrs[];
> +	struct bin_attribute attrs[] __counted_by(notes);
>  };
>  
>  static ssize_t module_notes_read(struct file *filp, struct kobject *kobj,
> -- 
> 2.34.1
> 
> 
