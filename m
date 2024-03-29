Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CED38384
	for <linux-hardening@vger.kernel.org>; Fri, 29 Mar 2024 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684469; cv=none; b=pfeHb1UxyrdoKa+HJ2LK2wie0ZQR2irI22OHOrwGup/eSYch6AhYexnVfhg9KxoplFSeouPCTJRGi3rssgWqBktuH6voE+MIjqq93tpiOuktf0dTME2zg3N38foqaaEkt0mJa/DGz92EP4iBL9a2ATm/1w/fQWcTntrzl2TwCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684469; c=relaxed/simple;
	bh=uuhBNiEPA5BGYC6HFspVOkMf/5FcVuYvwXDlLIMLIjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXKKuzkxXHebPNz+aAphPbmnupSs9cbBXSi3tBaGeUiQSE5WkvTSEemWdBuT4OPFiITRTwyTKRV3UxjKe91NuEo0VdzgxwElXyL1/xK5iiPR1zTZ3aexyxxu/KaDeBVJEk8bvDyNWGBeAqaeZEgkbQwcc2cCfQlwtvF9PFr8mrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hdhNm1UL; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hdhNm1UL"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so1000847b6e.2
        for <linux-hardening@vger.kernel.org>; Thu, 28 Mar 2024 20:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711684466; x=1712289266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3C41foMJwldN7lF7HFYV1LcCmv7iReonWo3nmflCe4k=;
        b=hdhNm1ULJNFZa3/awq+NvK7GM55brRVbg2WH+ovGpJM7zMK61ffZHD3kxZZ/pnATVe
         yYgnpP/HlBNlml26ryo8GjPuRP8/2qh5z/UmXGS7L6fZmKZ/Qb+Ymd73OBrinN6d+eZ1
         QoLf14TksO1NtgWSkrPnWrrU1Xcfnf20AP67Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684466; x=1712289266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C41foMJwldN7lF7HFYV1LcCmv7iReonWo3nmflCe4k=;
        b=vGoEfqjg0VvIz80RSuKipn13eUOt6dECRpw1z56uR3spHqGNkI/tZH2ABk7/7Ae1iW
         imOewCHAmf3FPyjIr//TRHC+pHLToNHAKKvdHIZgh+2sYr7jq1Ph3xoP32ztjuRwNbAj
         M0iXEqS5GrxJQkRBgDckmEzAP8Fm9bLdiaxOdLoDNdPHqKwBe9VPyp5l14qfqYdpuau8
         u8tA7q2bFum+BALTCJI0KwKlw+ZvdX8fSFAyUOeVZQkgO1FtodCYCA56znkFwTrjOGnK
         yaIf8mbqjD1FhsI0OogPPPvYCmDNktjPabKgd+XAw94BvAxE26r8mF6t1MGfEBlutnkI
         TRng==
X-Forwarded-Encrypted: i=1; AJvYcCVZrycXOU3irG1CeZ0Ld3wGiNmDg3pqQBhOuDyZ26VTevRDm4EphJYAmyWgXzFtZ/v/K1Brum6PhMh0Vg2nKO91mahStLYqHQ0GYc91Lre4
X-Gm-Message-State: AOJu0YznkEzpnvKZ9l+Uh0UiYfrt14OXNOF2IU3zNEROySdXvcfRoJxf
	r5PsrF01a9CcplezZc1AbdpDNpD9WLz3Qgx4eMxVZQZFSxKhS8dl7aIcuJrAOQ==
X-Google-Smtp-Source: AGHT+IFV3d5fwIBqU/c65R9zyRZ6WnFPmpDPlKpZ+gaG3pHS3NaZQMCL4vMAzkEhEWb9x4Q42+Papg==
X-Received: by 2002:a05:6808:1821:b0:3c3:de8e:5411 with SMTP id bh33-20020a056808182100b003c3de8e5411mr1349524oib.38.1711684466464;
        Thu, 28 Mar 2024 20:54:26 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z9-20020a63e549000000b005cd8044c6fesm2075211pgj.23.2024.03.28.20.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:54:25 -0700 (PDT)
Date: Thu, 28 Mar 2024 20:54:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] orangefs: cleanup uses of strncpy
Message-ID: <202403282053.78C952AC@keescook>
References: <20240322-strncpy-fs-orangefs-dcache-c-v1-1-15d12debbf38@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-strncpy-fs-orangefs-dcache-c-v1-1-15d12debbf38@google.com>

On Fri, Mar 22, 2024 at 09:41:18PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> There is some care taken to ensure these destination buffers are
> NUL-terminated by bounding the strncpy()'s by ORANGEFS_NAME_MAX - 1 or
> ORANGEFS_MAX_SERVER_ADDR_LEN - 1. Instead, we can use the new 2-argument
> version of strscpy() to guarantee NUL-termination on the destination
> buffers while simplifying the code.
> 
> Based on usage with printf-likes, we can see these buffers are expected
> to be NUL-terminated:
> |	gossip_debug(GOSSIP_NAME_DEBUG,
> |			"%s: doing lookup on %s under %pU,%d\n",
> |			__func__,
> |			new_op->upcall.req.lookup.d_name,
> |			&new_op->upcall.req.lookup.parent_refn.khandle,
> |			new_op->upcall.req.lookup.parent_refn.fs_id);
> ...
> |	gossip_debug(GOSSIP_SUPER_DEBUG,
> |			"Attempting ORANGEFS Remount via host %s\n",
> |			new_op->upcall.req.fs_mount.orangefs_config_server);
> 
> NUL-padding isn't required for any of these destination buffers as
> they've all been zero-allocated with op_alloc() or kzalloc().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/orangefs/dcache.c |  4 +---
>  fs/orangefs/namei.c  | 26 ++++++++------------------
>  fs/orangefs/super.c  | 17 ++++++-----------
>  3 files changed, 15 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
> index 8bbe9486e3a6..395a00ed8ac7 100644
> --- a/fs/orangefs/dcache.c
> +++ b/fs/orangefs/dcache.c
> @@ -33,9 +33,7 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
>  
>  	new_op->upcall.req.lookup.sym_follow = ORANGEFS_LOOKUP_LINK_NO_FOLLOW;
>  	new_op->upcall.req.lookup.parent_refn = parent->refn;
> -	strncpy(new_op->upcall.req.lookup.d_name,
> -		dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name);
>  
>  	gossip_debug(GOSSIP_DCACHE_DEBUG,
>  		     "%s:%s:%d interrupt flag [%d]\n",
> diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
> index c9dfd5c6a097..200558ec72f0 100644
> --- a/fs/orangefs/namei.c
> +++ b/fs/orangefs/namei.c
> @@ -41,8 +41,7 @@ static int orangefs_create(struct mnt_idmap *idmap,
>  	fill_default_sys_attrs(new_op->upcall.req.create.attributes,
>  			       ORANGEFS_TYPE_METAFILE, mode);
>  
> -	strncpy(new_op->upcall.req.create.d_name,
> -		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.create.d_name, dentry->d_name.name);
>  
>  	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
>  
> @@ -137,8 +136,7 @@ static struct dentry *orangefs_lookup(struct inode *dir, struct dentry *dentry,
>  		     &parent->refn.khandle);
>  	new_op->upcall.req.lookup.parent_refn = parent->refn;
>  
> -	strncpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name);
>  
>  	gossip_debug(GOSSIP_NAME_DEBUG,
>  		     "%s: doing lookup on %s under %pU,%d\n",
> @@ -192,8 +190,7 @@ static int orangefs_unlink(struct inode *dir, struct dentry *dentry)
>  		return -ENOMEM;
>  
>  	new_op->upcall.req.remove.parent_refn = parent->refn;
> -	strncpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.remove.d_name, dentry->d_name.name);
>  
>  	ret = service_operation(new_op, "orangefs_unlink",
>  				get_interruptible_flag(inode));
> @@ -247,10 +244,8 @@ static int orangefs_symlink(struct mnt_idmap *idmap,
>  			       ORANGEFS_TYPE_SYMLINK,
>  			       mode);
>  
> -	strncpy(new_op->upcall.req.sym.entry_name,
> -		dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> -	strncpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.sym.entry_name, dentry->d_name.name);
> +	strscpy(new_op->upcall.req.sym.target, symname);
>  
>  	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
>  
> @@ -324,8 +319,7 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	fill_default_sys_attrs(new_op->upcall.req.mkdir.attributes,
>  			      ORANGEFS_TYPE_DIRECTORY, mode);
>  
> -	strncpy(new_op->upcall.req.mkdir.d_name,
> -		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.mkdir.d_name, dentry->d_name.name);
>  
>  	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
>  
> @@ -405,12 +399,8 @@ static int orangefs_rename(struct mnt_idmap *idmap,
>  	new_op->upcall.req.rename.old_parent_refn = ORANGEFS_I(old_dir)->refn;
>  	new_op->upcall.req.rename.new_parent_refn = ORANGEFS_I(new_dir)->refn;
>  
> -	strncpy(new_op->upcall.req.rename.d_old_name,
> -		old_dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> -	strncpy(new_op->upcall.req.rename.d_new_name,
> -		new_dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.rename.d_old_name, old_dentry->d_name.name);
> +	strscpy(new_op->upcall.req.rename.d_new_name, new_dentry->d_name.name);
>  
>  	ret = service_operation(new_op,
>  				"orangefs_rename",
> diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
> index 34849b4a3243..fb4d09c2f531 100644
> --- a/fs/orangefs/super.c
> +++ b/fs/orangefs/super.c
> @@ -253,9 +253,8 @@ int orangefs_remount(struct orangefs_sb_info_s *orangefs_sb)
>  	new_op = op_alloc(ORANGEFS_VFS_OP_FS_MOUNT);
>  	if (!new_op)
>  		return -ENOMEM;
> -	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> -		orangefs_sb->devname,
> -		ORANGEFS_MAX_SERVER_ADDR_LEN);
> +	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> +		orangefs_sb->devname);

This one place doesn't use "ORANGEFS_MAX_SERVER_ADDR_LEN - 1", but this
appears to be an existing (likely unreachable) bug.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
>  	gossip_debug(GOSSIP_SUPER_DEBUG,
>  		     "Attempting ORANGEFS Remount via host %s\n",
> @@ -400,8 +399,7 @@ static int orangefs_unmount(int id, __s32 fs_id, const char *devname)
>  		return -ENOMEM;
>  	op->upcall.req.fs_umount.id = id;
>  	op->upcall.req.fs_umount.fs_id = fs_id;
> -	strncpy(op->upcall.req.fs_umount.orangefs_config_server,
> -	    devname, ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> +	strscpy(op->upcall.req.fs_umount.orangefs_config_server, devname);
>  	r = service_operation(op, "orangefs_fs_umount", 0);
>  	/* Not much to do about an error here. */
>  	if (r)
> @@ -494,9 +492,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
>  	if (!new_op)
>  		return ERR_PTR(-ENOMEM);
>  
> -	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> -		devname,
> -		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> +	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server, devname);
>  
>  	gossip_debug(GOSSIP_SUPER_DEBUG,
>  		     "Attempting ORANGEFS Mount via host %s\n",
> @@ -543,9 +539,8 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
>  	 * on successful mount, store the devname and data
>  	 * used
>  	 */
> -	strncpy(ORANGEFS_SB(sb)->devname,
> -		devname,
> -		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> +	strscpy(ORANGEFS_SB(sb)->devname, devname);
> +
>  
>  	/* mount_pending must be cleared */
>  	ORANGEFS_SB(sb)->mount_pending = 0;
> 
> ---
> base-commit: 241590e5a1d1b6219c8d3045c167f2fbcc076cbb
> change-id: 20240322-strncpy-fs-orangefs-dcache-c-9a0cf2d22dae
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
