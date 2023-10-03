Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246C3FB09
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 23:39:23 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C7D90
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 16:39:22 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57bbb38d5d4so825641eaf.2
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696376361; x=1696981161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHe8JYym2Ds2OFZFVeg/AdE0yJx5jpX05ec3eVSRCvE=;
        b=hSdcoybKOokerspqVkF9HEsQsQqnjop+uLPweb0CZRArvxr4PBAnP0+ZYOloMKJpDA
         iIR7Kw0RqKt60vstZJd2jTvfH7J6bXnreSJOo+hvJnHX7p5mJvRWpkesMZK7XbtxhPXM
         l/eSlCZaB4T8aZpzhzypbRuTNcfhDeRD92h1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376361; x=1696981161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHe8JYym2Ds2OFZFVeg/AdE0yJx5jpX05ec3eVSRCvE=;
        b=DCRigIdDXvtYV4d0kgBK806O0kuouY2FOxg1CmSeANXEUVkA2g7fsCZK6jwDWO8Axu
         rzdUKDet+2GtSt5Ad0wsIykwUzh1BS4PrHI+vRSwBJ6fFuaRrm9Zm7XfcQoFS29NpqsD
         iJA8KsKAYuNNJO8yY8stWoBEEUt5ATaBQHQIJiG9Bm914Jab5/VSJij9scX8UdUnRtQJ
         uh1uxmMcObCDVIgRqf6EaT4uPyno4SclbkSD9D2n7NmEu1lZlBlYFnDT0zQIoD91E5u3
         mlkAF+7OiPvt9GYEbg0inOxodYq7FngsWy7pxSydXjyBd6j9NSHU33yKz2Gw1RUJXEPn
         i8+Q==
X-Gm-Message-State: AOJu0Ywepj3dfJfwaBG61V021I06oD+xpcCnGJ6Tremk+hRSBZ7fM6Oy
	ZvP6sKOWxzJ35CJGmODOPbwToQ==
X-Google-Smtp-Source: AGHT+IH9yQzBUXtP3fdaCapHuvlVlpBE0YsTKz0XBHyXXwlEidsXtlrQMpU6wnuaa3wSyWjUDqs5Dw==
X-Received: by 2002:a05:6358:430c:b0:133:b42:69ca with SMTP id r12-20020a056358430c00b001330b4269camr763881rwc.18.1696376361471;
        Tue, 03 Oct 2023 16:39:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a656a01000000b0056c5454105csm1694225pgu.93.2023.10.03.16.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:39:20 -0700 (PDT)
Date: Tue, 3 Oct 2023 16:39:18 -0700
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] kernel.h: Move lib/cmdline.c prototypes to
 string.h
Message-ID: <202310031638.D39E80C32B@keescook>
References: <20231003130142.2936503-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003130142.2936503-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 04:01:42PM +0300, Andy Shevchenko wrote:
> The lib/cmdline.c is basically a set of some small string parsers
> which are wide used in the kernel. Their prototypes belong to the
> string.h rather then kernel.h.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I think these should live in string_helpers.h not string.h (which is, in
theory, supposed to be used for the standard C string library functions,
though that's not 100% currently)...

-Kees

> ---
>  include/linux/kernel.h | 6 ------
>  include/linux/string.h | 8 ++++++++
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index c07f9c779d45..3e6c5ac08f8b 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -195,12 +195,6 @@ static inline void might_fault(void) { }
>  
>  void do_exit(long error_code) __noreturn;
>  
> -extern int get_option(char **str, int *pint);
> -extern char *get_options(const char *str, int nints, int *ints);
> -extern unsigned long long memparse(const char *ptr, char **retptr);
> -extern bool parse_option_str(const char *str, const char *option);
> -extern char *next_arg(char *args, char **param, char **val);
> -
>  extern int core_kernel_text(unsigned long addr);
>  extern int __kernel_text_address(unsigned long addr);
>  extern int kernel_text_address(unsigned long addr);
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 3c920b6d609b..0995f2a737ef 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -181,9 +181,17 @@ extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
>  extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
>  extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
>  
> +/* lib/argv_split.c */
>  extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
>  extern void argv_free(char **argv);
>  
> +/* lib/cmdline.c */
> +extern int get_option(char **str, int *pint);
> +extern char *get_options(const char *str, int nints, int *ints);
> +extern unsigned long long memparse(const char *ptr, char **retptr);
> +extern bool parse_option_str(const char *str, const char *option);
> +extern char *next_arg(char *args, char **param, char **val);
> +
>  extern bool sysfs_streq(const char *s1, const char *s2);
>  int match_string(const char * const *array, size_t n, const char *string);
>  int __sysfs_match_string(const char * const *array, size_t n, const char *s);
> -- 
> 2.40.0.1.gaa8946217a0b
> 

-- 
Kees Cook
