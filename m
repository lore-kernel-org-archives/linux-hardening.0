Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F861D523
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 18:20:22 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6A2103
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 11:20:19 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c0d6fef60cso4556152a34.1
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695666019; x=1696270819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NO8m8eKRK6gw6Fe8TwUzngktRHamqnnDsDwwzDNH28M=;
        b=O/nD1cQaazGdhOue2jahkm1+yeWeoKqu1M4ITJ0EcOBorhKIpyziT1/lSG+8Npva//
         X9uMhsvJvYJxAfqbGmp6fdFoOv1VSXr8/XoHF5Bf5yBTkM07ZYceMSWkswbfovSD0sLL
         GIsX5bkCmA1rQ80+S3H5OE9sqUqPIYZqgWJzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695666019; x=1696270819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO8m8eKRK6gw6Fe8TwUzngktRHamqnnDsDwwzDNH28M=;
        b=fsTqn4if7TqCMeBqydB+XXqjDAPG7rlxKOESbsu0RYoGazLqvCR5gs3kLPwPWvSPug
         7ypm1bUuM/TTITyNfMcBwbyD6SBNWv+T23pUTWHMHAxt8n6tiILm52o9NhW27l6BSmqE
         AvfPjPONUrc2gpDxF437gpAGHar11aTcC4r9hLObba0GirhoyTDVct2ix5djf72Qm8m7
         yrshTTZDbZF1WWpxKlbJ+FwTaC1nSxU80D/PlBuFPEtiqSl37HXgPWTp5SvnWiAEoHJC
         L4jA43HAe6o0YqR/WDsbRQNBnwNurFNtEwFqeJhdOiaUxwgjGsjDcLjISxpHN3FQTkqs
         Juvg==
X-Gm-Message-State: AOJu0Yw5CyjlLTWHx7CZ73qJzqqRSQDsn/tTfTK0WCgXCeRAM4WmZ7jJ
	bAT3FlRh1bRLWohU88ytBA1LiA==
X-Google-Smtp-Source: AGHT+IHKSOY+zwApZkbmmnPtFl0loyWLQ/uN8QUCjcTuZ0xU2ovE+l4Elr00aAvn1WMqw7C2F4wggA==
X-Received: by 2002:a05:6830:115a:b0:6bc:b8d9:476e with SMTP id x26-20020a056830115a00b006bcb8d9476emr9039803otq.16.1695666019073;
        Mon, 25 Sep 2023 11:20:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k7-20020aa790c7000000b006875df4773fsm8310724pfk.163.2023.09.25.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:20:18 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:20:18 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm log userspace: replace deprecated strncpy with strscpy
Message-ID: <202309251119.69C15DC@keescook>
References: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 07:06:03AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `lc` is already zero-allocated:
> |       lc = kzalloc(sizeof(*lc), GFP_KERNEL);
> ... as such, any future NUL-padding is superfluous.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Let's also go with the more idiomatic `dest, src, sizeof(dest)` pattern
> for destination buffers that the compiler can calculate the size for.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good to me. Thanks for the sizeof() replacement. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Note: build-tested only.
> ---
>  drivers/md/dm-log-userspace-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-log-userspace-base.c b/drivers/md/dm-log-userspace-base.c
> index 5aace6ee6d47..7e4f27e86150 100644
> --- a/drivers/md/dm-log-userspace-base.c
> +++ b/drivers/md/dm-log-userspace-base.c
> @@ -224,7 +224,7 @@ static int userspace_ctr(struct dm_dirty_log *log, struct dm_target *ti,
>  
>  	lc->usr_argc = argc;
>  
> -	strncpy(lc->uuid, argv[0], DM_UUID_LEN);
> +	strscpy(lc->uuid, argv[0], sizeof(lc->uuid));
>  	argc--;
>  	argv++;
>  	spin_lock_init(&lc->flush_lock);
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230925-strncpy-drivers-md-dm-log-userspace-base-c-857579d9834f
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
