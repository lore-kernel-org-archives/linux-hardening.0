Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5D19B
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 02:52:02 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86798124
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 19:52:00 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ae214a077cso1906111b6e.0
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695523920; x=1696128720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qoxOpoYwwbcXvP8AhdHBWCEQ7XvmIo4NgjxEavDKJS0=;
        b=R7+78uPj1vsN9ArLH0OMzIGPyTzfVp7iVwptGLxavDM/4VWGPINkimkMWDGhYsJLLA
         KPLMZ/osNzryQT/bOFE2YrFLhsv5W1qWrGIgc+K6wycrLBQMNxtGOYN15t0Ewsl6cHcD
         nCBea44ociJPStjlivuIrUJ/jNR6rTgPiY/E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695523920; x=1696128720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoxOpoYwwbcXvP8AhdHBWCEQ7XvmIo4NgjxEavDKJS0=;
        b=gAJiL+Jv8AQ13RjlHDhWbnaXVN6gDEhLE4DPWQTaq9ry6Ay2BebHbQv3gpyUwHtq07
         MC8sKIhw45DGi4fpkIYWeRVbpaWl/sl1SaUfqKfoQrvbcRINI+pNyeQyzKuMl91IAiUJ
         n5ZJJuaoWylryN2QLMbDLBglByqObm06MiUeZizRR9qVmaw3kGgcwaO2iE4Hvf/7/tHK
         KIzY/BZfRIcQot+HbWsR+WqX/vTiQAsTa7Lt35pHPNEXlCiBnmSGqsoNZ3PgTQukZtKG
         7UltbN7kCMcqStN9BuzVbvIpFVXwpHhuz8dOrzscFsHX+HNdhKGqTQ6AKIJQBId3Heq3
         EJKg==
X-Gm-Message-State: AOJu0YyhthPELUG9ujE7rJUVB2MHd6L+DBZtdKbvhU42sk1UT6tXgNS/
	gWLKkMMqq/AR94mldcVgx8Ra2A==
X-Google-Smtp-Source: AGHT+IHcUoAikiUF1QqzgTagOroRwcP1YpmHmYrwno+IIkRbBhz92pli07wtVSNBbwi76ORGeUjvtg==
X-Received: by 2002:aca:1c14:0:b0:3a7:aa1:f883 with SMTP id c20-20020aca1c14000000b003a70aa1f883mr3738720oic.29.1695523919867;
        Sat, 23 Sep 2023 19:51:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001bba669a7eesm6038250plb.52.2023.09.23.19.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:51:58 -0700 (PDT)
Date: Sat, 23 Sep 2023 19:51:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc_sysfs: refactor deprecated strncpy
Message-ID: <202309231950.698026E687@keescook>
References: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 07:47:29AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We've already calculated bounds, possible truncation with '\0' or '\n'
> and manually NUL-terminated. The situation is now just a literal byte
> copy from one buffer to another, let's treat it as such and use a less
> ambiguous interface in memcpy.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, I think this looks good now. If a v5 is needed, a tiny improvement
would be to update the Subject: to "...: replace strncpy with memcpy".

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
