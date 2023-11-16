Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R3AEqaSZ"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD9198
	for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 06:30:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc921a4632so7938785ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 06:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700145001; x=1700749801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5CFIZMwZsIi1w6Tq3EafFzryCHHlKPpfY4zDkytZ7U=;
        b=R3AEqaSZVMIMjjddqI4j6NlcKknYaIrFrVGEqEcMQwcBU8DgIbnVyqQSrDcYbEYncJ
         sVUsdCqAN+/0SPB4QheAyNhquxo3VQGzAuUZkwGZ/zfVLk2cw84wlxdEyI9NHgB4Twep
         7dlv/1ASPG6x9tuWPca9T9e3A80ta4Sa08XTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700145001; x=1700749801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5CFIZMwZsIi1w6Tq3EafFzryCHHlKPpfY4zDkytZ7U=;
        b=o2cOwH6PcJr1KN6ORtyIpjPxwXpaJvfPcia7aQcOQhdksSxg/bRCKrzWWsEAIm1+hw
         VsHte+F7UT6fUdbG00Uz8Y4yS8bMLCVYgZwXtA36P8ggZWW8OjRKjgr0nYIkXULrQDZ6
         dghnnWNKS0ewZTIY0nhpXrGxYcJ1/wsXOWvgBaGwMIhj2JytOzZlhJd5SN+IjkLcecs2
         Xvcg/NkBv/R7yTpqRWB4xx/0FT64JpjRZzdc/33CzEYLrelg0GH2s7J3BCUAZGAuEKyB
         VVbZi1J+acMODPrzEQ3hOdH+DadQvwu7q79WOWgdqrRSeDq3Vjh2/2owVE+yFUAoV0Dn
         mH/g==
X-Gm-Message-State: AOJu0YwxbqizLbz9r+hyAErdtORu2GokwiY7A+gxqnbj2cMppOz2Pawe
	OS2XFM3cBn4JsdPkFmjERwU7fg==
X-Google-Smtp-Source: AGHT+IG6V5T+0h2/o/qC5yOwsFvHS/29nOKkQVfCxV97Mw1JK0y5UuHXg3KrPJuJB7pX6mYEVsJa4Q==
X-Received: by 2002:a17:903:1108:b0:1c3:c687:478c with SMTP id n8-20020a170903110800b001c3c687478cmr11031354plh.8.1700145001063;
        Thu, 16 Nov 2023 06:30:01 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001c46d04d001sm9301552plg.87.2023.11.16.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:30:00 -0800 (PST)
Date: Thu, 16 Nov 2023 06:29:59 -0800
From: Kees Cook <keescook@chromium.org>
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: al@alarsen.net, gustavoars@kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Message-ID: <202311160612.C38BF44@keescook>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112095353.579855-1-debug.penguin32@gmail.com>

On Sun, Nov 12, 2023 at 07:53:53PM +1000, Ronald Monthero wrote:
> qnx4 dir name length can vary to be of maximum size
> QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> 'link info' entry is stored and the status byte is set.
> So to avoid buffer overflow check di_fname length
> fetched from (struct qnx4_inode_entry *)
> before use in strlen to avoid buffer overflow.
> 
> panic context
> [ 4849.636861] detected buffer overflow in strlen
> [ 4849.636897] ------------[ cut here ]------------
> [ 4849.636902] kernel BUG at lib/string.c:1165!
> [ 4849.636917] invalid opcode: 0000 [#2] SMP PTI
> ..
> [ 4849.637047] Call Trace:
> [ 4849.637053]  <TASK>
> [ 4849.637059]  ? show_trace_log_lvl+0x1d6/0x2ea
> [ 4849.637075]  ? show_trace_log_lvl+0x1d6/0x2ea
> [ 4849.637095]  ? qnx4_find_entry.cold+0xc/0x18 [qnx4]
> [ 4849.637111]  ? show_regs.part.0+0x23/0x29
> [ 4849.637123]  ? __die_body.cold+0x8/0xd
> [ 4849.637135]  ? __die+0x2b/0x37
> [ 4849.637147]  ? die+0x30/0x60
> [ 4849.637161]  ? do_trap+0xbe/0x100
> [ 4849.637171]  ? do_error_trap+0x6f/0xb0
> [ 4849.637180]  ? fortify_panic+0x13/0x15
> [ 4849.637192]  ? exc_invalid_op+0x53/0x70
> [ 4849.637203]  ? fortify_panic+0x13/0x15
> [ 4849.637215]  ? asm_exc_invalid_op+0x1b/0x20
> [ 4849.637228]  ? fortify_panic+0x13/0x15
> [ 4849.637240]  ? fortify_panic+0x13/0x15
> [ 4849.637251]  qnx4_find_entry.cold+0xc/0x18 [qnx4]
> [ 4849.637264]  qnx4_lookup+0x3c/0xa0 [qnx4]
> [ 4849.637275]  __lookup_slow+0x85/0x150
> [ 4849.637291]  walk_component+0x145/0x1c0
> [ 4849.637304]  ? path_init+0x2c0/0x3f0
> [ 4849.637316]  path_lookupat+0x6e/0x1c0
> [ 4849.637330]  filename_lookup+0xcf/0x1d0
> [ 4849.637341]  ? __check_object_size+0x1d/0x30
> [ 4849.637354]  ? strncpy_from_user+0x44/0x150
> [ 4849.637365]  ? getname_flags.part.0+0x4c/0x1b0
> [ 4849.637375]  user_path_at_empty+0x3f/0x60
> [ 4849.637383]  vfs_statx+0x7a/0x130
> [ 4849.637393]  do_statx+0x45/0x80
> ..
> 
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  fs/qnx4/namei.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> index 8d72221735d7..825b891a52b3 100644
> --- a/fs/qnx4/namei.c
> +++ b/fs/qnx4/namei.c
> @@ -40,6 +40,13 @@ static int qnx4_match(int len, const char *name,
>  	} else {
>  		namelen = QNX4_SHORT_NAME_MAX;
>  	}
> +
> +	/** qnx4 dir name length can vary, check the di_fname
> +	 * fetched from (struct qnx4_inode_entry *) before use in
> +	 * strlen to avoid panic due to buffer overflow"
> +	 */

Style nit: this comment should start with just "/*" alone, like:

	/*
	 * qnx4 dir name ...

> +	if (strnlen(de->di_fname, namelen) >= sizeof(de->di_fname))
> +		return -ENAMETOOLONG;
>  	thislen = strlen( de->di_fname );

de->di_fname is:

struct qnx4_inode_entry {
        char            di_fname[QNX4_SHORT_NAME_MAX];
	...

#define QNX4_SHORT_NAME_MAX     16
#define QNX4_NAME_MAX           48

It's always going to have a max of QNX4_SHORT_NAME_MAX. Is any of this
code correct if namelen ends up being QNX4_NAME_MAX? It'll be reading
past the end of di_fname.

Is bh->b_data actually struct qnx4_inode_entry ?

-Kees

>  	if ( thislen > namelen )
>  		thislen = namelen;
> -- 
> 2.34.1
> 

-- 
Kees Cook
