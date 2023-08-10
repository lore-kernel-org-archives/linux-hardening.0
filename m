Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AEDC001DE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 18:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjHJSqP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjHJSqN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 14:46:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201DA270A
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 11:46:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc5acc627dso9522765ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691693172; x=1692297972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aD4/1sZser2bYv6MWlh14IS1WZm+jBzIMYH/7BTHdPg=;
        b=DbRD0/P47O0+ZL9rjWH0sZdgC1npDJRwHmGoM4Ckm/w7RSZ2p1glpZZ7jDvJyLMqqi
         zv+1ysQGn+JBBj/a9syvEOrcZwixcRIFqs9FWXHXct8olVEPgLioEH5OAU2zzM+MEd5m
         3wGqRPnW3x1LvdwpmeFpbp5sm9KI8i2KTfX48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693172; x=1692297972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aD4/1sZser2bYv6MWlh14IS1WZm+jBzIMYH/7BTHdPg=;
        b=d4MyIa1hLdyvN00T2PhLBNq5UuY2ENx//BRjDeF8dLAUH/AxFz1mZc9ipzmPKIVHbd
         cNBwLAgivQRrlVzkIIxjAgBx287ZJsZaTVuVVu7N2sGoYUQu4YGpV+jFmOuXzcsORV2F
         g6P6HcxAM9RG/2i/oxfFodnZXj1wH44pxSoC6f47jqtNpPsjAs3LI8fH44+5X1fLDFL/
         rtQqu/QZY5+jAENsqvSmC12codJRjaVCv7xsoyN9H638dSTBWuTSdaJTmhRVIVRJqQ8k
         ro+EAIpDiBJLd8JcjzczNqS+1WWBgkCqhHUaiX9kMZhiAw7E9YvOoXQLVLtZSuPV+dcB
         INHg==
X-Gm-Message-State: AOJu0YzHK1TA9QEK1b0nHhsuLw2jyE+TrOn9ClhaDLOr3/IJM1gzEKui
        LLJ2N/qd6bz6JW6rh6D6Ui+Szw==
X-Google-Smtp-Source: AGHT+IFZv2IWBP2UQjY57EbZ1aEKhfpe99+b1ybWLM5PinM+M8Pll2NyW6GLul8RARS7ehj5SPlY9Q==
X-Received: by 2002:a17:902:d511:b0:1b3:fafd:11c5 with SMTP id b17-20020a170902d51100b001b3fafd11c5mr3596148plg.44.1691693172613;
        Thu, 10 Aug 2023 11:46:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b001bb6c5ff4edsm2116032plc.173.2023.08.10.11.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:46:12 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:46:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>
Subject: Re: [PATCH net-next v1 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <202308101131.D8DEE055@keescook>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
 <20230810103509.163225-2-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810103509.163225-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 10, 2023 at 06:35:03AM -0400, Przemek Kitszel wrote:
> Add DEFINE_FLEX() macro for on-stack allocations of structs with
> flexible array member.
> 
> Add also const_flex_size() macro, that reads size of structs
> allocated by DEFINE_FLEX().
> 
> Using underlying array for on-stack storage lets us to declare
> known-at-compile-time structures without kzalloc().
> 
> Actual usage for ice driver is in following patches of the series.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v1: change macro name; add macro for size read;
>     accept struct type instead of ptr to it; change alignment;
> ---
>  include/linux/overflow.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index f9b60313eaea..21a4410799eb 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -309,4 +309,31 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  #define struct_size_t(type, member, count)					\
>  	struct_size((type *)NULL, member, count)
>  
> +/**
> + * DEFINE_FLEX() - Define a zeroed, on-stack, instance of @type structure with
> + * a trailing flexible array member.
> + *
> + * @type: structure type name, including "struct" keyword.
> + * @name: Name for a variable to define.
> + * @member: Name of the array member.
> + * @count: Number of elements in the array; must be compile-time const.
> + */
> +#define DEFINE_FLEX(type, name, member, count)					\
> +	union {									\
> +		u8 bytes[struct_size_t(type, member, count)];			\
> +		type obj;							\
> +	} name##_u __aligned(_Alignof(type)) = {};				\
> +	type *name = (type *)&name##_u

We'll need another macro when __counted_by is needed, but yes, if all of
these structs use non-native endian counters, we can't require it in the
base macro. (i.e. not now -- this is fine as-is.)

> +
> +/**
> + * const_flex_size() - Get size of on-stack instance of structure with
> + * a trailing flexible array member.
> + *
> + * @name: Name of the variable, the one defined by DEFINE_FLEX() macro above.
> + *
> + * Get size of @name, which is equivalent to struct_size(name, array, count),
> + * but does not require (repeating) last two arguments.
> + */
> +#define const_flex_size(name)	__builtin_object_size(name, 1)

Naming is hard. ;) I don't like "const" here (it's not a storage
class). But more importantly, this calculation ("how big is this thing
actually?") gets used a lot in the fortify routines, so I'd prefer
exposing those macros (from fortify-string.h):


diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c88488715a39..4b788fa0c576 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -352,6 +352,18 @@ struct ftrace_likely_data {
 # define __realloc_size(x, ...)
 #endif
 
+/*
+ * When the size of an allocated object is needed, use the best available
+ * mechanism to find it. (For cases where sizeof() cannot be used.)
+ */
+#if __has_builtin(__builtin_dynamic_object_size)
+#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
+#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
+#else
+#define __struct_size(p)	__builtin_object_size(p, 0)
+#define __member_size(p)	__builtin_object_size(p, 1)
+#endif
+
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index da51a83b2829..1e7711185ec6 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -93,13 +93,9 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #if __has_builtin(__builtin_dynamic_object_size)
 #define POS			__pass_dynamic_object_size(1)
 #define POS0			__pass_dynamic_object_size(0)
-#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
-#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
 #else
 #define POS			__pass_object_size(1)
 #define POS0			__pass_object_size(0)
-#define __struct_size(p)	__builtin_object_size(p, 0)
-#define __member_size(p)	__builtin_object_size(p, 1)
 #endif
 
 #define __compiletime_lessthan(bounds, length)	(	\


And the way DEFINE_FLEX is built, __struct_size() and __member_size()
will give the same result (which is what I was concerned about for
FORTIFY_SOURCE's use of __member_size not "seeing" the flexible array
members).

In this case, I think using __struct_size() in place of const_flex_size()
in the patch series is the way to go.

-- 
Kees Cook
