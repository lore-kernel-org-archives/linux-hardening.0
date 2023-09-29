Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D736669B
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 21:50:50 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEAAB7
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 14:50:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c724577e1fso46134525ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696024248; x=1696629048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nG8l3KmiLJUoQAJEoFfRXqVxZP9ikMMyfFYzlsqPkOg=;
        b=it+Yh6OVEOmZWjq5k6VvGtayvLGekUQU2USYgjkXiygYlODihzgWrPUOnjYXvFXpgo
         RTzgAHQYffiaCJyruMjltP3BEXYjqbRY/3NrlNbkju5iJANheEEUVDa/G4mLVOyATMK8
         Dm9OH0dGQhK3I5O/YWblBFpIay8Rkf/i0IoZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696024248; x=1696629048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG8l3KmiLJUoQAJEoFfRXqVxZP9ikMMyfFYzlsqPkOg=;
        b=wqIKhKTLl4lWO651LQP2BW8TfPtKLv1zeQnPAAdbj6BAm7RRwEiLm1+5W9t6ZVDKG2
         Ew22WHQVHphSKt3IlmlTnD5RT+H4PThIehPuXfZG89iQVYqrx/LoErRvgXv2a88sUwMb
         RynjrvO6CDppq1N1tRyi+kfbu+ysS+mwQKVPgNuhzJg2+w2KKEJETwcRYfILLSte2pxZ
         XA8NdRQb5Q4Fp5D8J0bpCh9ah/LVB58oGxqp8jsbb3JZXCRSM6A593iyMWfKPDsy4Fx0
         hTgs5zp2gDbOp6Ds8mb13VZ9yMrDhUTmKt8afK53WBXe2V7nuWZTZTns3PSTMqpzqcEf
         FEfA==
X-Gm-Message-State: AOJu0YwSR051z3WzgzRkiuLtaLL9BKT7UnGbQORfcdVo+4VZ4MtEXIZF
	a1zh7nEDnjX6d/kBzxfxqJFlTA==
X-Google-Smtp-Source: AGHT+IEep4U5eUTvZ2vvdTI5sayk+fxXL86fIIJEm0vaQsIdIR5u4n4IJv4dpYP1T65IKznGbt0Rhw==
X-Received: by 2002:a17:902:9b8e:b0:1c6:845:27c5 with SMTP id y14-20020a1709029b8e00b001c6084527c5mr5158004plp.61.1696024247858;
        Fri, 29 Sep 2023 14:50:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001c737387810sm3659271plb.31.2023.09.29.14.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:50:47 -0700 (PDT)
Date: Fri, 29 Sep 2023 14:50:46 -0700
From: Kees Cook <keescook@chromium.org>
To: Dave Hansen <dave.hansen@intel.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Message-ID: <202309291449.FC5C4AE27@keescook>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
 <51164807-4860-b1cc-e3de-4230795808df@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51164807-4860-b1cc-e3de-4230795808df@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 02:27:39PM -0700, Dave Hansen wrote:
> On 9/29/23 11:33, Kees Cook wrote:
> > On Mon, 11 Sep 2023 18:27:25 +0000, Justin Stitt wrote:
> >> `strncpy` is deprecated and we should prefer more robust string apis.
> >>
> >> In this case, `message.str` is not expected to be NUL-terminated as it
> >> is simply a buffer of characters residing in a union which allows for
> >> named fields representing 8 bytes each. There is only one caller of
> >> `tdx_panic()` and they use a 59-length string for `msg`:
> >> |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> >>
> >> [...]
> > This appears to be trivially correct, so I can take it via my tree.
> 
> Sorry about that, I was being clear as mud as to what I wanted to see
> here.  I was hoping for another more clear changelog at least.
> 
> The changelog makes it sound like there's a problem with not
> NULL-terminating 'message.str' when there isn't.  That makes it hard to
> tell what the patch's goals are.

Ah! Thanks, sorry. I thought it was resolved.

> As far as I can tell, the code is 100% correct with either the existing
> strncpy() or strtomem_pad(), even with a >64-byte string.  This _is_
> unusual because the hypervisor is nice and doesn't require NULL termination.
> 
> Would there be anything wrong with a changelog like this?
> 
> 	strncpy() works perfectly here in all cases.  However, it _is_
> 	deprecated and unsafe in other cases and there is an effort to
> 	purge it from the code base to avoid problems elsewhere.
> 
> 	Replace strncpy() with an equivalent (in this case)
> 	strtomem_pad() which is not deprecated.
> 
> In other words, this fixes no bug.  But we should do it anyway.

Sounds good; thanks! Justin, can you respin with these changes?

-Kees

-- 
Kees Cook
