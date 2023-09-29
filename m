Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90115AF2
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 17:09:20 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8121A7
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 10:09:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2774f6943b1so7987137a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696007358; x=1696612158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=deGBloOMDVyisXpRq7z1cbAOp1P4FMweZQk3k+cDqXE=;
        b=fn0V+0Vfk7EzGcx3tRZ5XSIaGVD5K1duXqU81L8WPSIucJ8UIaTcxUxebP70cHcuGy
         AiT//UqGko4CkjNIN/21f3wkp47zIwZSFpiM0Xn9a4p/N7ZMF7IBjD41hAeh0OZHiqTV
         3utWMHNw9FR6So3pHHM8XcaIM4/dfCS3RABT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696007358; x=1696612158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deGBloOMDVyisXpRq7z1cbAOp1P4FMweZQk3k+cDqXE=;
        b=Jzgpw92h5AYYPgevcitqEhPlZ3qXEffM5k75zXrC37yuh2KZCtmDvlEfFHnwGLFPBk
         psdXTSuZP39yi+MNHjeyzgPv3Ga8BwKRpwHQ0UdriZkMFfSYMFyP6MlIcs6T6oSuawgQ
         Ql/C7FoJJrX6ky6a4ZyL1uJXNZiT0vrxDSk19zNxjhg/ZCfx1ddHKTYpO3YYQmZ17v1Y
         xXrYan6JerwxeUZDlJezUlMa/EkmI19EqSfJZndxC4ifZAxDPey1eqikZFDkKwepxJi0
         zxO/IQfxxLk8hOUssT8KEuFEYhxd00wAARjFljfWuhsjZwsKJ6TyxwW4PC32+6m4wBFj
         WdXg==
X-Gm-Message-State: AOJu0YyftM5gITqN5En6GGBKO3bmX2f42wQCTwCsfg3/3VlymxT6rgvw
	eTrxHXoUU+L7C3wTxcgl6koktQ==
X-Google-Smtp-Source: AGHT+IHLVTOQ4nVYQ8HdmqbwBKA9K1DzJw40mT+QGwnZ2ewCFQ1ZJGmd3D5AE8sWdX/j80dyqzBFJQ==
X-Received: by 2002:a17:90a:9d82:b0:26d:2162:f596 with SMTP id k2-20020a17090a9d8200b0026d2162f596mr4608964pjp.6.1696007358393;
        Fri, 29 Sep 2023 10:09:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090a5d8900b00277560ecd5dsm1690993pji.46.2023.09.29.10.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:09:18 -0700 (PDT)
Date: Fri, 29 Sep 2023 10:09:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Sebastian Ott <sebott@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/6] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
Message-ID: <202309291007.A0640DD@keescook>
References: <20230929031716.it.155-kees@kernel.org>
 <7ddc633e-c724-ad8d-e7ca-62d6b012b9e9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ddc633e-c724-ad8d-e7ca-62d6b012b9e9@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 01:33:50PM +0200, Sebastian Ott wrote:
> Hello Kees,
> 
> On Thu, 28 Sep 2023, Kees Cook wrote:
> > This is the continuation of the work Eric started for handling
> > "p_memsz > p_filesz" in arbitrary segments (rather than just the last,
> > BSS, segment). I've added the suggested changes:
> > 
> > - drop unused "elf_bss" variable
> > - refactor load_elf_interp() to use elf_load()
> > - refactor load_elf_library() to use elf_load()
> > - report padzero() errors when PROT_WRITE is present
> > - drop vm_brk()
> 
> While I was debugging the initial issue I stumbled over the following
> - care to take it as part of this series?
> ----->8
> [PATCH] mm: vm_brk_flags don't bail out while holding lock
> 
> Calling vm_brk_flags() with flags set other than VM_EXEC
> will exit the function without releasing the mmap_write_lock.
> 
> Just do the sanity check before the lock is acquired. This
> doesn't fix an actual issue since no caller sets a flag other
> than VM_EXEC.

Oh, eek. Yeah, that seems like a good idea. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
